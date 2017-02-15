package com.jshpsoft.timer;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.jshpsoft.dao.CarShopMapper;
import com.jshpsoft.dao.ContractMapper;
import com.jshpsoft.dao.OtherContactsMapper;
import com.jshpsoft.dao.SupplierMapper;
import com.jshpsoft.dao.TrackInsuranceMapper;
import com.jshpsoft.domain.CarShop;
import com.jshpsoft.domain.Contract;
import com.jshpsoft.domain.OtherContacts;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.TrackInsurance;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.MailUtils;

/**
 * @Description: 系统定时任务
 * @author army.liu
 * @date 2016年11月5日 上午8:19:02
 *
 */
@Component
public class SystemTimer {

	private Logger logger = LoggerFactory.getLogger(SystemTimer.class);
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private SupplierMapper supplierMapper;
	
	@Autowired
	private CarShopMapper carShopMapper;
	
	@Autowired
	private TrackInsuranceMapper trackInsuranceMapper;
	
	@Autowired
	private ContractMapper contractMapper;
	
	@Autowired
	private OtherContactsMapper otherContactsMapper;
	
	//每天上午8点
	@Scheduled(cron="0 0 8 * * ?")
	public void sendMessage(){
		
		logger.debug("**********************"+Thread.currentThread().getName()+" "+": 发送即将到期提醒");
		
		try {
			//供应商、4s店联系人生日到期提醒：需要设置提醒人、提醒时间（提前几天提醒）-添加到公共配置表
			String birthdayBefore = commonService.getConfigValue(0,Constants.BasicConfigName.BIRTHDAY_NOTICE_BEFORE_DAYS);
			if( StringUtils.isNotEmpty(birthdayBefore) ){
				String[] arr = birthdayBefore.split("\\|");
				if( arr.length > 1 ){
					String days = arr[0];
					String receiveUserId = arr[1];
					
					//获取符合条件的人员：供应商
					Map<String, Object> params = new HashMap<String, Object>();
					params.put("delFlag", Constants.DelFlag.N);
					params.put("beforeDays", Integer.parseInt(days) );
					List<Supplier> supplierList = supplierMapper.getByConditions(params);
					if( null != supplierList && supplierList.size() > 0 ){
						for(int i=0; i<supplierList.size(); i++){
							Supplier bean = supplierList.get(i);
							String content = CommonUtil.createPushMsgForBirthday(bean);
							commonService.pushMsgToUser(Integer.parseInt(receiveUserId), content);
							
						}
						
					}
					
					//获取符合条件的人员：4S店
					List<CarShop> carShopList = carShopMapper.getByConditions(params);
					if( null != carShopList && carShopList.size() > 0 ){
						for(int i=0; i<carShopList.size(); i++){
							CarShop bean = carShopList.get(i);
							String content = CommonUtil.createPushMsgForBirthday(bean);
							commonService.pushMsgToUser(Integer.parseInt(receiveUserId), content);
							
						}
						
					}
					
				}
			}
			
			//保单到期提醒：需要设置提醒人、提醒时间（提前几天提醒）-添加到公共配置表
			String insuranceBefore = commonService.getConfigValue(0,Constants.BasicConfigName.INSURANCE_NOTICE_BEFORE_DAYS);
			if( StringUtils.isNotEmpty(insuranceBefore) ){
				String[] arr = insuranceBefore.split("\\|");
				if( arr.length > 1 ){
					String days = arr[0];
					String receiveUserId = arr[1];
					
					//获取符合条件的保单
					Map<String, Object> params = new HashMap<String, Object>();
					params.put("delFlag", Constants.DelFlag.N);
					params.put("beforeDays", Integer.parseInt(days) );
					params.put("status", Constants.InsuranceStatus.SUBMIT);
					List<TrackInsurance> list = trackInsuranceMapper.getByConditions(params);
					if( null != list && list.size() > 0 ){
						for(int i=0; i<list.size(); i++){
							TrackInsurance bean = list.get(i);
							String content = CommonUtil.createPushMsgForInsurance(bean);
							commonService.pushMsgToUser(Integer.parseInt(receiveUserId), content);
							
						}
						
					}
					
				}
			}
			
			//合同到期提醒：需要设置提醒人、提醒时间（提前几天提醒）-添加到公共配置表
			String contractBefore = commonService.getConfigValue(0,Constants.BasicConfigName.CONTRACT_NOTICE_BEFORE_DAYS);
			if( StringUtils.isNotEmpty(contractBefore) ){
				String[] arr = contractBefore.split("\\|");
				if( arr.length > 1 ){
					String days = arr[0];
					String receiveUserId = arr[1];
					
					//获取符合条件的保单
					Map<String, Object> params = new HashMap<String, Object>();
					params.put("delFlag", Constants.DelFlag.N);
					params.put("beforeDays", Integer.parseInt(days) );
					params.put("status", Constants.ContractStatus.EFFECT);
					List<Contract> list = contractMapper.getByConditions(params);
					if( null != list && list.size() > 0 ){
						for(int i=0; i<list.size(); i++){
							Contract bean = list.get(i);
							String content = CommonUtil.createPushMsgForContract(bean);
							commonService.pushMsgToUser(Integer.parseInt(receiveUserId), content);
							
						}
						
					}
					
				}
			}
			
			//其他往来到期提醒：需要设置提醒人、提醒时间（提前0天提醒）-添加到公共配置表
			String otherContacts = commonService.getConfigValue(0,Constants.BasicConfigName.OTHER_CONTACTS_BEFORE_DAYS);
			if( StringUtils.isNotEmpty(otherContacts) ){
				String[] arr = otherContacts.split("\\|");
				if( arr.length > 1 ){
					String days = arr[0];
					String receiveUserId = arr[1];
					
					//获取符合条件的保单
					Map<String, Object> params = new HashMap<String, Object>();
					params.put("delFlag", Constants.DelFlag.N);
					params.put("beforeDays", Integer.parseInt(days) );
					params.put("status", Constants.ContractStatus.EFFECT);
					List<OtherContacts> list = otherContactsMapper.getByConditions(params);
					if( null != list && list.size() > 0 ){
						for(int i=0; i<list.size(); i++){
							OtherContacts bean = list.get(i);
							String content = CommonUtil.createPushMsgForOtherContacts(bean);
							commonService.pushMsgToUser(Integer.parseInt(receiveUserId), content);
							
						}
						
					}
					
				}
			}
			
		} catch (Exception e) {
			logger.error("定时任务提醒执行失败-即将到来：" + e.getMessage(), e);
			
			MailUtils.sendMail("定时任务提醒执行失败-即将到来", CommonUtil.createExceptionMsgForShort("【定时任务提醒执行失败-即将到来】", e) );
			
		}
		
	}
	
	//每天上午1点
	@Scheduled(cron="0 0 1 * * ?")
	public void updateInsuranceStatus(){
		
		logger.debug("**********************"+Thread.currentThread().getName()+" "+": 更新失效状态");
		
		try {
			//保单到期失效处理，并推送消息提醒已失效
			String insuranceBefore = commonService.getConfigValue(0,Constants.BasicConfigName.INSURANCE_NOTICE_BEFORE_DAYS);
			if( StringUtils.isNotEmpty(insuranceBefore) ){
				String[] arr = insuranceBefore.split("\\|");
				if( arr.length > 1 ){
//					String receiveUserId = arr[1];
					
					//获取符合条件的保单
					Map<String, Object> params = new HashMap<String, Object>();
					params.put("delFlag", Constants.DelFlag.N);
					params.put("deadline", CommonUtil.format(new Date(), "yyyy-MM-dd") );
					params.put("statusNot", Constants.InsuranceStatus.INVALID);
					List<TrackInsurance> list = trackInsuranceMapper.getByConditions(params);
					if( null != list && list.size() > 0 ){
						for(int i=0; i<list.size(); i++){
							TrackInsurance bean = list.get(i);
//							String content = CommonUtil.createPushMsgForInsuranceDeadline(bean);
//							commonService.pushMsgToUser(Integer.parseInt(receiveUserId), content);
							
							bean.setStatus(Constants.InsuranceStatus.INVALID);
							bean.setUpdateTime(new Date());
							trackInsuranceMapper.update(bean);
							
						}
						
					}
					
				}
			}
			
			//合同到期失效处理，并推送消息提醒已失效
			String contractBefore = commonService.getConfigValue(0,Constants.BasicConfigName.CONTRACT_NOTICE_BEFORE_DAYS);
			if( StringUtils.isNotEmpty(contractBefore) ){
				String[] arr = contractBefore.split("\\|");
				if( arr.length > 1 ){
//					String receiveUserId = arr[1];
					
					//获取符合条件的保单
					Map<String, Object> params = new HashMap<String, Object>();
					params.put("delFlag", Constants.DelFlag.N);
					params.put("deadline", CommonUtil.format(new Date(), "yyyy-MM-dd") );
					params.put("status", Constants.ContractStatus.EFFECT);
					List<Contract> list = contractMapper.getByConditions(params);
					if( null != list && list.size() > 0 ){
						for(int i=0; i<list.size(); i++){
							Contract bean = list.get(i);
//							String content = CommonUtil.createPushMsgForContractDeadline(bean);
//							commonService.pushMsgToUser(Integer.parseInt(receiveUserId), content);
							
							bean.setStatus(Constants.ContractStatus.EXPIRED);
							bean.setUpdateTime(new Date());
							contractMapper.update(bean);
							
						}
						
					}
					
				}
			}
			
			
		} catch (Exception e) {
			logger.error("定时任务提醒执行失败-更新失效：" + e.getMessage(), e);
			
			MailUtils.sendMail("定时任务提醒执行失败-更新失效", CommonUtil.createExceptionMsgForShort("【定时任务提醒执行失败-更新失效】", e) );
			
		}
		
	}
	
}
