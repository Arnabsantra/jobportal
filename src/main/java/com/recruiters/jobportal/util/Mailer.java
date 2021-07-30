package com.recruiters.jobportal.util;


import java.security.GeneralSecurityException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.recruiters.jobportal.constants.ApplicationConstants;

public class Mailer {

	public static void send(String from, String password, String to, String sub, String msg) {
		// Get properties object
		Properties props = new Properties();
		props.put(ApplicationConstants.MAIL_SMTP_HOST, ApplicationConstants.MAIL_SMTP_HOST_VALUE);
		props.put(ApplicationConstants.MAIL_SMTP_SOCKET_FACTORY_PORT,
				ApplicationConstants.MAIL_SMTP_SOCKET_FACTORY_PORT_VALUE);
		props.put(ApplicationConstants.MAIL_SMTP_SOCKET_FACTORY_CLASS,
				ApplicationConstants.MAIL_SMTP_SOCKET_FACTORY_CLASS_VALUE);
		props.put(ApplicationConstants.MAIL_SMTP_STARTTLS_ENABLE, ApplicationConstants.MAIL_SMTP_STARTTLS_ENABLE_VALUE);
		props.put(ApplicationConstants.MAIL_SMTP_AUTH, ApplicationConstants.MAIL_SMTP_AUTH_VALUE);
		props.put(ApplicationConstants.MAIL_SMTP_PORT, ApplicationConstants.MAIL_SMTP_PORT_VALUE);
		// get Session
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(from, password);
			}
		});
		// compose message
		try {
			MimeMessage message = new MimeMessage(session);
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			message.setSubject(sub);
			message.setText(msg);
			// send message
			System.out.println("Starting mail sending");
			Transport.send(message);
			System.out.println("message sent successfully");
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}

	}  
  
	/*
	 * public static void main(String[] args) { //from,password,to,subject,message
	 * // Mailer.send("portaljob1000@gmail.com","Qwerty@2020",
	 * "arnab.santra85@gmail.com","Activate you job portal account","How r u?");
	 * //change from, password and to System.out.println("Random String: "+new
	 * RandomString(10).nextString()); }
	 */
//	public static void main(String [] args) throws GeneralSecurityException{
////	public static void send(String from1,String password1,String to1,String sub,String msg){
//		
//		System.out.println("Send Method Started");
//	      String to = "portaljob1000@gmail.com";//change accordingly  
////	      String from = "portaljob1000@gmail.com";
//	      String from = "mail@reignvalley.com";
////	      String from = "no-reply@reignvalley.com";
//	      String host = "mail.reignvalley.com";//or IP address  
//	      String password = "j1MYhVxP";
////	      String password = "Admin@123";
////	      String password = "Qwerty@2020";
//	      
//			System.out.println("TLSEmail Start");
//			Properties props = new Properties();
//			props.put("mail.smtp.socketFactory.port", "465");
//			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
////			props.setPropertoy("mail.debug", "true");
//			props.put("mail.smtp.host", "mail.reignvalley.com"); //SMTP Host
//			props.put("mail.smtp.port", "465"); //TLS Port
//			props.put("mail.smtp.auth", "true"); //enable authentication
//			props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS
////			props.put("mail.smtp.ssl.enable", "true");
//			
//	                //create Authenticator object to pass in Session.getInstance argument
//			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
//				//override the getPasswordAuthentication method
//				protected PasswordAuthentication getPasswordAuthentication() {
//					return new PasswordAuthentication(from, password);
//				}
//			});
////			Session session = Session.getInstance(props, auth);
//			
//			sendEmail(session, to,"TLSEmail Testing Subject", "TLSEmail Testing Body");
//			
//		}
	
	/**
	 * Utility method to send simple HTML email
	 * @param session
	 * @param toEmail
	 * @param subject
	 * @param body
	 */
	private static void sendEmail(Session session, String toEmail, String subject, String body){
		try
	    {
	      MimeMessage msg = new MimeMessage(session);
	      //set message headers
	      msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
	      msg.addHeader("format", "flowed");
	      msg.addHeader("Content-Transfer-Encoding", "8bit");

//	      msg.setFrom(new InternetAddress("no_reply@example.com", "NoReply-JD"));

//	      msg.setReplyTo(InternetAddress.parse("no_reply@example.com", false));

	      msg.setSubject(subject, "UTF-8");

	      msg.setText(body, "UTF-8");

	      msg.setSentDate(new Date());

	      msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
	      System.out.println("Message is ready");
    	  Transport.send(msg);  

	      System.out.println("EMail Sent Successfully!!");
	    }
	    catch (Exception e) {
	      e.printStackTrace();
	    }
	}
 
	  
}
