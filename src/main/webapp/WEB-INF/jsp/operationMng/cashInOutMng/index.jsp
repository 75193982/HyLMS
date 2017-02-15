
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
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->

</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			财务管理
			<small>
				<i class="icon-double-angle-right"></i>
				现金收支管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title mul-title" style="float: left;height: 34px;line-height: 34px;">时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 170px;margin-right:25px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width: 45px;margin-right: 8px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 170px;height: 34px;line-height: 34px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			<label class="title mul-title">类型：</label>
		    <select id="type" class="form-box mul-form-box" style="width:170px;">
		      <option value="-1">请选择类型</option>
		      <option value="0">收入</option>
		      <option value="1">支出</option>
		    </select>
		    
		</div>
		<div class="searchbox col-xs-12">
		  <label class="title mul-title">部门：</label>
		    <select id="dept" class="form-box mul-form-box" style="width:170px;">
		      <option value="">请选择部门</option>
		    </select>
		    <label class="title mul-title" style="text-align:left;width:50px;">状态：</label>
		    <select id="status" class="form-box mul-form-box" style="width:170px;">
		      <option value="-1">请选择状态</option>
		      <option value="0">新建</option>
		      <option value="1">已提交</option>
		    </select>
		    <label class="title mul-title" style="text-align: left;width: 45px;">事由：</label>
		    <input id="mark" class="form-box mul-form-box" type="text" placeholder="请输入事由" style="width:170px;"/>
		    
		</div>
		<div class="searchbox col-xs-12">
		  <label class="title mul-title">类别：</label>
		    <select id="businessType" class="form-box mul-form-box" style="width:170px;">
		      <option value="">请选择类别</option>
		      <option value="折损费用申请">折损费用申请</option>
		      <option value="油卡">油卡</option>
		      <option value="预付申请">预付申请</option>
		      <option value="折损出库">折损出库</option>
		      <option value="费用申请">费用申请</option>
		      <option value="核销费用申请">核销费用申请</option>
		      <option value="保费申请">保费申请</option>
		      <option value="轮胎入库登记">轮胎入库登记</option>
		      <option value="驾驶员报销折现">驾驶员报销折现</option>
		    </select>
			<a class="itemBtn m-lr5" onclick="searchInfo()">查询</a>
			<a class="itemBtn m-lr5" onclick="doadd()">新增</a>
			<a class="itemBtn m-lr5" onclick="doprint()">打印</a>
			<a class="itemBtn m-lr5" onclick="doexport()">导出</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>类型</th>
					<th>类别</th>
					<th>部门</th>
					<th>事由</th>
                    <th>金额</th>
                    <th>创建人</th>
                    <th>创建时间</th>
					<th>状态</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
		</div>
	</div>
	<!-- 新增收支Modal--begin -->
	<div class="modal fade" id="modal-add" tabindex="-1" role="dialog" >
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="refresh();">×</button>
						<h3 id="myModalLabel">新增收支管理</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								  <div class="add-item extra-item">
								        <label class="title"><span class="red">*</span>类型：</label>
								        <select id="typeInsert" class="form-control">
								           <option value="0">收入</option>
								           <option value="1">支出</option>
									    </select>
								    </div>
							  		<hr class="tree"></hr>
								   <div class="add-item extra-item">
								       <label class="title"><span class="red">*</span>事由：</label>
								       <input class="form-control" type="text" id="markInsert" placeholder="请输入事由" />
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-item" id="amount">
								        <label class="title"><span class="red">*</span>金额：</label>
								        <input class="form-control" type="text" id="moneyInsert" placeholder="请输入金额"/><span class="unit">(元)</span>
								    </div>
							  		<hr class="tree"></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="addSave();">确认</a>
									    <a class="add-itemBtn btnCancle" onclick="refresh();">取消</a>
									 </div>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
	
	<!-- 新增收支Modal--end -->
	
	<!-- 编辑收支Modal--begin -->
	<div class="modal fade" id="modal-edit" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="editRefresh();">×</button>
						<h3 id="myModalLabel">编辑收支管理</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								  <div class="add-item extra-item">
								        <label class="title"><span class="red">*</span>类型：</label>
								        <select id="typeEdit" class="form-control">
								           <option value="0">收入</option>
								           <option value="1">支出</option>
									    </select>
								    </div>
							  		<hr class="tree"></hr>
								   <div class="add-item extra-item">
								       <label class="title"><span class="red">*</span>事由：</label>
								       <input class="form-control" type="text" id="markEdit" placeholder="请输入事由" />
								       <input class="form-control" id="updateId" type="hidden"/>
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-item" id="amount">
								        <label class="title"><span class="red">*</span>金额：</label>
								        <input class="form-control" type="text" id="moneyEdit" placeholder="请输入金额"/><span class="unit">(元)</span>
								    </div>
							  		<hr class="tree"></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="update();">确认</a>
									    <a class="add-itemBtn btnCancle" onclick="editRefresh();">取消</a>
									 </div>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
	
	<!-- 编辑收支Modal--end -->
	
	<!-- 查看收支Modal--begin -->
	<div class="modal fade" id="modal-show" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="showRefresh();">×</button>
						<h3 id="myModalLabel">查看收支管理</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item show-item">
								     <label class="title">类型：</label>
								     <p id="typeShow"></p> 
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item show-item">
									     <label class="title">事由：</label>
									     <p id="markShow"></p> 
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item show-item">
									     <label class="title">金额：</label>
									     <p id="moneyShow"></p> 
									 </div>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
	
	<!-- 查看收支Modal--end -->
</div>

<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>收支信息记录表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>
		        <th>序号</th>
					<th>类型</th>
					<th>类别</th>
					<th>部门</th>
					<th>事由</th>
                    <th>金额</th>
                    <th>创建人</th>
                    <th>创建时间</th>
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
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">

function init(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/cashInOutMng/getListData" , //获取数据的ajax方法的URL							 
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
		    {data: "type",'width':'10%'},
		    {data: "businessType",'width':'10%'},
		    {data: "departmentName",'width':'10%'},
		    {data: "mark",'width':'10%'},
		    {data: "money",'width':'10%'},
		    {data: "insertUser",'width':'10%'},
		    {data: "insertTime",'width':'15%'},
		    {data: "status",'width':'10%'},
		    {data: null,'width':'20%'}
			],
		    columnDefs: [
				{
					 //类型
					 targets:1,
					 render: function (data, type, row, meta) {
				         if(data=='0'){
				       	 return '收入'; 
				         }else {
				       	  return '支出';
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
					 targets:8,
					 render: function (data, type, row, meta) {
						 if(data=='0'){
					       	 return '新建'; 
					         }else {
					       	  return '已提交';
					         }
				      }	       
				},

				{
					 //操作
					 targets: 9,
					 render: function (data, type, row, meta) {
						 if(row.status=='0'){
							 return '<a class="table-edit" onclick="dosumbit('+ row.id +')">提交</a>'
						        +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
				                +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
						 }else{
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
		 "sAjaxSource": "${ctx}/operationMng/cashInOutMng/getListData" , //获取数据的ajax方法的URL	
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
					    {data: "type",'width':'10%'},
					    {data: "businessType",'width':'10%'},
					    {data: "departmentName",'width':'10%'},
					    {data: "mark",'width':'10%'},
					    {data: "money",'width':'10%'},
					    {data: "insertUser",'width':'10%'},
					    {data: "insertTime",'width':'15%'},
					    {data: "status",'width':'10%'},
					    {data: null,'width':'20%'}
						],
					    columnDefs: [
							{
								 //类型
								 targets:1,
								 render: function (data, type, row, meta) {
							         if(data=='0'){
							       	 return '收入'; 
							         }else {
							       	  return '支出';
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
								 targets:8,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
								       	 return '新建'; 
								         }else {
								       	  return '已提交';
								         }
							      }	       
							},

							{
								 //操作
								 targets: 9,
								 render: function (data, type, row, meta) {
									 if(row.status=='0'){
										 return '<a class="table-edit" onclick="dosumbit('+ row.id +')">提交</a>'
									        +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
							                +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
									 }else{
										 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';

									 }
									 
							       }	           
							}
					      ],
				        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

$(function(){
	$("#startTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#endTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	init();
	getDeptList();
})

/* 获取部门 */
function getDeptList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/costApply/getDeptList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="">请选择部门</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	                		}
	            		}
	            	}
	            	$('#dept').html(html);
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
	   $('#secho').val(secho);
	   var type=$('#type').val();
	   var status=$('#status').val();
	   var mark=$('#mark').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var dept = $('#dept').val();
	   var businessType = $('#businessType').val();
	   if(type=='' || type==null || type=='-1'){
		   type="";
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
				businessType : businessType,
				status : status,
				mark : mark,
				startTime : startTime,
				endTime : endTime,
				departmentId:dept
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

/* 新增收支 */
function doadd(){
	refresh();
	$('#modal-add').modal('show');
}

/* 新增保存 */
function addSave(){
	var flag="false";
	   var type=$('#typeInsert').val();
	   var mark=$('#markInsert').val();
	   var money=$('#moneyInsert').val();
	   if(type=='' || type==null || type=='-1'){
		   bootbox.alert('类型不能为空！');
		   return;
	   }
	   if(mark=='' || mark==null){
		   bootbox.alert('事由不能为空！');
		   return;
	   }
	   if(money=='' || money==null){
		   bootbox.alert('金额不能为空！');
		   return;
	   }
	   bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该收支信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : "${ctx}/operationMng/cashInOutMng/save",
							data : JSON.stringify({
								type : type,
								mark : mark,
								money : money
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
												$('#modal-add').modal('hide');
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
	$('#typeInsert').val('0');
	$('#markInsert').val('');
	$('#moneyInsert').val('');
	$('#modal-add').modal('hide');
}

/* 删除收支信息 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该收支信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/cashInOutMng/delete/"+id,
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

/* 提交收支信息 */

function dosumbit(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该油卡信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/cashInOutMng/submit/"+id,
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

/* 编辑收支 --获取收支信息*/
function getInfo(id){
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/cashInOutMng/getDetail/"+id,
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#typeEdit').val(data.data.type);
				$('#markEdit').val(data.data.mark);
				$('#moneyEdit').val(data.data.money);
			} else {
				 bootbox.alert(data.msg);
			}
			
		}
	}); 
}
/* 查看收支 --获取收支信息*/
function getForShow(id){
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/cashInOutMng/getDetail/"+id,
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				if(data.data.type=='0'){
					$('#typeShow').html('收入');
				}else{
					$('#typeShow').html('支出');
				}
				$('#markShow').html(data.data.mark);
				$('#moneyShow').html(data.data.money);
			} else {
				 bootbox.alert(data.msg);
			}
			
		}
	}); 
}
/* 加载编辑信息 */
function doedit(id){
	getInfo(id);
	$('#modal-edit').modal('show');
	$('#updateId').val(id);
}

/* 编辑取消 */
function editRefresh(){
	$('#modal-edit').modal('hide');
	
}

/* 编辑保存 */
function update(){
	var flag="false";
	   var id=parseInt($('#updateId').val());
	   var type=$('#typeEdit').val();
	   var mark=$('#markEdit').val();
	   var money=$('#moneyEdit').val();
	   if(id=='' || id==null){
		   bootbox.alert('数据获取失败，请刷新再试或者联系管理员！');
		   return;
	   }
	   if(type=='' || type==null){
		   bootbox.alert('类型不能为空！');
		   return;
	   }
	   if(mark=='' || mark==null){
		   bootbox.alert('事由不能为空！');
		   return;
	   }
	   if(money=='' || money==null){
		   bootbox.alert('金额不能为空！');
		   return;
	   }
	   bootbox.confirm({ 
			  size: "small",
			  message: "确定要更新该收支信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : "${ctx}/operationMng/cashInOutMng/update",
							data : JSON.stringify({
								id :id,
								type : type,
								mark : mark,
								money : money
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
											$('#modal-edit').modal('hide');
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
	getForShow(id);
	$('#modal-show').modal('show');
}

/* 关闭取消窗口 */
function showRefresh(){
	$('#modal-show').modal('hide');
}

/* 导出 */
function doexport(){
	   var status=$('#status').val();
	   var type=$('#type').val();
	   var mark=$('#mark').val();
	   var startTime=$('#startTime').val();
	   var businessType=$('#businessType').val();
	   var endTime=$('#endTime').val();
	   var dept = $('#dept').val();
	   if(type=='' || type==null || type=='-1'){
		   type="";
	   }
	   if(status=='' || status==null || status=='-1'){
		   status="";
	   }
	   var form = $('<form action="${ctx}/operationMng/cashInOutMng/export" method="post"></form>');
	   var typeInput = $('<input id="type" name="type" value="'+type+'" type="hidden" />');
	   var businessTypeInput = $('<input id="businessType" name="businessType" value="'+businessType+'" type="hidden" />');
	   var statusInput = $('<input id="status" name="status" value="'+status+'" type="hidden" />');
	   var markInput = $('<input id="mark" name="mark" value="'+mark+'" type="hidden" />');
	   var startTimeInput = $('<input id="startTime" name="startTime" value="'+startTime+'" type="hidden" />');
	   var endTimeInput = $('<input id="endTime" name="endTime" value="'+endTime+'" type="hidden" />');
	   var deptInput = $('<input id="departmentId" name="departmentId" value="'+dept+'" type="hidden" />');
	   form.append(typeInput);
	   form.append(businessTypeInput);
	   form.append(statusInput);
	   form.append(markInput);
	   form.append(startTimeInput);
	   form.append(endTimeInput);
	   form.append(deptInput);
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
	   var status=$('#status').val();
	   var type=$('#type').val();
	   var businessType=$('#businessType').val();
	   var mark=$('#mark').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var dept = $('#dept').val();
	   if(type=='' || type==null || type=='-1'){
		   type="";
	   }
	   if(status=='' || status==null || status=='-1'){
		   status="";
	   }
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/operationMng/cashInOutMng/getPrint",
			data : JSON.stringify({
				type : type,
				businessType : businessType,
				mark : mark,
				status : status,
				startTime : startTime,
				endTime : endTime,
				departmentId : dept
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {					
					if(data.data.length>0){
						for(var i=0;i<data.data.length;i++){
							data.data[i]["rownum"]=i+1;
							var type="收入";
							var insertTime="";
							var mark="";
							var money="";
							var insertUser="";
							var status="新建";
							if(data.data[i]["type"]=='1'){
								type="支出";
							}
							if(data.data[i]["status"]=='1'){
								status="已提交";
							}
							if(data.data[i]["insertTime"]!='' && data.data[i]["insertTime"]!=null){
								insertTime=jsonForDateFormat(data.data[i]["insertTime"]);
							}
							if(data.data[i]["mark"]!='' && data.data[i]["mark"]!=null){
								mark=data.data[i]["mark"];
							}
							if(data.data[i]["money"]!='' && data.data[i]["money"]!=null){
								money=data.data[i]["money"];
							}
							if(data.data[i]["insertUser"]!='' && data.data[i]["insertUser"]!=null){
								insertUser=data.data[i]["insertUser"];
							}
							html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
						    +'<td>'+type+'</td>'
						    +'<td>'+data.data[i]["businessType"]+'</td>'
						    +'<td>'+data.data[i]["departmentName"]+'</td>'
						    +'<td>'+mark+'</td>'
						    +'<td>'+money+'</td>'
						    +'<td>'+insertUser+'</td>'
						    +'<td>'+insertTime+'</td>'
						    +'<td>'+status+'</td>'
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


</script>



</body>
</html>






