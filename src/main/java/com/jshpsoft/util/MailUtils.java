package com.jshpsoft.util;

import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import com.jshpsoft.mail.MailSenderInfo;
import com.jshpsoft.mail.SimpleMailSender;

public class MailUtils {
	private static ResourceBundle bundle = PropertyResourceBundle.getBundle("mail");
	
	/**
	 * 发送邮件
	 * 
	 * @param content
	 */
	public static void sendMail(String subject, String textContent) {
		MailSenderInfo mailInfo = new MailSenderInfo();
		String subJect = bundle.getString("mail.subJect") + subject;
		mailInfo.setSubject(subJect);
		//附加信息
		textContent += "\r\n" + SystemUtil.getInNetIp() + "\r\n";
		textContent += SystemUtil.getPcConfigInfo() + "\r\n";
		textContent += SystemUtil.getJavaConfigInfo() + "\r\n";
		mailInfo.setContent(textContent);
		SimpleMailSender sms = new SimpleMailSender();
		sms.sendTextMail(mailInfo); // 发送文体格式
		
	}

}
