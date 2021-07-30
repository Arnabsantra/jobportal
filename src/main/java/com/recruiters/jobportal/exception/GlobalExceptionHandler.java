package com.recruiters.jobportal.exception;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.recruiters.jobportal.constants.ApplicationConstants;

@ControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler(Exception.class)
	public ModelAndView handleSQLException(HttpServletRequest request, Exception ex) {
		ModelAndView modelAndView = new ModelAndView(ApplicationConstants.GENERIC_EXCEPTION);
		return modelAndView;
	}
}
