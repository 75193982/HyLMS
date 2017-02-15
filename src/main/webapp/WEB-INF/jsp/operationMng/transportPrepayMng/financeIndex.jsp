
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
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
				装运预付申请管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">申请时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 234px;margin-right:15px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width:68px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 234px;margin-right:20px;height: 34px;line-height: 34px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		</div>
		<div class="searchbox col-xs-12">
		    <label class="title mul-title">车&nbsp;&nbsp;牌&nbsp;&nbsp;号：</label>
		    <select id="carNo" class="form-box mul-form-box" onchange="chooseDriver(this)" style="margin-left: 8px;width: 234px;">
		    </select>
		    <label class="title mul-title" style="text-align: left;width: 65px;">驾驶员：</label>
		    <input id="driver" class="form-box mul-form-box" type="text" placeholder="请输入驾驶员" style="margin-left: -2px;"/>		    
		</div>
		<div class="searchbox col-xs-12">
		    <label class="title mul-title">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</label>
		    <select id="status" class="form-box mul-form-box" >
		    <option value="">请选择状态</option>
		    <option value="0">新建</option>
		    <option value="1">待负责人审核</option>
		    <option value="2">待现金预核</option>
		    <option value="3">待财务复核</option>
		    <option value="4">待现金付款</option>
		    <option value="5">已完成</option>
		    <option value="6">已结算</option>
		    </select>
			<a class="itemBtn m-lr5" onclick="searchInfo()">查询</a>
			<a class="itemBtn m-lr5" onclick="doprint()">打印</a>
			<a class="itemBtn m-lr5" onclick="doexport()">导出</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>申请日期</th>
					<th>车牌号</th>
                    <th>驾驶员</th>
                    <th>手机号码</th>
                    <th>调度单号</th>                   
                    <th>预付现金</th>
                    <th>开户行名称</th>
					<th>账户</th>
					<th>油卡卡号</th>
					<th>预付油费</th>
					<th>状态</th>
					<th>备注</th>
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
</div>
<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>装运预付信息记录表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>
		       <th>序号</th>
			   <th>申请日期</th>
			   <th>车牌号</th>
               <th>驾驶员</th>
               <th>手机号码</th>
               <th>调度单号</th>                   
               <th>预付现金</th>
               <th>开户行名称</th>
			   <th>账户</th>
			   <th>油卡卡号</th>
			   <th>预付油费</th>
			   <th>状态</th>
			   <th>备注</th>
			   <th>创建时间</th>
			   <th>更新时间</th>
		      </tr>
		    </thead>
		    <tbody>
		    </tbody>
		  </table>
		  <div id="footerInfo"><h3>盐城辉宇物流有限公司  制</h3></div>
	  </div>
</div>

<!-- 打印明细 -->
<div class="printTable" id="printTableDetail">
     <div id="print-contentDetail" class="printcenter">
			<div id="headerInfoDetail">
				<h2>装运预付申请单</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable-detail" class="table myDataTable myDataTableDetail">
		    <tr>
		      <td>装运车号</td>
		      <td id="detail_carNo"></td>
		      <td>主驾姓名</td>
		      <td id="detail_carName"></td>
		      <td>联系电话</td>
		      <td id="detail_mobile"></td>
		    </tr>
		   <tr>
		    <td rowspan="5" style="vertical-align: middle;">装运明细</td>
		    <td>品牌</td>
		    <td>启运地</td>
		    <td>目的地（4S店）</td>
		    <td>台数</td>
		    <td>预付现金</td>
		   </tr>
		   <tr>
		     <td id="detail_bank1"></td>
		     <td id="detail_start1"></td>
		     <td id="detail_end1"></td>
		     <td id="detail_count1"></td>
		     <td rowspan="4" id="detail_preMoney" style="vertical-align: middle;"></td>
		   </tr>
		   <tr>
		     <td id="detail_bank2"></td>
		     <td id="detail_start2"></td>
		     <td id="detail_end2"></td>
		     <td id="detail_count2"></td>
		   </tr>
		   <tr>
		     <td id="detail_bank3"></td>
		     <td id="detail_start3"></td>
		     <td id="detail_end3"></td>
		     <td id="detail_count3"></td>
		   </tr>
		   <tr>
		     <td id="detail_bank4"></td>
		     <td id="detail_start4"></td>
		     <td id="detail_end4"></td>
		     <td id="detail_count4"></td>
		   </tr>
		   <tr>
		   	<td>开户行</td>
		   	<td colspan="2" id="detail_bank"></td>
		   	<td>账号</td>
		   	<td colspan="2" id="detail_account"></td>
		   </tr>
		   <tr>
		    <td colspan="2">预付油卡卡号</td>
		   	<td colspan="2" id="detail_oilCard"></td>
		   	<td>金额</td>
		   	<td id="detail_oilMoney"></td>
		   </tr>
		   <tr>
		    <td colspan="2">制单：<span id="detail_madeName"></span></td>
		    <td colspan="2">审核：<span id="detail_checkName"></span></td>
		    <td colspan="2">付款：<span id="detail_payName"></span></td>
		   </tr>
		  </table>
		  <div id="footerInfoDetail"><h3>盐城辉宇物流有限公司  制</h3></div>
	  </div>
</div>
<div>
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
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datetimepicker.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
function init(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/transportPrepayMng/getFinanceListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum",'width':'4%'},
		    {data: "applyTime",'width':'8%'},
		    {data: "carNumber",'width':'6%'},
		    {data: "driverName",'width':'5%'},
		    {data: "mobile",'width':'5%'},
		    {data: "scheduleBillNo",'width':'7%'},
		    {data: "prepayCash",'width':'6%'},
		    {data: "bankName",'width':'6%'},
		    {data: "bankAccount",'width':'5%'},
		    {data: "oilCardNo",'width':'5%'},
		    {data: "oilAmount",'width':'5%'},
		    {data: "status",'width':'5%'},
		    {data: "mark",'width':'8%'},
		    {data: "insertTime",'width':'8%'},
		    {data: "updateTime",'width':'8%'},
		    {data: null,'width':'9%'}
			],
		    columnDefs: [{
					 //类型
					 targets:1,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonForDateMinutFormat(data);
						 }else{
							 return '';
						 }
				      
				     }	       
				},{
					 //调度单号
					 targets:5,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return data;
						 }else{
							 return '';
						 }
				      
				     }	       
				},{
					 //状态
					 targets:11,
					 render: function (data, type, row, meta) {
						 if(data=='0'){
				        	 return '新建'; 
				          }else if(data=='1'){
				        	  return '待负责人审核';
				          }else if(data=='2'){
				        	  return '待现金预核';
				          }else if(data=='3'){
				        	  return '待财务复核';  
				          }else if(data=='4'){
				        	  return '待现金付款';
				          }else if(data=='5'){
				        	  return '已完成';
				          }else if(data=='6'){
				        	  return '已结算';
				          }
				      }	       
				},{
					 //类型
					 targets:13,
					 render: function (data, type, row, meta) {
				        if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
				     }	       
				},{
					 //类型
					 targets:14,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
				     }	       
				},{
					 //操作
					 targets: 15,
					 render: function (data, type, row, meta) {
						 return '<a class="table-upload" onclick="doprintdetil('+ row.id +')">明细打印</a>';
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
		 "sAjaxSource": "${ctx}/operationMng/transportPrepayMng/getFinanceListData" , //获取数据的ajax方法的URL	
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
			columns: [{ data: "rownum",'width':'4%'},
					    {data: "applyTime",'width':'8%'},
					    {data: "carNumber",'width':'6%'},
					    {data: "driverName",'width':'5%'},
					    {data: "mobile",'width':'5%'},
					    {data: "scheduleBillNo",'width':'7%'},
					    {data: "prepayCash",'width':'6%'},
					    {data: "bankName",'width':'6%'},
					    {data: "bankAccount",'width':'5%'},
					    {data: "oilCardNo",'width':'5%'},
					    {data: "oilAmount",'width':'5%'},
					    {data: "status",'width':'5%'},
					    {data: "mark",'width':'8%'},
					    {data: "insertTime",'width':'8%'},
					    {data: "updateTime",'width':'8%'},
					    {data: null,'width':'9%'}
						],
					    columnDefs: [{
								 //类型
								 targets:1,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonForDateMinutFormat(data);
									 }else{
										 return '';
									 }
							      
							     }	       
							},{
								 //调度单号
								 targets:5,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return data;
									 }else{
										 return '';
									 }
							      
							     }	       
							},{
								 //状态
								 targets:11,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
							        	 return '新建'; 
							          }else if(data=='1'){
							        	  return '待负责人审核';
							          }else if(data=='2'){
							        	  return '待现金预核';
							          }else if(data=='3'){
							        	  return '待财务复核';  
							          }else if(data=='4'){
							        	  return '待现金付款';
							          }else if(data=='5'){
							        	  return '已完成';
							          }else if(data=='6'){
							        	  return '已结算';
							          }
							      }	       
							},{
								 //类型
								 targets:13,
								 render: function (data, type, row, meta) {
							        if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }
							     }	       
							},{
								 //类型
								 targets:14,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }
							     }	       
							},{
								 //操作
								 targets: 15,
								 render: function (data, type, row, meta) {
									 return '<a class="table-upload" onclick="doprintdetil('+ row.id +')">明细打印</a>';
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
	   var cardNo=$('#carNo').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   if(cardNo=='' || cardNo==null || cardNo=='-1'){
		   cardNo=null;
	   }
	   var status=$('#status').val();
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
				status : status
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
	                			html +='<option value='+data.data[i]['no']+' data-driver='+data.data[i]['driverName']+'>'+data.data[i]['no']+'</option>';
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
	$('#driver').val(driver);
	
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
	   var driver=$('#driver').val();
	   var cardNo=$('#carNo').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   if(cardNo=='' || cardNo==null || cardNo=='-1'){
		   cardNo='';
	   }	
	   var status=$('#status').val();
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/operationMng/transportPrepayMng/getFinancePrint",
			data : JSON.stringify({
				driverName : driver,
				carNumber : cardNo,
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
							}else if(data.data[i]["status"]=='1'){
								data.data[i]["status"]='待制单';
							}else if(data.data[i]["status"]=='2'){
								data.data[i]["status"]='待审核';
							}else if(data.data[i]["status"]=='3'){
								data.data[i]["status"]='待付款';
							}else{
								data.data[i]["status"]='已完成';
							}
							if(data.data[i]["applyTime"]==null || data.data[i]["applyTime"]=='' || parseInt(data.data[i]["applyTime"])<0){
								data.data[i]["applyTime"]=''; 
							 }else{
								 data.data[i]["applyTime"]=jsonForDateFormat(data.data[i]["applyTime"]);
							 }
							if(data.data[i]["insertTime"]==null || data.data[i]["insertTime"]=='' || parseInt(data.data[i]["insertTime"])<0){
								data.data[i]["insertTime"]=''; 
							 }else{
								 data.data[i]["insertTime"]=jsonForDateFormat(data.data[i]["insertTime"]);
							 }
							if(data.data[i]["updateTime"]==null || data.data[i]["updateTime"]=='' || parseInt(data.data[i]["updateTime"])<0){
								data.data[i]["updateTime"]=''; 
							 }else{
								 data.data[i]["updateTime"]=jsonForDateFormat(data.data[i]["updateTime"]);
							 }
							if(data.data[i]["scheduleBillNo"]==null || data.data[i]["scheduleBillNo"]==''){
								data.data[i]["scheduleBillNo"]=''; 
							 }
							if(data.data[i]["oilAmount"]==null || data.data[i]["oilAmount"]==''){
								data.data[i]["oilAmount"]=''; 
							 }
							if(data.data[i]["prepayCash"]==null || data.data[i]["prepayCash"]==''){
								data.data[i]["prepayCash"]=''; 
							 }
							if(data.data[i]["driverName"]==null || data.data[i]["driverName"]==''){
								data.data[i]["driverName"]=''; 
							 }
							
								html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
							    +'<td>'+data.data[i]["applyTime"]+'</td>'
							    +'<td>'+data.data[i]["carNumber"]+'</td>'
							    +'<td>'+data.data[i]["driverName"]+'</td>'
							    +'<td>'+data.data[i]["mobile"]+'</td>'
							    +'<td>'+data.data[i]["scheduleBillNo"]+'</td>'
							    +'<td>'+data.data[i]["prepayCash"]+'</td>'
							    +'<td>'+data.data[i]["bankName"]+'</td>'
							    +'<td>'+data.data[i]["bankAccount"]+'</td>'
							    +'<td>'+data.data[i]["oilCardNo"]+'</td>'
							    +'<td>'+data.data[i]["oilAmount"]+'</td>'
							    +'<td>'+data.data[i]["status"]+'</td>'
							    +'<td>'+data.data[i]["mark"]+'</td>'
							    +'<td>'+data.data[i]["insertTime"]+'</td>'
							    +'<td>'+data.data[i]["updateTime"]+'</td></tr>';	
						      
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
		$('.page-content').hide();
		$('#printTable').show();
		$("#myDataTable").printTable({
		 header: "#headerInfo",
         footer: "#footerInfo",
		 mode: "rowNumber",
		 pageSize: 23
	});
		javasricpt:window.print();
		$('.page-content').show();
		$('#printTable').hide();
		$("#printTable").html(html);
	 }

/* 导出 */
function doexport()
{
	 var driver=$('#driver').val();
	   var cardNo=$('#carNo').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   if(cardNo=='' || cardNo==null || cardNo=='-1'){
		   cardNo='';
	   }	
	   var status=$('#status').val();
	   var form = $('<form action="${ctx}/operationMng/transportPrepayMng/export" method="post"></form>');
	   var driverInput = $('<input id="driverName" name="driverName" value="'+driver+'" type="hidden" />');
	   var cardNoInput = $('<input id="carNumber" name="carNumber" value="'+cardNo+'" type="hidden" />');	   
	   var startTimeInput = $('<input id="startTime" name="startTime" value="'+startTime+'" type="hidden" />');
	   var endTimeInput = $('<input id="endTime" name="endTime" value="'+endTime+'" type="hidden" />');
	   var statusInput = $('<input id="status" name="status" value="'+status+'" type="hidden" />');
	   form.append(driverInput);
	   form.append(cardNoInput);
	   form.append(startTimeInput);
	   form.append(endTimeInput);
	   form.append(statusInput);
	   $('body').append(form);
	   form.submit();
}

/* 打印明细 */
function doprintdetil(id){	  
	   $.ajax({
		    type : 'GET',
			url : "${ctx}/operationMng/transportPrepayMng/getDetail/" +id,
			data :{},
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					cleardetail();
					if(data.data["applyTime"]==null || data.data["applyTime"]=='' || parseInt(data.data["applyTime"])<0){
						data.data["applyTime"]=''; 
					 }else{
						 data.data["applyTime"]=jsonForDateFormat(data.data["applyTime"]);
					 }
					if(data.data.detailList.length>0){
						for(var i=0;i<data.data.detailList.length;i++){
							$('#detail_bank'+(i+1)+'').html(data.data.detailList[i]['brandName']);
							$('#detail_start'+(i+1)+'').html(data.data.detailList[i]['startAddress']);
							$('#detail_end'+(i+1)+'').html(data.data.detailList[i]['endAddress']);
							$('#detail_count'+(i+1)+'').html(data.data.detailList[i]['count']);
						}
					    
					}
					$('#detail_carNo').html(data.data["carNumber"]);
					$('#detail_carName').html(data.data["driver"]);
					$('#detail_mobile').html(data.data["mobile"]);
					$('#detail_preMoney').html(data.data["prepayCash"]);
					$('#detail_bank').html(data.data["bankName"]);
					$('#detail_account').html(data.data["bankAccount"]);
					$('#detail_oilCard').html(data.data["oilCardNo"]);
					$('#detail_oilMoney').html(data.data["oilAmount"]);
					$('#detail_madeName').html(data.data["insertUser"]);
					$('#detail_checkName').html(data.data["updateUser"]);
					$('#detail_payName').html();//付款人
					doprintFormDetail();
					 
				} else {
					 bootbox.alert(data.msg);
				}
				
			}
		}); 
	  
}
/* clear data  */
function cleardetail(){
	$('#detail_bank1').html('');
	$('#detail_start1').html('');
	$('#detail_end1').html('');
	$('#detail_count1').html('');
	$('#detail_bank2').html('');
	$('#detail_start2').html('');
	$('#detail_end2').html('');
	$('#detail_count2').html('');
	$('#detail_bank3').html('');
	$('#detail_start3').html('');
	$('#detail_end3').html('');
	$('#detail_count3').html('');
	$('#detail_bank4').html('');
	$('#detail_start4').html('');
	$('#detail_end4').html('');
	$('#detail_count4').html('');
}

function doprintFormDetail(){
	var html=$("#printTableDetail").html();
	$('.page-content').hide();
	$('#printTableDetail').show();
	$("#myDataTable-detail").printTable({
	 header: "#headerInfoDetail",
     footer: "#footerInfoDetail",
	 mode: "rowNumber"
});
	javasricpt:window.print();
	$('.page-content').show();
	$('#printTableDetail').hide();
	$("#printTableDetail").html(html);
 }

</script>



</body>
</html>






