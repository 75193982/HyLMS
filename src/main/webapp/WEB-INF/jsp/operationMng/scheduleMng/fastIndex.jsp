 
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
	    <link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
		<!-- page specific plugin styles -->
		<!-- ace styles -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" />
		<!-- inline styles related to this page -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/staticPublic/themes/default/easyui.css"></link>
		<link rel="stylesheet" type="text/css" href="${ctx}/staticPublic/themes/icon.css"></link>
		<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
	</head>
	<!-- onkeydown="keyCheck(event);keyCheckByCode(event)" -->
<body class="white-bg">
	<div class="page-content">
		<div class="page-header">
			<h1>
				运营管理
				<small>
					<i class="icon-double-angle-right"></i>
					快速调度
				</small>
			</h1>
		</div><!-- /.page-header -->
	  <div class="detailInfo p5">
	     <div class="rowInfo" style="position:relative;">
		        <label class="title"><span class="red">*</span>调度单号:</label>
		          <input class="form-control" id="wayBillInfo" type="text"  placeholder="请输入调度单号" data-id="" onkeyup="searchSchedule(this)"/>
		          <a class="itemBtn" id="openSchedule" onclick="openInfo()">打开</a>
				  <a class="itemBtn" id="saveSchedule" >保存</a>
				  <a class="itemBtn" id="updateSchedule" onclick="changeApply()">申请修改</a>
				  <a class="itemBtn" id="clearSchedule" onclick="clearInfo()">清空</a>	
				  <a class="itemBtn" id="printSchedule" onclick="printInfo()">打印</a>
				   <a class="itemBtn" id="dd" onclick="listToJson()">点击</a>
		        <div class="clear"></div>
		   </div>
		   <div class="rowInfo" style="position:relative;">
		         <label class="title"><span class="red">*</span>装运日期:</label>
		         <div class="input-group input-group-sm" style="float: left;width: 100px;margin-right:5px;">
				    <input class="form-control" id="shipDate" type="text" placeholder="请输入装运日期" style="margin-right:0px;width:147px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			    </div>
		        <label class="title"><span class="red">*</span>装运车号:</label>
		        <input class="form-control" id="shipCarNo" style="width:130px;padding:6px 3px;" onkeyup="getStockList(this)" data-no="" placeholder="请输入装运车号"/>
		        <label class="title"><span class="red">*</span>驾驶员:</label>
		        <input class="form-control" id="shipDriver" type="text" placeholder="请输入驾驶员" style="width:100px;"/>
		        <label class="title"><span class="red">*</span>联系电话:</label>
		        <input class="form-control" id="shipMobile" type="text" placeholder="请输入联系电话" style="width:120px;"/>
			    <div class="clear"></div>
		   </div>
		   <div class="table-itemTit">调度明细</div>
		   <!-- 调度明细Grid------begin-->
	      <table class="easyui-datagrid" style="width:100%;height:auto;min-height:300px;" id="mytable"
			data-options="toolbar:toolbar,singleSelect:true">
			<thead>
				<tr>
					<th data-options="field:'type',width:80,align:'center',formatter:formatType,editor:{type:'combobox',
								options:{
									valueField:'type',
									textField:'typeName',
									data: [{ type:'', typeName:'' },{ type: '0', typeName:'商品车' },{ type:'1', typeName:'配件' },{ type:'2', typeName:'二手车' }],
									required:true}}">类型</th>
					<th data-options="field:'waybillNo',width:200,align:'center',editor:'text'">运单编号</th>
					<th data-options="field:'supplierId',width:100,align:'center',
					 formatter:fmSupplier,
					editor:{
						type:'combobox',
						options:{
							data : loadSupplier(),
							valueField:'supplierId',
							textField:'supplierName',
							panelHeight: 150,
							editable:false
							}}">供应商</th>
					<th data-options="field:'sendTime',width:100,align:'center',editor:{type:'datebox'}">托运日期</th>
					<th data-options="field:'arrivalTime',width:100,align:'center',editor:{type:'datebox'}">交车日期</th>
					<th data-options="field:'brandName',width:200,align:'center',editor:'text'">品牌-车型</th>
					<th data-options="field:'count',width:80,align:'center',editor:{type:'numberbox'},formatter:setnumcolor">数量</th>
					<th data-options="field:'startProvince',width:120,align:'center',
					editor:{
						type:'combobox',
						options:{
							data : provinces,
							valueField:'value',
							textField:'text',
							panelHeight: 150,
							editable:false,
							onSelect:chooseProvince
							}}">始发省</th>
					<th data-options="field:'startAddress',width:100,align:'center',
					editor:'text'">始发地</th>
					<th data-options="field:'carShopName',width:200,align:'center',editor:'text'">收车单位</th>
					<th data-options="field:'money',width:80,align:'center',editor:{type:'numberbox'},formatter:setnumcolor">金额</th>
					<th data-options="field:'mark',width:100,align:'center',editor:'text'">备注</th>
					<th data-options="field:'id',width:100,formatter:formatOper">操作</th>
					<th data-options="field:'carShopId',width:100,hidden:'true'"></th>
					<th data-options="field:'vinList',width:100,hidden:'true'"></th>
				</tr>
			</thead>
			<tbody id="tbody">
				<tr>
					<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				</tr>
				<tr>
					<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				</tr>
				<tr>
					<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				</tr>
				<tr>
					<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				</tr>
				<tr>
					<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				</tr>
				<tr>
					<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				</tr>
				<tr>
					<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				</tr>
				<tr>
					<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				</tr>
				<tr>
					<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				</tr>
				<tr>
					<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				</tr>
			  </tbody>
	    </table>
	    <table class="tableSum" cellspacing="0" cellpadding="0" border="0">
	       <tbody>
	          <tr class="datagrid-row"><td style="text-indent: 32px;width:780px;">合计</td><td id="td2" style="text-align:center;width:80px;"><span id="numRed">0</span></td><td id="td2"></td></tr>
	       </tbody>
	      </table> 
	     <!-- 调度明细Grid------end-->
	     <!-- 预付信息------begin-->
	     <div class="table-itemTit">预付信息</div>
	     <div class="rowInfo">
		        <label class="title2">预付日期:</label>
		        <div class="input-group input-group-sm" style="float: left;width: 180px;margin-right:15px;">
				    <input class="form-control" id="preDate" type="text" placeholder="请输入预付日期" style="margin-right:0px;width:147px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			    </div>
		        <label class="title2">开户行:</label>
		        <input class="form-control" id="prebank" type="text" placeholder="请输入开户行" />
		        <label class="title2">账号:</label>
		        <input class="form-control" id="preAmount" type="text" placeholder="请输入账号" />
		        <div class="clear"></div>
		   </div>
		   <div class="rowInfo">
		        <label class="title2">预付油卡号:</label>
		        <input class="form-control" id="preOil" type="text" placeholder="请输入预付油卡号" />
		        <label class="title2">预付油费:</label>
		        <input class="form-control" id="preOilMoney" type="text" placeholder="请输入预付油费" />
		        <label class="title2">预付现金:</label>
		        <input class="form-control" id="preMoney" type="text" placeholder="请输入预付现金" />
			    <div class="clear"></div>
		   </div>
	     <!-- 预付信息------end-->
	    <!-- 子类  品牌begin-->
		    <div id="selectItem2" class="selectItemhidden" >
				<div  class="selectItemcont">
					<div class="selectSub">
						<div id="brandLeft">
						  <table width="100%" height="100%" id="table2" class="divtab">
							<tbody id="table2_tbody">
								
							</tbody>
						  </table>
						</div>
						<div id="brandRight">
						  <table width="100%" height="100%" id="table3" class="divtab">
							<tbody id="table3_tbody">
								
							</tbody>
						  </table>
						</div>
					</div>
				</div>
		 </div>
		 <!-- 子类 品牌 end-->
		 <!-- 子类  配件begin-->
		    <div id="selectItem5" class="selectItemhidden" >
				<div  class="selectItemcont">
					<div class="selectSub">
						  <table width="100%" height="100%" id="table5" class="divtab">
							<tbody id="table5_tbody">
								
							</tbody>
						  </table>
					</div>
				</div>
		 </div>
		 <!-- 子类 品牌 end-->
		 <!-- 子类  配件begin-->
		    <div id="selectItem4" class="selectItemhidden" >
				<div  class="selectItemcont">
					<div class="selectSub">
						<table width="100%" height="100%" id="table4" class="divtab">
							<tbody id="table4_tbody">
								
							</tbody>
						</table>
					</div>
				</div>
		 </div>
		 <!-- 子类 收车单位 end-->
		 <!-- 新增车架号弹窗 begin -->
		 <div class="modal fade modal-reset" id="modal-add" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog dia-widget-box" style="padding:0;width:100%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="refreshVin();">×</button>
						<h3 id="myModalLabel">登记车架号信息</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <div class="vinDetailList">
								     <table id="vinList" class="table table-striped table-bordered table-hover">
								       <thead> 
								         <tr>
								            <th>序号</th>
								            <th>车架号</th>
								         </tr>
								       </thead>
								       <tbody>
								       </tbody>
								     </table>
								   </div>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="saveVin();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="refreshVin();">取消</a>
									 </div> 
									</div>
						       </div>
					     </div>
					  </div>
				   </div>
				 </div>
			 </div>
		 <!-- 新增车架号弹窗 end -->
		 <!-- 新增收车单位 begin -->
		  <div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">新增经销单位信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>经销单位名称：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							      <input class="form-control " id="name" type="text" placeholder="请输入经销单位名称"/>
							     </div>							      
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>省份：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <select id="province" class="form-control">
			                        <option value="">请选择省份</option>
			                        <option value="北京市">北京市</option>
	                                <option value="浙江省">浙江省</option>
	                                <option value="天津市">天津市</option>
	                                <option value="安徽省">安徽省</option>
	                                <option value="上海市">上海市</option>
	                                <option value="福建省">福建省</option>
	                                <option value="重庆市">重庆市</option>
	                                <option value="江西省">江西省</option>
	                                <option value="山东省">山东省</option>
	                                <option value="河南省">河南省</option>
	                                <option value="湖北省">湖北省</option>
	                                <option value="湖南省">湖南省</option>
	                                <option value="广东省">广东省</option>
	                                <option value="海南省">海南省</option>
	                                <option value="山西省">山西省</option>
	                                <option value="青海省">青海省</option>
	                                <option value="江苏省">江苏省</option>
	                                <option value="辽宁省">辽宁省</option>
	                                <option value="吉林省">吉林省</option>
	                                <option value="台湾省">台湾省</option>
	                                <option value="河北省">河北省</option>
	                                <option value="贵州省">贵州省</option>
	                                <option value="四川省">四川省</option>
	                                <option value="云南省">云南省</option>
	                                <option value="陕西省">陕西省</option>
	                                <option value="甘肃省">甘肃省</option>
	                                <option value="黑龙江省">黑龙江省</option>
	                                <option value="香港特别行政区">香港特别行政区</option>
	                                <option value="澳门特别行政区">澳门特别行政区</option>
	                                <option value="广西壮族自治区">广西壮族自治区</option>
	                                <option value="宁夏回族自治区">宁夏回族自治区</option>
	                                <option value="新疆维吾尔自治区">新疆维吾尔自治区</option>
	                                <option value="内蒙古自治区">内蒙古自治区</option>
	                                <option value="西藏自治区">西藏自治区</option>
				                   </select>
							     </div>
							   
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>城市：</label>
							      <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="city" type="text" placeholder="请输入城市"/>
							     <p style="margin-bottom:0px;"><span class="red">*输入城市时，格式必须为XX市（如盐城市）</span></p>
							     </div>
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>地址：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="address" type="text" placeholder="请输入地址"/>
							     	</div>					   					    
							  </div>	
							   <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>联系人：</label>
							      <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="linkUser" type="text" placeholder="请输入联系人"/>
							     </div>
							    </div>			
							  <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>联系电话：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="linkTelephone" type="text" placeholder="请输入联系电话"/>
							     </div>
							  </div>
							   <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4">经销单位编码：</label>
							      <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="orgCode" type="text" placeholder="请输入经销单位编码"/>
							     </div>
							 </div>
							 <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">生日：</label>
							    <div class="input-group input-group-sm col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
									<input class="form-control" id="brithday" type="text" placeholder="请输入生日"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>	
							    </div>		
							     <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">手机号码：</label>
							      <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="linkMobile" type="text" placeholder="请输入手机号码"/>
							     </div>
							  </div>
							  					  			  				  
							    <hr class="tree"></hr>
							    <div class="add-item-btn" id="addBtn" style="display:block">
								    <a class="add-itemBtn btnOk" onclick="save();">保存</a>
								    <a class="add-itemBtn btnCancle" onclick="refresh();">取消</a>
								 </div>
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
			<!-- 新增收车单位 End -->
			<!-- 新增品牌  begin-->
			<div class="modal fade" id="modal-einfo" tabindex="-1" role="dialog" data-backdrop="static" style="height:420px;">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel" style="margin: 0;">新增品牌信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>品牌名称：</label>
							     <input class="form-control" id="brandName_new" type="text" placeholder="请输入品牌名称"/>
							     <input class="form-control" id="id-hidden" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>车型：</label>
							     <input class="form-control" id="carType_new" type="text" placeholder="请输入车型,以‘|’隔开"/>
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">备注：</label>
							     <textarea class="form-control" rows="3" id="mark_new" name="mark_new" placeholder="请填写备注" ></textarea> 
							  </div>							  
							    <hr class="tree" style="margin-top: 60px;"></hr>
							    <div class="add-item-btn" id="addBtn" style="display:block;">
								    <a class="add-itemBtn btnOk" onclick="brandsave();">保存</a>
								    <a class="add-itemBtn btnCancle" onclick="brandrefresh();">取消</a>
								 </div>
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
			
			<!-- 新增品牌 end -->
			<!-- 提交修改申请  begin-->
			<div class="modal fade modal-reset" id="modal-edit" tabindex="-1" role="dialog" data-backdrop="static" style="width:600px;height:300px;">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">修改申请</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								    <div class="add-item col-xs-12">
									     <label class="title col-xs-4"><span class="red">*</span>调度单号：</label>
									     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
									        <p class="form-control no-border" id="applyScheduleNo" ></p>
									     </div>							      
									  </div>
									  <hr class="tree"></hr>
									<div class="add-item col-xs-12">
									     <label class="title col-xs-4"><span class="red">*</span>申请原因：</label>
									     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
									        <textarea rows="4" cols="4" class="form-control" id="applyReason" placeholder="请输入申请原因"></textarea>
									     </div>							      
									  </div>
									  <hr class="tree"></hr>
								    <div class="add-item-btn" id="addBtn" style="display:block">
									    <a class="add-itemBtn btnOk" onclick="saveApply();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="editRefresh();">取消</a>
									 </div>
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
			<!-- 提交修改申请  end-->
			
			
	  </div>
	  <!-- 打印模板   begin-->
			<div class="printTable" id="printTable">
			     <div id="print-content" class="printcenter">
						<div id="headerInfo">
							<h2>快速调度记录单</h2>
							<p id="localTime" style="text-align: right;"></p>
						   <div class="rowInfoP">
					           <label class="title"><span class="red">*</span>调度单号:</label>
					           <p class="form-control no-border" id="pscheduleNo"></p>
					           <label class="title"><span class="red">*</span>装运日期:</label>
					           <p class="form-control no-border" id="pshipDate"></p>
				         </div>
				         <div class="rowInfoP">
					           <label class="title"><span class="red">*</span>装运车号:</label>
					           <p class="form-control no-border" id="pshipCarNo"></p>
					           <label class="title"><span class="red">*</span>驾驶员:</label>
					           <p class="form-control no-border" id="pshipDriver"></p>
					           <label class="title"><span class="red">*</span>联系电话:</label>
					           <p class="form-control no-border" id="pshipMobile"></p>
				         </div>
						</div>
						  <table id="myDataTable" class="table myDataTable">
						    <thead>
						      <tr>
						            <th>类型</th>
									<th>运单编号</th>
									<th>交车日期</th>
				                    <th>品牌-车型</th>
				                    <th>数量</th>                   
				                    <th>托运日期</th>
				                    <th>始发地</th>
									<th>收车单位</th>					
									<th>备注</th>
						      </tr>
						    </thead>
						    <tbody>
						    </tbody>
						  </table>
						  
					  <div id="footerInfo">
					    <div class="rowInfoP">
					           <label class="title"><span class="red">*</span>预付日期:</label>
					           <p class="form-control no-border" id="ppreDate"></p>
					           <label class="title"><span class="red">*</span>开户行:</label>
					           <p class="form-control no-border" id="pprebank"></p>
					           <label class="title"><span class="red">*</span>账号:</label>
					           <p class="form-control no-border" id="ppreAmount"></p>
					           <div class="clear"></div>
				         </div>
					     <div class="rowInfoP">
					           <label class="title"><span class="red">*</span>预付油卡号:</label>
					           <p class="form-control no-border" id="ppreOil"></p>
					           <label class="title"><span class="red">*</span>预付油费:</label>
					           <p class="form-control no-border" id="ppreOilMoney"></p>
					           <label class="title"><span class="red">*</span>预付现金:</label>
					           <p class="form-control no-border" id="ppreMoney"></p>
					           <div class="clear"></div>
				         </div>
					     <h3>盐城辉宇物流有限公司  制</h3>
					  </div>
				  </div>
			</div>

			<!-- 打印模板   end-->
			<!-- 调度单模糊匹配 -->	
				<div id="selectItem8" class="selectItemhidden">
					<div class="selectItemcont">
						<div id="selectSchedule">
							
						</div>
					</div>
				</div>
				<!-- 调度单模糊匹配 -->	
				<div id="selectItem9" class="selectItemhidden">
					<div class="selectItemcont">
						<div id="selectCarNo">
							
						</div>
					</div>
				</div>
  </div>
<script src="${ctx}/staticPublic/js/jquery-2.0.3.min.js"></script>
<script src="${ctx}/staticPublic/js/easyUI/jquery.min.js"></script>
<script src="${ctx}/staticPublic/js/easyUI/jquery.easyui.min.js"></script>
<script src="${ctx}/staticPublic/js/easyUI/easyui-lang-zh_CN.js"></script> 
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script> 
<script src="${ctx}/staticPublic/js/easyUI/keyCheckByCode.js"></script>
<script src="${ctx}/staticPublic/js/easyUI/rownumber-util.js"></script> 
<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
<script src="${ctx}/staticPublic/js/bootbox.min.js"></script>
<script src="${ctx}/staticPublic/js/jsonDataFormat.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="${ctx}/staticPublic/js/easyUI/setnumcolor.js"></script>
<script src="${ctx}/staticPublic/js/provincecity.js"></script>
<script type="text/javascript">

var comboboxSupplierData = "";
//加载表格供应商下拉数据
function loadSupplier()
{
	$.ajax({  
        url: "${ctx}/operationMng/scheduleMng/getBasicSuppliersList",  
        type: 'get',  
        async: false,//此处必须是同步  
        dataTye: 'json',  
        success: function (data) {  
        	comboboxSupplierData = data;  
        }  
    })  
    return comboboxSupplierData;  
}
//格式化供应商显示
function fmSupplier(value, row) {  
    for (var i = 0; i < comboboxSupplierData.length; i++) {  
        if (comboboxSupplierData[i].supplierId == value) {  
            return comboboxSupplierData[i].supplierName;  
        }  
    }  
    return row.supplierId;  
}  

	//下拉格式化
	function supplierFormatter(value,row)
	{
		//console.info(JSON.stringify(row))
		//return row.supplierName; 
		  $.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/scheduleMng/getBasicSuppliersList",
			data :JSON.stringify({}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data) {
					console.info(JSON.stringify(data));
					/* if(data.length > 0)
					{
						for(var i = 0;i<data.length;i++)
						{
							if(data[i].id == value)
							{
								console.info(data[i].name);
								return data[i].name;
							}
						}
					} */
				}
			}
		}); 
		
     }
   /* 全局grid  begin*/
	
		  var toolbar = [{
		        text:'插行',
		        iconCls:'icon-add',
		        handler:function(){
		        	insertrow('mytable');
		          }
		        },
		        {
			        text:'删行',
			        iconCls:'icon-cut',
			        handler:function(){
			        	cutrow('mytable');
			          }
			    },
		        {
			        text:'新增收车单位',
			        iconCls:'icon-add',
			        handler:function(){
			        	addnewShop();
			        }
		    },{
		        text:'新增品牌',
		        iconCls:'icon-add',
		        handler:function(){
		        	addnewBrand();
		        }
	    }]; 
		  
		    var ai = "";
			var fieldName = "";//点击的列field
			var maincurRow = "";//主页面表格行索引
			//var selectRow = "";//选择行
			var saveclick  = 0;
			var rowNo= 0;
			var clickIndex = [];//单击行的索引数组
			var selectedData = [];//选中的数据集合
			var carType ='';
			$.extend($.fn.datagrid.methods, {
				editCell: function(jq,param){
					return jq.each(function(){
						var opts = $(this).datagrid('options');
						var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
						for(var i=0; i<fields.length; i++){
							var col = $(this).datagrid('getColumnOption', fields[i]);//每列的field 
							col.editor1 = col.editor;//每列的editor
							if (fields[i] != param.field){
								col.editor = null;
							}
						}
						$(this).datagrid('beginEdit', param.index);
		                var ed = $(this).datagrid('getEditor', param);
		                /* console.info(ed);
                        if (ed != null) {
                            var supplierName = $(ed.target).combobox('getText');
                            console.info('supplierName : '+supplierName);
                            $('#mytable').datagrid('getRows')[opts.editIndex]['supplierName'] = supplierName;
                        } */
		                if (ed){
		                    if ($(ed.target).hasClass('textbox-f')){
		                    	$(ed.target).textbox('textbox').focus();//获得焦点
		                        $(ed.target).next("span").children().first().one('blur', function (e) {
		                        	var eds = $('#mytable').datagrid('getRows');
		                        	
				                      
		                        });
		                        /* 数量 */
		                        if(param.field == "count"){
			                    	   $(ed.target).textbox('textbox').on('blur',function(){
			                    		   var rowSelected = $('#mytable').datagrid('getSelected');
			                    		   var row = $('#mytable').datagrid('getRows');
			                    		   var count = 0;
			                    		   var countSum=0;
			                    		   var thiscount=0;
			                    		   for (var i = 0; i < row.length; i++){
			       					          if(row[i]['count']!=''){
			       					        	count+=parseInt(row[i]['count']);
			       					          }
			       					       }
			                    		   if($(this).val().trim()!=''){
			                    			   countSum=parseInt($(this).val().trim());
			                    		   }
			                    		   if(rowSelected.count!=''){
			                    			   thiscount=parseInt(rowSelected.count);
			                    		   }
			                    		   $('#numRed').html(count+countSum-thiscount);
			                    	   });
			                     }
		                    	 
		                    }else{
		                       $(ed.target).focus();
		                       /* 品牌 */
		                       if(param.field == "brandName"){
		                    	   $(ed.target).bind('keyup', function (event) {
		                    		   var _tr2="";
		                    		   if(event.keyCode == 38 || event.keyCode == 40 )
		                   				{
		                   					$(this).blur();
		                   					event.stopPropagation();//通过使用 stopPropagation() 方法只阻止一个事件起泡。 
		                   					return false;//通过返回false来取消默认的行为并阻止事件起泡
		                   				}
		                    		   var pageHeight = document.body.clientHeight;//页面可见高度
		                        	   var A_top = $(this).offset().top + $(this).outerHeight(true); //  1
		                       		   var A_left = $(this).offset().left;
		                        	   var val = $(this).val().trim();
		                        	   $("#table2 tr").remove();
		                        	   $("#table3 tr").remove();
		                        	   rowNo= 0;
		                        	   clickIndex.splice(0,clickIndex.length);//每次键盘输入清空点击的数组
		                        	    var row = $('#mytable').datagrid('getSelected');
			                   			if (row){
			                   				if(row.type=="0" || row.type=='2'){
			                   					if(val != "" && val != null){
					                        		   var param =val;
					                        		   $.ajax({
					                        			    type : "post",
					                   						url : "${ctx}/operationMng/scheduleMng/getCarBrandList",
					                   						contentType : "application/json;charset=UTF-8",
					                   						data : JSON.stringify({
					                   							brandName:param
					                   						}),
					                   						dataType : "json",
					                   						success: function(data){
					                   							if(data.data != null && data.data.length != 0)
					                   							{
					                   								for(var i = 0;i< data.data.length;i++)
					                   	 							{
					                   	 							  _tr2+= '<tr width=100% ><td data-carType="'+data.data[i]["carType"]+'">'+data.data[i]["brandName"]+'</td></tr>';
					                   	 							    
					                   	 							}
					                   								$("#table2 tbody").html(_tr2);
					                   								$("#table3 tbody").html('<tr width=100%><td>请先选择品牌</td></tr>');
					                   								$("#selectItem2").show().css({
					        	                   						"position" : "absolute",
					        	                   						"top" : A_top + "px",
					        	                   						"left" : A_left + "px"
					        	                   						});
					                      								var itemHeight = document.getElementById("selectItem2").clientHeight;
					                      								var cha = parseInt(pageHeight-itemHeight-A_top);
					                      								if(cha <= 0)
					                      								{
					                      									$("#selectItem2").show().css({
					                      									"top" : parseInt(A_top-itemHeight-24) + "px",
					                      									});
					                      								}
					                      								//单击行
					                      								$("#table2 tr").click(function() {
					                      									var _tr3="";
					                      									var arr=[];
					                      									$(this).addClass("on").siblings("tr").removeClass("on");
					                      									var brandName = $(this).find("td").html();
					                      									carType=$(this).find("td").attr('data-carType');
					                      									if(carType!='' && carType!=null){
					             		                        			   arr=carType.split('|');
					             			                        		   for(var m=0;m<arr.length;m++){
					             			                        			   _tr3+="<tr width='100%' onclick='carStyleType(this,\""+brandName+"\")'><td>"+arr[m]+"</td></tr>";
					             			                        		   }
					             		                        		   }
					                      									$("#table3 tbody").html(_tr3); 
					                  	  									
					                      								});

					                   							}
					                   						}
					                        		   });	
					                        		  
				              							
					                        	   }
					                        	   else
					                        	   {
					                        		   $("#selectItem2").hide();
					                        	   }
			                   				}else{
			                   					if(val != "" && val != null){
					                        		   var param =val;
					                        		   var arrExtra=['工具','三角架','说明书','脚垫','灭火器','其它']
					                        		   for(var i = 0;i<arrExtra.length;i++)
		                   	 							{
		                   	 							  _tr2+= '<tr width=100% ><td>'+arrExtra[i]+'</td></tr>';
		                   	 							    
		                   	 							}
		                   								$("#table5 tbody").html(_tr2);
		                   								$("#selectItem5").show().css({
		        	                   						"position" : "absolute",
		        	                   						"top" : A_top + "px",
		        	                   						"left" : A_left + "px"
		        	                   						});
		                      								var itemHeight = document.getElementById("selectItem5").clientHeight;
		                      								var cha = parseInt(pageHeight-itemHeight-A_top);
		                      								if(cha <= 0)
		                      								{
		                      									$("#selectItem5").show().css({
		                      									"top" : parseInt(A_top-itemHeight-24) + "px",
		                      									});
		                      								}
		                      								$("#table5 tr").click(function() {
		                      									rowNo = $(this).index()+1;//当前单击行的索引+1
		                      									clickIndex.push($(this).index()+1);
		                      									$(this).addClass("on").siblings("tr").removeClass("on");
		                  	  									var brandName = $(this).find("td").html();
			                  	  								$('#mytable').datagrid('updateRow',{
	                              	    							index: maincurRow,
	                              	    							row: {
	                              	    								brandName: brandName
	                              	    								}
	                              	    							});
			                  	  							   /* getrow('mytable'); */// 序号重新排序 
			              									   $("#selectItem5").hide();
		                      								});	
					                        		  
				              							
					                        	   }
					                        	   else
					                        	   {
					                        		   $("#selectItem5").hide();
					                        	   }
			                   				}
			                   			}
		                        	   
		                           });
		                    	   
		                    	   
		                       }

		                       /* 收车单位 */
		                       if(param.field == "carShopName"){
		                    	   $(ed.target).bind('keyup', function (event) {
		                    		   var _tr4="";
		                    		   if(event.keyCode == 38 || event.keyCode == 40 )
		                   				{
		                   					$(this).blur();
		                   					event.stopPropagation();//通过使用 stopPropagation() 方法只阻止一个事件起泡。 
		                   					return false;//通过返回false来取消默认的行为并阻止事件起泡
		                   				}
		                    		   var pageHeight = document.body.clientHeight;//页面可见高度
		                        	   var A_top = $(this).offset().top + $(this).outerHeight(true); //  1
		                       		   var A_left = $(this).offset().left;
		                        	   var val = $(this).val().trim();
		                        	   $("#table4  tr:not(:first)").remove();
		                        	   rowNo= 0;
		                        	   clickIndex.splice(0,clickIndex.length);//每次键盘输入清空点击的数组
		                        	   if(val != "" && val != null)
		                        	   {
		                        		   var param =val;
		                        		   $.ajax({
		                        			    type : "post",
		                   						url : "${ctx}/operationMng/scheduleMng/getCarShopList",
		                   						contentType : "application/json;charset=UTF-8",
		                   						data : JSON.stringify({
		                   							name:param
		                   						}),
		                   						dataType : "json",
		                   						success: function(data){
		                   							if(data.data != null && data.data.length != 0)
		                   							{
		                   								for(var i = 0;i< data.data.length;i++)
		                   	 							{
		                   	 							  _tr4+= '<tr width=100%><td data-id="'+data.data[i]['id']+'">'+data.data[i]["name"]+'</td></tr>';
		                   	 							    
		                   	 							}
		                   								$("#table4 tbody").html(_tr4);
		                   								$("#selectItem4").show().css({
		        	                   						"position" : "absolute",
		        	                   						"top" : A_top + "px",
		        	                   						"left" : A_left + "px"
		        	                   						});
		                      								var itemHeight = document.getElementById("selectItem4").clientHeight;
		                      								var cha = parseInt(pageHeight-itemHeight-A_top);
		                      								if(cha <= 0)
		                      								{
		                      									$("#selectItem4").show().css({
		                      									"top" : parseInt(A_top-itemHeight-24) + "px",
		                      									});
		                      								}
		                      								//单击行
		                      								$("#table4 tr").click(function() {
		                      									rowNo = $(this).index()+1;//当前单击行的索引+1
		                      									clickIndex.push($(this).index()+1);
		                      									$(this).addClass("on").siblings("tr").removeClass("on");
		                  	  									var carShopName = $(this).find("td").html();
		                  	  									var carShopId= $(this).find("td").attr('data-id');
		                  	  									var id=$(this).find("td").attr('data-id');
			                  	  								$('#mytable').datagrid('updateRow',{
	                              	    							index: maincurRow,
	                              	    							row: {
	                              	    								carShopName: carShopName,
	                              	    								carShopId: carShopId
	                              	    								}
	                              	    							});
			                  	  							   /* getrow('mytable'); */// 序号重新排序 
			              									   $("#selectItem4").hide();
		                      								});
		                   							}
		                   						}
		                        		   });	
		                        		  
	              							
		                        	   }
		                        	   else
		                        	   {
		                        		   $("#selectItem4").hide();
		                        	   }
		                           });
		                    	   
		                    	   
		                       }
		                     
		                       
		                       
		                    }
		                    
		                }
						for(var i=0; i<fields.length; i++){
							var col = $(this).datagrid('getColumnOption', fields[i]);
							col.editor = col.editor1;
						}
					});
				},
		        enableCellEditing: function(jq){
		            return jq.each(function(){
		                var dg = $(this);
		                var opts = dg.datagrid('options');
		                opts.oldOnClickCell = opts.onClickCell;
		                opts.onClickCell = function(index, field){
		                	fieldName = field;
		                	maincurRow = index;//点击加入当前行索引
		                    if (opts.editIndex != undefined){//editIndex为编辑的索引值,这里仅为引用
		                        if (dg.datagrid('validateRow', opts.editIndex)){
		                        	//ww 2017.2.13
		                        	var ed = $('#mytable').datagrid('getEditor', { index: opts.editIndex, field: 'supplierId' });  //editIndex编辑时记录下的行号
		                            dg.datagrid('endEdit', opts.editIndex);
		                            opts.editIndex = undefined;
		                        } else {
		                            return;
		                        }
		                    }
		                    dg.datagrid('selectRow', index).datagrid('editCell', {
		                        index: index,
		                        field: field
		                    });
		                    
		                    opts.editIndex = index;
		                    opts.oldOnClickCell.call(this, index, field);
		                }
		                
		                $(document).click(function(event) {
		        			if (event.target.getAttribute("field") != "type") 
		        			{
		        				rowNo = 0;
		        				$("#selectItem").hide();
		        			}
		        			if (event.target.getAttribute("field") != "brandName") 
		        			{
		        				rowNo = 0;
		        				$("#selectItem2").hide();
		        				$("#selectItem5").hide();
		        			}
		        			
		        				if(event.target.getAttribute('class') != "" && event.target.getAttribute('class') != null)
		            			{
		        					//console.info("aa"+event.target.getAttribute('class'));
		            				if(event.target.getAttribute('class').indexOf('datagrid-cell') == -1)//是否点击表格cell 不包含
		            				{
		            					dg.datagrid('endEdit', opts.editIndex);
		            				}
		            			}
		            			else
		            			{
		            				//console.info("bb"+$(event.target).text());
		            				if($(event.target).text().trim() != "")
		                			{
		            					dg.datagrid('endEdit', opts.editIndex);
		                			}
		            			}
		        			
		        			
		        		});
		                $("#selectItem").click(function(e) {
		        			e.stopPropagation(); //  阻止冒泡
		        		});
		                $("#selectItem2").click(function(e) {
		        			e.stopPropagation(); //  阻止冒泡
		        		});
		                $("#selectItem3").click(function(e) {
		        			e.stopPropagation(); //  阻止冒泡
		        		});
		                $("#selectItem4").click(function(e) {
		        			e.stopPropagation(); //  阻止冒泡
		        		});
		                
		                
		            });
		            
		        }
				,keyCtr : function (jq) {
					return jq.each(function () { 
						var grid = $(this); 
						grid.datagrid('getPanel').panel('panel').attr('tabindex', 1).bind('keydown', function (event) { 
						switch (event.keyCode) { 
						case 9: 
							
						break;
						case 13:
							//alert("13");
							//keyTab();
							break;
						}
						});
					});
				}
			});
			
			//数量校验不为0
			$.extend($.fn.validatebox.defaults.rules, {
				notLing: {
					validator: function(value, param){
						return value != param[0];
					},
					message: '不能为 {0}.'
			    },
			    checkDate:{
			    	validator: function (value) {  
			            var reg = /^([1-9]\d\d\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;   // /^\d{4}-\d{1,2}-\d{1,2}$/;  
			            return reg.test(value);  
			        },  
			        message: '输入日期格式不准确,请按yyyy-MM-dd格式输入。'  
			    }
			});
			
			
			function keyCheck(evt){
				evt = (evt) ? evt : ((window.event) ? window.event : ""); //兼容IE和Firefox获得keyBoardEvent对象
				var key = evt.keyCode?evt.keyCode:evt.which;//兼容IE和Firefox获得keyBoardEvent对象的键值
				var d=document.getElementById("selectItem");
				var sumLength = document.getElementById("table1").rows.length;
			  	//enter事件
				if(key== 13)
				{
					evt.returnValue = false;//阻止事件的默认行为
					if($("#selectItem").is(':hidden'))//true 隐藏
					{
						keyTab();
					}
					else
					{
						var flag = false;
						var rowindex = 0;
						var inumber = "";//有数据的行数
						var rows = $("#mytable").datagrid('getRows');//tb.rows;
						for (var i = 0; i < rows.length; i++) 
						{
					       var textval = rows[i]['waybillNo']+"";
					       if(textval.trim() != "undefined" && textval.trim() != "" && textval.trim() != null)//判断当前页面的物品这列是否有数据
						 	{
						 		rowindex = i+1;
						 	}
					    }
						for(var j = 0;j<clickIndex.length;j++)
						{
							if(rowNo == clickIndex[j])
							{
								flag = true;
							}
						}
						if(flag == false)
						{
							var type = $("#table1 tr:eq("+rowNo+")").find("td").html().trim();
							if(type != null && type != "")
							{
								selectedData.push({Type:type});
							}
							var brandName = $("#table2 tr:eq("+rowNo+")").find("td").html().trim();
							if(brandName != null && brandName != "")
							{
								selectedData2.push({BrandName:brandName});
							}
						}
						/* getrow('mytable'); */// 序号重新排序   2016.6.8
				    	rowNo = 0;
				    	clickIndex.splice(0,clickIndex.length);
				    	keyTab();
					}
			 		
				}
				//esc事件
				if(key== 27)
				{
					rowNo = 0;
					selectedData.splice(0,selectedData.length);//清空
					clickIndex.splice(0,clickIndex.length);
					$("#selectItem").hide();
				}
				//Tab键盘
				if(key== 9)
				{
					keyTab();
				}
			};
			
			function keyTab()
			{
				var array = ['type','waybillNo','brandName','carStyle','count','sendTime','arrivalTime','carShopId','startAddress','mark'];
				for(var i = 0;i<array.length;i++)
				{
					if(fieldName == array[i])
					{
						ai = i+1;
					}
				}
				if(ai%(array.length) == 0)
				 {
					 maincurRow +=1;
				 }
				var dg = $('#mytable');
		        var opts = dg.datagrid('options');
				opts.onClickCell(maincurRow, array[ai%(array.length)]);
				opts.onClickCell(maincurRow, array[ai%(array.length)]);//再点击一次，获得焦点
				if(array[ai%(array.length)].trim() == "waybillNo")//输入框在itemName时,模糊查询药品名称,按enter后(即按下enter 后为amount时，再点击一次，获得焦点 ).
				{
					opts.onClickCell(maincurRow, array[ai%(array.length)]);
				}	
			}
			
		/* 全局 grid end */
	    var outA = document.getElementById("saveSchedule");
outA.addEventListener('click',saveQuick,true);

	$(function(){
		var scheduleBillNo="${scheduleBillNo}";
		$("#shipDate").datepicker({
			language: 'cn',
	        autoclose: true,//选中之后自动隐藏日期选择框
	        format: "yyyy-mm-dd"//日期格式
		});
		$("#preDate").datepicker({
			language: 'cn',
	        autoclose: true,//选中之后自动隐藏日期选择框
	        format: "yyyy-mm-dd"//日期格式
		});
		/* getStockList(); */
		
		if(scheduleBillNo!=null && scheduleBillNo!=''){
			$('#wayBillInfo').val(scheduleBillNo);
			openInfo();
		}else{
			getNewBillNo();
		}
		$('#mytable').datagrid().datagrid('enableCellEditing');
		$('#mytable').datagrid().datagrid('keyCtr');
		$('.tableSum').css({'width': $('.datagrid-view').width()});
		$('#td1').css({'width': $('.datagrid-view').width()-660});
		$('#updateSchedule').hide();
		
	});
	
	/* grid begin */
		
	function getGrid(){
		$.ajax({
			type : "post",
			url : "${ctx}/inStorage/getStoreInOutDataByStatus",
			data : {
				status : '0'
			},
			dataType : "json",
			success: function(data){
				$('#billNoText').combobox({
					data: data.data,
					method:'post',
					valueField:'id',
					textField:'billNo',
					loadFilter: function (data){
						var newData = [];
						for(var i = 0;i<data.length;i++)
						{
							newData.push({id:data[i].billNo,billNo:(''+data[i].billNo).trim()});
						}
						return newData;
					}
				});
			}
		});	
		
		
	}
	/* 初始加载获取序号 */
	/* function init(){
		for(var i=0;i<10;i++){
			$('#mytable').datagrid('appendRow',{rowNo:(i+1),type:'',waybillNo:'',arrivalTime: '',brandName: '',count: '',sendTime: '',startAddress:'',carShopId:'',mark:'',itemId:''});
		}
	} */
	
	
	/* 品牌以及车型联动选择 */
	function carStyleType(e,brandName){
				rowNo = $(e).index()+1;//当前单击行的索引+1
				clickIndex.push($(e).index()+1);
				$(this).addClass("on").siblings("tr").removeClass("on");
				var carStyle = brandName+'-'+$(e).find("td").html();
				$('#mytable').datagrid('updateRow',{
					index: maincurRow,
					row: {
						brandName: carStyle
					}
				});
				$("#selectItem2").hide();
	}
	
	
	function onLoad() {
	    //添加“合计”列
	    var rows = $('#mytable').datagrid('getRows');
	    if(rows.length>0){
	    	  $('#mytable').datagrid('appendRow', {
	    		    type: '合计',
	    		    count: '<span id="countSum">'+compute("count")+'</span>'
	    	    });
	    	 
	    	  $('#mytable').datagrid('mergeCells',{
	    	        index:rows.length-1,
	    	        field:'type',
	    	        colspan:3

	    	    });
	    	  
	    }
	}
	//指定列求和
	function compute(colName) {
	    var rows = $('#mytable').datagrid('getRows');
	    var total = 0;
	    var totalDetail=0;
	    for (var i = 0; i < rows.length; i++) {
	    	if(rows[i][colName]!='' && rows[i][colName]!=null){
	    		totalDetail=rows[i][colName];
	    	}
	        total += parseInt(totalDetail);
	    }
	    return total;
	}
	/* 删行 */
	function cutrow(mytable)
	{
		var selectRowIndex = $('#' + mytable).datagrid('getRowIndex',$('#' + mytable).datagrid('getSelected'));
		if(selectRowIndex === 0 || selectRowIndex >0)
		{
			bootbox.confirm({ 
				  size: "small",
				  message: "确定要删除这一行？", 
				  callback: function(result){
					  if(result){
						  $('#' + mytable).datagrid('deleteRow',selectRowIndex);
							getrow(mytable);
					  }
					 
				  }
			 });
			
		}else
		{
			bootbox.alert('请先选择一行！');
		}
	}
	/* 插行 */
	function insertrow(mytable) {
		var selectRowIndex = $('#' + mytable).datagrid('getRowIndex',$('#' + mytable).datagrid('getSelected'));
		if (selectRowIndex === 0 || selectRowIndex > 0) {
			$('#' + mytable).datagrid('insertRow', {
				index : selectRowIndex,
				row : {
					type:'',
					waybillNo:'',
					arrivalTime:'',
					brandName: '',
					count: '',
					sendTime: '',
					startAddress: '',
					carShopName:'',
					mark:'',
					id:'',
					carShopId:'',
					vinList:''
				}
			});
			getrow(mytable);
		} else {
			if ($('#' + mytable).datagrid('getRows') == null || $('#' + mytable).datagrid('getRows') == "") {
				$('#' + mytable).datagrid('insertRow', {
					index : 0,
					row : {
						type:'',
						waybillNo:'',
						arrivalTime:'',
						brandName: '',
						count: '',
						sendTime: '',
						startAddress: '',
						carShopName:'',
						mark:'',
						id:'',
						carShopId:'',
						vinList:''
					}
				});
				getrow(mytable);
			} else {
				bootbox.alert('请先选择一行！');
			}
		}
}
	/* grid end */
	
	/* 添加车架号 */
	function formatOper(val,row,index){
		if(row.type=='0' || row.type=='2'){
			if(row.id==''){
				if(row.count==''){
					if(row.vinList==''){
						return '<a href="#" id="saveBtn" style="width:66px;margin:5px;" onclick="addVin(\'0\',\'0\',\'N\')"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>车架号</a>';  
					}else{
						return '<a href="#" id="saveBtn" style="width:66px;margin:5px;" onclick="addVin(\'0\',\'0\',\''+row.vinList+'\')"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>车架号</a>';  
					}
					
				}else{
					if(row.vinList==''){
						return '<a href="#" id="saveBtn" style="width:66px;margin:5px;" onclick="addVin(\'0\',\''+row.count+'\',\'N\')"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>车架号</a>';  
					}else{
						return '<a href="#" id="saveBtn" style="width:66px;margin:5px;" onclick="addVin(\'0\',\''+row.count+'\',\''+row.vinList+'\')"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>车架号</a>';  
					}
				}

	         
			}else{
				if(row.count==''){
					if(row.vinList==''){
						return '<a href="#" id="saveBtn" style="width:66px;margin:5px;" onclick="addVin(\''+row.id+'\',\'0\',\'N\')"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>车架号</a>';  
					}else{
						return '<a href="#" id="saveBtn" style="width:66px;margin:5px;" onclick="addVin(\''+row.id+'\',\'0\',\''+row.vinList+'\')"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>车架号</a>';  
					}
					
				}else{
					if(row.vinList==''){
						return '<a href="#" id="saveBtn" style="width:66px;margin:5px;" onclick="addVin(\''+row.id+'\',\''+row.count+'\',\'N\')"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>车架号</a>';  
					}else{
						return '<a href="#" id="saveBtn" style="width:66px;margin:5px;" onclick="addVin(\''+row.id+'\',\''+row.count+'\',\''+row.vinList+'\')"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>车架号</a>';  
					}
					
				}
			}
		}
	} 
	
	/* 添加类型 */
	function formatType(val,row,index){
		if(val=='-1'){
			return '';
		}if(val=='0'){
			return '商品车';
		}else if(val=='1'){
			return '配件';
		}else if(val=='2'){
			return '二手车';
		}else{
			return '';
		}
	}
	
	
	/* 新增车架号功能 */
	function addVin(id,count,vinList){
		var html='';
		if(count=='0'){
			bootbox.alert('请先填写商品车数量');
			return;
		}else{
			if(vinList!=null && vinList!='' && vinList!='undefined' && vinList!='N'){
				var arrVin=vinList.split(",");
				for(var i=0;i<count;i++){
					var vinItem=arrVin[i];
					if(vinItem!='N'){
						html+='<tr><td>'+(i+1)+'</td><td><input class="form-control" type="text" placeholder="请输入车架号" value='+vinItem+' /></td>';
					}else{
						html+='<tr><td>'+(i+1)+'</td><td><input class="form-control" type="text" placeholder="请输入车架号"/></td>';
					}
					
				}
			}else{
				for(var i=0;i<count;i++){
					html+='<tr><td>'+(i+1)+'</td><td><input class="form-control" type="text" placeholder="请输入车架号"/></td>';
				}
				
			}
			
			$('#vinList tbody').html(html);
			$('#modal-add').modal('show');
		}
	}
	
	/* 车架号弹窗消失 */
	function refreshVin(){
		$('#modal-add').modal('hide');
	}
	
	/* 车架号保存 */
	function saveVin(){
		var flag="false";
		var vinList="";
		var vinListInfo="";
		var row=$('#vinList tbody').find('tr');
		for(var i=0;i<row.length;i++){
			var rowItem=row.eq(i).find('td');
			if(rowItem.eq(1).find('input').val()!=null){
				if(rowItem.eq(1).find('input').val()==''){
					vinList+='N,';
				}else{
					vinList+=rowItem.eq(1).find('input').val()+',';
				}
				
			}
		}
		if(vinList!=''){
			vinListInfo=vinList.substring(0,vinList.length-1);
			bootbox.confirm({ 
				  size: "small",
				  message: "确定要保存该车架号信息?", 
				  callback: function(result){
					  if(result){
						  $('#mytable').datagrid('updateRow',{
								index: maincurRow,
								row: {
									vinList: vinListInfo
								}
						  });
						  bootbox.confirm_alert({ 
							  size: "small",
							  message: "保存成功！", 
							  callback: function(result){
								  if(result){
									  flag="true";
									  $('#modal-add').modal('hide');
									  $('.bootbox').modal('hide');
								  }else{
									  $('#modal-add').modal('hide');
									  $('.bootbox').modal('hide');
								  }
							  }
						 });
						setTimeout(function(){
							if(flag=="false"){
								 $('#modal-add').modal('hide');
								 $('.bootbox').modal('hide');
							}
						},3000);
					  }
				  }
			 });
			
		}
	}
	
	/* 获取装运车信息 */
	function getStockList(e){
		  var $val=$(e).val();
		  $('#shipDriver').attr('data-id','');
		  $('#shipDriver').val('');
		  $('#shipMobile').val('');
		  $.ajax({  
		        url: '${ctx}/operationMng/scheduleMng/getStockList',  
		        type: "post",  
		        contentType : "application/json;charset=UTF-8",
				dataType : 'JSON',
		        data: JSON.stringify({
		        	no:$val
		        }),
		        success: function (data) {
		        	var html ='';
		            if(data.code == 200){  
		            	if(data.data!=null && data.data!=''){
		            		if(data.data.length>0){
		            			for(var i=0;i<data.data.length;i++){
		                			html +='<p onclick="changeCar(this)" data-no='+data.data[i]['no']+' data-driverId='+data.data[i]['driverId']+' data-driver='+data.data[i]['driverName']+' data-mobile='+data.data[i]['mobile']+'>'+data.data[i]['no']+'['+data.data[i]['status']+']</p>';
		                		}
		            			$('#selectCarNo').html(html);
		            		}
		            		
		            	}  
		          }else{  
		            	   bootbox.alert('加载失败！');
		            	   $('#wayBillInfo').val('');
		               } 
		        }
		      }); 
		    var A_top = $(e).offset().top + $(e).outerHeight(true); //  1
			var A_left = $(e).offset().left;
			$('#selectItem9').show().css({
				"position" : "absolute",
				"top" : A_top + "px",
				"left" : A_left + "px"
			});
	  }
	/* 获取获取最新的调度单号 */
	function getNewBillNo(){
		  $.ajax({  
		        url: '${ctx}/operationMng/scheduleMng/getLatestBillNo',  
		        type: "GET",  
				dataType : 'JSON',
		        data: '',
		        success: function (data) {
		            if(data.code == 200){  
		            	$('#wayBillInfo').val(data.data);
		               }else{  
		            	   bootbox.alert(data.msg);
		            	   $('#wayBillInfo').val('');
		               }  
		        }  
		      }); 
	}
	/* 获取驾驶员以及联系电话信息 */
	function changeCar(e){
		var carNo=$(e).html();
		var carnumber=$(e).attr('data-no');
		var driverId=$(e).attr('data-driverId');
		var driver=$(e).attr('data-driver');
		var mobile=$(e).attr('data-mobile');
		if(driver!=null && driver!='' && driver!="null" ){
			$('#shipDriver').val(driver);
		}else{
			$('#shipDriver').val('');
		}
		if(mobile!=null && mobile!='' && mobile!='null'){
			$('#shipMobile').val(mobile);
		}else{
			$('#shipMobile').val('');
		}
		if(driverId!=null && driverId!='' && driverId!='null'){
			$('#shipDriver').attr('data-id',driverId);
		}else{
			$('#shipDriver').attr('data-id','');
		}
		$('#shipCarNo').val(carNo);
		$('#shipCarNo').attr('data-no',carnumber);
		
	}
	
	//数量校验不为0
	$.extend($.fn.validatebox.defaults.rules, {
		notLing: {
			validator: function(value, param){
				return value != param[0];
			},
			message: '不能为 {0}.'
	    },
	    checkDate:{
	    	validator: function (value) {  
	            var reg = /^([1-9]\d\d\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;   // /^\d{4}-\d{1,2}-\d{1,2}$/;  
	            return reg.test(value);  
	        },  
	        message: '输入日期格式不准确,请按yyyy-MM-dd格式输入。'  
	    }
	});

	/*新增收车单位  begin*/
	function addnewShop(){
		clear();
		$('#addBtn').show();
		$('#editBtn').hide();
		$('#myModalLabel').html('新增经销单位信息');	
		$('#modal-info').modal('show');
		$("#brithday").datepicker({
			language: 'cn',
	        autoclose: true,//选中之后自动隐藏日期选择框
	        format: "yyyy-mm-dd"//日期格式
		});
	}
	
	function clear(){
		$('#name').val('');
		$('#address').val('');
		$('#linkUser').val('');	
		$('#brithday').val('');	
		$('#linkTelephone').val('');	
		$('#linkMobile').val('');
		$('#orgCode').val('');
		$('#province').val('');
		$('#city').val('');
	}
	
	/* 保存新增经销单位信息 */
	function save(){
		var flag="false";
		var name=$("#name").val(); 
		var orgCode=$("#orgCode").val(); 
		var province=$("#province").val(); 
		var address=$("#address").val(); 
		var linkUser=$("#linkUser").val(); 
		var linkTelephone=$("#linkTelephone").val(); 
		var linkMobile=$("#linkMobile").val(); 
		var brithday=$("#brithday").val(); 
		var city=$("#city").val(); 
		if(name==''){
			bootbox.alert('经销单位名称不能为空！');
			return;
		}
		if(province==''){
			bootbox.alert('省份不能为空！');
			return;
		}
		if(city==''){
			bootbox.alert('城市不能为空！');
			return;
		}
		if(address==''){
			bootbox.alert('地址不能为空！');
			return;
		}
		if(linkUser==''){
			bootbox.alert('联系人不能为空！');
			return;
		}	
		if(linkTelephone==''){
			bootbox.alert('联系电话不能为空！');
			return;
		}
		
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该新增经销单位信息?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : '${ctx}/basicSetting/carShopMng/save',
							data : JSON.stringify({
								name : $.trim(name),				
								address :$.trim(address) ,
								orgCode : $.trim(orgCode),
					  			province : $.trim(province),
					  			city : $.trim(city),
								brithday : $.trim(brithday),
								linkUser : $.trim(linkUser) ,
								linkTelephone : $.trim(linkTelephone),
								linkMobile : $.trim(linkMobile)
								
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
												  refresh();
											  }else{
												  refresh();
											  }
										  }
									 });
									 setTimeout(function(){
											if(flag=="false"){
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
			})
	}
	/* 关闭窗体 */
	function refresh(){
		clear();
		$('#modal-info').modal('hide');
		
	}
	/*新增信息输入  end*/
	
	/* 新增品牌   begin*/
	function addnewBrand(){
		brandclear();	
		$('#modal-einfo').modal('show');
	}
	/* 关闭窗体 */
	function brandrefresh(){
		brandclear();
		$('#modal-einfo').modal('hide');
		
	}
	/* 数据重置 */
	function brandclear(){
		$('#id-hidden').val('');
		$('#brandName_new').val('');
		$('#carType_new').val('');	
		$('#mark_new').val('');
	}
	function brandsave(){
		var flag="false";
		var brandName=$('#brandName_new').val();
		var carType=$('#carType_new').val();	
		var mark=$('#mark_new').val();	
		if(brandName==''|| brandName==null){
			bootbox.alert('品牌名称不能为空！');
			return;
		}
		if(carType==''|| carType==null){
			bootbox.alert('车型不能为空！');
			return;
		}
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该新增品牌信息?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : '${ctx}/basicSetting/carBrandMng/save',
							data : JSON.stringify({
								brandName : brandName,				
								carType : carType,
								mark : mark
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
												  location.reload();
											  }else{
												 location.reload();  
											  }
										  }
									 });
									setTimeout(function(){
										if(flag=="false"){
											location.reload();
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
			})
	}
	/* 新增品牌 end */
	/* 打开操作 */
	function openInfo(){
		var scheduleBillNo = $('#wayBillInfo').val();
		var obj=[];
		var allAmount=0;
		$.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/scheduleMng/getScheduleDetailForFast/"+scheduleBillNo,
			data : '',
			dataType : 'JSON',
			success: function(data){
				if (data && data.code == 200){
					if(data.data!=null && data.data!=''){
						if(data.data.sendTime!=''&&data.data.sendTime!=null){
							$('#shipDate').val(jsonForDateFormat(data.data.sendTime));
						}else{
							$('#shipDate').val('');
						}
						
						$('#shipCarNo').val(data.data.carNumber);
						$('#shipCarNo').attr('data-no',data.data.carNumber);
						$('#shipDriver').val(data.data.driverName);
						$('#shipDriver').attr('data-id',data.data.driverId);
						$('#shipMobile').val(data.data.mobile);
						if(data.data.prepayTime!=null && data.data.prepayTime!=''){
							$('#preDate').val(jsonForDateFormat(data.data.prepayTime));
						}else{
							$('#preDate').val('');
						}
						$('#wayBillInfo').attr('data-id',data.data.id);
						$('#prebank').val(data.data.bankName);
						$('#preAmount').val(data.data.bankAccount);
						$('#preOil').val(data.data.oilCardNo);
						$('#preOilMoney').val(data.data.oilAmount);
						$('#preMoney').val(data.data.prepayCash);
						$('#preDate').attr('disabled','disabled');
						$('#prebank').attr('disabled','disabled');
						$('#preAmount').attr('disabled','disabled');
						$('#preOil').attr('disabled','disabled');
						$('#preOilMoney').attr('disabled','disabled');
						$('#preMoney').attr('disabled','disabled');
						if(data.data.modifyEnabledFlag=='Y' && data.data.insertUser=='${sessionScope.LMS_USER.id}'){
							$('#updateSchedule').hide();
							$('#saveSchedule').show();
						}else if(data.data.modifyEnabledFlag=='N' && data.data.insertUser=='${sessionScope.LMS_USER.id}'){
							$('#updateSchedule').show();
							$('#saveSchedule').hide();
						}else{
							$('#updateSchedule').hide();
							$('#saveSchedule').hide();
						}
						for(var i=0;i<data.data.detailList.length;i++){
							var objs=data.data.detailList[i];
							var objItem={};
							var vinListInfo='';
							var arrList=objs.vinList;
							if(arrList!=null && arrList!=''){
							  for(var k=0;k<arrList.length;k++){
								  if(arrList[k]==''){
									  vinListInfo+='N,'; 
								  }else{
									  vinListInfo+=arrList[k]+',';
								  }
							   }
							   vinListInfo=vinListInfo.substring(0,vinListInfo.length-1);
							}
							objItem.type=objs.type;
							objItem.waybillNo=objs.waybillNo;
							if(objs.type == 2)//二手车
							{
								if(null != objs.waybillNo || "" != objs.waybillNo)
								{
									objItem.waybillNo = "";
								}
							}
							if(objs.sendTime!=''&&objs.sendTime!=null){
								objItem.sendTime=jsonForDateFormat(objs.sendTime);
							}else{
								objItem.sendTime='';
							}
							if(objs.type=='1'){
								objItem.brandName=objs.brandName;
							}else{
								objItem.brandName=objs.brandName+'-'+objs.carStyle;
							}
							
							/* if(objs.type=='2'){
								objItem.brandName=objs.brandName;
							}else{
								objItem.brandName=objs.brandName+'-'+objs.carStyle;
							} */
							if(null == objs.supplierId)
							{
								objItem.supplierId="";
							}
							else
							{
								objItem.supplierId=objs.supplierId;
							}
							
							objItem.money=objs.money;
							if(null == objs.startProvince)
							{
								objItem.startProvince="";
							}
							else
							{
								objItem.startProvince=objs.startProvince;
							}
							
							objItem.count=objs.count;
							allAmount+=objs.count;
							if(objs.arrivalTime!=''&&objs.arrivalTime!=null){
								objItem.arrivalTime=jsonForDateFormat(objs.arrivalTime);
							}else{
								objItem.arrivalTime='';
							}
							objItem.startAddress=objs.startAddress;
							objItem.carShopName=objs.carShopName;
							if(null == objs.carShopId)
							{
								objItem.carShopId="";
							}
							else
							{
								objItem.carShopId=objs.carShopId;
							}
							
							objItem.mark=objs.mark;
							objItem.id=objs.id;
							objItem.vinList=vinListInfo;
							obj.push(objItem);
						}
					}
					$('#numRed').html(allAmount);
					$('#mytable').datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
					$('#mytable').datagrid('loadData',{"total" : obj.length,"rows" :obj});
					for(var k=0;k<10-data.data.detailList.length;k++){
						$('#mytable').datagrid('appendRow',{
							type:'',
							waybillNo:'',
							supplierId:'',
							sendTime: '',
							arrivalTime:'',
							brandName: '',
							count: '',
							startProvince:'',
							startAddress: '',
							carShopName:'',
							money:'',
							mark:'',
							id:'',
							carShopId:'',
							vinList:''
	     					});
					}
					
					getrow('mytable');

				}else{
					$('#mytable').datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
					for(var k=0;k<10;k++){
						$('#mytable').datagrid('appendRow',{
							type:'',
							waybillNo:'',
							supplierId:'',
							sendTime: '',
							arrivalTime:'',
							brandName: '',
							count: '',
							startProvince:'',
							startAddress: '',
							carShopName:'',
							money:'',
							mark:'',
							id:'',
							carShopId:'',
							vinList:''
	     					});
					}
					getrow('mytable');
					bootbox.alert(data.msg);
				}
			}
		});
	}
	
	/* 清空 */
	function clearInfo(){
		location.reload();
	}
   /* 保存 快速调度*/
   function saveQuick(){
		  var flag="false";
		  var objs=[];
		  var objList={};
		  var rows = $('#mytable').datagrid('getRows');
		  //console.info(JSON.stringify(rows));
		  var scheduleBillNo=$.trim($('#wayBillInfo').val());
		  var id=$('#wayBillInfo').attr('data-id');
		  var carNumber=$.trim($('#shipCarNo').attr('data-no'));
		  var shipDate=$.trim($('#shipDate').val());
		  var driverId=$('#shipDriver').attr('data-id');
		  var mobile=$.trim($('#shipMobile').val());
		  var prepayCash=$.trim($('#preMoney').val());
		  var bankName=$.trim($('#prebank').val());
		  var bankAccount=$.trim($('#preAmount').val());
		  var oilCardNo=$.trim($('#preOil').val());
		  var oilAmount=$.trim($('#preOilMoney').val());
		  var prepayTime=$.trim($('#preDate').val());
		  if(shipDate=="" || shipDate==null){
			  bootbox.alert('装运日期不能为空！');
			  return;
		  }
		  if(carNumber=="" || carNumber==null){
			  bootbox.alert('装运车号不能为空！');
			  return;
		  }
		  if(driverId=="" || driverId==null){
			  bootbox.alert('驾驶员不能为空！');
			  return;
		  }
		  if(mobile=="" || mobile==null){
			  bootbox.alert('联系电话不能为空！');
			  return;
		  }
		  
		  if(rows){
			  for(i = 0;i < rows.length;i++){ 
				  var objItem={};
				  var vinObj=[];
				  var typeInfo=rows[i].type.toString();
				  if(typeInfo!= "" && typeInfo!= null){
					  if(rows[i].type.toString()=="" || rows[i].type.toString()==null){
						    bootbox.alert('第'+(i+1)+'行调度明细类型不能为空！');
							return;
						 }
						  if(rows[i].type.toString()!='2'){
							  if(rows[i].waybillNo=="" || rows[i].waybillNo==null){
								    bootbox.alert('第'+(i+1)+'行调度明细运单编号不能为空！');
									return;
								 }
							  if(rows[i].carShopId.toString()=="" || rows[i].carShopId.toString()==null){
							    bootbox.alert('第'+(i+1)+'行调度明细收车单位不能为空！');
								return;
						      }
							 if(rows[i].brandName=="" || rows[i].brandName==null){
								    bootbox.alert('第'+(i+1)+'行调度明细品牌-车型不能为空！');
									return;
							  }
						  }
						  if(rows[i].sendTime=="" || rows[i].sendTime==null){
							    bootbox.alert('第'+(i+1)+'行调度明细托运日期不能为空！');
								return;
						  }
						 if(rows[i].arrivalTime=="" || rows[i].arrivalTime==null){
						    bootbox.alert('第'+(i+1)+'行调度明细交车时间不能为空！');
							return;
						  }
						 
						  if(rows[i].count.toString()=="" || rows[i].count.toString()==null){
							    bootbox.alert('第'+(i+1)+'行调度明细数量不能为空！');
								return;
						  }
						  
						  if(typeInfo=='1'){
								objItem.brandName=rows[i].brandName;
						  }else{
							  var arr=rows[i].brandName.split('-');
							  if(arr!=null && arr!=''){
								  objItem.brandName=arr[0];
								  objItem.carStyle=arr[1];
							  }
							  var arrVinList = rows[i].vinList;
							  if(arrVinList!='' && arrVinList!=null){
								  var arrVin=arrVinList.split(',');
								  if(arrVin!='' && arrVin.length>0){
									  for(var k=0;k<arrVin.length;k++){
										  if(arrVin[k]=='N'){
											  arrVin[k]=''; 
										  }else{
											  arrVin[k]=arrVin[k];
										  }
										  vinObj.push(arrVin[k]);
									  }
									  
									  
								  }
							  }
						  }
						   if(rows[i].id.toString()!=null && rows[i].id.toString()!=''){
							  objItem.id=rows[i].id.toString();
						  } 
						  objItem.type=rows[i].type.toString();
						  objItem.supplierId = rows[i].supplierId.toString();//供应商id
						  objItem.money = rows[i].money.toString();//金额
						  objItem.startProvince = rows[i].startProvince.toString();//始发省
						  objItem.waybillNo=rows[i].waybillNo.toString();
						  objItem.count=rows[i].count.toString();
						  objItem.sendTime=rows[i].sendTime.toString();
						  objItem.arrivalTime=rows[i].arrivalTime.toString();
						  objItem.carShopId=rows[i].carShopId.toString();
						  objItem.startAddress=rows[i].startAddress.toString();
						  objItem.mark=rows[i].mark.toString();
						  objItem.vinList=vinObj;
						  objs.push(objItem);
				 }
				}
				if(id!=null && id!=''){
					objList.id=id;
				}

		  }
		 objList.scheduleBillNo=scheduleBillNo;
		 objList.sendTime=shipDate;
		 objList.carNumber=carNumber;
		 objList.driverId=driverId;
		 objList.mobile=mobile;
		 objList.prepayCash=prepayCash;
		 objList.bankName=bankName;
		 objList.bankAccount=bankAccount;
		 objList.oilCardNo=oilCardNo;
		 objList.oilAmount=oilAmount;
		 objList.prepayTime=prepayTime;
		 objList.detailList=objs;
		 bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该调度信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : '${ctx}/operationMng/scheduleMng/saveForFast',
							data : JSON.stringify(objList),
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
												  location.reload();
											  }else{
												  location.reload();
											  }
										  }
									 });
									setTimeout(function(){
										if(flag=="false"){
											 $('.bootbox').modal('hide');
											 location.reload();
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
   /* 关闭修改申请 */
   function editRefresh(){
	   $('#modal-edit').modal('hide');
   }
   /* 申请修改 */
   function changeApply(){
	   $('#applyReason').val('');
	   $('#applyScheduleNo').html($.trim($('#wayBillInfo').val()));
	   $('#modal-edit').modal('show');
   }
   /* 提交申请修改 */
   function saveApply(){
	   var flag="false";
	   var scheduleBillNo=$('#applyScheduleNo').html();
	   var reason=$('#applyReason').val();
	   if(reason==''){
		   bootbox.alert('请填写修改原因！');
		   return;
	   }
	   bootbox.confirm({ 
			  size: "small",
			  message: "确定要提交该修改申请?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : '${ctx}/operationMng/scheduleMng/submitScheduleBillChangeApply',
							data : JSON.stringify({
								scheduleBillNo:scheduleBillNo,
								reason:reason
							}),
							contentType : "application/json;charset=UTF-8",
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {
									 bootbox.confirm_alert({ 
										  size: "small",
										  message: "提交成功！", 
										  callback: function(result){
											  if(result){
												  flag="true";
												  openInfo();
												  $('#modal-edit').modal('hide');
											  }else{
												  openInfo();
												  $('#modal-edit').modal('hide');
											  }
										  }
									 });
									setTimeout(function(){
										if(flag=="false"){
											 $('.bootbox').modal('hide');
											 openInfo();
											 $('#modal-edit').modal('hide');
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
   /* 打印功能 */
   function printInfo(){
	   var date = new Date();
       var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
       var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
       var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
       var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
       var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
       var localTime= date.getFullYear() + "-" + month + "-" + day+ " " + hours + ":" + minutes + ":" + seconds;
	   var html="";
	   var scheduleBillNo = $('#wayBillInfo').val();
	   var allAmount=0;
		$.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/scheduleMng/getScheduleDetailForFast/"+scheduleBillNo,
			data : '',
			dataType : 'JSON',
			success: function(data){
				if (data && data.code == 200){
					if(data.data!=null && data.data!=''){
						var type=""
						$('#pshipDate').html(jsonForDateFormat(data.data.sendTime));
						$('#pshipCarNo').html(data.data.carNumber);
						$('#pscheduleNo').html(data.data.scheduleBillNo);
						$('#pshipDriver').html(data.data.driverName);
						$('#pshipMobile').html(data.data.mobile);
						if(data.data.prepayTime!=null && data.data.prepayTime!=''){
							$('#ppreDate').html(jsonForDateFormat(data.data.prepayTime));
						}else{
							$('#ppreDate').html('');
						}
						$('#pprebank').html(data.data.bankName);
						$('#ppreAmount').html(data.data.bankAccount);
						$('#ppreOil').html(data.data.oilCardNo);
						$('#ppreOilMoney').html(data.data.oilAmount);
						$('#ppreMoney').html(data.data.prepayCash);
						for(var i=0;i<data.data.detailList.length;i++){
							var objs=data.data.detailList[i];
							var brandNameInfo=objs.brandName+'-'+objs.carStyle;
							allAmount+=objs.count;
							if(objs.type=='0'){
								type="商品车";
							}else if(objs.type=='1'){
								type="配件";
								brandNameInfo=objs.brandName;
							}else if(objs.type=='2'){
								type="二手车";
							}else{
								type="";
							}
							if(objs.arrivalTime!=''&&objs.arrivalTime!=null){
								objs.arrivalTime=jsonForDateFormat(objs.arrivalTime);
							}else{
								objs.arrivalTime='';
							}
							if(objs.sendTime!=''&&objs.sendTime!=null){
								objs.sendTime=jsonForDateFormat(objs.sendTime);
							}else{
								objs.sendTime='';
							}
							html+='<tr>'
							    +'<td>'+type+'</td>'
							    +'<td>'+objs.waybillNo+'</td>'
							    +'<td>'+objs.arrivalTime+'</td>'
							    +'<td>'+brandNameInfo+'</td>'
							    +'<td>'+objs.count+'</td>'
							    +'<td>'+objs.sendTime+'</td>'
							    +'<td>'+objs.startAddress+'</td>'
							    +'<td>'+objs.carShopName+'</td>'
							    +'<td>'+objs.mark+'</td>'
								+'</tr>';
						}
						html+='<tr><td colspan="4">合计</td><td>'+allAmount+'</td><td colspan="4"></td></tr>';
						$('#localTime').html(localTime);
						$('#myDataTable tbody').html(html);
						doprintForm();
					}else{
						bootbox.alert('暂时没有可打印的数据！');
					}
					
					
				}else{
					bootbox.alert(data.msg);
				}
			}
		});
	   	  
   }
   function doprintForm(){
		var html=$("#printTable").html();
		$('.page-header').hide();
		$('.detailInfo').hide();
		$('#printTable').show();
		$("#myDataTable").printTable({
		 header: "#headerInfo",
         footer: "#footerInfo",
		 mode: "rowNumber"
	});
		javasricpt:window.print();
		$('.page-header').show();
		$('.detailInfo').show();
		$('#printTable').hide();
		$("#printTable").html(html);
	 }
    /* 调度单号模糊查询 begin */
   function searchSchedule(e){
    	var $val=$(e).val();
    	$.ajax({
			type : 'POST',
			url : "${ctx}/operationMng/scheduleMng/getUnFinishedBillNo",
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			data: JSON.stringify({
				scheduleBillNo : $val
			}),
			success : function(data) {
				if (data && data.code == 200) {
					var html = "";
					if(data.data!=null && data.data!=''){
		        		if(data.data.length>0){
		        			for(var i=0;i<data.data.length;i++){
		            			html +='<p id='+data.data[i]['id']+' onclick=\'clickp(this)\'>'+data.data[i]['scheduleBillNo']+'</p>';
		            		}
		        		}
		        	}
		        	$('#selectSchedule').html(html);
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		});
    	var A_top = $(e).offset().top + $(e).outerHeight(true); //  1
		var A_left = $(e).offset().left;
		$('#selectItem8').show().css({
			"position" : "absolute",
			"top" : A_top + "px",
			"left" : A_left + "px"
		});
    }
   function clickp(e){
		$('#wayBillInfo').val($(e).html());
		$('#selectItem8').hide();
		
	};
   $(document).click(function(event) {
	   $('#selectItem8').hide();
	   $('#selectItem9').hide();
	});
   /* 调度单号模糊查询 end */
    </script> 
 </body>
</html>


