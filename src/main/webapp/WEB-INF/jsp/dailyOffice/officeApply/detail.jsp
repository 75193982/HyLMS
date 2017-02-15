
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<!-- basic styles -->
<link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
<!-- page specific plugin styles -->
<!-- ace styles -->
<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" />
<!-- inline styles related to this page -->
<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
<%-- <link rel="stylesheet" href="${ctx}/staticPublic/css/bootstrap-datetimepicker.css" /> --%>
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
 <style type="text/css">
#modal-detilinfo {
	width: 1010px;
	height: 600px;
	margin: auto;
	background: rgb(255, 255, 255);
	overflow: auto;
}

.well {
	margin-bottom: 0px;
}

a:hover {
	text-decoration: none;
	cursor: pointer;
}

.editlinks {
	width: 280px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.editlinkes {
	width: 260px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
.modal-dialog{
    width: 1050px;	
    left: 20%;
    top: 2%;
}
</style>
</head>
<body class="white-bg">
<div class="breadcrumbs" id="breadcrumbs">
	<script type="text/javascript">
		try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
	</script>

	<ul class="breadcrumb">
		<li>
			<i class="icon-home home-icon"></i>
			<a href="#">日常办公</a>
		</li>
		<li class="active">办公费用申请</li>
	</ul><!-- .breadcrumb -->
</div>
<div class="page-content">
	<div class="page-content">
		<div class="mng">
		   <div class="table-tit">办公费用申请信息</div>
		   <div class="table-item">
		     <div class="table-itemTit">申请信息</div>
		     <div id="waybill_msg">
		      <!-- 第一列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>类型:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="type_way" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>运单编号:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="waybillNo_way" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>	
		     <div id="hiddens1">
		     <!-- 第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>品牌:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="brand_way" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>经销单位:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			         <p id="carShop_way" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第三列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>供应商:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="supplier_way" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>发运日期:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="sendTime_way" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     </div>	
		      <div id="hiddens2">
		      <!-- 第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>运输价格:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="amount_way" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>接车联系人电话:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			         <p id="receiveUserTelephone_way" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第三列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>接车联系人:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="receiveUser_way" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>接车联系人手机:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="receiveUserMobile_way" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     </div>	       		     		     
		     <!-- 第四列 -->
		     <div class="row newrow">
			     <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>始发地:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <p id="startAddress_way" class="form-control no-border"></p>
				       </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>目的地:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <p id="targetAddress_way" class="form-control no-border"></p>
				       </div>
			       </div>
		     </div>
		     <div id="hiddens3">
		      <!-- 第五列 -->
		     <div class="row newrow">
		        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>总路程:</label>
			       </div>
		       </div>
			   <div class="col-xs-11">
			     <div class="form-contr">
			       <p id="distance_way" class="form-control no-border"></p>
			     </div>
			   </div>
			 </div>
		     </div>
		    
		     </div>
		     <div id="scheduleBill_msg">
		      <!-- 第一列 -->
		     <div class="row newrow">
		        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>调度单号:</label>
			       </div>
		       </div>
			   <div class="col-xs-11">
			     <div class="form-contr">
			       <p id="scheduleBillNo_sch" class="form-control no-border"></p>
			     </div>
			   </div>
			 </div>
		     <!-- 第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>发车日期:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="sendTime_sch" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>交车日期:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="receiveTime_sch" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>		       
		     <!-- 第三列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>期望到达日期:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="planReachTime_sch" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>台数:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			         <p id="all_amount_sch" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第四列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>始发地:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="startAddress_sch" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>目的地:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="endAddress_sch" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第五列 -->
		     <div class="row newrow">
			     <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>装运车号:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <p id="carNumber_sch" class="form-control no-border"></p>
				       </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>驾驶员:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <p id="driver_sch" class="form-control no-border"></p>
				       </div>
			       </div>
		     </div>
		     <!-- 第六列 -->
		     <div class="row newrow">
		        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>备注:</label>
			       </div>
		       </div>
			   <div class="col-xs-11">
			     <div class="form-contr">
			       <p id="mark_sch" class="form-control no-border"></p>
			     </div>
			   </div>
			 </div>
		     </div>
		     <div id="changeCar_msg">
		      <!-- 第一列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>调度单:</label>
			       </div>
		       </div>
		       <div class="col-xs-11">
			       <div class="form-contr">
			          <p id="scheduleBillNo_cha" class="form-control no-border"></p>
			       </div>
		       </div>		       		      
		     </div>		       
		     <!-- 第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>装运车号:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="oldCarNumber_cha" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>新装运车号:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			         <p id="newCarNumber_cha" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第三列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>驾驶员:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="oldDriver_cha" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>新驾驶员:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="newDriver_cha" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第四列 -->
		     <div class="row newrow">
			     <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>原因:</label>
				       </div>
			       </div>
			       <div class="col-xs-11">
				       <div class="form-contr">
				          <p id="reason_cha" class="form-control no-border"></p>
				       </div>
			       </div>			       			       
		     </div>
		     <!-- 第五列 -->
		     <div class="row newrow">
			   <div class="col-xs-12">
			     <div class="form-contr">
			       <a class="add-detilBtn"  onclick="getmesgdetils();">换车申请明细</a>	
			     </div>
			   </div>
			 </div>
		     </div>
		     <div id="Prepay_msg">
		       <!-- 第一列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>装运车号:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="carNumber_pre" class="form-control no-border"></p>
			       </div>
		       </div>
		        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>申请时间:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="applyTime_pre" class="form-control no-border"></p>
			       </div>
		       </div>			       		      
		     </div>		       
		     <!-- 第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>驾驶员:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="driver_pre" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>联系电话:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			         <p id="mobile_pre" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第三列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>预付现金:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="prepayCash_pre" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>开户行:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="bankName_pre" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第四列 -->
		     <div class="row newrow">
			     <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>账户:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <p id="bankAccount_pre" class="form-control no-border"></p>
				       </div>
			       </div>
			        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>预付油卡卡号:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="oilCardNo_pre" class="form-control no-border"></p>
			       </div>
		       </div>			       			       
		     </div>
		     <!-- 第五列 -->
		     <div class="row newrow">
			   <div class="col-xs-12">
			    <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>预付邮费:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <p id="oilAmount_pre" class="form-control no-border"></p>
				       </div>
			       </div>
			        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>备注:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="mark_pre" class="form-control no-border"></p>
			       </div>
		       </div>			       	
			   </div>
			 </div>
		     </div>
		     <div id="trackTyreInOut_msg">
		      <!-- 第一列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>单据号:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="tyreInOutno_inout" class="form-control no-border"></p>
			       </div>
		       </div>
		        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>类型:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="type_inout" class="form-control no-border"></p>
			       </div>
		       </div>			       		      
		     </div>		       
		     <!-- 第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>备注:</label>
			       </div>
		       </div>
		       <div class="col-xs-11">
			       <div class="form-contr">
			          <p id="mark_inout" class="form-control no-border"></p>
			       </div>
		       </div>		       
		     </div>
		     <!-- 第三列 -->
		     <div class="row newrow">		       
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>轮胎:</label>
			       </div>
		       </div>
		       <div class="col-xs-12">
			       <div class="form-contr">
			         <table id="tyreNo_detailtable" class="table table-striped table-bordered table-hover" style="margin-bottom: 10px;">
			                              <thead>
				                          <tr>														
				                        	<th>序号</th>
				                           	<th>轮胎编号</th>				                      
                                            <th>尺寸</th>                                                                              
                                            <th>备注 </th>                                            
				                            </tr>
			                                 </thead>
			                                 <tbody>
			                                 </tbody>
		             </table>
			       </div>
		       </div>
		     </div>		    		    
		     </div>
		     <div id="trackMaint_msg">
		      <!-- 第一列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>装运车号:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="carNumber_maint" class="form-control no-border"></p>
			       </div>
		       </div>
		        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>目前公里数:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="curMile_maint" class="form-control no-border"></p>
			       </div>
		       </div>			       		      
		     </div>		       
		     <!-- 第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>保养费用:</label>
			       </div>
		       </div>
		       <div class="col-xs-11">
			       <div class="form-contr">
			          <p id="amount_maint" class="form-control no-border"></p>
			       </div>
		       </div>		       		       
		     </div>
		     <!-- 第三列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>保养详情:</label>
			       </div>
		       </div>
		       <div class="col-xs-11">
			       <div class="form-contr">
			          <p id="detailInfo_maint" class="form-control no-border"></p>
			       </div>
		       </div>		       		      
		     </div>
		     <!-- 第四列 -->
		     <div class="row newrow">
			     <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>备注:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <p id="mark_maint" class="form-control no-border"></p>
				       </div>
			       </div>			      		       		       			       
		     </div>		   
		     </div>
		   <div id="officeapply_msg">
		      <!-- 第一列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>业务流程:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="process_off" class="form-control no-border"></p>
			       </div>
		       </div>
		        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>项目名称:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="itemName_off" class="form-control no-border"></p>
			       </div>
		       </div>			       		      
		     </div>		       
		     <!-- 第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>金额:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="amount_off" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>预付现金:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="cashAdvance_off" class="form-control no-border"></p>
			       </div>
		       </div>			       		       
		     </div>
		     <!-- 第三列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>开始时间:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="startTime_off" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>结束时间:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="endTime_off" class="form-control no-border"></p>
			       </div>
		       </div>			       		      
		     </div>
		     <!-- 第四列 -->
		     <div class="row newrow">
			     <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>备注:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <p id="mark_off" class="form-control no-border"></p>
				       </div>
			       </div>			      		       		       			       
		     </div>		   
		     </div>
		     
		     
		     
		     <!--设置操作日志信息-->
		     <div class="row row-btn-tit" id="carDetail">
		        <div class="col-xs-2 pd-2">
			       <div class="row-tit">
			                           操作日志信息
			       </div>
		       </div>
		       <div class="col-xs-12" style="margin-top: 10px;">		        
		       <table id="taskHistory_view" class="table table-striped table-bordered table-hover">
			                      <thead>
				                   <tr>													
					               <th>序号</th>
					               <th>流程步骤名称</th>
                                   <th>操作人名称</th>
                                   <th>操作时间</th>                                 
                                   <th>审核意见</th>  
                                    <th>附件</th>                                                                                                                                             
				                    </tr>
			                      </thead>
			                      <tbody>
			                      </tbody>
			                      </table>	
		       </div>
		     </div>
		     
		     
		     <!-- 操作按钮栏 -->
		     <div class="row newrow">
		       <div class="col-xs-5"></div>
		       <div class="col-xs-2">
		       <input type="hidden" id="firsturl" name="firsturl"/>
			       <div class="form-contr">
			          <a class="backbtn" onclick="doback();"><i class="icon-undo" style="display: inline-block;width: 20px;"></i>返回</a>
			       </div>
		       </div>
		       <div class="col-xs-5"></div>
		     </div>
		   </div>
		</div>
	</div>
</div>

<script src="${ctx}/staticPublic/js/jquery-2.0.3.min.js"></script>
<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
<!-- ace scripts -->
<script src="${ctx}/staticPublic/js/ace-elements.min.js"></script>
<script src="${ctx}/staticPublic/js/ace.min.js"></script>
<!-- inline scripts related to this page -->
<script type="text/javascript" src="${ctx}/staticPublic/js/bootbox.min.js"></script>
<script src="${ctx}/staticPublic/js/jquery.dataTables.js"></script>
<script src="${ctx}/staticPublic/js/jquery.dataTables.bootstrap.js"></script>
<script src="${ctx}/staticPublic/js/jsonDataFormat.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
  $(function(){
	  var url = location.href;
		//console.log(url);
		var itemId="";
		var itemIds="";
		var firsturl="";
		if(url.indexOf("?")>0){
			itemIds = url.substring(url.indexOf("?")+1,url.length);
			firsturl=itemIds.substring(itemIds.indexOf("&")+1,url.length);
		    $('#firsturl').val(firsturl);
		    itemId=itemIds.split("&")[0];
			}
		//console.log(firsturl);
	    getdetil(itemId);
	 
  });
  function getdetil(itemId){
	  $.ajax({
			type : 'GET',
			url : "${ctx}/dailyOffice/officeApply/getDetailInfoForItem/"+itemId,
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {							
					//console.log(JSON.stringify(data.data));
					//console.log(data.data.businessType);
					if(data.data.businessType=='01'){
						$('#waybill_msg').show();
						$('#scheduleBill_msg').hide();						
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#officeapply_msg').hide();
						if(data.data.detail.type=='1'){
							$("#type_way").html('二手车'); 
							$('#hiddens1').hide();
							$('#hiddens3').hide();
							$('#hiddens2').show();
						}else{
							$("#type_way").html('商品车'); 
							$('#hiddens1').show();
							$('#hiddens2').hide();
							$('#hiddens3').show();
						}
						$("#waybillNo_way").html(data.data.detail.waybillNo);
						$("#supplier_way").html(data.data.detail.supplierName); 
						$("#amount_way").html(data.data.detail.amount); 
						$("#brand_way").html(data.data.detail.brand); 
						$("#carShop_way").html(data.data.detail.carShopName);
						$("#sendTime_way").html(data.data.detail.sendTime); 
						$("#receiveUser_way").html(data.data.detail.receiveUser); 
						$("#receiveUserTelephone_way").html(data.data.detail.receiveUserTelephone); 
						$("#receiveUserMobile_way").html(data.data.detail.receiveUserMobile); 
						$("#startAddress_way").html(data.data.detail.startAddress);
						$("#targetAddress_way").html(data.data.detail.targetAddress);
						$("#distance_way").html(data.data.detail.distance);	
					}else if(data.data.businessType=='02'){
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').show();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();	
						$('#officeapply_msg').hide();
						$("#scheduleBillNo_sch").html(data.data.detail.scheduleBillNo);
						if(data.data.detail.sendTime!=null&&data.data.detail.sendTime!=''){
							$("#sendTime_sch").html(jsonForDateFormat(data.data.detail.sendTime)); 
						}else{
							$("#sendTime_sch").html(''); 
						}
						if(data.data.detail.receiveTime!=null&&data.data.detail.receiveTime!=''){
							$("#receiveTime_sch").html(jsonForDateFormat(data.data.detail.receiveTime)); 
						}else{
							$("#receiveTime_sch").html(''); 
						}						
						$("#all_amount_sch").html(data.data.detail.amount); 
						if(data.data.detail.planReachTime!=null&&data.data.detail.planReachTime!=''){
							$("#planReachTime_sch").html(jsonForDateFormat(data.data.detail.planReachTime)); 
						}else{
							$("#planReachTime_sch").html(''); 
						}
						$("#startAddress_sch").html(data.data.detail.startAddress); 
						$("#endAddress_sch").html(data.data.detail.endAddress); 
						$("#carNumber_sch").html(data.data.detail.carNumber); 
						$("#driver_sch").html(data.data.detail.driverName); 
						$("#mark_sch").html(data.data.detail.mark);						

					}else if(data.data.businessType=='03'){
						
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#mesg_detilbtn').hide();
						$('#changeCar_msg').show();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#officeapply_msg').hide();
						$("#scheduleBillNo_cha").html(data.data.detail.scheduleBillNo); 
						$("#oldCarNumber_cha").html(data.data.detail.oldCarNumber); 
						$("#oldDriver_cha").html(data.data.detail.oldDriver); 
						$("#newCarNumber_cha").html(data.data.detail.newCarNumber); 
						$("#newDriver_cha").html(data.data.detail.newDriver); 
						$("#reason_cha").html(data.data.detail.reason);											
					}else if(data.data.businessType=='04'){
						
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#mesg_detilbtn').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').show();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#officeapply_msg').hide();
						$("#carNumber_pre").html(data.data.detail.carNumber); 
						if(data.data.detail.applyTime!=null&&data.data.detail.applyTime!=''){
							$("#applyTime_pre").html(jsonForDateFormat(data.data.detail.applyTime)); 
						}else{
							$("#applyTime_pre").html(''); 
						}
						$("#driver_pre").html(data.data.detail.driver); 
						$("#mobile_pre").html(data.data.detail.mobile); 
						$("#prepayCash_pre").html(data.data.detail.prepayCash);
						$("#bankName_pre").html(data.data.detail.bankAccount);
						$("#bankAccount_pre").html(data.data.detail.bankAccount);
						$("#oilCardNo_pre").html(data.data.detail.oilCardNo);
						$("#oilAmount_pre").html(data.data.detail.oilAmount);
						$("#mark_pre").html(data.data.detail.mark);
					}else if(data.data.businessType=='06'){
						
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#mesg_detilbtn').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').show();
						$('#trackMaint_msg').hide();
						$('#officeapply_msg').hide();
						$("#tyreInOutno_inout").html(data.data.detail.billNo); 
						var type=data.data.detail.type;
						var typename="";
						if(type=='0'){typename='入库'}else{
							typename='出库'
						}
						$("#type_inout").html(typename); 
						$("#mark_inout").html(data.data.detail.mark); 						
						if(data.data.detail.detailList.length>0){
							for(var i=0;i<data.data.detail.detailList.length;i++){
								data.data.detail.detailList[i]["rownum"]=i+1;
							}								
						}
						$('#tyreNo_detailtable').dataTable({
							 dom: 'Bfrtip',
							 "destroy": true,//如果需要重新加载需销毁
							 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
							 "bFilter": false,    //不使用过滤功能  
							 "bProcessing": true, //加载数据时显示正在加载信息	
							 "bPaginate" : false,
							 "bInfo" : false,
							  ordering: false,
								"oLanguage": {
									"sZeroRecords": "抱歉， 没有找到",
									"sInfoEmpty": "没有数据",
									"sInfoFiltered": "(从 _MAX_ 条数据中检索)",							
									"sZeroRecords": "没有检索到数据"
									},	
							data: data.data.detail.detailList,
					        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
					        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
					        columns: [	
					            { data: 'rownum' },
					            {data: "tyreNo"},
							    {data: "size"},							 
							    {data: "mark"},							   
							    /* {data: "status"} */]
						});
					}else if(data.data.businessType=='07'){
						
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#mesg_detilbtn').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').show();
						$('#officeapply_msg').hide();
						$("#carNumber_maint").html(data.data.detail.carNumber); 
						$("#curMile_maint").html(data.data.detail.currentMileage);
						$("#amount_maint").html(data.data.detail.amount); 
						$("#detailInfo_maint").html(data.data.detail.detailInfo); 
						$("#mark_maint").html(data.data.detail.mark); 						
					}else if(data.data.businessType=='08'){						
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#mesg_detilbtn').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#officeapply_msg').show();
						$("#process_off").html(data.data.item.processName); 
						$("#itemName_off").html(data.data.item.itemName);
						$("#amount_off").html(data.data.item.amount); 
						$("#cashAdvance_off").html(data.data.item.cashAdvance);
						$("#startTime_off").html(data.data.item.startTime); 
						$("#endTime_off").html(data.data.item.endTime); 
						$("#mark_maint").html(data.data.item.mark); 						
					}
					if(data.data.logList.length>0){
						for(var i=0;i<data.data.logList.length;i++){
							data.data.logList[i]["rownum"]=i+1;
						}
						$('#taskHistory_view').dataTable({
							 dom: 'Bfrtip',
							 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
							 "bFilter": false,    //不使用过滤功能  
							 "bProcessing": true, //加载数据时显示正在加载信息	
							 "bPaginate" : false,
							 "bInfo" : false,
							  ordering: false,
								"oLanguage": {
									"sZeroRecords": "抱歉， 没有找到",
									"sInfoEmpty": "没有数据",
									"sInfoFiltered": "(从 _MAX_ 条数据中检索)",							
									"sZeroRecords": "没有检索到数据"
									},	
							data: data.data.logList,
					        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
					        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
					        columns: [	
					            { data: 'rownum' },
					            {data: "processDetailName"},
							    {data: "operateUserName"},
							    {data: "operateTime"},
							    {data: "mark"},
							    {data: "attachFileName"}],
							    columnDefs: [{
									 //入职时间
									 targets: 3,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonDateFormat(data);
										 }else{
											 return '';
										 }			
								       }	       
								},{
									 //入职时间
									 targets: 5,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 var attachFilePaths="${ctx}"+row.attachFilePath;
											 return '<a  href='+attachFilePaths+' target="_blank">'+data+'</a>';
										 }else{
											 return '';
										 }			
								       }	       
								}
							      ]
						});
					}
				}else{
					bootbox.alert(data.msg);
				}
					}
				});
  }
  /* 返回*/
   function doback(){
	  var firsturl= $('#firsturl').val();
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要离开？", 
		  callback: function(result){
			  if(result){
				  location.href=firsturl;
			  }
			 
		  }
	 })
 }
</script>

</body>
</html>






