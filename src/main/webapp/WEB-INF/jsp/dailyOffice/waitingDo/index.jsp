
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/Confirm.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<script type="text/javascript" src="${ctx}/staticPublic/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${ctx}/staticPublic/js/popbox/Confirm.js"></script>
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
<div class="page-content">
	<div class="page-header">
		<h1>
			日常办公
			<small>
				<i class="icon-double-angle-right"></i>
				待办事项
			</small>
		</h1>
	</div><!-- /.page-header -->	
	<div class="page-content">
		<!-- <div class="searchbox col-xs-12">
		     <label class="title ">状态：</label>
		     <select id="fom_type" class="form-box">
		      <option value='0'>待办</option>
		      <option value='1'>已办</option>
			</select>	
			<a class="itemBtn " onclick="searchInfo()">查询</a>
			<a class="itemBtn " onclick="doadd()">新增</a>			
		</div> -->
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>标题</th>
					<th>接收时间</th>
                    <th>来源</th>                  
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div class="modal fade" id="modal-detilinfo" tabindex="-1" role="dialog" data-backdrop="static">
                            <div class="modal-header">
                              <button class="close" type="button" data-dismiss="modal" onclick="detilclose();">×</button>
                              <h3 id="myModalLabel">待办工作</h3></div>
                            <div class="modal-body" style="height:510px;overflow:auto;">
                              <div>
                                <div class="widget-box dia-widget-box">
                                  <div class="widget-body">
                                    <div class="widget-main">
                                      <div class="add-item">
                                        <label class="titlecenter tobold">申请审核</label>
                                        <input class="form-control" id="waybillid-hidden" type="hidden" />
                                        <input class="form-control" id="type-hidden" type="hidden" />
                                        <input class="form-control" id="taskId-hidden" type="hidden" />
                                        <input class="form-control" id="businessType-hidden" type="hidden" />
                                        <input class="form-control" id="waybillNo-hidden" type="hidden" />
                                        <input class="form-control" id="scheduleBillNo-hidden" type="hidden" />
                                        <input class="form-control" id="scheduleBillId-hidden" type="hidden" />
                                        <input class="form-control" id="changecarId-hidden" type="hidden" />
                                        <input class="form-control" id="tranPrepayId-hidden" type="hidden" />
                                        <input class="form-control" id="tyreInOutId-hidden" type="hidden" />
                                        <input class="form-control" id="maintId-hidden" type="hidden" />
                                        <input class="form-control" id="tranPortCostId-hidden" type="hidden" />
                                        <input class="form-control" id="damgcostId-hidden" type="hidden" />
                                        <input class="form-control" id="cardagoutid_hidden" type="hidden" />
                                        <input class="form-control" id="needSuggestFlag" type="hidden" />
                                        <input class="form-control" id="discountFlag_hidden" type="hidden" />
                                         <input class="form-control" id="tyretype-hidden" type="hidden" />
                                        </div>
                                      <hr class="tree"></hr>
                                      <div class="add-item">
                                        <label class="title tobold">待审信息</label></div>
                                      <div id="waybill_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">类型：</label>
                                          <label class="title col-xs-4" id="type_audit"></label>
                                          <label class="title col-xs-2">运单编号：</label>
                                          <label class="title col-xs-4" id="waybillNo_audit"></label>
                                        </div>
                                        <div id="hiddens1">
                                          <hr class="tree"></hr>
                                          <div class="add-item col-xs-12">
                                            <label class="title col-xs-2">品牌：</label>
                                            <label class="title col-xs-4" id="brand_audit"></label>
                                            <label class="title col-xs-2">经销单位：</label>
                                            <label class="title col-xs-4" id="carShopId_audit"></label>
                                          </div>
                                          <hr class="tree"></hr>
                                          <div class="add-item col-xs-12">
                                            <label class="title col-xs-2">供应商：</label>
                                            <label class="title col-xs-4" id="supplierId_audit"></label>
                                          </div>
                                          <hr class="tree"></hr>
                                          <div class="add-item col-xs-12">
                                            <label class="title col-xs-2">发运日期：</label>
                                            <label class="title col-xs-4" id="sendTime_audit"></label>
                                          </div>
                                        </div>
                                        <div id="hiddens2">
                                          <hr class="tree"></hr>
                                          <div class="add-item col-xs-12">
                                            <label class="title col-xs-2">运输价格：</label>
                                            <label class="title col-xs-4" id="amount_audit"></label>
                                            <label class="title col-xs-2">接车联系人电话：</label>
                                            <label class="title col-xs-4" id="receiveUserTelephone_audit"></label>
                                          </div>
                                          <hr class="tree"></hr>
                                          <div class="add-item col-xs-12">
                                            <label class="title col-xs-2">接车联系人：</label>
                                            <label class="title col-xs-4" id="receiveUser_audit"></label>
                                            <label class="title col-xs-2">接车联系人手机：</label>
                                            <label class="title col-xs-4" id="receiveUserMobile_audit"></label>
                                          </div>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">始发地：</label>
                                          <label class="title col-xs-10" id="startAddress_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">目的地：</label>
                                          <label class="title col-xs-10" id="targetAddress_audit"></label>
                                        </div>
                                        <div id="hiddens4">
                                          <hr class="tree"></hr>
                                          <div class="add-item col-xs-12">
                                            <label class="title col-xs-2">目的省 ：</label>
                                            <label class="title col-xs-10" id="targetProvince_audit"></label>
                                          </div>
                                        </div>
                                        <div id="hiddens3">
                                          <hr class="tree"></hr>
                                          <div class="add-item col-xs-12">
                                            <label class="title col-xs-2">总路程 ：</label>
                                            <label class="title col-xs-10" id="distance_audit"></label>
                                          </div>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item-btn" id="detilbtn" style="margin-left:0px;">
                                          <a class="add-itemBtn" onclick="getdetil();">运单明细</a></div>
                                      </div>
                                      <div id="scheduleBill_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">调度单：</label>
                                          <label class="title col-xs-4" id="scheduleBillNo_audit"></label>
                                          <!-- <label class="title col-xs-2">交车日期：</label><label class="title col-xs-4" id="receiveTime_audit"></label>	 --></div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12" id="fastsched">
									  <label class="title col-xs-2">装运日期：</label> 
									  <label class="title col-xs-4" id="shnsendTimes_audit"></label>																
									  </div>
									 <div class="add-item col-xs-12" id="schedatbill">
									<label class="title col-xs-2">发车日期：</label> 
									<label class="title col-xs-4" id="shnsendTime_audit"></label>
									<label class="title col-xs-2">交车日期：</label> 
									<label class="title col-xs-4" id="receiveTime_audit"></label>
									</div>
									<hr class="tree"></hr>
									<div class="add-item col-xs-12">
									<label class="title col-xs-2">台数：</label> 
									<label class="title col-xs-4" id="schamount_audit"></label> 
									<label class="title col-xs-2">装运车号：</label> 
									<label class="title col-xs-4" id="carNumber_audit"></label>
									</div>                                       
                                    <hr class="tree"></hr>
                                    <div class="add-item col-xs-12">
									<label class="title col-xs-2">驾驶员：</label> 
									<label class="title col-xs-4" id="driver_audit"></label> 
									<label class="title col-xs-2">备注：</label> 
									<label class="title col-xs-4" id="mark_audit"></label>
									</div>
                                        <hr class="tree"></hr>
                                        <div class="add-item-btn" id="detilbtns" style="margin-left:0px;">
                                          <a class="add-detilBtn" onclick="getdetils();">调度单明细</a></div>
                                      </div>
                                      <div class="add-item-btn" id="fastdetilbtns" style="margin-left: 0px;">
									  <a class="add-detilBtn" onclick="fastgetdetils();">调度单明细</a>
									  </div>
                                      <div id="changeCar_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">调度单：</label>
                                          <label class="title col-xs-4" id="scheduleBillNo_changeCar"></label>
                                          <!-- <label class="title col-xs-2">交车日期：</label><label class="title col-xs-4" id="receiveTime_audit"></label>	 --></div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">装运车号：</label>
                                          <label class="title col-xs-4" id="oldCarNumber_changeCar"></label>
                                          <label class="title col-xs-2">新装运车号：</label>
                                          <label class="title col-xs-4" id="newCarNumber_changeCar"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">驾驶员：</label>
                                          <label class="title col-xs-4" id="oldDriver_changeCar"></label>
                                          <label class="title col-xs-2">新驾驶员：</label>
                                          <label class="title col-xs-4" id="newDriver_changeCar"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">原因：</label>
                                          <label class="title col-xs-4" id="reason_changeCar"></label>
                                          <!-- <label class="title col-xs-2">目的地：</label><label class="title col-xs-4" id="endAddress_audit"></label>		 --></div>
                                        <hr class="tree"></hr>
                                        <div class="add-item-btn" id="mesg_detilbtn" style="margin-left:0px;">
                                          <a class="add-detilBtn" onclick="getmesgdetils();">换车申请明细</a></div>
                                      </div>
                                      <div id="Prepay_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">装运车号：</label>
                                          <label class="title col-xs-4" id="prepayCarNumber_audit"></label>
                                          <label class="title col-xs-2">申请时间：</label>
                                          <label class="title col-xs-4" id="applyTime_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">驾驶员：</label>
                                          <label class="title col-xs-4" id="prepaydriver_audit"></label>
                                          <label class="title col-xs-2">联系电话：</label>
                                          <label class="title col-xs-4" id="prepaymobile_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">预付现金：</label>
                                          <label class="title col-xs-4" id="prepayCash_audit"></label>
                                          <label class="title col-xs-2">开户行：</label>
                                          <label class="title col-xs-4" id="bankName_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">账户：</label>
                                          <label class="title col-xs-4" id="bankAccount_audit"></label>
                                          <label class="title col-xs-2">预付油卡卡号：</label>
                                          <label class="title col-xs-4" id="oilCardNo_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">预付邮费：</label>
                                          <label class="title col-xs-4" id="oilAmount_audit"></label>
                                          <label class="title col-xs-2">备注：</label>
                                          <label class="title col-xs-4" id="prepaymark_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item-btn" id="prepay_detilbtn" style="margin-left:0px;">
                                          <a class="add-itemBtn" onclick="getPrepaydetils();" style="width:130px;">装运预付申请明细</a></div>
                                      </div>
                                      <div id="trackTyreInOut_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">单据号：</label>
                                          <label class="title col-xs-4" id="tyreInOutno_audit"></label>
                                          <label class="title col-xs-2">类型：</label>
                                          <label class="title col-xs-4" id="tyreInOuttype_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">备注：</label>
                                          <label class="title col-xs-10" id="tyreInOutmark_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">轮胎：</label>
                                          <table id="tyreNo_detailtable" class="table table-striped table-bordered table-hover" style="margin-bottom: 10px;">
                                            <thead>
                                              <tr>
                                                <th>序号</th>
                                                <th>轮胎编号</th>
                                                <th>尺寸</th>
                                                <th>备注</th></tr>
                                            </thead>
                                            <tbody></tbody>
                                          </table>
                                        </div>
                                      </div>
                                      <div id="trackMaint_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">货运车号：</label>
                                          <label class="title col-xs-4" id="maintcarNumber_audit"></label>
                                          <label class="title col-xs-2">目前公里数：</label>
                                          <label class="title col-xs-4" id="maintcurMile_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">保养费用：</label>
                                          <label class="title col-xs-4" id="maintamount_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">保养详情：</label>
                                          <label class="title col-xs-4" id="maintdetailInfo_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">备注：</label>
                                          <label class="title col-xs-10" id="maintmark_audit"></label>
                                        </div>
                                      </div>
                                      <div id="portCost_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">调度单号：</label>
                                          <label class="title col-xs-4" id="scheduleBillNo_port"></label>
                                          <label class="title col-xs-2">报账时间：</label>
                                          <label class="title col-xs-4" id="applyTime_port"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">装运车号：</label>
                                          <label class="title col-xs-4" id="carNumber_port"></label>
                                          <label class="title col-xs-2">主驾驶员：</label>
                                          <label class="title col-xs-4" id="driver_port"></label>
                                        </div>
                                        <hr class="tree"></hr>
										<div class="add-item col-xs-12">
											<label class="title col-xs-2">副驾驶员：</label> 
											<label class="title col-xs-4" id="codriver_port"></label> 
										</div>
                                        <hr class="tree"></hr>
                                        <div class="add-item-btn" id="portCost_detilbtn" style="margin-left:0px;">
                                          <a class="add-itemBtn" onclick="getportCostdetils();" style="width:140px;">装费用核算申请明细</a></div>
                                      </div>
                                      <div id="officeapply_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">业务流程：</label>
                                          <label class="title col-xs-4" id="process_off"></label>
                                          <label class="title col-xs-2">项目名称：</label>
                                          <label class="title col-xs-4" id="itemName_off"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">金额：</label>
                                          <label class="title col-xs-4" id="amount_off"></label>
                                          <label class="title col-xs-2">预付现金：</label>
                                          <label class="title col-xs-4" id="cashAdvance_off"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">开始时间：</label>
                                          <label class="title col-xs-4" id="startTime_off"></label>
                                          <label class="title col-xs-2">结束时间：</label>
                                          <label class="title col-xs-4" id="endTime_off"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">备注：</label>
                                          <label class="title col-xs-10" id="mark_off"></label>
                                        </div>
                                      </div>
                                      <div id="trackchange_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">装运车号：</label>
                                          <label class="title col-xs-4" id="carNumber_chge"></label>
                                          <label class="title col-xs-2">申请时间：</label>
                                          <label class="title col-xs-4" id="applyTime_chge"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">原轮胎：</label>
                                          <label class="title col-xs-2" id="oldNo_chge"></label><label class="title col-xs-2" id="oldfilename-view"></label>
                                          <label class="title col-xs-2">新轮胎：</label>
                                          <label class="title col-xs-2" id="newNo_chge"></label><label class="title col-xs-2" id="newfilename-view"></label>
                                        </div>                                      
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">备注：</label>
                                          <label class="title col-xs-10" id="mark_chge"></label>
                                        </div>
                                      </div>
                                      <div id="carfeedback_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">装运时间：</label>
                                          <label class="title col-xs-4" id="transportTime_fbck"></label>
                                          <label class="title col-xs-2">车型：</label>
                                          <label class="title col-xs-4" id="carType_fbck"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">经销单位：</label>
                                          <label class="title col-xs-4" id="carShopId_fbck"></label>
                                          <label class="title col-xs-2">联系方式：</label>
                                          <label class="title col-xs-4" id="linkMobile_fbck"></label>
                                        </div>                                      
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">备注：</label>
                                          <label class="title col-xs-10" id="mark_fbck"></label>
                                        </div>
                                      </div>
                                      <div id="cardagout_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item row">
                                          <label class="title col-xs-2">申请时间：</label>
                                          <label class="title col-xs-4" id="insertTime_dagout"></label>    
                                          <label class="title col-xs-2">出库原因：</label>
                                          <label class="title col-xs-4" id="mark_dagout"></label>                                          
                                        </div>
                                        <div class="add-item row">
                                          <label class="title">折损车</label>
                                        <table id="cardagout_dagout" class="table table-striped table-bordered table-hover">
                                          <thead>
                                            <tr>
                                                <th>序号</th>	
												<th>车架号</th>
												<th>车型</th>
												<th>颜色</th>
	                    						<th>入库时间</th>
	                    						<th>品牌</th>
	                    						<th>存放位置</th>
	                    						<th>价格</th></tr>
                                          </thead>
                                          <tbody></tbody>
                                        </table>                                        
                                        </div>                                                                                                                  
                                      </div>
                                      <div id="cardamgcost_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item row">
                                          <label class="title col-xs-2">处理类型：</label>
                                          <label class="title col-xs-4" id="type_damgcost"></label>
                                          <label class="title col-xs-2">调度单号：</label>
                                          <label class="title col-xs-4" id="scheduleno_damgcost"></label>                                          
                                        </div>
                                         <hr class="tree"></hr> 
                                         <div class="add-item row">
                                          <label class="title col-xs-2">开户行：</label>
                                          <label class="title col-xs-4" id="bankName_damgcost"></label>
                                          <label class="title col-xs-2">名称：</label>
                                          <label class="title col-xs-4" id="accountName_damgcost"></label>                                          
                                        </div> 
                                         <hr class="tree"></hr>
                                        <div class="add-item row">
                                          <label class="title col-xs-2">账号：</label>
                                          <label class="title col-xs-4" id="accountNo_damgcost"></label>
                                          <label class="title col-xs-2">总金额：</label>
                                          <label class="title col-xs-4" id="amount_damgcost"></label>                                          
                                        </div>
                                         <hr class="tree"></hr>
                                         <div class="add-item row">
                                          <label class="title col-xs-2">是否走保险：</label>
                                          <label class="title col-xs-4" id="insuranceFlag_damgcost"></label>
                                          <label class="title col-xs-2">情况说明：</label>
                                          <label class="title col-xs-4" id="mark_damgcost"></label>                                          
                                        </div> 
                                         <hr class="tree"></hr>
                                         <div class="add-item row">
                                          <label class="title col-xs-2">上传凭证：</label>
                                          <label class="title col-xs-10" id="file_damgcost"></label>                                                                              
                                        </div>
                                         <hr class="tree"></hr>
                                        <div class="add-item-btn" id="damgcost_detilbtn" style="margin-left:0px;">
                                          <a class="add-itemBtn" onclick="getdamgcostdetil();" style="width:130px;">折损车明细</a></div>                                                                                                                                                                                 
                                      </div>
                                      <div id="sendCar_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item row">
                                          <label class="title col-xs-2">装运车号：</label>
                                          <label class="title col-xs-4" id="carNumber_sedcar"></label>                                                                                 
                                        </div>
                                         <hr class="tree"></hr> 
                                         <div class="add-item row">
                                          <label class="title col-xs-2">始发地：</label>
                                          <label class="title col-xs-4" id="startAddress_sedcar"></label>
                                          <label class="title col-xs-2">目的地：</label>
                                          <label class="title col-xs-4" id="endAddress_sedcar"></label>                                          
                                        </div>                                                                                                                                                                 
                                      </div>
                                                        <!-- 办公费用申请信息-新 -->
														<div id="officeapplynew_msg" style="display:none">
															<hr class="tree"></hr>
															<div class="add-item col-xs-12">
																<label class="title col-xs-2">申请部门：</label> 
																<label class="title col-xs-4" id="dep_offnew"></label> 
																<label class="title col-xs-2">申请人：</label> 
																<label class="title col-xs-4" id="applyUser_offnew"></label>
															</div>
															<hr class="tree"></hr>
															<div class="add-item col-xs-12">
																<label class="title col-xs-2">费用类型：</label> 
																<label class="title col-xs-4" id="type_offnew"></label> 
																<label class="title col-xs-2">申请时间：</label> 
																<label class="title col-xs-4" id="applyTime_offnew"></label>
															</div>
															<hr class="tree"></hr>
															<div class="add-item col-xs-12">
																<label class="title col-xs-2">项目名称：</label> 
																<label class="title col-xs-4" id="name_offnew"></label> 
																<label class="title col-xs-2">金额：</label> 
																<label class="title col-xs-4" id="amount_offnew"></label>
															</div>
															<hr class="tree"></hr>
															<div class="add-item col-xs-12">
																<label class="title col-xs-2">开始时间：</label> 
																<label class="title col-xs-4" id="startTime_offnew"></label> 
																<label class="title col-xs-2">结束时间：</label> 
																<label class="title col-xs-4" id="endTime_offnew"></label>
															</div>
															<hr class="tree"></hr>
															<div class="add-item col-xs-12">
																<label class="title col-xs-2">备注：</label> 
																<label class="title col-xs-10" id="mark_offnew"></label>
															</div>
														</div>
														<!-- 核销费用申请信息-新 -->
														<div id="costapply_msg" style="display:none">
															<hr class="tree"></hr>
															<div class="add-item col-xs-12">
																<label class="title col-xs-2">预付申请单号：</label> 
																<label class="title col-xs-4" id="sbillNoInfo_costaply"></label> 
																<label class="title col-xs-2">申请部门：</label> 
																<label class="title col-xs-4" id="sdepName_costaply"></label>
															</div>
															<hr class="tree"></hr>
															<div class="add-item col-xs-12">
																<label class="title col-xs-2">申请人：</label> 
																<label class="title col-xs-4" id="sapplyName_costaply"></label> 
																<label class="title col-xs-2">申请时间：</label> 
																<label class="title col-xs-4" id="sapplyTime_costaply"></label>
															</div>
															<hr class="tree"></hr>
															<div class="add-item col-xs-12">
																<label class="title col-xs-2">预付金额：</label> 
																<label class="title col-xs-4" id="spreAmount_costaply"></label> 
																<label class="title col-xs-2">实际使用金额：</label> 
																<label class="title col-xs-4" id="scostAmount_costaply"></label>
															</div>
															<hr class="tree"></hr>
															<div class="add-item col-xs-12">
																<label class="title col-xs-2">应退还金额：</label> 
																<label class="title col-xs-4" id="sreturnAmount_costaply"></label> 																
															</div>
														</div>
														<!-- 轮胎采购申请-新 -->
														<div id="buyapply_msg" style="display:none">
															<hr class="tree"></hr>
															<div class="add-item col-xs-12">
																<label class="title col-xs-2">申请部门：</label> 
																<label class="title col-xs-4" id="sdepInfo_buyapply"></label> 
																<label class="title col-xs-2">申请人：</label> 
																<label class="title col-xs-4" id="sapplyUserInfo_buyapply"></label>
															</div>
															<hr class="tree"></hr>
															<div class="add-item col-xs-12">
																<label class="title col-xs-2">类型：</label> 
																<label class="title col-xs-4" id="stypeInfo_buyapply"></label> 
																<label class="title col-xs-2">品牌：</label> 
																<label class="title col-xs-4" id="sbrandInfo_buyapply"></label>
															</div>
															<hr class="tree"></hr>
															<div class="add-item col-xs-12">
																<label class="title col-xs-2">尺寸：</label> 
																<label class="title col-xs-4" id="ssizeInfo_buyapply"></label> 
																<label class="title col-xs-2">数量：</label> 
																<label class="title col-xs-4" id="ssumInfo_buyapply"></label>
															</div>
															<hr class="tree"></hr>
															<div class="add-item col-xs-12">
																<label class="title col-xs-2">价格(元)：</label> 
																<label class="title col-xs-4" id="spriceInfo_buyapply"></label> 																
															</div>
															<hr class="tree"></hr>
															<div class="add-item col-xs-12">
																<label class="title col-xs-2">情况说明：</label> 
																<label class="title col-xs-10" id="smarkInfo_buyapply"></label> 																
															</div>
														</div>
                                      <hr class="tree"></hr>
                                      <div class="add-item">
                                        <label class="title tobold">操作日志信息</label>
                                        <table id="taskHistory_view" class="table table-striped table-bordered table-hover">
                                          <thead>
                                            <tr>
                                              <th>序号</th>
                                              <th>流程步骤名称</th>
                                              <th>操作人名称</th>
                                              <th>操作时间</th>
                                              <th>审核意见</th>
                                              <th>附件</th></tr>
                                          </thead>
                                          <tbody></tbody>
                                        </table>
                                      </div>
                                      <hr class="tree"></hr>
                                       
                                      <div class="add-item" id="hidden7">
                                        <label class="title tobold">审核信息</label></div>
                                       
                                      <div class="add-item col-xs-12" style="margin-bottom: 10px;" id="stephidden">
															<label class="title col-xs-2">当前流程步骤：</label> 
															<label class="title col-xs-10 red" id="name_mesg"></label>
														</div>
														<div class="add-item col-xs-12" style="margin-bottom: 10px;" id="hidden8">
															<label class="title col-xs-2">新装运车号：</label>
															<div class="col-xs-4">
																<select class="form-control" id="newcarNumber_audit">
																	<option value="">请选择装运车号</option>
																</select>
															</div>
															<label class="title col-xs-2">新驾驶员：</label>
															<div class="col-xs-4">
																<input class="form-control" id="newdriver_audit" type="text" readonly="readonly" placeholder="请输入驾驶员" />
																<input class="form-control" id="newdriver_audit_id" type="hidden" readonly="readonly"  />
															</div>
														</div>
														<div class="add-item col-xs-12" style="margin-bottom: 10px;" id="hidden2" >
															<label class="title col-xs-2"> 
															<span class="red" id="needSuggestFlag_audit" >*</span>审核意见： </label>
															<div class="col-xs-10" id="hidden5">
																<textarea rows="4" cols="4" class="form-control" id="audit_mesg" placeholder="请输入审核意见"></textarea>
															</div>
														</div>
														<div id="hiddeffice">
															<!--  <div class="add-item col-xs-12" >
                                                            <label class="title tobold ">预付信息</label></div> -->
															<div class="add-item col-xs-12" style="margin-bottom: 10px; padding-top: 15px;">
																<label class="title col-xs-2"><span class="red" id="speds_audit" style="display: none;">*</span>确认金额：</label>
																<div class="col-xs-8">
																	<input class="form-control" id="cashAdvance_audit" type="text" placeholder="请输入确认金额" onblur="revaildate(this,0);" />
																</div>
															</div>
														</div>
														<div id="hiddenprotes">
															<div class="add-item col-xs-12" style="margin-bottom: 10px; padding-top: 15px;">
																<label class="title col-xs-2"><span class="red">*</span>公里数：</label>
																<div class="col-xs-2">
																	<input class="form-control" id="distance_portes" type="text" placeholder="请输入公里数" onblur="revaildate(this,2);" />
																</div>
																<label class="title col-xs-1"><span class="red">*</span>罚款：</label>
																<div class="col-xs-3">
																	<input class="form-control" id="amerce_portes" type="text" placeholder="请输入罚款" onblur="revaildate(this,3);" />
																</div>
																<label class="title col-xs-1"><span class="red">*</span>油价：</label>
																<div class="col-xs-3">
																	<input class="form-control" id="oilPrice_portes" type="text" placeholder="请输入油价" onblur="revaildate(this,4);" />
																</div>
															</div>
														</div>

														<div id="hiddenpre">
															<!-- <div class="add-item col-xs-12" >
                                                             <label class="title tobold ">结付信息</label></div> -->
															<div class="add-item col-xs-12" style="margin-bottom: 10px; padding-top: 15px;">
																<label class="title col-xs-2" style="width:180px;"><span class="red">*</span>实付现金(当月实付)：</label>
																<div class="col-xs-2" style="margin-left:-20px;">
																	<input class="form-control" id="balanceCash_audit" type="text" placeholder="请输入实付现金" onblur="revaildate(this,1);" />
																</div>
																<div id="balanceCashNextMonth">
																<label class="title col-xs-2"><span class="red">*</span>下月实付现金：</label>
																<div class="col-xs-2" style="margin-left:-30px;width: 180px;">
																	<input class="form-control" id="balanceCashNextMonth_audit" type="text" placeholder="请输入下月实付现金" onblur="revaildate(this,5);"/>
																</div>
																</div>
                                                                
																<label class="title col-xs-2"><span class="red">*</span>实付油费：</label>
																<div class="col-xs-2" style="margin-left:-30px;width: 180px;">
																	<input class="form-control" id="balanceOil_audit" type="text" placeholder="请输入驾驶员油卡" />
																</div>
															</div>
														</div>
                                      
                                        <!-- <div class="add-item col-xs-12" style="margin-bottom: 10px;margin-top: 20px;" id="hidden6">
                                          <label class="title col-xs-2">附件 ：</label>
                                          <div class="col-xs-10">
                                            <input type="file" id="inputfile" />
                                            <label class="title" id="filename"></label>
                                            <input type="hidden" name="filename_hidden" id="filename_hidden" />
                                            <input type="hidden" name="filepath_hidden" id="filepath_hidden" /></div>
                                        </div> -->
                                      
                                     
                                      <div class="add-item-btn" id="auditBtn">
                                       <button class="btn btn-primary btnOk" type="button" onclick="waybillaudit('Y');" id="ybtn" style="margin-left: 380px;">通过</button>
                                      <button class="btn btn-primary btnOk" type="button" onclick="waybillaudit('N');" id="nbtn" >不通过</button>                                       
                                       <!--  <a class="add-itemBtn btnOk" onclick="waybillaudit('Y');" style="margin-left: 180px;">通过</a>
                                        <a class="add-itemBtn btnOk" onclick="waybillaudit('N');">不通过</a> -->
                                        <!-- <a class="add-itemBtn btnOk" onclick="refresh();">取消</a> --></div>
                                      <div class="add-item-btn" id="confirmBtn">
                                      <button class="btn btn-primary btnOk" type="button" onclick="waybillconfirm();" id="cbtn" style="margin-left: 380px;">确认</button>
                                        <!-- <a class="add-itemBtn btnOk" onclick="waybillconfirm();" style="margin-left: 180px;">确认</a> -->
                                        <!-- <a class="add-itemBtn btnOk" onclick="refresh();">取消</a> --></div>
                                      <div id="msglble" style="height: 70px;margin-top: 30px;">
                                        <label class="title">
                                          <span class="red">*请根据《操作日志信息》中的审核意见，修改后重新提交</span></label>
                                        <a onclick="newpage();" style="margin-left: 30px;">
                                          <img src="${ctx}/staticPublic/images/hand.png" style="width:30px;height:30px;" /></a>
                                        <!-- <button class="btn btn-app btn-pink btn-sm" onclick="openoper();"> <i class="ace-icon fa fa-share bigger-200"> </i> </button> --></div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
            <div class="modal fade" id="modal-waybilldetilinfo" tabindex="-1" role="dialog" data-backdrop="static">
                            <div class="modal-header">
                              <button class="close" type="button" data-dismiss="modal">×</button>
                              <h3 id="myModalLabel">运单信息</h3></div>
                            <div class="modal-body">
                              <div>
                                <div class="widget-box dia-widget-box">
                                  <div class="widget-body">
                                    <div class="widget-main">
                                      <div class="add-item col-xs-12">
                                        <label class="title col-xs-2">类型：</label>
                                        <label class="title col-xs-4" id="type_view"></label>
                                        <label class="title col-xs-2">运单编号：</label>
                                        <label class="title col-xs-4" id="waybillNo_view"></label>
                                      </div>
                                      <div id="hiddenes1">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">品牌：</label>
                                          <label class="title col-xs-4" id="brand_view"></label>
                                          <label class="title col-xs-2">经销单位：</label>
                                          <label class="title col-xs-4" id="carShopId_view"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">供应商：</label>
                                          <label class="title col-xs-4" id="supplierId_view"></label>
                                        </div>
                                      </div>
                                      <hr class="tree"></hr>
                                      <div class="add-item col-xs-12">
                                        <label class="title col-xs-2">下单日期：</label>
                                        <label class="title col-xs-4" id="sendTime_view"></label>
                                      </div>
                                      <div id="hiddenes2">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">运输价格：</label>
                                          <label class="title col-xs-4" id="amount_view"></label>
                                          <label class="title col-xs-2">接车联系人电话：</label>
                                          <label class="title col-xs-4" id="receiveUserTelephone_view"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">接车联系人：</label>
                                          <label class="title col-xs-4" id="receiveUser_view"></label>
                                          <label class="title col-xs-2">接车联系人手机：</label>
                                          <label class="title col-xs-4" id="receiveUserMobile_view"></label>
                                        </div>
                                      </div>
                                      <hr class="tree"></hr>
                                      <div class="add-item col-xs-12">
                                        <label class="title col-xs-2">始发地：</label>
                                        <label class="title col-xs-10" id="startAddress_view"></label>
                                      </div>
                                      <hr class="tree"></hr>
                                      <div class="add-item col-xs-12">
                                        <label class="title col-xs-2">目的地：</label>
                                        <label class="title col-xs-10" id="targetAddress_view"></label>
                                      </div>
                                      <div id="hiddenes4">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">目的省：</label>
                                          <label class="title col-xs-10" id="targetProvince_view"></label>
                                        </div>
                                      </div>
                                      <div id="hiddenes3">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">公里数：</label>
                                          <label class="title col-xs-10" id="distance_view"></label>
                                        </div>
                                      </div>
                                      <hr class="tree"></hr>
							          <div class="add-item col-xs-12">
							          <label class="title col-xs-2">附件：</label><label class="title col-xs-10" id="file_view"></label>							    								    
							          </div>
                                      <hr class="tree"></hr>
                                      <div class="add-item">
                                        <label class="title">商品车信息：</label>
                                        <table id="cardetable_view" class="table table-striped table-bordered table-hover">
                                          <thead>
                                            <tr>
                                              <th>序号</th>
                                              <th>类型</th>
                                              <!-- <th>供应商名称</th> -->
                                              <th>品牌</th>
                                              <th>车架号</th>
                                              <th>车型</th>
                                              <th>颜色</th>
                                              <th>发动机号</th>
                                              <th>备注</th>
                                              <!-- <th>状态</th>    --></tr>
                                          </thead>
                                          <tbody></tbody>
                                        </table>
                                      </div>
                                      <hr class="tree"></hr>
                                      <div class="add-item">
                                        <label class="title">配件信息：</label>
                                        <table id="attachmentdetable_view" class="table table-striped table-bordered table-hover">
                                          <thead>
                                            <tr>
                                              <th>序号</th>
                                              <th>配件名称</th>
                                              <th>存放位置</th>
                                              <th>台数</th>
                                              <th>备注</th>
                                              <!-- <th>状态</th>     --></tr>
                                          </thead>
                                          <tbody></tbody>
                                        </table>
                                      </div>
                                      <hr class="tree"></hr>
                                      <div class="add-item-btn" id="viewBtn">
                                        <a class="add-itemBtn btnCancle" onclick="doclose()">关闭</a></div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
            <div class="modal fade" id="modal-shedeinfo" tabindex="-1" role="dialog" data-backdrop="static">
                            <div class="modal-header">
                              <button class="close" type="button" data-dismiss="modal">×</button>
                              <h3 id="myModalLabel">调度单信息</h3></div>
                            <div class="modal-body">
                              <div>
                                <div class="widget-box dia-widget-box">
                                  <div class="widget-body">
                                    <div class="widget-main">
														<div class="mng">
		   <div class="table-tit">查看调度单<!-- <i class="icon-undo" style="display: inline-block;width: 20px;"></i> --></div>
		   <div class="table-item">
		     <div class="table-itemTit">基本信息</div>
		     <!-- 第一列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>发车日期:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="sendTime" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>交车日期:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="receiveTime" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>台数:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			         <p id="all-amount" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>装运车号:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <p id="carNumber" class="form-control no-border"></p>
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
				          <p id="driver" class="form-control no-border"></p>
				       </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>联系电话:</label>
				       </div>
			       </div>
				   <div class="col-xs-5">
				     <div class="form-contr">
				       <p id="mobile" class="form-control no-border"></p>
				     </div>
				   </div>
		     </div>
		     <!-- 第五列 -->
		     <div class="row newrow">
		        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>备注:</label>
			       </div>
		       </div>
			   <div class="col-xs-11">
			     <div class="form-contr">
			       <p id="mark" class="form-control no-border"></p>
			     </div>
			   </div>
			 </div>
			  <!-- 添加预付申请信息 -->
			 <div class="table-itemTit">预付申请信息</div>
			 <!-- 预付第一列 -->
			 <div id="prepayList">
		       
		     </div>
		     <!-- 预付第二列 -->
		     
			 <!-- 预付第三列 -->
		     
		     <!--设置商品车详细信息-->
		     <div class="row row-btn-tit" id="carDetail">
		        <div class="col-xs-2 pd-2">
			       <div class="row-tit">
			                           详细信息
			       </div>
		       </div>
		       <div class="col-xs-10" style=" text-align: right;margin-top:3px;"><a class="table-edit" onclick="doprint();" style=" width: 80px;">打印</a></div>
		     </div>
		     
		     
		     <!-- 操作按钮栏 -->
		     <div class="row newrow">
		       <div class="col-xs-5"></div>
		       <div class="col-xs-2">
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
                                </div>
                              </div>
                            </div>
                          </div>
            <!-- 装运预付申请信息 -->
             <div class="modal fade" id="modal-prepayinfo" tabindex="-1" role="dialog" data-backdrop="static">
                            <div class="modal-header">
                              <button class="close" type="button" data-dismiss="modal">×</button>
                              <h3 id="myModalLabel">装运预付信息</h3></div>
                            <div class="modal-body">
                              <div>
                                <div class="widget-box dia-widget-box">
                                  <div class="widget-body">
                                    <div class="widget-main">
                                      <div class="mng">
                                        <!-- <div class="table-tit">编辑调度单</div> -->
                                        <input type="hidden" id="listlength" />
                                        <div class="table-item">
                                          <div class="table-itemTit">基本信息</div>
                                          <!-- 第一列 -->
                                          <div class="row newrow">
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>装运车号:</label></div>
                                            </div>
                                            <div class="col-xs-5">
                                              <div class="form-contr">
                                                <p id="carNumber_pre" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>申请时间:</label></div>
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
                                                <label>驾驶员:</label></div>
                                            </div>
                                            <div class="col-xs-5">
                                              <div class="form-contr">
                                                <p id="driver_pre" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>联系电话:</label></div>
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
                                                <label>预付现金:</label></div>
                                            </div>
                                            <div class="col-xs-5">
                                              <div class="form-contr">
                                                <p id="prepayCash_pre" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>开户行:</label></div>
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
                                                <label>账号:</label></div>
                                            </div>
                                            <div class="col-xs-5">
                                              <div class="form-contr">
                                                <p id="bankAccount_pre" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>预付油卡卡号:</label></div>
                                            </div>
                                            <div class="col-xs-5">
                                              <div class="form-contr">
                                                <p id="oilCardNo_pre" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                          </div>
                                          <!-- 第五列 -->
                                          <div class="row newrow">
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>预付油费:</label></div>
                                            </div>
                                            <div class="col-xs-5">
                                              <div class="form-contr">
                                                <p id="oilAmount_pre" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>备注:</label></div>
                                            </div>
                                            <div class="col-xs-5">
                                              <div class="form-contr">
                                                <p id="mark_pre" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                          </div>
                                          <!--设置商品车详细信息-->
                                          <div class="row row-btn-tit" id="preDetail">
                                            <div class="col-xs-2 pd-2">
                                              <div class="row-tit">装运明细</div></div>
                                            <div class="col-xs-10"></div>
                                          </div>
                                          <!-- 操作按钮栏 -->
                                          <div class="row newrow">
                                            <div class="col-xs-5"></div>
                                            <div class="col-xs-2">
                                              <div class="form-contr">
                                                <a class="backbtn" onclick="dopreback();">
                                                  <i class="icon-undo" style="display: inline-block;width: 20px;"></i>关闭</a>
                                              </div>
                                            </div>
                                            <div class="col-xs-5"></div>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
			<!-- 装运费用核算信息 -->
			<div class="modal fade" id="modal-portcostinfo" tabindex="-1" role="dialog" data-backdrop="static">
									<div class="modal-header">
										<button class="close" type="button" data-dismiss="modal">×</button>
										<h3 id="myModalLabel">装运费用核算信息</h3>
									</div>
									<div class="modal-body">
										<div>
											<div class="widget-box dia-widget-box">
												<div class="widget-body">
													<div class="widget-main">
														<div class="mng">
															<div class="table-item">
																<div class="table-itemTit">基本信息</div>
																<!-- 第一列 -->
																<div class="row newrow">
																	<div class="col-xs-1 pd-2">
																		<div class="lab-tit">
																			<label>调度单号:</label>
																		</div>
																	</div>
																	<div class="col-xs-5">
																		<div class="form-contr">
																			<p class="form-control no-border" id="scheduleBillNo_prt"></p>
																		</div>
																	</div>
																	<div class="col-xs-1 pd-2">
																		<div class="lab-tit">
																			<label>报账时间:</label>
																		</div>
																	</div>
																	<div class="col-xs-5">
																		<div class="form-contr">
																			<p class="form-control no-border" id="applyTime_prt"></p>
																		</div>
																	</div>
																</div>
																<div class="row newrow">
																	<div class="col-xs-1 pd-2">
																		<div class="lab-tit">
																			<label>装运车号:</label>
																		</div>
																	</div>
																	<div class="col-xs-5">
																		<div class="form-contr">
																			<p class="form-control no-border" id="carNumber_prt"></p>
																		</div>
																	</div>
																	<div class="col-xs-1 pd-2">
																		<div class="lab-tit">
																			<label>驾驶员:</label>
																		</div>
																	</div>
																	<div class="col-xs-5">
																		<div class="form-contr">
																			<p class="form-control no-border" id="driver_prt"></p>
																		</div>
																	</div>
																</div>
																<div class="row newrow">
																	<div class="col-xs-1 pd-2">
																		<div class="lab-tit">
																			<label>副驾驶员:</label>
																		</div>
																	</div>
																	<div class="col-xs-5">
																		<div class="form-contr">
																			<p class="form-control no-border" id="codriver_prt"></p>
																		</div>
																	</div>																	
																</div>
																<!--设置详细信息-->
																<div class="table-itemTit">明细信息</div>
																<!-- 第一条详细信息 -->
																<div id="detailList" class="detailList">
																	<!-- 第三列 -->
																	<div class="row newrow">
																		<div class="col-xs-1 pd-2">
																			<div class="lab-tit">
																				<label>品牌:</label>
																			</div>
																		</div>
																		<div class="col-xs-5">
																			<div class="form-contr">
																				<p class="form-control no-border" id="brandName_prt"></p>
																			</div>
																		</div>
																		<div class="col-xs-1 pd-2">
																			<div class="lab-tit">
																				<label>发车时间:</label>
																			</div>
																		</div>
																		<div class="col-xs-5">
																			<div class="form-contr">
																				<p class="form-control no-border" id="sendTime_prt"></p>
																			</div>
																		</div>
																	</div>
																	<!-- 第四列 -->
																	<div class="row newrow">
																		<div class="col-xs-1 pd-2">
																			<div class="lab-tit">
																				<label>交车时间:</label>
																			</div>
																		</div>
																		<div class="col-xs-5">
																			<div class="form-contr">
																				<p class="form-control no-border" id="receiveTime_prt"></p>
																			</div>
																		</div>
																		<div class="col-xs-1 pd-2">
																			<div class="lab-tit">
																				<label>台数:</label>
																			</div>
																		</div>
																		<div class="col-xs-5">
																			<div class="form-contr">
																				<p class="form-control no-border" id="amount_prt"></p>
																			</div>
																		</div>
																	</div>
																	<!-- 第五列 -->
																	<div class="row newrow">
																		<div class="col-xs-1 pd-2">
																			<div class="lab-tit">
																				<label>起运地:</label>
																			</div>
																		</div>
																		<div class="col-xs-5">
																			<div class="form-contr">
																				<p class="form-control no-border" id="startAddress_prt"></p>
																			</div>
																		</div>
																		<div class="col-xs-1 pd-2">
																			<div class="lab-tit">
																				<label>目的地:</label>
																			</div>
																		</div>
																		<div class="col-xs-5">
																			<div class="form-contr">
																				<p class="form-control no-border" id="endAddress_prt"></p>
																			</div>
																		</div>
																	</div>
																	<!-- 油费 -->
																	<div class="row bor-b-ff9a00">
			                                                         <label class="f-s14">里程油费核算</label>
		                                                            </div>
																	<div class="row newrow">
																		<div class="col-xs-1 pd-2">
																			<div class="lab-tit">
																				<label>公里数:</label>
																			</div>
																		</div>
																		<div class="col-xs-5">
																			<div class="form-contr">
																				<p class="form-control no-border" id="distance_prt"></p>
																			</div>
																		</div>
																		<div class="col-xs-1 pd-2">
																			<div class="lab-tit">
																				<label>指定油耗:</label>
																			</div>
																		</div>
																		<div class="col-xs-5">
																			<div class="form-contr">
																				<p class="form-control no-border" id="standardOilWear_prt"></p>
																			</div>
																		</div>
																	</div>
																	<div class="row newrow bor-b-ff9a00-1">
																		<div class="col-xs-1 pd-2">
																			<div class="lab-tit">
																				<label>指定油价:</label>
																			</div>
																		</div>
																		<div class="col-xs-5">
																			<div class="form-contr">
																				<p class="form-control no-border" id="oilPrice_prt"></p>
																			</div>
																		</div>
																		<div class="col-xs-1 pd-2">
																			<div class="lab-tit">
																				<label>油费:</label>
																			</div>
																		</div>
																		<div class="col-xs-5">
																			<div class="form-contr">
																				<p class="form-control no-border" id="oilAmount_prt"></p>
																			</div>
																		</div>
																	</div>
																	 <!-- 费用明细 -->
		                                                             <div class="row bor-b-ff9a00">
			                                                           <label class="f-s14">费用明细</label>
		                                                             </div>
		                                                              <div class="catoList">
		                                                                <div id="cataListItem_prt">		            
		                                                                </div>			      
		                                                              </div>
                                                                          <!-- 是否折现 -->
		                                                             <div class="row newrow bor-b-ff9a00-1">
			                                                           <div class="col-xs-1 pd-2">
				                                                         <div class="lab-tit">
				                                                            <label>是否折现:</label>
				                                                          </div>
			                                                          </div>
			                                                             <div class="col-xs-2">
			                                                               <div class="form-contr">
			                                                                 <p id="discountFlag_prt" class="form-control no-border"></p>
			                                                                </div>
			                                                               </div>
			                                                             <div class="col-xs-9"></div>
		                                                               </div>

																	<!--预付信息-->
																	<div class="table-itemTit bor-t-ff9a00">预付信息</div>
																	<div id="prepayList_prt"></div>
																	<!-- <div class="row newrow">
																		<div class="col-xs-1 pd-2">
																			<div class="lab-tit">
																				<label>预付时间:</label>
																			</div>
																		</div>
																		<div class="col-xs-5">
																			<div class="form-contr">
																				<p class="form-control no-border"
																					id="preApplyTime0_prt"></p>
																			</div>
																		</div>
																		<div class="col-xs-6"></div>
																	</div> -->
																	<!-- 现金 -->
																	<!-- <div class="row newrow bor-b-ff9a00-1">
																		<div class="col-xs-1 pd-2">
																			<div class="lab-tit">
																				<label>现金金额:</label>
																			</div>
																		</div>
																		<div class="col-xs-5">
																			<div class="form-contr">
																				<p class="form-control no-border"
																					id="preAmount0_prt"></p>
																			</div>
																		</div>
																		<div class="col-xs-1 pd-2">
																			<div class="lab-tit">
																				<label>油卡金额:</label>
																			</div>
																		</div>
																		<div class="col-xs-5">
																			<div class="form-contr">
																				<p class="form-control no-border"
																					id="preAmount1_prt"></p>
																			</div>
																		</div>
																	</div> -->
																	<!--费用小计信息-->
																	   <!--费用小计信息-->
		     <div class="table-itemTit bor-b-ff9a00">费用小计</div> 
		     <div class="row newrow">
		           <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>报账现金(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="sumMoney"></p>
			           </div>
			       </div>
			       <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>报账油费(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="oilMoney"></p>
			           </div>
			       </div>
		      </div>
		      <div class="row newrow">
		           <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>预付现金(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="sumMoneyPre"></p>
			           </div>
			       </div>
			       <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>预付油费(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="oilMoneyPre"></p>
			           </div>
			       </div>
		      </div>
		      <div class="row newrow">
		           <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>应付现金(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="sumMoneyActual"></p>
			           </div>
			       </div>
			       <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>应付油费(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="oilMoneyActual"></p>
			           </div>
			       </div>
		      </div>
		      <div class="row newrow" id="discountMoneyInfo">
		           <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>折现后应付现金(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="sumMoneyDiscount"></p>
			           </div>
			       </div>
			       <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>折现后应付油费(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="oilMoneyDiscount"></p>
			           </div>
			       </div>
		      </div>
			  <div class="row newrow">
		           <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>实付现金(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="sumMoneyNew"></p>
			           </div>
			       </div>
			       <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>实付油费(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="oilMoneyNew"></p>
			           </div>
			       </div>
		      </div>
		   </div>
																<!-- 操作按钮栏 -->
																<div class="row newrow">
																	<div class="col-xs-5"></div>
																	<div class="col-xs-2">
																		<div class="form-contr">
																			<a class="backbtn" onclick="doportback();"> <i
																				class="icon-undo"
																				style="display: inline-block; width: 20px;"></i>关闭
																			</a>
																		</div>
																	</div>
																	<div class="col-xs-5"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
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
<script src="${ctx}/staticPublic/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
function init(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "destroy": true,//如果需要重新加载需销毁
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/dailyOffice/waitingDo/getListData" , //获取数据的ajax方法的URL							 
		 "ordering": false,	
			"oLanguage": {
				"sLengthMenu": "每页显示 _MENU_ 条记录",
				"sZeroRecords": "抱歉， 没有找到",
				"sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
				"sInfoEmpty": "没有数据",
				"sInfoFiltered": "(从 _MAX_ 条数据中检索)",
				"oPaginate": {
				"sFirst": "首页",
				"sPrevious": "上一页",
				"sNext": "下一页",
				"sLast": "尾页"
				},
				"sZeroRecords": "没有检索到数据"
				},		
		 columns: [{ data: "rownum",'width':'4%'},
		    {data: "itemName",'width':'15%'},
		    {data: "insertTime",'width':'15%'},
		    {data: "insertUserName",'width':'15%'},
		    {data: null,'width':'20%'}		    
			],
		    columnDefs: [{
					 //类型
					 targets:2,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
						
				     }	       
				},{
					 //状态
					 targets:4,
					 render: function (data, type, row, meta) {
						 if((${sessionScope.LMS_USER.id} == row.receiveUserId) && row.cancelFlag == 'Y')
							 return '<a class="table-edit" onclick="dosubmit('+ row.itemId +','+ row.processDetailId +','+ row.id +')">处理</a>'+
							 '&nbsp;&nbsp;<a class="table-edit" onclick="cancelTask('+ row.id +')">取消</a>';
							 return '<a class="table-edit" onclick="dosubmit('+ row.itemId +','+ row.processDetailId +','+ row.id +')">处理</a>';
				      }	       
				}
		      ],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
function reload(){
	//reload dataTables plugin
	var myTable = $('#detailtable').DataTable({
		"destroy": true,//如果需要重新加载需销毁
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/dailyOffice/waitingDo/getListData" , //获取数据的ajax方法的URL	
		 "ordering": false,	
		 "oLanguage": {
			"sLengthMenu": "每页显示 _MENU_ 条记录",
			"sZeroRecords": "抱歉， 没有找到",
			"sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
			"sInfoEmpty": "没有数据",
			"sInfoFiltered": "(从 _MAX_ 条数据中检索)",
			"oPaginate": {
			"sFirst": "首页",
			"sPrevious": "上一页",
			"sNext": "下一页",
			"sLast": "尾页"
			},
			"sZeroRecords": "没有检索到数据"
			},	
			columns: [{ data: "rownum",'width':'4%'},
					    {data: "itemName",'width':'15%'},
					    {data: "insertTime",'width':'15%'},
					    {data: "insertUserName",'width':'15%'},
					    {data: null,'width':'20%'}		    
						],
					    columnDefs: [{
								 //类型
								 targets:2,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }
									
							     }	       
							},{
								 //状态
								 targets:4,
								 render: function (data, type, row, meta) {									
									 if((${sessionScope.LMS_USER.id} == row.receiveUserId) && row.cancelFlag == 'Y')
										 return '<a class="table-edit" onclick="dosubmit('+ row.itemId +','+ row.processDetailId +','+ row.id +')">处理</a>'+
										  '&nbsp;&nbsp;<a class="table-edit" onclick="cancelTask('+ row.id +')">取消</a>';
										 return '<a class="table-edit" onclick="dosubmit('+ row.itemId +','+ row.processDetailId +','+ row.id +')">处理</a>';
										        					    		 
							      }	       
							}
					      ],
				        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

$(function(){
	init();
	//getCarNo();
})
/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					obj.iTotalDisplayRecords=data.data.totalCounts;
					obj.iTotalRecords=data.data.totalCounts;
					obj.aaData=data.data.records;		
					obj.sEcho=data.data.frontParams;
					if(obj.aaData.length>0){
						for(var i=0;i<obj.aaData.length;i++){
							obj.aaData[i]["rownum"]=i+1;
							if(obj.aaData[i]["insertUserName"]==undefined){
								obj.aaData[i]["insertUserName"]='';
							}
						}
					}else{
						obj.aaData=[];
					}
					fnCallback(obj); //服务器端返回的对象的returnObject部分是要求的格式  	
				} else {
					 bootbox.alert(data.msg);
				}
				
			}
		}); 
	   
	}
/* 查询 */
function searchInfo(){
	reload();	
	
}
/* 绑定货运车 */
function getStockList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/scheduleMng/getStockList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: JSON.stringify({}),
	        success: function (data) {
	        	var html ='<option value="" data-id="">请选择装运车号</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['no']+' data-driver='+data.data[i]['driver']+'>'+data.data[i]['no']+'</option>';
	                		}
	            		}
	            	}
	            	$('#newcarNumber_audit').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
}

//取消
function cancelTask(taskId)
{
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要取消该待办信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/dailyOffice/waitingDo/cancelTask/"+taskId,
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								 bootbox.confirm_alert({ 
									  size: "small",
									  message: "取消成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  reload();
										  }else{
											  reload();
										  }
									  }
								 });
								 setTimeout(function(){
										if(flag=="false"){
											reload();
											 $('.bootbox').modal('hide');
										}
									},3000);
							} else {
								 bootbox.alert(data.msg);
							}
							
						}
					}); 
			  }
		  }
 });
}

/* 获取要处理的代办事项信息 */
function dosubmit(itemId,processDetailId,taskId){
	getStockList();
	 /* 根据货运车绑定驾驶员 */
	  $('#newcarNumber_audit').on('change',function(e){
		  var newDriver=$(this).find('option:selected').attr('data-driver');		
		  $('#newdriver_audit').val(newDriver);
		 
	  });
	$('#hidden2').show();	
	$('#taskId-hidden').val(taskId);  
	 $.ajax({
			type : 'GET',
			url : "${ctx}/dailyOffice/waitingDo/getDetailInfoForItem/"+itemId,
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {							
					var businessType=data.data.businessType;
					$('#businessType-hidden').val(data.data.businessType);
					if(data.data.businessType=='01'){
						$('#waybill_msg').show();
						$('#scheduleBill_msg').hide();
						$('#hidden8').hide();
						/* $('#hidden6').show(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').hide();
						$('#damgcost_detilbtn').hide();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').hide();
						$('#hiddenprotes').hide();
						$('#detilbtn').show();							
						$('#modal-detilinfo').modal('show');						
						if(data.data.detail.type=='1'){
							$("#type_audit").html('二手车'); 
							$('#hiddens1').hide();
							$('#hiddens3').hide();
							$('#hiddens2').show();
							$('#hiddens4').hide();
						}else{
							$("#type_audit").html('商品车'); 
							$('#hiddens1').show();
							$('#hiddens2').hide();
							$('#hiddens3').hide();
							$('#hiddens4').hide();
						}						
						$('#waybillNo-hidden').val(data.data.detail.waybillNo);
						$("#waybillNo_audit").html(data.data.detail.waybillNo);
						$("#supplierId_audit").html(data.data.detail.supplierName); 
						$("#amount_audit").html(data.data.detail.amount); 
						$("#brand_audit").html(data.data.detail.brand); 
						$("#carShopId_audit").html(data.data.detail.carShopName);
						$("#sendTime_audit").html(data.data.detail.sendTime); 
						$("#receiveUser_audit").html(data.data.detail.receiveUser); 
						$("#receiveUserTelephone_audit").html(data.data.detail.receiveUserTelephone); 
						$("#receiveUserMobile_audit").html(data.data.detail.receiveUserMobile); 
						$("#startAddress_audit").html(data.data.detail.startAddress);
						$("#targetAddress_audit").html(data.data.detail.targetAddress);
						$("#distance_audit").html(data.data.detail.distance);	
						if(data.data.detail.id!=''){
							$('#waybillid-hidden').val(data.data.detail.id);	
						}
						
						
					}else if(data.data.businessType=='02'){
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').show();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').hide();
						$('#damgcost_detilbtn').hide();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').hide();
						if(data.data.detail.type=="1"){
							$('#fastdetilbtns').show();	
							$('#detilbtns').hide();	
							$('#fastsched').show();	
							$('#schedatbill').hide();	
						}else{
							$('#fastdetilbtns').hide();	
							$('#detilbtns').show();	
							$('#fastsched').hide();	
							$('#schedatbill').show();
						}
						$('#type-hidden').val(data.data.detail.type);
						$('#hidden8').hide();
						/* $('#hidden6').show(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#hiddenprotes').hide();
						$('#modal-detilinfo').modal('show');	
						$('#scheduleBillNo-hidden').val(data.data.detail.scheduleBillNo);
						$("#scheduleBillNo_audit").html(data.data.detail.scheduleBillNo);
						if(data.data.detail.sendTime!=''&&data.data.detail.sendTime!=null){
							$("#shnsendTime_audit").html(jsonForDateFormat(data.data.detail.sendTime)); 	
							$("#shnsendTimes_audit").html(jsonForDateFormat(data.data.detail.sendTime)); 
						}else{
							$("#shnsendTime_audit").html(''); 
							$("#shnsendTimes_audit").html('');
						}
						if(data.data.detail.receiveTime!=''&&data.data.detail.receiveTime!=null){
							$("#receiveTime_audit").html(jsonForDateFormat(data.data.detail.receiveTime)); 	
						}else{
							$("#receiveTime_audit").html(''); 
						}
						$("#schamount_audit").html(data.data.detail.amount); 
						if(data.data.detail.planReachTime!=''&&data.data.detail.planReachTime!=null){
							$("#planReachTime_audit").html(jsonForDateFormat(data.data.detail.planReachTime)); 	
						}else{
							$("#planReachTime_audit").html(''); 
						}
						$("#shnstartAddress_audit").html(data.data.detail.startAddress); 
						$("#endAddress_audit").html(data.data.detail.endAddress); 
						$("#carNumber_audit").html(data.data.detail.carNumber); 
						$("#driver_audit").html(data.data.detail.driverName); 
						$("#mark_audit").html(data.data.detail.mark);						
						if(data.data.detail.id!=''){
							$('#scheduleBillId-hidden').val(data.data.detail.id);	
						}
					}else if(data.data.businessType=='03'){
						
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#mesg_detilbtn').hide();
						$('#changeCar_msg').show();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').hide();
						$('#damgcost_detilbtn').hide();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').hide();
						$('#hidden8').show();
						/* $('#hidden6').hide(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#hiddenprotes').hide();
						//$('#mesg_detilbtn').show();						
						$('#modal-detilinfo').modal('show');	
						$('#scheduleBillNo-hidden').val(data.data.detail.scheduleBillNo);
						//$('#changecarId-hidden').val(data.data.detail.id);
						$("#scheduleBillNo_changeCar").html(data.data.detail.scheduleBillNo); 
						$("#oldCarNumber_changeCar").html(data.data.detail.oldCarNumber); 
						$("#oldDriver_changeCar").html(data.data.detail.oldDriver); 
						$("#newCarNumber_changeCar").html(data.data.detail.newCarNumber); 
						$("#newDriver_changeCar").html(data.data.detail.newDriver); 
						$("#reason_changeCar").html(data.data.detail.reason);											
						if(data.data.detail.id!=''){
							$('#changecarId-hidden').val(data.data.detail.id);	
						}
					}else if(data.data.businessType=='04'){
						
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#mesg_detilbtn').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').show();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').hide();
						$('#damgcost_detilbtn').hide();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').hide();
						$('#hidden8').hide();
						/* $('#hidden6').show(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#hiddenprotes').hide();
						$('#prepay_detilbtn').show();						
						$('#modal-detilinfo').modal('show');	
						$("#prepayCarNumber_audit").html(data.data.detail.carNumber); 
						if(data.data.detail.applyTime!=''&&data.data.detail.applyTime!=null){
							$("#applyTime_audit").html(jsonForDateFormat(data.data.detail.applyTime)); 	
						}else{
							$("#applyTime_audit").html(''); 
						}
						$("#prepaydriver_audit").html(data.data.detail.driverName); 
						$("#prepaymobile_audit").html(data.data.detail.mobile); 
						$("#prepayCash_audit").html(data.data.detail.prepayCash);
						$("#bankName_audit").html(data.data.detail.bankName);
						$("#bankAccount_audit").html(data.data.detail.bankAccount);
						$("#oilCardNo_audit").html(data.data.detail.oilCardNo);
						$("#oilAmount_audit").html(data.data.detail.oilAmount);
						$("#prepaymark_audit").html(data.data.detail.mark);
						if(data.data.detail.id!=''){
							$('#tranPrepayId-hidden').val(data.data.detail.id);	
						}
					}else if(data.data.businessType == '05'){

						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#mesg_detilbtn').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').show();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').hide();
						$('#damgcost_detilbtn').hide();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').hide();
						$('#hidden8').hide();
						/* $('#hidden6').show(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#hiddenprotes').hide();
						$('#portCost_detilbtn').show();
						$('#modal-detilinfo').modal('show');
						//$('#scheduleBillNo-hidden').val(data.data.detail.scheduleBillNo);
						//$('#changecarId-hidden').val(data.data.detail.id);
						//$("#scheduleBillNo_changeCar").html(data.data.detail.scheduleBillNo); 
						$("#scheduleBillNo_port").html(data.data.detail.scheduleBillNo);
						if(data.data.detail.applyTime!=''&&data.data.detail.applyTime!=null){
							$("#applyTime_port").html(jsonForDateFormat(data.data.detail.applyTime)); 	
						}else{
							$("#applyTime_port").html(''); 
						}
						$("#carNumber_port").html(data.data.detail.carNumber);
						$("#driver_port").html(data.data.detail.driver);
						$("#codriver_port").html(data.data.detail.codriverName);
						$('#balanceOil_need').html(data.data.detail.balanceOil);
						$('#balanceCash_need').html(data.data.detail.balanceCash);
						if (data.data.detail.id != '') {
							$('#tranPortCostId-hidden').val(data.data.detail.id);
						}
						discountFlag=data.data.detail.discountFlag;
						$('#discountFlag_hidden').val(discountFlag);
						$.ajax({
							type : 'GET',
							url : "${ctx}/operationMng/transportCostMng/getDetail/"+ data.data.detail.id,
							dataType : 'JSON',
							success : function(data) {
								if (data&& data.code == 200) {
									var sumMoneyActual=0,oilMoneyActual=0,localMonthMoney=0;
									var preMoneySum=0,preOilSum=0;
									var prepayHtml = "";
									if(data.data['prepayList']!=null && data.data['prepayList'].length>0){
										for(var k=0;k<data.data['prepayList'].length;k++){
											var oilAmount=data.data['prepayList'][k]['oilAmount'];
											if(oilAmount!=null && oilAmount!=''){
												preOilSum+=parseFloat(oilAmount);
											}else{
												oilAmount=0;
											}
											var prepayCash=data.data['prepayList'][k]['prepayCash'];
											if(prepayCash!=null && prepayCash!=''){
												preMoneySum+=parseFloat(prepayCash);
											}else{
												prepayCash=0;
											}

										}
									}
									if(data.data['amount']!=''){
										sumMoneyActual=(parseFloat(data.data['amount'])-parseFloat(preMoneySum)).toFixed(2);
									}else{
										sumMoneyActual=(0-parseFloat(preMoneySum)).toFixed(2);
									}
									
									if(data.data['oilAmount']!=''){
										oilMoneyActual=(parseFloat(data.data['oilAmount'])-parseFloat(preOilSum)).toFixed(2);
									}else{
										oilMoneyActual=(0-parseFloat(preOilSum)).toFixed(2);
									}
									//console.info(JSON.stringify(data.data));
									/* 费用小计 */
									$('#sumMoney_port').html(data.data['amount']);/* 报账现金 */
									$('#oilMoney_port').html(data.data['oilAmount']);/* 报账油费 */
									$('#prepayCash_port').html(preMoneySum);/* 预付现金 */
									$('#oilAmount_port').html(preOilSum);/* 预付油费 */
									$('#sumMoneyActual_port').html(sumMoneyActual);/* 应付现金 */
									$('#oilMoneyActual_port').html(oilMoneyActual);/* 应付油费 */
									if(data.data['discountFlag']=='Y'){
										$('#needmoney').show();
										$('#sumMoneyDiscount_need').html(data.data['discountTotalAmount']);/* 折现应付现金 */
										$('#oilMoneyDiscount_need').html(data.data['discountTotalOilAmount']);/* 折现应付油费 */
										$('#balanceCashNextMonth_audit').val(data.data['discountTotalAmount']);//下月应付现金
									}else{
										$('#needmoney').hide();
										$('#sumMoneyDiscount_need').html('');/* 折现应付现金 */
										$('#oilMoneyDiscount_need').html('');/* 折现应付油费 */
									}
									if(data.data['balanceCash']!='' && data.data['balanceCashNextMonth']!=''){
										localMonthMoney=(parseFloat(data.data['balanceCash'])-parseFloat(data.data['balanceCashNextMonth'])).toFixed(2);
									}else if(data.data['balanceCash']=='' && data.data['balanceCashNextMonth']!=''){
										localMonthMoney=(0-parseFloat(data.data['balanceCashNextMonth'])).toFixed(2);
									}else if(data.data['balanceCash']!='' && data.data['balanceCashNextMonth']==''){
										localMonthMoney=(parseFloat(data.data['balanceCash'])-0).toFixed(2);
									}
									$('#balanceCash_port').html(localMonthMoney);
									$('#balanceOil_port').html(data.data['balanceOil']);
									$('#balanceNextCash_port').html(data.data['balanceCashNextMonth']);
									//$('#sumMoneyNew').html('当月实付：'+localMonthMoney+'+下月实付：'+data.data['discountTotalAmount']+'='+data.data['balanceCash']);/* 实付现金 */
									//$('#oilMoneyNew').html(data.data['balanceOil']);/* 实付油费 */
								} else {
									bootbox.alert(data.msg);
								}
							}

						});
						
						//location.href="${ctx}/dailyOffice/waitingDo/detail?"+itemId+"&"+processDetailId+"&"+taskId;changecarId-hidden
					}else if(data.data.businessType=='06'){
						
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#mesg_detilbtn').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').show();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').hide();
						$('#damgcost_detilbtn').hide();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').hide();
						$('#hidden8').hide();
						/* $('#hidden6').show(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#hiddenprotes').hide();
						$('#prepay_detilbtn').hide();						
						$('#modal-detilinfo').modal('show');	
						$("#tyreInOutno_audit").html(data.data.detail.billNo); 
						var type=data.data.detail.type;
						var typename="";
						if(type=='0'){typename='入库'}else{
							typename='出库'
						}
						$("#tyreInOuttype_audit").html(typename); 
						$("#tyreInOutmark_audit").html(data.data.detail.mark); 						
						if(data.data.detail.id!=''){
							$('#tyreInOutId-hidden').val(data.data.detail.id);	
							$('#tyretype-hidden').val(data.data.detail.type);
						}
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
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').hide();
						$('#damgcost_detilbtn').hide();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').hide();
						$('#hidden8').hide();
						/* $('#hidden6').show(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#hiddenprotes').hide();
						$('#prepay_detilbtn').hide();						
						$('#modal-detilinfo').modal('show');	
						$("#maintcarNumber_audit").html(data.data.detail.carNumber); 
						$("#maintcurMile_audit").html(data.data.detail.currentMileage);
						$("#maintamount_audit").html(data.data.detail.amount); 
						$("#maintdetailInfo_audit").html(data.data.detail.detailInfo); 
						$("#maintmark_audit").html(data.data.detail.mark); 						
						if(data.data.detail.id!=''){
							$('#maintId-hidden').val(data.data.detail.id);	
						}
					}else if(data.data.businessType=='08'){		
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').show();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').hide();
						$('#damgcost_detilbtn').hide();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').hide();
						$('#hidden8').hide();
						/* $('#hidden6').show(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').show();
						$('#hiddenprotes').hide();
						$('#modal-detilinfo').modal('show');	
						$("#process_off").html(data.data.item.processName); 
						$("#itemName_off").html(data.data.item.itemName);
						$("#amount_off").html(data.data.item.amount); 
						$("#cashAdvance_off").html(data.data.item.cashAdvance);
						$("#startTime_off").html(data.data.item.startTime); 
						$("#endTime_off").html(data.data.item.endTime); 
						$("#mark_maint").html(data.data.item.mark); 						
					}else if(data.data.businessType=='09'){		
						//console.log(JSON.stringify(data.data.businessType));
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').show();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').hide();
						$('#damgcost_detilbtn').hide();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').hide();
						$('#hidden8').hide();
						$('#hidden6').show();
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#hiddenprotes').hide();
						$('#modal-detilinfo').modal('show');	
						$("#carNumber_chge").html(data.data.detail.carNumber); 
						if(data.data.detail.applyTime!=''&&data.data.detail.applyTime!=null){
							$("#applyTime_chge").html(jsonDateFormat(data.data.detail.applyTime)); 	
						}else{
							$("#applyTime_chge").html(''); 
						}
						$("#oldNo_chge").html(data.data.detail.oldTyreNo); 
						$("#newNo_chge").html(data.data.detail.newTyreNo);
						$("#mark_chge").html(data.data.detail.mark); 
						if(data.data.detail.oldTyrePic!=null&&data.data.detail.oldTyrePic!=''&&data.data.detail.oldTyrePic!=undefined){
							var html='<a  href=${ctx}'+data.data.detail.oldTyrePic+' target="_blank">原轮胎图片</a>';
				        	$('#oldfilename-view').html(html);
						}
						if(data.data.detail.newTyrePic!=null&&data.data.detail.newTyrePic!=''&&data.data.detail.newTyrePic!=undefined){
							var html2 = '<a  href=${ctx}'+data.data.detail.newTyrePic+' target="_blank">新轮胎图片</a>';
				        	$('#newfilename-view').html(html2);
						}
			        	
					}else if(data.data.businessType=='10'){		
						//console.log(JSON.stringify(data.data.businessType));
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').show();
						$('#cardamgcost_msg').hide();
						$('#damgcost_detilbtn').hide();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').hide();
						$('#hidden8').hide();
						/* $('#hidden6').show(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#hiddenprotes').hide();
						$('#modal-detilinfo').modal('show');
						if(data.data.detail.transportTime!=''&&data.data.detail.transportTime!=null){
							$('#transportTime_fbck').html(jsonForDateFormat(data.data.detail.transportTime));	
						}else{
							$('#transportTime_fbck').html('');	
						} 
						$("#carType_fbck").html(data.data.detail.carType);
						if(data.data.detail.carShopName==null){
							$("#carShopId_fbck").html('');
						}else{
							$("#carShopId_fbck").html(data.data.detail.carShopName);
						}
						$("#linkMobile_fbck").html(data.data.detail.linkMobile);
						$("#mark_fbck").html(data.data.detail.mark); 						
					}else if(data.data.businessType=='11'){		
						//console.log(JSON.stringify(data.data.businessType));
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').show();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').hide();
						$('#hidden8').hide();
						/* $('#hidden6').show(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#hiddenprotes').hide();
						$('#damgcost_detilbtn').show();
						$('#modal-detilinfo').modal('show');
						if(data.data.detail.type=='0'){
							$('#type_damgcost').html('直接赔付');	
						}else{
							$('#type_damgcost').html('买断');	
						} 
						$('#damgcostId-hidden').val(data.data.detail.id);
						$("#scheduleno_damgcost").html(data.data.detail.scheduleBillNo);
						$("#bankName_damgcost").html(data.data.detail.bankName); 
						$("#accountName_damgcost").html(data.data.detail.accountName);
						$("#accountNo_damgcost").html(data.data.detail.accountNo);
						$("#amount_damgcost").html(data.data.detail.amount);
						if(data.data.detail.insuranceFlag=='Y'){
							$('#insuranceFlag_damgcost').html('是');	
						}else{
							$('#insuranceFlag_damgcost').html('否');	
						} 
						$("#mark_damgcost").html(data.data.detail.mark);	
						if(data.data.detail.attachFilePath!=''&&data.data.detail.attachFilePath!=null){
							 var attachFilePaths=data.data.detail.attachFilePath.split(';');
							 var html='';
							 for(var i=0;i<attachFilePaths.length-1;i++){
								 var attachFilePathes="${ctx}"+attachFilePaths[i];
								 var j=i+1;
								 html+='<a  href='+attachFilePathes+' target="_blank">照片'+j+'</a>&nbsp;&nbsp;';
							 }
							 $("#file_damgcost").html(html);							
						}
					}else if(data.data.businessType=='12'){		
						//console.log(JSON.stringify(data.data.businessType));
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').hide();
						$('#cardagout_msg').show();
						$('#sendCar_msg').hide();
						$('#hidden8').hide();
						/* $('#hidden6').show(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#hiddenprotes').hide();
						$('#damgcost_detilbtn').hide();
						$('#modal-detilinfo').modal('show');
						if(data.data.detail.insertTime!=''&&data.data.detail.insertTime!=null){
							$('#insertTime_dagout').html(jsonDateFormat(data.data.detail.insertTime));	
						}else{
							$('#insertTime_dagout').html('');
						} 
						$("#mark_dagout").html(data.data.detail.mark);
						$("#cardagoutid_hidden").val(data.data.detail.id);
						//console.log(data.data.detail.id);
						var id=data.data.detail.id;
						$.ajax({
							type : 'POST',
							url : "${ctx}/operationMng/carDamageOutStock/getById",
							dataType : 'JSON',
							data :{id:id},
							success : function(data) {
								if (data && data.code == 200) {
									//console.log(JSON.stringify(data.data));
									if(data.data.detailList.length>0){
										for(var i=0;i<data.data.detailList.length;i++){
											data.data.detailList[i]["rownum"]=i+1;
										}
										$('#cardagout_dagout').dataTable({
											 "destroy": true,//如果需要重新加载需销毁
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
											data: data.data.detailList,
									        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
									        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
									        columns: [	
									            { data: 'rownum' },
									            {data: "vin"},
											    {data: "model"},
											    {data: "color"},
											    {data: "insertTime"},
											    {data: "brand"},
											    {data: "position"},
											    {data: "amount"}],
											    columnDefs: [{
													 //入职时间
													 targets: 4,
													 render: function (data, type, row, meta) {
														 if(data!=''&&data!=null){
															 return jsonDateFormat(data);
														 }else{
															 return '';
														 }			
												       }	       
												}]
										});	
									}
								} else {
									bootbox.alert(data.msg);
								}
							}
							
						});
					}else if(data.data.businessType=='13'){		
						//console.log(JSON.stringify(data.data.businessType));
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').hide();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').show();
						$('#hidden8').hide();
						/* $('#hidden6').show(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#hiddenprotes').hide();
						$('#damgcost_detilbtn').hide();
						$('#modal-detilinfo').modal('show');						
						$("#carNumber_sedcar").html(data.data.detail.carNumber);
						$("#startAddress_sedcar").html(data.data.detail.startAddress);
						$("#endAddress_sedcar").html(data.data.detail.endAddress);						
						
					}else if (data.data.businessType == '14') {
						//console.log(JSON.stringify(data.data.businessType));
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').hide();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').hide();
						$('#officeapplynew_msg').show();
						$('#hidden8').hide();
						/* $('#hidden6').show(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#hiddenprotes').hide();
						$('#damgcost_detilbtn').hide();
						$('#modal-detilinfo').modal('show');
						$("#dep_offnew").html(data.data.detail.departmentName);
						$("#applyUser_offnew").html(data.data.detail.applyUserName);
						$("#type_offnew").html(data.data.detail.typeName); 
						if(data.data.detail.applyTime!=null&&data.data.detail.applyTime!=''){
							$("#applyTime_offnew").html(jsonDateFormat(data.data.detail.applyTime)); 
						}else{
							$("#applyTime_offnew").html(''); 
						}
						if(data.data.detail.startTime!=null&&data.data.detail.startTime!=''){
							$("#startTime_offnew").html(jsonDateFormat(data.data.detail.startTime)); 
						}else{
							$("#startTime_offnew").html(''); 
						}
						if(data.data.detail.endTime!=null&&data.data.detail.endTime!=''){
							$("#endTime_offnew").html(jsonDateFormat(data.data.detail.endTime)); 
						}else{
							$("#endTime_offnew").html(''); 
						}
						$("#mark_offnew").html(data.data.detail.mark);
						$("#name_offnew").html(data.data.detail.name); 
						$("#amount_offnew").html(data.data.detail.amount); 
					}else if(data.data.businessType == '15'){
						//console.log(JSON.stringify(data.data.businessType));
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').hide();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').hide();
						$('#officeapplynew_msg').hide();
						$('#costapply_msg').show();
						$('#hidden8').hide();
						/* $('#hidden6').show(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#hiddenprotes').hide();
						$('#damgcost_detilbtn').hide();
						$('#modal-detilinfo').modal('show');
						$("#sbillNoInfo_costaply").html(data.data.detail.costApplyBillNo);
						$("#sdepName_costaply").html(data.data.detail.departmentName);
						$("#sapplyName_costaply").html(data.data.detail.applyUserName); 
						if(data.data.detail.applyTime!=null&&data.data.detail.applyTime!=''){
							$("#sapplyTime_costaply").html(jsonDateFormat(data.data.detail.applyTime)); 
						}else{
							$("#sapplyTime_costaply").html(''); 
						}
						$("#spreAmount_costaply").html(data.data.detail.prepayAmount);
						$("#scostAmount_costaply").html(data.data.detail.realUseAmount); 
						$("#sreturnAmount_costaply").html(data.data.detail.returnAmount); 
					}else if (data.data.businessType == '17') {
						//console.log(JSON.stringify(data.data.businessType));
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#trackchange_msg').hide();
						$('#carfeedback_msg').hide();
						$('#cardamgcost_msg').hide();
						$('#cardagout_msg').hide();
						$('#sendCar_msg').hide();
						$('#officeapplynew_msg').hide();
						$('#buyapply_msg').show();
						$('#hidden8').hide();
						/* $('#hidden6').show(); */
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#hiddenprotes').hide();
						$('#damgcost_detilbtn').hide();
						$('#modal-detilinfo').modal('show');
						$("#sdepInfo_buyapply").html(data.data.detail.departmentName);
						$("#sapplyUserInfo_buyapply").html(data.data.detail.applyUserName);
						if(data.data.detail.type=="0"){
							$("#stypeInfo_buyapply").html('轮胎'); 	
						}else{
							$("#stypeInfo_buyapply").html('钢圈'); 	
						}																		
						$("#sbrandInfo_buyapply").html(data.data.detail.brand);
						$("#ssizeInfo_buyapply").html(data.data.detail.size); 
						$("#ssumInfo_buyapply").html(data.data.detail.sum); 
						$("#spriceInfo_buyapply").html(data.data.detail.price); 
						$("#smarkInfo_buyapply").html(data.data.detail.mark); 
					}
					/**根据流程步骤id获取该流程的具体信息**/
					$.ajax({
						type : 'GET',
						url : "${ctx}/dailyOffice/waitingDo/getProcessDetailInfo/"+processDetailId,
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								$("#needSuggestFlag").val(data.data.needSuggestFlag);
								var needSuggestFlag=data.data.needSuggestFlag;
								if (needSuggestFlag == "N") {
									$("#hidden2").hide();
								}else{
									$("#hidden2").show();
								}
								var name="["+data.data.name+"]";
								$("#name_mesg").html(name); 
								if (data.data.orderNo == '0') {
									$('#hidden2').hide();
									$('#hidden3').hide();
									$('#hidden8').hide();
									$('#auditBtn').hide();
									$('#confirmBtn').hide();
									$('#msglble').show();
									/* $('#msglblereview').hide(); */
									$('#stephidden').hide();
								} else if (data.data.type == '0') {
									$('#auditBtn').show();
									$('#confirmBtn').hide();
									$('#msglble').hide();
									/* $('#msglblereview').hide(); */
								} else if (data.data.type == '1') {
									$('#auditBtn').hide();
									$('#confirmBtn').show();
									$('#msglble').hide();
									/* $('#msglblereview').hide(); */
								}
								//console.log(businessType);
								//console.log(data.data.type);
								if (businessType == '05'&& data.data.orderNo == '1') {
									$('#hiddenprotes').show();
								}
								if (businessType == '05'&& data.data.orderNo == '4') {
									$('#hiddenpre').show();
									if(discountFlag=="Y"){
										$('#balanceCashNextMonth').show();
									}else{
										$('#balanceCashNextMonth').hide();
									}
								}
							} else {
								bootbox.alert(data.msg);
							}
						}
						
					});
					if(data.data.logList.length>0){
						for(var i=0;i<data.data.logList.length;i++){
							data.data.logList[i]["rownum"]=i+1;
						}
						$('#taskHistory_view').dataTable({
							 "destroy": true,//如果需要重新加载需销毁
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
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		});
}
function refresh(){
	$('#modal-info').modal('hide');	
}
/*代办中各个流程超链接的页面*/
function newpage() {
			//console.log('erwr');
			var businessType = $("#businessType-hidden").val();
			var waybillNo = $("#waybillNo-hidden").val();
			var type = $("#type-hidden").val();
			var scheduleBillNo = $("#scheduleBillNo-hidden").val();
			var tyretype = $("#tyretype-hidden").val();
			$('#modal-detilinfo').modal('hide');
			//console.info('erwr'+scheduleBillNo);
			if (businessType == '01') {
				parent.addTabs({id : '49',title : '运单管理',close : true,url : '${ctx}/waybill/waybillManage/index?' + waybillNo});
			} else if (businessType == '02'&&type=='1') {
				parent.addTabs({id : '1120',title : '快速调度',close : true,url : '${ctx}/operationMng/scheduleMng/fastIndex?scheduleBillNo='+scheduleBillNo});
			}else if (businessType == '02'&&type=='0') {
				parent.addTabs({id : '52',title : '调度管理',close : true,url : '${ctx}/operationMng/scheduleMng/index'});
			} else if (businessType == '03') {
				parent.addTabs({id : '59',title : '在途换车管理',close : true,url : '${ctx}/operationMng/trackChangeMng/index'});
			} else if (businessType == '04') {
				parent.addTabs({id : '21',title : '装运预付申请',close : true,url : '${ctx}/operationMng/transportPrepayMng/officeIndex'});
			} else if (businessType == '05') {
				parent.addTabs({id : '22',title : '驾驶员报销申请',close : true,url : '${ctx}/operationMng/transportCostMng/officeIndex'});
			} else if (businessType == '06'&&tyretype=='0') {
				parent.addTabs({id : '61',title : '轮胎入库管理',close : true,url : '${ctx}/operationMng/trackTyreRuMng/index'});
			}else if (businessType == '06'&&tyretype=='1') {
				parent.addTabs({id : '61',title : '轮胎出库管理',close : true,url : '${ctx}/operationMng/trackTyreInOutMng/index'});
			} else if (businessType == '07') {
				parent.addTabs({id : '62',title : '维修保养管理',close : true,url : '${ctx}/operationMng/trackMaintMng/index'});
			} else if (businessType == '08') {
				parent.addTabs({id : '23',title : '办公费用申请',close : true,url : '${ctx}/dailyOffice/officeApply/index'});
			}else if (businessType == '09') {
				parent.addTabs({id : '63',title : '轮胎更换管理',close : true,url : '${ctx}/operationMng/trackTyreChangeMng/index'});
			}else if (businessType == '10') {
				parent.addTabs({id : '1104',title : '折损反馈管理',close : true,url : '${ctx}/operationMng/carDamageFeedbackMng/index'});
			}else if (businessType == '11') {
				parent.addTabs({id : '1106',title : '折损费用申请',close : true,url : '${ctx}/operationMng/carDamageCostMng/index'});
			}else if (businessType == '12') {
				parent.addTabs({id : '55',title : '折损车出库管理',close : true,url : '${ctx}/operationMng/carDamageOutStock/Manageindex'});
			}else if (businessType == '13') {
				parent.addTabs({id : '1111',title : '派车指令管理',close : true,url : '${ctx}/operationMng/sendCarCommand/index'});
			}else if (businessType == '14') {
				parent.addTabs({id : '1112',title : '预付申请管理',close : true,url : '${ctx}/operationMng/costApply/index'});
			}else if (businessType == '15') {
				parent.addTabs({id : '1114',title : '核销申请管理',close : true,url : '${ctx}/operationMng/costApplyReturn/index'});
			}
		}
//获取运单明细
function getdetil(){
	cleardetil();
	var waybillid=$('#waybillid-hidden').val();
	$.ajax({
		type : 'GET',
		url : "${ctx}/waybill/waybillManage/checkWaybill/"+waybillid,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				$('#id-hidden').val(waybillid);
				$('#myModalLabel').html('运单信息');
				$("#waybillNo_view").html(data.data.waybillNo);
				if(data.data.type=='1'){
					$("#type_view").html('二手车'); 
					$('#hiddenes1').hide();
					$('#hiddenes3').hide();
					$('#hiddenes2').show();
					$('#hiddenes4').hide();
				}else{
					$("#type_view").html('商品车'); 
					$('#hiddenes1').show();
					$('#hiddenes2').hide();
					$('#hiddenes3').hide();
					$('#hiddenes4').show();
				}				
				$("#supplierId_view").html(data.data.supplierName); 
				$("#amount_view").html(data.data.amount); 
				$("#brand_view").html(data.data.brand); 
				$("#carShopId_view").html(data.data.carShopName);
				$("#sendTime_view").html(data.data.sendTime); 
				$("#receiveUser_view").html(data.data.receiveUser); 
				$("#receiveUserTelephone_view").html(data.data.receiveUserTelephone); 
				$("#receiveUserMobile_view").html(data.data.receiveUserMobile); 
				$("#startAddress_view").html(data.data.startAddress);
				$("#targetAddress_view").html(data.data.targetCity);
				$("#targetProvince_view").html(data.data.targetProvince);
				$("#distance_view").html(data.data.distance);
				if(data.data.attachFileName!=''&&data.data.attachFileName!=null){
					var attachFilePathes="${ctx}"+data.data.attachFilePath;
					$("#file_view").html('<a  href='+attachFilePathes+' target="_blank">'+data.data.attachFileName+'</a>');
				}
				if(data.data.carStockList.length>0){
					for(var i=0;i<data.data.carStockList.length;i++){
						data.data.carStockList[i]["rownum"]=i+1;
					}
					$('#cardetable_view').dataTable({
						 "destroy": true,//如果需要重新加载需销毁
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
						data: data.data.carStockList,
				        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
				        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
				        columns: [	
				            { data: 'rownum' },
				            {data: "type"},
						    /* {data: "supplierName"}, */
						    {data: "brand"},
						    {data: "vin"},
						    {data: "model"},
						    {data: "color"},
						    {data: "engineNo"},
						    {data: "mark"}							   
						   /*  {data: "status"}, */],
						    columnDefs: [{
								 targets: 1,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
										 return '商品车';
									 }else if(data=='1'){
										 return '二手车';
									 }else{
										 return '';
									 }						
							       }	       
							}
						      ]
					});
				}
				if(data.data.carAttachmentStockList.length>0){
					for(var i=0;i<data.data.carAttachmentStockList.length;i++){
						data.data.carAttachmentStockList[i]["rownum"]=i+1;
					}
					$('#attachmentdetable_view').dataTable({
						 "destroy": true,//如果需要重新加载需销毁
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
						data: data.data.carAttachmentStockList,
				        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
				        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
				        columns: [	
				            { data: 'rownum' },
				            {data: "attachmentName"},
						    {data: "position"},
						    {data: "count"},
						    {data: "mark"},							   
						    /* {data: "status"} */]
					});
				}
				$('#viewBtn').show();
				$('#modal-waybilldetilinfo').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	});
}
function cleardetil(){
    $("#waybillNo_view").html('');					
	$("#supplierId_view").html(''); 
	$("#amount_view").html(''); 
	$("#brand_view").html(''); 
	$("#carShopId_view").html('');
	$("#sendTime_view").html(''); 
	$("#receiveUser_view").html(''); 
	$("#receiveUserTelephone_view").html(''); 
	$("#receiveUserMobile_view").html(''); 
	$("#startAddress_view").html('');
	$("#targetAddress_view").html('');
	$("#distance_view").html('');
	$("#cardetable_view tbody tr").remove();  
	$("#attachmentdetable_view tbody tr").remove();  
}
//获取调度单明细
function getdetils(){
	var scheduleBillNo=$('#scheduleBillNo-hidden').val();
	 //var scheduleBillNo="${scheduleBillNo}";
	 clearshedeinfo();
	 $('#modal-shedeinfo').modal('show');
	  var html="";
	  var prepayHtml="";
	  var carHtml="";
	  var carAttachmentHtml="";
	  var detailListHtml="";
	  $.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/scheduleMng/getDetailData/"+scheduleBillNo,
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					if(data.data['sendTime']!=''&&data.data['sendTime']!=null){
						$('#sendTime').html(jsonForDateFormat(data.data['sendTime']));
					}else{
						$('#sendTime').html('');
					}
					if(data.data['receiveTime']!=''&&data.data['receiveTime']!=null){
						$('#receiveTime').html(jsonForDateFormat(data.data['receiveTime']));
					}else{
						$('#receiveTime').html('');
					}
					if(data.data['planReachTime']!=''&&data.data['planReachTime']!=null){
						$('#planReachTime').html(jsonForDateFormat(data.data['planReachTime']));
					}else{
						$('#planReachTime').html('');
					}

					$('#all-amount').html(data.data['amount']);
					$('#startAddress').html(data.data['startAddress']);
					$('#endAddress').html(data.data['endAddress']);
					$('#carNumber').html(data.data['carNumber']);
					$('#driver').html(data.data['driverName']);
					$('#mark').html(data.data['mark']);
					if(data.data['preList']!=null && data.data['preList'].length>0){
						for(var k=0;k<data.data['preList'].length;k++){
							var status='';
							var oilAmount=data.data['preList'][k]['oilAmount'];
							if(oilAmount==null){
								oilAmount='';
							}
							var prepayCash=data.data['preList'][k]['prepayCash'];
							if(prepayCash==null){
								prepayCash='';
							}
							var bankName=data.data['preList'][k]['bankName'];
							if(bankName==null){
								bankName='';
							}
							var bankAccount=data.data['preList'][k]['bankAccount'];
							if(bankAccount==null){
								bankAccount='';
							}
							var oilCardNo=data.data['preList'][k]['oilCardNo'];
							if(oilCardNo==null){
								oilCardNo='';
							}
							if(data.data['preList'][k]['status']=='0'){
								status='新建';
							}else if(data.data['preList'][k]['status']=='1'){
								status='待审核';
							}else if(data.data['preList'][k]['status']=='2'){
								status='待付款';
							}else if(data.data['preList'][k]['status']=='3'){
								status='已完成';
							}else if(data.data['preList'][k]['status']=='4'){
								status='已结算';
							}
							prepayHtml+='<div class="border-b-ff9a00"><div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付现金:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayCash'+k+'" class="form-control no-border">'+prepayCash+'</p></div></div>'
						          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>开户行:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="bankName'+k+'" class="form-control no-border">'+bankName+'</p></div></div></div>'
						          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>账号:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="bankAccount'+k+'" class="form-control no-border">'+bankAccount+'</p></div></div>'
						          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付油卡卡号:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="oilCardNo'+k+'" class="form-control no-border">'+oilCardNo+'</p></div></div></div>'
						          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付油费:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="oilAmount'+k+'" class="form-control no-border">'+oilAmount+'</p></div></div>'
						          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付状态:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayStatus'+k+'" class="form-control no-border">'+status+'</p></div></div></div></div>';
						}
					}else{
						prepayHtml='<div class="border-b-ff9a00"><div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付现金:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayCash" class="form-control no-border"></p></div></div>'
					          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>开户行:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="bankName" class="form-control no-border"></p></div></div></div>'
					          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>账号:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="bankAccount" class="form-control no-border"></p></div></div>'
					          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付油卡卡号:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="oilCardNo" class="form-control no-border"></p></div></div></div>'
					          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付油费:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="oilAmount" class="form-control no-border"></p></div></div>'
					          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付状态:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayStatus" class="form-control no-border"></p></div></div></div></div>';
					}
					$('#prepayList').html(prepayHtml);
					$('#mobile').html(data.data['mobile']);
					if(data.data['detailList'].length>0){
						 $('#listlength').val(data.data['detailList'].length);
						for(var i=0;i<data.data['detailList'].length;i++){
							var carInfo=data.data['detailList'][i]['carList'];
							var carAttachmentInfo=data.data['detailList'][i]['carAttachmentList'];
							var carHtmlItem="";
							var carAttachmentHtmlItem="";
							/* 车辆信息 */
							if(carInfo!=null && carInfo.length>0){
								for(var j=0;j<carInfo.length>0;j++){
									var carShopName=data.data['detailList'][i]['carShopName'];
									if(carShopName!=null && carShopName!=""){
										carHtmlItem+='<tr><td>'+carInfo[j]['vin']+'</td><td>'+carInfo[j]['model']+'</td>'
										   +'<td>'+carInfo[j]['color']+'</td><td>'+jsonDateFormat(carInfo[j]['insertTime'])+'</td>'
										   +'<td>'+carInfo[j]['waybillNo']+'</td><td>'+carShopName+'</td>'
										   +'<td>'+carInfo[j]['brand']+'</td></tr>';
									}else{
										carHtmlItem+='<tr><td>'+carInfo[j]['vin']+'</td><td>'+carInfo[j]['model']+'</td>'
										   +'<td>'+carInfo[j]['color']+'</td><td>'+jsonDateFormat(carInfo[j]['insertTime'])+'</td>'
										   +'<td>'+carInfo[j]['waybillNo']+'</td><td>二手车</td>'
										   +'<td>'+carInfo[j]['brand']+'</td></tr>';
									}
									
								}
								carHtml='<table class="carList table table-striped table-bordered table-hover">'
							        +'<thead><tr><th>车架号</th><th>车型</th><th>颜色</th><th>入库时间</th><th>运单编号</th><th>经销单位</th><th>品牌</th></tr></thead>'
							        +'<tbody>'+carHtmlItem+'</tbody></table>'; 
							}else{
								carHtmlItem='<tr><td colspan="7">暂无车辆信息</td></tr>'
								carHtml='<table class="carList table table-striped table-bordered table-hover">'
							        +'<thead><tr><th>车架号</th><th>车型</th><th>颜色</th><th>入库时间</th><th>运单编号</th><th>经销单位</th><th>品牌</th></tr></thead>'
							        +'<tbody>'+carHtmlItem+'</tbody></table>';
							}
							/* 配件信息 */
							if(carAttachmentInfo!=null && carAttachmentInfo.length>0){
								for(var k=0;k<carAttachmentInfo.length>0;k++){
									carAttachmentHtmlItem+='<tr><td>'+carAttachmentInfo[k]['attachmentName']+'</td>'
										   +'<td>'+carAttachmentInfo[k]['position']+'</td>'
										   +'<td>'+carAttachmentInfo[k]['count']+'</td>'
										   +'<td>'+carAttachmentInfo[k]['outCount']+'</td></tr>';
									
								}
							}else{
								carAttachmentHtmlItem='<tr><td colspan="4">暂无配件信息</td></tr>'
							}
							carAttachmentHtml='<table class="carList table table-striped table-bordered table-hover">'
						        +'<thead><tr><th>配件</th><th>位置</th><th>库存</th><th>出库数</th></tr></thead>'
						        +'<tbody>'+carAttachmentHtmlItem+'</tbody></table>';
						        var startAddress=data.data['detailList'][i]['startAddress'];
						        var targetProvince=data.data['detailList'][i]['targetProvince'];
						        var targetCity=data.data['detailList'][i]['targetCity'];
						        if(startAddress==null){
						        	startAddress="";
						        }
						        if(targetProvince==null){
						        	targetProvince="";
						        }
						        if(targetCity==null){
						        	targetCity="";
						        }
							if(data.data['detailList'][i]['carShopId']!=null && data.data['detailList'][i]['carShopId']!=''){
								detailListHtml+='<div class="border-b-ff9a00 detailList" id="detailList'+i+'">'
									  +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>经销单位:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="carShopId-item form-control">'+data.data['detailList'][i]['carShopName']+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>台数:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="amount-item form-control">'+data.data['detailList'][i]['amount']+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>详细指令:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="detailMark-item form-control">'+data.data['detailList'][i]['mark']+'</p></div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>始发地:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border">'+startAddress+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>目的省:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border">'+targetProvince+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>目的地:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border">'+targetCity+'</p></div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>车辆信息:</label></div></div>'
						              +'<div class="col-xs-11"><div class="newCarDetail-item">'+carHtml+'</div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>配件信息:</label></div></div>'
						              +'<div class="col-xs-11"><div class="newPartDetail-item">'+carAttachmentHtml+'</div></div></div></div>';
							}else{
								detailListHtml+='<div class="border-b-ff9a00 detailList" id="detailList'+i+'">'
									  +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>经销单位:</label></div></div>'
						              +'<div class="col-xs-4"><div class="form-contr"><p class="carShopId-item form-control">二手车</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>台数:</label></div></div>'
						              +'<div class="col-xs-2"><div class="form-contr"><p class="amount-item form-control">'+data.data['detailList'][i]['amount']+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>详细指令:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="detailMark-item form-control">'+data.data['detailList'][i]['mark']+'</p></div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>始发地:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border">'+startAddress+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>目的省:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border">'+targetProvince+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>目的地:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border">'+targetCity+'</p></div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>车辆信息:</label></div></div>'
						              +'<div class="col-xs-11"><div class="newCarDetail-item">'+carHtml+'</div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>配件信息:</label></div></div>'
						              +'<div class="col-xs-11"><div class="newPartDetail-item">'+carAttachmentHtml+'</div></div></div></div>';
							}
							
						}

					}else{
						detailListHtml='<div class="border-b-ff9a00 detailList" id="detailList0"><div class="row newrow"><div class="col-xs-12"><p class="form-control no-border t-c">没有详细信息！</p></div></div>';
					}
					
					html=detailListHtml;

					$('#carDetail').after(html);
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		}); 
}
//调度单关闭
function doback(){	 
	 $('#modal-shedeinfo').modal('hide');
}
function clearshedeinfo(){
	 $('#sendTime').html('');
		$('#receiveTime').html('');
		$('#planReachTime').html('');
		$('#all-amount').html('');
		$('#startAddress').html('');
		$('#endAddress').html('');
		$('#carNumber').html('');
		$('#driver').html('');
		$('#mark').html('');
	 var length= $('#listlength').val();
	 if(length!=''){
		 for(var i=0;i<length;i++){
			 $('#detailList'+i).html('');
		 }		
	 }
	 $('#listlength').val('');
}
/**弹窗关闭**/
function refresh(){	 
	location.reload();
}
/**运单明细弹框关闭***/
function doclose(){	
	$('#modal-waybilldetilinfo').modal('hide');	
	  //$('#hidden8').hide();
		
}
function detilclose(){	
	//roload();
	$('#modal-detilinfo').modal('hide');	
	
}
/*装运预付明细*/
function getPrepaydetils(){
	 $('#modal-prepayinfo').modal('show');
	 var id=$('#tranPrepayId-hidden').val();
	 var html="";
	  var detailListHtml="";
	  var detailItem="";
	  $.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/transportPrepayMng/getDetail/"+id,
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					$('#carNumber_pre').html(data.data['carNumber']);
					$('#driver_pre').html(data.data['driverName']);
					$('#mobile_pre').html(data.data['mobile']);
					$('#prepayCash_pre').html(data.data['prepayCash']);
					$('#bankName_pre').html(data.data['bankName']);
					$('#bankAccount_pre').html(data.data['bankAccount']);
					$('#oilCardNo_pre').html(data.data['oilCardNo']);
					$('#oilAmount_pre').html(data.data['oilAmount']);
					$('#oilCardNo_pre').html(data.data['oilCardNo']);
					if(data.data['applyTime']!=null&&data.data['applyTime']!=''){
						$('#applyTime_pre').html(jsonForDateFormat(data.data['applyTime']));	
					}else{
						$('#applyTime_pre').html('');	
					}
					
					$('#mark_pre').html(data.data['mark']);
					if(data.data['detailList'].length>0){
						for(var i=0;i<data.data['detailList'].length;i++){
							if(data.data['detailList'][i]['mark']==null || data.data['detailList'][i]['mark']==''){
								data.data['detailList'][i]['mark']='';
							}
							detailListHtml+='<div id="detailList'+i+'" class="border-b-ff9a00 detailList">'
							          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>品牌:</label></div></div>'
							          +'<div class="col-xs-5"><div class="form-contr"><p class="form-control form-control-item" id="brandName'+i+'">'+data.data['detailList'][i]['brandName']+'</p></div></div>'
							          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>台数:</label></div></div>'
							          +'<div class="col-xs-5"><div class="form-contr"><p class="form-control form-control-item" id="count'+i+'">'+data.data['detailList'][i]['count']+'</p></div></div></div>'
							          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>起运地:</label></div></div>'
							          +'<div class="col-xs-5"><div class="form-contr"><p class="form-control form-control-item" id="startAddress'+i+'">'+data.data['detailList'][i]['startAddress']+'</p></div></div>'
							          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>目的地:</label></div></div>'
							          +'<div class="col-xs-5"><div class="form-contr"><p class="form-control form-control-item" id="endAddress'+i+'">'+data.data['detailList'][i]['endAddress']+'</p></div></div></div>'
							          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>备注:</label></div></div>'
							          +'<div class="col-xs-11"><div class="form-contr"><p class="form-control form-control-item" id="remark'+i+'">'+data.data['detailList'][i]['mark']+'</p></div></div></div></div>';
						}
						
					}else{
						detailListHtml='<div class="border-b-ff9a00 detailList" id="detailList0"><div class="row newrow"><div class="col-xs-12"><p class="form-control no-border t-c">没有详细信息！</p></div></div>';
					}
					html=detailListHtml;
					$('#preDetail').after(html);
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		}); 
}

function dopreback(){	 
	 $('#modal-prepayinfo').modal('hide');
}

/*装运费用审核明细*/
function getportCostdetils(){
	//var url=location.href;
	 $('#modal-portcostinfo').modal('show');
	var id=$('#tranPortCostId-hidden').val();
	 var html="";
	  var detailListHtml="";
	  var detailItem="";
	  var prepayHtml="";
	//location.href="${ctx}/operationMng/transportCostMng/queryIndex/"+id;
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/transportCostMng/getDetail/"+id,
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var preIds=data.data['prepayApplyIds'];
				$('#carNumber_prt').html(data.data['carNumber']);
				$('#driver_prt').html(data.data['driverName']);
				$('#codriver_prt').html(data.data['codriverName']);
				$('#scheduleBillNo_prt').html(data.data['scheduleBillNo']);
				$('#brandName_prt').html(data.data['costList'][0]['brandName']);
				if(data.data['costList'][0]['sendTime']!=null&&data.data['costList'][0]['sendTime']!=''){
					$('#sendTime_prt').html(jsonForDateFormat(data.data['costList'][0]['sendTime']));	
				}else{
					$('#sendTime_prt').html('');	
				}
				if(data.data['costList'][0]['receiveTime']!=null&&data.data['costList'][0]['receiveTime']!=''){
					$('#receiveTime_prt').html(jsonForDateFormat(data.data['costList'][0]['receiveTime']));	
				}else{
					$('#receiveTime_prt').html('');	
				}
				$('#amount_prt').html(data.data['costList'][0]['count']);
				$('#startAddress_prt').html(data.data['costList'][0]['startAddress']);
				$('#endAddress_prt').html(data.data['costList'][0]['endAddress']);
				if(data.data['applyTime']!=null&&data.data['applyTime']!=''){
					$('#applyTime_prt').html(jsonForDateFormat(data.data['applyTime']));	
				}else{
					$('#applyTime_prt').html('');	
				}
				$('#distance_prt').html(data.data['distance']);
				$('#standardOilWear_prt').html(data.data['standardOilWear']);
				$('#oilPrice_prt').html(data.data['oilPrice']);
				$('#oilAmount_prt').html(data.data['oilAmount']);
				var discountFlag=data.data['discountFlag'];
				if(discountFlag=='Y'){
					$('#discountFlag_prt').html('是');
				}else{
					$('#discountFlag_prt').html('否');
				}
				var sumMoneyActual=0,oilMoneyActual=0,localMonthMoney=0;
				var preMoneySum=0,preOilSum=0;
				if(data.data['prepayList']!=null && data.data['prepayList'].length>0){
					for(var k=0;k<data.data['prepayList'].length;k++){
						var oilAmount=data.data['prepayList'][k]['oilAmount'];
						if(oilAmount!=null && oilAmount!=''){
							preOilSum+=parseFloat(oilAmount);
						}else{
							oilAmount=0;
						}
						var prepayCash=data.data['prepayList'][k]['prepayCash'];
						if(prepayCash!=null && prepayCash!=''){
							preMoneySum+=parseFloat(prepayCash);
						}else{
							prepayCash=0;
						}
						prepayHtml+='<div class="row newrow bor-b-ff9a00-1"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付现金:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayCash'+k+'" class="form-control no-border">'+prepayCash+'</p></div></div>'
					          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付油费:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="oilAmount'+k+'" class="form-control no-border">'+oilAmount+'</p></div></div>'
					          +'</div>';

					}
				}else{
					prepayHtml+='<div class="row newrow bor-b-ff9a00-1"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付现金:</label></div></div>'
				          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayCash'+k+'" class="form-control no-border"></p></div></div>'
				          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付油费:</label></div></div>'
				          +'<div class="col-xs-5"><div class="form-contr"><p id="oilAmount'+k+'" class="form-control no-border"></p></div></div>'
				          +'</div>';
				}
				$('#prepayList_prt').html(prepayHtml);
				if(data.data['costList'][0]['cashList'].length>0){
					for(var i=0;i<data.data['costList'][0]['cashList'].length;i++){
						var obj=data.data['costList'][0]['cashList'];
						var attachFilePaths="";
						var partHtml="";
						if(obj[i].filePath!=null && obj[i].filePath!=''){
							attachFilePaths="${ctx}"+obj[i].filePath;
							partHtml='<a href='+attachFilePaths+' target="_blank">附件</a>';
						}
						if(obj[i].mark==null || obj[i].mark==''){
							obj[i].mark='';
						}
							html+='<div id="detailList'+i+'" class="detailList bor-b-ff9a00-1">'
		       			      +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>费用名称:</label></div></div>'
		       			      +'<div class="col-xs-2"><div class="form-contr"><p class="form-control no-border" id="titleName'+i+'">'+obj[i].name+'</p></div></div>'
		       			      +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>金额:</label></div></div>'
		       			      +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border" id="amount'+i+'">'+obj[i].amount+'</p></div></div>'
		       			      +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>备注:</label></div></div>'
		       			      +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border" id="name'+i+'">'+obj[i].mark+'</p></div></div>'
		       			      +'<div class="col-xs-1"></div></div>'
		       			      +'<div class="row newrow bor-no"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>上传凭证:</label></div></div>'
		       			      +'<div class="col-xs-5"><div class="form-contr">'
		       			      +'<label class="title" id="filename'+i+'">'+partHtml+'</label>'
		       			      +'</div></div><div class="col-xs-6"></div></div></div>';
					}
				}
				$('#cataListItem_prt').html(html);
				if(data.data['amount']!=''){
					sumMoneyActual=(parseFloat(data.data['amount'])-parseFloat(preMoneySum)).toFixed(2);
				}else{
					sumMoneyActual=(0-parseFloat(preMoneySum)).toFixed(2);
				}
				
				if(data.data['oilAmount']!=''){
					oilMoneyActual=(parseFloat(data.data['oilAmount'])-parseFloat(preOilSum)).toFixed(2);
				}else{
					oilMoneyActual=(0-parseFloat(preOilSum)).toFixed(2);
				}
				/* 费用小计 */
				$('#sumMoney').html(data.data['amount']);/* 报账现金 */
				$('#oilMoney').html(data.data['oilAmount']);/* 报账油费 */
				$('#sumMoneyPre').html(preMoneySum);/* 预付现金 */
				$('#oilMoneyPre').html(preOilSum);/* 预付油费 */
				$('#sumMoneyActual').html(sumMoneyActual);/* 应付现金 */
				$('#oilMoneyActual').html(oilMoneyActual);/* 应付油费 */
				if(data.data['discountFlag']=='Y'){
					$('#discountMoneyInfo').show();
					$('#sumMoneyDiscount').html(data.data['discountTotalAmount']);/* 折现应付现金 */
					$('#oilMoneyDiscount').html(data.data['discountTotalOilAmount']);/* 折现应付油费 */
				}else{
					$('#discountMoneyInfo').hide();
					$('#sumMoneyDiscount').html('');/* 折现应付现金 */
					$('#oilMoneyDiscount').html('');/* 折现应付油费 */
				}
				if(data.data['balanceCash']!='' && data.data['balanceCashNextMonth']!=''){
					localMonthMoney=(parseFloat(data.data['balanceCash'])-parseFloat(data.data['balanceCashNextMonth'])).toFixed(2);
				}else if(data.data['balanceCash']=='' && data.data['balanceCashNextMonth']!=''){
					localMonthMoney=(0-parseFloat(data.data['balanceCashNextMonth'])).toFixed(2);
				}else if(data.data['balanceCash']!='' && data.data['balanceCashNextMonth']==''){
					localMonthMoney=(parseFloat(data.data['balanceCash'])-0).toFixed(2);
				}
				$('#sumMoneyNew').html('当月实付：'+localMonthMoney+'+下月实付：'+data.data['balanceCashNextMonth']+'='+data.data['balanceCash']);/* 实付现金 */
				$('#oilMoneyNew').html(data.data['balanceOil']);/* 实付油费 */
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	}); 
}
function doportback(){	 
	 $('#modal-portcostinfo').modal('hide');
}
/* 金额验证 */
function revaildate(e, flag) {
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
	var money = $(e).val();
	if (money != null && money != '') {
		if (!reg.test(money)) {
			if (flag == '0') {//预付现金    			
				$('#cashAdvance_audit').val('');
				bootbox.alert('请输入正确的金额！');
			} else if (flag == '1') {//预付油费
				$('#balanceCash_audit').val('');
				bootbox.alert('请输入正确的金额！');
			} else if (flag == '2') {//公里数
				$('#distance_portes').val('');
				bootbox.alert('请输入正确的公里数！');
			} else if (flag == '3') {//罚款
				$('#amerce_portes').val('');
				bootbox.alert('请输入正确的金额！');
			} else if (flag == '4') {//油价
				$('#oilPrice_portes').val('');
				bootbox.alert('请输入正确的金额！');
			}
		}else{
			//console.info(money);
			if(flag == '2'){/***根据公里数及罚款比例获取罚款数据**/
				$.ajax({
					type : 'POST',
					url : "${ctx}/basicSetting/fineSetting/getBean",
					contentType : "application/json;charset=UTF-8",
					dataType : 'JSON',
					success : function(data) {
						if (data && data.code == 200) {
							//console.info(JSON.stringify(data.data));
							if(data.data!=null){						
								  //$('#proportion').val(data.data.proportion);	
								  var proportion=data.data.proportion;
								  var amerce=money*proportion;
								  amerce=amerce/100;
								  var sumPrice=amerce+"";
									if(sumPrice.indexOf(".")>-1){
										if(sumPrice.split(".")[1].length>2){
											amerce=sumPrice.toFixed(2);
										}
									}
								  $('#amerce_portes').val(amerce);	 
							}
						} else {
							bootbox.alert(data.msg);
						}
					}
					
				});
			}
		}
	}
}
/**审核通过/不通过**/
function waybillaudit(successFlag){
var audit_mesg = $("#audit_mesg").val();
var taskId = $("#taskId-hidden").val();
var filename = $("#filename_hidden").val();
var filepath = $("#filepath_hidden").val();
var businessType = $("#businessType-hidden").val();
var newcarNumber = $("#newcarNumber_audit").val();
var newdriver = $("#newdriver_audit_id").val();
var newdriverName = $("#newdriver_audit").val();
var newCarNumber = $("#newCarNumber_changeCar").html();
var balanceCash = $("#balanceCash_audit").val();
var balanceOil = $("#balanceOil_audit").val();
var cashAdvance = $("#cashAdvance_audit").val();
var distance = $("#distance_portes").val();
var amerce = $("#amerce_portes").val();
var oilPrice = $("#oilPrice_portes").val();
var needSuggestFlag = $("#needSuggestFlag").val();
var balanceCashNextMonth = $("#balanceCashNextMonth_audit").val();
var discountFlag = $("#discountFlag_hidden").val();
//console.info($("#hiddenprotes").is(":visible"));
//console.info($("#hiddenprotes").is(":hidden"));
if ($("#hiddenprotes").is(":visible") && distance == '') {
	bootbox.alert('公里数不可为空！');
	return;
}
if ($("#hiddenprotes").is(":visible") && amerce == '') {
	bootbox.alert('罚款不可为空！');
	return;
}
if ($("#hiddenprotes").is(":visible") && oilPrice == '') {
	bootbox.alert('油价不可为空！');
	return;
}
if ($("#hiddenpre").is(":visible") && balanceCash == '') {
	bootbox.alert('实付现金不可为空！');
	return;
}
if ($("#hiddenpre").is(":visible") && balanceOil == '') {
	bootbox.alert('实付油费不可为空！');
	return;
}
if ($("#hiddenpre").is(":visible")&&discountFlag=='Y' && balanceCashNextMonth == '') {
	bootbox.alert('下月实付现金不可为空！');
	return;
}
if (businessType == '11' && $("#hiddeffice").is(":visible")
		&& (cashAdvance == '' || cashAdvance == null)) {
	bootbox.alert('确认金额不可为空！');
	return;
}
if (discountFlag=='Y' && balanceCash!= ''&& balanceCashNextMonth!= '') {
	balanceCash=balanceCash+balanceCashNextMonth;
}
if(discountFlag!='Y'){
	balanceCashNextMonth=0;
}
//$("#test").is(":hidden");//是否隐藏balanceCash
/*  if(businessType=='03'&&newCarNumber!=''){
	 bootbox.alert('新货车已选择不可重复选！');
	 return;
}  */
//console.info(taskId);
if (audit_mesg == '' && needSuggestFlag == 'Y') {
	bootbox.alert('审核意见不可为空！');
	return;
}
if (newcarNumber != '') {
	audit_mesg += "[重新指派：" + newcarNumber + "-" + newdriverName + "]";
}
var mesg = "";
if (successFlag == 'Y') {
	mesg = "确定要审核通过吗?";
} else {
	mesg = "确定要审核不通过吗?";
	$("#nbtn").attr("disabled", "true");
	return false;
	//$("#nbtn").attr("href","javascript:return false;"); 
	//$('#nbtn').css('opacity','0.2');
}
$("#ybtn").attr("disabled", "true");
$("#nbtn").attr("disabled", "true");
var flag = "false";
bootbox.confirm({
	size : "small",
	message : mesg,
	callback : function(result) {
		if (result) {
			$.ajax({
				type : 'POST',
				url : "${ctx}/dailyOffice/waitingDo/audit",
				data : JSON.stringify({
					taskId : $.trim(taskId),
					mark : $.trim(audit_mesg),
					successFlag : $.trim(successFlag),
					attachFileName : $.trim(filename),
					attachFilePath : $.trim(filepath),
					newCarNumber : $.trim(newcarNumber),
					newDriverId : $.trim(newdriver),
					balanceCash : $.trim(balanceCash),
					balanceCashNextMonth : $.trim(balanceCashNextMonth),
					balanceOil : $.trim(balanceOil),
					prepareMoney : $.trim(cashAdvance),
					amerce : $.trim(amerce),
					oilPrice : $.trim(oilPrice),
					distance : $.trim(distance)
				}),
				contentType : "application/json;charset=UTF-8",
				dataType : 'JSON',
				success : function(data) {
					if (data && data.code == 200) {
						//console.log(JSON.stringify(data.data));	
						bootbox.confirm_alert({
							size : "small",
							message : "审核成功！",
							callback : function(result) {
								if (result) {
									flag = "true";
									refresh();
								} else {
									refresh();
								}
							}
						});
						setTimeout(function() {
							if (flag == "false") {
								refresh();
								$('.bootbox').modal('hide');
							}
						}, 3000);
					} else {
						bootbox.alert(data.msg);
					}
					$("#ybtn").removeAttr("disabled");
					$("#nbtn").removeAttr("disabled");
					$('#modal-detilinfo').modal('hide');
				}
			});
		} else {
			$("#ybtn").removeAttr("disabled");
			$("#nbtn").removeAttr("disabled");
		}
	}
})

	
}
/**确认操作***/
function waybillconfirm(){
	var audit_mesg=$("#audit_mesg").val();
	var filename=$("#filename_hidden").val();
	var filepath=$("#filepath_hidden").val();
	var newcarNumber=$("#newcarNumber_audit").val();
	var newdriver=$("#newdriver_audit").val();
	var newCarNumber=$("#newCarNumber_changeCar").html();
	var taskId=$("#taskId-hidden").val();
	var balanceCash=$("#balanceCash_audit").val();
	var balanceOil=$("#balanceOil_audit").val();
	var cashAdvance=$("#cashAdvance_audit").val();
	//console.info(newCarNumber);
	if($("#hiddenprotes").is(":visible")&&distance==''){
		 bootbox.alert('公里数不可为空！');
		 return;
	}
	if($("#hiddenpre").is(":visible")&&balanceCash==''){
		 bootbox.alert('驾驶员金额不可为空！');
		 return;
	}
	if($("#hiddenpre").is(":visible")&&balanceOil==''){
		 bootbox.alert('驾驶员油卡不可为空！');
		 return;
	}
	var successFlag='Y';
	if(audit_mesg==''&&needSuggestFlag=='Y'){
		 bootbox.alert('审核意见不可为空！');
		 return;
	}
	if(newcarNumber!=''){
		audit_mesg+="[重新指派："+newcarNumber+"-"+newdriver+"]";
	}
	$("#cbtn").attr("disabled", "true");
	
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要确认吗?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/dailyOffice/waitingDo/audit",
						data : JSON.stringify({
							taskId : $.trim(taskId),				
							mark : $.trim(audit_mesg),
							successFlag : $.trim(successFlag),
							attachFileName: $.trim(filename),
							attachFilePath : $.trim(filepath),
							newCarNumber : $.trim(newcarNumber),
							newDriver : $.trim(newdriver),
							balanceCash :$.trim(balanceCash),
							balanceOil :$.trim(balanceOil),
							cashAdvance :$.trim(cashAdvance)
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								//console.log(JSON.stringify(data.data));							
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "确认成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  searchInfo();
										  }else{
											  searchInfo();
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										searchInfo();
										 $('.bootbox').modal('hide');
									}
								},3000);
							} else {
								 bootbox.alert(data.msg);
							}
							$("#cbtn").removeAttr("disabled"); 
							$('#modal-detilinfo').modal('hide');
						}
					}); 
			  }else{
				  $("#cbtn").removeAttr("disabled"); 	
			  }
		  }
		})
}
function getdamgcostdetil(){
	var id=$('#damgcostId-hidden').val();
	var arr=[];
	var path="";
	var pathlist="";
	var ids=parseInt(id);
	var html="";
	var pathHtml="";
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/carDamageCostMng/getDetail/"+id,
		data :{},
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				if(data.data.type=='0'){
					$('#stypeInfo').html('直接赔付');
				}else if(data.data.type=='1'){
					$('#stypeInfo').html('买断');
				}else{
					$('#stypeInfo').html('');
				}
				if(data.data.insuranceFlag=="Y"){
					$('#sinsuranceFlag').html('是');
				}else{
					$('#sinsuranceFlag').html('否');
				}				
				$('#sscheduleInfo').html(data.data.scheduleBillNo);
				$('#sbankName').html(data.data.bankName);
				$('#saccountName').html(data.data.accountName);
				$('#saccountNo').html(data.data.accountNo);
				$('#samount').html(data.data.amount);
				$('#smark').html(data.data.mark);
				$('#scarNo').html(data.data.carNumber);
				$('#sdriver').html(data.data.driver);
				if(data.data.detailList!=null && data.data.detailList.length>0){
					var objs=data.data.detailList;
					var carlist=data.data.carStockList;
					for(var i=0;i<objs.length;i++){
						html+='<tr>'
						     +'<td>'+carlist[i]["waybillNo"]+'</td>'
						     +'<td>'+carlist[i]["brand"]+'</td>'
						     +'<td>'+carlist[i]["model"]+'</td>'
						     +'<td>'+carlist[i]["vin"]+'</td>'
						     +'<td>'+carlist[i]["color"]+'</td>'
						     +'<td>'+carlist[i]["engineNo"]+'</td>'
						     +'<td>'+carlist[i]["carShopName"]+'</td>'
						     +'<td>'+objs[i]["amount"]+'</td>'
						     +'</tr>';
					}
				}
				if(data.data.attachFilePath!=null && data.data.attachFilePath!=''){
					 path=data.data.attachFilePath
					 pathlist = path.substring(0, path.length-1);
					 arr = pathlist.split(';');
					 if(arr!=null && arr!="" && arr.length>0){
						 for(var k=0;k<arr.length;k++){
							 var attachFilePaths="${ctx}"+arr[k];
							 pathHtml+='<p><a href='+attachFilePaths+' target="_blank">照片'+(k+1)+'</a></p>';
						 }
						 
					 }
				}
				
				$('#spdetailTable tbody').html(html);
				$('#sfilename').html(pathHtml);
				$('#modal-view').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}

/**快速调度的明细**/
function fastgetdetils(){
	 var scheduleBillNo = $('#scheduleBillNo-hidden').val();
	 var flag="5";
	// $('#modal-fastshedeinfo').modal('show');
	//window.open("${ctx}/operationMng/scheduleMng/fastDetailIndex/"+scheduleBillNo+'/'+flag, "newwindow", "height=750, width=1000, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no") 
var url="${ctx}/operationMng/scheduleMng/fastDetailIndex/"+scheduleBillNo+"/"+flag;
	  bootbox.dialog({  
         message: '<iframe width=1000 height=550 frameborder=0 scrolling=auto src='+url+'></iframe>',  
         title: "快速调度信息"  
     }); 
	}
</script>



</body>
</html>






