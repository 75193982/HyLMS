package com.jshpsoft.exception;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.support.json.JSONUtils;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.MailUtils;
import com.jshpsoft.util.SystemUtil;

/**
 * 系统异常处理类
 * 
 */
public class MyExceptionHandler implements HandlerExceptionResolver {

	public static final Logger logger = Logger.getLogger(MyExceptionHandler.class);
	
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,  
            Exception e) {  
        
		String operateName = "统一异常信息处理";
        String exceptionMsg = CommonUtil.createExceptionMsg("【统一异常处理】", SystemUtil.getInNetIp(), operateName, request.getParameterMap().toString(), request, e) ;
        
        //日志文件异常信息
        logger.error(exceptionMsg, e);
       
        //发送邮件
		MailUtils.sendMail( operateName, exceptionMsg );
    	  	
        // 判断是否ajax请求
        if (!(request.getHeader("accept").indexOf("application/json") > -1 || (request
                .getHeader("X-Requested-With") != null && request.getHeader(
                "X-Requested-With").indexOf("XMLHttpRequest") > -1))) {
            // 如果不是ajax，JSP格式返回
            // 为安全起见，只有业务异常我们对前端可见，否则否则统一归为系统异常
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("code", "300");
            if (e instanceof BusinessException) {
                map.put("msg", e.getMessage());
            } else {
                map.put("msg", "系统异常！");
            }

            //对于非ajax请求，我们都统一跳转到error.jsp页面
            return new ModelAndView("/error", map);
            
        } else {
            // 如果是ajax请求，JSON格式返回
        	 PrintWriter writer = null;
            try {
                response.setContentType("application/json;charset=UTF-8");
                writer = response.getWriter();
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("code", "300");
                // 为安全起见，只有业务异常我们对前端可见，否则统一归为系统异常
                if (e instanceof BusinessException) {
                    map.put("msg", e.getMessage());
                } else {
                    map.put("msg", "系统异常！");
                }
                writer.write(JSONUtils.toJSONString(map));
                writer.flush();
                
            } catch (IOException ex) {
                ex.printStackTrace();
                
            }finally{
            	if( null != writer ){
            		writer.close();
            	}
            }
        }
        
        return null;
    }  
    
}  