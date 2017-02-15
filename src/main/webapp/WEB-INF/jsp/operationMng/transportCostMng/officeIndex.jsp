
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/datetimepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
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
				驾驶员报销申请管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title mul-title" style="float: left;height: 34px;line-height: 34px;width: 75px;text-align:left;">时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 180px;margin-right:15px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width:68px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 180px;margin-right:20px;height: 34px;line-height: 34px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			<label class="title" style="float: left;height: 34px;line-height: 34px;">调度单号：</label>
			<input id="scheduleBillNo" class="form-box mul-form-box" type="text" placeholder="请输入调度单号" style="width:180px;"/>
		</div>
		<div class="searchbox col-xs-12">
		    <label class="title mul-title" style="width:75px;">装运车号：</label>
		    <select id="carNo" class="form-box mul-form-box" onchange="chooseDriver(this)" style="width:180px;">
		    </select>
		    <label class="title mul-title" style="text-align: left;width: 65px;">驾驶员：</label>
		    <input id="driver" class="form-box mul-form-box" type="text" placeholder="请输入驾驶员" style="width:180px;"/>
			<a class="itemBtn m-lr5" onclick="searchInfo()">查询</a>
			<a class="itemBtn m-lr5" onclick="doadd()">新增</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>报账日期</th>
					<th>调度单号</th>
					<th>装运车号</th>
                    <th>主驾驶员</th>
                    <th>副驾驶员</th>                
                    <th>公里数</th>
                    <th>运费总成</th>				
					<th>状态</th>
					<th>创建时间</th>
					<th>更新时间</th>
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
		 "sAjaxSource": "${ctx}/operationMng/transportCostMng/getOfficeListData" , //获取数据的ajax方法的URL							 
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
						    {data: "applyTime",'width':'8%'},
						    {data: "scheduleBillNo",'width':'8%'},
						    {data: "carNumber",'width':'7%'},
						    {data: "driverName",'width':'8%'},
						    {data: "codriverName",'width':'8%'},
						    {data: "distance",'width':'8%'},
						    {data: "oilAndAmountSum",'width':'10%'},
						    {data: "status",'width':'8%'},
						    {data: "insertTime",'width':'10%'},
						    {data: "updateTime",'width':'10%'},
						    {data: null,'width':'10%'}
							],
						    columnDefs: [{
									 //类型
									 targets:1,
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
									 targets:8,
									 render: function (data, type, row, meta) {
										 if(data=='0'){
								        	 return '新建'; 
								          }else if(data=='1'){
								        	  return '待费用审核';
								          }else if(data=='2'){
								        	  return '待驾驶员确认';
								          }else if(data=='3'){
								        	  return '待运营部负责人';
								          }else if(data=='4'){
								        	  return '待现金会计';
								          }else if(data=='5'){
								        	  return '待财务复核';
								          }else if(data=='6'){
								        	  return '确认付款';
								          }else if(data=='7'){
								        	  return '已完成';
								          }else{
								        	  return data;
								          }
								      }	       
								},{
									 //类型
									 targets:9,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonDateFormat(data);
										 }else{
											 return '';
										 }				       
								     }	       
								},{
									 //类型
									 targets:10,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonDateFormat(data);
										 }else{
											 return '';
										 }
								     }	       
								},{
									 //操作
									 targets: 11,
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
		 "sAjaxSource": "${ctx}/operationMng/transportCostMng/getOfficeListData" , //获取数据的ajax方法的URL	
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
					    {data: "applyTime",'width':'8%'},
					    {data: "scheduleBillNo",'width':'8%'},
					    {data: "carNumber",'width':'7%'},
					    {data: "driverName",'width':'8%'},
					    {data: "codriverName",'width':'8%'},
					    {data: "distance",'width':'8%'},
					    {data: "oilAndAmountSum",'width':'10%'},
					    {data: "status",'width':'8%'},
					    {data: "insertTime",'width':'10%'},
					    {data: "updateTime",'width':'10%'},
					    {data: null,'width':'10%'}
						],
					    columnDefs: [{
								 //类型
								 targets:1,
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
								 targets:8,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
							        	 return '新建'; 
							          }else if(data=='1'){
							        	  return '待费用审核';
							          }else if(data=='2'){
							        	  return '待驾驶员确认';
							          }else if(data=='3'){
							        	  return '待运营部负责人';
							          }else if(data=='4'){
							        	  return '待现金会计';
							          }else if(data=='5'){
							        	  return '待财务复核';
							          }else if(data=='6'){
							        	  return '确认付款';
							          }else if(data=='7'){
							        	  return '已完成';
							          }else{
							        	  return data;
							          }
							      }	       
							},{
								 //类型
								 targets:9,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }				       
							     }	       
							},{
								 //类型
								 targets:10,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }
							     }	       
							},{
								 //操作
								 targets: 11,
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
	getCarNo();
})

/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   $('#secho').val(secho);
	   var driver=$('#driver').val();
	   var cardNo=$('#carNo').find('option:selected').html();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var scheduleBillNo=$('#scheduleBillNo').val();
	   if(cardNo=='' || cardNo==null || cardNo=='请选择装运车号'){
		   cardNo="";
	   }
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				carNumber : cardNo,
				driverName : driver,
				startTime : startTime,
				endTime : endTime,
				scheduleBillNo:scheduleBillNo
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

/* 获取驾驶员信息 */
function getCarNo(){
	 $.ajax({  
	        url: '${ctx}/operationMng/transportPrepayMng/getStockList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="-1" data-id="-1">请选择装运车号</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+' data-driver='+data.data[i]['driverName']+'>'+data.data[i]['no']+'</option>';
	                		}
	            		}
	            	}
	            	$('#carNo').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
}

/* 车号联动驾驶员 */
function chooseDriver(e){
	var driver=$(e).find('option:selected').attr('data-driver');
	if(null == driver || "null" == driver)
	{
		$('#driver').val("");
	}
	else
	{
		$('#driver').val(driver);
	}
	
}



/* 新增 */
function doadd(){
	location.href="${ctx}/operationMng/transportCostMng/addIndex";
}

/* 编辑 */
function doedit(id){
	location.href="${ctx}/operationMng/transportCostMng/editIndex/"+id;
}

/* 查看 */
function doshow(id){
	location.href="${ctx}/operationMng/transportCostMng/queryIndex/"+id+'?type=0';
}

/* 删除申请信息 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该驾驶员报销申请信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/transportCostMng/delete/"+id,
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

/* 提交申请信息 */
function dosumbit(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该驾驶员报销申请信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/transportCostMng/submit/"+id,
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


</script>



</body>
</html>






