<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>其他应收款管理</title>
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/datetimepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
#modal-view{
    width: 600px;
    height: 600px;
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
			财务管理
			<small>
				<i class="icon-double-angle-right"></i>
				其他应收款管理
			</small>
		</h1>
	</div>
	<div class="page-content">
		<div class="searchbox col-xs-12">
			<label class="title" style="float: left;">经办人：</label>
			<!--  <select id="fom_business" class="form-box" style="float: left;width:180px;">	</select> -->
		     <input id="fom_operUser" class="form-box" type="text" placeholder="请输入经办人" style="float: left;width:234px;"/> 
			
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width: 105px;">借出开始日期：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 180px;height:34px;margin-right:30px; margin-left: 5px;">
				<input class="form-control" id="operTimeStart" type="text" placeholder="请输入时间" style="height: 34px;font-size: 14px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 13px;width:105px;">借出结束日期</label>
		   <div class="input-group input-group-sm" style="float: left;width: 180px;height:34px; margin-right:30px;margin-left: 5px;">
				<input class="form-control" id="operTimeEnd" type="text" placeholder="请输入时间" style="height: 34px;font-size: 14px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		</div>
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;width:60px;">事由：</label>
		    <input id="fom_name" class="form-box" type="text" placeholder="请输入事由" style="float: left;width:234px;"/> 
		   <!--   <select id="fom_fundType" class="form-box" style="float: left;width:180px;">	
							     <option value="">请选择类型</option>
		                         <option value="0">应付款</option>
		                         <option value="1">实付款</option>
							     </select>		 -->    
		    <label class="title" style="float: left;width: 105px;">状态：</label>
		     <select id="fom_status" class="form-box" style="float: left;width:180px;margin-left: 5px;">	
		                       <option value="">请选择状态</option>	                       
		                       <option value='0'>新建</option>
		                       <option value='1'>已提交</option>
			                    </select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="doadd()">新增</a>		
			<a class="itemBtn"  onclick="printInfo()">打印</a>
			<a class="itemBtn"  onclick="exportInfo()">导出</a>		
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>经办人</th>
					<th>摘要</th>
                    <th>借出时间</th>
                    <th>借款期限</th>
                    <th>提醒时间</th>
                    <th>借出金额</th>
                    <th>借款利息</th>
                    <th>本息合计</th>
                    <th>借款核减金额</th>
                    <th>核减时间</th>
                    <th>实际应收</th>
                    <th>状态</th>
                    <th>备注</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>			
			<!-- 新增 开始-->
			<div class="modal fade modal_car" id="modal-add" tabindex="-1" role="dialog"  data-backdrop="static">
				<div class="modal-dialog" style="padding:0;margin:auto;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
					  <button class="close" type="button" data-dismiss="modal">×</button>
					  <h3 id="myModalLabel">新增其他应收款信息</h3>
				     </div>
					<div class="modal-body" style="padding:5px 20px;">
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							  <div class="widget-main">
								  <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>经办人：</label>
								    <!--  <select id="business_add" class="form-control" style="height: 32px;">	</select> -->
								       <input class="form-control" id="operateUser_add" type="text" placeholder="请输入经办人" style="height: 32px;"/>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>摘要：</label>
								    <!--  <select id="business_add" class="form-control" style="height: 32px;">	</select> -->
								       <input class="form-control" id="name_add" type="text" placeholder="请输入摘要" style="height: 32px;"/>
								  </div>
								  <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title"><span class="red">*</span>借出时间：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px; ">
										<input class="form-control" style="font-size: 14px;padding: 5px 4px;" id="operateTime_add" style="height: 32px;" type="text" placeholder="请输入借出时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>
							      <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title" style="width:115px;"><span class="red">*</span>借款开始时间：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px; width: 370px;">
										<input class="form-control" style="font-size: 14px;padding: 5px 4px;" id="startTime_add" style="height: 32px;" type="text" placeholder="请输入借款开始时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>
							      <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title" style="width:115px;"><span class="red">*</span>借款结束时间：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px; width: 370px;">
										<input class="form-control" style="font-size: 14px;padding: 5px 4px;" id="endTime_add" style="height: 32px;" type="text" placeholder="请输入借款结束时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>								
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
									  <label class="title"><span class="red">*</span>借出金额：</label>
									  <input class="form-control" id="amount_add" type="text" placeholder="请输入借出金额" style="height: 32px;" onblur="revaildate(this,0);"/>
								 </div>
								  <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title" style="width:115px;"><span class="red">*</span>提醒时间：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px; width: 370px;">
										<input class="form-control" style="font-size: 14px;padding: 5px 4px;" id="noticeTime_add" style="height: 32px;" type="text" placeholder="请输入提醒时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>		
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
							        <label class="title"><span class="red">*</span>借款利息：</label>
							     	<input class="form-control" id="ratio_add" type="text" placeholder="请输入借款利息" style="height: 32px;" onblur="revaildate(this,1);"/>
							    </div>
							     <hr class="tree"></hr>
								 <div class="add-item extra-item">
							        <label class="title"><span class="red">*</span>本息合计：</label>
							     	<input class="form-control" id="totalAmount_add" type="text" placeholder="请输入本息合计" style="height: 32px;" onblur="revaildate(this,2);"/>
							    </div>
							    <hr class="tree"></hr>
								 <div class="add-item extra-item">
							        <label class="title" style="width:115px;">借款核减金额：</label>
							     	<input class="form-control" id="decreaseAmount_add" type="text" placeholder="请输入借款核减金额" style="height: 32px;width: 370px;" onblur="revaildate(this,3);"/>
							    </div>
							     <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title">核减时间：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px; ">
										<input class="form-control" style="font-size: 14px;padding: 5px 4px;" id="decreaseTime_add" style="height: 32px;" type="text" placeholder="请输入核减时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>	
							     <hr class="tree"></hr>
								 <div class="add-item extra-item">
							        <label class="title">实际应收：</label>
							     	<input class="form-control" id="actualAmount_add" type="text" placeholder="请输入实际应收" style="height: 32px;" readonly="readonly"/>
							    </div>	
							    <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title">备注：</label>
								     <input class="form-control" id="mark_add" type="text" placeholder="请输入备注" style="height: 32px;"/>
								 </div>		
							     <hr class="tree"></hr>
								   <div class="add-item extra-item">
								      <label class="title">附件：</label>
								      <div class="form-control" style="border:0;height:auto;">
								         <input type="file" id="attachFilePath" />
                                         <label class="title" id="filename"></label>
                                         <input type="hidden" name="filename_hidden" id="attachfilename_hidden" />
                                         <input type="hidden" name="filepath_hidden" id="attachfilepath_hidden" />
								      </div>
                                    </div>								 							
								  <hr class="tree"></hr>					  
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="save();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="cancel();">取消</a>
									 </div>
									</div>
							  </div>
						</div>
					</div>
				  </div>
				</div>
			</div>
			<!-- 新增 结束-->
			<!-- 编辑 开始-->
			<div class="modal fade modal_car" id="modal-edit" tabindex="-1" role="dialog"  data-backdrop="static">
				<div class="modal-dialog" style="padding:0;margin:auto;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
					  <button class="close" type="button" data-dismiss="modal">×</button>
					  <h3 id="myModalLabel">编辑其他应收款信息</h3>
				     </div>
					<div class="modal-body" style="padding:5px 20px;">
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							  <div class="widget-main">
							  	 <input type="hidden" id="id-hidden">
								 <div class="add-item extra-item">
								        <label class="title"><span class="red">*</span>经办人：</label>
								    <!--  <select id="business_add" class="form-control" style="height: 32px;">	</select> -->
								       <input class="form-control" id="operateUser_edit" type="text" placeholder="请输入经办人" style="height: 32px;"/>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>摘要：</label>
								    <!--  <select id="business_add" class="form-control" style="height: 32px;">	</select> -->
								       <input class="form-control" id="name_edit" type="text" placeholder="请输入摘要" style="height: 32px;"/>
								  </div>
								 <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title"><span class="red">*</span>借出时间：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px; ">
										<input class="form-control" style="font-size: 14px;padding: 5px 4px;" id="operateTime_edit" style="height: 32px;" type="text" placeholder="请输入借出时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>
							      <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title" style="width:115px;"><span class="red">*</span>借款开始时间：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px; width:370px;">
										<input class="form-control" style="font-size: 14px;padding: 5px 4px;" id="startTime_edit" style="height: 32px;" type="text" placeholder="请输入借款开始时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>
							      <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title" style="width:115px;"><span class="red">*</span>借款结束时间：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px; width:370px;">
										<input class="form-control" style="font-size: 14px;padding: 5px 4px;" id="endTime_edit" style="height: 32px;" type="text" placeholder="请输入借款结束时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>								
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
									  <label class="title"><span class="red">*</span>借出金额：</label>
									  <input class="form-control" id="amount_edit" type="text" placeholder="请输入借出金额" style="height: 32px;" onblur="revaildate(this,4);"/>
								 </div>
								 <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title">提醒时间：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px; ">
										<input class="form-control" style="font-size: 14px;padding: 5px 4px;" id="noticeTime_edit" style="height: 32px;" type="text" placeholder="请输入借款结束时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>		
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
							        <label class="title"><span class="red">*</span>借款利息：</label>
							     	<input class="form-control" id="ratio_edit" type="text" placeholder="请输入借款利息" style="height: 32px;" onblur="revaildate(this,5);"/>
							    </div>
							     <hr class="tree"></hr>
								 <div class="add-item extra-item">
							        <label class="title"><span class="red">*</span>本息合计：</label>
							     	<input class="form-control" id="totalAmount_edit" type="text" placeholder="请输入本息合计" style="height: 32px;" onblur="revaildate(this,6);"/>
							    </div>
							    <hr class="tree"></hr>
								 <div class="add-item extra-item">
							        <label class="title" style="width:115px;">借款核减金额：</label>
							     	<input class="form-control" id="decreaseAmount_edit" type="text" placeholder="请输入借款核减金额" style="height: 32px; width:370px;" onblur="revaildate(this,7);"/>
							    </div>
							     <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title">核减时间：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px; ">
										<input class="form-control" style="font-size: 14px;padding: 5px 4px;" id="decreaseTime_edit" style="height: 32px;" type="text" placeholder="请输入核减时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>	
							     
							     <hr class="tree"></hr>
								 <div class="add-item extra-item">
							        <label class="title">实际应收：</label>
							     	<input class="form-control" id="actualAmount_edit" type="text" placeholder="请输入实际应收" style="height: 32px;" readonly="readonly"/>
							    </div>	
							    <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title">备注：</label>
								     <input class="form-control" id="mark_edit" type="text" placeholder="请输入备注" style="height: 32px;"/>
								 </div>			
								 	 <hr class="tree"></hr>
								   <div class="add-item extra-item">
								      <label class="title">附件：</label>
								      <div class="form-control" style="border:0;height:auto;">
								         <input type="file" id="eattachFilePath" />
                                         <label class="title" id="efilename"></label>
                                         <input type="hidden" name="eattachfilename_hidden" id="eattachfilename_hidden" />
                                         <input type="hidden" name="eattachfilepath_hidden" id="eattachfilepath_hidden" />
								      </div>
                                    </div>					
								  <hr class="tree"></hr>					  
								    <div class="add-item-btn dis-block" id="editBtn">
									    <a class="add-itemBtn btnOk" onclick="saveEdit();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="cancelEdit();">取消</a>
									 </div>
									</div>
							  </div>
						</div>
					</div>
				  </div>
				</div>
			</div>
			<!-- 编辑 结束-->
			<!-- 查看 开始-->
		 <div class="modal fade" id="modal-view" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal" >×</button>
					<h3 id="myModalLabel" style="margin:5px;">查看其他应收款信息</h3>
				</div>
				<div class="modal-body" style="height:510px;overflow:auto;">
					<div class="mng" style="min-height:470px;">						
						<div class="table-item">
							<!-- 第一列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">经办人:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
									<!-- <select id="business_view" class="form-control no-border" style="height: 32px;">	</select> -->
										<p id="operateUser_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							<!-- 第二列 -->
							<div class="row newrow">
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">摘要:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="name_view" class="form-control no-border"></p>
									</div>
								</div>								
							</div>
							<!-- 第三列 -->
							<div class="row newrow">
							<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">借出时间:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="operateTime_view" class="form-control no-border"></p>
									</div>
								</div>							
							</div>
							<!-- 第四列 -->
							<div class="row newrow">
							<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">借款开始时间:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="startTime_view" class="form-control no-border"></p>
									</div>
								</div>																
								</div>	
							<!-- 第五列 -->	
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">借款结束时间:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="endTime_view" class="form-control no-border" ></p>
									</div>
								</div>																
							</div>	
							<!-- 第六列 -->	
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">借出金额:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="amount_view" class="form-control no-border" ></p>
									</div>
								</div>																
							</div>	
							<!-- 第六列 -->	
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">提醒时间:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="noticeTime_view" class="form-control no-border" ></p>
									</div>
								</div>																
							</div>	
							<!-- 第七列 -->	
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">借款利息:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="ratio_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>	
							<!-- 第八列 -->	
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">本息合计:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="totalAmount_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>	
							<!-- 第九列 -->	
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">借款核减金额:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="decreaseAmount_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>	
							<!-- 第十列 -->	
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">核减时间:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="decreaseTime_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>	
							<!-- 第十一列 -->	
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">实际应收:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="actualAmount_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>	
							<!-- 第十二列 -->	
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">附件:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="attachFilePath_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>							
							<!-- 第十三列 -->	
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">备注:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="mark_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>							
							<!-- 操作按钮栏 -->
							<div class="row newrow">
								<div class="col-xs-5"></div>
								<div class="col-xs-2">
									<div class="form-contr">
										<a class="backbtn" onclick="cancelView();"><i
											class="icon-undo" style="display: inline-block; width: 20px;"></i>关闭</a>
									</div>
								</div>
								<div class="col-xs-5"></div>
							</div>
															
							</div>	
						</div>
					</div>
				</div>
			<!-- 查看 结束-->		
			<!-- 核销操作 开始-->			
				<div class="modal fade" id="modal-upload" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding:0;margin:auto;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
					  <button class="close" type="button" data-dismiss="modal">×</button>
					  <h3 id="myModalLabel">核销信息</h3>
				     </div>
					<div class="modal-body" style="padding:5px 20px;">
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							  <div class="widget-main">
							  	 <input type="hidden" id="otherContactId-hidden">
								 <div class="add-item extra-item">
								        <label class="title"><span class="red">*</span>金额：</label>
								       <input class="form-control" id="amount_log" type="text" placeholder="请输入金额" style="height: 32px;" onblur="revaildate(this,8);"/>
								  </div>
								 <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title"><span class="red">*</span>核销时间：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px; ">
										<input class="form-control" style="font-size: 14px;padding: 5px 4px;" id="operateTime_log" style="height: 32px;" type="text" placeholder="请输入核销时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>							     
							    <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title">备注：</label>
								     <input class="form-control" id="mark_log" type="text" placeholder="请输入备注" style="height: 32px;"/>
								 </div>											 		
								  <hr class="tree"></hr>					  
								    <div class="add-item-btn dis-block" id="editBtn">
									    <a class="add-itemBtn btnOk" onclick="savelog();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="cancellog();">取消</a>
									 </div>
									</div>
							  </div>
						</div>
					</div>
				  </div>
				</div>
			</div>
			<!-- 核销操作结束-->	
			<!-- 查看核销记录 begin-->
		   <div class="modal fade" id="modal-show" tabindex="-1" role="dialog" data-backdrop="static">
		    <div class="modal-dialog" style="padding:0;margin:auto;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
					  <button class="close" type="button" data-dismiss="modal">×</button>
					  <h3 id="myModalLabel">核销信息</h3>
				     </div>
					<div class="modal-body" style="padding:5px 20px;">
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							  <div class="widget-main">
							  	 <input type="hidden" id="otherContactId-hidden">
								 <div class="add-item extra-item">
								      <table id="logList" class="table table-striped table-bordered table-hover">
					                      <thead>
						                   <tr>	
								               <th>序号</th>
								               <th>金额</th>
			                                   <th>核销时间</th>
			                                   <th>备注</th>
						                   </tr>
					                      </thead>
					                      <tbody>
					                      </tbody>
					                      </table>
								  </div>								
									</div>
							  </div>
						</div>
					</div>
				  </div>
				</div>
			   </div>
			<!-- 查看核销记录 end-->
		</div>
	</div>
</div>
<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>其他应收款信息表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>														
					<th>序号</th>
					<th>经办人</th>
					<th>摘要</th>
                    <th>借出时间</th>
                    <th>借款期限</th>
                    <th>提醒时间</th>
                    <th>借出金额</th>
                    <th>借款利息</th>
                    <th>本息合计</th>
                    <th>借款核减金额</th>
                    <th>核减时间</th>
                    <th>实际应收</th>
                    <th>状态</th>
                    <th>备注</th>                                           
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
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datetimepicker.js"></script>
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script>
<script src="${ctx}/staticPublic/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
function init(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/reportMng/receivableContacts/getListData" , //获取数据的ajax方法的URL							 
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
				columns: [{ data: "rownum","width":"5%"},
						    {data: "operateUser","width":"6%"},
						    {data: "name","width":"6%"},
						    {data: "operateTime","width":"7%"},
						    {data: "datadiff","width":"10%"},
						    {data: "noticeTime","width":"7%"},
						    {data: "amount","width":"6%"},
						    {data: "ratio","width":"6%"},
						    {data: "totalAmount","width":"5%"},
						    {data: "decreaseAmount","width":"6%"},
						    {data: "decreaseTime","width":"7%"},
						    {data: "actualAmount","width":"6%"},
						    {data: "status","width":"6%"},
						    {data: "mark","width":"6%"},
						    {data: null,"width":"11%"}],
		    columnDefs: [
			       {
					//时间
					targets:3,
					render: function (data, type, row, meta) {
						if(data!=''&& data!=null){
							return jsonForDateFormat(data);
						}else{
							return '';
						}
				 	}	       
				},  {
					//时间
					targets:5,
					render: function (data, type, row, meta) {
						if(data!=''&& data!=null){
							return jsonForDateFormat(data);
						}else{
							return '';
						}
				 	}	       
				}, {
					//时间
					targets:10,
					render: function (data, type, row, meta) {
						if(data!=''&& data!=null){
							return jsonForDateFormat(data);
						}else{
							return '';
						}
				 	}	       
				},{
					//类型
					targets:12,
					render: function (data, type, row, meta) {
						if(data=='0'){
							return '新建';
						}else if(data=='1'){
							return '已提交';
						}else{
							return '';
						}
				 	}	       
				},{
			    	 //操作栏
			    	 targets: 14,
			    	 render: function (data, type, row, meta) {
			    		 if(row.status=='0'){
		                    return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
		                    	+'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
						        +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
		                }
			    		 else
			    		{
			    			 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>'
			    			     +'<a class="table-edit" onclick="dolog('+ row.id +')">核销</a>'
			    			     +'<a class="table-edit"  style="width:70px;" onclick="dogetlog('+ row.id +')">核销记录</a>';
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
		 "sAjaxSource": "${ctx}/reportMng/receivableContacts/getListData" , //获取数据的ajax方法的URL	
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
				 columns: [{ data: "rownum","width":"5%"},
						    {data: "operateUser","width":"6%"},
						    {data: "name","width":"6%"},
						    {data: "operateTime","width":"7%"},
						    {data: "datadiff","width":"10%"},
						    {data: "noticeTime","width":"7%"},
						    {data: "amount","width":"6%"},
						    {data: "ratio","width":"6%"},
						    {data: "totalAmount","width":"5%"},
						    {data: "decreaseAmount","width":"6%"},
						    {data: "decreaseTime","width":"7%"},
						    {data: "actualAmount","width":"6%"},
						    {data: "status","width":"6%"},
						    {data: "mark","width":"6%"},
						    {data: null,"width":"11%"}],
				    columnDefs: [
					       {
							//时间
							targets:3,
							render: function (data, type, row, meta) {
								if(data!=''&& data!=null){
									return jsonForDateFormat(data);
								}else{
									return '';
								}
						 	}	       
						},  {
							//时间
							targets:5,
							render: function (data, type, row, meta) {
								if(data!=''&& data!=null){
									return jsonForDateFormat(data);
								}else{
									return '';
								}
						 	}	       
						}, {
							//时间
							targets:10,
							render: function (data, type, row, meta) {
								if(data!=''&& data!=null){
									return jsonForDateFormat(data);
								}else{
									return '';
								}
						 	}	       
						},{
							//类型
							targets:12,
							render: function (data, type, row, meta) {
								if(data=='0'){
									return '新建';
								}else if(data=='1'){
									return '已提交';
								}else{
									return '';
								}
						 	}	       
						},{
					    	 //操作栏
					    	 targets: 14,
					    	 render: function (data, type, row, meta) {
					    		 if(row.status=='0'){
				                    return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
				                    	+'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
								        +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
				                }
					    		 else
					    		{
					    			 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>'
					    			     +'<a class="table-edit" onclick="dolog('+ row.id +')">核销</a>'
					    			     +'<a class="table-edit" style="width:70px;"  onclick="dogetlog('+ row.id +')">核销记录</a>';
					    		}
					    	}
				    	} 
						],
						"fnServerData":retrieveData //与后台交互获取数据的处理函数
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
				operTimeStart : $.trim($('#operTimeStart').val()),
				operTimeEnd :$.trim($('#operTimeEnd').val()),
				operUser :$.trim($('#fom_operUser').val()),
				name :$.trim($('#fom_name').val()),
				status :$('#fom_status').val()
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.info(JSON.stringify(data.data));						
					obj.iTotalDisplayRecords=data.data.totalCounts;
					obj.iTotalRecords=data.data.totalCounts;
					obj.aaData=data.data.records;		
					obj.sEcho=data.data.frontParams;
					if(obj.aaData.length>0){
						for(var i=0;i<obj.aaData.length;i++){
							obj.aaData[i]["rownum"]=i+1;
							if(obj.aaData[i]["endTime"]!=''&&obj.aaData[i]["endTime"]!=null){
								obj.aaData[i]["endTime"]=jsonForDateFormat(obj.aaData[i]["endTime"]);
							}
							if(obj.aaData[i]["startTime"]!=''&&obj.aaData[i]["startTime"]!=null){
								obj.aaData[i]["startTime"]=jsonForDateFormat(obj.aaData[i]["startTime"]);
							}
							if(obj.aaData[i]["startTime"]!=''&&obj.aaData[i]["startTime"]!=null&&obj.aaData[i]["endTime"]!=''&&obj.aaData[i]["endTime"]!=null){
								obj.aaData[i]["datadiff"]=obj.aaData[i]["startTime"]+" 到  "+obj.aaData[i]["endTime"];
							}else{
								obj.aaData[i]["datadiff"]='';
							}
							
						}
					}else{
						obj.aaData=[];
					}
					//console.info(JSON.stringify(obj.aaData));	
					fnCallback(obj); //服务器端返回的对象的returnObject部分是要求的格式  	
				} else {
					 bootbox.alert(data.msg);
				}
				
			}
		}); 
	   
	}

function searchInfo(){
	reload();
}
$(function(){
	$("#operTimeStart").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#operTimeEnd").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	init();
});

/* 金额验证 */
function revaildate(e, flag) {
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
	var money = $(e).val();
	if (money != null && money != '') {
		if (!reg.test(money)) {
			if (flag == '0') {//借入金额  			
				$('#amount_add').val('');
				bootbox.alert('请输入正确的金额！');
			} else if (flag == '1') {//借款利息
				$('#ratio_add').val('');
				bootbox.alert('请输入正确的利息！');
			} else if (flag == '2') {//本息合计
				$('#totalAmount_add').val('');
				$('#actualAmount_add').val($('#decreaseAmount_add').val());
				bootbox.alert('请输入正确的金额！');
			} else if (flag == '3') {//借款核减金额
				$('#decreaseAmount_add').val('');
				$('#actualAmount_add').val($('#totalAmount_add').val());
				bootbox.alert('请输入正确的金额！');
			}else if (flag == '4') {//借入金额  			
				$('#amount_edit').val('');
				bootbox.alert('请输入正确的金额！');
			} else if (flag == '5') {//借款利息
				$('#ratio_edit').val('');
				bootbox.alert('请输入正确的利息！');
			} else if (flag == '6') {//本息合计
				$('#totalAmount_edit').val('');
				$('#actualAmount_edit').val($('#decreaseAmount_edit').val());
				bootbox.alert('请输入正确的金额！');
			} else if (flag == '7') {//借款核减金额
				$('#decreaseAmount_edit').val('');
				$('#actualAmount_edit').val($('#totalAmount_edit').val());
				bootbox.alert('请输入正确的金额！');
			} 
		}
	}
}
//清空
function clear(){
	$('#operateUser_add').val('');
	$('#name_add').val('');
	$('#operateTime_add').val('');
	$('#startTime_add').val('');
	$('#endTime_add').val('');
	$('#amount_add').val('');
	$('#ratio_add').val('');
	$('#totalAmount_add').val('');
	$('#decreaseAmount_add').val('');
	$('#decreaseTime_add').val('');
	$('#actualAmount_add').val('');
	$('#noticeTime_add').val('');
	$('#mark_add').val('');
	$('#attachFilePath').val('');
	$('#attachfilename_hidden').val('');
	$('#attachfilepath_hidden').val('');
}
//关闭
function cancel()
{
	 clear();
	$('#modal-add').modal('hide');
}
//新增
function doadd()
{
	clear();
	$("#operateTime_add").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#startTime_add").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#endTime_add").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#noticeTime_add").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#decreaseTime_add").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	upload();
	$("#totalAmount_add").on('input',function(e){  
		   var a = $(this).val();
		   var b = $("#decreaseAmount_add").val();
		   $('#actualAmount_add').val(a*1-b*1);
		}); 
	$("#decreaseAmount_add").on('input',function(e){  
		   var a = $("#totalAmount_add").val();
		   var b = $(this).val();
		   $('#actualAmount_add').val(a*1-b*1);
		});
	$('#modal-add').modal('show');
}

/*附件上传 */
function upload(){
	$("#attachFilePath").uploadify({
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
        'uploader':'${ctx}/upload/saveFile?type=othercontacts',
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
        	$('#attachfilename_hidden').val(orginFileName);
        	$('#attachfilepath_hidden').val(attachFilePath);
        }
 });
}

//保存
function save(){
	var flag="false";
	var operateUser=$('#operateUser_add').val();
	var name=$('#name_add').val();
	var operateTime=$('#operateTime_add').val();
	var startTime=$('#startTime_add').val();
	var endTime=$('#endTime_add').val();
	var amount=$('#amount_add').val();
	var ratio=$('#ratio_add').val();
	var totalAmount=$('#totalAmount_add').val();
	var decreaseAmount=$('#decreaseAmount_add').val();
	var decreaseTime=$('#decreaseTime_add').val();
	var noticeTime=$('#noticeTime_add').val();
	var actualAmount=$('#actualAmount_add').val();
	var attachFilePath=$('#attachfilepath_hidden').val();
	var mark=$('#mark_add').val();
	if(operateUser==''|| operateUser==null){
		bootbox.alert('经办人不能为空！');
		return;
	}
	if(name==''|| name==null){
		bootbox.alert('摘要不能为空！');
		return;
	}
	
	if(operateTime==''|| operateTime==null ){
		bootbox.alert('借入时间不能为空！');
		return;
	}
	if(startTime==''|| startTime==null){
		bootbox.alert('借款开始时间不能为空！');
		return;
	}
	if(endTime==''|| endTime==null){
		bootbox.alert('借款结束时间不能为空！');
		return;
	}
	if(amount==''|| amount==null){
		bootbox.alert('借入金额不能为空！');
		return;
	}
	if(ratio==''|| ratio==null){
		bootbox.alert('借款利息不能为空！');
		return;
	}
	if(totalAmount==''|| totalAmount==null){
		bootbox.alert('本息合计不能为空！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该其他应收款信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/reportMng/receivableContacts/save',
						data : JSON.stringify({
							id:0,
							operateUser :$.trim(operateUser),
							name : $.trim(name),
							operateTime : $.trim(operateTime),
							startTime : $.trim(startTime),
							endTime :$.trim(endTime),
							amount : $.trim(amount),
							ratio : $.trim(ratio),
							noticeTime:$.trim(noticeTime),
							totalAmount : $.trim(totalAmount),
							decreaseAmount : $.trim(decreaseAmount),
							decreaseTime : $.trim(decreaseTime),
							actualAmount : $.trim(actualAmount),
							attachFilePath : $.trim(attachFilePath),
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
											  reload();
											  $('#modal-add').modal('hide');
										  }else{
											  reload();
											  $('#modal-add').modal('hide');
										  }
									  }
								});
								setTimeout(function(){
									if(flag=="false"){
										 reload();
										 $('#modal-add').modal('hide');
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

//编辑
function doedit(id)
{
	$("#operateTime_edit").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#startTime_edit").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#endTime_edit").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#noticeTime_edit").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#decreaseTime_edit").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});	
	eupload();
	$("#totalAmount_edit").on('input',function(e){  
		   var a = $(this).val();
		   var b = $("#decreaseAmount_edit").val();
		   $('#actualAmount_edit').val(a*1-b*1);
		}); 
	$("#decreaseAmount_edit").on('input',function(e){  
		   var a = $("#totalAmount_edit").val();
		   var b = $(this).val();
		   $('#actualAmount_edit').val(a*1-b*1);
		});
	$.ajax({
		type : 'GET',
		url : "${ctx}/reportMng/receivableContacts/getDetailData/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				$('#id-hidden').val(id);				
				$('#operateUser_edit').val(data.data.operateUser);
				$('#name_edit').val(data.data.name);
				if(data.data.operateTime!=''&&data.data.operateTime!=null){
					$("#operateTime_edit").val(jsonForDateFormat(data.data.operateTime)); 
				}else{
					$("#operateTime_edit").val(''); 
				}
				if(data.data.startTime!=''&&data.data.startTime!=null){
					$("#startTime_edit").val(jsonForDateFormat(data.data.startTime)); 
				}else{
					$("#startTime_edit").val(''); 
				}
				if(data.data.endTime!=''&&data.data.endTime!=null){
					$("#endTime_edit").val(jsonForDateFormat(data.data.endTime)); 
				}else{
					$("#endTime_edit").val(''); 
				}			
				$("#amount_edit").val(data.data.amount);
				$("#totalAmount_edit").val(data.data.totalAmount);
				if(data.data.noticeTime!=''&&data.data.noticeTime!=null){
					$("#noticeTime_edit").val(jsonForDateFormat(data.data.noticeTime)); 
				}else{
					$("#noticeTime_edit").val(''); 
				}
				$("#ratio_edit").val(data.data.ratio);
				$("#decreaseAmount_edit").val(data.data.decreaseAmount);
				if(data.data.decreaseTime!=''&&data.data.decreaseTime!=null){
					$("#decreaseTime_edit").val(jsonForDateFormat(data.data.decreaseTime)); 
				}else{
					$("#decreaseTime_edit").val(''); 
				}
				$("#actualAmount_edit").val(data.data.actualAmount);
				$("#mark_edit").val(data.data.mark);	
				if(data.data.attachFilePath!=''&&data.data.attachFilePath!=null&&data.data.attachFilePath!='null'){
					var attachFilePaths="${ctx}"+data.data.attachFilePath;
					var certificatehtml='<a  href='+attachFilePaths+' target="_blank">附件</a>';
					$("#eattachfilepath_hidden").val(data.data.attachFilePath);
					$('#efilename').html(certificatehtml);
				}else{
					$('#efilename').html('');
					$("#eattachfilepath_hidden").val('');
				}
				
				$('#modal-edit').modal('show');
				$('#editBtn').show();							
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
	
}


function eupload(){
	$("#eattachFilePath").uploadify({
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
        'uploader':'${ctx}/upload/saveFile?type=othercontacts',
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
        	$('#efilename').html(html);
        	$('#eattachfilename_hidden').val(orginFileName);
        	$('#eattachfilepath_hidden').val(attachFilePath);
        }
 });
}
//更新
function saveEdit()
{
	var flag="false";
	var id = $('#id-hidden').val();
	var operateUser=$('#operateUser_edit').val();
	var name=$('#name_edit').val();
	var operateTime=$('#operateTime_edit').val();
	var startTime=$('#startTime_edit').val();
	var endTime=$('#endTime_edit').val();
	var amount=$('#amount_edit').val();
	var ratio=$('#ratio_edit').val();
	var totalAmount=$('#totalAmount_edit').val();
	var decreaseAmount=$('#decreaseAmount_edit').val();
	var decreaseTime=$('#decreaseTime_edit').val();
	var noticeTime=$('#noticeTime_edit').val();
	var actualAmount=$('#actualAmount_edit').val();
	var attachFilePath=$('#eattachfilepath_hidden').val();
	var mark=$('#mark_edit').val();
	if(operateUser==''|| operateUser==null){
		bootbox.alert('经办人不能为空！');
		return;
	}
	if(name==''|| name==null){
		bootbox.alert('摘要不能为空！');
		return;
	}
	
	if(operateTime==''|| operateTime==null ){
		bootbox.alert('借入时间不能为空！');
		return;
	}
	if(startTime==''|| startTime==null){
		bootbox.alert('借款开始时间不能为空！');
		return;
	}
	if(endTime==''|| endTime==null){
		bootbox.alert('借款结束时间不能为空！');
		return;
	}
	if(amount==''|| amount==null){
		bootbox.alert('借入金额不能为空！');
		return;
	}
	if(ratio==''|| ratio==null){
		bootbox.alert('借款利息不能为空！');
		return;
	}
	if(totalAmount==''|| totalAmount==null){
		bootbox.alert('本息合计不能为空！');
		return;
	}
	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该其他应收款信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/reportMng/receivableContacts/save',
						data : JSON.stringify({
							id : id,
							operateUser :$.trim(operateUser),
							name : $.trim(name),
							operateTime : $.trim(operateTime),
							startTime : $.trim(startTime),
							endTime :$.trim(endTime),
							amount : $.trim(amount),
							ratio : $.trim(ratio),
							noticeTime:$.trim(noticeTime),
							totalAmount : $.trim(totalAmount),
							decreaseAmount : $.trim(decreaseAmount),
							decreaseTime : $.trim(decreaseTime),
							actualAmount : $.trim(actualAmount),
							attachFilePath : $.trim(attachFilePath),
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
											  reload();
											  $('#modal-edit').modal('hide');
										  }else{
											  reload();
											  $('#modal-edit').modal('hide');
										  }
									  }
								});
								setTimeout(function(){
									if(flag=="false"){
										 reload();
										 $('#modal-edit').modal('hide');
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

function cancelEdit()
{
	$('#modal-edit').modal('hide');
}
//查看
function doshow(id)
{
	$.ajax({
		type : 'GET',
		url : "${ctx}/reportMng/receivableContacts/getDetailData/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				//$('#id-hidden').val(id);	
				$('#operateUser_view').html(data.data.operateUser);
				$('#name_view').html(data.data.name);
				if(data.data.operateTime!=''&&data.data.operateTime!=null){
					$("#operateTime_view").html(jsonForDateFormat(data.data.operateTime)); 
				}else{
					$("#operateTime_view").html(''); 
				}
				if(data.data.startTime!=''&&data.data.startTime!=null){
					$("#startTime_view").html(jsonForDateFormat(data.data.startTime)); 
				}else{
					$("#startTime_view").html(''); 
				}
				if(data.data.endTime!=''&&data.data.endTime!=null){
					$("#endTime_view").html(jsonForDateFormat(data.data.endTime)); 
				}else{
					$("#endTime_view").html(''); 
				}
				if(data.data.noticeTime!=''&&data.data.noticeTime!=null){
					$("#noticeTime_view").html(jsonForDateFormat(data.data.noticeTime)); 
				}else{
					$("#noticeTime_view").html(''); 
				}
				if(data.data.decreaseTime!=''&&data.data.decreaseTime!=null){
					$("#decreaseTime_view").html(jsonForDateFormat(data.data.decreaseTime)); 
				}else{
					$("#decreaseTime_view").html(''); 
				}
				$("#amount_view").html(data.data.amount); 
				$("#ratio_view").html(data.data.ratio); 
				$("#totalAmount_view").html(data.data.totalAmount);
				$("#decreaseAmount_view").html(data.data.decreaseAmount);
				$("#actualAmount_view").html(data.data.actualAmount);
				$("#mark_view").html(data.data.mark);
				
				if(data.data.attachFilePath!=''&&data.data.attachFilePath!=null&&data.data.attachFilePath!='null'){
					var attachFilePaths="${ctx}"+data.data.attachFilePath;
					var certificatehtml='<a  href='+attachFilePaths+' target="_blank">附件</a>';
					$('#attachFilePath_view').html(certificatehtml);
				}else{
					$('#attachFilePath_view').html('');
				}
				$('#modal-view').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}

function cancelView()
{
	$('#modal-view').modal('hide');	
}
//提交
function dosubmit(id)
{
		var flag="false";
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要提交该其他应收款信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'GET',
							url : "${ctx}/reportMng/receivableContacts/submit/"+id,
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {
									 bootbox.confirm_alert({ 
										  size: "small",
										  message: "提交成功！", 
										  callback: function(result){
											  if(result){
												  flag="true";
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

var format = function(time, format){
    var t = new Date(time);
    var tf = function(i){return (i < 10 ? '0' : '') + i};
    return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a){
        switch(a){
            case 'yyyy':
                return tf(t.getFullYear());
                break;
            case 'MM':
                return tf(t.getMonth() + 1);
                break;
            case 'mm':
                return tf(t.getMinutes());
                break;
            case 'dd':
                return tf(t.getDate());
                break;
            case 'HH':
                return tf(t.getHours());
                break;
            case 'ss':
                return tf(t.getSeconds());
                break;
        }
    })
}
//删除
function dodelete(id)
{
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该其他应收款信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/reportMng/receivableContacts/delete/"+id,
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								 bootbox.confirm_alert({ 
									  size: "small",
									  message: "删除成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
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

//清空核销
function clearlog(){
	$('#amount_log').val('');
	$('#otherContactId-hidden').val('');
	$('#operateTime_log').val('');
	$('#mark_log').val('');	
}

//关闭核销
function cancellog()
{
	clearlog();
	$('#modal-upload').modal('hide');
}
//打开核销
function dolog(otherContactId)
{
	cancellog();
	$('#otherContactId-hidden').val(otherContactId);
	$("#operateTime_log").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});	
	$('#modal-upload').modal('show');
}
//核销信息保存
function savelog(){
	var otherContactId=$('#otherContactId-hidden').val();
	var amount=$('#amount_log').val();
	var operateTime=$('#operateTime_log').val();
	var mark=$('#mark_log').val();
	if(amount==''||amount==null){
		bootbox.alert('金额不能为空！');
		return;
	}
	if(operateTime==''||operateTime==null){
		bootbox.alert('核销时间不能为空！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该核销信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/reportMng/receivableContacts/saveLog',
						data : JSON.stringify({
							otherContactId : otherContactId,
							amount :$.trim(amount),
							operateTime : $.trim(operateTime),
							mark : $.trim(mark)
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
											  reload();
											  $('#modal-upload').modal('hide');
										  }else{
											  reload();
											  $('#modal-upload').modal('hide');
										  }
									  }
								});
								setTimeout(function(){
									if(flag=="false"){
										 reload();
										 $('#modal-upload').modal('hide');
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
function dogetlog(otherContactId){
	var html="";
	 $.ajax({
			type : 'GET',
			url : "${ctx}/reportMng/receivableContacts/getLogList/"+otherContactId,
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					if(data.data.length>0 && data.data!=null){
						for(var i=0;i<data.data.length;i++){
							var amount=data.data[i]['amount'];
							if(amount==null){
								amount='';
							}
							
							var operateTime='';
							if(data.data[i]['operateTime']!=null && data.data[i]['operateTime']!=''){
								operateTime=jsonForDateFormat(data.data[i]['operateTime']);
							}
							var mark='';
							if(data.data[i]['mark']!=null && data.data[i]['mark']!=''){
								mark=data.data[i]['mark'];
							}else{
								mark='';
							}
							html+='<tr>'
								+'<td>'+(i+1)+'</td>'
							    +'<td>'+amount+'</td>'
							    +'<td>'+operateTime+'</td>'
							    +'<td>'+mark+'</td>'
							    +'</tr>';
						}
					}else{
						html='<tr><td colspan="4">暂无核销信息</td></tr>';
					}
					$('#logList tbody').html(html);
					$('#modal-show').modal('show');
				}else{
					bootbox.alert('获取失败！');
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
       var localTime= date.getFullYear() + "-" + month  + "-" + day+ " " + hours + ":" + minutes + ":" + seconds ;
	   var html="";
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/reportMng/receivableContacts/getPrintData",
			data : JSON.stringify({
				operTimeStart : $.trim($('#operTimeStart').val()),
				operTimeEnd :$.trim($('#operTimeEnd').val()),
				operUser :$.trim($('#fom_operUser').val()),
				name :$.trim($('#fom_name').val()),
				status :$('#fom_status').val()
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {					
					if(data.data.length>0){
						for(var i=0;i<data.data.length;i++){
							data.data[i]["rownum"]=i+1;
							if(data.data[i]["operateUser"]==null || data.data[i]["operateUser"]==''){
								data.data[i]["operateUser"]=''; 
							 }
							if(data.data[i]["name"]==null || data.data[i]["name"]==''){
								data.data[i]["name"]=''; 
							 }
							if(data.data[i]["operateTime"]==null || data.data[i]["operateTime"]==''){
								data.data[i]["operateTime"]=''; 
							 }else{
								 data.data[i]["operateTime"]=jsonForDateFormat(data.data[i]['operateTime']);  
							 }
							if(data.data[i]["endTime"]!=''&&data.data[i]["endTime"]!=null){
								data.data[i]["endTime"]=jsonForDateFormat(data.data[i]["endTime"]);
							}
							if(data.data[i]["startTime"]!=''&&data.data[i]["startTime"]!=null){
								data.data[i]["startTime"]=jsonForDateFormat(data.data[i]["startTime"]);
							}
							if(data.data[i]["startTime"]!=''&&data.data[i]["startTime"]!=null&&data.data[i]["endTime"]!=''&&data.data[i]["endTime"]!=null){
								data.data[i]["datadiff"]=data.data[i]["startTime"]+" 到   "+data.data[i]["endTime"];
							}else{
								data.data[i]["datadiff"]='';
							}
							if(data.data[i]["noticeTime"]==null || data.data[i]["noticeTime"]==''){
								data.data[i]["noticeTime"]=''; 
							 }else{
								 data.data[i]["noticeTime"]=jsonForDateFormat(data.data[i]['noticeTime']);  
							 }
							if(data.data[i]["decreaseTime"]==null || data.data[i]["decreaseTime"]==''){
								data.data[i]["decreaseTime"]=''; 
							 }else{
								 data.data[i]["decreaseTime"]=jsonForDateFormat(data.data[i]['decreaseTime']);  
							 }							
							if(data.data[i]["status"]==null || data.data[i]["status"]==''){
								data.data[i]["status"]=''; 
								data.data[i]["statusName"]=''; 
							 }else if(data.data[i]["status"]=='0'){
								 data.data[i]["statusName"]='新建';  
							 }else{
								 data.data[i]["statusName"]='已提交';  
							 }
							if(data.data[i]["mark"]==null || data.data[i]["mark"]==''){
								data.data[i]["mark"]=''; 
							 }							
						
								html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
							    +'<td>'+data.data[i]["operateUser"]+'</td>'
							    +'<td>'+data.data[i]["name"]+'</td>'
							    +'<td>'+data.data[i]["operateTime"]+'</td>'
							    +'<td>'+data.data[i]["datadiff"]+'</td>'
							    +'<td>'+data.data[i]["noticeTime"]+'</td>'
							    +'<td>'+data.data[i]["amount"]+'</td>'
							    +'<td>'+data.data[i]["ratio"]+'</td>'
							    +'<td>'+data.data[i]["totalAmount"]+'</td>'
							    +'<td>'+data.data[i]["decreaseAmount"]+'</td>'
							    +'<td>'+data.data[i]["decreaseTime"]+'</td>'
							    +'<td>'+data.data[i]["actualAmount"]+'</td>'
							    +'<td>'+data.data[i]["statusName"]+'</td>'
							    +'<td>'+data.data[i]["mark"]+'</td></tr>';							   
						      
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
		 pageSize: 15
	});
		javasricpt:window.print();
		$('#breadcrumbs').show();
		$('.page-content').show();
		$('#printTable').hide();
		$("#printTable").html(html);
	 }
/* 导出 */
function exportInfo()
{
	   var operTimeStart=$('#operTimeStart').val();
	   var operTimeEnd=$('#operTimeEnd').val();
	   var operUser=$('#fom_operUser').val();
	   var name=$('#fom_name').val();
	   var status=$('#fom_status').val();
	   var form = $('<form action="${ctx}/reportMng/receivableContacts/getExportData" method="POST"></form>');
	   var operTimeStartInput = $('<input id="operTimeStart" name="operTimeStart" value="'+operTimeStart+'" type="hidden" />');
	   var operTimeEndInput = $('<input id="operTimeEnd" name="operTimeEnd" value="'+operTimeEnd+'" type="hidden" />');
	   var operUserInput = $('<input id="operUser" name="operUser" value="'+operUser+'" type="hidden" />');
	   var statustInput = $('<input id="status" name="status" value="'+status+'" type="hidden" />');
	   var nameInput = $('<input id="name" name="name" value="'+name+'" type="hidden" />');	   
	   form.append(operTimeStartInput);
	   form.append(operTimeEndInput);
	   form.append(operUserInput);
	   form.append(nameInput);
	   form.append(statustInput);
	   $('body').append(form);
	   form.submit();
}
</script>

</body>
</html>