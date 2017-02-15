<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>派车指令管理</title>
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
#modal-info{
    width: 650px;
    height: 400px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }
    #modal-infoe{
    width: 650px;
    height: 400px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }
    #modal-upload{
    width: 600px;
    height: 400px;
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
				派车指令管理
			</small>
		</h1>
	</div>
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
	                    <th>始发地</th>
	                    <th>目的地</th>
	                    <th>创建时间</th> 
	                    <th>状态</th>                                           
	                    <th>操作</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			<!-- 派车指令信息新增 开始 -->
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" onclick="exit()">×</button>
					<h3 id="myModalLabel">新增派车指令信息</h3>
				</div>
				<div class="modal-body"  style="height:330px;overflow:auto;">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>装运车号：</label>
							     <select class="form-control" id="carNumber_new">
				                  <option value="">请选择装运车号</option>
				                   </select>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>始发地：</label>
							      <input class="form-control" id="startAddress_new" type="text" placeholder="请输入始发地 "/>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>目的地：</label>
							     <input class="form-control" id="endAddress_new" type="text" placeholder="请输入目的地 "/>						    
							 </div>
							  
							  <hr class="tree" style="margin-top:60px;"></hr>
										<div class="add-item-btn" id="addBtn">
											<a class="add-itemBtn btnOk" onclick="doaddsave();">保存</a>
											<a class="add-itemBtn btnCancle" onclick="exit();">关闭</a>
										</div>										
									</div>
						  </div>
					</div>
				</div>
				</div>			
			</div>
			
				<!-- 派车指令信息编辑 -->
			<div class="modal fade" id="modal-infoe" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" onclick="editexit()">×</button>
					<h3 id="myModalLabel">编辑派车指令信息</h3>
				</div>
				<div class="modal-body"  style="height:300px;overflow:auto;">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body" style="height: 250px;">
								<div class="widget-main" style="height: 200px;">
							<div class="add-item extra-itemSec">
							     <label class="title">装运车号：</label>
							     <select class="form-control" id="carNumber_edit">
				                  <option value="">请选择装运车号</option>
				                   </select>
							  </div>
							  <input class="form-control" id="id-hidden" type="hidden"/> 
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">始发地：</label>
							      <input class="form-control" id="startAddress_edit" type="text" />
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title">目的地：</label>
							     <input class="form-control" id="endAddress_edit" type="text" />						    
							 </div>
							  
							  <hr class="tree" style="margin-top:30px;"></hr>
										<div class="add-item-btn" id="editBtn">
											<a class="add-itemBtn btnOk" onclick="doeditsave();">保存</a>
											<a class="add-itemBtn btnCancle" onclick="editexit();">关闭</a>
										</div>										
									</div>
						  </div>
					</div>
				</div>
				</div>			
			</div>
		 <!-- 出险信息明细查看 开始-->
		 <div class="modal fade" id="modal-upload" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal" >×</button>
					<h3 id="myModalLabel">查看派车指令信息</h3>
				</div>
				<div class="modal-body" style="height:310px;overflow:auto;">
					<div class="mng" style="min-height:250px;">						
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
										<label class="title">始发地:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="startAddress_view" class="form-control no-border"></p>
									</div>
								</div>							
							</div>
							<!-- 第三列 -->
							<div class="row newrow">
							<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">目的地:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="endAddress_view" class="form-control no-border"></p>
									</div>
								</div>																
								</div>								
							</div>	
							<!-- 操作按钮栏 -->
							<!-- <div class="row newrow">
								<div class="col-xs-5"></div>
								<div class="col-xs-2">
									<div class="form-contr">
										<a class="backbtn" onclick="doback();"><i
											class="icon-undo" style="display: inline-block; width: 20px;"></i>关闭</a>
									</div>
								</div>
								<div class="col-xs-5"></div>
							</div> -->
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
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script>
<script src="${ctx}/staticPublic/js/bootstrap-tab.js"></script>
 <script src="${ctx}/staticPublic/js/date-time/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
function init(){	
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/sendCarCommand/getListData" , //获取数据的ajax方法的URL							 
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
				columns: [{ data: "rownum" ,"width":"5%"},
						    {data: "carNumber","width":"15%"},
						    {data: "startAddress","width":"15%"},
						    {data: "endAddress","width":"15%"},
						    {data: "insertTime","width":"15%"},
						    {data: "status","width":"15%"},			    	
						    {data: null,"width":"20%"}],
		    columnDefs: [{
				 //时间
				 targets: 4,
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
					  if(data=='0'){
						 return '新建';
					 }else if(data=='1'){
						 return '待驾驶员确认';
					 }else if(data=='2'){
						 return '待驾驶员到达确认';
					 }else if(data=='3'){
						 return '已完成';
					 }else {
						 return '';
					 }					
			       }	       
			},{//操作栏
			    	 targets: 6,
			    	 render: function (data, type, row, meta) {		
			    		 if(row.status=='0'){
			    			 return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
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
		 "sAjaxSource": "${ctx}/operationMng/sendCarCommand/getListData", //获取数据的ajax方法的URL	
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
				columns: [{ data: "rownum","width":"5%" },
						    {data: "carNumber","width":"15%"},
						    {data: "startAddress","width":"15%"},
						    {data: "endAddress","width":"15%"},
						    {data: "insertTime","width":"15%"},
						    {data: "status","width":"15%"},			    	
						    {data: null,"width":"20%"}],
		    columnDefs: [{
				 //时间
				 targets: 4,
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
					 if(data=='0'){
						 return '新建';
					 }else if(data=='1'){
						 return '待驾驶员确认';
					 }else if(data=='2'){
						 return '待驾驶员到达确认';
					 }else if(data=='3'){
						 return '已完成';
					 }else {
						 return '';
					 }					
			       }	       
			},{//操作栏
			    	 targets: 6,
			    	 render: function (data, type, row, meta) {		
			    		 if(row.status=='0'){
			    			 return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
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
	getStockList();
	
});

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
	                			html +='<option value='+data.data[i]['no']+' data-driver='+data.data[i]['driver']+' >'+data.data[i]['no']+'</option>';
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
	   //var type='1';
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
				carNumber :$.trim(carNumber) ,
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

/* 新增信息 */	
function doadd(){
	clear();
	$('#addBtn').show();
	$('#myModalLabel').html('新增派车指令信息');	
	$('#modal-info').modal('show');
}

/* 数据重置 */
function clear(){
	$('#carNumber_new').val('');		
	$('#startAddress_new').val('');
	$('#startAddress_new').val('');
}

function exit()
{
	clear();
	$('#modal-info').modal('hide');
}
//保存
function doaddsave(){
	var flag="false";
	var carNumber=$("#carNumber_new").val(); 
	var startAddress=$("#startAddress_new").val(); 
	var endAddress=$("#endAddress_new").val(); 
	if(carNumber==''){
		bootbox.alert('装运车号不能为空！');
		return;
	}if(startAddress==''){
		bootbox.alert('始发地不能为空！');
		return;
	}if(endAddress==''){
		bootbox.alert('目的地不能为空！');
		return;
	}
	 var obj={};
	   obj.carNumber=carNumber;
	   obj.startAddress=startAddress;
	   obj.endAddress=endAddress;
	   
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该派车指令信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/sendCarCommand/save',
						data : JSON.stringify(obj),
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
											 exit();
								             reload();
										  }else{
											exit();
								            reload(); 
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										exit();
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

function editexit()
{
	$('#modal-infoe').modal('hide');
}
//打开编辑页面
function doedit(id){		
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/sendCarCommand/getDetailData/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				$('#id-hidden').val(id);				
				$("#carNumber_edit").val(data.data.carNumber);
				$("#startAddress_edit").val(data.data.startAddress); 
				$("#endAddress_edit").val(data.data.endAddress); 
				$('#modal-infoe').modal('show');
				$('#editBtn').show();							
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}

//更新保存
function doeditsave(){
	var flag="false";
	var id = $("#id-hidden").val();
	var carNumber=$("#carNumber_edit").val(); 
	var startAddress=$("#startAddress_edit").val(); 
	var endAddress=$("#endAddress_edit").val(); 
	if(carNumber==''){
		bootbox.alert('装运车号不能为空！');
		return;
	}if(startAddress==''){
		bootbox.alert('始发地不能为空！');
		return;
	}if(endAddress==''){
		bootbox.alert('目的地不能为空！');
		return;
	}
	 var obj={};
	 obj.id = id;
	   obj.carNumber=carNumber;
	   obj.startAddress=startAddress;
	   obj.endAddress=endAddress;
	   
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该派车指令信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/sendCarCommand/save',
						data : JSON.stringify(obj),
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
											 editexit();
								             reload();
										  }else{
											editexit();
								            reload(); 
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										editexit();
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

//删除
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该派车指令信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/sendCarCommand/delete/"+id,
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

//提交
function dosubmit(id)
{
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该派车指令信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'GET',
						url : '${ctx}/operationMng/sendCarCommand/submit/'+id,
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
											 //refresh();
								             reload();
										  }else{
											//refresh();
								            reload(); 
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										//refresh();
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


//查看
function doview(id)
{
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/sendCarCommand/getDetailData/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$("#carNumber_view").html(data.data.carNumber); 
				$("#startAddress_view").html(data.data.startAddress);  
				$("#endAddress_view").html(data.data.endAddress); 
				$('#modal-upload').modal('show');
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 	
}

</script>
</body>
</html>