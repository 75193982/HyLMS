package com.jshpsoft.util;

import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.jpush.api.JPushClient;
import cn.jpush.api.common.resp.APIConnectionException;
import cn.jpush.api.common.resp.APIRequestException;
import cn.jpush.api.push.PushResult;
import cn.jpush.api.push.model.Message;
import cn.jpush.api.push.model.Options;
import cn.jpush.api.push.model.Platform;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.audience.AudienceTarget;
import cn.jpush.api.push.model.notification.IosNotification;
import cn.jpush.api.push.model.notification.Notification;

/**
 * 极光推送工具类
 * @author Administrator
 *
 */
@SuppressWarnings("deprecation")
public class JPushUtils {
	
	private static Logger LOG = LoggerFactory.getLogger(JPushUtils.class);
	
	private static ResourceBundle bundle = PropertyResourceBundle.getBundle("conf");
	
	private static JPushClient jpushClient;

	static {
//		jpushClient = new JPushClient(  bundle.getString("secret"), bundle.getString("appkey"), 3);
		jpushClient = new JPushClient(  Constants.PUSH_SECRET, Constants.PUSH_APPKEY, 3);
	}

	/**
	 * 推送消息到某些人
	 * @throws APIRequestException 
	 * @throws APIConnectionException 
	 */
	public static boolean push(String msgContent, String... receiveUsers) throws Exception {
		boolean rt = false;
		PushPayload payloadAndroid = buildPushObject_android_audienceMore_messageWithExtras(msgContent, receiveUsers);
		PushPayload payloadIos = buildPushObject_ios_audienceMore_messageWithExtras(msgContent, receiveUsers);
		try {
			PushResult result_android = jpushClient.sendPush(payloadAndroid);
			rt = true;
			LOG.debug("Got result - result_android =" + result_android );
		} catch (APIConnectionException e) {
			// Connection error, should retry later
			LOG.error("Connection error, should retry later", e);
			throw new RuntimeException( e ); 
		} catch (APIRequestException e) {
			 // Should review the error, and fix the request
			 LOG.error("Should review the error, and fix the request", e);
			 LOG.info("HTTP Status: " + e.getStatus());
			 LOG.info("Error Code: " + e.getErrorCode());
			 LOG.info("Error Message: " + e.getErrorMessage());
		}
		try {
			PushResult result_ios = jpushClient.sendPush(payloadIos);
			rt = true;
			LOG.debug("Got result - result ios=" + result_ios);
		} catch (APIConnectionException e) {
			// Connection error, should retry later
			LOG.error("Connection error, should retry later", e);
			throw new RuntimeException( e ); 
		} catch (APIRequestException e) {
			 // Should review the error, and fix the request
			 LOG.error("Should review the error, and fix the request", e);
			 LOG.info("HTTP Status: " + e.getStatus());
			 LOG.info("Error Code: " + e.getErrorCode());
			 LOG.info("Error Message: " + e.getErrorMessage());
			throw new RuntimeException( e ); 
		}
		
		return rt;
	}
	
	/**
	 * 推送消息到所有人
	 */
	public static boolean pushToAll(String msgContent) {
		boolean rt = false;
		
		PushPayload payload = buildPushObject_all_all_alert(msgContent);
		try {
			PushResult result = jpushClient.sendPush(payload);
			rt = true;
			LOG.debug("Got result - " + result);

		} catch (APIConnectionException e) {
			// Connection error, should retry later
			LOG.error("Connection error, should retry later", e);
			throw new RuntimeException( e ); 
		} catch (APIRequestException e) {
			 // Should review the error, and fix the request
			 LOG.error("Should review the error, and fix the request", e);
			 LOG.info("HTTP Status: " + e.getStatus());
			 LOG.info("Error Code: " + e.getErrorCode());
			 LOG.info("Error Message: " + e.getErrorMessage());
			throw new RuntimeException( e ); 
		}

		return rt;
	}
	
	public static PushPayload buildPushObject_all_all_alert(String msgContent) {
        return PushPayload.alertAll(msgContent);
    }
	/**
	 * android
	 * @param msgContent
	 * @param receiveUsers
	 * @return
	 */
	public static PushPayload buildPushObject_android_audienceMore_messageWithExtras(
			String msgContent, String... receiveUsers) {

		/*return PushPayload
				.newBuilder()
				.setPlatform(Platform.all())
				.setAudience(
						Audience.newBuilder()
								.addAudienceTarget(
										AudienceTarget.alias(receiveUsers))
								.build())
				.setNotification(Notification.alert(msgContent))
				.build();*/
		return PushPayload.newBuilder()
                .setPlatform(Platform.android())
                .setAudience(Audience.newBuilder()
                        .addAudienceTarget(AudienceTarget.alias(receiveUsers))
                        .build())
                .setMessage(Message.newBuilder()
                        .setMsgContent(msgContent)
                        .addExtra("title", "辉宇物流消息通知")
                        .build())
                .build();
	}
	
	/**
	 * ios推送
	 * @param msgContent
	 * @param receiveUsers
	 * @return
	 */
	public static PushPayload buildPushObject_ios_audienceMore_messageWithExtras(
			String msgContent, String... receiveUsers) {	
		String apnsProduction = bundle.getString("apnsProduction");
		return PushPayload
				.newBuilder()
				.setPlatform(Platform.all())
				.setAudience(
						Audience.newBuilder()
								.addAudienceTarget(
										AudienceTarget.alias(receiveUsers))
								.build())
				.setNotification(Notification.newBuilder()
                        .addPlatformNotification(IosNotification.newBuilder()
                                .setAlert(msgContent)
                                .setBadge(1)
                                .setSound("default")                            
                                .build())
                        .build())
                        .setOptions(Options.newBuilder()
                         .setApnsProduction( Boolean.parseBoolean(apnsProduction) )//生产坏境
                         .build())
				.build();
	}
	
	
	
	public static void main(String[] args) throws Exception {
		push("hello world!", "999", "888");
	}
	
}
