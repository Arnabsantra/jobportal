package com.recruiters.jobportal.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.recruiters.jobportal.constants.ApplicationConstants;
import com.recruiters.jobportal.dao.JobDAO;
import com.recruiters.jobportal.model.JobDetail;

/**
 * Represents the controller for the home page related use cases
 * */
@Controller
public class MasterController {
	

	@Autowired
	private JobDAO jobDao;
	/**
	 * @return home page
	 * */
	@RequestMapping(value = {"/", "/index", "/home"})
	public ModelAndView showHome() {
		ModelAndView mav = new ModelAndView(ApplicationConstants.GUEST_PAGE);
		mav.addObject(ApplicationConstants.TITLE, ApplicationConstants.HOME);
		Long count = jobDao.countJob();
		List<JobDetail> jobDetails = jobDao.topNJobs(3);
		mav.addObject("jobCount", count);
		mav.addObject("jobList", jobDetails);
		return mav;
	}
	
	/**
	 * @return login form
	 * */
	@RequestMapping(value = "/logout")
	public ModelAndView showLogout() {
		ModelAndView mav = new ModelAndView("login");
		return mav;
	}
	
	/**
	 * @return access denied page
	 * */
	@RequestMapping(value = "/access-denied")
	public ModelAndView accessDenied() {
		ModelAndView mav = new ModelAndView("access-denied");
		return mav;
	}
}
