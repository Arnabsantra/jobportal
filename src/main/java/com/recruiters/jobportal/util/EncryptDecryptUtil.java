package com.recruiters.jobportal.util;

import java.io.IOException;
import java.util.Date;
import java.util.Random;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class EncryptDecryptUtil {

	private static Random rand = new Random((new Date()).getTime());

	public static String encrypt(String str) {

		BASE64Encoder encoder = new BASE64Encoder();

		byte[] salt = new byte[8];

		rand.nextBytes(salt);

		return encoder.encode(salt) + encoder.encode(str.getBytes());
	}

	public static String decrypt(String encstr) throws IOException {

		if (encstr.length() > 12) {

			String cipher = encstr.substring(12);

			BASE64Decoder decoder = new BASE64Decoder();

				return new String(decoder.decodeBuffer(cipher));
		}

		return null;
	}
}
