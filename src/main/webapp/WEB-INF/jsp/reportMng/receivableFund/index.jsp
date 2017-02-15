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
<title>承运商往来款管理</title>
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
				供应商往来款管理
			</small>
		</h1>
	</div>
	<div class="page-content">
		<div class="searchbox col-xs-12">
			<label class="title" style="float: left;">供应商：</label>
			 <select id="fom_business" class="form-box" style="float: left;width:180px;">	</select>
		    <!-- <input id="invoiceNoSearch" class="form-box" type="text" placeholder="请输入承运商" style="float: left;width:234px;"/> -->
			
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width: 75px;">开始日期：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 180px;height:34px;margin-right:30px; margin-left: 5px;">
				<input class="form-control" id="fundDateStart" type="text" placeholder="请输入时间" style="height: 34px;font-size: 14px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 13px;width:75px;">结束日期</label>
		   <div class="input-group input-group-sm" style="float: left;width: 180px;height:34px; margin-right:30px;margin-left: 5px;">
				<input class="form-control" id="fundDateEnd" type="text" placeholder="请输入时间" style="height: 34px;font-size: 14px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		</div>
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;width:60px;">类型：</label>
		     <select id="fom_fundType" class="form-box" style="float: left;width:180px;">	
							     <option value="">请选择类型</option>
		                         <option value="0">应收款</option>
		                         <option value="1">实收款</option>
							     </select>		    
		    <label class="title" style="float: left;width: 75px;">状态：</label>
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
					<th>供应商</th>
					<th>账款日期</th>
                    <th>款项类型</th>
                    <th>现金金额</th>
                    <th>油卡金额</th>
                    <th>总金额</th>
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
					  <h3 id="myModalLabel">新增供应商往来款信息</h3>
				     </div>
					<div class="modal-body" style="padding:5px 20px;">
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							  <div class="widget-main">
								  <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>供应商：</label>
								     <select id="business_add" class="form-control" style="height: 32px;">	</select>
								      <!-- <input class="form-control" id="business_add" type="text" placeholder="请输入发票号" style="height: 32px;"/> -->
								  </div>
								  <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title"><span class="red">*</span>账款日期：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px; ">
										<input class="form-control" style="font-size: 14px;padding: 5px 4px;" id="fundDate_add" style="height: 32px;" type="text" placeholder="请输入账款日期"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>款项类型：</label>
								      <select id="fundType_add" class="form-control" style="height: 32px;">	
							          <option value="">请选择类型</option>
		                              <option value="0">应收款</option>
		                              <option value="1">实收款</option>
							         </select>								    
								  </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
									  <label class="title"><span class="red">*</span>现金金额：</label>
									  <input class="form-control" id="cashAmount_add" type="text" placeholder="请输入现金金额" style="height: 32px;" onblur="revaildate(this,0);"/>
								 </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
							        <label class="title"><span class="red">*</span>油卡金额：</label>
							     	<input class="form-control" id="oilAmount_add" type="text" placeholder="请输入油卡金额" style="height: 32px;" onblur="revaildate(this,1);"/>
							    </div>
							     <hr class="tree"></hr>
								 <div class="add-item extra-item">
							        <label class="title"><span class="red">*</span>总金额：</label>
							     	<input class="form-control" id="amount_add" type="text" placeholder="请输入总金额" style="height: 32px;" readonly="readonly"/>
							    </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title">备注：</label>
								     <input class="form-control" id="mark_add" type="text" placeholder="请输入备注" style="height: 32px;"/>
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
					  <h3 id="myModalLabel">编辑供应商往来款信息</h3>
				     </div>
					<div class="modal-body" style="padding:5px 20px;">
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							  <div class="widget-main">
							  	 <input type="hidden" id="id-hidden">
								 <div class="add-item extra-item">
								      <label class="title"><span class="red">*</span>供应商：</label>
								       <select id="business_edit" class="form-control" style="height: 32px;">	</select>
								      <!-- <input class="form-control" id="business_edit" type="text" placeholder="请输入发票号" style="height: 32px;"/> -->
								  </div>
								  <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title">账款日期：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px;">
										<input class="form-control"  style="font-size: 14px;padding: 5px 4px;" id="fundDate_edit" type="text" placeholder="请输入账款日期"/>
										<span class="input-group-addon" >
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>款项类型：</label>
								      <select id="fundType_edit" class="form-control" style="height: 32px;">	
							          <option value="">请选择类型</option>
		                              <option value="0">应收款</option>
		                              <option value="1">实收款</option>
							         </select>								    
								  </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
									  <label class="title"><span class="red">*</span>现金金额：</label>
									  <input class="form-control" id="cashAmount_edit" type="text" placeholder="请输入现金金额" style="height: 32px;" onblur="revaildate(this,2);"/>
								 </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
							        <label class="title"><span class="red">*</span>油卡金额：</label>
							     	<input class="form-control" id="oilAmount_edit" type="text" placeholder="请输入油卡金额" style="height: 32px;" onblur="revaildate(this,3);"/>
							    </div>
							     <hr class="tree"></hr>
								 <div class="add-item extra-item">
							        <label class="title"><span class="red">*</span>总金额：</label>
							     	<input class="form-control" id="amount_edit" type="text" placeholder="请输入总金额" style="height: 32px;" readonly="readonly"/>
							    </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title">备注：</label>
								     <input class="form-control" id="mark_edit" type="text" placeholder="请输入备注" style="height: 32px;"/>
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
					<h3 id="myModalLabel" style="margin:5px;">查看供应商往来款信息</h3>
				</div>
				<div class="modal-body" style="height:510px;overflow:auto;">
					<div class="mng" style="min-height:470px;">						
						<div class="table-item">
							<!-- 第一列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">供应商:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
									<!-- <select id="business_view" class="form-control no-border" style="height: 32px;">	</select> -->
										<p id="business_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							<!-- 第二列 -->
							<div class="row newrow">
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">账款日期:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="fundDate_view" class="form-control no-border"></p>
									</div>
								</div>								
							</div>
							<!-- 第三列 -->
							<div class="row newrow">
							<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">款项类型:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="fundType_view" class="form-control no-border"></p>
									</div>
								</div>							
							</div>
							<!-- 第四列 -->
							<div class="row newrow">
							<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">现金金额:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="cashAmount_view" class="form-control no-border"></p>
									</div>
								</div>																
								</div>	
							<!-- 第五列 -->	
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">油卡金额:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="oilAmount_view" class="form-control no-border" ></p>
									</div>
								</div>																
							</div>	
							<!-- 第六列 -->	
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">总金额:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="amount_view" class="form-control no-border" ></p>
									</div>
								</div>																
							</div>	
							<!-- 第七列 -->	
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
		</div>
	</div>
</div>
<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>供应商往来款信息表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>														
					<th>序号</th>
					<th>供应商</th>
					<th>账款日期</th>
                    <th>款项类型</th>
                    <th>现金金额</th>
                    <th>油卡金额</th>
                    <th>总金额</th>
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
		 "sAjaxSource": "${ctx}/reportMng/receivableFund/getListData" , //获取数据的ajax方法的URL							 
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
				    {data: "businessName","width":"14%"},
				    {data: "fundDate","width":"10%"},
				    {data: "fundType","width":"8%"},
				    {data: "cashAmount","width":"8%"},
				    {data: "oilAmount","width":"8%"},
				    {data: "amount","width":"8%"},
				    {data: "status","width":"8%"},
				    {data: "mark","width":"10%"},
				    {data: null,"width":"20%"}],
		    columnDefs: [
				/* {
					//时间
					targets:2,
					render: function (data, type, row, meta) {
						if(data!=''&& data!=null){
							return jsonForDateFormat(data);
						}else{
							return '';
						}
				 	}	       
				}, */{
					//类型
					targets:3,
					render: function (data, type, row, meta) {
						if(data=='0'){
							return '应收款';
						}else{
							return '实收款';
						}
				 	}	       
				},{
					//类型
					targets:7,
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
			    	 targets: 9,
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
		 "sAjaxSource": "${ctx}/reportMng/receivableFund/getListData" , //获取数据的ajax方法的URL	
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
						    {data: "businessName","width":"14%"},
						    {data: "fundDate","width":"10%"},
						    {data: "fundType","width":"8%"},
						    {data: "cashAmount","width":"8%"},
						    {data: "oilAmount","width":"8%"},
						    {data: "amount","width":"8%"},
						    {data: "status","width":"8%"},
						    {data: "mark","width":"10%"},
						    {data: null,"width":"20%"}],
				    columnDefs: [
						/* {
							//时间
							targets:2,
							render: function (data, type, row, meta) {
								if(data!=''&& data!=null){
									return jsonForDateFormat(data);
								}else{
									return '';
								}
						 	}	       
						}, */{
							//类型
							targets:3,
							render: function (data, type, row, meta) {
								if(data=='0'){
									return '应收款';
								}else{
									return '实收款';
								}
						 	}	       
						},{
							//类型
							targets:7,
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
					    	 targets: 9,
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
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				fundDateStart : $.trim($('#fundDateStart').val()),
				fundDateEnd :$.trim($('#fundDateEnd').val()),
				businessId :$.trim($('#fom_business').val()),
				fundType :$.trim($('#fom_fundType').val()),
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
$(function(){
/* 	$("#startTime").datetimepicker({
		language: 'cn',
		 format: "yyyy-mm-dd hh:ii",//日期格式
        autoclose: true,//选中之后自动隐藏日期选择框
        todayBtn: true
	});
	$("#endTime").datetimepicker({
		language: 'cn',
		format: "yyyy-mm-dd hh:ii",//日期格式
        autoclose: true,//选中之后自动隐藏日期选择框
        todayBtn: true
	}); */
	$("#fundDateStart").datetimepicker({
		language: 'cn',
        format: 'yyyy-mm',
        weekStart: 1,  
        autoclose: true,  
        startView: 3,  
        minView: 3,  
        forceParse: false
    });
	$("#fundDateEnd").datetimepicker({
		language: 'cn',
        format: 'yyyy-mm',
        weekStart: 1,  
        autoclose: true,  
        startView: 3,  
        minView: 3,  
        forceParse: false
    });
	init();
	bindbusiness();//绑定承运商
});
function bindbusiness(){
	$.ajax({
		type : 'POST',
		url : "${ctx}/reportMng/receivableFund/getSupplierList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var html ='<option value="">请选择供应商</option>';
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	            		}
	        		}
	        	}
	        	$('#fom_business').html(html);
	        	$('#business_add').html(html);
	        	$('#business_edit').html(html);
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
}
/* 金额验证 */
function revaildate(e, flag) {
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
	var money = $(e).val();
	if (money != null && money != '') {
		if (!reg.test(money)) {
			if (flag == '0') {//预付现金    			
				$('#cashAmount_add').val('');
				$('#amount_add').val($('#oilAmount_add').val());
				bootbox.alert('请输入正确的金额！');
			} else if (flag == '1') {//预付油费
				$('#oilAmount_add').val('');
				$('#amount_add').val($('#cashAmount_add').val());
				bootbox.alert('请输入正确的金额！');
			} else if (flag == '2') {//公里数
				$('#cashAmount_edit').val('');
				$('#amount_edit').val($('#oilAmount_edit').val());
				bootbox.alert('请输入正确的金额！');
			} else if (flag == '3') {//罚款
				$('#oilAmount_edit').val('');
				$('#amount_edit').val($('#cashAmount_edit').val());
				bootbox.alert('请输入正确的金额！');
			} 
		}
	}
}
//清空
function clear(){
	$('#business_add').val('');
	$('#fundDate_add').val('');
	$('#fundType_add').val('');
	$('#cashAmount_add').val('');
	$('#oilAmount_add').val('');
	$('#amount_add').val('');
	$('#mark_add').val('');
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
	$("#fundDate_add").datetimepicker({
		language: 'cn',
        format: 'yyyy-mm',
        weekStart: 1,  
        autoclose: true,  
        startView: 3,  
        minView: 3,  
        forceParse: false
    });
/* 	$("#fundDate_add").datetimepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd hh:ii", //日期格式
        todayBtn: true
	}); */
	$("#cashAmount_add").on('input',function(e){  
		   var a = $(this).val();
		   var b = $("#oilAmount_add").val();
		   $('#amount_add').val(a*1+b*1);
		}); 
	$("#oilAmount_add").on('input',function(e){  
		   var a = $(this).val();
		   var b = $("#cashAmount_add").val();
		   $('#amount_add').val(a*1+b*1);
		});
	$('#modal-add').modal('show');
}

//保存
function save(){
	var flag="false";
	var businessId=$('#business_add').val();
	var fundDate=$('#fundDate_add').val();
	var fundType=$('#fundType_add').val();
	var cashAmount=$('#cashAmount_add').val();
	var oilAmount=$('#oilAmount_add').val();
	var amount=$('#amount_add').val();
	var mark=$('#mark_add').val();
	if(businessId==''|| businessId==null){
		bootbox.alert('请选择供应商！');
		return;
	}
	if(fundDate==''|| fundDate==null){
		bootbox.alert('账款日期不能为空！');
		return;
	}
	
	if(fundType==''|| fundType==null ){
		bootbox.alert('请选择款项类型！');
		return;
	}
	if(cashAmount==''|| cashAmount==null){
		bootbox.alert('现金金额不能为空！');
		return;
	}
	if(oilAmount==''|| oilAmount==null){
		bootbox.alert('油卡金额不能为空！');
		return;
	}
	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该供应商往来款信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/reportMng/receivableFund/save',
						data : JSON.stringify({
							id:0,
							businessId :businessId,
							fundDate : fundDate,
							fundType : fundType,
							cashAmount : cashAmount,
							oilAmount :oilAmount, 
							amount : amount,
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
	$("#fundDate_edit").datetimepicker({
		language: 'cn',
        format: 'yyyy-mm',
        weekStart: 1,  
        autoclose: true,  
        startView: 3,  
        minView: 3,  
        forceParse: false
    });
	/* $("#fundDate_edit").datetimepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd hh:ii", //日期格式
        todayBtn: true
	}); */	
	$("#cashAmount_edit").on('input',function(e){  
		   var a = $(this).val();
		   var b = $("#oilAmount_edit").val();
		   $('#amount_edit').val(a*1+b*1);
		}); 
	$("#oilAmount_edit").on('input',function(e){  
		   var a = $(this).val();
		   var b = $("#cashAmount_edit").val();
		   $('#amount_edit').val(a*1+b*1);
		});
	$.ajax({
		type : 'GET',
		url : "${ctx}/reportMng/receivableFund/getDetailData/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				$('#id-hidden').val(id);				
				$('#business_edit').val(data.data.businessId);
				$('#fundDate_edit').val(data.data.fundDate);			
				$("#fundType_edit").val(data.data.fundType); 
				$("#cashAmount_edit").val(data.data.cashAmount);
				$("#oilAmount_edit").val(data.data.oilAmount);
				$("#amount_edit").val(data.data.amount);
				$("#mark_edit").val(data.data.mark);				
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
	var businessId=$('#business_edit').val();
	var fundDate=$('#fundDate_edit').val();
	var fundType=$('#fundType_edit').val();
	var cashAmount=$('#cashAmount_edit').val();
	var oilAmount=$('#oilAmount_edit').val();
	var amount=$('#amount_edit').val();
	var mark=$('#mark_edit').val();
	if(businessId==''|| businessId==null){
		bootbox.alert('请选择供应商！');
		return;
	}
	if(fundDate==''|| fundDate==null){
		bootbox.alert('账款日期不能为空！');
		return;
	}
	
	if(fundType==''|| fundType==null ){
		bootbox.alert('请选择款项类型！');
		return;
	}
	if(cashAmount==''|| cashAmount==null){
		bootbox.alert('现金金额不能为空！');
		return;
	}
	if(oilAmount==''|| oilAmount==null){
		bootbox.alert('油卡金额不能为空！');
		return;
	}
	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该承运商往来款信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/reportMng/receivableFund/save',
						data : JSON.stringify({
							id : id,
							businessId :businessId,
							fundDate :fundDate,
							fundType : fundType,
							cashAmount : cashAmount,
							oilAmount :oilAmount, 
							amount :amount, 
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
		url : "${ctx}/reportMng/receivableFund/getDetailData/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				//$('#id-hidden').val(id);	
				$('#business_view').html(data.data.businessName);
				$('#fundDate_view').html(data.data.fundDate);
				if(data.data.fundType=='0'){
					$("#fundType_view").html('应付款'); 
				}else if(data.data.fundType=='1'){
					$("#fundType_view").html('实收款'); 
				}else{
					$("#fundType_view").html(''); 
				}
				$("#cashAmount_view").html(data.data.cashAmount); 
				$("#oilAmount_view").html(data.data.oilAmount); 
				$("#amount_view").html(data.data.amount);
				$("#mark_view").html(data.data.mark);
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
			  message: "确定要提交该供应商往来款信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'GET',
							url : "${ctx}/reportMng/receivableFund/submit/"+id,
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
		  message: "确定要删除该供应商往来款信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/reportMng/receivableFund/delete/"+id,
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

/* 打印功能 */
function printInfo(){
	   var date = new Date();
       var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
    /*    var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
       var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
       var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
       var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds(); */
       var localTime= date.getFullYear() + "-" + month /* + "-" + day+ " " + hours + ":" + minutes + ":" + seconds */;
	   var html="";
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/reportMng/receivableFund/getPrintData",
			data : JSON.stringify({
				fundDateStart : $.trim($('#fundDateStart').val()),
				fundDateEnd :$.trim($('#fundDateEnd').val()),
				businessId :$.trim($('#fom_business').val()),
				fundType :$.trim($('#fom_fundType').val()),
				status :$('#fom_status').val()
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {					
					if(data.data.length>0){
						for(var i=0;i<data.data.length;i++){
							data.data[i]["rownum"]=i+1;
							if(data.data[i]["businessName"]==null || data.data[i]["businessName"]==''){
								data.data[i]["businessName"]=''; 
							 }
							if(data.data[i]["fundType"]==null || data.data[i]["fundType"]==''){
								data.data[i]["fundType"]=''; 
								data.data[i]["fundTypeName"]=''; 
							 }else if(data.data[i]["fundType"]=='0'){
								 data.data[i]["fundTypeName"]='应收款';  
							 }else{
								 data.data[i]["fundTypeName"]='实收款';  
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
							    +'<td>'+data.data[i]["businessName"]+'</td>'
							    +'<td>'+data.data[i]["fundDate"]+'</td>'
							    +'<td>'+data.data[i]["fundType"]+'</td>'
							    +'<td>'+data.data[i]["cashAmount"]+'</td>'
							    +'<td>'+data.data[i]["oilAmount"]+'</td>'
							    +'<td>'+data.data[i]["amount"]+'</td>'
							    +'<td>'+data.data[i]["status"]+'</td>'
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
	   var fundDateStart=$('#fundDateStart').val();
	   var fundDateEnd=$('#fundDateEnd').val();
	   var businessId=$('#fom_business').val();
	   var fundType=$('#fom_fundType').val();
	   var status=$('#fom_status').val();
	   var form = $('<form action="${ctx}/reportMng/receivableFund/getExportData" method="POST"></form>');
	   var fundDateStartInput = $('<input id="fundDateStart" name="fundDateStart" value="'+fundDateStart+'" type="hidden" />');
	   var fundDateEndInput = $('<input id="fundDateEnd" name="fundDateEnd" value="'+fundDateEnd+'" type="hidden" />');
	   var fundTypetInput = $('<input id="fundType" name="fundType" value="'+fundType+'" type="hidden" />');
	   var statustInput = $('<input id="status" name="status" value="'+status+'" type="hidden" />');
	   var businessIdInput = $('<input id="businessId" name="businessId" value="'+businessId+'" type="hidden" />');	   
	   form.append(fundDateStartInput);
	   form.append(fundDateEndInput);
	   form.append(fundTypetInput);
	   form.append(businessIdInput);
	   form.append(statustInput);
	   $('body').append(form);
	   form.submit();
}
</script>

</body>
</html>