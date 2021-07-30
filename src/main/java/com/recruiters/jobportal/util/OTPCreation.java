package com.recruiters.jobportal.util;

import java.security.SecureRandom;

public class OTPCreation {

	public String generateOTP() {
		
		SecureRandom random = new SecureRandom();
		String otp = String.valueOf(random.nextInt(999999));
		return otp;
	}
}
