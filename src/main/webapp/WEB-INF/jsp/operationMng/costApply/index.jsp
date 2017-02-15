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
<title>费用申请管理</title>
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
			运营管理
			<small>
				<i class="icon-double-angle-right"></i>
				预付申请管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">申请时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 170px;height:34px;margin-right:40px; margin-left: 5px;">
				<input class="form-control" id="applyStartTime" type="text" placeholder="请输入时间" style="height: 34px;font-size: 14px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 20px;width:39px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 170px;height:34px; margin-right:30px;margin-left: 5px;">
				<input class="form-control" id="applyEndTime" type="text" placeholder="请输入时间" style="height: 34px;font-size: 14px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			
			<label class="title">项目名称：</label>
		    <input id="name" class="form-box" type="text" placeholder="请输入项目名称" style="width:170px;"/>
		    
		</div>
		<div class="searchbox col-xs-12">
		    <label class="title">申请部门：</label>
		    <select id="department" class="form-box" style="width:170px;">
		      <option value="">请选择申请部门</option>
		    </select>
		    
		    <label class="title" style="width:80px;">费用类型：</label>
		    <select id="type" class="form-box" style="width:170px;">
		      <option value="">请选择费用类型</option>
		    </select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="doadd()">新增</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>申请部门</th>
					<th>费用类型</th>
                    <th>项目名称</th>
                    <th>申请时间</th>
                    <th>金额</th>
                    <th>状态</th>
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
					  <h3 id="myModalLabel">新增费用申请</h3>
				     </div>
					<div class="modal-body" style="padding:5px 20px;">
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							  <div class="widget-main">
								  <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>费用类型：</label>
								      <select class="form-control" id="type_add">
								        <option value="">请选择费用类型</option>
								     </select>
								  </div>
								  <hr class="tree"></hr>
								<div class="add-item extra-item">
							     <label class="title"><span class="red">*</span>申请部门：</label>
							     <select class="form-control" id="dep_add">
							      <option value="">请选择申请部门</option>
								</select>
							    </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>申请人：</label>
								     <input class="form-control" id="applyUser_add" type="text" disabled="disabled" style="height: 32px;"/>
								     <input class="form-control" id="applyUserId_add" type="hidden" placeholder="" style="height: 32px;"/>
								  </div>
								 <!--  <hr class="tree"></hr>
								 <div class="add-item extra-item" style="position:relative">
								     <label class="title">申请时间：</label>
								     <div class="input-group input-group-sm w75">
										<input class="form-control" id="applyTime_add" type="text" placeholder="请输入申请时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div> -->
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
									     <label class="title">项目名称：</label>
									     <input class="form-control" id="name_add" type="text" placeholder="请输入项目名称" style="height: 32px;"/>
								 </div>
								
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
							     <label class="title"><span class="red">*</span>金额：</label>
							     	<input class="form-control" id="amount_add" type="text" placeholder="请输入金额" style="height: 32px;"/>
							    </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item" style="position:relative">
								     <label class="title">开始时间：</label>
								     <div class="input-group input-group-sm w75">
										<input class="form-control" id="startTime_add" type="text" placeholder="请输入开始时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>
							     <hr class="tree"></hr>
								 <div class="add-item extra-item" style="position:relative">
								     <label class="title">结束时间：</label>
								     <div class="input-group input-group-sm w75">
										<input class="form-control" id="endTime_add" type="text" placeholder="请输入结束时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title">备注：</label>
								     <input class="form-control" id="remark_add" type="text" placeholder="请输入备注" style="height: 32px;"/>
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
					  <h3 id="myModalLabel">编辑费用申请</h3>
				     </div>
					<div class="modal-body" style="padding:5px 20px;">
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							  <div class="widget-main">
							  <input type="hidden" id="id-hidden">
								  <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>费用类型：</label>
								      <select class="form-control" id="type_edit">
								        <option value="">请选择费用类型</option>
								     </select>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-item">
								     <label class="title" ><span class="red">*</span>申请单号：</label>
								     <input class="form-control" id="billNo" type="text" disabled="disabled" style="height: 32px;"/>
								  </div>
								  <hr class="tree"></hr>	
								<div class="add-item extra-item">
							     <label class="title"><span class="red">*</span>申请部门：</label>
							     <select class="form-control" id="dep_edit">
							      <option value="">请选择申请部门</option>
								</select>
							    </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>申请人：</label>
								     <input class="form-control" id="applyUser_edit" type="text" disabled="disabled" style="height: 32px;"/>
								     <input class="form-control" id="applyUserId_edit" type="hidden" placeholder="" style="height: 32px;"/>
								  </div>
								 <!--  <hr class="tree"></hr>
								 <div class="add-item extra-item" style="position:relative">
								     <label class="title">申请时间：</label>
								     <div class="input-group input-group-sm w75">
										<input class="form-control" id="applyTime_edit" type="text" placeholder="请输入申请时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div> -->
								 
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
									     <label class="title">项目名称：</label>
									     <input class="form-control" id="name_edit" type="text" placeholder="请输入项目名称" style="height: 32px;"/>
								 </div>
								
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
							     <label class="title"><span class="red">*</span>金额：</label>
							     	<input class="form-control" id="amount_edit" type="text" placeholder="请输入金额" style="height: 32px;"/>
							    </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item" style="position:relative">
								     <label class="title">开始时间：</label>
								     <div class="input-group input-group-sm w75">
										<input class="form-control" id="startTime_edit" type="text" placeholder="请输入开始时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>
							     <hr class="tree"></hr>
								 <div class="add-item extra-item" style="position:relative">
								     <label class="title">结束时间：</label>
								     <div class="input-group input-group-sm w75">
										<input class="form-control" id="endTime_edit" type="text" placeholder="请输入结束时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title">备注：</label>
								     <input class="form-control" id="remark_edit" type="text" placeholder="请输入备注" style="height: 32px;"/>
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
					<h3 id="myModalLabel" style="margin:5px;">查看费用申请</h3>
				</div>
				<div class="modal-body" style="height:510px;overflow:auto;">
					<div class="mng" style="min-height:480px;">						
						<div class="table-item">
							<div class="table-itemTit">基本信息</div>
							<!-- 第五列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">费用类型:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="type_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							<!-- 第一列 -->
							<div class="row newrow">
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">申请单号:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="billNo_view" class="form-control no-border"></p>
									</div>
								</div>								
							</div>
							<!-- 第二列 -->
							<div class="row newrow">
							<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">申请部门:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="dep_view" class="form-control no-border"></p>
									</div>
								</div>							
							</div>
							<!-- 第三列 -->
							<div class="row newrow">
							<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">申请人:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="applyUser_view" class="form-control no-border"></p>
									</div>
								</div>																
								</div>								
							</div>	
							<!-- 第四列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">申请时间:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="applyTime_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							
							<!-- 第六列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">项目名称:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="name_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							<!-- 第七列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">金额:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="amount_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							<!-- 第八列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div  style="padding-top:9px;">
										<label class="title">开始时间:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="startTime_view" class="form-control no-border"></p>
									</div>
								</div>								
							</div>	
							<!-- 第九列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div  style="padding-top:9px;">
										<label class="title">结束时间:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="endTime_view" class="form-control no-border"></p>
									</div>
								</div>								
							</div>	
							<!-- 第十列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div  style="padding-top:9px;">
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
			<!-- 查看 结束-->		
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
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
function init(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/costApply/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum","width":"6%"},
		    {data: "departmentName","width":"9%"},
		    {data: "typeName","width":"9%"},
		    {data: "name","width":"20%"},
		    {data: "applyTime","width":"16%"},
		    {data: "amount","width":"10%"},
		    {data: "status","width":"10%"},
		    {data: null,"width":"20%"}],
		    columnDefs: [
				{
					//时间
					targets:4,
					render: function (data, type, row, meta) {
						if(data!=''&& data!=null){
							return jsonDateFormat(data);
						}else{
							return '';
						}
				 	}	       
				},
				{
					 //状态
					 targets:6,
					 render: function (data, type, row, meta) {
						 if(data=='0'){
				        	   return '新建';
				           }
				           if(data=='1'){
				        	   return '部门负责人审核';
				           }
				           if(data=='2'){
				        	   return '财务审核';
				           }
				           if(data=='3'){
				        	   return '总经理审核';
				           }
				           if(data=='4'){
				        	   return '现金会计';
				           }
				           if(data=='5'){
				        	   return '已完成';
				           }
				           if(data=='6'){
				        	   return '已核销';
				           }
				       }	       
				},
		      	{
			    	 //操作栏
			    	 targets: 7,
			    	 render: function (data, type, row, meta) {
			    		 if(row.status=='0'){
		                    return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
		                    	+'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
						        +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
		                }
			    		 else
			    		{
			    			 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
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
		 "sAjaxSource": "${ctx}/operationMng/costApply/getListData" , //获取数据的ajax方法的URL	
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
				 columns: [{ data: "rownum","width":"6%"},
						    {data: "departmentName","width":"9%"},
						    {data: "typeName","width":"9%"},
						    {data: "name","width":"20%"},
						    {data: "applyTime","width":"16%"},
						    {data: "amount","width":"10%"},
						    {data: "status","width":"10%"},
						    {data: null,"width":"20%"}],
						    columnDefs: [
										{
											//时间
											targets:4,
											render: function (data, type, row, meta) {
												if(data!=''&& data!=null){
													return jsonDateFormat(data);
												}else{
													return '';
												}
										 	}	       
										},
										{
											 //状态
											 targets:6,
											 render: function (data, type, row, meta) {
												 if(data=='0'){
										        	   return '新建';
										           }
										           if(data=='1'){
										        	   return '部门负责人审核';
										           }
										           if(data=='2'){
										        	   return '财务审核';
										           }
										           if(data=='3'){
										        	   return '总经理审核';
										           }
										           if(data=='4'){
										        	   return '现金会计';
										           }
										           if(data=='5'){
										        	   return '已完成';
										           }
										           if(data=='6'){
										        	   return '已核销';
										           }
										       }	       
										},
											{
											 //操作栏
											 targets: 7,
											 render: function (data, type, row, meta) {
												 if(row.status=='0'){
										            return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
										            	+'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
												        +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
										        }
												 else
												{
													 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
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
	   /* var status=$.trim($('#status').val());
	   if(status==null || status=='' || status=='-1'){
		   status="";
	   } */
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				startTime : $.trim($('#applyStartTime').val()),
				endTime :$.trim($('#applyEndTime').val()),
				departmentId :$.trim($('#department').val()),
				name :$.trim($('#name').val()),
				type :$('#type').val()
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

function searchInfo(){
	reload();
}
/* 获取申请部门 */
function getDeptList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/costApply/getDeptList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="">请选择申请部门</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	                		}
	            		}
	            	}
	            	$('#department').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
 }

/* 获取申请部门    用于新增 */
function getDeptAddList(depId){
	  $.ajax({  
	        url: '${ctx}/operationMng/costApply/getDeptList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="">请选择申请部门</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	            				if(depId == data.data[i]['id'])
	            				{
	            					html +='<option selected value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	            				}
	            				else
	            				{
	            					html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	            				}
	                		}
	            		}
	            	}
	            	$('#dep_add').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
 }
 
/* 获取申请部门    用于编辑 */
function getDeptEditList(depId){
	  $.ajax({  
	        url: '${ctx}/operationMng/costApply/getDeptList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="">请选择申请部门</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	            				if(depId == data.data[i]['id'])
	            				{
	            					html +='<option selected value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	            				}
	            				else
	            				{
	            					html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	            				}
	                		}
	            		}
	            	}
	            	$('#dep_edit').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
 }
 
/* 获取费用类型 */
function getCostTypeList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/costApply/getCostTypeList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="">请选择费用类型</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	                		}
	            		}
	            	}
	            	$('#type').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
 }
 
/* 获取费用类型    用于新增*/
function getCostTypeAddList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/costApply/getCostTypeList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="">请选择费用类型</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	                		}
	            		}
	            	}
	            	$('#type_add').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
 }
/* 获取费用类型    用于编辑*/
function getCostTypeEditList(type){
	  $.ajax({  
	        url: '${ctx}/operationMng/costApply/getCostTypeList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="">请选择费用类型</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	            				if(type == data.data[i]['id'])
	            				{
	            					html +='<option selected value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	            				}
	            				else
	            				{
	            					html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	            				}
	                			
	                		}
	            		}
	            	}
	            	$('#type_edit').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
 }
$(function(){
	$("#applyStartTime").datetimepicker({
		language: 'cn',
		 format: "yyyy-mm-dd hh:ii",//日期格式
        autoclose: true,//选中之后自动隐藏日期选择框
        todayBtn: true
	});
	$("#applyEndTime").datetimepicker({
		language: 'cn',
		format: "yyyy-mm-dd hh:ii",//日期格式
        autoclose: true,//选中之后自动隐藏日期选择框
        todayBtn: true
	});
	init();
	getDeptList()
	getCostTypeList();
});
//清空
function clear(){
	$('#applyTime_add').val('');
	$('#type_add').val('');
	$('#name_add').val('');
	$('#amount_add').val('');
	$('#startTime_add').val('');
	$('#endTime_add').val('');
	$('#remark_add').val('');
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
	$("#applyTime_add").datetimepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd hh:ii", //日期格式
        todayBtn: true
	});
	$("#startTime_add").datetimepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd hh:ii",//日期格式
        todayBtn: true
	});
	$("#endTime_add").datetimepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd hh:ii",//日期格式
        todayBtn: true
	});
	var a = '${sessionScope.LMS_USER.name}';
	var b = ${sessionScope.LMS_USER.departmentId};
	$('#applyUser_add').val(a);
	getDeptAddList(b);
	getCostTypeAddList();
	$('#applyUserId_add').val(${sessionScope.LMS_USER.id});
	$('#modal-add').modal('show');
}

//保存
function save(){
	var flag="false";
	var dep=$('#dep_add').val();
	var applyUserId=$('#applyUserId_add').val();
	//var applyTime = $('#applyTime_add').val();
	var type=$('#type_add').val();
	var name=$('#name_add').val();
	var amount=$('#amount_add').val();
	var startTime = $('#startTime_add').val();
	var endTime=$('#endTime_add').val();
	var mark=$('#remark_add').val();
	if(dep==''|| dep==null){
		bootbox.alert('申请部门不能为空！');
		return;
	}
	if(applyUserId==''|| applyUserId==null){
		bootbox.alert('申请人不能为空！');
		return;
	}
	
	if(type==''|| type==null || type=='请选择费用类型'){
		bootbox.alert('费用类型不能为空！');
		return;
	}
	if(amount==''|| dep==amount){
		bootbox.alert('金额不能为空！');
		return;
	}
	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该费用申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/costApply/save',
						data : JSON.stringify({
							id : '',
							type :type,
							departmentId :dep,
							applyUserId : applyUserId,
							//applyTime : new Date(applyTime),
							name :name, 
							amount : amount,
							startTime :new Date(startTime),
							endTime :new Date(endTime),
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
	$("#applyTime_edit").datetimepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd hh:ii", //日期格式
        todayBtn: true
	});
	$("#startTime_edit").datetimepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd hh:ii",//日期格式
        todayBtn: true
	});
	$("#endTime_edit").datetimepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd hh:ii",//日期格式
        todayBtn: true
	});
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/costApply/getById/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				console.info(JSON.stringify(data.data));
				$('#id-hidden').val(id);				
				//$("#dep_edit").val(data.data.departmentId);
				$('#billNo').val(data.data.billNo);
				getDeptEditList(data.data.departmentId);
				$("#applyUser_edit").val(data.data.applyUserName); 
				$("#applyUserId_edit").val(data.data.applyUserId); 
				//$("#applyTime_edit").val(format(data.data.applyTime, 'yyyy-MM-dd HH:mm')); 
				//$("#type_edit").val(data.data.type);
				getCostTypeEditList(data.data.type);
				$("#name_edit").val(data.data.name);
				$("#amount_edit").val(data.data.amount);
				if(null != data.data.startTime && "" != data.data.startTime)
				{
					$("#startTime_edit").val(format(data.data.startTime, 'yyyy-MM-dd HH:mm'));
				}
				if(null != data.data.endTime && "" != data.data.endTime)
				{
					$("#endTime_edit").val(format(data.data.endTime, 'yyyy-MM-dd HH:mm'));
				}
				$("#remark_edit").val(data.data.mark);
				$('#modal-edit').modal('show');
				$('#editBtn').show();							
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
	
}
//更新
function saveEdit()
{
	var flag="false";
	var id = $('#id-hidden').val();
	var dep=$('#dep_edit').val();
	var applyUserId=$('#applyUserId_edit').val();
	//var applyTime = $('#applyTime_edit').val();
	var type=$('#type_edit').val();
	var name=$('#name_edit').val();
	var amount=$('#amount_edit').val();
	var startTime = $('#startTime_edit').val();
	var endTime=$('#endTime_edit').val();
	var mark=$('#remark_edit').val();
	if(dep==''|| dep==null){
		bootbox.alert('申请部门不能为空！');
		return;
	}
	if(applyUserId==''|| applyUserId==null){
		bootbox.alert('申请人不能为空！');
		return;
	}
	
	if(type==''|| type==null || type=='请选择费用类型'){
		bootbox.alert('费用类型不能为空！');
		return;
	}
	if(amount==''|| amount==null){
		bootbox.alert('金额不能为空！');
		return;
	}
	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该费用申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/costApply/save',
						data : JSON.stringify({
							id : id,
							type :type,
							departmentId :dep,
							applyUserId : applyUserId,
							//applyTime : new Date(applyTime),
							name :name, 
							amount : amount,
							startTime :new Date(startTime),
							endTime :new Date(endTime),
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
		url : "${ctx}/operationMng/costApply/getById/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				//$('#id-hidden').val(id);				
				$('#billNo_view').html(data.data.billNo);
				$("#dep_view").html(data.data.departmentName);
				//getDeptEditList(data.data.departmentId);
				$("#applyUser_view").html(data.data.applyUserName); 
				//$("#applyUserId_edit").val(data.data.applyUserId); 
				$("#applyTime_view").html(format(data.data.applyTime, 'yyyy-MM-dd HH:mm')); 
				$("#type_view").html(data.data.typeName);
				//getCostTypeEditList(data.data.type);
				$("#name_view").html(data.data.name);
				$("#amount_view").html(data.data.amount);
				$("#startTime_view").html(format(data.data.startTime, 'yyyy-MM-dd HH:mm'));
				$("#endTime_view").html(format(data.data.endTime, 'yyyy-MM-dd HH:mm'));
				$("#mark_view").html(data.data.mark);
				$('#modal-view').modal('show');
				//$('#editBtn').show();							
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
			  message: "确定要提交该费用申请信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'GET',
							url : "${ctx}/operationMng/costApply/submit/"+id,
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
		  message: "确定要删除该费用申请信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/costApply/delete/"+id,
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
</script>

</body>
</html>