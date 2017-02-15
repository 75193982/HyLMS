package com.jshpsoft.util;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;

import com.jshpsoft.domain.CarShop;
import com.jshpsoft.domain.Contract;
import com.jshpsoft.domain.OtherContacts;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.TrackInsurance;
import com.jshpsoft.domain.User;

/**
 * 公用工具类
 */
public abstract  class CommonUtil {
	
//	private static ResourceBundle bundle = PropertyResourceBundle.getBundle("conf");

	/**
	 * session中存储用户的标识
	 */
	public static final String SESSION_USER_FLAG = "LMS_USER";
	
	/**
	 * app的token标识
	 */
	public static final String TOKEN = "token";
	
	/**
	  * 获取当前系统时间的年月
	  * 
	  * @Description: 获取当前系统时间的年月，格式yyyyMM
	  * @author army.liu
	  * @date 2016年4月5日 上午11:05:19
	 */
	public static String getCurrYearMonth() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		return sdf.format(new Date());
		
	}
	
	/**
	 * 获取当前系统时间的年月日
	* @author  fengql 
	* @date 2016年9月29日 下午3:42:18 
	* @parameter  
	* @return
	 */
	public static String getCurrYearMonthDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return sdf.format(new Date());
		
	}
	
	/**
	  * 获取自定义格式的时间转字符串
	  * @Description: 获取当前系统时间的年月，格式 自定义
	  * @author lvhao
	  * @date 2016年7月14日 上午10:05:19
	 */
	public static String getCustomDateToString(Date date ,String format) {
		
		SimpleDateFormat sdf = new SimpleDateFormat( format );
		
		return sdf.format( date );
		
	}
	
	/**
	  * 转化字符串为日期
	  * 
	  * @Description: 转化字符串为日期
	  * @author army.liu
	  * @date 2016年4月5日 上午11:05:19
	 */
	public static Date parseStringToDate(String formatStr, String startTime) {
		if( StringUtils.isNotEmpty(formatStr) && StringUtils.isNotEmpty(startTime) ){
			SimpleDateFormat sdf = new SimpleDateFormat(formatStr);
			try {
				return sdf.parse(startTime);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
		}
		
		return null;
	}

	/**
	  * 将日期按照指定格式转化为没有时分秒
	  * 
	  * @Description: 方法功能描述
	  * @author army.liu
	  * @date 2016年4月21日 上午9:41:34
	 */
	public static Date parseDateToDate(String formatStr, Date date) {
		if( StringUtils.isNotEmpty(formatStr)  && null != date ){
			SimpleDateFormat sdf = new SimpleDateFormat(formatStr);
			SimpleDateFormat sdf2 = new SimpleDateFormat(formatStr+" HH:mm:ss");
			try {
				String format = sdf.format(date);
				return sdf2.parse( format+" 00:00:00" );
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
		}
		return null;
	}

	/**
	 * 保存信息到session
	 * @param string
	 * @param i
	 */
	public static void addAttributeToSession(HttpServletRequest request, String name, String i) {
		request.getSession().setAttribute(name, i);
		
	}

	/**
	 * long 类型时间 转 String
	 * @date 2016年7月12日 上午11:05:19
	 * @author lvhao
	 * @param date
	 * @return
	 */
	public static String longDateToString(long date ,String  DATE_TIME_FORMAT){
		
		SimpleDateFormat sdf = new SimpleDateFormat( DATE_TIME_FORMAT );

	  
	    return sdf.format(new Date(date));
	}
	
	/**
	 * 把不足4位整数前面补0 满足4位或以上 原数据返回
	 * @author lvhao
	 * @date 2016年7月15日 上午9:05:19
	 * @param i
	 * @return
	 */
	public static String completeToString(Integer i){

			DecimalFormat df=new DecimalFormat("0000");
		    String format = df.format(i);
		    
		    return format;
		    
	}
	
	/**
	 * 获取住院号/登记号--登记时间 前8位+登记流水号4位补全
	* @author  fengql 
	* @date 2016年8月1日 下午1:54:12 
	* @parameter  
	* @return
	 */
	public static String getRegisterNo(Date registerTime, int serialNo){

		SimpleDateFormat sdf = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_CUSTOM_1);
		DecimalFormat df=new DecimalFormat("0000");
	    String registerNo = sdf.format(registerTime)+ df.format(serialNo);
	    
	    return registerNo;	    
	}
	
//	/**
//	 * 获取系统的住院流水号：
//	 * 	格式： yyyyMMddHHmmss+流水号
//	 * 
//	 * @param time 患者挂号时间
//	 * @param serialno 流水号
//	 * @return
//	 */
//	public static String getInhosNo(Date regtime,String serialno){
//		String inhosNo = "";
//		try {
//			SimpleDateFormat df = new SimpleDateFormat( "yyyyMMddHHmmss" );  
//			String timeStr = df.format( regtime );//
//			inhosNo = timeStr + serialno;//住院号
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		return inhosNo;
//	}

	/**
	 * 计算相差天数
	 * @param registerTime
	 * @param outhosTime
	 * @return
	 */
	public static int getDays(Date startTime, Date endTime) {
		Calendar startCal = GregorianCalendar.getInstance();
		Calendar endCal = GregorianCalendar.getInstance();
		startCal.setTime(startTime);
		endCal.setTime(endTime);
		long time1 = startCal.getTimeInMillis();
		long time2 = endCal.getTimeInMillis();
		long between_days = (time2 - time1) / (1000 * 3600 * 24);
		return Integer.parseInt(String.valueOf(between_days));
	}
	
	/**
	 * 用户登录时，将用户存入session
	 * @param dictEmployee
	 */
	public static void addUserToSession(HttpServletRequest request, User user) {
		request.getSession().setAttribute(SESSION_USER_FLAG, user);
		
	}

	/**
	 * 用户退出时，清除session
	 * @param request
	 */
	public static void removeUserFromSession(HttpServletRequest request) {
		request.getSession().removeAttribute(SESSION_USER_FLAG);
	}
	
	/**
	  * 获取session中用户名称
	  * 
	  * @Description: 在用户登录时，将用户以user存入session
	  * @author army.liu
	  * @date 2016年4月5日 上午11:05:19
	 */
	public static String getUserNameFromSession(HttpServletRequest request) {
		if( null != request.getSession().getAttribute(SESSION_USER_FLAG) ){
			User user = (User)request.getSession().getAttribute(SESSION_USER_FLAG);
			if( null != user ){
				return user.getName();
			}
			
		}
		return null;
	}
	
	/**
	 * 获取session中用户id--唯一id
	 * @author  army.liu 
	 * @date 2016年8月29日 下午3:46:57 
	 * @parameter  
	 * @return
	 */
	public static int getUserIdFromSession(HttpSession session) {
		if( null != session.getAttribute(SESSION_USER_FLAG) ){
			User user = (User)session.getAttribute(SESSION_USER_FLAG);
			if( null != user ){
				return user.getId();
			}
			
		}
		return 0;
	}
	
	/**
	 * 获取操作者id
	* @author  fengql 
	* @date 2016年10月12日 下午4:11:47 
	* @parameter  
	* @return
	 */
	public static String getOperId(HttpServletRequest request) {
		int operId=getUserIdFromSession(request);
		return String.valueOf(operId);
	}
	
	
	/**
	 * 获取session中用户id--唯一id
	* @author  fengql 
	* @date 2016年8月29日 下午3:46:57 
	* @parameter  
	* @return
	 */
	public static int getUserIdFromSession(HttpServletRequest request) {
		if( null != request.getSession().getAttribute(SESSION_USER_FLAG) ){
			User user = (User)request.getSession().getAttribute(SESSION_USER_FLAG);
			if( null != user ){
				return user.getId();
			}
			
		}
		return 0;
	}
	

	/**
	 * 二手车生成运单号
	 * @return
	 */
	
	public static String getWaybillNo(){

		SimpleDateFormat sdf = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_CUSTOM_3);
		
	    String waybillNo = sdf.format(new Date());
	    
	    return waybillNo;	    
	}
	
	/**
	 * 折损车生成运单号
	 * @return
	 */
	
	public static String getWaybillNo_ZS(){

		SimpleDateFormat sdf = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_CUSTOM_3);
		
	    String waybillNo = "ZS"+sdf.format(new Date());
	    
	    return waybillNo;	    
	}
	
	/**
	 * 预付生成申请单号
	 * @return
	 */
	
	public static String getCostApplyNo_YF(){

		SimpleDateFormat sdf = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_CUSTOM_1);
		
	    String waybillNo = "YF"+sdf.format(new Date());
	    
	    return waybillNo;	    
	}
	
	/**
	 * 年月日
	 * @return
	 */
	public static String getYearMonthDayNo(){

		SimpleDateFormat sdf = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_CUSTOM_1);
		
	    String waybillNo = sdf.format(new Date());
	    
	    return waybillNo;	    
	}
	
	/**
	 * 获取session中的用户仓库编号
	* @author  fengql 
	* @date 2016年9月28日 下午1:31:41 
	* @parameter  
	* @return
	 */
	public static String getStockIdFromSession(HttpServletRequest request) {
		if( null != request.getSession().getAttribute(SESSION_USER_FLAG) ){
			User user = (User)request.getSession().getAttribute(SESSION_USER_FLAG);
			if( null != user ){
				return user.getStockId();
			}
			
		}
		return null;
	}

	/**
	 * 生成手机端的token
	 * @param mobile
	 * @return
	 */
	public static String createToken(String mobile) {
//		String dataStr = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		String dataStr = "20161114";
		return DigestUtils.md5Hex( mobile + dataStr );
		
	}

	/**
	 * 日期格式化
	 * @param date
	 * @param string
	 * @return
	 */
	public static String format(Date date, String formatStr) {
		return new SimpleDateFormat(formatStr).format( date );
	}

	/**
	 * 生成异常信息
	 * @param accessIp
	 * @param operateName
	 * @param operateContent
	 * @param request
	 * @param ex
	 * @return
	 */
	public static String createExceptionMsg(String noticeType, String accessIp,
			String operateName, String operateContent,
			HttpServletRequest request, Exception ex) {
		StringWriter sw=new StringWriter();  
        PrintWriter pw=new PrintWriter(sw);  
        ex.printStackTrace(pw);
        
		return "**************************异常信息**************************"
        		+"\r\n******************************"
        		+"\r\n*******noticeType:" + noticeType
        		+"\r\n*******access_ip:" + accessIp
        		+"\r\n*******access_date:" + CommonUtil.format( new Date(), "yyyy-MM-dd HH:mm:ss")
        		+"\r\n*******operate:" + operateName
        		+"\r\n*******requeset_url:" + request.getRequestURL()
        		+"\r\n*******requeset_method:" + request.getMethod()
        		+"\r\n*******requeset_content:" +  operateContent
        		+"\r\n*******exception_message:" + ex.getMessage()
        		+"\r\n*******exception_detail:" + sw.toString()
        		+"\r\n******************************";
	}
	
	/**
	 * 生成异常信息
	 * @param accessIp
	 * @param operateName
	 * @param operateContent
	 * @param request
	 * @param ex
	 * @return
	 */
	public static String createExceptionMsgForShort(
			String operateName, Exception ex) {
		StringWriter sw=new StringWriter();  
		PrintWriter pw=new PrintWriter(sw);  
		ex.printStackTrace(pw);
		
		return "**************************异常信息**************************"
		+"\r\n******************************"
		+"\r\n*******access_date:" + CommonUtil.format( new Date(), "yyyy-MM-dd HH:mm:ss")
		+"\r\n*******operate:" + operateName
		+"\r\n*******exception_message:" + ex.getMessage()
		+"\r\n*******exception_detail:" + sw.toString()
		+"\r\n******************************";
	}

	/**
	 * 
	 * @Description: 生成流程名称
	 * @author army.liu 
	 * @param @param yd
	 * @param @param string
	 * @param @return    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public static String getProcessName(String type, String string) {
		if( null == string ){
			string = "";
		}
		String name = "";
		if( Constants.ProcessType.YD.equals(type) ){//运单
			name = "【运单】"+string;
			
		}else if( Constants.ProcessType.DDD.equals(type) ){//调度单
			name = "【调度单】"+string;
			
		}else if( Constants.ProcessType.HCSQD.equals(type) ){//换车申请单
			name = "【换车申请单】"+string;
			
		}else if( Constants.ProcessType.ZYYFSQD.equals(type) ){//装运预付申请单
			name = "【装运预付申请单】"+string;
			
		}else if( Constants.ProcessType.ZYFYHSSQD.equals(type) ){//装运费用核算申请单
			name = "【装运费用核算申请单】"+string;
			
		}else if( Constants.ProcessType.LTCRKSQD.equals(type) ){//轮胎出入库申请单
			name = "【轮胎出入库申请单】"+string;
			
		}else if( Constants.ProcessType.WXBYSQD.equals(type) ){//维修保养申请单
			name = "【维修保养申请单】"+string;
			
		}else if( Constants.ProcessType.LTGHSQD.equals(type) ){//轮胎更换申请单
			name = "【轮胎更换申请单】"+string;
			
		}else if( Constants.ProcessType.ZSFKSQD.equals(type) ){//折损反馈申请单
			name = "【折损反馈申请单】"+string;
			
		}else if( Constants.ProcessType.ZSFYSQD.equals(type) ){//折损费用申请单
			name = "【折损费用申请单】"+string;
			
		}else if( Constants.ProcessType.ZSCRKSQD.equals(type) ){//折损出入库申请单
			name = "【折损出入库申请单】"+string;
			
		}else if( Constants.ProcessType.PCZLSQD.equals(type) ){//折损出入库申请单
			name = "【派车指令】"+string;
			
		}else if( Constants.ProcessType.FYSQD.equals(type) ){//费用申请单
			name = "【预付费用申请】"+string;
			
		}else if( Constants.ProcessType.HXFYSQD.equals(type) ){//核销费用申请单
			name = "【核销费用申请】"+string;
			
		}else if( Constants.ProcessType.DDXGSQD.equals(type) ){//调度修改申请单
			name = "【调度修改申请】"+string;
			
		}else if( Constants.ProcessType.LTCGSQD.equals(type) ){//轮胎采购申请单
			name = "【轮胎采购申请】"+string;
			
		}
		return name;
	}

	/**
	 * 
	 * @Description: 获取上传文件存储的临时目录
	 * @author army.liu 
	 * @param @param type
	 * @param @return    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public static String getStorePathForTempFile(String uploadType) {
		String subPath = "common";//默认地址
		if( StringUtils.isNotEmpty( uploadType ) && StringUtils.isNotEmpty( uploadType.trim() ) ){
			subPath = uploadType.trim();
		}
		
		return Constants.UPLOAD_DIR_FOR_TEMP + subPath;
	}

	/**
	 * 
	 * @Description: 获取临时文件重新存储的目录地址
	 * @author army.liu 
	 * @param uploadType
	 * @param 设定文件
	 * @return String  返回类型
	 * @throws
	 * @see
	 */
	public static String getStorePathForNormal(String uploadType) {
		String subPath = "common";//默认地址
		if( StringUtils.isNotEmpty( uploadType ) && StringUtils.isNotEmpty( uploadType.trim() ) ){
			subPath = uploadType.trim();
		}
		
		return Constants.UPLOAD_DIR_FOR_NORMAL + subPath;
	}

	/**
	 * 
	 * @Description: 生成生日提醒的推送消息格式【供应商】
	 * @author army.liu 
	 * @param @param supplier
	 * @param @return    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public static String createPushMsgForBirthday(Supplier bean) {
		
		return "生日提醒：" + bean.getName() + "的" + bean.getLinkUser() + "生日即将来临。"+
		 "[手机号码-"+bean.getLinkMobile()+"，生日-"+CommonUtil.format(bean.getBrithday(), "yyyy年MM月dd日")+"]";
	}
	
	/**
	 * 
	 * @Description: 生成生日提醒的推送消息格式【4S店】
	 * @author army.liu 
	 * @param @param supplier
	 * @param @return    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public static String createPushMsgForBirthday(CarShop bean) {
		
		return "生日提醒：" + bean.getName() + "的" + bean.getLinkUser() + "生日即将来临。"+
				"[手机号码-"+bean.getLinkMobile()+"，生日-"+CommonUtil.format(bean.getBrithday(), "yyyy年MM月dd日")+"]";
	}

	/**
	 * 
	 * @Description: 生成保单失效提醒的推送消息格式
	 * @author army.liu 
	 * @param @param supplier
	 * @param @return    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public static String createPushMsgForInsurance(TrackInsurance bean) {
		return "保单即将到期提醒：" + bean.getCarNumber() + "车辆的保单有效期至" + CommonUtil.format(bean.getEndTime(), "yyyy年MM月dd日") + "。请及时续保。";
	}
	public static String createPushMsgForInsuranceDeadline(TrackInsurance bean) {
		return "保单到期提醒：" + bean.getCarNumber() + "车辆的保单有效期至今天[" + CommonUtil.format(bean.getEndTime(), "yyyy年MM月dd日") + "]。";
	}

	/**
	 * 
	 * @Description: 生成合同失效提醒的推送消息格式
	 * @author army.liu 
	 * @param @param supplier
	 * @param @return    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public static String createPushMsgForContract(Contract bean) {
		return "合同即将到期提醒：编号" + bean.getCode() + "的合同有效期至" + CommonUtil.format(bean.getEndTime(), "yyyy年MM月dd日") + "。请及时处理。";
	}
	public static String createPushMsgForContractDeadline(Contract bean) {
		return "合同到期提醒：编号" + bean.getCode() + "的合同有效期至今天[" + CommonUtil.format(bean.getEndTime(), "yyyy年MM月dd日") + "]。";
	}
	public static String createPushMsgForOtherContacts(OtherContacts bean) {
		return "其他往来到期提醒：事由" + bean.getName() + "。";
	}
	
	/**
	 * 得到首字母
	 * @author  ww 
	 * @date 2016年11月14日 下午5:20:59
	 * @parameter  
	 * @return
	 */
	private static char getPYIndexChar(char strChinese, boolean bUpCase) {
        int charGBK = strChinese;
        char result;
        if (charGBK >= 45217 && charGBK <= 45252)
            result = 'A';
        else if (charGBK >= 45253 && charGBK <= 45760)
            result = 'B';
        else if (charGBK >= 45761 && charGBK <= 46317)
            result = 'C';
        else if (charGBK >= 46318 && charGBK <= 46825)
            result = 'D';
        else if (charGBK >= 46826 && charGBK <= 47009)
            result = 'E';
        else if (charGBK >= 47010 && charGBK <= 47296)
            result = 'F';
        else if (charGBK >= 47297 && charGBK <= 47613)
            result = 'G';
        else if (charGBK >= 47614 && charGBK <= 48118)
            result = 'H';
        else if (charGBK >= 48119 && charGBK <= 49061)
            result = 'J';
        else if (charGBK >= 49062 && charGBK <= 49323)
            result = 'K';
        else if (charGBK >= 49324 && charGBK <= 49895)
            result = 'L';
        else if (charGBK >= 49896 && charGBK <= 50370)
            result = 'M';
        else if (charGBK >= 50371 && charGBK <= 50613)
            result = 'N';
        else if (charGBK >= 50614 && charGBK <= 50621)
            result = 'O';
        else if (charGBK >= 50622 && charGBK <= 50905)
            result = 'P';
        else if (charGBK >= 50906 && charGBK <= 51386)
            result = 'Q';
        else if (charGBK >= 51387 && charGBK <= 51445)
            result = 'R';
        else if (charGBK >= 51446 && charGBK <= 52217)
            result = 'S';
        else if (charGBK >= 52218 && charGBK <= 52697)
            result = 'T';
        else if (charGBK >= 52698 && charGBK <= 52979)
            result = 'W';
        else if (charGBK >= 52980 && charGBK <= 53688)
            result = 'X';
        else if (charGBK >= 53689 && charGBK <= 54480)
            result = 'Y';
        else if (charGBK >= 54481 && charGBK <= 55289)
            result = 'Z';
        else
            result = (char) (65 + (new Random()).nextInt(25));
        if (!bUpCase)
            result = Character.toLowerCase(result);
        return result;
    }
	
	/**
	 * 返回首字母
	 * @author  ww 
	 * @date 2016年11月14日 下午5:21:58
	 * @parameter strChinese--中文汉字, bUpCase--是否大小写
	 * @return
	 */
	public static String getPYIndexStr(String strChinese, boolean bUpCase) {

        try {
            StringBuffer buffer = new StringBuffer();
            byte b[] = strChinese.getBytes("GBK");// 把中文转化成byte数组
            for (int i = 0; i < b.length; i++) {
                if ((b[i] & 255) > 128) {
                    int char1 = b[i++] & 255;
                    char1 <<= 8;// 左移运算符用“<<”表示，是将运算符左边的对象，向左移动运算符右边指定的位数，并且在低位补零。其实，向左移n位，就相当于乘上2的n次方
                    int chart = char1 + (b[i] & 255);
                    buffer.append(getPYIndexChar((char) chart, bUpCase));
                    continue;
                }
                char c = (char) b[i];
                if (!Character.isJavaIdentifierPart(c))// 确定指定字符是否可以是 Java
                                                        // 标识符中首字符以外的部分。
                    c = 'A';
                buffer.append(c);

            }

            return buffer.toString();

        } catch (Exception e) {
            System.out.println((new StringBuilder())
                    .append("\u53D6\u4E2D\u6587\u62FC\u97F3\u6709\u9519")
                    .append(e.getMessage()).toString());
        }
        return null;
    }

	/**
	 * @Description: 精确到两位小数
	 * @author army.liu 
	 * @param @param doubleValue
	 * @param @return    设定文件
	 * @return double    返回类型
	 * @throws
	 * @see
	 */
	public static double formatDouble(double orgin) {
		DecimalFormat df=new DecimalFormat(".##");
		String st=df.format(orgin);
		return Double.parseDouble(st);
	}

	/**
	 * @Description: 生成下月时间
	 * @author army.liu 
	 * @param @param date
	 * @param @return    设定文件
	 * @return Object    返回类型
	 * @throws
	 * @see
	 */
	public static Date getNextYearMonthTime(Date date) {
		Calendar instance = Calendar.getInstance();
		instance.setTime(date);
		instance.set(Calendar.MONTH, instance.get(Calendar.MONTH)+1);
		return instance.getTime();
	}
	/**
	 * @Description: 生成上月时间
	 * @author army.liu 
	 * @param @param date
	 * @param @return    设定文件
	 * @return Object    返回类型
	 * @throws
	 * @see
	 */
	public static Date getLastYearMonthTime(Date date) {
		Calendar instance = Calendar.getInstance();
		instance.setTime(date);
		instance.set(Calendar.MONTH, instance.get(Calendar.MONTH)-1);
		return instance.getTime();
	}

	public static int compareTime(Date date, Date sendTime) {
		Date todayTime = CommonUtil.parseDateToDate(Constants.DATE_TIME_FORMAT_SHORT, new Date());
		Date sendTimeShort = CommonUtil.parseDateToDate(Constants.DATE_TIME_FORMAT_SHORT, sendTime);
		if( todayTime.getTime() > sendTimeShort.getTime() ){
			return 1;//比当天早
		}else if( todayTime.getTime() == sendTimeShort.getTime() ){
			return 0;//同一天
		}
		
		return -1;//比当天晚
	}
	
}
