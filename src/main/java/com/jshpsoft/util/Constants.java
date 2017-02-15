package com.jshpsoft.util;

/**
 * 公共常量类
 * 
 * @Description: 
 * @author army.liu
 */
public abstract class Constants {
	// 分页默认大小
	public static int PAGESIZE = 10;
	
	//
	public static String CTX = "";
	public static String PUSH_APPKEY = "";
	public static String PUSH_SECRET = "";
	
	//
	public static String TOKEN = "token";

	// 默认时间格式
	public static final String DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
	// 默认时间简写格式
	public static final String DATE_TIME_FORMAT_SHORT = "yyyy-MM-dd";
	// 自定义时间格式
	public static final String DATE_TIME_FORMAT_CUSTOM_1 = "yyyyMMdd";
	public static final String DATE_TIME_FORMAT_CUSTOM_2 = "yyyy年MM月";
	public static final String DATE_TIME_FORMAT_CUSTOM_3 = "yyyyMMddHHmmss";
	public static final String DATE_TIME_FORMAT_CUSTOM_4 = "MM/dd";
	public static final String DATE_TIME_FORMAT_CUSTOM_5 = "yyyy-MM";
	public static final String DATE_TIME_FORMAT_CUSTOM_6 = "yyyy年MM月dd日";

	//websocket
	public static final String WEBSOCKET_USER = "LMS_USER";
	public static final String FORCE_LOGIN_OUT = "FORCE_LOGIN_OUT";
	
	//上传文件临时目录
	public static final String UPLOAD_DIR_FOR_TEMP = "/uploadFile/temp/";
	//上传文件正式目录
	public static final String UPLOAD_DIR_FOR_NORMAL = "/uploadFile/normal/";

	//分隔符
	public class SplitStr {
		public static final String UploadFileName = ";";//上传文件多个连接
		public static final String CAR_DAMAGE = ";";//折损费用申请
		public static final String ScheduleBillDetailCarStockIds = ",";//
	}
	
	//上传文件的子目录
	public class UploadType {
		public static final String TASK = "task";//任务
		public static final String CONTRACT = "contract";//合同
		public static final String INSURANCE = "insurance";//保费
		public static final String APPMANAGE_AND = "android";//安卓
		public static final String APPMANAGE_IOS = "ios";//苹果
		public static final String TYRECHANGE = "tyreChange";//轮胎更换
		public static final String WAYBILL = "waybill";//运单
		public static final String IDCARD = "idcard";//身份证扫描件
		public static final String CERTIFICATE = "certificate";//从业资格证
		public static final String DRIVING = "driving";//车头行驶证
		public static final String TOPERATING = "toperating";//车头营运证
		public static final String XOPERATING = "xoperating";//车厢营运证
		public static final String CAR_DAMAGE = "cardamage";//折损费用申请的拍照
		public static final String TRANSPORTCOST = "transportcost";//装运费用核算(驾驶员报销)附件上传
		public static final String OTHERCONTACTS = "othercontacts";//其他往来
	}
	
	// 运单状态
	public enum WaibillStatus {
		//状态：0-新建，1-待复核，2-待回执，3-已完成
		NEW("0"), UNREVIEW("1"), UNRECEIPT("2"), FINISHED("3");
		private String nCode;

		private WaibillStatus(String _nCode) {
			this.nCode = _nCode;
		}

		public String getValue() {
			return nCode;
		}

	}

	public class CarStockType {
		public static final String SPC = "0";// 商品车
		public static final String ESC = "1";// 二手车
	}
	
	public class WaybillType {
		public static final String SPC = "0";// 商品车
		public static final String ESC = "1";// 二手车
		public static final String ZSC = "2";// 折损车
	}
	
	public class CarDamageCostType {
		public static final String MONEY = "0";// 赔钱
		public static final String BUY = "1";// 买断
	}

	// 删除标志
	public class DelFlag {
		public static final String Y = "Y";
		public static final String N = "N";
	}
	
	// 驾驶员标志
	public class DriverFlag {
		public static final String Y = "Y";
		public static final String N = "N";
	}
	
	//审核通过标志
	public class SuccessFlag {
		public static final String Y = "Y";
		public static final String N = "N";
	}
	
	// 已读标志
	public class ReadFlag {
		public static final String Y = "Y";//已读
		public static final String N = "N";//未读
	}
	
	// 系统标志
	public class SystemFlag {
		public static final String Y = "Y";
		public static final String N = "N";
	}


	// 配件入库类型
	public class CarAttchmentType {
		public static final String RU = "0";// 入库
		public static final String CHU = "1";// 出库
	}

	// 配件库存状态
	public class CarAttchmentStockStatus {
		public static final String NEW = "0";//新建
		public static final String HASIN = "1";//已入库
	}

	// 配件出入库状态
		public class CarAttchmentStockInOutStatus {
			public static final String NEW = "0";//新建
			public static final String UNREVIEW= "1";//待审核
			public static final String FINISH = "2";//已完成
		}
		
	//商品车/折损车状态
	public class CarStatus{
		public static final String NEW = "0";//新建
		public static final String HASIN = "1";//已入库
		public static final String HASOUT = "2";//已出库
	}

	//商品车/折损车出入库类型
	public class CarType{
		public static final String IN = "0";//入库
		public static final String OUT = "1";//出库
	}
		
	//商品车/折损车出入库状态
	public class CarInOutStatus{
		public static final String NEW = "0";//新建
		public static final String UNREVIEW= "1";//待审核
		public static final String FINISH = "2";//已完成
	}
	
	//折损车出入库状态
	public class CarDamageStockInOutStatus{
		public static final String NEW = "0";//新建
		public static final String UNREVIEW= "1";//待审核
		public static final String FINISH = "2";//已完成
	}
	
	//调度单类型
	public class ScheduleBillType{
		public static final String NORMAL = "0";//正常调度
		public static final String FAST = "1";//快速调度
	}
	
	//调度单详细中的类型
	public class ScheduleBillDetailType{
		public static final int SPC = 0;//商品车
		public static final int PJ = 1;//配件
		public static final int ESC = 2;//商品车
	}
	
	//调度单状态
	public class ScheduleBillStatus{
//		public static final String NEW = "0";//新建
//		public static final String UNREVIEW= "1";//待审核
//		public static final String UNSURE = "2";//待仓管员已确认
//		public static final String UNSURE_DRIVER = "3";//待驾驶员已确认
//		public static final String ONWAY = "4";//在途
//		public static final String FINISH = "5";//已完成
		public static final String NEW = "0";//新建
		public static final String UNSURE = "1";//待仓管员已确认
		public static final String UNSURE_DRIVER = "2";//待驾驶员已确认
		public static final String ONWAY = "3";//在途
		public static final String FINISH = "4";//已完成
	}
	
	//调度单修改申请状态
	public class ScheduleBillChangeApplyStatus{
		public static final String WAITING = "0";//待审核
		public static final String PASS = "1";//审核通过
		public static final String UNPASS = "2";//审核未通过
		public static final String FINISH = "3";//已修改
	}
	
	//调度单明细状态
	public class ScheduleDetailStatus{
		public static final String UNFINISH = "0";//未完成
		public static final String FINISH = "1";//已完成
	}
	
	//调度单明细类型
	public class ScheduleDetailType{
		public static final String SPC = "0";// 商品车
		public static final String PJ = "1";// 配件
		public static final String ESC = "2";// 二手车	
	}
	
	//商品车出库单类型
	public class CarOutStockBillType {
		public static final String SPC = "0";// 商品车
		public static final String ESC = "1";// 二手车
		public static final String ZSC = "2";// 折损车
		public static final String PJ = "3";// 配件
	}
	
	//换车变更状态
	public class TrackChangeStatus{
		public static final String NEW = "0";//新建
		public static final String UNREVIEW= "1";//待审核
		public static final String REVIEWSUCCESS = "2";//复核通过
		public static final String REVIEWFAIL = "3";//复核不通过
	}
	
	//业务流程状态
	public class ProcessStatus {
		public static final String NEW = "0";//新建
		public static final String USEING = "1";//使用中
	}
	
	//项目状态
	public class ItemStatus {
		public static final String NEW = "0";//新建
		public static final String PROCESSING = "1";//流转中
		public static final String FINISHED = "2";//已完成
	}
	
	//业务类型
	public class BusinessType {
		public static final String YD = "YD";//运单
		public static final String DDD = "DDD";//调度单
	}
	
	//项目状态
	public class ProcessType {
		public static final String YD = "01";//运单
		public static final String DDD = "02";//调度单
		public static final String HCSQD = "03";//换车申请
		public static final String ZYYFSQD = "04";//装运预付申请单
		public static final String ZYFYHSSQD = "05";//装运费用核算申请单
		public static final String LTCRKSQD = "06";//轮胎出入库申请单
		public static final String WXBYSQD = "07";//维修保养申请单
		public static final String BGFYSQD = "08";//办公费用申请单
		public static final String LTGHSQD = "09";//轮胎更换申请单
		public static final String ZSFKSQD = "10";//折损反馈申请单
		public static final String ZSFYSQD = "11";//折损费用申请单
		public static final String ZSCRKSQD = "12";//折损出入库申请单
		public static final String PCZLSQD = "13";//派车指令申请单
		public static final String FYSQD = "14";//费用申请单
		public static final String HXFYSQD = "15";//核销费用申请单
		public static final String DDXGSQD = "16";//调度修改申请
		public static final String LTCGSQD = "17";//轮胎采购申请
	}
	
	//合同状态
	public class ContractStatus {
		public static final String NEW = "0";//新建
		public static final String EFFECT = "1";//生效中
		public static final String EXPIRED = "2";//已过期
	}
	
	//流程状态-操作类型
	public class ProcessDetailOperateType {
		public static final String AUDIT = "0";//审核操作
		public static final String CONFIRM = "1";//确认操作
	}
	
	//轮胎状态
	public class TrackTyreStatus{
		public static final String NEW = "0";//新建
		public static final String HASIN= "1";//已入库
		public static final String USED = "2";//使用中
		public static final String CANCEL = "3";//已出库
		public static final String ZUOFEI = "4";//已作废
	}
	
	//轮胎更换状态
	public class TrackTyreChangeStatus{
		public static final String NEW = "0";//新建
		public static final String UNREVIEW= "1";//待审核
		public static final String FINISH = "2";//已完成
	}
	
	//轮胎出入库类型
	public class TrackTyreInOutType{
		public static final String IN = "0";//入库登记
		public static final String OUT= "1";//出库
	}
		
	//轮胎出入库状态
	public class TrackTyreInOutStatus{
		public static final String NEW = "0";//新建
		public static final String UNREVIEW= "1";//待复核
		public static final String FINISH = "2";//已完成
	}
	
	//维修保养申请状态
	public class TrackMaintStatus{
		public static final String NEW = "0";//新建
		public static final String UNREVIEW= "1";//待审核
		public static final String FINISH = "2";//已完成
	}
	
	//油卡状态
	public class OilCardStatus{
		public static final String NEW = "0";//新建
		public static final String UNUSED= "1";//未使用
		public static final String RECEIVE = "2";//已领取
	}
	//油卡状态
	public class OilCardOperateStatus{
		public static final String NEW = "0";//新建
		public static final String UNSURE= "1";//待确认
		public static final String FINISH = "2";//已完成
	}
	
	//现金收支类型
	public class CashInOutType{
		public static final String IN = "0";//收入
		public static final String OUT= "1";//支出
	}
	//现金收支类型
	public class OtherContactsType{
		public static final String IN = "0";//收入--应收款
		public static final String OUT= "1";//支出--应付款
	}
	//现金收支业务类型
	public class CashInOutBusinessType{
		public static final String CarDamageCostApply = "折损费用申请";//折损费用申请
		public static final String OilCard= "油卡";//油卡
		public static final String TransportPrepayApply= "预付申请";//预付申请
		public static final String CarDamageStockOut= "折损出库";//折损出库
		public static final String CostApply= "费用申请";//费用申请
		public static final String CostApplyReturn= "核销费用申请";//核销费用申请
		public static final String TrackInsurance="保费申请";//保费申请
		public static final String TrackTyreIn ="轮胎入库登记"; //轮胎入库登记
		public static final String TransportCost ="驾驶员报销现金"; //驾驶员报销折现
		public static final String TransportCostDiscount ="驾驶员报销折现"; //驾驶员报销折现
	}
	
	//现金收支状态
	public class CashInOutStatus{
		public static final String NEW = "0";//新建
		public static final String SUBMIT= "1";//已提交
	}
	
	//保费类型
	public class InsuranceType{
		public static final String JOIN = "0";//参加保险
		public static final String EXPENSE = "1";//报保险
	}
	
	//保费状态
	public class InsuranceStatus{
		public static final String NEW = "0";//新建
		public static final String SUBMIT= "1";//生效中
		public static final String INVALID = "2";//已失效
	}
	
	//保费支付状态
		public class InsurancePayStatus{
			public static final String WEI = "0";//未支付
			public static final String YI= "1";//已支付
		}
	
	//保费支付类型
	public class InsurancePayType{
		public static final String OUT = "0";//支付参加保险费用
		public static final String IN= "1";//报保险的赔付费用
		public static final String OFFSET = "2";//已经抵充的参保费用
	}
	
	//装运预付申请状态
	public class PrepayApplyStatus{
		public static final String NEW = "0";//新建
		public static final String LEADERAUDIT = "1";//负责人审核
		public static final String CASHAUDIT = "2";//现金预核
		public static final String CASHLEADERAUDIT = "3";//财务复核
		public static final String CASHPAY = "4";//现金付款
		public static final String FINISH = "5";//已完成
		public static final String BALANCE = "6";//已结算
	}
	
	//折损费用申请状态
	public class CarDamageCostApplyStatus{
		public static final String NEW = "0";//新建
		public static final String VERIFY = "1";//复核
		public static final String AUDIT = "2";//财务
		public static final String CASHPAY = "3";//现金付款
		public static final String FINISH = "4";//已完成
	}
	
	//app版本管理状态
	public class AppVersionStatus{
			public static final String NEW = "0";//新建
			public static final String SUBMIT= "1";//已提交
		}
	
	
	//基础配置参数名称
	public class BasicConfigName{
		public static final String JPUSH_APPKEY = "JPUSH_APPKEY";//极光推送appkey
		public static final String JPUSH_SECRET = "JPUSH_SECRET";//极光推送SECRET
		
		public static final String YD_PROCESS_ID = "YD_PROCESS_ID";//运单
		public static final String DDD_PROCESS_ID = "DDD_PROCESS_ID";//调度单
		public static final String HCSQD_PROCESS_ID = "HCSQD_PROCESS_ID";//在途换车申请单
		public static final String ZYYFSQD_PROCESS_ID = "ZYYFSQD_PROCESS_ID";//装运预付申请单
		public static final String ZYFYHSSQD_PROCESS_ID = "ZYFYHSSQD_PROCESS_ID";//装运费用核算申请单
		public static final String LTCRKSQD_PROCESS_ID = "LTCRKSQD_PROCESS_ID";//轮胎出入库申请单
		public static final String WXBYSQD_PROCESS_ID = "WXBYSQD_PROCESS_ID";//维修保养申请单
		public static final String LTGHSQD_PROCESS_ID = "LTGHSQD_PROCESS_ID";//轮胎更换申请单
		public static final String ZSFKSQD_PROCESS_ID = "ZSFKSQD_PROCESS_ID";//折损反馈申请单
		public static final String ZSFYSQD_PROCESS_ID = "ZSFYSQD_PROCESS_ID";//折损费用申请单
		public static final String ZSCRKSQD_PROCESS_ID = "ZSCRKSQD_PROCESS_ID";//折损出入库申请单
		public static final String PCZLSQD_PROCESS_ID = "PCZLSQD_PROCESS_ID";//派车指令申请单
		public static final String FYSQD_PROCESS_ID = "FYSQD_PROCESS_ID";//费用申请单
		public static final String HXFYSQD_PROCESS_ID = "HXFYSQD_PROCESS_ID";//核销费用申请单
		public static final String LTCGSQD_PROCESS_ID = "LTCGSQD_PROCESS_ID";//轮胎采购申请单
		
		public static final String BIRTHDAY_NOTICE_BEFORE_DAYS = "BIRTHDAY_NOTICE_BEFORE_DAYS";//生日提醒的提前天数
		public static final String INSURANCE_NOTICE_BEFORE_DAYS = "INSURANCE_NOTICE_BEFORE_DAYS";//保单到期提醒的提前天数
		public static final String CONTRACT_NOTICE_BEFORE_DAYS = "CONTRACT_NOTICE_BEFORE_DAYS";//合同到期提醒的提前天数
		public static final String OTHER_CONTACTS_BEFORE_DAYS = "OTHER_CONTACTS_BEFORE_DAYS";//其他往来到期提醒的提前天数
		
		public static final String LOG_ENABLED = "LOG_ENABLED";//是否开启日志记录
		
		//驾驶员默认的部门和角色名称
		public static final String DRIVER_DEPARTMENT_DEFAULT_NAME = "DRIVER_DEPARTMENT_DEFAULT_NAME";
		public static final String DRIVER_ROLE_DEFAULT_NAME = "DRIVER_ROLE_DEFAULT_NAME";
		
		public static final String DEFAULT_PASSWORD = "DEFAULT_PASSWORD";//初始密码
		public static final String FAST_SCHEDULE_USE_PROCESS = "FAST_SCHEDULE_USE_PROCESS";//快速调度是否使用流程：默认不使用
		public static final String DRIVER_SALARY_DISTANCE_LIMIT = "DRIVER_SALARY_DISTANCE_LIMIT";//补贴里程的下限
		public static final String DRIVER_SALARY_DISTANCE_PRICE = "DRIVER_SALARY_DISTANCE_PRICE";//超出补贴里程的每公里价钱
		public static final String OUT_SOURCE_ID_FOR_OWN_COMPANY = "OUT_SOURCE_ID_FOR_OWN_COMPANY";//承运商中名称为“公司车队”的id
	}
	
	//其他往来状态
	public class OtherContactsStatus{
		public static final String NEW = "0";//新建
		public static final String SUBMIT= "1";//已提交
		public static final String FINISH= "2";//已完成
	}
	
	//装运费用核算申请状态
	public class CostApplyStatus{
		public static final String NEW = "0";//新建
		public static final String COSTAUDIT= "1";//待费用审核
		public static final String DIRVERVERIFY = "2";//待驾驶员确认
		public static final String OPERVERIFY = "3";//待运营部负责人
		public static final String CASHAUDIT = "4";//待现金会计
		public static final String CASHLEADERAUDIT = "5";//待财务复核
		public static final String PAYVEFIRY = "6";//现金会计
		public static final String FINISH = "7";//已完成
	}
	
	//办公申请-出差申请单状态
	public class OfficeApply{
		public static final String NEW = "0";//新建
		public static final String SUBMIT= "1";//待复核
	}
	
	//结算方式
	public class BalanceType{
		public static final String PRICE = "0";//单价模式
		public static final String DISTANCE= "1";//公里数模式
		public static final String SUMPRICE= "2";//总价模式
	}
	
	//额外计算方式
	public class AttachType{
		public static final String FIXED = "0";//0-固定（元）
		public static final String RATIO= "1";//1-按比例（%）
	}
	
	//对账类型
	public class BalanceBillType{
		public static final String UP = "0";//上游对账
		public static final String DOWN= "1";//下游对账
	}
	
	//对账状态
	public class BalanceStatus{
		public static final String NEW = "0";//新建
		public static final String SURE= "1";//已确认
	}
	
	//对账状态
	public class BusinessLogType{
		public static final String BALANCEUP = "10";//上游对账
		public static final String BALANCEDOWN = "11";//下游对账
	}
	
	//装运核算费用明细类型0-交车费，1-带路费，2-罚款，3-餐费，4-住宿费，5-其他支出
	public class TransportCostApplyDetailType{
		public static final String CAR = "0";//0-交车费
		public static final String ROAD = "1";//1-带路费
		public static final String FINE = "2";//2-罚款
		public static final String LUNCH = "3";//3-餐费
		public static final String SLEEP = "4";//4-住宿费
		public static final String OTHER = "5";//5-其他支出
	}
	
	//折损反馈状态
	public class CarDamageFeedbackStatus{
		public static final String NEW = "0";//
		public static final String CONFIRM = "1";//运单管理确认
		public static final String DAMAGE_CONFIRM = "2";//折损管理确认
		public static final String OPER_CONFIRM = "3";//运营负责人确认
		public static final String FINISHED = "4";//完成
	}
	
	//角色名称
	public class roleName{
		public static final String MOBILE_DEVELOP = "手机端已开发功能";
	}
	
	//结算模式execl固定列数
	public class importExeclLength{
		public static final int priceLength = 6;//单价模式
		public static final int totalPriceLength = 5;//总价模式
	}
	//派车指令状态
	public class SendCarCommandStatus{
		public static final String NEW = "0";//新建
		public static final String SUBMIT= "1";//待驾驶员确认
		public static final String VERIFY= "2";//待驾驶员到达确认
		public static final String FINISH= "3";//已完成 
	}
	
	//额外类型：0收入1成本
	public class attachMold{
		public static final int INCOME = 0;
		public static final int COST = 1;
	}
	
	//计费类型：0加价运费1其他扣除
	public class chargeType{
		public static final int FARE = 0;
		public static final int OTHER = 1;
	}
	
	//费用申请管理状态
	public class CostApplyForOfficeStatus
	{
		public static final String NEW = "0";//新建
		public static final String SUBMIT= "1";//部门负责人审核
		public static final String VERIFY= "2";//财务复核
		public static final String ZCHECK= "3";//总经理审核
		public static final String XIANJ= "4";//现金会计 
		public static final String FINISH= "5";//已完成 
		public static final String HEXIAO= "6";//已核销
	}
	
	//核销申请管理状态
	public class CostApplyReturnForOfficeStatus
	{
		public static final String NEW = "0";//新建
		public static final String SUBMIT= "1";//部门负责人审核
		public static final String VERIFY= "2";//财务复核
		public static final String ZCHECK= "3";//总经理审核
		public static final String XIANJ= "4";//现金会计 
		public static final String FINISH= "5";//已完成
	}
	
	//轮胎采购
	public class TrackTyreBuyApplyStatus
	{
		public static final String NEW = "0";//新建
		public static final String SUBMIT= "1";//待复核
		public static final String DAICAI= "2";//待采购
		public static final String FINISH= "3";//已完成
		public static final String DENGJI= "4";//已登记 
	}
	
	//代付现金状态
	public class CashWaitingPayLogStatus{
		public static final String NEW = "0";//未支付
		public static final String PAY= "1";//已支付
	}
	
	//折损维修登记状态0-新建，1-修理中，2-已完成
	public class TrackRepairApplyStatus{
		public static final String NEW = "0";//新建
		public static final String ING= "1";//修理中
		public static final String FINISH= "2";//已完成
	}
	
	//工资发放状态：
	public class SalaryPayStatus{
		public static final String NEW = "0";//新建
		public static final String PAY= "1";//已发放
	}
	
	//往来款业务类型：
	public class ContactFundsType{
		public static final String GYS = "0";//供应商
		public static final String CYS= "1";//承运商
	}
	
	//往来款状态：
	public class ContactFundsStatus{
		public static final String NEW = "0";//草稿
		public static final String SUBMIT= "1";//提交
	}
	
	//往来款类型：
	public class FundType{
		public static final String ALL = "0";//0应收(付)款
		public static final String GIVE= "1";//1实收(付)款
	}
}
