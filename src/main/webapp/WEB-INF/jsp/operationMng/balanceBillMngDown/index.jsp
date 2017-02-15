
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->

<style type="text/css">
	/* @media print{
	.Noprint{DISPLAY:none;}
	.PageNext{PAGE-BREAK-AFTER:always}	
	} */
	/* @media print{
	img{display:none;}
	} */
	</style>
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			财务管理
			<small>
				<i class="icon-double-angle-right"></i>
				下游对账管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title" style="float: left;height: 34px;line-height: 34px;">接单时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 200px;margin-right:15px; margin-left: 2px;">
				<input class="form-control" id="form_startTime" type="text" placeholder="请输入开始时间" style="height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 20px;width: 25px;margin-left: 20px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 200px;margin-right:19px;margin-left: 2px;">
				<input class="form-control" id="form_endTime" type="text" placeholder="请输入结束时间" style="height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			<label class="title" style="width:80px;">承运商：</label>
		    <select id="form_outSourcingId" class="form-box">
		    </select>
		</div>
		<div class="searchbox col-xs-12">
		    <label class="title">调度单号：</label>
		     <input id="form_scheduleBillNo" class="form-box" type="text" placeholder="请输入调度单号" style="width:200px;"/>
		    <label class="title" >状态：</label>
		    <select id="form_status" class="form-box" style="width:200px;">
		      <option value="">请选择状态</option>
		      <option value="0">新建</option>
		      <option value="1">已确认</option>
		    </select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn m-lr5" onclick="doprint()">打印</a>
			<a class="itemBtn m-lr5" onclick="doexport()">导出</a>
			<!-- <a class="itemBtn" onclick="doadd()">新增</a> -->
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>车队名称</th>
					<th>调度单号</th>
                    <th>台数</th>
                    <th>结算总金额</th>                  
                    <th>状态</th>
                    <th>调度时间</th> 
                    <th>确认时间 </th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 编辑对账信息-->
			<div class="modal fade" id="modal-edit" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="updateCancle()">×</button>
						<h3>编辑对账信息</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>台数：</label>
								     <input class="form-control" id="carCount" type="text" placeholder="请输入台数"  disabled="disabled"/>
								     <input class="form-control" id="id-hidden" type="hidden"/>
								    </div>
							  		<!-- <hr class="tree"></hr>
							  		<div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>公里数：</label>
								     <input class="form-control" id="distance" type="text" placeholder="请输入公里数" onChange="changenumb(this,'1');"/>
								    </div>
								    <hr class="tree"></hr>
							  		<div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>结算方式：</label>
								     <select id="balanceType" class="form-control" onChange="changenumb(this,'2');">
		                             <option value="">请选择结算方式</option>
		                             <option value="0">单价模式</option>
		                             <option value="1">公里数模式</option>
		                             <option value="2">总价模式</option>
		                             </select>
								    </div> -->
								    <hr class="tree"></hr>
							  		<div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>驳运金额：</label>
								     <input class="form-control" id="transportAmount" type="text" placeholder="请输入驳运金额" onChange="changenumb(this,'1');"/>
								    </div>
								    <hr class="tree"></hr>
							  		<div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>油费结算比率：</label>
								     <input class="form-control" id="oilBalanceRatio" type="text" placeholder="请输入油费结算比率" onChange="changenumb(this,'2');"/>
								    </div>
								    <hr class="tree"></hr>
							  		<div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>总油费：</label>
								     <input class="form-control" id="oilAmount" type="text" placeholder="请输入总油费" disabled="disabled"/>
								    </div>
								    <hr class="tree"></hr>
							  		<div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>结算总金额：</label>
								     <input class="form-control" id="balanceAmount" type="text" placeholder="请输入结算总金额" disabled="disabled"/>
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-itemSec">
									     <label class="title">备注：</label>
									     <input class="form-control" id="remark" type="text" placeholder="请输入备注"/>
									 </div>
							    	<hr class="tree"></hr>
									 <div class="add-item-btn dis-block" id="editBtn">
									    <a class="add-itemBtn btnOk" onclick="update()">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="updateCancle()">取消</a>
									  </div>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
			<!-- 查看对账信息-->
			<div class="modal fade" id="modal-shedeinfo" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">对账信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="mng">
		   <!-- <div class="table-tit">编辑调度单</div> -->
		   <input  type="hidden" id="listlength"/>
		   <div class="table-item">
		     <div class="table-itemTit">基本信息</div>
		     <!-- 第一列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>承运商名称:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="carTrackName_view" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>调度单号:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="scheduleBillNo_view" class="form-control no-border"></p>
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
			          <p id="carCount_view" class="form-control no-border"></p>
			       </div>
		       </div>
		       <!-- <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>公里数:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			         <p id="distance_view" class="form-control no-border"></p>
			       </div>
		       </div> -->
		     </div>
		     <!-- 第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>驳运余额:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="transportAmount_view" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>结算油费:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			         <p id="oilAmount_view" class="form-control no-border"></p>
			       </div>
		       </div> 
		     </div>
		     <!-- 第三列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label >结算总金额:</label>
			       </div>
		       </div>
		       <div class="col-xs-9">
			       <div class="form-contr">
			          <p id="balanceAmount_view" class="form-control no-border"></p>
			       </div>
		       </div>		     
		     </div>
		     <!--设置商品车详细信息-->
		     <div class="row row-btn-tit" id="carDetail">
		        <div class="col-xs-2 pd-2">
			       <div class="row-tit">
			                           详细信息
			       </div>
		       </div>
		       <div class="detailList col-xs-10"></div>
		     </div>
		     
		     
		     <!-- 操作按钮栏 -->
		     <div class="row newrow">
		       <div class="col-xs-5"></div>
		       <div class="col-xs-2">
			       <div class="form-contr">
			          <a class="backbtn" onclick="doback();"><i class="icon-undo" style="display: inline-block;width: 20px;"></i>关闭</a>
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
<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>对账信息表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>
		            <th>序号</th>
					<th>车队名称</th>
					<th>调度单号</th>
                    <th>台数</th>
                    <th>结算总金额</th>                  
                    <th>状态</th>
                    <th>调度时间</th> 
                    <th>确认时间 </th>
                    
		      </tr>
		    </thead>
		    <tbody>
		    </tbody>
		  </table>
		  <div id="footerInfo"><h3>盐城辉宇物流有限公司  制</h3></div>
	  </div>
</div>

<!-- 打印 -->
<div class="printTable" id="printdetilTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfos">
				<h2>对账明细信息表</h2>
				<p id="localTimes" style="text-align: right;"></p>
				<!-- 第一列 -->
		     <div class="row newrowSec">
		       <div class="col-xs-2 pd-2">
			       <div class="lab-tit">
			          <label>承运商:</label>
			       </div>
		       </div>
		       <div class="col-xs-4">
			       <div class="form-contr">
			          <p id="carTrackName_prt" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-2 pd-2">
			       <div class="lab-tit">
			          <label>调度单号:</label>
			       </div>
		       </div>
		       <div class="col-xs-4">
			       <div class="form-contr">
			          <p id="scheduleBillNo_prt" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第二列 -->
		     <div class="row newrowSec">
		       <div class="col-xs-2 pd-2">
			       <div class="lab-tit">
			          <label>台&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;数:</label>
			       </div>
		       </div>
		       <div class="col-xs-4">
			       <div class="form-contr">
			          <p id="carCount_prt" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-2 pd-2">
			       <div class="lab-tit">
			          <label>驳运余额:</label>
			       </div>
		       </div>
		       <div class="col-xs-4">
			       <div class="form-contr">
			          <p id="transportAmount_prt" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第二列 -->
		     <div class="row newrowSec">
		       <div class="col-xs-2 pd-2">
			       <div class="lab-tit">
			          <label>结算油费:</label>
			       </div>
		       </div>
		       <div class="col-xs-4">
			       <div class="form-contr">
			         <p id="oilAmount_prt" class="form-control no-border"></p>
			       </div>
		       </div> 
		        <div class="col-xs-2 pd-2">
			       <div class="lab-tit">
			          <label >结算总额:</label>
			       </div>
		       </div>
		       <div class="col-xs-4">
			       <div class="form-contr">
			          <p id="balanceAmount_prt" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		    </div>
		    <!--设置商品车详细信息-->
		     <div class="row row-btn-titSec" id="carDetails">
		        <div class="col-xs-2 pd-2">
			       <div class="row-titSec">
			                           详细信息
			       </div>
		       </div>
		       <div class="detailList col-xs-10"></div>
		     </div>
		  <!-- <table id="myprintDataTable" class="table myDataTable">
		    <thead>
		      <tr>
		            <th>明细信息</th>					
		      </tr>
		    </thead>
		    <tbody>
		    </tbody>
		  </table> -->
		  <div id="footerInfos"><h3>盐城辉宇物流有限公司  制</h3></div>
	 
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
<script type="text/javascript">
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/balanceBillMngDown/getListData" , //获取数据的ajax方法的URL							 
		 ordering: false,	
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
		    {data: "carTrackName","width":"10%"},
		    {data: "scheduleBillNo","width":"10%"},
		    {data: "carCount","width":"8%"},
		    {data: "balanceAmount","width":"8%"},
		    {data: "status","width":"8%"},
		    {data: "insertTime","width":"10%"},
		    {data: "verifyTime","width":"10%"},	    
		    {data: null,"width":"15%"}],
		    columnDefs: [
					{
						//时间
						 targets:6,
						 render: function (data, type, row, meta) {
					           if(data!=''&&data!=null){
									 return jsonDateFormat(data);
								 }else{
									 return '';
								 }
					       }	       
					},
					{
						//时间
						 targets:7,
						 render: function (data, type, row, meta) {
							 if(data!=''&&data!=null){
								 return jsonDateFormat(data);
							 }else{
								 return '';
							 }
					       }	       
					},					
					{
					 //状态
					 targets:5,
					 render: function (data, type, row, meta) {
				           if(data=='0'){
				        	   return '新建';
				           }
				           if(data=='1'){
				        	   return '已确认';
				           }else{
				        	   return '';
				           }
				       }	       
				},
				{
			    	 //操作栏
			    	 targets: 8,
			    	 render: function (data, type, row, meta) {
			    		 if(row.status=='0'){
			    			 return '<a class="table-edit" data-id="'+row.id+'" onclick="doedit(this)">编辑</a>'
	                           +'<a class="table-edit" data-id="'+row.id+'" onclick="dosubmit(this)">确认</a>';
			    		 }else{
			    			 return '<a class="table-edit" data-id="'+row.id+'" onclick="doshow(this)">查看</a>'
			    			 +'<a class="table-delete" style="width:65px;" data-id="'+row.id+'" onclick="dodetprint(this)">明细打印</a>';
	                          
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
		 "sAjaxSource": "${ctx}/operationMng/balanceBillMngDown/getListData" , //获取数据的ajax方法的URL	
		 ordering: false,	
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
						    {data: "carTrackName","width":"10%"},
						    {data: "scheduleBillNo","width":"10%"},
						    {data: "carCount","width":"8%"},
						    {data: "balanceAmount","width":"8%"},
						    {data: "status","width":"8%"},
						    {data: "insertTime","width":"10%"},
						    {data: "verifyTime","width":"10%"},	    
						    {data: null,"width":"15%"}],
						    columnDefs: [
									{
										//时间
										 targets:6,
										 render: function (data, type, row, meta) {
									           if(data!=''&&data!=null){
													 return jsonDateFormat(data);
												 }else{
													 return '';
												 }
									       }	       
									},
									{
										//时间
										 targets:7,
										 render: function (data, type, row, meta) {
											 if(data!=''&&data!=null){
												 return jsonDateFormat(data);
											 }else{
												 return '';
											 }
									       }	       
									},					
									{
									 //状态
									 targets:5,
									 render: function (data, type, row, meta) {
								           if(data=='0'){
								        	   return '新建';
								           }
								           if(data=='1'){
								        	   return '已确认';
								           }else{
								        	   return '';
								           }
								       }	       
								},
								{
							    	 //操作栏
							    	 targets: 8,
							    	 render: function (data, type, row, meta) {
							    		 if(row.status=='0'){
							    			 return '<a class="table-edit" data-id="'+row.id+'" onclick="doedit(this)">编辑</a>'
					                           +'<a class="table-edit" data-id="'+row.id+'" onclick="dosubmit(this)">确认</a>';
							    		 }else{
							    			 return '<a class="table-edit" data-id="'+row.id+'" onclick="doshow(this)">查看</a>'
							    			 +'<a class="table-delete" style="width:65px;" data-id="'+row.id+'" onclick="dodetprint(this)">明细打印</a>';
					                          
							    		 }
						                    
						                }	       
						    	}
						      ],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	$("#form_startTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#form_endTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	init();
	getOutSourcing();
});
/* 承运商绑定 */
function getOutSourcing(){
	$.ajax({  
        url: '${ctx}/basicSetting/trackMng/getOutSourcingList',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: '',
        success: function (data) {
        	var html ='<option value="">请选择承运商</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		/* console.log(JSON.stringify(data.data)); */
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                		}
            		}
            	}
            	$('#form_outSourcingId').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}
/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var status=$.trim($('#form_status').val());
	   if(status==null || status=='' || status=='-1'){
		   status="";
	   }
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				startTime : $.trim($('#form_startTime').val()),
				endTime :$.trim($('#form_endTime').val()),
				outSourcingId :$.trim($('#form_outSourcingId').val()),
				scheduleBillNo :$.trim($('#form_scheduleBillNo').val()),
				status :$.trim(status)
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

/* 提交调度单 */
function dosubmit(e){
	var flag="false";
	var id=$(e).attr("data-id");
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要确认该对账信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/balanceBillMngDown/sure/"+id,
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								 bootbox.confirm_alert({ 
									  size: "small",
									  message: "确认成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
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
	})
};

/* 查看详细调度信息 */
function doshow(e){
	//detailList
	$('.detailList').remove();
	var id=$(e).attr("data-id");
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/balanceBillMngDown/getDetailPrintData/"+id,
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);				
				$('#modal-shedeinfo').modal('show');
				$('#carTrackName_view').html(data.data['carTrackName']);
				$('#scheduleBillNo_view').html(data.data['scheduleBillNo']);
				$('#transportAmount_view').html(data.data['transportAmount']);
				$('#oilAmount_view').html(data.data['oilAmount']);
				$('#carCount_view').html(data.data['carCount']);
				$('#balanceAmount_view').html(data.data['balanceAmount']);
				//console.log(JSON.stringify(data.data));
				var detailListHtml="";	
				 var carHtml="";
				if(data.data['scheduleList'].length>0){										
					for(var i=0;i<data.data['scheduleList'].length;i++){	
						var carInfo=data.data['scheduleList'][i]['carList'];
						var carShopName=data.data['scheduleList'][i]['carShopName'];
						var carHtmlItem="";
						/* 车辆信息 */
						if(carInfo!=null && carInfo.length>0){
							for(var j=0;j<carInfo.length>0;j++){
								var m=j+1;								
								carHtmlItem+='<tr><td>'+m+'</td><td>'+carInfo[j]['waybillNo']+'</td><td>'+carInfo[j]['brand']+'</td><td>'+carInfo[j]['model']+'</td>'
								   +'<td>'+carInfo[j]['vin']+'</td><td>'+carInfo[j]['color']+'</td><td>'+carInfo[j]['engineNo']+'</td>'
								   +'<td>'+jsonDateFormat(carInfo[j]['insertTime'])+'</td>'
								   +'</tr>';								
							}
							carHtml='<table class="carList table table-striped table-bordered table-hover">'
						        +'<thead><tr><th>序号</th><th>运单编号</th><th>品牌</th><th>车型</th><th>车架号</th><th>颜色</th><th>发动机号</th><th>入库时间</th></tr></thead>'
						        +'<tbody>'+carHtmlItem+'</tbody></table>'; 
						}else{
							carHtmlItem='<tr><td colspan="7">暂无车辆信息</td></tr>'
							carHtml='<table class="carList table table-striped table-bordered table-hover">'
						        +'<thead><tr><th>序号</th><th>运单编号</th><th>品牌</th><th>车型</th><th>车架号</th><th>颜色</th><th>发动机号</th><th>入库时间</th></tr></thead>'
						        +'<tbody>'+carHtmlItem+'</tbody></table>';
						}	
					if(data.data['scheduleList'][i]['status']=='0'){
						data.data['scheduleList'][i]['status']='未完成';
					}else{data.data['scheduleList'][i]['status']='已完成';}
					if(data.data['scheduleList'][i]['carShopId']!=null && data.data['scheduleList'][i]['carShopId']!=''){
						detailListHtml+='<div class="border-b-ff9a00 detailList" id="detailList'+i+'">'
							  +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>经销单位:</label></div></div>'
				              +'<div class="col-xs-5"><div class="form-contr"><p class="carShopId-item form-control">'+data.data['scheduleList'][i]['carShopName']+'</p></div></div>'
				              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>数量:</label></div></div>'
				              +'<div class="col-xs-5"><div class="form-contr"><p class="amount-item form-control">'+data.data['scheduleList'][i]['amount']+'</p></div></div></div>'
				              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>详细指令:</label></div></div>'
				              +'<div class="col-xs-5"><div class="form-contr"><p class="detailMark-item form-control">'+data.data['scheduleList'][i]['mark']+'</p></div></div>'
				              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>状态:</label></div></div>'
				              +'<div class="col-xs-5"><div class="form-contr"><p class="detailMark-item form-control">'+data.data['scheduleList'][i]['status']+'</p></div></div></div>'
				              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>车辆信息:</label></div></div>'
				              +'<div class="col-xs-11"><div class="newCarDetail-item">'+carHtml+'</div></div></div>';
					}else{
						detailListHtml+='<div class="border-b-ff9a00 detailList" id="detailList'+i+'">'
							  +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>经销单位:</label></div></div>'
				              +'<div class="col-xs-5"><div class="form-contr"><p class="carShopId-item form-control">二手车</p></div></div>'
				              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>数量:</label></div></div>'
				              +'<div class="col-xs-5"><div class="form-contr"><p class="amount-item form-control">'+data.data['scheduleList'][i]['amount']+'</p></div></div></div>'
				              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>详细指令:</label></div></div>'
				              +'<div class="col-xs-5"><div class="form-contr"><p class="detailMark-item form-control">'+data.data['scheduleList'][i]['mark']+'</p></div></div>'
				              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>状态:</label></div></div>'
				              +'<div class="col-xs-5"><div class="form-contr"><p class="detailMark-item form-control">'+data.data['scheduleList'][i]['status']+'</p></div></div></div>'
				              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>车辆信息:</label></div></div>'
				              +'<div class="col-xs-11"><div class="newCarDetail-item">'+carHtml+'</div></div></div>';
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
	//location.href="${ctx}/operationMng/scheduleMng/detail/"+scheduleBillNo;
}

/* 编辑对账信息 */
function doedit(e){
	var id=$(e).attr("data-id");
	//location.href="${ctx}/operationMng/scheduleMng/edit/"+scheduleBillNo;
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/balanceBillMngDown/getDetailData/"+id,
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#carCount').val(data.data.carCount);
				$('#transportAmount').val(data.data.transportAmount);
				$('#oilAmount').val(data.data.oilAmount);
				$('#oilBalanceRatio').val(data.data.oilBalanceRatio);
				$('#balanceAmount').val(data.data.balanceAmount);
				$('#remark').val(data.data.mark);
				$('#modal-edit').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	});
}
function updateCancle(){
	clear();
	$('#modal-edit').modal('hide');
}
/* 数据重置 */
function clear(){
	$('#id-hidden').val('');
	$('#carCount').val('');
	$('#distance').val('');
	$('#balanceType').val('');
	$('#balanceAmount').val('');
	/* $('#parentName').find("option[value='-1']").attr("selected",true); */
	$('#remark').val('');
}
/**台数、公里数、结算方式变化获取总金额**/
function changenumb(e,type){
	var transportAmount='';
	var oilBalanceRatio='';
	var oilAmount='';
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
	if(type==1){
		transportAmount=$(e).val();
		oilBalanceRatio=$('#oilBalanceRatio').val();
		if(transportAmount==''||transportAmount==null){
			bootbox.alert('驳运金额不能为空，请输入数值');	
			return;
		}else if(!reg.test(transportAmount)){
			bootbox.alert('请正确填写驳运金额！');
			return;
		}
	}if(type==2){
		oilBalanceRatio=$(e).val();
		transportAmount=$('#transportAmount').val();
		if(oilBalanceRatio==''||oilBalanceRatio==null){
			bootbox.alert('油费结算比率不能为空，请输入数值');	
			return;
		}else if(isNaN(oilBalanceRatio)){
			bootbox.alert('请正确填写油费结算比率！');
			return;
		}
	}
	oilAmount=(transportAmount*oilBalanceRatio)/100;
	var balanceAmount=transportAmount*1+(oilAmount.toFixed(2)*1);	
	var oilAmounts=oilAmount+"";
	var balanceAmounts=balanceAmount+"";
	//console.info(oilAmounts.split(".")[1]);
	if(oilAmounts.split(".")[1]!=undefined&&oilAmounts.split(".")[1].length>2){
		$('#oilAmount').val(oilAmount.toFixed(2));	
	}else{
		$('#oilAmount').val(oilAmount);	
	}	
	if(balanceAmounts.split(".")[1]!=undefined&&balanceAmounts.split(".")[1].length>2){
		$('#balanceAmount').val(balanceAmount.toFixed(2));	
	}else{
		$('#balanceAmount').val(balanceAmount);	
	}
	//console.info($(e).val());
}
/* 更新 */
function update(){
	var id=$('#id-hidden').val();
	var carCount=$('#carCount').val();
	var transportAmount=$('#transportAmount').val();
	var oilBalanceRatio=$('#oilBalanceRatio').val();
	var oilAmount=$('#oilAmount').val();
	var balanceAmount=$('#balanceAmount').val();
	var remark=$('#remark').val();
	var menusList={};
	var obj={};
	var objs=[];
	if(transportAmount==''|| transportAmount==null){
		bootbox.alert('驳运金额不能为空！');
		return;
	}
	if(oilBalanceRatio==''|| oilBalanceRatio==null){
		bootbox.alert('油费结算比率不能为空！');
		return;
	}
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要修改该对账信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/balanceBillMngDown/update',
						data : JSON.stringify({
							id:id,
							carCount : carCount,
							transportAmount : transportAmount,
							oilBalanceRatio : oilBalanceRatio,
							oilAmount : oilAmount,
							balanceAmount : balanceAmount,
							mark : remark
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

function doback(){	 
	 $('#modal-shedeinfo').modal('hide');
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
	   var scheduleBillNo=$('#form_scheduleBillNo').val();
	   var outSourcingId=$('#form_outSourcingId').val();
	   var startTime=$('#form_startTime').val();
	   var endTime=$('#form_endTime').val();
	   var status=$('#form_status').val();
					  $.ajax({
						    type : 'POST',
							url : "${ctx}/operationMng/balanceBillMngDown/getPrint",
							data : JSON.stringify({
								outSourcingId : outSourcingId,
								scheduleBillNo : scheduleBillNo,
								startTime : startTime,
								endTime : endTime,
								status : status
							}),
							contentType : "application/json;charset=UTF-8",
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {					
									if(data.data.length>0){
										for(var i=0;i<data.data.length;i++){
											    data.data[i]["rownum"]=i+1;											    
											     if(data.data[i]["status"]=='0'){
											    	 data.data[i]["status"]='新建'; 
										         }else{
										        	 data.data[i]["status"]='已确认';
										         }
											     if(data.data[i]["carTrackName"]=='' || data.data[i]["carTrackName"]==null){
											    	 data.data[i]["carTrackName"]='';
											     }
											     if(data.data[i]["scheduleBillNo"]=='' || data.data[i]["scheduleBillNo"]==null){
											    	 data.data[i]["scheduleBillNo"]='';
											     }
											     if(data.data[i]["carCount"]=='' || data.data[i]["carCount"]==null){
											    	 data.data[i]["carCount"]='';
											     }
											     if(data.data[i]["balanceAmount"]=='' || data.data[i]["balanceAmount"]==null){
											    	 data.data[i]["balanceAmount"]='';
											     }							    
											     if(data.data[i]["insertTime"]=='' || data.data[i]["insertTime"]==null){
											    	 data.data[i]["insertTime"]='';
											     }else{
											    	 data.data[i]["insertTime"]=jsonDateFormat(data.data[i]["insertTime"]);
											     }
											     if(data.data[i]["verifyTime"]=='' || data.data[i]["verifyTime"]==null){
											    	 data.data[i]["verifyTime"]='';
											     }else{
											    	 data.data[i]["verifyTime"]=jsonDateFormat(data.data[i]["verifyTime"]);
											     }							     
												html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
												 +'<td>'+data.data[i]["carTrackName"]+'</td>'
											    +'<td>'+data.data[i]["scheduleBillNo"]+'</td>'							
											    +'<td>'+data.data[i]["carCount"]+'</td>'
											    +'<td>'+data.data[i]["balanceAmount"]+'</td>'
											    +'<td>'+data.data[i]["status"]+'</td>'
											    +'<td>'+data.data[i]["insertTime"]+'</td>'
											    +'<td>'+data.data[i]["verifyTime"]+'</td>'
											    +'</tr>';	
										      
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
	$('#printdetilTable').hide();
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
	$('#printdetilTable').hide();
	$("#printTable").html(html); 
 }

/* 导出 */
function doexport()
{
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要导出对账信息?", 
		  callback: function(result){
			  if(result){
				  var scheduleBillNo=$('#form_scheduleBillNo').val();
				   var outSourcingId=$('#form_outSourcingId').val();
				   var startTime=$('#form_startTime').val();
				   var endTime=$('#form_endTime').val();
				   var status=$('#form_status').val();
				   var form = $('<form action="${ctx}/operationMng/balanceBillMngDown/export" method="post"></form>');
				   var scheduleBillNoInput = $('<input id="scheduleBillNo" name="scheduleBillNo" value="'+scheduleBillNo+'" type="hidden" />');
				   var outSourcingIdInput = $('<input id="outSourcingId" name="outSourcingId" value="'+outSourcingId+'" type="hidden" />');
				   var startTimeInput = $('<input id="startTime" name="startTime" value="'+startTime+'" type="hidden" />');
				   var endTimeInput = $('<input id="endTime" name="endTime" value="'+endTime+'" type="hidden" />');
				   var statusInput = $('<input id="status" name="status" value="'+status+'" type="hidden" />');
				   form.append(scheduleBillNoInput);
				   form.append(statusInput);
				   form.append(startTimeInput);
				   form.append(endTimeInput);
				   form.append(outSourcingIdInput);
				   $('body').append(form);
				   form.submit();
			  }
		  }
		})
	  
}
function dodetprint(e){
	var id=$(e).attr("data-id");
	 var date = new Date();
     var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
     var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
     var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
     var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
     var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
     var localTime= date.getFullYear() + "-" + month + "-" + day+ " " + hours + ":" + minutes + ":" + seconds;
	   var html="";
					  $.ajax({
						    type : 'GET',
							url : "${ctx}/operationMng/balanceBillMngDown/getDetailPrintData/"+id,
							contentType : "application/json;charset=UTF-8",
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {	
									if(data.data!=null){
										$('#carTrackName_prt').html(data.data['carTrackName']);
										$('#scheduleBillNo_prt').html(data.data['scheduleBillNo']);
										$('#transportAmount_prt').html(data.data['transportAmount']);
										$('#oilAmount_prt').html(data.data['oilAmount']);
										$('#carCount_prt').html(data.data['carCount']);
										$('#balanceAmount_prt').html(data.data['balanceAmount']);
										var detailListHtml="";	
										 var carHtml="";
										if(data.data['scheduleList'].length>0){										
											for(var i=0;i<data.data['scheduleList'].length;i++){	
												var carInfo=data.data['scheduleList'][i]['carList'];
												var carShopName=data.data['scheduleList'][i]['carShopName'];
												var carHtmlItem="";
												/* 车辆信息 */
												if(carInfo!=null && carInfo.length>0){
													for(var j=0;j<carInfo.length>0;j++){
														var m=j+1;								
														carHtmlItem+='<tr><td>'+m+'</td><td>'+carInfo[j]['waybillNo']+'</td><td>'+carInfo[j]['brand']+'</td><td>'+carInfo[j]['model']+'</td>'
														   +'<td>'+carInfo[j]['vin']+'</td><td>'+carInfo[j]['color']+'</td><td>'+carInfo[j]['engineNo']+'</td>'
														   +'<td>'+jsonDateFormat(carInfo[j]['insertTime'])+'</td>'
														   +'</tr>';								
													}
													carHtml='<table class="carList table table-striped table-bordered table-hover">'
												        +'<thead><tr><th>序号</th><th>运单编号</th><th>品牌</th><th>车型</th><th>车架号</th><th>颜色</th><th>发动机号</th><th>入库时间</th></tr></thead>'
												        +'<tbody>'+carHtmlItem+'</tbody></table>'; 
												}else{
													carHtmlItem='<tr><td colspan="7">暂无车辆信息</td></tr>'
													carHtml='<table class="carList table table-striped table-bordered table-hover">'
												        +'<thead><tr><th>序号</th><th>运单编号</th><th>品牌</th><th>车型</th><th>车架号</th><th>颜色</th><th>发动机号</th><th>入库时间</th></tr></thead>'
												        +'<tbody>'+carHtmlItem+'</tbody></table>';
												}	
											if(data.data['scheduleList'][i]['status']=='0'){
												data.data['scheduleList'][i]['status']='未完成';
											}else{data.data['scheduleList'][i]['status']='已完成';}
											if(data.data['scheduleList'][i]['carShopId']!=null && data.data['scheduleList'][i]['carShopId']!=''){
												detailListHtml+='<div class="border-b-ff9a00 detailList" id="detailList'+i+'">'
													  +'<div class="row newrowThr"><div class="col-xs-2 pd-2"><div class="lab-tit"><label>经销单位:</label></div></div>'
										              +'<div class="col-xs-4"><div class="form-contr"><p class="carShopId-item form-control">'+data.data['scheduleList'][i]['carShopName']+'</p></div></div>'
										              +'<div class="col-xs-2 pd-2"><div class="lab-tit"><label>数量:</label></div></div>'
										              +'<div class="col-xs-4"><div class="form-contr"><p class="amount-item form-control">'+data.data['scheduleList'][i]['amount']+'</p></div></div></div>'
										              +'<div class="row newrowThr"><div class="col-xs-2 pd-2"><div class="lab-tit"><label>详细指令:</label></div></div>'
										              +'<div class="col-xs-4"><div class="form-contr"><p class="detailMark-item form-control">'+data.data['scheduleList'][i]['mark']+'</p></div></div>'
										              +'<div class="col-xs-2 pd-2"><div class="lab-tit"><label>状态:</label></div></div>'
										              +'<div class="col-xs-4"><div class="form-contr"><p class="detailMark-item form-control">'+data.data['scheduleList'][i]['status']+'</p></div></div></div>'
										              +'<div class="row newrowThr"><div class="col-xs-2 pd-2"><div class="lab-tit"><label>车辆信息:</label></div></div>'
										              +'<div class="col-xs-10"><div class="newCarDetail-item">'+carHtml+'</div></div></div></div>';
											}else{
												detailListHtml+='<div class="border-b-ff9a00 detailList" id="detailList'+i+'">'
													  +'<div class="row newrowThr"><div class="col-xs-2 pd-2"><div class="lab-tit"><label>经销单位:</label></div></div>'
										              +'<div class="col-xs-4"><div class="form-contr"><p class="carShopId-item form-control">二手车</p></div></div>'
										              +'<div class="col-xs-2 pd-2"><div class="lab-tit"><label>数量:</label></div></div>'
										              +'<div class="col-xs-4"><div class="form-contr"><p class="amount-item form-control">'+data.data['scheduleList'][i]['amount']+'</p></div></div></div>'
										              +'<div class="row newrowThr"><div class="col-xs-2 pd-2"><div class="lab-tit"><label>详细指令:</label></div></div>'
										              +'<div class="col-xs-4"><div class="form-contr"><p class="detailMark-item form-control">'+data.data['scheduleList'][i]['mark']+'</p></div></div>'
										              +'<div class="col-xs-2 pd-2"><div class="lab-tit"><label>状态:</label></div></div>'
										              +'<div class="col-xs-4"><div class="form-contr"><p class="detailMark-item form-control">'+data.data['scheduleList'][i]['status']+'</p></div></div></div>'
										              +'<div class="row newrowThr"><div class="col-xs-2 pd-2"><div class="lab-tit"><label>车辆信息:</label></div></div>'
										              +'<div class="col-xs-10"><div class="newCarDetail-item">'+carHtml+'</div></div></div></div>';
											}
											}
										}else{
											detailListHtml='<div class="border-b-ff9a00 detailList" id="detailList'+i+'"><div class="row newrow"><div class="col-xs-12"><p class="form-control no-border t-c">没有详细信息！</p></div></div>';
										}
										
										html=detailListHtml;
										$('#carDetails').after(html);
										$('#localTimes').html(localTime);
									   doprintForms();
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

function doprintForms(){
	var html=$("#printdetilTable").html();
	$('#breadcrumbs').hide();
	$('.page-content').hide();
	$('#printdetilTable').show();
	$('#printTable').hide();
	/* $("#myprintDataTable").printTable({
	 header: "#headerInfos",
     footer: "#footerInfos",
	 mode: "rowNumber",
	 pageSize: 6
}); */

	javasricpt:window.print();
	$('#breadcrumbs').show();
	$('.page-content').show();
	$('#printdetilTable').hide();
	$('#printTable').hide(); 
	$('.detailList').remove(); 
	//$("#printdetilTable").html(html); 
 }
</script>



</body>
</html>






