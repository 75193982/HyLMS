package com.jshpsoft.mail;

import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.commons.lang.StringUtils;

public class SimpleMailSender {

	private static ResourceBundle bundle = PropertyResourceBundle.getBundle("mail");

	public SimpleMailSender() {
	}

	/**
	 * 以文本格式发送邮件发送单个邮件
	 * 
	 * @param mailInfo
	 *            待发送的邮件的信息
	 */

	public boolean sendTextMail(MailSenderInfo mailInfo) {
		if (mailInfo == null) {
			return false;
		} else {
			if(StringUtils.isBlank(mailInfo.getUserName())){
				mailInfo.setUserName(bundle.getString("mail.userName"));
			}
			String account = mailInfo.getUserName();
			final String smtpHostName = "smtp." + account.split("@")[1];
//			System.out.println("发送邮件服务器：" + smtpHostName);
			mailInfo.setMailServerHost(smtpHostName);
			if(StringUtils.isBlank(mailInfo.getFromAddress())){
				mailInfo.setFromAddress(bundle.getString("mail.fromAddress"));
			}
			if(StringUtils.isBlank(mailInfo.getPassword())){
				mailInfo.setPassword(bundle.getString("mail.password"));
			}
			mailInfo.setValidate(true);
			if(StringUtils.isBlank(mailInfo.getSubject())){
				mailInfo.setSubject(bundle.getString("mail.subJect"));
			}
			if(StringUtils.isBlank(mailInfo.getToAddress())){
				mailInfo.setToAddress(bundle.getString("mail.toAddress"));
			}
		}
		// 判断是否需要身份认证
		MyAuthenticator authenticator = null;
		Properties pro = mailInfo.getProperties();
		if (mailInfo.isValidate()) {
			// 如果需要身份认证，则创建一个密码验证器
			authenticator = new MyAuthenticator(mailInfo.getUserName(),
					mailInfo.getPassword());
		}
		// 根据邮件会话属性和密码验证器构造一个发送邮件的session
		Session sendMailSession = Session
				.getDefaultInstance(pro, authenticator);
		try {
			// 根据session创建一个邮件消息
			Message mailMessage = new MimeMessage(sendMailSession);
			// 创建邮件发送者地址
			Address from = new InternetAddress(mailInfo.getFromAddress());
			// 设置邮件消息的发送者
			mailMessage.setFrom(from);
			// 创建邮件的接收者地址，并设置到邮件消息中
			Address to = new InternetAddress(mailInfo.getToAddress());
			mailMessage.setRecipient(Message.RecipientType.TO, to);
			// 设置邮件消息的主题
			mailMessage.setSubject(mailInfo.getSubject());
			// 设置邮件消息发送的时间
			mailMessage.setSentDate(new Date());
			// 设置邮件消息的主要内容
			String mailContent = mailInfo.getContent();
			mailMessage.setText(mailContent);
			// 发送邮件
			Transport.send(mailMessage);
			return true;
		} catch (MessagingException ex) {
			ex.printStackTrace();
		}
		return false;
	}

//	/**
//	 * 以文本格式发送邮件 群发邮件
//	 * 
//	 * @param mailInfo
//	 *            待发送的邮件的信息
//	 */
//	public boolean sendTextMail(MailSenderInfo mailInfo, List<Su_Users> users) {
//		if (mailInfo == null) {
//			return false;
//		} else {
//			String account = mailInfo.getUserName();
//			final String smtpHostName = "smtp." + account.split("@")[1];
//			System.out.println("发送邮件服务器：" + smtpHostName);
//			mailInfo.setMailServerHost(smtpHostName);
//			if(StringUtils.isBlank(mailInfo.getUserName())){
//				mailInfo.setUserName(bundle.getString("mail.UserName"));
//				}
//				if(StringUtils.isBlank(mailInfo.getFromAddress())){
//				mailInfo.setFromAddress(bundle.getString("mail.FromAddress"));
//				}
//				if(StringUtils.isBlank(mailInfo.getPassword())){
//				mailInfo.setPassword(bundle.getString("mail.Password"));
//				}
//				mailInfo.setValidate(true);
//				if(StringUtils.isBlank(mailInfo.getSubject())){
//				mailInfo.setSubject(bundle.getString("mail.SubJect"));
//				}
//		}
//		// 判断是否需要身份认证
//		MyAuthenticator authenticator = null;
//		Properties pro = mailInfo.getProperties();
//		if (mailInfo.isValidate()) {
//			// 如果需要身份认证，则创建一个密码验证器
//			authenticator = new MyAuthenticator(mailInfo.getUserName(),
//					mailInfo.getPassword());
//		}
//		// 根据邮件会话属性和密码验证器构造一个发送邮件的session
//		Session sendMailSession = Session
//				.getDefaultInstance(pro, authenticator);
//		try {
//			if (users != null) {
//				for (Su_Users user : users) {
//					// 根据session创建一个邮件消息
//					Message mailMessage = new MimeMessage(sendMailSession);
//					// 创建邮件发送者地址
//					Address from = new InternetAddress(
//							mailInfo.getFromAddress());
//					// 设置邮件消息的发送者
//					mailMessage.setFrom(from);
//					// 创建邮件的接收者地址，并设置到邮件消息中
//					Address to = new InternetAddress(user.getEmail());
//					mailMessage.setRecipient(Message.RecipientType.TO, to);
//					// 设置邮件消息的主题
//					mailMessage.setSubject(mailInfo.getSubject());
//					// 设置邮件消息发送的时间
//					mailMessage.setSentDate(new Date());
//					// 设置邮件消息的主要内容
//					String mailContent = mailInfo.getContent();
//					mailMessage.setText(mailContent);
//					// 发送邮件
//					Transport.send(mailMessage);
//				}
//			}
//			return true;
//		} catch (MessagingException ex) {
//			ex.printStackTrace();
//		}
//		return false;
//	}
	
	
	/**
	 * 以文本格式发送邮件 群发邮件
	 * 
	 * @param mailInfo 待发送的邮件的信息
	 */
	public boolean sendTextMail(MailSenderInfo mailInfo, List<String> emails) {
		if (mailInfo == null) {
			return false;
		} else {
			if(StringUtils.isBlank(mailInfo.getUserName())){
				mailInfo.setUserName(bundle.getString("mail.userName"));
			}
			String account = mailInfo.getUserName();
			final String smtpHostName = "smtp." + account.split("@")[1];
//			System.out.println("发送邮件服务器：" + smtpHostName);
			mailInfo.setMailServerHost(smtpHostName);
				if(StringUtils.isBlank(mailInfo.getFromAddress())){
				mailInfo.setFromAddress(bundle.getString("mail.fromAddress"));
				}
				if(StringUtils.isBlank(mailInfo.getPassword())){
				mailInfo.setPassword(bundle.getString("mail.password"));
				}
				mailInfo.setValidate(true);
				if(StringUtils.isBlank(mailInfo.getSubject())){
				mailInfo.setSubject(bundle.getString("mail.subJect"));
				}
				if(StringUtils.isBlank(mailInfo.getToAddress())){
					mailInfo.setToAddress(bundle.getString("mail.toAddress"));
				}
		}
		// 判断是否需要身份认证
		MyAuthenticator authenticator = null;
		Properties pro = mailInfo.getProperties();
		if (mailInfo.isValidate()) {
			// 如果需要身份认证，则创建一个密码验证器
			authenticator = new MyAuthenticator(mailInfo.getUserName(),
					mailInfo.getPassword());
		}
		// 根据邮件会话属性和密码验证器构造一个发送邮件的session
		Session sendMailSession = Session
				.getDefaultInstance(pro, authenticator);
		try {
			if (emails != null) {
				for (String email : emails) {
					// 根据session创建一个邮件消息
					Message mailMessage = new MimeMessage(sendMailSession);
					// 创建邮件发送者地址
					Address from = new InternetAddress(
							mailInfo.getFromAddress());
					// 设置邮件消息的发送者
					mailMessage.setFrom(from);
					// 创建邮件的接收者地址，并设置到邮件消息中
					Address to = new InternetAddress(email);
					mailMessage.setRecipient(Message.RecipientType.TO, to);
					// 设置邮件消息的主题
					mailMessage.setSubject(mailInfo.getSubject());
					// 设置邮件消息发送的时间
					mailMessage.setSentDate(new Date());
					// 设置邮件消息的主要内容
					String mailContent = mailInfo.getContent();
					mailMessage.setText(mailContent);
					// 发送邮件
					Transport.send(mailMessage);
				}
			}
			return true;
		} catch (MessagingException ex) {
			ex.printStackTrace();
		}
		return false;
	}

	/**
	 * 以HTML格式发送邮件
	 * 
	 * @param mailInfo
	 *            待发送的邮件信息
	 */
	public static boolean sendHtmlMail(MailSenderInfo mailInfo) {
		if (mailInfo == null) {
			return false;
		} else {
			if(StringUtils.isBlank(mailInfo.getUserName())){
				mailInfo.setUserName(bundle.getString("mail.userName"));
			}
			String account = mailInfo.getUserName();
			final String smtpHostName = "smtp." + account.split("@")[1];
//			System.out.println("发送邮件服务器：" + smtpHostName);
			mailInfo.setMailServerHost(smtpHostName);
				if(StringUtils.isBlank(mailInfo.getFromAddress())){
				mailInfo.setFromAddress(bundle.getString("mail.fromAddress"));
				}
				if(StringUtils.isBlank(mailInfo.getPassword())){
				mailInfo.setPassword(bundle.getString("mail.password"));
				}
				mailInfo.setValidate(true);
				if(StringUtils.isBlank(mailInfo.getSubject())){
				mailInfo.setSubject(bundle.getString("mail.subJect"));
				}
				if(StringUtils.isBlank(mailInfo.getToAddress())){
					mailInfo.setToAddress(bundle.getString("mail.toAddress"));
				}
		}
		// 判断是否需要身份认证
		MyAuthenticator authenticator = null;
		Properties pro = mailInfo.getProperties();
		// 如果需要身份认证，则创建一个密码验证器
		if (mailInfo.isValidate()) {
			authenticator = new MyAuthenticator(mailInfo.getUserName(),
					mailInfo.getPassword());
		}
		// 根据邮件会话属性和密码验证器构造一个发送邮件的session
		Session sendMailSession = Session
				.getDefaultInstance(pro, authenticator);
		try {
			// 根据session创建一个邮件消息
			Message mailMessage = new MimeMessage(sendMailSession);
			// 创建邮件发送者地址
			Address from = new InternetAddress(mailInfo.getFromAddress());
			// 设置邮件消息的发送者
			mailMessage.setFrom(from);
			// 创建邮件的接收者地址，并设置到邮件消息中
			Address to = new InternetAddress(mailInfo.getToAddress());
			// Message.RecipientType.TO属性表示接收者的类型为TO
			mailMessage.setRecipient(Message.RecipientType.TO, to);
			// 设置邮件消息的主题
			mailMessage.setSubject(mailInfo.getSubject());
			// 设置邮件消息发送的时间
			mailMessage.setSentDate(new Date());
			// MiniMultipart类是一个容器类，包含MimeBodyPart类型的对象
			Multipart mainPart = new MimeMultipart();
			// 创建一个包含HTML内容的MimeBodyPart
			BodyPart html = new MimeBodyPart();
			// 设置HTML内容
			html.setContent(mailInfo.getContent(), "text/html; charset=utf-8");
			mainPart.addBodyPart(html);
			// 将MiniMultipart对象设置为邮件内容
			mailMessage.setContent(mainPart);
			// 发送邮件
			Transport.send(mailMessage);
			return true;
		} catch (MessagingException ex) {
			ex.printStackTrace();
		}
		return false;
	}

	/**
	 * 以HTML格式发送邮件
	 * 
	 * @param mailInfo
	 *            群发邮件 待发送的邮件信息
	 */
	public static boolean sendHtmlMail(MailSenderInfo mailInfo,
			List<String> users) {
		if (mailInfo == null) {
			return false;
		} else {
			if(StringUtils.isBlank(mailInfo.getUserName())){
				mailInfo.setUserName(bundle.getString("mail.userName"));
			}
//			String account = mailInfo.getUserName();
//			final String smtpHostName = "smtp." + account.split("@")[1];
//			System.out.println("发送邮件服务器：" + smtpHostName);
				if(StringUtils.isBlank(mailInfo.getFromAddress())){
				mailInfo.setFromAddress(bundle.getString("mail.fromAddress"));
				}
				if(StringUtils.isBlank(mailInfo.getPassword())){
				mailInfo.setPassword(bundle.getString("mail.password"));
				}
				mailInfo.setValidate(true);
				if(StringUtils.isBlank(mailInfo.getSubject())){
				mailInfo.setSubject(bundle.getString("mail.subJect"));
				}
				if(StringUtils.isBlank(mailInfo.getToAddress())){
					mailInfo.setToAddress(bundle.getString("mail.toAddress"));
				}
		}
		// 判断是否需要身份认证
		MyAuthenticator authenticator = null;
		Properties pro = mailInfo.getProperties();
		// 如果需要身份认证，则创建一个密码验证器
		if (mailInfo.isValidate()) {
			authenticator = new MyAuthenticator(mailInfo.getUserName(),
					mailInfo.getPassword());
		}
		// 根据邮件会话属性和密码验证器构造一个发送邮件的session
		Session sendMailSession = Session
				.getDefaultInstance(pro, authenticator);
		try {
			if (users != null) {
				for (String user : users) {
					// 根据session创建一个邮件消息
					Message mailMessage = new MimeMessage(sendMailSession);
					// 创建邮件发送者地址
					Address from = new InternetAddress(
							mailInfo.getFromAddress());
					// 设置邮件消息的发送者
					mailMessage.setFrom(from);
					// 创建邮件的接收者地址，并设置到邮件消息中
					Address to = new InternetAddress(user);
					// Message.RecipientType.TO属性表示接收者的类型为TO
					mailMessage.setRecipient(Message.RecipientType.TO, to);
					// 设置邮件消息的主题
					mailMessage.setSubject(mailInfo.getSubject());
					// 设置邮件消息发送的时间
					mailMessage.setSentDate(new Date());
					// MiniMultipart类是一个容器类，包含MimeBodyPart类型的对象
					Multipart mainPart = new MimeMultipart();
					// 创建一个包含HTML内容的MimeBodyPart
					BodyPart html = new MimeBodyPart();
					// 设置HTML内容
					html.setContent(mailInfo.getContent(),
							"text/html; charset=utf-8");
					mainPart.addBodyPart(html);
					// 将MiniMultipart对象设置为邮件内容
					mailMessage.setContent(mainPart);
					// 发送邮件
					Transport.send(mailMessage);
				}
			}
			return true;
		} catch (MessagingException ex) {
			ex.printStackTrace();
		}
		return false;
	}
}
