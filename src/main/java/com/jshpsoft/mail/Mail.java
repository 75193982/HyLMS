package com.jshpsoft.mail;

import java.io.Serializable;

public class Mail implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5968496183026698972L;
	
	/**
	 * 发件人邮箱
	 */
	private String username;
	
	/**
	 * 发件人邮箱密码
	 */
	private String password;
	
	/**
	 * 邮件主题
	 */
	private String subject;
	
	/**
	 * 邮件内容
	 */
	private String mailcontent;
	
	/**
	 * 发件人
	 */
	private String from_address;
	
	/**
	 * 收件人
	 */
	private String to_address;
	
	/**
	 * 邮件类型(0审核通过1驳回2终审通过3预警)
	 */
	private Integer mail_type;
	
	/**
	 * 邮件状态(0未发送1已发送2发送失败)
	 */
	private Integer mail_status;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getMailcontent() {
		return mailcontent;
	}

	public void setMailcontent(String mailcontent) {
		this.mailcontent = mailcontent;
	}

	public String getFrom_address() {
		return from_address;
	}

	public void setFrom_address(String from_address) {
		this.from_address = from_address;
	}

	public String getTo_address() {
		return to_address;
	}

	public void setTo_address(String to_address) {
		this.to_address = to_address;
	}

	public Integer getMail_type() {
		return mail_type;
	}

	public void setMail_type(Integer mail_type) {
		this.mail_type = mail_type;
	}

	public Integer getMail_status() {
		return mail_status;
	}

	public void setMail_status(Integer mail_status) {
		this.mail_status = mail_status;
	}
	
}
