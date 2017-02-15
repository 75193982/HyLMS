package com.jshpsoft.listener;


import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.jshpsoft.domain.SystemErrorLog;
import com.jshpsoft.service.SystemErrorLogService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.AddressIP;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.MailUtils;

public class InitListener implements ApplicationListener<ContextRefreshedEvent> {
	
	private Logger logger = Logger.getLogger(InitListener.class);

	@Autowired
	private CommonService commonService;
	
	@Autowired
	private SystemErrorLogService systemErrorLogService;
	
	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		// 在web 项目中（spring mvc），系统会存在两个容器，一个是root application context ,另一个就是我们自己的 projectName-servlet context（作为root application context的子容器）。
		// 这种情况下，就会造成onApplicationEvent方法被执行两次。为了避免上面提到的问题，我们可以只在root application context初始化完成后调用逻辑代码，其他的容器的初始化完成，则不做任何处理，修改后代码
		if (event.getApplicationContext().getParent() == null) {// root application context 没有parent，他就是老大.
			// 需要执行的逻辑代码，当spring容器初始化完成后就会执行该方法。
			logger.error("*******************************listener init*************************");
			Constants.CTX = event.getApplicationContext().getApplicationName();
			logger.error("Constants.CTX="+Constants.CTX);
			
		}
		
		try{
			String operateName = "PROJECT START";
	        String exceptionMsg = 
	        		"**************************启动信息**************************"
	        		+"\r\n*******access_date:" + CommonUtil.format( new Date(), "yyyy-MM-dd HH:mm:ss")
	        		+"\r\n*******operate:" + operateName
	        		+"\r\n******************************";
			MailUtils.sendMail( operateName, exceptionMsg );
			
		}catch(Exception e){
			
		}
		
		//读取推送配置
		try{
			String appkey = commonService.getConfigValue(0,Constants.BasicConfigName.JPUSH_APPKEY);
			String secret = commonService.getConfigValue(0,Constants.BasicConfigName.JPUSH_SECRET);
			Constants.PUSH_APPKEY = appkey;
			Constants.PUSH_SECRET = secret;
			
		}catch(Exception e){
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			String accessIp = AddressIP.getIpAddr(request);
			int operatorId = CommonUtil.getUserIdFromSession(request);
			String params = "";
			String detailInfo = "";
			String operateName = "";
			String exceptionName = e.getClass().getName() + ": " + e.getMessage();
			
			try {
				operateName = "读取推送账户信息";
				detailInfo = getExceptionMsg((Exception)e);
				
				SystemErrorLog errorLog = new SystemErrorLog();
				errorLog.setDetailInfo(detailInfo);
				errorLog.setExceptionName(exceptionName);
				errorLog.setLoginIp(accessIp);
				errorLog.setOperateName(operateName);
				errorLog.setParams(params);
				errorLog.setOperator(operatorId + "");
				errorLog.setOperateTime(new Date());
				systemErrorLogService.insert(errorLog);
				//发送邮件
				MailUtils.sendMail( operateName+"失败",  CommonUtil.createExceptionMsg("【初始化】", accessIp, operateName, params, request, (Exception)e)  );

			} catch (Exception ex) {
				logger.error(ex.getMessage(), ex);
				//发送邮件
				MailUtils.sendMail( operateName+"失败",  CommonUtil.createExceptionMsg("【初始化】", accessIp, operateName, params, request, ex) );
				
			}
			
		}
		
	}
	
	/**获取异常信息**/
	public String getExceptionMsg(Exception e){
		StringBuffer emsg = new StringBuffer();
		if(e!=null){
			StackTraceElement[] st = e.getStackTrace();
			for (StackTraceElement stackTraceElement : st) {
				String exclass = stackTraceElement.getClassName();
				String method = stackTraceElement.getMethodName();
				emsg.append("	at " + exclass + "."+ method + "("+stackTraceElement.getFileName() + ":" + stackTraceElement.getLineNumber()+")" +"\r\n");
			}
		}
		return emsg.toString();
	}
	

}
