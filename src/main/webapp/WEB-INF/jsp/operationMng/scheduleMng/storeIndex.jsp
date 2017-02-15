
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
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->


</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			运营管理
			<small>
				<i class="icon-double-angle-right"></i>
				仓管员调度管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">装运时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 180px;margin-right:15px; margin-left: 5px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入时间"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 13px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 180px;margin-right:15px;margin-left: 5px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入时间"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			<label class="title">装运车号：</label>
		    <input id="carNumber" class="form-box" type="text" placeholder="请输入装运车号" style="width:180px;"/>
		    <a class="itemBtn" onclick="searchInfo()" style="width:60px;">查询</a>
			<!-- <a class="itemBtn" onclick="doadd()" style="width:60px;">新增</a> -->
		</div>		
		
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>调度单号</th>
					<th>装运时间</th>
                    <th>交车时间</th>
                    <th>预计到达时间</th>
                    <th>货运车号</th>
                    <th>驾驶员</th>
                    <th>数量</th>
                    <th>内容</th>
                    <th>状态</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>						
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
<script type="text/javascript">
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/scheduleMng/getOwnListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum","width":"6%"},
		    {data: "scheduleBillNo","width":"9%"},
		    {data: "sendTime","width":"10%"},
		    {data: "receiveTime","width":"10%"},
		    {data: "planReachTime","width":"10%"},
		    {data: "carNumber","width":"10%"},
		    {data: "driver","width":"7%"},
		    {data: "amount","width":"10%"},
		    {data: "mark","width":"10%"},
		    {data: "status","width":"8%"},
		    {data: null,"width":"8%"}],
		    columnDefs: [
					{
						//时间
						 targets:2,
						 render: function (data, type, row, meta) {
					           if(data!=''&&data!=null){
									 return jsonForDateFormat(data);
								 }else{
									 return '';
								 }
					       }	       
					},
					{
						//时间
						 targets:3,
						 render: function (data, type, row, meta) {
							 if(data!=''&&data!=null){
								 return jsonForDateFormat(data);
							 }else{
								 return '';
							 }
					       }	       
					},
					{
						//时间
						 targets:4,
						 render: function (data, type, row, meta) {
							 if(data!=''&&data!=null){
								 return jsonForDateFormat(data);
							 }else{
								 return '';
							 }
					       }	       
					},
					{
					 //状态
					 targets:9,
					 render: function (data, type, row, meta) {
				           if(data=='0'){
				        	   return '新建';
				           }
				           if(data=='1'){
				        	   return '待复核';
				           }
				           if(data=='2'){
				        	   return '待仓管员已确认';
				           }
				           if(data=='3'){
				        	   return '待驾驶员确认';
				           }
				           if(data=='4'){
				        	   return '在途';
				           }
				           if(data=='5'){
				        	   return '已完成';
				           }else{
				        	   return '';
				           }
				       }	       
				},
				{
			    	 //操作栏
			    	 targets: 10,
			    	 render: function (data, type, row, meta) {
			    		 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this)">查看</a>' ;
		                    
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
		 "sAjaxSource": "${ctx}/operationMng/scheduleMng/getOwnListData" , //获取数据的ajax方法的URL	
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
				columns: [{ data: "rownum","width":"6%"},
						    {data: "scheduleBillNo","width":"9%"},
						    {data: "sendTime","width":"10%"},
						    {data: "receiveTime","width":"10%"},
						    {data: "planReachTime","width":"10%"},
						    {data: "carNumber","width":"10%"},
						    {data: "driver","width":"7%"},
						    {data: "amount","width":"10%"},
						    {data: "mark","width":"10%"},
						    {data: "status","width":"8%"},
						    {data: null,"width":"8%"}],
						    columnDefs: [
						 				{
						 					//时间
						 					 targets:2,
						 					 render: function (data, type, row, meta) {
						 						 if(data!=''&&data!=null){
													 return jsonForDateFormat(data);
												 }else{
													 return '';
												 }
						 				       }	       
						 				},
						 				{
						 					//时间
						 					 targets:3,
						 					 render: function (data, type, row, meta) {
						 						 if(data!=''&&data!=null){
													 return jsonForDateFormat(data);
												 }else{
													 return '';
												 }
						 				       }	       
						 				},
						 				{
						 					//时间
						 					 targets:4,
						 					 render: function (data, type, row, meta) {
						 						 if(data!=''&&data!=null){
													 return jsonForDateFormat(data);
												 }else{
													 return '';
												 }
						 				       }	       
						 				},
						 				{
						 					 //状态
						 					 targets:9,
						 					 render: function (data, type, row, meta) {
						 				           if(data=='0'){
						 				        	   return '新建';
						 				           }
						 				           if(data=='1'){
						 				        	   return '待复核';
						 				           }
						 				           if(data=='2'){
						 				        	   return '待仓管员已确认';
						 				           }
						 				           if(data=='3'){
						 				        	   return '待驾驶员确认';
						 				           }
						 				           if(data=='4'){
						 				        	   return '在途';
						 				           }
						 				           if(data=='5'){
						 				        	   return '已完成';
						 				           }else{
										        	   return '';
										           }
						 				       }	       
						 				},
						 				{
									    	 //操作栏
									    	 targets: 10,
									    	 render: function (data, type, row, meta) {
									    		 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this)">查看</a>' ;
								                    
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
});

/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var status=$.trim($('#status').val());
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
				sendTimeStart : $.trim($('#startTime').val()),
				sendTimeEnd :$.trim($('#endTime').val()),
				carNumber :$.trim($('#carNumber').val())
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

/* 查看详细调度信息 */
function doshow(e){
	var scheduleBillNo=$(e).attr("data-scheduleBillNo");
	scheduleBillNo=scheduleBillNo+"@store"
	location.href="${ctx}/operationMng/scheduleMng/detailIndex/"+scheduleBillNo;
}

</script>



</body>
</html>






