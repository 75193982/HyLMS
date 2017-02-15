
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
				承运商运费查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right:25px;">承运商：</label>
		   <select id="fom_outSourcing" class="form-box" style="width: 150px;float: left;">	
		   </select>
		   <label class="title" style="float: left;height: 34px;line-height: 34px;">装运时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 150px;margin-right:42px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入装运时间" />
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 13px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 150px;margin-right:33px;margin-left: 30px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入装运时间" />
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div> 
		</div>
		<div class="searchbox col-xs-12">
		   <label class="title">装运车号：</label>
		   <input id="fom_carNumber" class="form-box" type="text" placeholder="请输入装运车号" style="width:150px;" onkeyup="searchCar(this)"/>
		   <label class="title" style="margin-right:25px;">4S店：</label>
		   <input id="fom_carShopId" class="form-box" data-id="" type="text" placeholder="请输入4S店" style="width:150px;" onkeyup="searchShop(this)"/>
		   <label class="title">调度单号：</label>
		   <input id="fom_scheduleBillNo" class="form-box" type="text" placeholder="请输入调度单号" style="width:150px;"/>
		</div>
		<div class="searchbox col-xs-12">
		    <label class="title" style="margin-right:20px;">始发地：</label>
		    <input id="fom_startAddress" class="form-box" type="text" placeholder="请输入始发地" style="width:150px;"/>
		    <label class="title" style="margin-right:20px;">目的省：</label>
		    <input id="fom_targetProvince" class="form-box" type="text" placeholder="请输入目的省" style="width:150px;"/>
		    <label class="title" style="margin-right:18px;">目的地：</label>
		    <input id="fom_targetCity" class="form-box" type="text" placeholder="请输入目的地" style="width:150px;"/>
			<a class="itemBtn" style="margin:0 5px;" onclick="searchInfo()">查询</a>
			<a class="itemBtn" style="margin:0 5px;" onclick="printInfo()">打印</a>
			<a class="itemBtn" style="margin:0 5px;" onclick="exportInfo()">导出</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>承运商</th>
					<th>装运时间</th>
                    <th>装运车号</th>
                    <th>调度单号</th>
                    <th>品牌</th>
                    <th>车型</th>
                    <th>车架号</th>
                    <th>始发地</th>
                    <th>目的省</th>
                    <th>目的地</th>
                    <th>4S店</th>
                    <th>运费</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div id="sumCount" class="sumCount">
			   <p class="sumInfo">台数：<span id="localSum"></span></p>
			   <p class="sumInfo">运费(元)：<span id="allSum" ></span></p>
			</div>
		</div>
	</div>
	<!-- 装运车号模糊匹配 -->	
	<div id="selectItem8" class="selectItemhidden">
		<div class="selectItemcont">
			<div id="selectCar">
				
			</div>
		</div>
	</div>
	<!-- 4S店模糊匹配 -->	
	<div id="selectItem9" class="selectItemhidden">
		<div class="selectItemcont">
			<div id="selectShop">
				
			</div>
		</div>
	</div>
</div>
<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>承运商运费记录表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>														
					<th>序号</th>
					<th>承运商</th>
					<th>装运时间</th>
                    <th>装运车号</th>
                    <th>调度单号</th>
                    <th>品牌</th>
                    <th>车型</th>
                    <th>车架号</th>
                    <th>始发地</th>
                    <th>目的省</th>
                    <th>目的地</th>
                    <th>4S店</th>
                    <th>运费</th>                                                       
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
		 "sAjaxSource": "${ctx}/reportMng/outSourcingCost/getListData" , //获取数据的ajax方法的URL							 
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
		    {data: "outSourcingName","width":"10%"},
		    {data: "scheduleSendTime","width":"10%"},
		    {data: "carNumber","width":"6%"},
		    {data: "scheduleBillNo","width":"10%"},
		    {data: "brand","width":"6%"},
		    {data: "model","width":"8%"},
		    {data: "vin","width":"8%"},
		    {data: "startAddress","width":"8%"},
		    {data: "targetProvince","width":"8%"},
		    {data: "targetCity","width":"8%"},
		    {data: "carShopName","width":"8%"},
		    {data: "transportCost","width":"5%"}
		    ],
		    columnDefs: [
                {
                	//时间
			    	 targets: 2,
			    	 render: function (data, type, row, meta) {
			    		 if(data!=null && data!=''){
		                	  return jsonDateFormat(data);
		                   }else{
		                	   return '';
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
		 "sAjaxSource": "${ctx}/reportMng/outSourcingCost/getListData" , //获取数据的ajax方法的URL	
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
						    {data: "outSourcingName","width":"10%"},
						    {data: "scheduleSendTime","width":"10%"},
						    {data: "carNumber","width":"6%"},
						    {data: "scheduleBillNo","width":"10%"},
						    {data: "brand","width":"6%"},
						    {data: "model","width":"8%"},
						    {data: "vin","width":"8%"},
						    {data: "startAddress","width":"8%"},
						    {data: "targetProvince","width":"8%"},
						    {data: "targetCity","width":"8%"},
						    {data: "carShopName","width":"8%"},
						    {data: "transportCost","width":"5%"}
						    ],
						    columnDefs: [
				                {
				                	//时间
							    	 targets: 2,
							    	 render: function (data, type, row, meta) {
							    		 if(data!=null && data!=''){
						                	  return jsonDateFormat(data);
						                   }else{
						                	   return '';
						                   }
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
	getOutSourcing();
	getSum();
})
/* 获取台数运费 */
function getSum(){
	 var outSourceingId=$('#fom_outSourcing').val();
	   var startScheduleSendTime=$('#startTime').val();
	   var endScheduleSendTime=$('#endTime').val();
	   var carNumber=$('#fom_carNumber').val();
	   var scheduleBillNo=$('#fom_scheduleBillNo').val();
	   var startAddress=$('#fom_startAddress').val();
	   var targetProvince=$('#fom_targetProvince').val();
	   var targetCity=$('#fom_targetCity').val();
	   var carShopId=$('#fom_carShopId').attr('data-id');
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/reportMng/outSourcingCost/print",
			data : JSON.stringify({
				outSourcingId : $.trim(outSourceingId),
				startScheduleSendTime : $.trim(startScheduleSendTime),
				endScheduleSendTime :$.trim(endScheduleSendTime),
				carNumber :$.trim(carNumber),
				scheduleBillNo : $.trim(scheduleBillNo),
				startAddress :$.trim(startAddress),
				targetProvince :targetProvince,
				targetCity :targetCity,
				carShopId :carShopId
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {					
					 $('#localSum').html(data.totalCount);
					 $('#allSum').html(data.totalTransportCost);
				} else {
					 bootbox.alert(data.msg);
				}
				
			}
		}); 
	  
}

/* 绑定承运商 */
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
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                		}
            		}
            	}
            	$('#fom_outSourcing').html(html);
            	$('#outSourcingId').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}

/* 4S店模糊查询 begin */
function searchShop(e){
 	var $val=$(e).val();
 	 $('#fom_carShopId').attr('data-id','');
 	$.ajax({
			type : 'POST',
			url : "${ctx}/basicSetting/carShopMng/getCarShopList",
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			data: JSON.stringify({
				name : $val
			}),
			success : function(data) {
				if (data && data.code == 200) {
					var html = "";
					if(data.data!=null && data.data!=''){
		        		if(data.data.length>0){
		        			for(var i=0;i<data.data.length;i++){
		            			html +='<p data-id='+data.data[i]['id']+' onclick=\'clickp(this)\'>'+data.data[i]['name']+'</p>';
		            		}
		        		}
		        	}
		        	$('#selectShop').html(html);
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		});
 	var A_top = $(e).offset().top + $(e).outerHeight(true); //  1
		var A_left = $(e).offset().left;
		$('#selectItem9').show().css({
			"position" : "absolute",
			"top" : A_top + "px",
			"left" : A_left + "px"
		});
 }
function clickp(e){
		$('#fom_carShopId').val($(e).html());
		$('#fom_carShopId').attr('data-id',$(e).attr('data-id'));
		$('#selectItem9').hide();
		
	};
$(document).click(function(event) {
	   $('#selectItem8').hide();
	   $('#selectItem9').hide();
	});
/* 4S店模糊查询 end */

 /* 装运车号模糊查询 begin */
 function searchCar(e){
	 var $val=$(e).val();
	  $('#fom_carNumber').attr('data-id','');
	  $.ajax({  
	        url: '${ctx}/operationMng/scheduleMng/getStockList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: JSON.stringify({
	        	no:$val
	        }),
	        success: function (data) {
	        	var html ='';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<p onclick=\'clickc(this)\'>'+data.data[i]['no']+'</p>';
	                		}
	            			$('#selectCar').html(html);
	            		}
	            		
	            	}  
	          }else{  
	            	   bootbox.alert('加载失败！');
	            	   $('#fom_carNumber').val('');
	               } 
	        }
	      }); 
	    var A_top = $(e).offset().top + $(e).outerHeight(true); 
		var A_left = $(e).offset().left;
		$('#selectItem8').show().css({
			"position" : "absolute",
			"top" : A_top + "px",
			"left" : A_left + "px"
		});
	 }
	function clickc(e){
			$('#fom_carNumber').val($(e).html());
			$('#selectItem8').hide();
			
	};
	/* 装运车号模糊查询 end */

/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var outSourceingId=$('#fom_outSourcing').val();
	   var startScheduleSendTime=$('#startTime').val();
	   var endScheduleSendTime=$('#endTime').val();
	   var carNumber=$('#fom_carNumber').val();
	   var scheduleBillNo=$('#fom_scheduleBillNo').val();
	   var startAddress=$('#fom_startAddress').val();
	   var targetProvince=$('#fom_targetProvince').val();
	   var targetCity=$('#fom_targetCity').val();
	   var carShopId=$('#fom_carShopId').attr('data-id');
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
				outSourcingId : $.trim(outSourceingId),
				startScheduleSendTime : $.trim(startScheduleSendTime),
				endScheduleSendTime :$.trim(endScheduleSendTime),
				carNumber :$.trim(carNumber),
				scheduleBillNo : $.trim(scheduleBillNo),
				startAddress :$.trim(startAddress),
				targetProvince :targetProvince,
				targetCity :targetCity,
				carShopId :carShopId
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
	getSum();
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
	   var outSourceingId=$('#fom_outSourcing').val();
	   var startScheduleSendTime=$('#startTime').val();
	   var endScheduleSendTime=$('#endTime').val();
	   var carNumber=$('#fom_carNumber').val();
	   var scheduleBillNo=$('#fom_scheduleBillNo').val();
	   var startAddress=$('#fom_startAddress').val();
	   var targetProvince=$('#fom_targetProvince').val();
	   var targetCity=$('#fom_targetCity').val();
	   var carShopId=$('#fom_carShopId').attr('data-id');
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/reportMng/outSourcingCost/print",
			data : JSON.stringify({
				outSourcingId : $.trim(outSourceingId),
				startScheduleSendTime : $.trim(startScheduleSendTime),
				endScheduleSendTime :$.trim(endScheduleSendTime),
				carNumber :$.trim(carNumber),
				scheduleBillNo : $.trim(scheduleBillNo),
				startAddress :$.trim(startAddress),
				targetProvince :targetProvince,
				targetCity :targetCity,
				carShopId :carShopId
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {					
					if(data.data.length>0){
						for(var i=0;i<data.data.length;i++){
							data.data[i]["rownum"]=i+1;
							if(data.data[i]["outSourcingName"]==null || data.data[i]["outSourcingName"]==''){
								data.data[i]["outSourcingName"]=''; 
							 }
							if(data.data[i]["scheduleSendTime"]==null || data.data[i]["scheduleSendTime"]==''){
								data.data[i]["scheduleSendTime"]=''; 
							 }else{
								 data.data[i]["scheduleSendTime"]=jsonDateFormat(data.data[i]["scheduleSendTime"]);
							 }
							if(data.data[i]["carNumber"]==null || data.data[i]["carNumber"]==''){
								data.data[i]["carNumber"]=''; 
							 }
							if(data.data[i]["scheduleBillNo"]=='' || data.data[i]["scheduleBillNo"]==null){
								data.data[i]["scheduleBillNo"]='';
							}
							if(data.data[i]["brand"]=='' || data.data[i]["brand"]==null){
								data.data[i]["brand"]='';
							}
							if(data.data[i]["vin"]=='' || data.data[i]["vin"]==null){
								data.data[i]["vin"]='';
							}
							if(data.data[i]["model"]=='' || data.data[i]["model"]==null){
								data.data[i]["model"]='';
							}
							if(data.data[i]["startAddress"]=='' || data.data[i]["startAddress"]==null){
								data.data[i]["startAddress"]='';
							}
							if(data.data[i]["targetProvince"]=='' || data.data[i]["targetProvince"]==null){
								data.data[i]["targetProvince"]='';
							}
							if(data.data[i]["targetCity"]=='' || data.data[i]["targetCity"]==null){
								data.data[i]["targetCity"]='';
							}
							if(data.data[i]["carShopName"]=='' || data.data[i]["carShopName"]==null){
								data.data[i]["carShopName"]='';
							}
							if(data.data[i]["transportCost"]=='' || data.data[i]["transportCost"]==null){
								data.data[i]["transportCost"]='';
							}
								html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
							    +'<td>'+data.data[i]["outSourcingName"]+'</td>'
							    +'<td>'+data.data[i]["scheduleSendTime"]+'</td>'
							    +'<td>'+data.data[i]["carNumber"]+'</td>'
							    +'<td>'+data.data[i]["scheduleBillNo"]+'</td>'
							    +'<td>'+data.data[i]["brand"]+'</td>'
							    +'<td>'+data.data[i]["model"]+'</td>'
							    +'<td>'+data.data[i]["vin"]+'</td>'							    							    
							    +'<td>'+data.data[i]["startAddress"]+'</td>'
							    +'<td>'+data.data[i]["targetProvince"]+'</td>'
							    +'<td>'+data.data[i]["targetCity"]+'</td>'
							    +'<td>'+data.data[i]["carShopName"]+'</td>'
							    +'<td>'+data.data[i]["transportCost"]+'</td></tr>';
						      
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
		 pageSize: 13
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
	   var startWaybillSendTime='';
	   var endWaybillSendTime='';
	   var outSourcingId=$('#fom_outSourcing').val();
	   var startScheduleSendTime=$('#startTime').val();
	   var endScheduleSendTime=$('#endTime').val();
	   var carNumber=$('#fom_carNumber').val();
	   var scheduleBillNo=$('#fom_scheduleBillNo').val();
	   var startAddress=$('#fom_startAddress').val();
	   var targetProvince=$('#fom_targetProvince').val();
	   var targetCity=$('#fom_targetCity').val();
	   var carShopId=$('#fom_carShopId').attr('data-id');
	   var form = $('<form action="${ctx}/reportMng/outSourcingCost/export" method="POST"></form>');
	   var outSourcingIdInput = $('<input id="outSourcingId" name="outSourcingId" value="'+outSourcingId+'" type="hidden" />');
	   var startScheduleSendTimeInput = $('<input id="startScheduleSendTime" name="startScheduleSendTime" value="'+startScheduleSendTime+'" type="hidden" />');
	   var endScheduleSendTimeInput = $('<input id="endScheduleSendTime" name="endScheduleSendTime" value="'+endScheduleSendTime+'" type="hidden" />');	   
	   var carNumberInput = $('<input id="carNumber" name="carNumber" value="'+carNumber+'" type="hidden" />');
	   var scheduleBillNoInput = $('<input id="scheduleBillNo" name="scheduleBillNo" value="'+scheduleBillNo+'" type="hidden" />');
	   var startAddressInput = $('<input id="startAddress" name="startAddress" value="'+startAddress+'" type="hidden" />');
	   var targetProvinceInput = $('<input id="targetProvince" name="targetProvince" value="'+targetProvince+'" type="hidden" />');
	   var targetCityInput = $('<input id="targetCity" name="targetCity" value="'+targetCity+'" type="hidden" />');
	   var carShopIdInput = $('<input id="carShopId" name="carShopId" value="'+carShopId+'" type="hidden" />');
	   var startWaybillSendTimeInput = $('<input id="startWaybillSendTime" name="startWaybillSendTime" value="'+startWaybillSendTime+'" type="hidden" />');
	   var endWaybillSendTimeInput = $('<input id="endWaybillSendTime" name="endWaybillSendTime" value="'+endWaybillSendTime+'" type="hidden" />');	
	   form.append(outSourcingIdInput);
	   form.append(startScheduleSendTimeInput);
	   form.append(endScheduleSendTimeInput);
	   form.append(carNumberInput);
	   form.append(scheduleBillNoInput);
	   form.append(startAddressInput);
	   form.append(targetProvinceInput);
	   form.append(targetCityInput);
	   form.append(carShopIdInput);
	   form.append(startWaybillSendTimeInput);
	   form.append(endWaybillSendTimeInput);
	   $('body').append(form);
	   form.submit();
}
</script>



</body>
</html>






