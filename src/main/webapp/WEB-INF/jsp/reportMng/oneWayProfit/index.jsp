
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
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
.mask {       
            position: absolute; top: 0px; filter: alpha(opacity=60); background-color: #777;     
            z-index: 1002; left: 0px;     
            opacity:0.5; -moz-opacity:0.5;     
        }
 </style>
</head>
<body class="white-bg">
<div id="loading" style="display:none;position:absolute;z-index:9999;height:30px;width:200px;top:30%;left:50%;margin-left:-150px;text-align:center;border: solid 2px #86a5ad">
		<i class="fa fa-spinner fa-spin"></i>数据加载中......
		</div>
<div class="page-content">
	<div class="page-header">
		<h1>
			报表查询
			<small>
				<i class="icon-double-angle-right"></i>
				单程利润计算表
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title mul-title" style="float: left;height: 34px;line-height: 34px;width: 80px;" >装运时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 150px;margin-right:20px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="sendTimeStart" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width:48px;margin-left: 20px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 150px;margin-right:20px;height: 34px;line-height: 34px;">
				<input class="form-control" id="sendTimeEnd" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			<label class="title mul-title" style="width: 80px;">调度单号：</label>
		    <input id="scheduleBillNo" class="form-box" type="text" placeholder="请输入调度单号" style="margin-left: -5px;width: 150px;"/>	
		    	
		</div>
		<div class="searchbox col-xs-12">
			<label class="title mul-title" style="width: 80px;">装运车号：</label>
		    <input id="carNumber" class="form-box" type="text" placeholder="请输入装运车号" style="margin-left:-2px;width: 150px;"/>
		    <label class="title mul-title" style="margin-left:-2px;width: 68px;">驾驶员：</label>
		    <input id="driverName" class="form-box" type="text" placeholder="请输入驾驶员" style="margin-left: -5px;width: 150px;"/>
		     <a class="itemBtn m-lr5" onclick="searchInfo()">查询</a>  
		     <a class="itemBtn m-lr5" onclick="doprint()">打印</a>
			 <a class="itemBtn m-lr5" onclick="doexport()">导出</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>调度单号</th>
					<th>装运日期</th>
                    <th>装运车号</th>
                    <th>驾驶员</th>
					<th>台数</th>
					<th>应收运费</th>
                    <th>在途费用</th>
                    <th>毛利润</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
		</div>
	</div>
	
</div>

<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>单程利润计算表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>
		         <th>序号</th>
				 <th>调度单号</th>
				 <th>装运日期</th>
                 <th>装运车号</th>
                 <th>驾驶员</th>
			     <th>台数</th>
				 <th>应收运费</th>
                 <th>在途费用</th>
                 <th>毛利润</th>
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
<script src="${ctx}/staticPublic/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
//对浏览器进行判别,判断是否使用的是ie内核
var isIe = (document.all) ? true : false;


//创建渐变的背景层
function showBackDIV() {
	var bWidth =$(document).width();//parseInt(document.body.scrollWidth);
	var bHeight =$(document).height();//parseInt(document.body.scrollHeight);

	var back = document.createElement("div");
	back.id = "back";
	var styleStr = "top:0px;left:0px;position:absolute;z-index:9998;background:gray;width:" + bWidth + "px;height:" + bHeight + "px;";
	styleStr += (isIe) ? "filter:alpha(opacity=0);" : "opacity:0;";
	back.style.cssText = styleStr;
	document.body.appendChild(back);
	showBackground(back, 20);
}

//让背景渐渐变暗
function showBackground(obj, endInt) {
	if (isIe) {
		obj.filters.alpha.opacity += 1;
		if (obj.filters.alpha.opacity < endInt) {
			setTimeout( function() {
				showBackground(obj, endInt)
			}, 1);	//1秒
		}
	} else {
		var al = parseFloat(obj.style.opacity);
		al += 0.01;
		obj.style.opacity = al;
		if (al < (endInt / 100)) {
			setTimeout( function() {
				showBackground(obj, endInt)
			}, 1);
		}
	}
}
/**
 * 获取当前月的第一天
 */
function getCurrentMonthFirst(){
 var date=new Date();
 date.setDate(1);
 return date;
}
/**
 * 获取当前月的最后一天
 */
function getCurrentMonthLast(){
 var date=new Date();
 var currentMonth=date.getMonth();
 var nextMonth=++currentMonth;
 var nextMonthFirstDay=new Date(date.getFullYear(),nextMonth,1);
 var oneDay=1000*60*60*24;
 return new Date(nextMonthFirstDay-oneDay);
}

//格式化
var format = function(time, format){
    var t = new Date(time);
    var tf = function(i){return (i < 10 ? '0' : '') + i};
    return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a){
        switch(a){
            case 'yyyy':
                return tf(t.getFullYear());
                break;
            case 'MM':
                return tf(t.getMonth() + 1);
                break;
            case 'mm':
                return tf(t.getMinutes());
                break;
            case 'dd':
                return tf(t.getDate());
                break;
            case 'HH':
                return tf(t.getHours());
                break;
            case 'ss':
                return tf(t.getSeconds());
                break;
        }
    })
}

function init(){
	showBackDIV();
	$("#loading").show();
	var scheduleBillNo = $('#scheduleBillNo').val();
	var sendTimeStart = $('#sendTimeStart').val();
	var sendTimeEnd = $('#sendTimeEnd').val();
	var carNumber = $('#carNumber').val();
	var driverName = $('#driverName').val();
	$.ajax({
		type : 'POST',
		url : "${ctx}/reportMng/oneWayProfit/getListData",
		dataType : 'JSON',
		contentType : "application/json;charset=UTF-8",
		data : JSON.stringify({
			scheduleBillNo : scheduleBillNo,
			sendTimeStart : sendTimeStart,
			sendTimeEnd : sendTimeEnd,
			carNumber : carNumber,
			driverName : driverName
		}),
		success : function(data) {
			if (data&& data.code == 200) {
				$("#loading").hide();
				//$("#back").hide();
				$("#back").remove();
				if(data.data.length > 0)
				{
					for (var i = 0; i < data.data.length; i++) 
					{
						data.data[i]["rownum"] = i + 1;
					}
					$('#detailtable').DataTable({
							"destroy" : true,//如果需要重新加载需销毁
							dom : 'Bfrtip',
							"bLengthChange" : false,//屏蔽tables的一页展示多少条记录的下拉列表
							"bFilter" : false, //不使用过滤功能  
							"bProcessing" : true, //加载数据时显示正在加载信息	
							"bPaginate" : false,
							"bInfo" : false,
							ordering : false,														
							"oLanguage" : {
								"sZeroRecords" : "抱歉， 没有找到",
								"sInfoEmpty" : "没有数据",
								"sInfoFiltered" : "(从 _MAX_ 条数据中检索)",
								"sProcessing" : "<span style='color:#ff0000;'>正在加载，请稍后。。。。</span>",
								"sLoadingRecords" : "载入中...", 
								"sZeroRecords" : "没有检索到数据"
							},
							data : data.data,
							//使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
							//data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
							columns : [{ data: "rownum",'width':'5%'},
									    {data: "scheduleBillNo",'width':'15%'},
									    {data: "sendTime",'width':'15%'},
									    {data: "carNumber",'width':'15%'},
									    {data: "driverName",'width':'10%'},
									    {data: "amount",'width':'10%'},
									    {data: "receiveMoney",'width':'10%'},
									    {data: "onWayMoney",'width':'10%'},
									    {data: "chaMoney",'width':'10%'}
									],
							columnDefs : [ {
								 //日期
								 targets:2,
								 render: function (data, type, row, meta) {
									 if(data==null || data==''|| parseInt(data)<0){
										return ''; 
									 }else{
										 return jsonForDateFormat(data);
									 }
							       }	       
							}
							]
					});
				}
				else
				{
					$('#detailtable').DataTable({
						"destroy" : true,//如果需要重新加载需销毁
						dom : 'Bfrtip',
						"bLengthChange" : false,//屏蔽tables的一页展示多少条记录的下拉列表
						"bFilter" : false, //不使用过滤功能  
						"bProcessing" : true, //加载数据时显示正在加载信息	
						"bPaginate" : false,
						"bInfo" : false,
						ordering : false,
						"oLanguage" : {
							"sZeroRecords" : "抱歉， 没有找到",
							"sInfoEmpty" : "没有数据",
							"sInfoFiltered" : "(从 _MAX_ 条数据中检索)",
							"sZeroRecords" : "没有检索到数据"
						},
						data : data.data,
						//使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
						//data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
						columns : [{ data: "rownum",'width':'5%'},
								    {data: "scheduleBillNo",'width':'15%'},
								    {data: "sendTime",'width':'15%'},
								    {data: "carNumber",'width':'15%'},
								    {data: "driverName",'width':'10%'},
								    {data: "amount",'width':'10%'},
								    {data: "receiveMoney",'width':'10%'},
								    {data: "onWayMoney",'width':'10%'},
								    {data: "chaMoney",'width':'10%'}
								]
				});
				}
			}
			else {
				bootbox.alert(data.msg);
			}

		}
	})
	
}

$(function(){
	$("#sendTimeStart").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#sendTimeEnd").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$('#sendTimeStart').val(format(getCurrentMonthFirst().getTime(), 'yyyy-MM-dd'));
	$('#sendTimeEnd').val(format(getCurrentMonthLast().getTime(), 'yyyy-MM-dd'));
	init();
})


/* 查询 */
function searchInfo(){
	init();
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
	    var scheduleBillNo = $('#scheduleBillNo').val();
		var sendTimeStart = $('#sendTimeStart').val();
		var sendTimeEnd = $('#sendTimeEnd').val();
		var carNumber = $('#carNumber').val();
		var driverName = $('#driverName').val();
	   
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/reportMng/oneWayProfit/getListData",
			dataType : 'JSON',
			contentType : "application/json;charset=UTF-8",
			data : JSON.stringify({
				scheduleBillNo : scheduleBillNo,
				sendTimeStart : sendTimeStart,
				sendTimeEnd : sendTimeEnd,
				carNumber : carNumber,
				driverName : driverName
			}),
			success : function(data) {
				if (data && data.code == 200) {					
					if(data.data.length>0){
						for(var i=0;i<data.data.length;i++){
							data.data[i]["rownum"]=i+1;
						
								html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
							    +'<td>'+data.data[i]["scheduleBillNo"]+'</td>'
							    +'<td>'+data.data[i]["sendTime"]+'</td>'
							    +'<td>'+data.data[i]["carNumber"]+'</td>'
							    +'<td>'+data.data[i]["driverName"]+'</td>'
							    +'<td>'+data.data[i]["amount"]+'</td>'
							    +'<td>'+data.data[i]["receiveMoney"]+'</td>'
							    +'<td>'+data.data[i]["onWayMoney"]+'</td>'
							    +'<td>'+data.data[i]["chaMoney"]+'</td></tr>'
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
function doexport()
{
	 var scheduleBillNo = $('#scheduleBillNo').val();
	 var sendTimeStart = $('#sendTimeStart').val();
	 var sendTimeEnd = $('#sendTimeEnd').val();
	 var carNumber = $('#carNumber').val();
	 var driverName = $('#driverName').val();
	   
	   var form = $('<form action="${ctx}/reportMng/oneWayProfit/exportData" method="post"></form>');
	   var scheduleBillNoInput = $('<input id="scheduleBillNo" name="scheduleBillNo" value="'+scheduleBillNo+'" type="hidden" />');
	   var sendTimeStartInput = $('<input id="sendTimeStart" name="sendTimeStart" value="'+sendTimeStart+'" type="hidden" />');
	   var sendTimeEndInput = $('<input id="sendTimeEnd" name="sendTimeEnd" value="'+sendTimeEnd+'" type="hidden" />');
	   var carNumberInput = $('<input id="carNumber" name="carNumber" value="'+carNumber+'" type="hidden"  />');
	   var driverNameInput = $('<input id="driverName" name="driverName" value="'+driverName+'" type="hidden"  />');
	   form.append(scheduleBillNoInput);
	   form.append(sendTimeStartInput);
	   form.append(sendTimeEndInput);
	   form.append(carNumberInput);
	   form.append(driverNameInput);
	   $('body').append(form);
	   form.submit();
}

</script>

</body>
</html>






