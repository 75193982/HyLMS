
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
				4S店驳运查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title" style="height: 34px;line-height: 34px;margin-right:25px;float: left;">4S店：</label>
		   <input id="fom_carShopId" class="form-box" data-id="" type="text" placeholder="请输入4S店" style="width:150px;float: left;" onkeyup="searchShop(this)"/>
		   <label class="title" style="float: left;height: 34px;line-height: 34px;">下单日期：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 150px;margin-right:42px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入下单日期" />
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 13px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 150px;margin-right:33px;margin-left: 30px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入下单日期" />
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div> 
		</div>
		<div class="searchbox col-xs-12">
		   <label class="title">运单编号：</label>
		   <input id="fom_waybillNo" class="form-box" type="text" placeholder="请输入运单编号" style="width:150px;"/>
		   <label class="title" style="margin-right:33px;">车型：</label>
		    <input id="fom_model" class="form-box" type="text" placeholder="请输入车型" style="width:150px;"/>
		    <label class="title" style="margin-right:20px;">车架号：</label>
		    <input id="fom_vin" class="form-box" type="text" placeholder="请输入车架号" style="width:150px;"/>
		    <a class="itemBtn" style="margin:0 5px;" onclick="searchInfo()">查询</a>
			<a class="itemBtn" style="margin:0 5px;" onclick="printInfo()">打印</a>
			<a class="itemBtn" style="margin:0 5px;" onclick="exportInfo()">导出</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>4S店</th>
					<th>运单编号</th>
                    <th>下单日期</th>
                    <th>车型</th>
                    <th>车架号</th>
                    <th>状态</th>   
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div id="sumCount" class="sumCount">
			   <p class="sumInfo">台数：<span id="localSum"></span></p>
			   <p class="sumInfo">已运（台）：<span id="allSumTrans" style="margin-right:15px;"></span>待运（台）：<span id="allSumUntrans" ></span></p>
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
				<h2>4S店驳运记录表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>														
					<th>序号</th>
					<th>4S店</th>
					<th>运单编号</th>
                    <th>下单日期</th>
                    <th>车型</th>
                    <th>车架号</th>
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
		 "sAjaxSource": "${ctx}/reportMng/carShopTransport/getListData" , //获取数据的ajax方法的URL							 
		 "ordering": false,	
			"oLanguage": {
				"sLengthMenu": "每页显示 _MENU_ 条记录",
				"sZeroRecords": "抱歉， 没有找到",
				"sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
				"sInfoEmpty": "没有数据",
				"sInfoFiltered": "(从 _MAX_ 条数据中检索)",
				"sProcessing" : "<span style='color:#ff0000;'>正在加载，请稍后。。。。</span>",
				"sLoadingRecords" : "载入中...", 
				"oPaginate": {
				"sFirst": "首页",
				"sPrevious": "上一页",
				"sNext": "下一页",
				"sLast": "尾页"
				},
				"sZeroRecords": "没有检索到数据"
				},		
				columns: [{ data: "rownum","width":"8%"},
						    {data: "carShopName","width":"20%"},
						    {data: "waybillNo","width":"20%"},
						    {data: "waybillSendTime","width":"15%"},
						    {data: "model","width":"10%"},
						    {data: "vin","width":"17%"},
						    {data: "carStatus","width":"10%"}
						    ],
						    columnDefs: [
				                {
				                	//时间
							    	 targets: 3,
							    	 render: function (data, type, row, meta) {
							    		 if(data!=null && data!=''){
						                	  return jsonForDateMinutFormat(data);
						                   }else{
						                	   return '';
						                   }
						                }	
				                },
				                {
				                	//状态
							    	 targets:6,
							    	 render: function (data, type, row, meta) {
							    		 if(data=='1'){
						                	  return '待运';
						                   }else if(data=='2'){
						                	   return '已运';
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
		 "sAjaxSource": "${ctx}/reportMng/carShopTransport/getListData" , //获取数据的ajax方法的URL	
		 "ordering": false,	
			"oLanguage": {
				"sLengthMenu": "每页显示 _MENU_ 条记录",
				"sZeroRecords": "抱歉， 没有找到",
				"sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
				"sInfoEmpty": "没有数据",
				"sInfoFiltered": "(从 _MAX_ 条数据中检索)",
				"sProcessing" : "<span style='color:#ff0000;'>正在加载，请稍后。。。。</span>",
				"sLoadingRecords" : "载入中...", 
				"oPaginate": {
				"sFirst": "首页",
				"sPrevious": "上一页",
				"sNext": "下一页",
				"sLast": "尾页"
				},
				"sZeroRecords": "没有检索到数据"
				},		
				columns: [{ data: "rownum","width":"8%"},
						    {data: "carShopName","width":"20%"},
						    {data: "waybillNo","width":"20%"},
						    {data: "waybillSendTime","width":"15%"},
						    {data: "model","width":"10%"},
						    {data: "vin","width":"17%"},
						    {data: "carStatus","width":"10%"}
						    ],
						    columnDefs: [
				                {
				                	//时间
							    	 targets: 3,
							    	 render: function (data, type, row, meta) {
							    		 if(data!=null && data!=''){
						                	  return jsonForDateMinutFormat(data);
						                   }else{
						                	   return '';
						                   }
						                }	
				                },
				                {
				                	//状态
							    	 targets:6,
							    	 render: function (data, type, row, meta) {
							    		 if(data=='1'){
						                	  return '待运';
						                   }else if(data=='2'){
						                	   return '已运';
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
	getSum();
})
/* 获取台数已运未运 */
function getSum(){
	   var waybillNo=$('#fom_waybillNo').val();
	   var startWaybillSendTime=$('#startTime').val();
	   var endWaybillSendTime=$('#endTime').val();
	   var model=$('#fom_model').val();
	   var vin=$('#fom_vin').val();
	   var carShopId=$('#fom_carShopId').attr('data-id');
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/reportMng/carShopTransport/print",
			data : JSON.stringify({
				waybillNo : $.trim(waybillNo),
				startWaybillSendTime : $.trim(startWaybillSendTime),
				endWaybillSendTime :$.trim(endWaybillSendTime),
				model :$.trim(model),
				vin : $.trim(vin),
				carShopId :$.trim(carShopId)
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {					
					 $('#localSum').html(data.totalCount);
					 $('#allSumTrans').html(data.hasFinished);
					 $('#allSumUntrans').html(data.unFinished);
				} else {
					 bootbox.alert(data.msg);
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
	   $('#selectItem9').hide();
	});
/* 4S店模糊查询 end */


/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var waybillNo=$('#fom_waybillNo').val();
	   var startWaybillSendTime=$('#startTime').val();
	   var endWaybillSendTime=$('#endTime').val();
	   var model=$('#fom_model').val();
	   var vin=$('#fom_vin').val();
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
				waybillNo : $.trim(waybillNo),
				startWaybillSendTime : $.trim(startWaybillSendTime),
				endWaybillSendTime :$.trim(endWaybillSendTime),
				model :$.trim(model),
				vin : $.trim(vin),
				carShopId :$.trim(carShopId)
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
	   var waybillNo=$('#fom_waybillNo').val();
	   var startWaybillSendTime=$('#startTime').val();
	   var endWaybillSendTime=$('#endTime').val();
	   var model=$('#fom_model').val();
	   var vin=$('#fom_vin').val();
	   var carShopId=$('#fom_carShopId').attr('data-id');
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/reportMng/carShopTransport/print",
			data : JSON.stringify({
				waybillNo : $.trim(waybillNo),
				startWaybillSendTime : $.trim(startWaybillSendTime),
				endWaybillSendTime :$.trim(endWaybillSendTime),
				model :$.trim(model),
				vin : $.trim(vin),
				carShopId :$.trim(carShopId)
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {					
					if(data.data.length>0){
						for(var i=0;i<data.data.length;i++){
							data.data[i]["rownum"]=i+1;
							if(data.data[i]["carShopName"]==null || data.data[i]["carShopName"]==''){
								data.data[i]["carShopName"]=''; 
							 }
							if(data.data[i]["waybillSendTime"]==null || data.data[i]["waybillSendTime"]==''){
								data.data[i]["waybillSendTime"]=''; 
							 }else{
								 data.data[i]["waybillSendTime"]=jsonForDateMinutFormat(data.data[i]["waybillSendTime"]);
							 }
							if(data.data[i]["waybillNo"]==null || data.data[i]["waybillNo"]==''){
								data.data[i]["waybillNo"]=''; 
							 }
							if(data.data[i]["model"]=='' || data.data[i]["model"]==null){
								data.data[i]["model"]='';
							}
							if(data.data[i]["vin"]=='' || data.data[i]["vin"]==null){
								data.data[i]["vin"]='';
							}
							if(data.data[i]["carStatus"]=='' || data.data[i]["carStatus"]==null){
								data.data[i]["carStatus"]='';
							}else if(data.data[i]["carStatus"]=='1'){
								data.data[i]["carStatus"]='待运';
							}else if(data.data[i]["carStatus"]=='2'){
								data.data[i]["carStatus"]='已运';
							}
								html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
							    +'<td>'+data.data[i]["carShopName"]+'</td>'
							    +'<td>'+data.data[i]["waybillNo"]+'</td>'
							    +'<td>'+data.data[i]["waybillSendTime"]+'</td>'
							    +'<td>'+data.data[i]["model"]+'</td>'
							    +'<td>'+data.data[i]["vin"]+'</td>'
							    +'<td>'+data.data[i]["carStatus"]+'</td></tr>';
							   
						      
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
	   var waybillNo=$('#fom_waybillNo').val();
	   var startWaybillSendTime=$('#startTime').val();
	   var endWaybillSendTime=$('#endTime').val();
	   var model=$('#fom_model').val();
	   var vin=$('#fom_vin').val();
	   var carShopId=$('#fom_carShopId').attr('data-id');
	   var form = $('<form action="${ctx}/reportMng/carShopTransport/export" method="POST"></form>');
	   var waybillNoInput = $('<input id="waybillNo" name="waybillNo" value="'+waybillNo+'" type="hidden" />');
	   var startWaybillSendTimeInput = $('<input id="startWaybillSendTime" name="startWaybillSendTime" value="'+startWaybillSendTime+'" type="hidden" />');
	   var endWaybillSendTimeInput = $('<input id="endWaybillSendTime" name="endWaybillSendTime" value="'+endWaybillSendTime+'" type="hidden" />');	
	   var vinInput = $('<input id="vin" name="vin" value="'+vin+'" type="hidden" />');
	   var modelInput = $('<input id="model" name="model" value="'+model+'" type="hidden" />');
	   var carShopIdInput = $('<input id="carShopId" name="carShopId" value="'+carShopId+'" type="hidden" />');
	   form.append(waybillNoInput);
	   form.append(startWaybillSendTimeInput);
	   form.append(endWaybillSendTimeInput);
	   form.append(vinInput);
	   form.append(modelInput);
	   form.append(carShopIdInput);
	   $('body').append(form);
	   form.submit();
}
</script>



</body>
</html>






