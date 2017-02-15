
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
	#modal-down{
    width: 400px;
    height: 300px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    } 
 </style>
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			油卡管理
			<small>
				<i class="icon-double-angle-right"></i>
				基础信息管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title mul-title" style="float: left;height: 34px;line-height: 34px;width: 80px;" >创建时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 150px;margin-right:20px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="insertStartTime" type="text" placeholder="请输入创建开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width:48px;margin-left: 20px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 150px;margin-right:20px;height: 34px;line-height: 34px;">
				<input class="form-control" id="insertEndTime" type="text" placeholder="请输入创建结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			<label class="title mul-title" >类型：</label>
		    <select id="oilType" class="form-box mul-form-box" style="width: 150px;">
		      <option value="">请选择类型</option>
		      <option value="0">公司购买</option>
		      <option value="1">供应商抵款</option>
		    </select>
		    <label class="title mul-title" style="width: 70px;">来&nbsp;&nbsp;&nbsp;源：</label>
		    <input id="oilSource" class="form-box" type="text" placeholder="请输入来源" style="width: 150px;margin-left: -5px;"/>		  
		</div>
		<div class="searchbox col-xs-12">
		    
		    <label class="title mul-title" style="float: left;width: 80px;">卡类型：</label>
		    <select id="oilCardType" class="form-box mul-form-box" style="float: left;width: 150px;margin-left: 2px;">
		      <option value="">请选择卡类型</option>
		      <option value="0">中石化</option>
		      <option value="1">中石油</option>
		    </select>
		    <label class="title mul-title" style="float: left;width: 73px;">卡&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</label>
		    <input id="oilCardNo" class="form-box mul-form-box" type="text" placeholder="请输入卡号" style="float: left;width: 150px;"/>
		    <label class="title mul-title" style="float: left;width: 70px;">状态：</label>
		    <select id="oilStatus" class="form-box mul-form-box" style="float: left;width: 150px;margin-left: 5px;">
		      <option value="">请选择状态</option>
		      <option value="0">新建</option>
		      <option value="1">未领用</option>
		      <option value="2">已领用</option>
		    </select>
		   <label class="title mul-title" style="float: left;width: 75px;margin-left: 2px;">领取人：</label>
		   <input id="receiveUser" class="form-box mul-form-box" type="text" placeholder="请输入领取人" style="float: left;width: 150px;"/>	 
		</div>
		<div class="searchbox col-xs-12">
		    
		    <label class="title mul-title" style="float: left;height: 34px;line-height: 34px;width: 80px;" >领取时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 150px;margin-right:20px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="receiveStartTime" type="text" placeholder="请输入领取开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width:48px;margin-left: 20px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 150px;margin-right:20px;height: 34px;line-height: 34px;">
				<input class="form-control" id="receiveEndTime" type="text" placeholder="请输入领取结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			
			<a class="itemBtn m-lr5" onclick="searchInfo()">查询</a>
			<a class="itemBtn m-lr5" onclick="doadd()">新增</a>
			<a class="itemBtn m-lr5" onclick="doprint()">打印</a>
			<a class="itemBtn m-lr5" onclick="doexport()">导出</a>
			<a class="itemBtn m-lr5" onclick="openinput()">导入</a>
			<a class="itemBtn m-lr5" onclick="showTemple()">模板下载</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>类型</th>
					<th>来源</th>
                    <th>卡类型</th>
                    <th>卡号</th>
					<th>状态</th>
					<th>创建人</th>
                    <th>创建时间</th>
                    <th>领取人</th>
                    <th>领取时间</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
		</div>
	</div>
	<!-- 新增油卡Modal--begin -->
	<div class="modal fade" id="modal-add" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="refresh();">×</button>
						<h3 id="myModalLabel">新增油卡</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>类型：</label>
								      <select id="insertType" class="form-control">
									      <option value="-1">请选择类型</option>
									      <option value="0">公司购买</option>
									      <option value="1">供应商抵款</option>
									    </select>
								     <input class="form-control" id="id-hidden" type="hidden"/>
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>来源：</label>
									     <input class="form-control" id="insertSource" type="text" placeholder="请输入来源"/>
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>卡类型：</label>
									     <select id="insertCardType" class="form-control">
									      <option value="-1">请选择卡类型</option>
									      <option value="0">中石化</option>
									      <option value="1">中石油</option>
									    </select>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>卡号：<span class="red" id="addValCard"></span></label>
									     <input class="form-control" id="insertCardNo" type="text"  onkeyup="cardNoConfirm(this,0)" onblur="cardNoConfirmBlur(this,0)" placeholder="请输入卡号"/>
									 </div>
								    <!-- <hr class="tree"></hr>
									<div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>金额：<span class="red" id="addValMoney"></span></label>
									     <input class="form-control" id="insertMoney" type="text"  onkeyup="vaildate(this,0);" onblur="revaildate(this,0);" placeholder="请输入金额"/>
									 </div> -->
								    <hr class="tree"></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="save();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="refresh();">取消</a>
									 </div>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
	
	<!-- 新增油卡Modal--end -->
	
	<!-- 编辑油卡Modal--begin -->
	<div class="modal fade" id="modal-edit" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="editRefresh();">×</button>
						<h3 id="myModalLabel">编辑油卡</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>类型：</label>
								      <select id="editType" class="form-control">
									      <option value="-1">请选择类型</option>
									      <option value="0">公司购买</option>
									      <option value="1">供应商抵款</option>
									    </select>
								     <input class="form-control" id="updateId-hidden" type="hidden"/>
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>来源：</label>
									     <input class="form-control" id="editSource" type="text" placeholder="请输入来源"/>
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>卡类型：</label>
									     <select id="editCardType" class="form-control">
									      <option value="-1">请选择卡类型</option>
									      <option value="0">中石化</option>
									      <option value="1">中石油</option>
									    </select>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>卡号：<span class="red" id="editValCard"></span></label>
									     <input class="form-control" id="editCardNo" type="text"  onkeyup="cardNoConfirm(this,1)" onblur="cardNoConfirmBlur(this,1)" placeholder="请输入卡号"/>
									 </div>
								    <!-- <hr class="tree"></hr>
									<div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>金额：<span class="red" id="editValMoney"></span></label>
									     <input class="form-control" id="editMoney" type="text"  onkeyup="vaildate(this,1);" onblur="revaildate(this,1);" placeholder="请输入金额"/>
									 </div> -->
								    <hr class="tree"></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="update();">更新</a>
									    <a class="add-itemBtn btnCancle" onclick="editRefresh();">取消</a>
									 </div>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
	
	<!-- 编辑油卡Modal--end -->
	
	<!-- 查看油卡Modal--begin -->
	<div class="modal fade" id="modal-show" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="showRefresh();">×</button>
						<h3 id="myModalLabel">查看油卡</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item show-item">
								     <label class="title">类型：</label>
								     <p id="showType"></p> 
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item show-item">
									     <label class="title">来源：</label>
									     <p id="showSource"></p> 
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item show-item">
									     <label class="title">卡类型：</label>
									     <p id="showCardType"></p> 
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item show-item">
									     <label class="title">卡号：</label>
									     <p id="showCardNo"></p> 
									 </div>
								    <hr class="tree"></hr>
									<div class="add-item show-item">
									     <label class="title">金额：</label>
									     <p id="showMoney"></p> 
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item show-item">
									     <label class="title">状态：</label>
									     <p id="showStatus"></p> 
									 </div>
									 <hr class="tree"></hr>
									  <div class="add-item show-item">
									     <label class="title">领取人：</label>
									     <p id="showReceiveUser"></p> 
									 </div>
									 <hr class="tree"></hr>
									<div class="add-item show-item">
									     <label class="title">领取时间：</label>
									     <p id="showReceiveTime"></p> 
									 </div>
									 <hr class="tree"></hr>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
	
	<!-- 查看油卡Modal--end -->
	
	<!-- 发放油卡Modal--begin -->

	<div class="modal fade" id="modal-grant" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content" style="height:300px;">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="grantRefresh();">×</button>
						<h3 id="myModalLabel">发放油卡</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item grant-item" style="position:relative;">
								     <label class="title"><span class="red">*</span>领取人：</label>
								      <!-- <select id="grantDriver" class="form-control">
									    </select>  -->
									 <input class="form-control" id="grantDriver" type="text" onkeyup="searchSchedule(this)"/>
									 <input class="form-control" id="grantDriver-hidden" type="hidden"/>
								     <input class="form-control" id="grantId-hidden" type="hidden"/>
								     <div id="selectItem8" class="selectItemhidden" style="height: 150px;">
										<div id="selectItemCount" class="selectItemcont">
											<div id="selectCarNo" style="height: 150px;">
											
											</div>
										</div>
									</div>
								    </div>
							  		<hr class="tree" ></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="grant();">发放</a>
									    <a class="add-itemBtn btnCancle" onclick="grantRefresh();">取消</a>
									 </div>
								</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
		
		
	<!-- 发放油卡Modal--end -->
	
	<!-- 回收油卡Modal--begin -->
	<div class="modal fade" id="modal-recover" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="recoverRefresh();">×</button>
						<h3 id="myModalLabel">回收油卡</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item grant-item">
								     <label class="title" style="width:86px;"><span class="red">*</span>回收金额：</label>
								     <input type="text" id="recoverMoney" class="form-control" placeholder="请输入回收金额" onkeyup="vaildate(this,2);" onblur="revaildate(this,2);""/>
								     <input class="form-control" id="recoverId-hidden" type="hidden"/>
								     <input class="form-control" id="recoverMoney-hidden" type="hidden"/>
								    </div>
								    <p class="red" id="recoverValMoney"></p>
							  		<hr class="tree"></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="recover();">回收</a>
									    <a class="add-itemBtn btnCancle" onclick="recoverRefresh();">取消</a>
									 </div>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
	
	<!-- 回收油卡Modal--end -->
	
	<!-- 充值油卡Modal--begin -->
	<div class="modal fade" id="modal-charge" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="chargeRefresh();">×</button>
						<h3 id="myModalLabel">充值油卡</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item grant-item">
								     <label class="title" style="width:86px;"><span class="red">*</span>充值金额：</label>
								     <input type="text" id="chargeMoney" class="form-control" placeholder="请输入充值金额" onkeyup="vaildate(this,3);" onblur="revaildate(this,3);"" />
								     <input class="form-control" id="chargeId-hidden" type="hidden"/>
								    </div>
								    <p class="red" id="chargeValMoney"></p>
							  		<hr class="tree"></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="charge();">充值</a>
									    <a class="add-itemBtn btnCancle" onclick="chargeRefresh();">取消</a>
									 </div>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
	<!-- 充值油卡Modal--end -->
		 <!-- 基础数据导入  modal begin-->
		 <div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static" style="height: 300px;">
				<div class="modal-dialog" style="padding:0px">
				     <div class="modal-header" >
				        <button class="close" type="button" onclick="cancelinput();">×</button>
						<h3 id="myModalLabel">基础信息导入</h3>
				    </div>
					<div class="modal-body" >
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								    <div class="add-item extra-itemSec">
								      <label class="title">选择文件：</label>
								      <div class="form-control" style="border:0;height:auto;">
								         <input type="file" id="file" /> 
                                         <label class="title" id="filename"></label>
                                         <input type="hidden" name="filename_hidden" id="filename_hidden" />
                                         <input type="hidden" name="filepath_hidden" id="filepath_hidden" /><br />
								      </div>
								      
                                    </div>
                                     <hr class="tree"></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="doinput();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="cancelinput();">取消</a>
									 </div>
									</div>
						  </div>
					  </div>
					</div>
				</div>
			</div>
		 <!-- 基础数据导入  modal end-->
		 	 <!-- 基础信息模板下载   modal begin -->
			<div class="modal fade" id="modal-down" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header" style="padding-top: 5px;">
					<button class="close" type="button" data-dismiss="modal" style="padding-top: 5px;">×</button>
					<h3 id="myModalLabel">模板下载</h3>
				</div>
				<div class="modal-body" style="height: 200px;">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-itemSec">
							     		<a class="table-upload" href="${ctx}/staticPublic/resources/oilcard_template/油卡基础信息模板.xls"><font size="6">油卡基础信息模板下载</font></a>
							 		 </div>
								</div>
						  </div>
					</div>
				 </div>
				</div>
			
			</div>
		 <!-- 基础信息模板下载  modal end -->
</div>

<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>油卡信息记录表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>
		        <th>序号</th>
				<th>类型</th>
				<th>来源</th>
		        <th>卡类型</th>
		        <th>卡号</th>
				<th>状态</th>
				<th>创建人</th>
                <th>创建时间</th>
		        <th>领取人</th>
		        <th>领取时间</th>
		      </tr>
		    </thead>
		    <tbody>
		    </tbody>
		  </table>
		  <div id="footerInfo"><h3>盐城辉宇物流有限公司  制</h3></div>
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
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="${ctx}/staticPublic/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
function searchSchedule(e){
	var $val=$(e).val();
	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/oilCardMng/getReceiveUser",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		data: JSON.stringify({
			name : $val
		}),
		success : function(data) {
			if (data && data.code == 200) {
				var html = "";
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<p id='+data.data[i]['id']+' onclick=\'clickp(this)\'>【'+data.data[i]['departmentName']+'】'+data.data[i]['name']+'</p>';
	            		}
	        		}
	        	}
	        	$('#selectCarNo').html(html);
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
	var A_top = $(e).offset().top + $(e).outerHeight(true); //  1
	var A_left = $(e).offset().left;
	$('#selectItem8').show().css({
		"position" : "absolute",
		"top" : "33px",
		"left" : "75px"
	});
	if( null == $val || '' == $val)
	{
		$('#grantDriver-hidden').val('');
	}
}
function clickp(e){
	$('#grantDriver').val($(e).html());
	$('#grantDriver-hidden').val($(e).attr("id"));
	$('#selectItem8').hide();
};
$(document).click(function(event) {
   $('#selectItem8').hide();
});
function init(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/oilCardMng/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum",'width':'5%'},
		    {data: "type",'width':'7%'},
		    {data: "source",'width':'10%'},
		    {data: "cardType",'width':'8%'},
		    {data: "cardNo",'width':'15%'},
		    {data: "status",'width':'5%'},
		    {data: "insertUserName",'width':'6%'},
		    {data: "insertTime",'width':'10%'},
		    {data: "receiveUserName",'width':'6%'},
		    {data: "receiveTime",'width':'10%'},
		    {data: null,'width':'18%'}
			],
		    columnDefs: [
				{
					 //类型
					 targets:3,
					 render: function (data, type, row, meta) {
				         if(data=='0'){
				       	 return '中石化'; 
				         }else {
				       	  return '中石油';
				         }
				     }	       
				},
				{
					 //卡类型
					 targets:1,
					 render: function (data, type, row, meta) {
				         if(data=='0'){
				       	 return '公司购买'; 
				         }else {
				       	  return '供应商抵款';
				         }
				     }	       
				},
				{
					 //状态
					 targets:5,
					 render: function (data, type, row, meta) {
				          if(data=='0'){
				        	 return '新建'; 
				          }else if(data=='1'){
				        	  return '未领用';
				          }else{
				        	  return '已领用';
				          }
				      }	       
				},
				{
					 //日期
					 targets:7,
					 render: function (data, type, row, meta) {
						 if(data==null || data==''|| parseInt(data)<0){
							return ''; 
						 }else{
							 return jsonDateFormat(data);
						 }
				           
				       }	       
				},
				{
					 //日期
					 targets:9,
					 render: function (data, type, row, meta) {
						 if(data==null || data=='' || parseInt(data)<0){
							return ''; 
						 }else{
							 return jsonDateFormat(data);
						 }
				           
				       }	       
				},
				{
					 //操作
					 targets: 10,
					 render: function (data, type, row, meta) {
						 if(row.status=='0'){
							 return '<a class="table-edit" onclick="dosumbit('+ row.id +')">提交</a>'
						        +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
				                +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
						 }else if(row.status=='1'){
							 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>'
						        +'<a class="table-edit" onclick="dogrant('+ row.id +')">发放</a>'
						        /* +'<a class="table-edit" onclick="docharge('+ row.id +')">充值</a>'; */
						 }
						 else{
							 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>'
						        +'<a class="table-edit" onclick="dorecover('+ row.id +','+row.money+')">回收</a>';
						        /* +'<a class="table-edit" onclick="docharge('+ row.id +')">充值</a>'; */
						 }
						 
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
		 "sAjaxSource": "${ctx}/operationMng/oilCardMng/getListData" , //获取数据的ajax方法的URL	
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
			 columns: [{ data: "rownum",'width':'5%'},
					    {data: "type",'width':'7%'},
					    {data: "source",'width':'10%'},
					    {data: "cardType",'width':'8%'},
					    {data: "cardNo",'width':'15%'},
					    {data: "status",'width':'5%'},
					    {data: "insertUserName",'width':'6%'},
					    {data: "insertTime",'width':'10%'},
					    {data: "receiveUserName",'width':'6%'},
					    {data: "receiveTime",'width':'10%'},
					    {data: null,'width':'18%'}
						],
			columnDefs: [
							{
								 //类型
								 targets:3,
								 render: function (data, type, row, meta) {
							         if(data=='0'){
							       	 return '中石化'; 
							         }else {
							       	  return '中石油';
							         }
							     }	       
							},
							{
								 //卡类型
								 targets:1,
								 render: function (data, type, row, meta) {
							         if(data=='0'){
							       	 return '公司购买'; 
							         }else {
							       	  return '供应商抵款';
							         }
							     }	       
							},
							{
								 //状态
								 targets:5,
								 render: function (data, type, row, meta) {
							          if(data=='0'){
							        	 return '新建'; 
							          }else if(data=='1'){
							        	  return '未领用';
							          }else{
							        	  return '已领用';
							          }
							      }	       
							},
							{
								 //日期
								 targets:7,
								 render: function (data, type, row, meta) {
									 if(data==null || data==''|| parseInt(data)<0){
										return ''; 
									 }else{
										 return jsonDateFormat(data);
									 }
							           
							       }	       
							},
							{
								 //日期
								 targets:9,
								 render: function (data, type, row, meta) {
									 if(data==null || data==''|| parseInt(data)<0){
										return ''; 
									 }else{
										 return jsonDateFormat(data);
									 }
							           
							       }	       
							},
							{
								 //操作
								 targets: 10,
								 render: function (data, type, row, meta) {
									 if(row.status=='0'){
										 return '<a class="table-edit" onclick="dosumbit('+ row.id +')">提交</a>'
									        +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
							                +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
									 }else if(row.status=='1'){
										 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>'
									        +'<a class="table-edit" onclick="dogrant('+ row.id +')">发放</a>'
									        /* +'<a class="table-edit" onclick="docharge('+ row.id +')">充值</a>'; */
									 }
									 else{
										 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>'
									        +'<a class="table-edit" onclick="dorecover('+ row.id +','+row.money+')">回收</a>';
									        /* +'<a class="table-edit" onclick="docharge('+ row.id +')">充值</a>'; */
									 }
									 
							       }	           
							}
					      ],
				        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

$(function(){
	$("#insertStartTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#insertEndTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#receiveStartTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#receiveEndTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	init();
	upload();
	//getdriver();
})

/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   $('#secho').val(secho);
	   var type=$('#oilType').val();
	   var source=$('#oilSource').val();
	   var cardType=$('#oilCardType').val();
	   var cardNo=$('#oilCardNo').val();
	   var status=$('#oilStatus').val();
	   var startTime=$('#insertStartTime').val();
	   var endTime=$('#insertEndTime').val();
	   var receiveUser = $('#receiveUser').val();
	   var receiveStartTime = $('#receiveStartTime').val();
	   var receiveEndTime = $('#receiveEndTime').val();
	   if(type=='' || type==null || type=='-1'){
		   type="";
	   }
	   if(cardType=='' || cardType==null || cardType=='-1'){
		   cardType="";
	   }
	   if(status=='' || status==null || status=='-1'){
		   status="";
	   }
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				type : type,
				source : source,
				cardType : cardType,
				cardNo : cardNo,
				status : status,
				startTime : startTime,
				endTime : endTime,
				receiveUserName : receiveUser,
				receiveStartTime : receiveStartTime,
				receiveEndTime : receiveEndTime
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

/* 金额验证 */
function vaildate(e,flag){
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
    var money = $(e).val();
    if(money!=null && money!=''){
    	if (!reg.test(money)) {
    		if(flag=='0'){//新增
    			$('#addValMoney').html('(*请输入正确的金额！)');
    		}else if(flag=='1'){//编辑
    			$('#editValMoney').html('(*请输入正确的金额！)');
    		}else if(flag=='2'){//回收
    			$('#recoverValMoney').html('(*请输入正确的金额！)');
    		}else if(flag=='3'){//充值
    			$('#chargeValMoney').html('(*请输入正确的金额！)');
    		}
    		
       }else{
    	 if(flag=='0'){//新增
   			$('#addValMoney').html('');
   		}else if(flag=='1'){//编辑
   			$('#editValMoney').html('');
   		}else if(flag=='2'){//回收
   			$('#recoverValMoney').html('');
   		}else if(flag=='3'){//充值
   			$('#chargeValMoney').html('');
   		}
       }
    }
    
}

function revaildate(e,flag){
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
    var money = $(e).val();
    if(money!=null && money!=''){
    	if (!reg.test(money)) {
    		if(flag=='0'){//新增
    			$('#addValMoney').html('(*请输入正确的金额！)');
    			$('#insertMoney').val('');
    		}else if(flag=='1'){//编辑
    			$('#editValMoney').html('(*请输入正确的金额！)');
    			$('#editMoney').val('');
    		}else if(flag=='2'){//回收
    			$('#recoverValMoney').html('(*请输入正确的金额！)');
    			$('#recoverMoney').val('');
    		}else if(flag=='3'){//充值
    			$('#chargeValMoney').html('(*请输入正确的金额！)');
    			$('#chargeMoney').val('');
    		}
    		
       }else{
    	 if(flag=='0'){//新增
   			$('#addValMoney').html('');
   		}else if(flag=='1'){//编辑
   			$('#editValMoney').html('');
   		}else if(flag=='2'){//回收
   			$('#recoverValMoney').html('');
   		}else if(flag=='3'){//充值
   			$('#chargeValMoney').html('');
   		}
       }
    }
}
/* 卡号验证 */
function cardNoConfirm(e,flag){
	var reg = /[^\d]/g;
    var cardNo = $(e).val();
    if(cardNo!=null && cardNo!=''){
    	if (reg.test(cardNo)) {
    		if(flag=='0'){//新增
    			$('#addValCard').html('(*请输入正确的卡号！)');
    		}else if(flag=='1'){//编辑
    			$('#editValCard').html('(*请输入正确的卡号！)');
    		}
    		
       }else{
    	 if(flag=='0'){//新增
   			$('#addValCard').html('');
   		}else if(flag=='1'){//编辑
   			$('#editValCard').html('');
   		}
       }
    }

}

function cardNoConfirmBlur(e,flag){
	var reg = /[^\d]/g;
    var cardNo = $(e).val();
    if(cardNo!=null && cardNo!=''){
    	if (reg.test(cardNo)) {
    		if(flag=='0'){//新增
    			$('#addValCard').html('(*请输入正确的卡号！)');
    			$('#insertCardNo').val('');
    		}else if(flag=='1'){//编辑
    			$('#editValCard').html('(*请输入正确的卡号！)');
    			$('#editCardNo').val('');
    		}
    		
       }else{
    	 if(flag=='0'){//新增
   			$('#addValCard').html('');
   		}else if(flag=='1'){//编辑
   			$('#editValCard').html('');
   		}
       }
    }

}

/* 新增油卡 */
function doadd(){
	refresh();
	$('#modal-add').modal('show');
}

/* 新增保存 */
function save(){
	var flag="false";
	   var type=$('#insertType').val();
	   var source=$('#insertSource').val();
	   var cardType=$('#insertCardType').val();
	   var cardNo=$('#insertCardNo').val();
	   //var money=$('#insertMoney').val();
	   if(type=='' || type==null || type=='-1'){
		   bootbox.alert('类型不能为空！');
		   return;
	   }
	   if(source=='' || source==null){
		   bootbox.alert('来源不能为空！');
		   return;
	   }
	   if(cardType=='' || cardType==null || cardType=='-1'){
		   bootbox.alert('卡类型不能为空！');
		   return;
	   }
	   if(cardNo=='' || cardNo==null){
		   bootbox.alert('卡号不能为空！');
		   return;
	   }
	   /* if(money=='' || money==null){
		   bootbox.alert('金额不能为空！');
		   return;
	   } */
	   bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该油卡信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : "${ctx}/operationMng/oilCardMng/save",
							data : JSON.stringify({
								type : type,
								source : source,
								cardType : cardType,
								cardNo : cardNo
							}),
							contentType : "application/json;charset=UTF-8",
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {
									 bootbox.confirm_alert({ 
										  size: "small",
										  message: "新增成功！", 
										  callback: function(result){
											  if(result){
												  flag="true";
												  $('#modal-add').modal('hide');
													reload();
											  }else{
												  $('#modal-add').modal('hide');
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
/* 新增取消 */
function refresh(){
	$('#insertType').val('-1');
	$('#insertSource').val('');
	$('#insertCardType').val('-1');
	$('#insertCardNo').val('');
	//$('#insertMoney').val('');
	$('#modal-add').modal('hide');
}

/* 删除油卡信息 */

function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该油卡信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/oilCardMng/delete/"+id,
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								 bootbox.confirm_alert({ 
									  size: "small",
									  message: "删除成功！", 
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

/* 提交油卡信息 */

function dosumbit(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该油卡信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/oilCardMng/submit/"+id,
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "提交成功！", 
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

/* 编辑油卡 --获取油卡信息*/
function getOilInfo(id){
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/oilCardMng/getDetail/"+id,
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#editType').val(data.data.type);
				$('#editSource').val(data.data.source);
				$('#editCardType').val(data.data.cardType);
				$('#editCardNo').val(data.data.cardNo);
				//$('#editMoney').val(data.data.money);
			} else {
				 bootbox.alert(data.msg);
			}
			
		}
	}); 
}

/* 查看油卡 --获取油卡信息*/
function getOilForShow(id){
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/oilCardMng/getDetail/"+id,
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var type="";
				var cardType="";
				var status="";
				var receiveUser="";
				var receiveTime="";
				if(data.data.type=='0'){
					type="公司购买";
				}else if(data.data.type=='1'){
					type="供应商抵款";
				}else{
					type='';
				}
				if(data.data.cardType=='0'){
					cardType="中石化";
				}else if(data.data.cardType=='1'){
					cardType="中石油";
				}else{
					cardType='';
				}
				if(data.data.status=='0'){
					status="新建";
				}else if(data.data.status=='1'){
					status="未领用";
				}else if(data.data.status=='2'){
					status="已领用";
				}else{
					status='';
				}
				if(data.data.receiveUserName ==''||data.data.receiveUserName==null){
					receiveUser="暂无领取人"
				}else{
					receiveUser=data.data.receiveUserName;
				}
				if(data.data.receiveTime==''||data.data.receiveTime==null || parseInt(data.data.receiveTime)<0){
					receiveTime="暂无领取时间"
				}else{
					receiveTime=jsonForDateFormat(data.data.receiveTime);
				}
				$('#showType').html(type);
				$('#showSource').html(data.data.source);
				$('#showCardType').html(cardType);
				$('#showCardNo').html(data.data.cardNo);
				$('#showMoney').html(data.data.money);
				$('#showStatus').html(status);
				$('#showReceiveUser').html(receiveUser);
				$('#showReceiveTime').html(receiveTime);
			} else {
				 bootbox.alert(data.msg);
			}
			
		}
	}); 
}

/* 加载编辑信息 */
function doedit(id){
	getOilInfo(id);
	$('#modal-edit').modal('show');
	$('#updateId-hidden').val(id);
}

/* 编辑取消 */
function editRefresh(){
	$('#modal-edit').modal('hide');
	
}

function update(){
	var flag="false";
	   var id=parseInt($('#updateId-hidden').val());
	   var type=$('#editType').val();
	   var source=$('#editSource').val();
	   var cardType=$('#editCardType').val();
	   var cardNo=$('#editCardNo').val();
	   //var money=$('#editMoney').val();
	   if(id=='' || id==null){
		   bootbox.alert('数据获取失败，请刷新再试或者联系管理员！');
		   return;
	   }
	   if(type=='' || type==null || type=='-1'){
		   bootbox.alert('类型不能为空！');
		   return;
	   }
	   if(source=='' || source==null){
		   bootbox.alert('来源不能为空！');
		   return;
	   }
	   if(cardType=='' || cardType==null || cardType=='-1'){
		   bootbox.alert('卡类型不能为空！');
		   return;
	   }
	   if(cardNo=='' || cardNo==null){
		   bootbox.alert('卡号不能为空！');
		   return;
	   }
	   /* if(money=='' || money==null){
		   bootbox.alert('金额不能为空！');
		   return;
	   } */
	   bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该油卡信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : "${ctx}/operationMng/oilCardMng/update",
							data : JSON.stringify({
								id :id,
								type : type,
								source : source,
								cardType : cardType,
								cardNo : cardNo
							}),
							contentType : "application/json;charset=UTF-8",
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {
									bootbox.confirm_alert({ 
										  size: "small",
										  message: "保存成功！", 
										  callback: function(result){
											  if(result){
												  flag="true";
												  $('#modal-edit').modal('hide');
													reload();
											  }else{
												  $('#modal-edit').modal('hide');
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

/* 查看油卡信息 */

function doshow(id){
	getOilForShow(id);
	$('#modal-show').modal('show');
}

/* 关闭取消窗口 */
function showRefresh(){
	$('#modal-show').modal('hide');
}

/* 获取驾驶员信息 */

function getdriver(){
	 $.ajax({  
	        url: '${ctx}/operationMng/oilCardMng/getReceiveUser',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="-1">请选择驾驶员</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	                		}
	            		}
	            	}
	            	$('#grantDriver').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
}
/* 发放油卡 */

function dogrant(id){
	$('#modal-grant').modal('show');
	$('#grantId-hidden').val(id);
}

/* 关闭发放窗口 */
function grantRefresh(){
	$('#modal-grant').modal('hide');
}
/* 发放油卡 */
function grant(){
	var flag="false";
	var id=parseInt($('#grantId-hidden').val());
	var receiveUser=$('#grantDriver-hidden').val();
	if(receiveUser==null || receiveUser==''){
		bootbox.alert('请先填写领取人！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要发放油卡?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/operationMng/oilCardMng/grant",
						data : JSON.stringify({
							id : id,
							receiveUser : receiveUser
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "发放成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  $('#modal-grant').modal('hide');
												reload();
										  }else{
											  $('#modal-grant').modal('hide');
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

/* 回收油卡 */

function dorecover(id,money){
	$('#recoverMoney').val('');
	$('#modal-recover').modal('show');
	$('#recoverId-hidden').val(id);
	$('#recoverMoney-hidden').val(money);
	$('#recoverMoney').val(money);
}

/* 关闭回收窗口 */
function recoverRefresh(){
	$('#modal-recover').modal('hide');
}

/* 回收油卡 */
function recover(){
	var flag="false";
	var id=parseInt($('#recoverId-hidden').val());
	var money=$('#recoverMoney').val();
	var maxMoney=$('#recoverMoney-hidden').val();
	if(money==null || money=='' ){
		bootbox.alert('请先填写金额！');
		return;
	}else if(parseInt(money)>parseInt(maxMoney)){
		bootbox.alert('回收金额不能超过最大金额！');
		return;
	}
	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要回收油卡?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/operationMng/oilCardMng/recover",
						data : JSON.stringify({
							id : id,
							money : money
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "回收成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  $('#modal-recover').modal('hide');
												reload();
										  }else{
											  $('#modal-recover').modal('hide');
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

/* 充值油卡 */

function docharge(id){
	$('#chargeMoney').val('');
	$('#modal-charge').modal('show');
	$('#chargeId-hidden').val(id);
}

/* 关闭充值窗口 */
function chargeRefresh(){
	$('#modal-charge').modal('hide');
}

/* 充值油卡 */
function charge(){
	var flag="false";
	var id=parseInt($('#chargeId-hidden').val());
	var money=$('#chargeMoney').val();
	if(money==null || money=='' ){
		bootbox.alert('请先填写金额！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要充值?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/operationMng/oilCardMng/recharge",
						data : JSON.stringify({
							id : id,
							money : money
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "充值成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  $('#modal-charge').modal('hide');
												reload();
										  }else{
											  $('#modal-charge').modal('hide');
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

/* 导出 */
function doexport()
{
	   var type=$('#oilType').val();
	   var source=$('#oilSource').val();
	   var cardType=$('#oilCardType').val();
	   var cardNo=$('#oilCardNo').val();
	   var status=$('#oilStatus').val();
	   var startTime=$('#insertStartTime').val();
	   var endTime=$('#insertEndTime').val();
	   var receiveUser = $('#receiveUser').val();
	   var receiveStartTime = $('#receiveStartTime').val();
	   var receiveEndTime = $('#receiveEndTime').val();
	   if(type=='' || type==null || type=='-1'){
		   type="";
	   }
	   if(cardType=='' || cardType==null || cardType=='-1'){
		   cardType="";
	   }
	   if(status=='' || status==null || status=='-1'){
		   status="";
	   }
	   var form = $('<form action="${ctx}/operationMng/oilCardMng/export" method="post"></form>');
	   var typeInput = $('<input id="type" name="type" value="'+type+'" type="hidden" />');
	   var sourceInput = $('<input id="source" name="source" value="'+source+'" type="hidden" />');
	   var cardTypeInput = $('<input id="cardType" name="cardType" value="'+cardType+'" type="hidden" />');
	   var cardNoInput = $('<input id="cardNo" name="cardNo" value="'+cardNo+'" type="hidden"  />');
	   var statusInput = $('<input id="status" name="status" value="'+status+'" type="hidden"  />');
	   var startTimeInput = $('<input id="startTime" name="startTime" value="'+startTime+'" type="hidden" />');
	   var endTimeInput = $('<input id="endTime" name="endTime" value="'+endTime+'" type="hidden" />');
	   var receiveUserInput = $('<input id="receiveUserName" name="receiveUserName" value="'+receiveUser+'" type="hidden" />');
	   var receiveStartTimeInput = $('<input id="receiveStartTime" name="receiveStartTime" value="'+receiveStartTime+'" type="hidden" />');
	   var receiveEndTimeInput = $('<input id="receiveEndTime" name="receiveEndTime" value="'+receiveEndTime+'" type="hidden" />');
	   form.append(typeInput);
	   form.append(sourceInput);
	   form.append(cardTypeInput);
	   form.append(cardNoInput);
	   form.append(statusInput);
	   form.append(startTimeInput);
	   form.append(endTimeInput);
	   form.append(receiveUserInput);
	   form.append(receiveStartTimeInput);
	   form.append(receiveEndTimeInput);
	   $('body').append(form);
	   form.submit();
}

/* 打印功能 */
function doprint(){
	   var date = new Date();
       var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
       var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
       var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
       var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
       var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
       var localTime= date.getFullYear() + "-" + month + "-" + day+ " " + hours + ":" + minutes + ":" + seconds;
	   var html="";
	   var type=$('#oilType').val();
	   var source=$('#oilSource').val();
	   var cardType=$('#oilCardType').val();
	   var cardNo=$('#oilCardNo').val();
	   var status=$('#oilStatus').val();
	   var startTime=$('#insertStartTime').val();
	   var endTime=$('#insertEndTime').val();
	   var receiveUser = $('#receiveUser').val();
	   var receiveStartTime = $('#receiveStartTime').val();
	   var receiveEndTime = $('#receiveEndTime').val();
	   if(type=='' || type==null || type=='-1'){
		   type=null;
	   }
	   if(cardType=='' || cardType==null || cardType=='-1'){
		   cardType=null;
	   }
	   if(status=='' || status==null || status=='-1'){
		   status=null;
	   }
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/operationMng/oilCardMng/getPrintData",
			data : JSON.stringify({
				type : type,
				source : source,
				cardType : cardType,
				cardNo : cardNo,
				status : status,
				startTime : startTime,
				endTime : endTime,
				receiveUserName : receiveUser,
				receiveStartTime : receiveStartTime,
				receiveEndTime : receiveEndTime
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {					
					if(data.data.length>0){
						for(var i=0;i<data.data.length;i++){
							data.data[i]["rownum"]=i+1;
							if(data.data[i]["type"]=='0'){
								data.data[i]["type"]='公司购买';
							}else{
								data.data[i]["type"]='供应商抵款';
							}
							if(data.data[i]["cardType"]=='0'){
								data.data[i]["cardType"]='中石化';
							}else{
								data.data[i]["cardType"]='中石油';
							}
							if(data.data[i]["status"]=='0'){
								data.data[i]["status"]='新建';
							}else if(data.data[i]["status"]=='1'){
								data.data[i]["status"]='未领用';
							}else{
								data.data[i]["status"]='已领用';
							}
							if(data.data[i]["insertUserName"]=='' || data.data[i]["insertUserName"]==null){
								data.data[i]["insertUserName"]='';
							}
							if(data.data[i]["insertTime"]=='' || data.data[i]["insertTime"]==null){
								data.data[i]["insertTime"]='';
							}
							else
							{
								data.data[i]["insertTime"]=jsonDateFormat(data.data[i]["insertTime"]);
							}
							if(data.data[i]["receiveTime"]==null || data.data[i]["receiveTime"]=='' || parseInt(data.data[i]["receiveTime"])<0){
								data.data[i]["receiveTime"]=''; 
							 }else{
								 data.data[i]["receiveTime"]=jsonDateFormat(data.data[i]["receiveTime"]);
							 }
							if(data.data[i]["receiveUser"]=='' || data.data[i]["receiveUser"]==null){
								data.data[i]["receiveUser"]='';
							}
								html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
							    +'<td>'+data.data[i]["type"]+'</td>'
							    +'<td>'+data.data[i]["source"]+'</td>'
							    +'<td>'+data.data[i]["cardType"]+'</td>'
							    +'<td>'+data.data[i]["cardNo"]+'</td>'
							    +'<td>'+data.data[i]["status"]+'</td>'
							    +'<td>'+data.data[i]["insertUserName"]+'</td>'
							    +'<td>'+data.data[i]["insertTime"]+'</td>'
							    +'<td>'+data.data[i]["receiveUser"]+'</td>'
							    +'<td>'+data.data[i]["receiveTime"]+'</td></tr>';	
						      
						}
						$('#localTime').html(localTime);
						$('#myDataTable tbody').html(html);
					      doprintForm();
					}else{
						bootbox.alert('暂无可打印的数据！');
						return;
					}
					 
				} else {
					 bootbox.alert(data.msg);
				}
				
			}
		}); 
	  
	   
}

function doprintForm(){
		var html=$("#printTable").html();
		$('#breadcrumbs').hide();
		$('.page-content').hide();
		$('#printTable').show();
		$("#myDataTable").printTable({
		 header: "#headerInfo",
         footer: "#footerInfo",
		 mode: "rowNumber",
		 pageSize: 23
	});
		javasricpt:window.print();
		$('#breadcrumbs').show();
		$('.page-content').show();
		$('#printTable').hide();
		$("#printTable").html(html);
	 }

/* 数据导上传*/
function upload(){
	$("#file").uploadify({
		//按钮额外自己添加点的样式类.upload
        'buttonClass':'upload',
        //限制文件上传大小
        'fileSizeLimit':'200MB',
        //文件选择框显示
        'fileTypeDesc':'选择',
        //文件类型过滤
         'fileTypeExts':'*.xls;*.xlsx',
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
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#filename').html(html);
        	$('#filename_hidden').val(orginFileName);
        	$('#filepath_hidden').val(attachFilePath);
        }
 });
}

//打开导入界面
function openinput()
{
	$('#modal-info').modal('show');
}
//关闭导入界面
function cancelinput()
{
	$('#modal-info').modal('hide');
}
//导入
function doinput()
{
	var flag="false";
	if($('#filepath_hidden').val()==''||$('#filepath_hidden').val()=='null'||$('#filepath_hidden').val()==null){
		$('#filepath_hidden').val()='';
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存基础模板信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/operationMng/oilCardMng/input",
						data : JSON.stringify({
							filePath : $('#filepath_hidden').val()
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "导入成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  $('#modal-info').modal('hide');
												reload();
										  }else{
											  $('#modal-info').modal('hide');
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
//下载
function showTemple()
{
	$('#myModalLabel').html('油卡基础信息模板下载');	
	$('#modal-down').modal('show');	
}
</script>

</body>
</html>






