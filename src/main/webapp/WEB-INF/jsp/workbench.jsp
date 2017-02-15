
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
#modal-detilinfo{
    width: 1000px;
    height: 600px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }  
    .well{
    margin-bottom : 0px;
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
				工作台
			</small>
		</h1>
	</div><!-- /.page-header -->	
	<div class="page-content">
		<div class="searchbox col-xs-12">
		     <label class="title ">状态：</label>
		     <select id="fom_type" class="form-box">
		      <option value='0'>待办</option>
		      <option value='1'>已办</option>
			</select>	
			<a class="itemBtn " onclick="searchInfo()">查询</a>
			<!-- <a class="itemBtn " onclick="doadd()">新增</a>	 -->		
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>标题</th>
					<th>接收时间</th>
                    <th>来源</th>
                    <th>操作时间</th>                   
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
                                        <input class="form-control" id="tranPortCostId-hidden" type="hidden" /></div>
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
                                          <label class="title col-xs-2">出发地：</label>
                                          <label class="title col-xs-10" id="startAddress_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">目的地：</label>
                                          <label class="title col-xs-10" id="targetAddress_audit"></label>
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
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">发车日期：</label>
                                          <label class="title col-xs-4" id="shnsendTime_audit"></label>
                                          <label class="title col-xs-2">交车日期：</label>
                                          <label class="title col-xs-4" id="receiveTime_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">数量：</label>
                                          <label class="title col-xs-4" id="schamount_audit"></label>
                                          <label class="title col-xs-2">期望到达日期：</label>
                                          <label class="title col-xs-4" id="planReachTime_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">出发地：</label>
                                          <label class="title col-xs-4" id="shnstartAddress_audit"></label>
                                          <label class="title col-xs-2">目的地：</label>
                                          <label class="title col-xs-4" id="endAddress_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">货运车：</label>
                                          <label class="title col-xs-4" id="carNumber_audit"></label>
                                          <label class="title col-xs-2">驾驶员：</label>
                                          <label class="title col-xs-4" id="driver_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">备注：</label>
                                          <label class="title col-xs-4" id="mark_audit"></label>
                                        </div>
                                        <hr class="tree"></hr>
                                        <div class="add-item-btn" id="detilbtns" style="margin-left:0px;">
                                          <a class="add-detilBtn" onclick="getdetils();">调度单明细</a></div>
                                      </div>
                                      <div id="changeCar_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">调度单：</label>
                                          <label class="title col-xs-4" id="scheduleBillNo_changeCar"></label>
                                          <!-- <label class="title col-xs-2">交车日期：</label><label class="title col-xs-4" id="receiveTime_audit"></label>	 --></div>
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">货运车：</label>
                                          <label class="title col-xs-4" id="oldCarNumber_changeCar"></label>
                                          <label class="title col-xs-2">新货运车：</label>
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
                                          <label class="title col-xs-2">车号：</label>
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
                                                <th>规格</th>
                                                <th>备注</th></tr>
                                            </thead>
                                            <tbody></tbody>
                                          </table>
                                        </div>
                                      </div>
                                      <div id="trackMaint_msg">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">货运车：</label>
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
                                          <label class="title col-xs-2">车号：</label>
                                          <label class="title col-xs-4" id="carNumber_port"></label>
                                          <label class="title col-xs-2">驾驶员：</label>
                                          <label class="title col-xs-4" id="driver_port"></label>
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
                                        <label class="title col-xs-2">新货运车：</label>
                                        <div class="col-xs-4">
                                          <select class="form-control" id="newcarNumber_audit">
                                            <option value="">请选择货运车</option></select>
                                        </div>
                                        <label class="title col-xs-2">新驾驶员：</label>
                                        <div class="col-xs-4">
                                          <input class="form-control" id="newdriver_audit" type="text" readonly="readonly" placeholder="请输入驾驶员" /></div>
                                      </div>                                     
                                      <div class="add-item col-xs-12" style="margin-bottom: 10px;" id="hidden2">
                                        <label class="title col-xs-2">
                                          <span class="red">*</span>审核意见 ：</label>
                                        <div class="col-xs-10" id="hidden5">
                                          <textarea rows="4" cols="4" class="form-control" id="audit_mesg" placeholder="请输入审核意见"></textarea>
                                        </div>
                                          <div id="hiddeffice" >
                                     <!--  <div class="add-item col-xs-12" >
                                        <label class="title tobold ">预付信息</label></div> -->
                                         <div class="add-item col-xs-12" style="margin-bottom: 10px;padding-top: 15px;">
                                        <label class="title col-xs-2">确认金额：</label>
                                        <div class="col-xs-8">
                                          <input class="form-control" id="cashAdvance_audit" type="text"  placeholder="请输入确认金额"   onblur="revaildate(this,0);"/></div>                                                                               
                                        </div>                                      
                                      </div>
                                       <div id="hiddenpre" >
                                      <!-- <div class="add-item col-xs-12" >
                                        <label class="title tobold ">结付信息</label></div> -->
                                         <div class="add-item col-xs-12" style="margin-bottom: 10px;padding-top: 15px;">
                                        <label class="title col-xs-2">结付驾驶员金额：</label>
                                        <div class="col-xs-4">
                                          <input class="form-control" id="balanceCash_audit" type="text"  placeholder="请输入驾驶员金额"  onblur="revaildate(this,1);" /></div>
                                        
                                        <label class="title col-xs-2">结付驾驶员油卡：</label>
                                        <div class="col-xs-4">
                                          <input class="form-control" id="balanceOil_audit" type="text"  placeholder="请输入驾驶员油卡" /></div>
                                        </div>                                      
                                      </div>
                                        <div class="add-item col-xs-12" style="margin-bottom: 10px;margin-top: 20px;" id="hidden6">
                                          <label class="title col-xs-2">附件 ：</label>
                                          <div class="col-xs-10">
                                            <input type="file" id="inputfile" />
                                            <label class="title" id="filename"></label>
                                            <input type="hidden" name="filename_hidden" id="filename_hidden" />
                                            <input type="hidden" name="filepath_hidden" id="filepath_hidden" /></div>
                                        </div>
                                      </div>
                                     
                                      <div class="add-item-btn" id="auditBtn">
                                       <button class="btn btn-primary btnOk" type="button" onclick="waybillaudit('Y');" id="ybtn" style="margin-left: 380px;">通过</button>
                                      <button class="btn btn-primary btnOk" type="button" onclick="waybillaudit('N');" id="nbtn" >不通过</button>
                                       
                                        <!-- <a class="add-itemBtn btnOk" onclick="waybillaudit('Y');" style="margin-left: 180px;">通过</a>
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
                                        <label class="title col-xs-2">发运日期：</label>
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
                                        <label class="title col-xs-2">出发地：</label>
                                        <label class="title col-xs-10" id="startAddress_view"></label>
                                      </div>
                                      <hr class="tree"></hr>
                                      <div class="add-item col-xs-12">
                                        <label class="title col-xs-2">目的地：</label>
                                        <label class="title col-xs-10" id="targetAddress_view"></label>
                                      </div>
                                      <div id="hiddenes3">
                                        <hr class="tree"></hr>
                                        <div class="add-item col-xs-12">
                                          <label class="title col-xs-2">公里数：</label>
                                          <label class="title col-xs-10" id="distance_view"></label>
                                        </div>
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
                                              <th>数量</th>
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
                                        <!-- <div class="table-tit">编辑调度单</div> -->
                                        <input type="hidden" id="listlength" />
                                        <div class="table-item">
                                          <div class="table-itemTit">基本信息</div>
                                          <!-- 第一列 -->
                                          <div class="row newrow">
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>发车日期:</label></div>
                                            </div>
                                            <div class="col-xs-5">
                                              <div class="form-contr">
                                                <p id="sendTime" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>交车日期:</label></div>
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
                                                <label>期望到达日期:</label></div>
                                            </div>
                                            <div class="col-xs-5">
                                              <div class="form-contr">
                                                <p id="planReachTime" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>数量:</label></div>
                                            </div>
                                            <div class="col-xs-5">
                                              <div class="form-contr">
                                                <p id="all-amount" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                          </div>
                                          <!-- 第三列 -->
                                          <div class="row newrow">
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>出发地:</label></div>
                                            </div>
                                            <div class="col-xs-5">
                                              <div class="form-contr">
                                                <p id="startAddress" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>目的地:</label></div>
                                            </div>
                                            <div class="col-xs-5">
                                              <div class="form-contr">
                                                <p id="endAddress" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                          </div>
                                          <!-- 第四列 -->
                                          <div class="row newrow">
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>货运车:</label></div>
                                            </div>
                                            <div class="col-xs-5">
                                              <div class="form-contr">
                                                <p id="carNumber" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>驾驶员:</label></div>
                                            </div>
                                            <div class="col-xs-5">
                                              <div class="form-contr">
                                                <p id="driver" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                          </div>
                                          <!-- 第五列 -->
                                          <div class="row newrow">
                                            <div class="col-xs-1 pd-2">
                                              <div class="lab-tit">
                                                <label>备注:</label></div>
                                            </div>
                                            <div class="col-xs-11">
                                              <div class="form-contr">
                                                <p id="mark" class="form-control no-border"></p>
                                              </div>
                                            </div>
                                          </div>
                                          <!--设置商品车详细信息-->
                                          <div class="row row-btn-tit" id="carDetail">
                                            <div class="col-xs-2 pd-2">
                                              <div class="row-tit">详细信息</div></div>
                                            <div class="col-xs-10"></div>
                                          </div>
                                          <!-- 操作按钮栏 -->
                                          <div class="row newrow">
                                            <div class="col-xs-5"></div>
                                            <div class="col-xs-2">
                                              <div class="form-contr">
                                                <a class="backbtn" onclick="doback();">
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
                                                <label>车号:</label></div>
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
  <h3 id="myModalLabel">装运费用核算信息</h3></div>
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
			             <label>车号:</label>
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
		      <!-- <div class="row bor-b-ff9a00">
			        <label class="f-s14">油费</label>
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
		      </div> -->
		       <!-- 交车费 -->
		       <div class="catoList">
		          <div class="row bor-b-ff9a00">
			        <label class="f-s14">交车费</label>
		          </div>
			      <div class="row newrow bor-b-ff9a00-1">
			           <div class="col-xs-1 pd-2">
					       <div class="lab-tit">
					          <label>收费单位:</label>
					       </div>
				        </div>
				       <div class="col-xs-5">
				           <div class="form-contr">
				              <p class="form-control no-border" id="name0_prt"></p>
				           </div>
				       </div>
				       <div class="col-xs-1 pd-2">
					       <div class="lab-tit">
					          <label>金额:</label>
					       </div>
				        </div>
				       <div class="col-xs-5">
				           <div class="form-contr">
				              <p class="form-control no-border" id="amount0_prt"></p>
				            </div>
				       </div>
			      </div>
		       </div>
		      
		       <!-- 带路费 -->
		      <div class="catoList">
		         <div class="row bor-b-ff9a00">
			        <label class="f-s14">带路费</label>
			      </div>
			      <div class="row newrow bor-b-ff9a00-1">
			           <div class="col-xs-1 pd-2">
					       <div class="lab-tit">
					          <label>带路地点:</label>
					       </div>
				        </div>
				       <div class="col-xs-5">
				           <div class="form-contr">
				              <p class="form-control no-border" id="name1_prt"></p>
				           </div>
				       </div>
				       <div class="col-xs-1 pd-2">
					       <div class="lab-tit">
					          <label>金额:</label>
					       </div>
				        </div>
				       <div class="col-xs-5">
				           <div class="form-contr">
				              <p class="form-control no-border" id="amount1_prt"></p>
				            </div>
				       </div>
			      </div>
		      </div>
		      
		       <!-- 罚款 -->
		       <div class="catoList">
		          <!-- <div class="row bor-b-ff9a00">
			        <label class="f-s14">罚款</label>
			      </div>
			      <div class="row newrow bor-b-ff9a00-1">
			           <div class="col-xs-1 pd-2">
					       <div class="lab-tit">
					          <label>罚款路段:</label>
					       </div>
				        </div>
				       <div class="col-xs-5">
				           <div class="form-contr">
				              <p class="form-control no-border" id="name1_prt"></p>
				           </div>
				       </div>
				       <div class="col-xs-1 pd-2">
					       <div class="lab-tit">
					          <label>金额:</label>
					       </div>
				        </div>
				       <div class="col-xs-5">
				           <div class="form-contr">
				              <p class="form-control no-border" id="amount2_prt"></p>
				            </div>
				       </div>
			      </div> -->
		       </div>
		      
		      <!-- 餐费 -->
		      <div class="catoList">
		         <div class="row bor-b-ff9a00">
			        <label class="f-s14">餐费</label>
			      </div>
			      <div class="row newrow bor-b-ff9a00-1">
			           <div class="col-xs-1 pd-2">
					       <div class="lab-tit">
					          <label>详情:</label>
					       </div>
				        </div>
				       <div class="col-xs-5">
				           <div class="form-contr">
				              <p class="form-control no-border" id="name3_prt"></p>
				           </div>
				       </div>
				       <div class="col-xs-1 pd-2">
					       <div class="lab-tit">
					          <label>金额:</label>
					       </div>
				        </div>
				       <div class="col-xs-5">
				           <div class="form-contr">
				              <p class="form-control no-border" id="amount3_prt"></p>
				            </div>
				       </div>
			      </div>
		      </div>
		      
		      <!-- 住宿费 -->
		      <div class="catoList">
		         <div class="row bor-b-ff9a00">
			        <label class="f-s14">住宿费</label>
			      </div>
			      <div class="row newrow bor-b-ff9a00-1">
			           <div class="col-xs-1 pd-2">
					       <div class="lab-tit">
					          <label>详情:</label>
					       </div>
				        </div>
				       <div class="col-xs-5">
				           <div class="form-contr">
				              <p class="form-control no-border" id="name4_prt"></p>
				           </div>
				       </div>
				       <div class="col-xs-1 pd-2">
					       <div class="lab-tit">
					          <label>金额:</label>
					       </div>
				        </div>
				       <div class="col-xs-5">
				           <div class="form-contr">
				              <p class="form-control no-border" id="amount4_prt"></p>
				            </div>
				       </div>
			      </div>
		      </div>
		      
		      <!-- 其它支出费 -->
		      <div class="catoList">
		        <div class="row bor-b2-ff9a00">
			        <div class="col-xs-2 pd-2">
				       <div class="row-tit">
				                           其它支出费
				       </div>
			       </div>
		       		<div class="col-xs-8"></div>
			       <div class="col-xs-2"></div>
			     </div>
			     <div id="amountExtra0" class="extraList bor-b-ff9a00-1">
				    <div class="row newrow">
				       <div class="col-xs-1 pd-2">
					       <div class="lab-tit">
					          <label>项目:</label>
					       </div>
				        </div>
				       <div class="col-xs-5">
				           <div class="form-contr">
				              <p class="form-control no-border" id="name5_0_prt"></p>
				           </div>
				       </div>
				       <div class="col-xs-1 pd-2">
					       <div class="lab-tit">
					          <label>金额:</label>
					       </div>
				        </div>
				       <div class="col-xs-5">
				           <div class="form-contr">
				              <p class="form-control no-border" id="amount5_0_prt"></p>
				            </div>
				       </div>
				    </div>
		      </div>
		      
		      </div>
		      <!--预付信息-->
		     <div class="table-itemTit bor-t-ff9a00">预付信息</div>
		     <div class="row newrow">
		           <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>预付时间:</label>
				       </div>
			        </div>
			       <div class="col-xs-5">
			           <div class="form-contr">
			              <p class="form-control no-border" id="prePay_prt"></p>
			           </div>
			       </div>
			       <div class="col-xs-6"></div>
		      </div>
		      <!-- 现金 -->
		      <div class="row newrow bor-b-ff9a00-1">
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>现金金额:</label>
				       </div>
			        </div>
			       <div class="col-xs-5">
			           <div class="form-contr">
			              <p class="form-control no-border" id="preAmount0_prt"></p>
			            </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>油卡金额:</label>
				       </div>
			        </div>
			       <div class="col-xs-5">
			           <div class="form-contr">
			              <p class="form-control no-border" id="preAmount1_prt"></p>
			            </div>
			       </div>
		      </div> 
		      <!-- 油卡 -->
		      <div class="row bor-b-ff9a00">
			        <label class="f-s14">油卡</label>
		      </div>
		      <div class="row newrow bor-b-ff9a00-1">
		           <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>预付时间:</label>
				       </div>
			        </div>
			       <div class="col-xs-5">
			           <div class="form-contr">
			              <p class="form-control no-border" id="preApplyTime1_prt"></p>
			           </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>金额:</label>
				       </div>
			        </div>
			       <div class="col-xs-5">
			           <div class="form-contr">
			              <p class="form-control no-border" id="preAmount1_prt"></p>
			            </div>
			       </div>
		      </div>
		        <!--费用小计信息-->
		     <div class="table-itemTit bor-b-ff9a00">费用小计</div> 
		     <div class="row newrow">
		           <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>现金小计:</label>
				       </div>
			        </div>
			       <div class="col-xs-5">
			           <div class="form-contr">
			              <p class="form-control no-border" id="sumMoney_prt"></p>
			           </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>油费小计:</label>
				       </div>
			        </div>
			       <div class="col-xs-5">
			           <div class="form-contr">
			              <p class="form-control no-border" id="oilMoney_prt"></p>
			           </div>
			       </div>
		      </div>      
		   </div>
          <!-- 操作按钮栏 -->
         <div class="row newrow">
        <div class="col-xs-5"></div>
        <div class="col-xs-2">
       <div class="form-contr">
       <a class="backbtn" onclick="doportback();">
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
		    {data: "operateTime",'width':'15%'},
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
					 //类型
					 targets:4,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
						
				     }	       
				},{
					 //状态
					 targets:5,
					 render: function (data, type, row, meta) {
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
		 "sAjaxSource": "${ctx}/dailyOffice/waitingDo/getListDataForHasDo" , //获取数据的ajax方法的URL	
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
					    {data: "operateTime",'width':'15%'},
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
								 //类型
								 targets:4,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }
									
							     }	       
							},{
								 //状态
								 targets:5,
								 render: function (data, type, row, meta) {
									
						    			 return '<a class="table-edit" onclick="doview('+ row.itemId +','+ row.processDetailId +','+ row.id +')">查看</a>'
								           /* +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>' */; 
						    		 
							      }	       
							}
					      ],
				        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

$(function(){
	upload();
	init();
	//getCarNo();
})
/*附件上传*/
 function upload(){
	$("#inputfile").uploadify({
		//按钮额外自己添加点的样式类.upload
        'buttonClass':'upload',
        //限制文件上传大小
        'fileSizeLimit':'200MB',
        //文件选择框显示
        'fileTypeDesc':'选择',
        //文件类型过滤
       /*  'fileTypeExts':'*.zip;*.rar', */
        //按钮高度
        'height':'30',
        //按钮宽度
        'width':'100',
        //请求类型
        'method':'post',
        //是否支持多文件上传
        'multi':false,
        /* //需要重写的事件
        'overrideEvents'    :    ['onUploadError'], */
        /* //队列ID，用来显示文件上传队列与进度
        'queueID'            :    'photo_queue', */
        //队列一次最多允许的文件数，也就是一次最多进入上传队列的文件数
        'queueSizeLimit': 1,
        //上传动画，插件文件下的swf文件
        'swf':'${ctx}/staticPublic/js/uploadify/uploadify.swf',
        //处理上传文件的服务类
        'uploader':'${ctx}/upload/saveFile?type=task',
        /* //上传文件个数限制
        'uploadLimit': 1, */
        //上传按钮内容显示文本
        'buttonText':'上传',
         //自定义重写的方法，文件上传错误触发
        /*'onUploadError'        :   function(file,errorCode,erorMsg,errorString){
        	alert(erorMsg);
        },
        //文件选择错误触发
        'onSelectError'        :    uploadify_onSelectError, */
        /* //文件队列上传完毕触发
        'onQueueComplete'    :    heightReset,
        //队列开始上传触发
        'onUploadStart'        :   heightFit, */
        //单个文件上传成功触发
        'onUploadSuccess':function(file, data, response){        	
        	//刷新目录
        	var orginFileName = JSON.parse(data).orginFileName;        		
        	var attachFilePath = JSON.parse(data).attachFilePath;
        	 var attachFilePaths="${ctx}"+attachFilePath;
        	//console.info(attachFilePath);
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#filename').html(html);
        	$('#filename_hidden').val(orginFileName);
        	$('#filepath_hidden').val(attachFilePath);
        }
    });
}
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
					//console.log(JSON.stringify(data.data));								
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
	var type=$('#fom_type').val();
	if(type=='0'){
		init();
	}else{
		reload();	
	}
	
}
/**已办事项查看**/
function doview(itemId,processDetailId,taskId){
	$('#taskId-hidden').val(taskId); 
	$('#hidden7').hide();
	$('#stephidden').hide();
	$('#hidden2').hide();
	$('#hidden8').hide();
	$('#hidden6').hide();
	$('#hiddenpre').hide();
	$('#hiddeffice').hide();
	$('#auditBtn').hide();
	$('#confirmBtn').hide();
	$('#msglble').hide();
	$('#myModalLabel').html('已办信息');
		 $.ajax({
				type : 'GET',
				url : "${ctx}/dailyOffice/waitingDo/getDetailInfoForItem/"+itemId,
				contentType : "application/json;charset=UTF-8",
				dataType : 'JSON',
				success : function(data) {
					if (data && data.code == 200) {							
						//console.log(JSON.stringify(data.data));
						$('#businessType-hidden').val(data.data.businessType);
						if(data.data.businessType=='01'){
							$('#waybill_msg').show();
							$('#scheduleBill_msg').hide();
							$('#changeCar_msg').hide();
							$('#Prepay_msg').hide();
							$('#trackTyreInOut_msg').hide();
							$('#trackMaint_msg').hide();
							$('#portCost_msg').hide();
							$('#officeapply_msg').hide();
							$('#detilbtn').show();						
							$('#modal-detilinfo').modal('show');						
							if(data.data.detail.type=='1'){
								$("#type_audit").html('二手车'); 
								$('#hiddens1').hide();
								$('#hiddens3').hide();
								$('#hiddens2').show();
							}else{
								$("#type_audit").html('商品车'); 
								$('#hiddens1').show();
								$('#hiddens2').hide();
								$('#hiddens3').show();
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
							$('#detilbtns').show();						
							$('#modal-detilinfo').modal('show');	
							$('#scheduleBillNo-hidden').val(data.data.detail.scheduleBillNo);
							$("#scheduleBillNo_audit").html(data.data.detail.scheduleBillNo);
							$("#shnsendTime_audit").html(jsonForDateFormat(data.data.detail.sendTime)); 
							$("#receiveTime_audit").html(jsonForDateFormat(data.data.detail.receiveTime)); 
							$("#schamount_audit").html(data.data.detail.amount); 
							$("#planReachTime_audit").html(jsonForDateFormat(data.data.detail.planReachTime));
							$("#shnstartAddress_audit").html(data.data.detail.startAddress); 
							$("#endAddress_audit").html(data.data.detail.endAddress); 
							$("#carNumber_audit").html(data.data.detail.carNumber); 
							$("#driver_audit").html(data.data.detail.driver); 
							$("#mark_audit").html(data.data.detail.mark);						
							if(data.data.detail.id!=''){
								$('#scheduleBillId-hidden').val(data.data.detail.id);	
							}
						}else if(data.data.businessType=='03'){
							
							//$('#hidden6').hide();
							$('#waybill_msg').hide();
							$('#scheduleBill_msg').hide();
							$('#mesg_detilbtn').hide();
							$('#changeCar_msg').show();
							$('#Prepay_msg').hide();
							$('#trackTyreInOut_msg').hide();
							$('#trackMaint_msg').hide();
							$('#officeapply_msg').hide();
							$('#portCost_msg').hide();
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
							$('#hidden8').hide();
							$('#hidden6').hide();
							$('#prepay_detilbtn').hide();						
							$('#modal-detilinfo').modal('show');	
							$("#prepayCarNumber_audit").html(data.data.detail.carNumber); 
							$("#applyTime_audit").html(data.data.detail.applyTime); 
							$("#prepaydriver_audit").html(data.data.detail.driver); 
							$("#prepaymobile_audit").html(data.data.detail.mobile); 
							$("#prepayCash_audit").html(data.data.detail.prepayCash);
							$("#bankName_audit").html(data.data.detail.bankAccount);
							$("#bankAccount_audit").html(data.data.detail.bankAccount);
							$("#oilCardNo_audit").html(data.data.detail.oilCardNo);
							$("#oilAmount_audit").html(data.data.detail.oilAmount);
							$("#prepaymark_audit").html(data.data.detail.mark);
							if(data.data.detail.id!=''){
								$('#tranPrepayId-hidden').val(data.data.detail.id);	
							}
						}else if(data.data.businessType=='05'){
							
							$('#waybill_msg').hide();
							$('#scheduleBill_msg').hide();
							$('#mesg_detilbtn').hide();
							$('#changeCar_msg').hide();
							$('#Prepay_msg').hide();
							$('#trackTyreInOut_msg').hide();
							$('#trackMaint_msg').hide();
							$('#portCost_msg').show();
							$('#officeapply_msg').hide();
							$('#hidden8').hide();
							$('#hidden6').hide();
							$('#portCost_detilbtn').show();						
							$('#modal-detilinfo').modal('show');	
							$("#scheduleBillNo_port").html(data.data.detail.scheduleBillNo); 
							$("#applyTime_port").html(jsonForDateFormat(data.data.detail.applyTime)); 
							$("#carNumber_port").html(data.data.detail.carNumber); 
							$("#driver_port").html(data.data.detail.driver); 					
							if(data.data.detail.id!=''){
								$('#tranPortCostId-hidden').val(data.data.detail.id);	
							}
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
							$('#hidden8').hide();
							$('#hidden6').hide();
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
							}
							if(data.data.detail.detailList.length>0){
								for(var i=0;i<data.data.detail.detailList.length;i++){
									data.data.detail.detailList[i]["rownum"]=i+1;
								}								
							}
							$('#tyreNo_detailtable').dataTable({
								 "destroy": true,//如果需要重新加载需销毁
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
								    {data: "spec"},								    
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
							$('#hidden8').hide();
							$('#hidden6').hide();
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
							$('#mesg_detilbtn').hide();
							$('#changeCar_msg').hide();
							$('#Prepay_msg').hide();
							$('#trackTyreInOut_msg').hide();
							$('#trackMaint_msg').hide();
							$('#officeapply_msg').show();
							$('#portCost_msg').hide();
							$('#hidden8').hide();
							$('#hidden6').hide();
							$('#modal-detilinfo').modal('show');	
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


/* 绑定货运车 */
function getStockList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/scheduleMng/getStockList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: JSON.stringify({}),
	        success: function (data) {
	        	var html ='<option value="" data-id="">请选择货运车</option>';
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
					//console.log(JSON.stringify(data.data));
					$('#businessType-hidden').val(data.data.businessType);
					if(data.data.businessType=='01'){
						$('#waybill_msg').show();
						$('#scheduleBill_msg').hide();
						$('#hidden8').hide();
						$('#hidden6').show();
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').hide();
						$('#officeapply_msg').hide();
						$('#detilbtn').show();							
						$('#modal-detilinfo').modal('show');						
						if(data.data.detail.type=='1'){
							$("#type_audit").html('二手车'); 
							$('#hiddens1').hide();
							$('#hiddens3').hide();
							$('#hiddens2').show();
						}else{
							$("#type_audit").html('商品车'); 
							$('#hiddens1').show();
							$('#hiddens2').hide();
							$('#hiddens3').show();
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
						$('#detilbtns').show();	
						$('#hidden8').hide();
						$('#hidden6').show();
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
						$('#modal-detilinfo').modal('show');	
						$('#scheduleBillNo-hidden').val(data.data.detail.scheduleBillNo);
						$("#scheduleBillNo_audit").html(data.data.detail.scheduleBillNo);
						$("#shnsendTime_audit").html(jsonForDateFormat(data.data.detail.sendTime)); 
						$("#receiveTime_audit").html(jsonForDateFormat(data.data.detail.receiveTime)); 
						$("#schamount_audit").html(data.data.detail.amount); 
						$("#planReachTime_audit").html(jsonForDateFormat(data.data.detail.planReachTime));
						$("#shnstartAddress_audit").html(data.data.detail.startAddress); 
						$("#endAddress_audit").html(data.data.detail.endAddress); 
						$("#carNumber_audit").html(data.data.detail.carNumber); 
						$("#driver_audit").html(data.data.detail.driver); 
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
						$('#hidden8').show();
						$('#hidden6').hide();
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
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
						$('#hidden8').hide();
						$('#hidden6').show();
						$('#hiddenpre').hide();
						$('#hiddeffice').show();
						$('#prepay_detilbtn').show();						
						$('#modal-detilinfo').modal('show');	
						$("#prepayCarNumber_audit").html(data.data.detail.carNumber); 
						$("#applyTime_audit").html(jsonForDateFormat(data.data.detail.applyTime)); 
						$("#prepaydriver_audit").html(data.data.detail.driver); 
						$("#prepaymobile_audit").html(data.data.detail.mobile); 
						$("#prepayCash_audit").html(data.data.detail.prepayCash);
						$("#bankName_audit").html(data.data.detail.bankAccount);
						$("#bankAccount_audit").html(data.data.detail.bankAccount);
						$("#oilCardNo_audit").html(data.data.detail.oilCardNo);
						$("#oilAmount_audit").html(data.data.detail.oilAmount);
						$("#prepaymark_audit").html(data.data.detail.mark);
						if(data.data.detail.id!=''){
							$('#tranPrepayId-hidden').val(data.data.detail.id);	
						}
					}else if(data.data.businessType=='05'){
						
						$('#waybill_msg').hide();
						$('#scheduleBill_msg').hide();
						$('#mesg_detilbtn').hide();
						$('#changeCar_msg').hide();
						$('#Prepay_msg').hide();
						$('#trackTyreInOut_msg').hide();
						$('#trackMaint_msg').hide();
						$('#portCost_msg').show();
						$('#officeapply_msg').hide();
						$('#hidden8').hide();
						$('#hidden6').show();
						$('#hiddenpre').show();
						$('#hiddeffice').hide();
						$('#portCost_detilbtn').show();						
						$('#modal-detilinfo').modal('show');	
						$("#scheduleBillNo_port").html(data.data.detail.scheduleBillNo); 
						$("#applyTime_port").html(jsonForDateFormat(data.data.detail.applyTime)); 
						$("#carNumber_port").html(data.data.detail.carNumber); 
						$("#driver_port").html(data.data.detail.driver); 					
						if(data.data.detail.id!=''){
							$('#tranPortCostId-hidden').val(data.data.detail.id);	
						}
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
						$('#hidden8').hide();
						$('#hidden6').show();
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
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
							    {data: "spec"},							 
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
						$('#hidden8').hide();
						$('#hidden6').show();
						$('#hiddenpre').hide();
						$('#hiddeffice').hide();
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
						$('#hidden8').hide();
						$('#hidden6').show();
						$('#hiddenpre').hide();
						$('#hiddeffice').show();
						$('#modal-detilinfo').modal('show');	
						$("#process_off").html(data.data.item.processName); 
						$("#itemName_off").html(data.data.item.itemName);
						$("#amount_off").html(data.data.item.amount); 
						$("#cashAdvance_off").html(data.data.item.cashAdvance);
						$("#startTime_off").html(data.data.item.startTime); 
						$("#endTime_off").html(data.data.item.endTime); 
						$("#mark_maint").html(data.data.item.mark); 						
					}
					
					$.ajax({
						type : 'GET',
						url : "${ctx}/dailyOffice/waitingDo/getProcessDetailInfo/"+processDetailId,
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								var name="["+data.data.name+"]";
								$("#name_mesg").html(name); 
								if(data.data.orderNo=='0'){
									$('#hidden2').hide();
									$('#hidden3').hide();
									$('#auditBtn').hide();
									$('#confirmBtn').hide();
									$('#msglble').show();
									$('#stephidden').hide();
								} else if(data.data.type=='0'){
									$('#auditBtn').show();
									$('#confirmBtn').hide();
									$('#msglble').hide();
									
								}else if(data.data.type=='1'){
									$('#auditBtn').hide();
									$('#confirmBtn').show();
									$('#msglble').hide();
									
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
function newpage(){
	var businessType=$("#businessType-hidden").val();
	var waybillNo=$("#waybillNo-hidden").val();
	if(businessType=='01'){
		parent.addTabs({id:'49',title: '运单管理',close: true,url: '${ctx}/waybill/waybillManage/index?'+waybillNo});
	}else if(businessType=='02'){
		parent.addTabs({id:'52',title: '调度管理',close: true,url: '${ctx}/operationMng/scheduleMng/index'});
	}else if(businessType=='03'){
		parent.addTabs({id:'59',title: '在途换车管理',close: true,url: '${ctx}/operationMng/trackChangeMng/index'});
	}else if(businessType=='04'){
		parent.addTabs({id:'21',title: '装运预付申请',close: true,url: '${ctx}/operationMng/transportPrepayMng/officeIndex'});
	}else if(businessType=='05'){
		parent.addTabs({id:'22',title: '驾驶员报销申请',close: true,url: '${ctx}/operationMng/transportCostMng/officeIndex'});
	}else if(businessType=='06'){
		parent.addTabs({id:'61',title: '轮胎出入库管理',close: true,url: '${ctx}/operationMng/trackTyreInOutMng/index'});
	}else if(businessType=='07'){
		parent.addTabs({id:'62',title: '维修保养管理',close: true,url: '${ctx}/operationMng/trackMaintMng/index'});
	}else if(businessType=='08'){
		parent.addTabs({id:'23',title: '办公费用申请',close: true,url: '${ctx}/dailyOffice/officeApply/index'});
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
				}else{
					$("#type_view").html('商品车'); 
					$('#hiddenes1').show();
					$('#hiddenes2').hide();
					$('#hiddenes3').show();
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
				$("#targetAddress_view").html(data.data.targetAddress);
				$("#distance_view").html(data.data.distance);	
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
	  var carHtml="";
	  var carAttachmentHtml="";
	  var detailListHtml="";
	  $.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/scheduleMng/getDetailData/"+scheduleBillNo,
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					$('#sendTime').html(jsonForDateFormat(data.data['sendTime']));
					$('#receiveTime').html(jsonForDateFormat(data.data['receiveTime']));
					$('#planReachTime').html(jsonForDateFormat(data.data['planReachTime']));
					$('#all-amount').html(data.data['amount']);
					$('#startAddress').html(data.data['startAddress']);
					$('#endAddress').html(data.data['endAddress']);
					$('#carNumber').html(data.data['carNumber']);
					$('#driver').html(data.data['driver']);
					$('#mark').html(data.data['mark']);
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
						        
							if(data.data['detailList'][i]['carShopId']!=null && data.data['detailList'][i]['carShopId']!=''){
								detailListHtml+='<div class="border-b-ff9a00 detailList" id="detailList'+i+'">'
									  +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>经销单位:</label></div></div>'
						              +'<div class="col-xs-4"><div class="form-contr"><p class="carShopId-item form-control">'+data.data['detailList'][i]['carShopName']+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>数量:</label></div></div>'
						              +'<div class="col-xs-2"><div class="form-contr"><p class="amount-item form-control">'+data.data['detailList'][i]['amount']+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>详细指令:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="detailMark-item form-control">'+data.data['detailList'][i]['mark']+'</p></div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>车辆信息:</label></div></div>'
						              +'<div class="col-xs-11"><div class="newCarDetail-item">'+carHtml+'</div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>配件信息:</label></div></div>'
						              +'<div class="col-xs-11"><div class="newPartDetail-item">'+carAttachmentHtml+'</div></div></div></div>';
							}else{
								detailListHtml+='<div class="border-b-ff9a00 detailList" id="detailList'+i+'">'
									  +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>经销单位:</label></div></div>'
						              +'<div class="col-xs-4"><div class="form-contr"><p class="carShopId-item form-control">二手车</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>数量:</label></div></div>'
						              +'<div class="col-xs-2"><div class="form-contr"><p class="amount-item form-control">'+data.data['detailList'][i]['amount']+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>详细指令:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="detailMark-item form-control">'+data.data['detailList'][i]['mark']+'</p></div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>车辆信息:</label></div></div>'
						              +'<div class="col-xs-11"><div class="newCarDetail-item">'+carHtml+'</div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>配件信息:</label></div></div>'
						              +'<div class="col-xs-11"><div class="newPartDetail-item">'+carAttachmentHtml+'</div></div></div></div>';
							}
							
						}

					}else{
						detailListHtml='<div class="border-b-ff9a00 detailList" id="detailList'+i+'"><div class="row newrow"><div class="col-xs-12"><p class="form-control no-border t-c">没有详细信息！</p></div></div>';
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
					$('#driver_pre').html(data.data['driver']);
					$('#mobile_pre').html(data.data['mobile']);
					$('#prepayCash_pre').html(data.data['prepayCash']);
					$('#bankName_pre').html(data.data['bankName']);
					$('#bankAccount_pre').html(data.data['bankAccount']);
					$('#oilCardNo_pre').html(data.data['oilCardNo']);
					$('#oilAmount_pre').html(data.data['oilAmount']);
					$('#oilCardNo_pre').html(data.data['oilCardNo']);
					$('#applyTime_pre').html(jsonForDateFormat(data.data['applyTime']));
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
	//location.href="${ctx}/operationMng/transportCostMng/queryIndex/"+id;
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/transportCostMng/getDetail/"+id,
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var preIds=data.data['prepayApplyIds'];
				$('#carNumber_prt').html(data.data['carNumber']);
				$('#driver_prt').html(data.data['driver']);
				$('#scheduleBillNo_prt').html(data.data['scheduleBillNo']);
				$('#brandName_prt').html(data.data['costList'][0]['brandName']);
				$('#sendTime_prt').html(jsonForDateFormat(data.data['costList'][0]['sendTime']));
				$('#receiveTime_prt').html(jsonForDateFormat(data.data['costList'][0]['receiveTime']));
				$('#amount_prt').html(data.data['costList'][0]['count']);
				$('#startAddress_prt').html(data.data['costList'][0]['startAddress']);
				$('#endAddress_prt').html(data.data['costList'][0]['endAddress']);
				$('#applyTime_prt').html(jsonForDateFormat(data.data['applyTime']));
				/* $('#distance_prt').html(data.data['costList'][0]['distance']);
				$('#standardOilWear_prt').html(data.data['costList'][0]['standardOilWear']);
				$('#oilPrice_prt').html(data.data['costList'][0]['oilPrice']);
				$('#oilAmount_prt').html(data.data['oilAmount']); */
				var moneySum=0,extraMoneySum=0;
				if(data.data['prepayList']!=null && data.data['prepayList'].length>0 ){
					var applyTime=data.data['prepayList'][0]['applyTime'];
    				if(applyTime!='' && applyTime!=null){
        				applyTime=jsonForDateFormat(data.data['prepayList'][0]['applyTime']);
        			}else{
        				applyTime='';
        			}
    				 var prepayCash=data.data['prepayList'][0]['prepayCash'];
			  		 var oilAmount=data.data['prepayList'][0]['oilAmount'];
			  		 if(prepayCash=="null"){
						  prepayCash="";
					  }
					  if(oilAmount=="null"){
						  oilAmount="";
					  }
					$('#prePay_prt').attr('data-id',data.data['prepayList'][0]['id']);
					    $('#prePay_prt').html(applyTime);
			  		    $('#preAmount0_prt').html(prepayCash);
			  		    $('#preAmount1_prt').html(oilAmount);
				}else{
					$('#prePay_prt').attr('data-id','');
                	$('#prePay_prt').html('');
			  		    $('#preAmount0_prt').html('');
			  		    $('#preAmount1_prt').html('');
				}
				var ertra=[];
				if(data.data['costList'][0]['cashList'].length>0){
					for(var i=0;i<data.data['costList'][0]['cashList'].length;i++){
						var obj=data.data['costList'][0]['cashList'];
						if(obj[i]['type']=='0'){
							$('#amount0_prt').html(obj[i]['amount']);
							$('#name0_prt').html(obj[i]['name']);
						}else if(obj[i]['type']=='1'){
								$('#amount1_prt').html(obj[i]['amount']);
								$('#name1_prt').html(obj[i]['name']);
						}else if(obj[i]['type']=='2'){
							$('#amount2_prt').html(obj[i]['amount']);
							$('#name2_prt').html(obj[i]['name']);
					    }
						else if(obj[i]['type']=='3'){
							$('#amount3_prt').html(obj[i]['amount']);
							$('#name3_prt').html(obj[i]['name']);
					    }
						else if(obj[i]['type']=='4'){
							$('#amount4_prt').html(obj[i]['amount']);
							$('#name4_prt').html(obj[i]['name']);
					    }else if(obj[i]['type']=='5'){
					    	var ertraItem={};
					    	ertraItem.name=obj[i]['name'];
					    	ertraItem.amount=obj[i]['amount'];
					    	ertra.push(ertraItem);
					    }
					}
					if(ertra.length>0){
						for(var j=0;j<ertra.length;j++){
							if(j==0){
								$('#amount5_0_prt').html(ertra[0]['amount']);
								$('#name5_0_prt').html(ertra[0]['name']);
							}else{
								detailItem+='<div id="amountExtra'+j+'" class="extraList bor-b-ff9a00-1"><div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>项目:</label></div></div>'
								          +'<div class="col-xs-5"><div class="form-contr"><p class="form-control no-border" id="name5_'+j+'">'+ertra[j]['name']+'</p></div></div>'
								          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>金额:</label></div></div>'
								          +'<div class="col-xs-5"><div class="form-contr"><p class="form-control no-border" id="amount5_'+j+'">'+ertra[j]['amount']+'</p></div></div></div></div>'
							} 
						}
					}
				}
				if(data.data['oilAmount']!='' && data.data['oilAmount']!=null){
					$('#oilMoney_prt').html(data.data['oilAmount']);
				}
				if($('#amount0_prt').html()!=''){
					moneySum+=parseFloat($('#amount0_prt').html());
				}
				if($('#amount1_prt').html()!=''){
					moneySum+=parseFloat($('#amount1_prt').html());
				}
				/* if($('#amount2').html()!=''){
					moneySum+=parseFloat($('#amount2').html());
				} */
				if($('#amount3_prt').html()!=''){
					moneySum+=parseFloat($('#amount3_prt').html());
				}
				if($('#amount4_prt').html()!=''){
					moneySum+=parseFloat($('#amount4_prt').html());
				}
				
				
				$('#sumMoney_prt').html((moneySum+extraMoneySum).toFixed(2));/* 费用总计 */
				html=detailItem;
				$('#amountExtra0').after(html);
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
function revaildate(e,flag){
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
    var money = $(e).val();
    if(money!=null && money!=''){
    	if (!reg.test(money)) {
    		if(flag=='0'){//预付现金
    			$('#cashAdvance_audit').val('');
    		}else if(flag=='1'){//预付油费
    			$('#balanceCash_audit').val('');
    		}
    		bootbox.alert('请输入正确的金额！');
       }
    }
}
/**审核通过/不通过**/
function waybillaudit(successFlag){
	var audit_mesg=$("#audit_mesg").val();
	var taskId=$("#taskId-hidden").val();
	var filename=$("#filename_hidden").val();
	var filepath=$("#filepath_hidden").val();
	var businessType=$("#businessType-hidden").val();
	var newcarNumber=$("#newcarNumber_audit").val();
	var newdriver=$("#newdriver_audit").val();
	var newCarNumber=$("#newCarNumber_changeCar").html();
	var balanceCash=$("#balanceCash_audit").val();
	var balanceOil=$("#balanceOil_audit").val();
	var cashAdvance=$("#cashAdvance_audit").val();
	//console.info(cashAdvance);
	//console.info(taskId);
	if(audit_mesg==''){
		 bootbox.alert('审核意见不可为空！');
		 return;
	}
	if(newcarNumber!=''){
		audit_mesg+="[重新指派："+newcarNumber+"-"+newdriver+"]";
	}
	var mesg="";
	if(successFlag=='Y'){
		mesg="确定要审核通过吗?";
	}else{
		mesg="确定要审核不通过吗?";
	}
	$("#ybtn").attr("disabled","true");
	$("#nbtn").attr("disabled", "true");
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: mesg, 
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
							prepareMoney :$.trim(cashAdvance)
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								//console.log(JSON.stringify(data.data));	
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "审核成功！", 
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
							$("#ybtn").removeAttr("disabled"); 	
							$("#nbtn").removeAttr("disabled"); 
						}
					}); 
			  }else{
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
	var successFlag='Y';
	if(audit_mesg==''){
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
						}
					}); 
			  }else{
				  $("#cbtn").removeAttr("disabled"); 	
			  }
		  }
		})
}
</script>



</body>
</html>






