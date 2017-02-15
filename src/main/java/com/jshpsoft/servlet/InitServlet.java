
package com.jshpsoft.servlet;  

import java.io.IOException;  

import javax.servlet.ServletConfig;  
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;  

import com.jshpsoft.util.Constants;

/** 
 * 类型解释：Spring启动完成后执行初始化操作 
 * 类型表述：
 * @author  
 * @version  
 * 
 */  
@Component("initServlet")  
public class InitServlet extends HttpServlet {  
    private static final long serialVersionUID = 1L;  
     
    private Logger logger = Logger.getLogger(InitServlet.class);

    /** 
     * @see HttpServlet#HttpServlet() 
     */  
    public InitServlet() {  
        super();  
    }  

    /** 
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response) 
     */  
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
          
    }  

    /** 
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response) 
     */  
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
        // TODO Auto-generated method stub  
    }  

    @Override  
    public void init(ServletConfig config) throws ServletException {  
       logger.error("***************************servlet init***************************");
       config.getServletContext().setAttribute("ctx", Constants.CTX);
       logger.error("servletContenxt.ctx="+Constants.CTX);
    }  

}  
