
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/datetimepicker.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->

</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			查询管理
			<small>
				<i class="icon-double-angle-right"></i>
				折损维修登记查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">折损车架号：</label>
		   <input id="vinSearch" class="form-box" type="text" placeholder="请输入折损车架号" style="width:170px;"/>
		    <label class="title">维修项目：</label>
		   <input id="repairContentSearch" class="form-box" type="text" placeholder="请输入维修项目" style="width:170px;"/>
		   <label class="title">登记人：</label>
		   <input id="nameSearch" class="form-box" type="text" placeholder="请输入登记人" style="width:170px;"/>
		</div>
		<div class="searchbox col-xs-12">
		   <label class="title">维修厂：</label>
		   <input id="repairCompanySearch" class="form-box" type="text" placeholder="请输入维修厂" style="width:170px;"/>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 18px;">登记时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 170px;margin-right:42px; margin-left: 5px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入登记开始时间" />
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 13px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 170px;margin-right:33px;margin-left: 30px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入登记结束时间" />
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		</div>
		<div class="searchbox col-xs-12">
		    <label class="title" style="margin-right:48px;">状态：</label>
		    <select id="typeSearch" class="form-box" style="width:170px;">
		     <option value="">请选择状态</option>
		     <option value="0">新建</option>
		     <option value="1">修理中</option>
		     <option value="2">已完成</option>
		    </select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="printInfo()">打印</a>
			<a class="itemBtn" onclick="exportInfo()">导出</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>折损车架号</th>
					<th>维修项目</th>
                    <th>维修厂</th>
                    <th>维修电话</th>
                    <th>预计修好时间</th>
                    <th>状态</th>
                    <th>登记人</th>
                    <th>登记时间</th>
                    <th>取车人</th>
                    <th>取车时间</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			 <!-- 查看 -->
			 <div class="modal fade modal-reset" id="modal-view" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog dia-widget-box" style="padding:0;width:100%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="viewrefresh();">×</button>
						<h3 id="myModalLabel">查看折损维修登记</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>折损车架号：</label>
								     <p id="scarStockInfo" class="form-control no-border"></p>
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>登记人：</label>
								     <p id="sapplyUser" class="form-control no-border"></p>
								    </div>
							  		<hr class="tree"></hr>
								     <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>登记时间：</label>
									     <p id="sapplyTime" class="form-control no-border"></p>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
								      <label class="title"><span class="red">*</span>预计修好时间：</label>
								      <p id="srepairFinishedTime" class="form-control no-border"></p>
								    </div>
								    <hr class="tree"></hr>
								     <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>维修项目：</label>
									     <p id="srepairContent" class="form-control no-border"></p>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>维修厂：</label>
									     <p id="srepairCompany" class="form-control no-border"></p>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>维修电话：</label>
									     <p id="srepairTelephone" class="form-control no-border"></p>
									 </div>
									 <hr class="tree"></hr>
									 <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>取车人：</label>
									     <p id="sfinishUser" class="form-control no-border"></p>
									 </div>
									 <hr class="tree"></hr>
									 <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>取车时间：</label>
									     <p id="sfinishTime" class="form-control no-border"></p>
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
				<h2>折损维修登记记录表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>														
					<th>序号</th>
					<th>折损车架号</th>
					<th>维修项目</th>
                    <th>维修厂</th>
                    <th>维修电话</th>
                    <th>预计修好时间</th>
                    <th>状态</th>
                    <th>登记人</th>
                    <th>登记时间</th>
                    <th>取车人</th>
                    <th>取车时间</th>                                                        
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
<script src="${ctx}/staticPublic/js/jsonDataFormat.js"></script>
<script src="${ctx}/staticPublic/js/jquery.dataTables.bootstrap.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script>
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
		 "sAjaxSource": "${ctx}/operationMng/trackRepairApply/searchListData" , //获取数据的ajax方法的URL							 
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
		    {data: "vin","width":"10%"},
		    {data: "repairContent","width":"7%"},
		    {data: "repairCompany","width":"7%"},
		    {data: "repairTelephone","width":"8%"},
		    {data: "repairFinishedTime","width":"10%"},
		    {data: "status","width":"5%"},
		    {data: "name","width":"5%"},
		    {data: "applyTime","width":"9%"},
		    {data: "finishUser","width":"5%"},
		    {data: "finishTime","width":"9%"},
		    {data: null,"width":"20%"}],
		    columnDefs: [
                {
                	//修好时间
			    	 targets: 5,
			    	 render: function (data, type, row, meta) {
			    		 if(data!=null && data!=''){
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
		                    }else if(data=='1'){
		                    	return '修理中';
		                    }else if(data=='2'){
		                    	return '已完成';
		                    }else{
		                    	return data;
		                    }
		                }	
                },
                {
                	//时间
			    	 targets: 8,
			    	 render: function (data, type, row, meta) {
			    		 if(data!=null && data!=''){
		                	  return jsonDateFormat(data);
		                   }else{
		                	   return '';
		                   }
		                }	
                },
                {
                	//取车时间
			    	 targets: 10,
			    	 render: function (data, type, row, meta) {
			    		 if(data!=null && data!=''){
		                	  return jsonDateFormat(data);
		                   }else{
		                	   return '';
		                   }
		                }	
                },
                
		      	{
			    	 //操作栏
			    	 targets: 11,
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
		 "sAjaxSource": "${ctx}/operationMng/trackRepairApply/searchListData" , //获取数据的ajax方法的URL	
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
						    {data: "vin","width":"10%"},
						    {data: "repairContent","width":"7%"},
						    {data: "repairCompany","width":"7%"},
						    {data: "repairTelephone","width":"8%"},
						    {data: "repairFinishedTime","width":"10%"},
						    {data: "status","width":"5%"},
						    {data: "name","width":"5%"},
						    {data: "applyTime","width":"9%"},
						    {data: "finishUser","width":"5%"},
						    {data: "finishTime","width":"9%"},
						    {data: null,"width":"20%"}],
						    columnDefs: [
				                {
				                	//修好时间
							    	 targets: 5,
							    	 render: function (data, type, row, meta) {
							    		 if(data!=null && data!=''){
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
						                    }else if(data=='1'){
						                    	return '修理中';
						                    }else if(data=='2'){
						                    	return '已完成';
						                    }else{
						                    	return data;
						                    }
						                }	
				                },
				                {
				                	//时间
							    	 targets: 8,
							    	 render: function (data, type, row, meta) {
							    		 if(data!=null && data!=''){
						                	  return jsonDateFormat(data);
						                   }else{
						                	   return '';
						                   }
						                }	
				                },
				                {
				                	//取车时间
							    	 targets: 10,
							    	 render: function (data, type, row, meta) {
							    		 if(data!=null && data!=''){
						                	  return jsonDateFormat(data);
						                   }else{
						                	   return '';
						                   }
						                }	
				                },
				                
						      	{
							    	 //操作栏
							    	 targets: 11,
							    	 render: function (data, type, row, meta) {
							    		 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
						                    
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

$(function(){
	init();
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

})


/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var vin=$('#vinSearch').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var name=$('#nameSearch').val();
	   var repairContent=$('#repairContentSearch').val();
	   var repairCompany=$('#repairCompanySearch').val();
	   var status=$('#typeSearch').val();
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
				vin : $.trim(vin),
				startTime : $.trim(startTime),
				endTime :$.trim(endTime),
				name :$.trim(name),
				repairContent : $.trim(repairContent),
				repairCompany :$.trim(repairCompany),
				status :status
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


/* 查看申请详细信息 */
function doshow(id){
	var ids=parseInt(id);
	var applyTime='';
	var repairFinishedTime='';
	var finishTime='';
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackRepairApply/getDetail/"+ids,
		data :{},
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				if(data.data.applyTime!=null && data.data.applyTime!=''){
					 applyTime=jsonForDateMinutFormat(data.data.applyTime);
				}
				if(data.data.repairFinishedTime!=null && data.data.repairFinishedTime!=''){
					repairFinishedTime=jsonForDateMinutFormat(data.data.repairFinishedTime);
				}
				if(data.data.finishTime!=null && data.data.finishTime!=''){
					finishTime=jsonForDateMinutFormat(data.data.finishTime);
				}
				$('#scarStockInfo').html(data.data.vin);
				$('#sapplyUser').html(data.data.name);
				$('#sapplyTime').html(applyTime);
				$('#srepairContent').html(data.data.repairContent);
				$('#srepairCompany').html(data.data.repairCompany);
				$('#srepairTelephone').html(data.data.repairTelephone);
				$('#srepairFinishedTime').html(repairFinishedTime);
				$('#sfinishUser').html(data.data.finishUser);
				$('#sfinishTime').html(finishTime);
				$('#modal-view').modal('show');
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
/* 关闭查看窗口 */
function viewrefresh(){
	$('#modal-view').modal('hide');
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
	   var vin=$('#vinSearch').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var name=$('#nameSearch').val();
	   var repairContent=$('#repairContentSearch').val();
	   var repairCompany=$('#repairCompanySearch').val();
	   var status=$('#typeSearch').val();
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/operationMng/trackRepairApply/getPrint",
			data : JSON.stringify({
				vin : $.trim(vin),
				startTime : $.trim(startTime),
				endTime :$.trim(endTime),
				name :$.trim(name),
				repairContent : $.trim(repairContent),
				repairCompany :$.trim(repairCompany),
				status :status,
				all :'0'
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
							}else if(data.data[i]["status"]=='1'){
								data.data[i]["status"]='修理中';
							}else if(data.data[i]["status"]=='2'){
								data.data[i]["status"]='已完成';
							}
							if(data.data[i]["repairFinishedTime"]==null || data.data[i]["repairFinishedTime"]=='' || parseInt(data.data[i]["operateTime"])<0){
								data.data[i]["repairFinishedTime"]=''; 
							 }else{
								 data.data[i]["repairFinishedTime"]=jsonDateFormat(data.data[i]["repairFinishedTime"]);
							 }
							if(data.data[i]["applyTime"]==null || data.data[i]["applyTime"]=='' || parseInt(data.data[i]["applyTime"])<0){
								data.data[i]["applyTime"]=''; 
							 }else{
								 data.data[i]["applyTime"]=jsonDateFormat(data.data[i]["applyTime"]);
							 }
							if(data.data[i]["finishTime"]==null || data.data[i]["finishTime"]=='' || parseInt(data.data[i]["finishTime"])<0){
								data.data[i]["finishTime"]=''; 
							 }else{
								 data.data[i]["finishTime"]=jsonDateFormat(data.data[i]["finishTime"]);
							 }
							if(data.data[i]["name"]=='' || data.data[i]["name"]==null){
								data.data[i]["name"]='';
							}
							if(data.data[i]["vin"]=='' || data.data[i]["vin"]==null){
								data.data[i]["vin"]='';
							}
							if(data.data[i]["repairContent"]=='' || data.data[i]["repairContent"]==null){
								data.data[i]["repairContent"]='';
							}
							if(data.data[i]["repairCompany"]=='' || data.data[i]["repairCompany"]==null){
								data.data[i]["repairCompany"]='';
							}
							if(data.data[i]["repairTelephone"]=='' || data.data[i]["repairTelephone"]==null){
								data.data[i]["repairTelephone"]='';
							}
							if(data.data[i]["finishUser"]=='' || data.data[i]["finishUser"]==null){
								data.data[i]["finishUser"]='';
							}
								html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
							    +'<td>'+data.data[i]["vin"]+'</td>'
							    +'<td>'+data.data[i]["repairContent"]+'</td>'
							    +'<td>'+data.data[i]["repairCompany"]+'</td>'
							    +'<td>'+data.data[i]["repairTelephone"]+'</td>'
							    +'<td>'+data.data[i]["repairFinishedTime"]+'</td>'
							    +'<td>'+data.data[i]["status"]+'</td>'
							    +'<td>'+data.data[i]["name"]+'</td>'							    							    
							    +'<td>'+data.data[i]["applyTime"]+'</td>'
							    +'<td>'+data.data[i]["finishUser"]+'</td>'
							    +'<td>'+data.data[i]["finishTime"]+'</td></tr>';	
						      
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
		 pageSize: 20
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
	  var all='0';
	   var vin=$('#vinSearch').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var name=$('#nameSearch').val();
	   var repairContent=$('#repairContentSearch').val();
	   var repairCompany=$('#repairCompanySearch').val();
	   var status=$('#typeSearch').val();
	   var form = $('<form action="${ctx}/operationMng/trackRepairApply/export" method="post"></form>');
	   var vinInput = $('<input id="vin" name="vin" value="'+vin+'" type="hidden" />');
	   var startTimeInput = $('<input id="startTime" name="startTime" value="'+startTime+'" type="hidden" />');
	   var endTimeInput = $('<input id="endTime" name="endTime" value="'+endTime+'" type="hidden" />');	   
	   var nameInput = $('<input id="name" name="name" value="'+name+'" type="hidden" />');
	   var repairContentInput = $('<input id="repairContent" name="repairContent" value="'+repairContent+'" type="hidden" />');
	   var repairCompanyInput = $('<input id="repairCompany" name="repairCompany" value="'+repairCompany+'" type="hidden" />');
	   var statusInput = $('<input id="status" name="status" value="'+status+'" type="hidden" />');
	   var allInput = $('<input id="all" name="all" value="'+all+'" type="hidden" />');
	   form.append(vinInput);
	   form.append(startTimeInput);
	   form.append(endTimeInput);
	   form.append(nameInput);
	   form.append(repairContentInput);
	   form.append(repairCompanyInput);
	   form.append(statusInput);
	   form.append(allInput);
	   $('body').append(form);
	   form.submit();
}
</script>



</body>
</html>






