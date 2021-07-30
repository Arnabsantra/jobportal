package com.recruiters.jobportal.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.recruiters.jobportal.constants.ApplicationConstants;
import com.recruiters.jobportal.dao.RoleDao;
import com.recruiters.jobportal.dao.TmpUserDAO;
import com.recruiters.jobportal.dao.UserDAO;
import com.recruiters.jobportal.model.RoleDetail;
import com.recruiters.jobportal.model.TmpUser;
import com.recruiters.jobportal.model.UserDetail;
import com.recruiters.jobportal.util.EncryptDecryptUtil;
import com.recruiters.jobportal.util.Mailer;
import com.recruiters.jobportal.util.RandomString;

@Controller
@RequestMapping("/user")
public class UserController {

	
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private RoleDao roleDao;
	
	@Autowired
	private TmpUserDAO tmpUserDao;
	/*
	 *This method will be called from AJAX. This will check if the email id already exists or not.
	 */
	
	@RequestMapping(value = "/userForm")
	public ModelAndView showUserForm() {
		ModelAndView mav = new ModelAndView(ApplicationConstants.REGISTER_PAGE);
		mav.addObject(ApplicationConstants.TITLE, ApplicationConstants.SIGNIN);
		mav.addObject("userClicksUserForm", true);
		mav.addObject("user", new UserDetail());
		return mav;
	}
	
	@GetMapping(value = "/chekEmailAvailability")
	@ResponseBody
	public ResponseEntity<String> chekEmailAvailability(@RequestParam String email) {
		
		UserDetail userDetail = userDAO.findUserByEmail(email);
		if(null != userDetail) {
			return new ResponseEntity<String>(ApplicationConstants.USER_EXISTS,HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity<String>(ApplicationConstants.SUCCESS,HttpStatus.OK);
	}
	
	/*
	 *This method will be called from AJAX. It will generate the otp and save user details into
	 *TMP_USER table. After successful save it will trigger mail with the OTP.
	 */
	@PostMapping(value = "/saveTempUserData")
	@ResponseBody
	public ResponseEntity<String> saveTmpUser(@RequestBody TmpUser tmpUser, HttpServletRequest request) {

		String contextPath = request.getContextPath();
		RoleDetail roleDetail = roleDao.fetchRecruiterRole();
		tmpUser.setOtp(new RandomString(10).nextString());
		tmpUser.setRoleId(roleDetail.getRoleId());
		tmpUserDao.save(tmpUser);
		String userCode = EncryptDecryptUtil.encrypt(tmpUser.getEmailId() + "|" + tmpUser.getOtp());
		String link = ApplicationConstants.HTTP + "://" + ApplicationConstants.SERVER_HOST
				+ ApplicationConstants.SERVER_PORT + contextPath + "/user/saveUserData?userData=" + userCode;
		String message = "Dear User," + System.lineSeparator() + "Please click in the link to validate your account"
				+ System.lineSeparator() + link;
//		Send Email to the user
		try {
		Mailer.send(ApplicationConstants.EMAIL_FROM_ADDRESS, ApplicationConstants.EMAIL_FROM_PASSWORD,
				tmpUser.getEmailId(), ApplicationConstants.USER_CREATE_EMAIL_SUBJECT, message);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<String>(ApplicationConstants.USER_CRTD_EMAIL_SENT, HttpStatus.OK);
	}
	
	/* This method will validate the otp. if the otp is correct and not expired it will create the user in the
	 * USER_DETAILS table in created status. Admin will approve the use5r later.
	 */
	@GetMapping(value = "/saveUserData")
	@ResponseBody
	public ModelAndView saveUser(@RequestParam(name = "userData") String data)
			throws Exception {

		ModelAndView mav = new ModelAndView(ApplicationConstants.GUEST_PAGE);
		if (null != data) {
			data = EncryptDecryptUtil.decrypt(data);
			String email = data.split("\\|")[0];
			String code = data.split("\\|")[1];
			TmpUser tmpUser = tmpUserDao.get(email);
			if (null != code && code.equals(tmpUser.getOtp())) {

				long codeCreatedTimeMill = tmpUser.getLastUpdtdTimestamp().getTime();
				long currentTimeMill = new Date().getTime();
				long timeDiff = currentTimeMill - codeCreatedTimeMill;
				// Validating if OTP has been expired or not
				if ((timeDiff / (1000 * 60)) % 60 <= Integer.parseInt(ApplicationConstants.EMAIL_VALIDATION_TIME)) {

					UserDetail userDetail = new UserDetail();
					BeanUtils.copyProperties(userDetail, tmpUser);
					userDetail.getRoleDetail().setRoleId(tmpUser.getRoleId());
					userDetail.setUserStatus("CREATED");
					userDAO.save(userDetail);
					mav.addObject("message", ApplicationConstants.USER_CREATED);
					return mav;
				}
				mav.addObject("message", ApplicationConstants.LINK_EXPIRED);
				return mav;
			}
			mav.addObject("message",ApplicationConstants.INVALID_LINK);
			return mav;
		} else {
			throw new Exception();
		}

	}
	
	@GetMapping(value = "/viewCreatedUser")
	public ModelAndView viewCreatedUser() {
		ModelAndView mav = new ModelAndView(ApplicationConstants.APPROVE_USER_PAGE);
		List<UserDetail> list = userDAO.findCreatedUsers();
		mav.addObject("userList", list);
		return mav;
	}
	
	@GetMapping(value = "/approveUser")
	public ModelAndView approveUser(@RequestParam("userId") Integer userId) {
		ModelAndView mav = new ModelAndView("redirect:/user/viewCreatedUser");
		UserDetail userDetail = userDAO.get(userId);
		userDetail.setUserStatus(ApplicationConstants.ACTIVE);
		userDAO.update(userDetail);
		return mav;
	}
	
	@GetMapping(value = "/fetchByEmail")
	@ResponseBody
	public ResponseEntity<String> fetchByEmail(@RequestParam String email, HttpServletRequest request) {
		
		String contextPath = request.getContextPath();
		request.getRemoteHost();
		request.getRemoteAddr();
		UserDetail userDetail = userDAO.findUserByEmail(email);
		if(null == userDetail) {
			return new ResponseEntity<String>(ApplicationConstants.USER_NOT_EXISTS,HttpStatus.BAD_REQUEST);
		}
		
		String userCode = EncryptDecryptUtil.encrypt(userDetail.getEmailId());
		String link = ApplicationConstants.HTTP + "://" + ApplicationConstants.SERVER_HOST
				+ ApplicationConstants.SERVER_PORT + contextPath + "/user/confirmPassword?userData=" + userCode;
		String message = "Dear User," + System.lineSeparator() + "Please click in the link to Reset your Password"
				+ System.lineSeparator() + link;
//		Send Email to the user
		Mailer.send(ApplicationConstants.EMAIL_FROM_ADDRESS, ApplicationConstants.EMAIL_FROM_PASSWORD,
				userDetail.getEmailId(), ApplicationConstants.USER_EMAIL_FORGOT_PASSWORD, message);
		
		
		return new ResponseEntity<String>(ApplicationConstants.SUCCESS,HttpStatus.OK);
	}
	
	@GetMapping(value = "/confirmPassword")
	@ResponseBody
	public ModelAndView confirmPassword(@RequestParam(name = "userData") String email)
			throws Exception {

		ModelAndView mav = new ModelAndView(ApplicationConstants.REST_PASSWORD_PAGE);
		if(email != null) {
		email = EncryptDecryptUtil.decrypt(email);
		}
		mav.addObject("email", email);
		return mav;	

	}
	
	@PostMapping(value = "/changePassword")
	public ModelAndView changePassword(@RequestParam(name = "email") String email, @RequestParam(name = "pass") String pass) {
		
		ModelAndView mav = new ModelAndView(ApplicationConstants.GUEST_PAGE);
		UserDetail userDetail = userDAO.findUserByEmail(email);
		userDetail.setPassword(new BCryptPasswordEncoder().encode(pass));
		userDAO.update(userDetail);
		mav.addObject("message", ApplicationConstants.PASSWORD_CHANGED_MESSAGE);
		return mav;
	}
	
}
