package com.jshpsoft.aop;

import java.lang.reflect.Method;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.domain.SystemErrorLog;
import com.jshpsoft.domain.SystemOperateLog;
import com.jshpsoft.service.SystemErrorLogService;
import com.jshpsoft.service.SystemOperateLogService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.AddressIP;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.JsonUtils;
import com.jshpsoft.util.MailUtils;

@Aspect
@Component
public class SystemLogAspect implements Ordered {

	public static final Logger logger = Logger.getLogger(SystemLogAspect.class);
	
	@Autowired
	private SystemOperateLogService systemOperateLogService;

	@Autowired
	private SystemErrorLogService systemErrorLogService;
	
	@Autowired
	private CommonService commonService;

	/**
	 * Service层切点
	 */
	@Pointcut("@annotation(com.jshpsoft.annotation.SystemServiceLog)")
	public void serviceAspect() {

	}
	
	/**
	 * controller层切点
	 */
	@Pointcut("@annotation(com.jshpsoft.annotation.SystemControllerLog)")
	public void controllerAspect() {
		
	}

	/**
	 * 前置通知-处理service
	 * 
	 * @param joinPoint
	 * @param rtv
	 * @throws Throwable
	 */
//	@Before(value = "controllerAspect()", argNames = "rtv")
//	public Object controllerAspectCalls(JoinPoint joinPoint) throws Throwable {
	@Before(value = "serviceAspect()", argNames = "rtv")
	public Object serviceAspectCalls(JoinPoint joinPoint) throws Throwable {
		
		//未开启，则不记录日志
		String logEnabledFlag = commonService.getConfigValue(0, Constants.BasicConfigName.LOG_ENABLED );
		if( !"Y".equals(logEnabledFlag) ){
			return null;
		}
		
		//单元测试特殊
		if( null == RequestContextHolder.getRequestAttributes() ){
			return null;
		}
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
				
		String accessIp = AddressIP.getIpAddr(request);
		String operateName = "";
		String operateContent = "";
		
		//通知处理方法
		Object result = null;
		try {
			//获取当前用户id
			int operatorId = CommonUtil.getUserIdFromSession(request);
			//获取业务操作名称
			operateName = getServiceMthodDescription(joinPoint);
			String params = "";
			if(joinPoint.getArgs() !=  null && joinPoint.getArgs().length > 0) {    
	            for ( int i = 0; i < joinPoint.getArgs().length; i++) {    
	            	params += "参数" + (i+1) + ":" + JsonUtils.objectToJson( joinPoint.getArgs()[i] ) + ";";   
	            }    
	        } 
			operateContent = joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()[" + params+"]";
			SystemOperateLog log = new SystemOperateLog();
			log.setOperator(operatorId + "");
			log.setLoginIp(accessIp);
			log.setOperateName(operateName);
			log.setOperateContent(operateContent);
			log.setOperateTime(new Date());
			systemOperateLogService.insert(log);// 添加日志
			
		} catch (Exception ex) {
			 //记录本地异常日志
			logger.error(ex.getMessage(), ex);
			
			//发送邮件
			MailUtils.sendMail(operateName+"失败", CommonUtil.createExceptionMsg("【业务层记录时异常】", accessIp, operateName, operateContent, request, ex) );
		}

		return result;
	}

	/**
	 * 异常通知 用于拦截service层记录异常日志
	 * 
	 * @param joinPoint
	 * @param e
	 */
	@AfterThrowing(pointcut = "serviceAspect()", throwing = "e")
	public void doAfterThrowing(JoinPoint joinPoint, Throwable e) {
		
		//单元测试特殊
		if( null == RequestContextHolder.getRequestAttributes() ){
			return;
		}
				
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String accessIp = AddressIP.getIpAddr(request);
		int operatorId = CommonUtil.getUserIdFromSession(request);
		String params = "";
		String detailInfo = "";
		String operateName = "";
		
		try {
			operateName = getServiceMthodDescription(joinPoint);
			String exceptionName = e.getClass().getName() + ": " + e.getMessage();
			if(joinPoint.getArgs() !=  null && joinPoint.getArgs().length > 0) {    
	            for ( int i = 0; i < joinPoint.getArgs().length; i++) {    
	                params += "参数" + (i+1) + ":" + JsonUtils.objectToJson( joinPoint.getArgs()[i] );
	                
	            }    
	        } 
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
			MailUtils.sendMail( operateName+"失败",  CommonUtil.createExceptionMsg("【业务层异常记录】", accessIp, operateName, params, request, (Exception)e)  );

		} catch (Exception ex) {
			// 记录本地异常日志
			logger.error(ex.getMessage(), ex);
			//发送邮件
			MailUtils.sendMail( operateName+"失败",  CommonUtil.createExceptionMsg("【业务层异常记录时异常】", accessIp, operateName, params, request, ex) );
			
		}
		
	}

	/**获取异常信息**/
	public static String getExceptionMsg(Exception e){
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
	
	/**
	 * 使用反射来获取被拦截方法(insert、update)的参数值， 将参数值拼接为操作内容
	 */
	public String adminOptionContent(Object[] args, String mName)
			throws Exception {

		if (args == null) {
			return null;
		}

		StringBuffer rs = new StringBuffer();
		rs.append(mName);
		String className = null;
		int index = 1;
		// 遍历参数对象
		for (Object info : args) {

			// 获取对象类型
			className = info.getClass().getName();
			className = className.substring(className.lastIndexOf(".") + 1);
			rs.append("[参数" + index + "，类型：" + className + "，值："
					/*+ args[(index - 1)] + "；"*/);

			// 获取对象的所有方法
			Method[] methods = info.getClass().getDeclaredMethods();

			// 遍历方法，判断get方法
			for (Method method : methods) {

				String methodName = method.getName();
				// 判断是不是get方法
				if (methodName.indexOf("get") == -1) {// 不是get方法
					continue;// 不处理
				}

				Object rsValue = null;
				try {

					// 调用get方法，获取返回值
					rsValue = method.invoke(info);

					if (rsValue == null) {// 没有返回值
						continue;
					}

				} catch (Exception e) {
					continue;
				}

				// 将值加入内容中
				rs.append("(" + methodName + " : " + rsValue + ")");
			}

			rs.append("]");

			index++;
		}

		return rs.toString();
	}

	/**
	 * 获取注解中对方法的描述信息 用于service层注解
	 * 
	 * @param joinPoint
	 *            切点
	 * @return 方法描述
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public static String getServiceMthodDescription(JoinPoint joinPoint)
			throws Exception {
		String targetName = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		Object[] arguments = joinPoint.getArgs();
		Class targetClass = Class.forName(targetName);
		Method[] methods = targetClass.getMethods();
		String description = "";
		for (Method method : methods) {
			if (method.getName().equals(methodName)) {
				Class[] clazzs = method.getParameterTypes();
				if (clazzs.length == arguments.length) {
					description = method.getAnnotation(SystemServiceLog.class)
							.description();
					break;
				}
			}
		}
		return description;
	}

	@Override
	public int getOrder() {
		
		return 1;
	}
}
