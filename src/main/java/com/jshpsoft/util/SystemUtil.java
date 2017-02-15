package com.jshpsoft.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.URL;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

public class SystemUtil {
	private static String WEBURL = "http://www.ip138.com/ip2city.asp";

	/**
	 * 
	 * @Description: 得到计算机的内网ip地址
	 * @author army.liu 
	 * @param @return    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public static String getInNetIp() {
		String ip = "";
		try {
			InetAddress address = InetAddress.getLocalHost();
			ip = address.getHostAddress();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return ip;
	}

	/**
	 * 
	 * @Description: 获取计算机的外网ip地址
	 * @author army.liu 
	 * @param @return    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public static String getOutNetIp() {
		try {
			// 连接网页
			URL url = new URL(WEBURL);
			BufferedReader br = new BufferedReader(new InputStreamReader(
					url.openStream()));
			String s = "";
			StringBuffer sb = new StringBuffer("");
			String webContent = "";
			// 读取网页信息
			while ((s = br.readLine()) != null) {
				sb.append(s + "\r\n");
			}
			br.close();
			// 网页信息
			webContent = sb.toString();
			int start = webContent.indexOf("[") + 1;
			int end = webContent.indexOf("]");
			// 获取网页中 当前 的 外网IP
			webContent = webContent.substring(start, end);
			return webContent;

		} catch (Exception e) {
			e.printStackTrace();
			return "error open url:" + WEBURL;
		}
	}

	/**
	 * 
	 * @Description: 得到计算机的mac地址
	 * @author army.liu 
	 * @param @return    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	@SuppressWarnings("resource")
	public static String getMac() {
		String mac = "";
		try {
			InetAddress address = InetAddress.getLocalHost();
			NetworkInterface ni = NetworkInterface.getByInetAddress(address);
			byte[] macArr = ni.getHardwareAddress();
			Formatter formatter = new Formatter();
			for (int i = 0; i < macArr.length; i++) {
				mac = formatter.format(Locale.getDefault(), "%02X%s",
						macArr[i], (i < macArr.length - 1) ? "-" : "")
						.toString();

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mac;
	}

	/**
	 * 
	 * @Description: 得到计算机的系统信息
	 * @author army.liu 
	 * @param @return    设定文件
	 * @return Map<String,Object>    返回类型
	 * @throws
	 * @see
	 */
	public static Map<String, Object> getPcConfigInfo() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			InetAddress addr = InetAddress.getLocalHost();
			String hostName = addr.getHostName().toString(); // 获取本机计算机名称
			Properties props = System.getProperties();
			String osName = props.getProperty("os.name");// 操作系统的名称
			String osVersion = props.getProperty("os.version");// 操作系统的版本
			String osArch = props.getProperty("os.arch");// 操作系统的构架

			Map<String, String> map = System.getenv();
			String userName = map.get("USERNAME");// 获取用户名
			String pcName = map.get("COMPUTERNAME");// 获取计算机名
			String domainName = map.get("USERDOMAIN");// 获取计算机域名

			result.put("hostName", hostName);
			result.put("osName", osName);
			result.put("osVersion", osVersion);
			result.put("osArch", osArch);
			result.put("userName", userName);
			result.put("pcName", pcName);
			result.put("domainName", domainName);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 
	 * @Description: 得到java环境信息
	 * @author army.liu 
	 * @param @return    设定文件
	 * @return Map<String,Object>    返回类型
	 * @throws
	 * @see
	 */
	public static Map<String, Object> getJavaConfigInfo() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Properties props = System.getProperties();
			String javaVersion = props.getProperty("java.version");// Java的运行环境版本
			String javaHome = props.getProperty("java.home");// Java的安装路径
			String javaClassVersion = props.getProperty("java.class.version");// Java的类格式版本号
			String userHome = props.getProperty("user.home");// 用户的主目录
			String userDir = props.getProperty("user.dir");// 用户的当前工作目录

			result.put("javaHome", javaHome);
			result.put("javaVersion", javaVersion);
			result.put("javaClassVersion", javaClassVersion);
			result.put("userHome", userHome);
			result.put("userDir", userDir);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static void main(String[] args) {
		System.out.println(Integer.parseInt("0002147483647"));
		System.out.println( getInNetIp() );
		System.out.println( getOutNetIp() );
		System.out.println( getMac() );
		System.out.println( getPcConfigInfo() );
		System.out.println( getJavaConfigInfo() );
	}
}
