
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
				办公费用管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">时&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 180px;margin-right:15px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width:28px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 180px;margin-right:15px;height: 34px;line-height: 34px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			<label class="title" >申请事由：</label>
		    <input id="itemName" class="form-box" type="text" placeholder="请输入申请事由" />
			<a class="itemBtn" onclick="searchInfo()" style="width:60px;margin-left:5px;margin-right:5px;">查询</a>
			<a class="itemBtn" onclick="doprint()" style="width:60px;margin-left:5px;margin-right:5px;">打印</a>
			<a class="itemBtn" onclick="doexport()" style="width:60px;margin-left:5px;margin-right:5px;">导出</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>申请类型</th>
					<th>部门</th>					
                    <th>申请人</th>
                    <th>申请事由</th>	                  
                    <th>申请金额</th>
                    <th>预付金额</th>
                    <th>申请时间</th> 
                    <th>状态</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
		</div>
	</div>
	</div>	
</div>
<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>办公费用管理信息表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>
		            <th>序号</th>
					<th>申请类型</th>
					<th>部门</th>					
                    <th>申请人</th>
                    <th>申请事由</th>	                  
                    <th>申请金额</th>
                    <th>预付金额</th>
                    <th>申请时间</th> 
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
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
function init(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/dailyOffice/officeApply/getListData" , //获取数据的ajax方法的URL							 
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
		           {data: "typeName",'width':'10%'},
				    {data: "depName",'width':'10%'},				   
				    {data: "applyUserName",'width':'10%'},
				    {data: "itemName",'width':'20%'},				   
				    {data: "amount",'width':'10%'},
				    {data: "cashAdvance",'width':'10%'},
				    {data: "applyTime",'width':'15%'},
				    {data: "status",'width':'10%'}
					],
				    columnDefs: [{
							 //类型
							 targets:7,
							 render: function (data, type, row, meta) {
						        if(data!=''&&data!=null){
									 return jsonDateFormat(data);
								 }else{
									 return '';
								 }
						     }	       
						},{
							 //类型
							 targets:8,
							 render: function (data, type, row, meta) {
						        if(data =='0'){
									 return '新建';
								 }else if(data =='1'){
									 return '流转中';
								 }else{
									 return '完成';
								 }
						     }	       
						},
						{
							 //money
							 targets:5,
							 render: function (data, type, row, meta) {
						        if(data==null || data==''){
						        	return 0;
						        }else{
						        	return data;
						        }
						     }	       
						},
						{
							 //money
							 targets:6,
							 render: function (data, type, row, meta) {
								 if(data==null || data==''){
							        	return 0;
						        }else{
						        	return data;
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
		 "sAjaxSource": "${ctx}/dailyOffice/officeApply/getListData" , //获取数据的ajax方法的URL	
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
			           {data: "typeName",'width':'10%'},
					    {data: "depName",'width':'10%'},				   
					    {data: "applyUserName",'width':'10%'},
					    {data: "itemName",'width':'20%'},				   
					    {data: "amount",'width':'10%'},
					    {data: "cashAdvance",'width':'10%'},
					    {data: "applyTime",'width':'15%'},
					    {data: "status",'width':'10%'}
						],
					    columnDefs: [{
								 //类型
								 targets:7,
								 render: function (data, type, row, meta) {
							        if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }
							     }	       
							},{
								 //类型
								 targets:8,
								 render: function (data, type, row, meta) {
							        if(data =='0'){
										 return '新建';
									 }else if(data =='1'){
										 return '流转中';
									 }else{
										 return '完成';
									 }
							     }	       
							},
							{
								 //money
								 targets:5,
								 render: function (data, type, row, meta) {
							        if(data==null || data==''){
							        	return 0;
							        }else{
							        	return data;
							        }
							     }	       
							},
							{
								 //money
								 targets:6,
								 render: function (data, type, row, meta) {
									 if(data==null || data==''){
								        	return 0;
							        }else{
							        	return data;
							        }
							     }	       
							}
					      ],
				        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

$(function(){
	/* $("#startTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#endTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	}); */
	
	$("#startTime").datetimepicker({
		language: 'cn',
	      format: "yyyy-mm-dd hh:ii",
	      autoclose: true,//选中之后自动隐藏日期选择框
	      todayBtn: true
	});
 
 $("#endTime").datetimepicker({
		language: 'cn',
	      format: "yyyy-mm-dd hh:ii",
	      autoclose: true,//选中之后自动隐藏日期选择框
	      todayBtn: true
	});
	init();
})

/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   $('#secho').val(secho);
	   var itemName=$('#itemName').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				itemName : itemName,
				sign : 1,
				startTime : startTime,
				endTime : endTime
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
	   var itemName=$('#itemName').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();  
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/dailyOffice/officeApply/print",
			data : JSON.stringify({
				itemName : itemName,
				startTime : startTime,
				endTime : endTime
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {					
					if(data.data.length>0){
						for(var i=0;i<data.data.length;i++){
							  var applyTime="";
							  var statusname="";
							   data.data[i]["rownum"]=i+1;	
							   if(data.data[i]["cashAdvance"]==null || data.data[i]["cashAdvance"]==""){
								   data.data[i]["cashAdvance"]='0';
							   }
							   if(data.data[i]["amount"]==null || data.data[i]["amount"]==""){
								   data.data[i]["amount"]='0';
							   }
							   if(data.data[i]["amount"]==null){
								   data.data[i]["amount"]='';
							   }
							   if(data.data[i]["depName"]==null){
								   data.data[i]["depName"]='';
							   }
							   if(data.data[i]["typeName"]==null){
								   data.data[i]["typeName"]='';
							   }
							   if(data.data[i]["applyUserName"]==null){
								   data.data[i]["applyUserName"]='';
							   }
							   if(data.data[i]["itemName"]==null){
								   data.data[i]["itemName"]='';
							   }
							   if(data.data[i]["applyTime"]!='' && data.data[i]["applyTime"]!=null){
								   applyTime=jsonDateFormat(data.data[i]["applyTime"]);
							   }
							   if(data.data[i]["status"]=='0'){
								   statusname='新建';
							   }else if(data.data[i]["status"]=='1'){
								   statusname='流转中';
							   }else{
								   statusname='完成';
							   }
								html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
								+'<td>'+data.data[i]["typeName"]+'</td>'
							    +'<td>'+data.data[i]["depName"]+'</td>'							    
							    +'<td>'+data.data[i]["applyUserName"]+'</td>'
							    +'<td>'+data.data[i]["itemName"]+'</td>'							   
							    +'<td>'+data.data[i]["amount"]+'</td>'
							    +'<td>'+data.data[i]["cashAdvance"]+'</td>'
							    +'<td>'+applyTime+'</td>'
							    +'<td>'+statusname+'</td></tr>';	
						      
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
		 pageSize: 12
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
	   var itemName=$('#itemName').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var form = $('<form action="${ctx}/dailyOffice/officeApply/export" method="post"></form>');
	   var itemNameInput = $('<input id="itemName" name="itemName" value="'+itemName+'" type="hidden" />');	   
	   var startTimeInput = $('<input id="startTime" name="startTime" value="'+startTime+'" type="hidden" />');
	   var endTimeInput = $('<input id="endTime" name="endTime" value="'+endTime+'" type="hidden" />');
	   form.append(itemNameInput);
	   form.append(startTimeInput);
	   form.append(endTimeInput);
	   $('body').append(form);
	   form.submit();
}


</script>



</body>
</html>






