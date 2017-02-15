package com.jshpsoft.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.URL;
import java.net.UnknownHostException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;


/**
 * 获取IP地址
 *
 */
public class AddressIP {

	private static String WEBURL = "http://www.ip138.com/ip2city.asp";

 /**
  * @param args
 * @throws Exception 
  */
 public static void main(String[] args) throws Exception {
  System.out.println("本机的外网IP是："+AddressIP.getWebIP());
  System.out.println("本机的内网IP是："+AddressIP.getLocalIP());
  System.out.println("mac:"+getMacAddress("58.241.208.171"));
 }

 

 /**
  * 获取外网地址
  * @param strUrl
  * @return
  */
 public static String getWebIP() {
	 try {
	 //连接网页
	  URL url = new URL(WEBURL);
	  BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
	  String s = "";
	  StringBuffer sb = new StringBuffer(""); 
	  String webContent = "";
	  //读取网页信息
	  while ((s = br.readLine()) != null) {
	  sb.append(s + "\r\n");
	  }
	  br.close();
	  //网页信息
	  webContent = sb.toString();
	  int start = webContent.indexOf("[")+1;
	  int end = webContent.indexOf("]");
	  //获取网页中  当前 的 外网IP
	  webContent = webContent.substring(start,end);
	  return webContent;
	
	 } catch (Exception e) {
	  e.printStackTrace();
	  return "error open url:" + WEBURL;
	 }
}
 /**
  * 获取当前本机的IP
  * @return
  * @throws Exception
  */
  public static String getLocalIP() throws Exception{
	  String localIP = "";
	  InetAddress addr = (InetAddress) InetAddress.getLocalHost();
	  //获取本机IP
	  localIP = addr.getHostAddress().toString();
	  return localIP;
  }
  
  /**
	 * 获取当前网络ip
	 * @param request
	 * @return
	 */
	public static String getIpAddr(HttpServletRequest request){
		String ipAddress = request.getHeader("x-forwarded-for");
			if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getHeader("Proxy-Client-IP");
			}
			if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getHeader("WL-Proxy-Client-IP");
			}
			if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getRemoteAddr();
				if(ipAddress.equals("127.0.0.1") || ipAddress.equals("0:0:0:0:0:0:0:1")){
					//根据网卡取本机配置的IP
					InetAddress inet=null;
					try {
						inet = InetAddress.getLocalHost();
					} catch (UnknownHostException e) {
						e.printStackTrace();
					}
					ipAddress= inet.getHostAddress();
				}
			}
			//对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
			if(ipAddress!=null && ipAddress.length()>15){ //"***.***.***.***".length() = 15
				if(ipAddress.indexOf(",")>0){
					ipAddress = ipAddress.substring(0,ipAddress.indexOf(","));
				}
			}
			return ipAddress; 
	}
  
  
  /******************************MAC 地址有关的*******************************/
  public static String callCmd(String[] cmd) {
	  String result = "";
	  String line = "";
	    try {
	        Process proc = Runtime.getRuntime().exec(cmd);
	        InputStreamReader is = new InputStreamReader(proc.getInputStream());
	        BufferedReader br = new BufferedReader (is);
	        while ((line = br.readLine ()) != null) {
	             result += line;
	        }
	   }catch(Exception e) {
	        e.printStackTrace();
	   }
	      return result;
	}
	/**
	 *
	 *
	 *
	 * @param cmd
	 *            第一个命令
	 *
	 * @param another
	 *            第二个命令
	 *
	 * @return 第二个命令的执行结果
	 *
	 */

	public static String callCmd(String[] cmd,String[] another) {
	   String result = "";
	   String line = "";
	   try {
	      Runtime rt = Runtime.getRuntime();
	      Process proc = rt.exec(cmd);
	      proc.waitFor(); // 已经执行完第一个命令，准备执行第二个命令
	      proc = rt.exec(another);
	      InputStreamReader is = new InputStreamReader(proc.getInputStream());
	      BufferedReader br = new BufferedReader (is);
	      while ((line = br.readLine ()) != null) {
	         result += line;
	      }
	   }catch(Exception e) {
	        e.printStackTrace();
	   }
	      return result;
	}

	/**
	 *
	 * @param ip
	 *            目标ip,一般在局域网内
	 *
	 * @param sourceString
	 *            命令处理的结果字符串
	 *
	 * @param macSeparator
	 *            mac分隔符号
	 *
	 * @return mac地址，用上面的分隔符号表示
	 *
	 */

	public static String filterMacAddress(final String ip, final String sourceString,final String macSeparator) {
	   String result = "";
	   String regExp = "((([0-9,A-F,a-f]{1,2}" + macSeparator + "){1,5})[0-9,A-F,a-f]{1,2})";
	   Pattern pattern = Pattern.compile(regExp);
	   Matcher matcher = pattern.matcher(sourceString);
	   while(matcher.find()){
	     result = matcher.group(1);
	     if(sourceString.indexOf(ip) <= sourceString.lastIndexOf(matcher.group(1))) {
	        break; // 如果有多个IP,只匹配本IP对应的Mac.
	     }
	   }
	    return result;
	}

	/**
	 * @param ip
	 *            目标ip
	 * @return Mac Address
	 */
	public static String getMacInWindows(final String ip){
	   String result = "";
	   String[] cmd = {"cmd","/c","ping " + ip};
	   String[] another = {"cmd","/c","arp -a"};
	   String cmdResult = callCmd(cmd,another);
	   result = filterMacAddress(ip,cmdResult,"-");
	   return result;
	}
	 /**
	  * @param ip
	  *            目标ip
	  * @return Mac Address
	  */
	 public static String getMacInLinux(final String ip){ 
	     String result = ""; 
	     String[] cmd = {"/bin/sh","-c","ping " +  ip + " -c 2 && arp -a" }; 
	     String cmdResult = callCmd(cmd); 
	     result = filterMacAddress(ip,cmdResult,":"); 
	     return result; 
	 } 

	 /**
	  * 获取MAC地址
	  *
	  * @return 返回MAC地址
	  */
	 public static String getMacAddress(String ip){
	     String macAddress = "";
	     macAddress = getMacInWindows(ip).trim();
	     if(macAddress==null||"".equals(macAddress)){
	         macAddress = getMacInLinux(ip).trim();
	     }
	     return macAddress;
	 }
  
	 
}