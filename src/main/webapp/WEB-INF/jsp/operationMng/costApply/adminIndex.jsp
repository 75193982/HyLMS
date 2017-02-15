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
			查询管理
			<small>
				<i class="icon-double-angle-right"></i>
				预付申请查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">申请时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 170px;height:34px;margin-right:37px; margin-left: 5px;">
				<input class="form-control" id="applyStartTime" type="text" placeholder="请输入时间" style="height: 34px;font-size: 14px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 23px;width:39px;">到</label>
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
		 "sAjaxSource": "${ctx}/operationMng/costApply/getAdminListData" , //获取数据的ajax方法的URL							 
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
			    			 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
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
		 "sAjaxSource": "${ctx}/operationMng/costApply/getAdminListData" , //获取数据的ajax方法的URL	
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
												return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
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
				$('#billNo_view').html(data.data.billNo);
				$("#dep_view").html(data.data.departmentName);
				$("#applyUser_view").html(data.data.applyUserName); 
				if(data.data.applyTime!=''&&data.data.applyTime!=null){
					$("#applyTime_view").html(jsonDateFormat(data.data.applyTime)); 	
				}else{
					$("#applyTime_view").html(''); 
				}
				
				$("#type_view").html(data.data.typeName);
				$("#name_view").html(data.data.name);
				$("#amount_view").html(data.data.amount);
				if(data.data.startTime!=''&&data.data.startTime!=null){
					$("#startTime_view").html(jsonDateFormat(data.data.startTime)); 	
				}else{
					$("#startTime_view").html(''); 
				}
				if(data.data.endTime!=''&&data.data.endTime!=null){
					$("#endTime_view").html(jsonDateFormat(data.data.endTime)); 	
				}else{
					$("#endTime_view").html(''); 
				}
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
</script>

</body>
</html>