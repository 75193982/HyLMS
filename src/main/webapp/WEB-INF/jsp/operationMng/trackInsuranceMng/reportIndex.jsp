
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/ztree/demo.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/datetimepicker.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
.searchboxs{width:100%;height:45px;margin-bottom:15px;}
.searchboxs .title{margin-right:8px;font-family:"Microsoft YaHei";}
.searchboxs .titletwo{margin:0 8px 0 12px;font-family:"Microsoft YaHei";}
.searchboxs .form-box{width:180px;font-size:14px;height: 30px;margin-right:15px;}
.searchboxs .itemBtn{width: 65px;height: 34px;display: inline-block;cursor: pointer;
    text-decoration: none;background: #2ca9e1;color: #fff;margin: 0px 15px;text-align: center;
    font-size: 14px;line-height: 30px;border-radius: 3px;padding: 3px;
}  
.searchboxs .itemBtn:hover{background: #2E8EB9;} 
.form-new{
float:right;
width:480px;
}
.table-audit{
	width: 75px;
	height: 30px;
	display: inline-block;
	cursor: pointer;
	text-decoration: none;
	background: #2ca9e1;
	color: #fff;
	text-align: center;
	font-size: 13px;
	line-height: 24px;
	border-radius: 3px;
	padding: 3px;
	margin-right:5px;
	
}
.table-audit:hover{color:#fff;} 
#modal-shedeinfo{
    width: 1200px;
    height: 600px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }
    #modal-info{
    width: 650px;
    height: 600px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }
     #modal-payInsurance{
    width: 650px;
    height: 400px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }
     .table-upload{
	width: 70px;
	height: 30px;
	display: inline-block;
	cursor: pointer;
	text-decoration: none;
	background: #2ca9e1;
	color: #fff;
	text-align: center;
	font-size: 13px;
	line-height: 24px;
	border-radius: 3px;
	padding: 3px;
	margin-right:5px;
	margin-left:5px;
}
.table-upload:hover{color:#fff;} 
#modal-upload{
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
				出险管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
	<div class="searchbox col-xs-12">
		<label class="title" style="float: left;height: 34px;line-height: 34px; ">时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 180px;margin-right:15px;">
				<input class="form-control" id="form_startTime" type="text" placeholder="请输入时间" style="height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 180px;margin-right:15px;margin-left: 15px;">
				<input class="form-control" id="form_endTime" type="text" placeholder="请输入时间" style="height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			 <label class="title" style="float: left;height: 34px;line-height: 34px;">装运车号：</label>
		    <input id="fom_carNumber" class="form-box" type="text" placeholder="请输入装运车号" style="width:180px;"/>
			 <a class="itemBtn m-lr5" onclick="searchInfo()">查询</a>
			 <a class="itemBtn m-lr5" onclick="doadd()">新增</a>						   		
		  	</div>				
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>装运车号</th>
                    <th>驾驶员</th>
                    <th>出险时间</th>
                    <th>保险公司勘查员号码</th>
                    <th>金额</th>
                    <th>理赔材料是否齐全</th>                    
                    <th >缺少材料备注 </th>  
                    <th>备注</th>    
                    <th>创建时间</th> 
                    <th>状态</th>                                           
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 出险信息新增 开始 -->
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">新增出險信息</h3>
				</div>
				<div class="modal-body"  style="height:510px;overflow:auto;">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>装运车号：</label>
							     <select class="form-control" id="carNumber_new">
				                  <option value="">请选择装运车号</option>
				                   </select>
							      <!-- <input class="form-control" id="carNumber_new" type="text" placeholder="请输入货运车号 "/> -->
							     <!-- <input class="form-control" id="id-hidden" type="hidden"/> -->
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>驾驶员：</label>
							      <input class="form-control" id="driver_new" type="text" placeholder="请输入驾驶员 " readonly="readonly"/>
							      <input class="form-control" id="driver_new_id" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>出险时间：</label>
							     <div class="input-group input-group-sm" style="width:460px;">
									<input class="form-control" id="reportTime_new" type="text" placeholder="请输入出险时间"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>							   
							    </div>							    
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title" style="width:170px;"><span class="red">*</span>保险公司勘查员号码：</label>
							      <input  style="width:410px;float:left;height:30px;" id="surveyMobile_new" type="text" placeholder="请输入保险公司勘查员号码 "/>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>金额：</label>
							      <input class="form-control" id="amount_new" type="text" placeholder="请输入金额 " style="width:350px;"  onblur="revaildate(this,0);"/><p class="title"><input type="checkbox" name="materialCompleteFlag" id="materialCompleteFlag" value="Y" onclick="dochecked(this)"/>理赔材料齐全</p>	
							  </div>
							   <hr class="tree" ></hr>								
							  <div id="needhide">							 
							  <div class="add-item extra-itemSec">
							     <label class="title">缺少材料备注：</label>
							      <textarea rows="4" cols="4" class="form-control" id="materialMark_new" placeholder="请输入缺少材料备注"></textarea>
							  </div>
							  <hr class="tree" style="margin-top:60px;"></hr>
							  </div>
							  
							  <div class="add-item extra-itemSec">
							     <label class="title">备注：</label>
							     <textarea rows="4" cols="4" class="form-control" id="mark_new" placeholder="请输入备注" ></textarea>
							  </div>					
							  <hr class="tree" style="margin-top:60px;"></hr>
										<div class="add-item-btn" id="addBtn">
											<a class="add-itemBtn btnOk" onclick="doaddsave();">保存</a> <a
												class="add-itemBtn btnCancle" onclick="refresh();">关闭</a>
										</div>										
									</div>
						  </div>
					</div>
				</div>
				</div>			
			</div>
			<!-- 出险信息新增 结束 -->
			
			<!-- 出险信息编辑  开始 -->
			<div class="modal fade" id="modal-einfo" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">编辑出险信息</h3>
				</div>
				<div class="modal-body"  style="height:510px;overflow:auto;">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>装运车号：</label>
							     <select class="form-control" id="carNumber_edit">
				                  <option value="">请选择装运车号</option>
				                   </select>
							     <!--  <input class="form-control" id="carNumber_edit" type="text" placeholder="请输入货运车号 "/> -->
							      <input class="form-control" id="id-hidden" type="hidden"/> 
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>驾驶员：</label>
							      <input class="form-control" id="driver_edit" type="text" placeholder="请输入驾驶员 " readonly="readonly"/>
							      <input class="form-control" id="driver_edit_id" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>出险时间：</label>
							     <div class="input-group input-group-sm" style="width:395px;">
									<input class="form-control" id="reportTime_edit" type="text" placeholder="请输入出险时间"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>							   
							    </div>							    
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title" style="width:170px;"><span class="red">*</span>保险公司勘查员号码：</label>
							      <input  style="width:345px;float:left;height:30px;" id="surveyMobile_edit" type="text" placeholder="请输入保险公司勘查员号码 "/>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>金额：</label>
							      <input class="form-control" id="amount_edit" type="text" placeholder="请输入金额 " style="width:280px;" onblur="revaildate(this,1);"/><p class="title"><input type="checkbox" name="materialCompleteFlag_edit" id="materialCompleteFlag_edit" value="Y" onclick="dochecked_edit(this)"/>理赔材料齐全</p>	
							  </div>	
							  <hr class="tree" ></hr>							
							  <div id="needhide_edit">							  
							  <div class="add-item extra-itemSec">
							     <label class="title">缺少材料备注：</label>
							      <textarea rows="4" cols="4" class="form-control" id="materialMark_edit" placeholder="请输入缺少材料备注"></textarea>
							  </div>
							   <hr class="tree" style="margin-top:60px;"></hr>
							  </div>
							 
							  <div class="add-item extra-itemSec">
							     <label class="title">备注：</label>
							     <textarea rows="4" cols="4" class="form-control" id="mark_edit" placeholder="请输入备注" ></textarea>
							  </div>					
							  <hr class="tree" style="margin-top:60px;"></hr>
										<div class="add-item-btn" id="editBtn">
											<a class="add-itemBtn btnOk" onclick="doeditsave();">保存</a> 
											<a class="add-itemBtn btnCancle" onclick="refresh_edit();">关闭</a>
										</div>										
									</div>
						  </div>
					</div>
				</div>
				</div>			
			</div>
			<!-- 出险信息编辑 结束 -->
			
			<!-- 出险信息明细查看 开始-->
		 <div class="modal fade" id="modal-upload" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal" onclick="refreshe();">×</button>
					<h3 id="myModalLabel">查看出险信息</h3>
				</div>
				<div class="modal-body" style="height:510px;overflow:auto;">
					<div class="mng" style="min-height:480px;">						
						<div class="table-item">
							<div class="table-itemTit">基本信息</div>
							<!-- 第一列 -->
							<div class="row newrow">
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">装运车号:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="carNumber_view" class="form-control no-border"></p>
									</div>
								</div>								
							</div>
							<!-- 第二列 -->
							<div class="row newrow">
							<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">驾驶员:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="driver_view" class="form-control no-border"></p>
									</div>
								</div>							
							</div>
							<!-- 第三列 -->
							<div class="row newrow">
							<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">出险时间:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="reportTime_view" class="form-control no-border"></p>
									</div>
								</div>																
								</div>								
							</div>	
							<!-- 第四列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">保险公司勘查员号码:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="surveyMobile_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							<!-- 第五列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">金额:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="amout_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							<!-- 第六列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">理赔材料是否齐全:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="materialCompleteFlag_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							<!-- 第七列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">缺少材料备注:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="materialMark_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							<!-- 第八列 -->
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
										<a class="backbtn" onclick="doback();"><i
											class="icon-undo" style="display: inline-block; width: 20px;"></i>关闭</a>
									</div>
								</div>
								<div class="col-xs-5"></div>
							</div>
						</div>
					</div>
				</div>
			<!-- 出险信息明细查看 结束-->		
		</div>
	</div>

</div>
	<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>保费信息记录表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>
		        <th>序号</th>
				<th>类型</th>
				<th>装运车号</th>
		        <th>驾驶员</th>
		        <th>保单号</th>
		        <th>保险开始时间</th>
				<th>保险结束时间</th>
		        <th>总金额</th>
		      <!--   <th>提醒时间</th> -->
		        <th>备注</th>
		        <th>创建时间</th>
		        <th>创建人</th>
		        <th>更新时间</th>
		        <th>更新人</th>
		        <th>状态</th>
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
<script src="${ctx}/staticPublic/js/uploadify/jquery.uploadify.min.js"></script>
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script>
<script src="${ctx}/staticPublic/js/bootstrap-tab.js"></script>
<script type="text/javascript">
function init(){	
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/trackInsuranceMng/getListData" , //获取数据的ajax方法的URL							 
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
				columns: [{ data: "rownum" ,"width":"6%"},
						    {data: "carNumber","width":"8%"},
						    {data: "driverName","width":"6%"},
						    {data: "reportTime","width":"8%"},
						    {data: "surveyMobile","width":"10%"},
						    {data: "amount","width":"6%"},
						    {data: "materialCompleteFlag","width":"8%"},
						    {data: "materialMark","width":"8%"},
						   /*  {data: "noticeTime","width":"7%"}, */
						    {data: "mark","width":"8%"},	
						    {data: "insertTime","width":"12%"},
						    {data: "status","width":"6%"},			    	
						    {data: null,"width":"16%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 6,
				 render: function (data, type, row, meta) {
					 if(data=='Y'){
						 return '是';
					 }else{
						 return '否';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 3,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonForDateMinutFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 9,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 10,
				 render: function (data, type, row, meta) {
					  if(data=='0'){
						 return '新建';
					 }else if(data=='1'){
						 return '已确认';
					 }else {
						 return '';
					 }					
			       }	       
			},{//操作栏
			    	 targets: 11,
			    	 render: function (data, type, row, meta) {		
			    		 if(row.status=='0'){
			    			 return '<a class="table-edit" onclick="dosubmit('+ row.id +')">确认</a>'
			    			    +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
				               +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';	
			    		 }else{
			    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';
			    			  	
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
		 "sAjaxSource": "${ctx}/operationMng/trackInsuranceMng/getListData", //获取数据的ajax方法的URL	
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
				columns: [{ data: "rownum" ,"width":"6%"},
						    {data: "carNumber","width":"8%"},
						    {data: "driverName","width":"6%"},
						    {data: "reportTime","width":"8%"},
						    {data: "surveyMobile","width":"10%"},
						    {data: "amount","width":"6%"},
						    {data: "materialCompleteFlag","width":"8%"},
						    {data: "materialMark","width":"8%"},
						   /*  {data: "noticeTime","width":"7%"}, */
						    {data: "mark","width":"8%"},	
						    {data: "insertTime","width":"12%"},
						    {data: "status","width":"6%"},			    	
						    {data: null,"width":"16%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 6,
				 render: function (data, type, row, meta) {
					 if(data=='Y'){
						 return '是';
					 }else{
						 return '否';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 3,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonForDateMinutFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 9,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 10,
				 render: function (data, type, row, meta) {
					  if(data=='0'){
						 return '新建';
					 }else if(data=='1'){
						 return '已确认';
					 }else {
						 return '';
					 }					
			       }	       
			},{//操作栏
			    	 targets: 11,
			    	 render: function (data, type, row, meta) {		
			    		 if(row.status=='0'){
			    			 return '<a class="table-edit" onclick="dosubmit('+ row.id +')">确认</a>'
			    			    +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
				               +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';	
			    		 }else{
			    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';
			    			  	
			    		 }    				                 
		                }	       
		    	} 
		      ],
			"fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	/* $("#form_startTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#form_endTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	}); */
	
	$("#form_startTime").datetimepicker({
		language: 'cn',
	      format: "yyyy-mm-dd hh:ii",
	      autoclose: true,//选中之后自动隐藏日期选择框
	      todayBtn: true
	});
	$("#form_endTime").datetimepicker({
		language: 'cn',
	      format: "yyyy-mm-dd hh:ii",
	      autoclose: true,//选中之后自动隐藏日期选择框
	      todayBtn: true
	});
	//getOutSourcing();//获取承运商
	//getCarShop();
	getStockList();
	/* 根据货运车绑定驾驶员 */
	  $('#carNumber_new').on('change',function(e){
		  var mobile="";
		  if($(this).val()=='' || $(this).val()==null){
			  $('#driver_new').val('');
			  $('#driver_new_id').val('');
		  }else{
			  $('#driver_new').val($(this).find('option:selected').attr('data-driverName'));
			  $('#driver_new_id').val($(this).find('option:selected').attr('data-driverId'));
		  }
	  });
	  $('#carNumber_edit').on('change',function(e){
		  var mobile="";
		  if($(this).val()=='' || $(this).val()==null){
			  $('#driver_edit').val('');
			  $('#driver_edit_id').val('');
		  }else{
			  $('#driver_edit').val($(this).find('option:selected').attr('data-driverName'));
			  $('#driver_edit_id').val($(this).find('option:selected').attr('data-driverId'));
		  }
	  });
})
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
	                			html +='<option value='+data.data[i]['no']+' data-driverId='+data.data[i]['driverId']+' data-driverName='+data.data[i]['driverName']+' >'+data.data[i]['no']+'</option>';
	                		}
	            		}
	            	}
	            	$('#carNumber_new').html(html);
	            	$('#carNumber_edit').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
  }
/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var startTime=$("#form_startTime").val(); 
	   var endTime=$("#form_endTime").val(); 
	   //var status=$("#fom_status").val(); 
	   var carNumber=$("#fom_carNumber").val();
	   var type='1';
	  // var insuranceBillNo=$("#fom_insuranceBillNo").val();
	   //var insuranceCompany=$("#fom_insuranceCompany").val();
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				type :$.trim(type) ,
				carNumber :$.trim(carNumber) ,
				insuranceBillNo :'',
				status :'' ,
				startInTime :$.trim(startTime) ,
				endInTime : $.trim(endTime)		
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
					var allamount=0;
					var allbalance=0;
					if(obj.aaData.length>0){
						for(var i=0;i<obj.aaData.length;i++){
							obj.aaData[i]["rownum"]=i+1;
							if(obj.aaData[i]["type"]=='0'){
								allamount+=obj.aaData[i]["amount"];
								allbalance+=obj.aaData[i]["balance"];
							}
						}
						//console.info(allamount);
						//console.info(allbalance);
						$('#fom_amount').val(allamount);
						$('#fom_balance').val(allbalance);
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
/* 新增信息 */	
/*申请信息输入  */
function doadd(){
	clear();
	$('#addBtn').show();
	$('#needhide').show();
	$('#myModalLabel').html('新增出险信息');	
	$('#modal-info').modal('show');
	/* $("#reportTime_new").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	}); */
	$("#reportTime_new").datetimepicker({
		language: 'cn',
	      format: "yyyy-mm-dd hh:ii",
	      autoclose: true,//选中之后自动隐藏日期选择框
	      todayBtn: true
	});

}

/* 关闭新增窗体 */
function refresh(){
	clear();
	$('#modal-info').modal('hide');
	
}
/* 关闭编辑窗体 */
function refresh_edit(){
	clear_edit();
	$('#modal-einfo').modal('hide');
	
}
/* 数据重置 */
function clear(){
	$('#carNumber_new').val('');		
	$('#driver_new').val('');
	$('#driver_new_id').val('');
	$('#reportTime_new').val('');
	$('#amount_new').val('');
	$('#materialMark_new').val('');
	$('#mark_new').val('');
	$('#materialCompleteFlag').prop('checked', false);
}
/* 数据重置 */
function clear_edit(){
	$('#carNumber_edit').val('');		
	$('#driver_edit').val('');
	$('#driver_edit_id').val('');
	$('#reportTime_edit').val('');
	$('#amount_edit').val('');
	$('#materialMark_edit').val('');
	$('#mark_edit').val('');
	$('#materialCompleteFlag_edit').prop('checked', false);
}
/* 保存换车申请信息 */
function doaddsave(){
	var flag="false"; 
	var carNumber=$("#carNumber_new").val(); 
	var driver=$("#driver_new_id").val(); 
	var reportTime=$("#reportTime_new").val(); 
	var amount=$("#amount_new").val(); 
	var materialMark=$("#materialMark_new").val(); 
	var surveyMobile=$("#surveyMobile_new").val(); 
	var mark=$("#mark_new").val(); 	
	if(carNumber==''){
		bootbox.alert('装运车号不能为空！');
		return;
	}if(driver==''){
		bootbox.alert('驾驶员不能为空！');
		return;
	}if(surveyMobile==''){
		bootbox.alert('保险公司勘查员号码不能为空！');
		return;
	}if(reportTime==''){
		bootbox.alert('出险时间不能为空！');
		return;
	}if(amount==''){
		bootbox.alert('金额不能为空！');
		return;
	}
	if(amount!=''&&isNaN(amount)){
		bootbox.alert('金额请填写数字！');
		return;
	}
	var materialCompleteFlag=''; 
	if($('#materialCompleteFlag').prop("checked")){		
		materialCompleteFlag='Y';
	}else{
		materialCompleteFlag='N';
	}
	var dt = new Date(reportTime);
	 var objs=[];
	 var objList={};	 
	   objList.type='1';
	   objList.carNumber=carNumber;
	   objList.driverId=driver;
	   objList.amount=amount;
	   objList.mark=mark;
	   objList.reportTime=dt;
	   objList.surveyMobile=surveyMobile;
	   objList.materialCompleteFlag=materialCompleteFlag; 
	   objList.materialMark=materialMark;
	   
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该出险信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackInsuranceMng/save',
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
											 refresh();
								             reload();
										  }else{
											refresh();
								            reload(); 
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										refresh();
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
}
//申请提交
function dosubmit(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要确认该出险信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'GET',
						url : '${ctx}/operationMng/trackInsuranceMng/submit/'+id,
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "确认成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											 refresh();
								             reload();
										  }else{
											refresh();
								            reload(); 
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										refresh();
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
}
//打开编辑页面
function doedit(id){		
	/* $("#reportTime_edit").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	}); */
	$("#reportTime_edit").datetimepicker({
		language: 'cn',
	      format: "yyyy-mm-dd hh:ii",
	      autoclose: true,//选中之后自动隐藏日期选择框
	      todayBtn: true
	});
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackInsuranceMng/getDetail/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				$('#id-hidden').val(id);				
				$("#carNumber_edit").val(data.data.carNumber);
				$("#driver_edit").val(data.data.driverName); 
				$("#driver_edit_id").val(data.data.driverId); 
				$("#reportTime_edit").val(data.data.reportTime); 
				$("#surveyMobile_edit").val(data.data.surveyMobile); 
                if(data.data.reportTime!=''&&data.data.reportTime!=null){
					$("#reportTime_edit").val(jsonForDateMinutFormat(data.data.reportTime));
				}else{
					$("#reportTime_edit").val('');	
				}				
				$("#amount_edit").val(data.data.amount);
				$("#mark_edit").val(data.data.mark);
				if(data.data.materialCompleteFlag=='Y'){
					$('#materialCompleteFlag_edit').prop('checked', true);	
					$('#needhide_edit').hide();
				}else{
					$('#materialCompleteFlag_edit').prop('checked', false);
					$('#needhide_edit').show();
				}
				//$('#myModalLabel').html('编辑出险信息');	
				$('#modal-einfo').modal('show');
				$('#editBtn').show();							
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
/* 更新 */
function doeditsave(){
	var flag="false";
	var id=$('#id-hidden').val();	
	var carNumber=$("#carNumber_edit").val(); 
	var driver=$("#driver_edit_id").val(); 
	var reportTime=$("#reportTime_edit").val(); 
	var amount=$("#amount_edit").val(); 
	var materialMark=$("#materialMark_edit").val(); 
	var surveyMobile=$("#surveyMobile_edit").val(); 
	var mark=$("#mark_edit").val(); 	
	if(carNumber==''){
		bootbox.alert('装运车号不能为空！');
		return;
	}if(driver==''){
		bootbox.alert('驾驶员不能为空！');
		return;
	}if(surveyMobile==''){
		bootbox.alert('保险公司勘查员号码不能为空！');
		return;
	}if(reportTime==''){
		bootbox.alert('出险时间不能为空！');
		return;
	}if(amount==''){
		bootbox.alert('金额不能为空！');
		return;
	}
	if(amount!=''&&isNaN(amount)){
		bootbox.alert('金额请填写数字！');
		return;
	}
	var materialCompleteFlag=''; 
	if($('#materialCompleteFlag_edit').prop("checked")){		
		materialCompleteFlag='Y';
	}else{
		materialCompleteFlag='N';
	}
	var dt = new Date(reportTime);
	 var objs=[];
	 var objList={};	 
	  objList.type='1';
	   objList.carNumber=carNumber;
	   objList.driverId=driver;
	   objList.amount=amount;
	   objList.mark=mark;
	   objList.reportTime=dt;
	   objList.surveyMobile=surveyMobile;
	   objList.materialCompleteFlag=materialCompleteFlag; 
	   objList.materialMark=materialMark;	   
	   objList.id=id;
	   bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该出险信息?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : '${ctx}/operationMng/trackInsuranceMng/update',
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
												 flag="true"
												 refresh_edit();
									             reload();
											  }else{
												 refresh_edit();
									            reload(); 
											  }
										  }
									 });
									setTimeout(function(){
										if(flag=="false"){
											refresh_edit();
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
}
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该出险信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/trackInsuranceMng/delete/"+id,
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "删除成功！", 
									  callback: function(result){
										  if(result){
											  flag="true"
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
							}else{
								bootbox.alert(data.msg);
							}
						}
						
					}); 
			  }
		  }
	})
}
/**明细查看**/
 function doview(id){
		$.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/trackInsuranceMng/getDetail/"+id,
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.info(JSON.stringify(data.data));
					$("#carNumber_view").html(data.data.carNumber); 
					$("#driver_view").html(data.data.driverName);  
                    if(data.data.reportTime!=''&&data.data.reportTime!=null){
						$("#reportTime_view").html(jsonForDateMinutFormat(data.data.reportTime));
					}else{
						$("#reportTime_view").html('');	
					}				
					$("#surveyMobile_view").html(data.data.surveyMobile);
					$("#amout_view").html(data.data.amout);
					if(data.data.materialCompleteFlag=='Y'){
						$("#materialCompleteFlag_view").html('是');	
					}else{
						$("#materialCompleteFlag_view").html('否');		
					}
					$("#mark_view").val(data.data.mark);	
					$('#modal-upload').modal('show');
				} else {
					bootbox.alert(data.msg);				
				}
			}
			
		}); 
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
		   var startTime=$("#form_startTime").val(); 
		   var endTime=$("#form_endTime").val(); 
		   var status=$("#fom_status").val(); 
		   var carNumber=$("#fom_carNumber").val();
		   var type=$("#fom_type").find("option:selected").val();
		   var insuranceBillNo=$("#fom_insuranceBillNo").val();
		   if(type=='' || type==null || type=='-1'){
			   type='';
		   }		   
		   if(status=='' || status==null || status=='-1'){
			   status='';
		   }
		   $.ajax({
			    type : 'POST',
				url : "${ctx}/operationMng/trackInsuranceMng/getPrintData",
				data : JSON.stringify({
					type : type,
					carNumber : carNumber,
					insuranceBillNo : insuranceBillNo,
					status : status,
					startInTime : startTime,
					endInTime : endTime
				}),
				contentType : "application/json;charset=UTF-8",
				dataType : 'JSON',
				success : function(data) {
					if (data && data.code == 200) {					
						if(data.data.length>0){
							for(var i=0;i<data.data.length;i++){
								data.data[i]["rownum"]=i+1;
								if(data.data[i]["type"]=='0'){
									data.data[i]["type"]='参加保险';
								}else{
									data.data[i]["type"]='报保险';
								}								
								if(data.data[i]["status"]=='0'){
									data.data[i]["status"]='新建';
								}else if(data.data[i]["status"]=='1'){
									data.data[i]["status"]='已提交';
								}else{
									data.data[i]["status"]='已失效';
								}
								if(data.data[i]["startTime"]==null || data.data[i]["startTime"]=='' || parseInt(data.data[i]["startTime"])<0){
									data.data[i]["startTime"]=''; 
								 }else{
									 data.data[i]["startTime"]=jsonForDateMinutFormat(data.data[i]["startTime"]);
								 }
								if(data.data[i]["endTime"]==null || data.data[i]["endTime"]=='' || parseInt(data.data[i]["endTime"])<0){
									data.data[i]["endTime"]=''; 
								 }else{
									 data.data[i]["endTime"]=jsonForDateMinutFormat(data.data[i]["endTime"]);
								 }
								if(data.data[i]["noticeTime"]==null || data.data[i]["noticeTime"]=='' || parseInt(data.data[i]["noticeTime"])<0){
									data.data[i]["noticeTime"]=''; 
								 }else{
									 data.data[i]["noticeTime"]=jsonForDateFormat(data.data[i]["noticeTime"]);
								 }
								if(data.data[i]["insertTime"]==null || data.data[i]["insertTime"]=='' || parseInt(data.data[i]["insertTime"])<0){
									data.data[i]["insertTime"]=''; 
								 }else{
									 data.data[i]["insertTime"]=jsonDateFormat(data.data[i]["insertTime"]);
								 }
								if(data.data[i]["updateTime"]==null || data.data[i]["updateTime"]=='' || parseInt(data.data[i]["updateTime"])<0){
									data.data[i]["updateTime"]=''; 
								 }else{
									 data.data[i]["updateTime"]=jsonDateFormat(data.data[i]["updateTime"]);
								 }
								if(data.data[i]["insertUser"]=='' || data.data[i]["insertUser"]==null){
									data.data[i]["insertUser"]='';
								}if(data.data[i]["updateUser"]=='' || data.data[i]["updateUser"]==null){
									data.data[i]["updateUser"]='';
								}
								if(data.data[i]["driverName"]=='' || data.data[i]["driverName"]==null){
									data.data[i]["driverName"]='';
								}
									html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
								    +'<td>'+data.data[i]["type"]+'</td>'
								    +'<td>'+data.data[i]["carNumber"]+'</td>'
								    +'<td>'+data.data[i]["driverName"]+'</td>'
								    +'<td>'+data.data[i]["insuranceBillNo"]+'</td>'
								    +'<td>'+data.data[i]["startTime"]+'</td>'
								    +'<td>'+data.data[i]["endTime"]+'</td>'
								    +'<td>'+data.data[i]["amount"]+'</td>'								  
								    +'<td>'+data.data[i]["noticeTime"]+'</td>'
								    +'<td>'+data.data[i]["mark"]+'</td>'
								    +'<td>'+data.data[i]["insertTime"]+'</td>'
								    +'<td>'+data.data[i]["insertUser"]+'</td>'
								    +'<td>'+data.data[i]["updateTime"]+'</td>'
								    +'<td>'+data.data[i]["updateUser"]+'</td>'
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

	/* 导出 */
	function doexport()
	{
		 var startTime=$("#form_startTime").val(); 
		   var endTime=$("#form_endTime").val(); 
		   var status=$("#fom_status").val(); 
		   var carNumber=$("#fom_carNumber").val();
		   var type=$("#fom_type").find("option:selected").val();
		   var insuranceBillNo=$("#fom_insuranceBillNo").val();
		   if(type=='' || type==null || type=='-1'){
			   type='';
		   }		   
		   if(status=='' || status==null || status=='-1'){
			   status='';
		   }
		   var form = $('<form action="${ctx}/operationMng/trackInsuranceMng/export" method="post"></form>');
		   var typeInput = $('<input id="type" name="type" value="'+type+'" type="hidden" />');
		   var carNumberInput = $('<input id="carNumber" name="carNumber" value="'+carNumber+'" type="hidden" />');
		   var insuranceBillNoInput = $('<input id="insuranceBillNo" name="insuranceBillNo" value="'+insuranceBillNo+'" type="hidden" />');		  
		   var statusInput = $('<input id="status" name="status" value="'+status+'" type="hidden"  />');
		   var startTimeInput = $('<input id="startInTime" name="startInTime" value="'+startTime+'" type="hidden" />');
		   var endTimeInput = $('<input id="endInTime" name="endInTime" value="'+endTime+'" type="hidden" />');
		   form.append(typeInput);
		   form.append(carNumberInput);
		   form.append(insuranceBillNoInput);
		   form.append(statusInput);
		   form.append(startTimeInput);
		   form.append(endTimeInput);
		   $('body').append(form);
		   form.submit();
	}
	/**理赔材料是否齐全隐藏缺少材料备注**/
	function dochecked(e){
		/* console.info($(e).prop("checked")); */
		 if($(e).prop("checked")){
			 $("#needhide").hide(); 			 			 
		 }else{
			 $("#needhide").show(); 
		 }
		 
	}
	/**理赔材料是否齐全隐藏缺少材料备注**/
	function dochecked_edit(e){
		/* console.info($(e).prop("checked")); */
		 if($(e).prop("checked")){
			 $("#needhide_edit").hide(); 			 			 
		 }else{
			 $("#needhide_edit").show(); 
		 }
		 
	}
	//弹窗关闭
	function refreshe(){
		$('#modal-upload').modal('hide');
	}
	function doback(){
		$('#modal-upload').modal('hide');
	}
	
	/* 金额验证 */
	function revaildate(e,flag){
		var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
	    var money = $(e).val();
	    if(money!=null && money!=''){
	    	if (!reg.test(money)) {
	    		if(flag=='0'){//预付现金
	    			$('#amount_new').val('');
	    		}else if(flag=='1'){//预付油费
	    			$('#amount_edit').val('');
	    		}
	    		bootbox.alert('请输入正确的金额！');
	       }
	    }
	}
</script>



</body>
</html>






