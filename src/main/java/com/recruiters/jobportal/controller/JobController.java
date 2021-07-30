package com.recruiters.jobportal.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.recruiters.jobportal.constants.ApplicationConstants;
import com.recruiters.jobportal.dao.JobDAO;
import com.recruiters.jobportal.model.JobDetail;
import com.recruiters.jobportal.model.UserDetail;
import com.recruiters.jobportal.util.Mailer;

/* Represents the details of job */
@Controller
@RequestMapping("/job")
public class JobController {
	
	@Autowired
	private JobDAO jobDao;
	
	@RequestMapping(value = {"/jobDetails"}, method = RequestMethod.GET)
	public ModelAndView jobDetails(HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView(ApplicationConstants.JOB_DETAILS_PAGE);
		List<JobDetail> jobDetailList = null;
		UserDetail userDetail = (UserDetail) session.getAttribute("loggedInUserDetails");
		if(request.isUserInRole("ROLE_ADMIN")){
			jobDetailList =  jobDao.fetchAllJob();
		} else {
			jobDetailList = jobDao.fetchJobByUserId(userDetail.getUserId());
		}
		mav.addObject("jobList", jobDetailList);
		mav.addObject(ApplicationConstants.TITLE, ApplicationConstants.JOB_DETAILS);
		return mav;
	}
	
	@RequestMapping(value = { "/viewJobDetails" }, method = RequestMethod.GET)
	public ModelAndView viewJobDetails(@RequestParam(name = "jobId",required = false) Integer jobId,
			@RequestParam(name = "pageType", required = false) String pageType) {
		ModelAndView mav = new ModelAndView(ApplicationConstants.JOB_POST_PAGE);
		JobDetail jobDetail = new JobDetail();
		if(null != jobId)
		jobDetail = jobDao.fetchJobById(jobId);
		mav.addObject("jobDetail", jobDetail);
		if(null != pageType) {
			mav.addObject("pageType", pageType);
			if(pageType.equals("view"))
				mav.addObject("pageName","View Job");
			if(pageType.equals("edit"))
				mav.addObject("pageName","Edit Job");
		}
		return mav;
	}
	
	@RequestMapping(value = { "/saveOrUpdateJob" }, consumes ={"multipart/form-data"})
	public ModelAndView saveOrUpdateJob(@ModelAttribute(name = "jobDetail") JobDetail jobDetail, HttpSession session) throws IOException {

		ModelAndView mav = new ModelAndView("redirect:/job/jobDetails");
		CommonsMultipartFile file = jobDetail.getJdFile();
		if (jobDetail.getJobId() == 0) { // Add New JOb
			UserDetail userDetail = (UserDetail) session.getAttribute("loggedInUserDetails");
			jobDetail.setUserDetail(userDetail);
			jobDetail.setJobStatus(ApplicationConstants.CREATED);
			jobDetail.setEmploymentType(Optional.ofNullable(String.join(",", jobDetail.getEmploymentTypeArray())).orElse(null));
			int jobId = jobDao.save(jobDetail);
			if (!file.isEmpty()) {
				String actualFileName = file.getOriginalFilename();
				String fileName = jobId + "_" + actualFileName;
				uploadFile(file, fileName);
				jobDetail.setJobId(jobId);
				jobDetail.setJdFileName(fileName);
				jobDao.update(jobDetail);
			}
		} else { // Update existing job
			if (!file.isEmpty()) {
				if (null != jobDetail.getJdFileName()) {
					deleteFile(jobDetail.getJdFileName());
				}
				String actualFileName = file.getOriginalFilename();
				String fileName = jobDetail.getJobId() + "_" + actualFileName;
				uploadFile(file, fileName);
				jobDetail.setJdFileName(fileName);
				jobDetail.setEmploymentType(Optional.ofNullable(String.join(",", jobDetail.getEmploymentTypeArray())).orElse(jobDetail.getEmploymentType()));
			}
			jobDao.update(jobDetail);
		}
		return mav;

	}
	
	@GetMapping(value = "/fetchComment")
	@ResponseBody
	public ResponseEntity<String> fetchComment(@RequestParam Integer jobId) {
		
		String comment = jobDao.fetchComment(jobId);
		return new ResponseEntity<String>(comment,HttpStatus.OK);
	}
	
	@PostMapping(value = "/saveComment")
	@ResponseBody
	public ResponseEntity<String> saveComment(@RequestParam String comment, @RequestParam Integer jobId) {
		
		JobDetail jobDetail = jobDao.fetchJobById(jobId);
		jobDetail.setComments(comment);
		jobDao.update(jobDetail);
		String message = "Dear User," + System.lineSeparator() + "You have a notification for you posted Job: " + jobDetail.getJobTitle();
//		Send Email to the user
		Mailer.send(ApplicationConstants.EMAIL_FROM_ADDRESS, ApplicationConstants.EMAIL_FROM_PASSWORD,
				jobDetail.getUserDetail().getEmailId(), ApplicationConstants.JOB_NOTIFICATION_MESSAGE, message);
		return new ResponseEntity<String>(comment,HttpStatus.OK);
	}
	
	@GetMapping(value = "/viewCreatedJob")
	public ModelAndView viewCreatedJob() {
		ModelAndView mav = new ModelAndView(ApplicationConstants.APPROVE_JOB_PAGE);
		List<JobDetail> jobList = jobDao.fetchCreatedJob();
		mav.addObject("jobList", jobList);
		return mav;
	}
	
	@GetMapping(value = "/approveJob")
	public ModelAndView approveJob(@RequestParam("jobId") Integer jobId) {
		ModelAndView mav = new ModelAndView("redirect:/job/viewCreatedJob");
		JobDetail jobDetail = jobDao.fetchJobById(jobId);
		jobDetail.setJobStatus(ApplicationConstants.ACTIVE);
		jobDao.update(jobDetail);
		return mav;
	}
	
	@GetMapping(value = "/deleteJob")
	public ModelAndView deleteJob(@RequestParam("jobId") Integer jobId) throws IOException {
		ModelAndView mav = new ModelAndView("redirect:/job/viewCreatedJob");
		JobDetail jobDetail = jobDao.fetchJobById(jobId);
		jobDao.deleteJob(jobDetail);
		deleteFile(jobDetail.getJdFileName());
		return mav;
	}
	
	private void deleteFile(String fileName) throws IOException {
		
		String rootPath = ApplicationConstants.FILE_ROOT_PATH + File.separator + ApplicationConstants.FOLDER_NAME + File.separator + fileName;
		File fileToDelete = FileUtils.getFile(rootPath);
	    FileUtils.forceDelete(fileToDelete);
	}
	
	private void uploadFile(CommonsMultipartFile file, String fileName) throws IOException {

		byte[] bytes = file.getBytes();
		String rootPath = ApplicationConstants.FILE_ROOT_PATH;
		File dir = new File(rootPath + File.separator + ApplicationConstants.FOLDER_NAME);
		if (!dir.exists())
			dir.mkdirs();

		// Create the file on server
		File serverFile = new File(dir.getAbsolutePath() + File.separator + fileName);
		BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
		stream.write(bytes);
		stream.close();
	}

}
