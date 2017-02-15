
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/datetimepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">

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
				车队利润表
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">装运时间：</label>
			    <div class="input-group input-group-sm" style="float: left;width: 234px;height:34px;margin-right:30px; margin-left: 5px;">
					<input class="form-control" id="startTime" type="text" placeholder="装运时间" style="height: 34px;font-size: 14px;"/>
						<span class="input-group-addon">
							<i class="icon-calendar"></i>
						</span>
				</div>
		        <a class="itemBtn" id="openSchedule" onclick="searchInfo()">查询</a>
				<a class="itemBtn" id="printSchedule" onclick="printInfo()">打印</a>
				<a class="itemBtn" id="printSchedule" onclick="doexport()">导出</a>
		       <div class="clear"></div>
		</div>
		<div class="detailInfo">
		<table id="reportFleet" class="table table-striped table-bordered table-hover" style="width:800px;">
			<thead>
				<tr>														
					<th>项目</th>
					<th>本月金额</th>
					<th>本年合计</th>
				</tr>
			</thead>
			<tbody>
			   <tr><td class="first"><span class="color000">车队费用总收入</span></td><td id="mincomeSum"></td><td id="yincomeSum"></td></tr>
			   <tr><td class="width30 first"><span>其中：</span>主营计划收入</td><td id="mcarIncome"></td><td id="ycarIncome"></td></tr>
			   <tr><td class="first">二手车及其他</td><td id="mshCarIncome"></td><td id="yshCarIncome"></td></tr>
			   <tr><td class="first">保险赔偿</td><td id="minsuranceIncome"></td><td id="yinsuranceIncome"></td></tr>
			   <tr><td class="first"><span class="color000">车队运费成本</span></td><td id="mcostSum"></td><td id="ycostSum"></td></tr>
			   <tr><td class="width30 first"><span>其中：</span>运输在途成本</td><td id="mdriverCost"></td><td id="ydriverCost"></td></tr>
			   <tr><td class="first">鲁通卡费用</td><td id="mlukatong"></td><td id="ylukatong"></td></tr>
			   <tr><td class="first">保险分摊（月分摊）</td><td id="minsuranceCost"></td><td id="yinsuranceCost"></td></tr>
			   <tr><td class="first">大车维修包月费</td><td id="mcarRepairCost"></td><td id="ycarRepairCost"></td></tr>
			   <tr><td class="first">驾驶员工资</td><td id="mdriverPay"></td><td id="ydriverPay"></td></tr>
			   <tr><td class="first">车队办公人员工资</td><td id="mofficePay"></td><td id="yofficePay"></td></tr>
			   <tr><td class="first">轮胎费用</td><td id="mtireCost"></td><td id="ytireCost"></td></tr>
			   <tr><td class="first">车队费用</td><td id="mFleetCost"></td><td id="yFleetCost"></td></tr>
			   <tr><td class="first">场地租金</td><td id="mrentCost"></td><td id="yrentCost"></td></tr>
			   <tr><td class="first">挂车年审（月分摊）</td><td id="mtrailerCost"></td><td id="ytrailerCost"></td></tr>
			   <tr><td class="first">二维（月分摊）</td><td id="merWeiCost"></td><td id="yerWeiCost"></td></tr>
			   <tr><td class="first">油卡折现成本</td><td id="moilCardCost"></td><td id="yoilCardCost"></td></tr>
			   <tr><td class="first"><span class="color000">本月利润</span></td><td id="mexpandMoney"></td><td id="yexpandMoney"></td></tr>
			</tbody>
			</table>
		</div>
	</div>
	
</div>

<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>车队利润表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>
		         <th>项目</th>
				 <th>本月金额</th>
				 <th>本年合计</th>
		      </tr>
		    </thead>
		    <tbody>
		       <tr><td class="first"><span class="color000">车队费用总收入</span></td><td id="pmincomeSum"></td><td id="pyincomeSum"></td></tr>
			   <tr><td class="width30 first"><span>其中：</span>主营计划收入</td><td id="pmcarIncome"></td><td id="pycarIncome"></td></tr>
			   <tr><td class="first">二手车及其他</td><td id="pmshCarIncome"></td><td id="pyshCarIncome"></td></tr>
			   <tr><td class="first">保险赔偿</td><td id="pminsuranceIncome"></td><td id="pyinsuranceIncome"></td></tr>
			   <tr><td class="first"><span class="color000">车队运费成本</span></td><td id="pmcostSum"></td><td id="pycostSum"></td></tr>
			   <tr><td class="width30 first"><span>其中：</span>运输在途成本</td><td id="pmdriverCost"></td><td id="pydriverCost"></td></tr>
			   <tr><td class="first">鲁通卡费用</td><td id="pmlukatong"></td><td id="pylukatong"></td></tr>
			   <tr><td class="first">保险分摊（月分摊）</td><td id="pminsuranceCost"></td><td id="pyinsuranceCost"></td></tr>
			   <tr><td class="first">大车维修包月费</td><td id="pmcarRepairCost"></td><td id="pycarRepairCost"></td></tr>
			   <tr><td class="first">驾驶员工资</td><td id="pmdriverPay"></td><td id="pydriverPay"></td></tr>
			   <tr><td class="first">车队办公人员工资</td><td id="pmofficePay"></td><td id="pyofficePay"></td></tr>
			   <tr><td class="first">轮胎费用</td><td id="pmtireCost"></td><td id="pytireCost"></td></tr>
			   <tr><td class="first">车队费用</td><td id="pmFleetCost"></td><td id="pyFleetCost"></td></tr>
			   <tr><td class="first">场地租金</td><td id="pmrentCost"></td><td id="pyrentCost"></td></tr>
			   <tr><td class="first">挂车年审（月分摊）</td><td id="pmtrailerCost"></td><td id="pytrailerCost"></td></tr>
			   <tr><td class="first">二维（月分摊）</td><td id="pmerWeiCost"></td><td id="pyerWeiCost"></td></tr>
			   <tr><td class="first">油卡折现成本</td><td id="pmoilCardCost"></td><td id="pyoilCardCost"></td></tr>
			   <tr><td class="first"><span class="color000">本月利润</span></td><td id="pmexpandMoney"></td><td id="pyexpandMoney"></td></tr>
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
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datetimepicker.js"></script>
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
$(function(){
	 var date = new Date();
     var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
     var localTime= date.getFullYear() + "-" + month;
	$("#startTime").datetimepicker({
		language: 'cn',
        format: 'yyyy-mm',
        weekStart: 1,  
        autoclose: true,  
        startView: 3,  
        minView: 3,  
        forceParse: false
    });
	$("#startTime").val(localTime);
	searchInfo();
});

/* 查询 */
function searchInfo(){
	showBackDIV();
	$("#loading").show();
	clear();
	var sendTime=$("#startTime").val();
	var mincomeSum=0;
	var mcostSum=0;
	var yincomeSum=0;
	var ycostSum=0;
	 $.ajax({
		    type : 'POST',
			url : "${ctx}/reportMng/fleetProfit/getListData",
			dataType : 'JSON',
			contentType : "application/json;charset=UTF-8",
			data : JSON.stringify({
				sendTime : sendTime
			}),
			success : function(data) {
				$("#loading").hide();
				$("#back").remove();
				if (data && data.code == 200) {					
					if(data.data.monthProfit!=null){
						 var objM=data.data.monthProfit;
						 $('#mincomeSum').html(objM.incomeSum);
						 $('#mcarIncome').html(objM.carIncome);
						 $('#mshCarIncome').html(objM.shCarIncome);
						 $('#minsuranceIncome').html(objM.insuranceIncome);
						 $('#mcostSum').html(objM.costSum);
						 $('#mdriverCost').html(objM.driverCost);
						 $('#mlukatong').html(objM.lukatong);
						 $('#minsuranceCost').html(objM.insuranceCost);
						 $('#mcarRepairCost').html(objM.carRepairCost);
						 $('#mdriverPay').html(objM.driverPay);
						 $('#mofficePay').html(objM.officePay);
						 $('#mtireCost').html(objM.tireCost);
						 $('#mFleetCost').html(objM.fleetCost);
						 $('#mrentCost').html(objM.rentCost);
						 $('#mtrailerCost').html(objM.trailerCost);
						 $('#merWeiCost').html(objM.erWeiCost);
						 $('#moilCardCost').html(objM.oilCardCost);

					}if(data.data.yearProfit!=null){
						 var objY=data.data.yearProfit;
						 $('#yincomeSum').html(objY.incomeSum);
						 $('#ycarIncome').html(objY.carIncome);
						 $('#yshCarIncome').html(objY.shCarIncome);
						 $('#yinsuranceIncome').html(objY.insuranceIncome);
						 $('#ycostSum').html(objY.costSum);
						 $('#ydriverCost').html(objY.driverCost);
						 $('#ylukatong').html(objY.lukatong);
						 $('#yinsuranceCost').html(objY.insuranceCost);
						 $('#ycarRepairCost').html(objY.carRepairCost);
						 $('#ydriverPay').html(objY.driverPay);
						 $('#yofficePay').html(objY.officePay);
						 $('#ytireCost').html(objY.tireCost);
						 $('#yFleetCost').html(objY.fleetCost);
						 $('#yrentCost').html(objY.rentCost);
						 $('#ytrailerCost').html(objY.trailerCost);
						 $('#yerWeiCost').html(objY.erWeiCost);
						 $('#yoilCardCost').html(objY.oilCardCost);
					}
					
					if($('#mincomeSum').html()!=''){
						mincomeSum=$('#mincomeSum').html();
					}
					if($('#mcostSum').html()!=''){
						mcostSum=$('#mcostSum').html();
					}
					if($('#yincomeSum').html()!=''){
						yincomeSum=$('#yincomeSum').html();
					}
					if($('#ycostSum').html()!=''){
						ycostSum=$('#ycostSum').html();
					}
					$('#mexpandMoney').html(parseFloat(parseFloat(mincomeSum)-parseFloat(mcostSum)).toFixed(2));
					$('#yexpandMoney').html(parseFloat(parseFloat(yincomeSum)-parseFloat(ycostSum)).toFixed(2));
					 
				} else {
					 bootbox.alert(data.msg);
				}
				
			}
		}); 
}

function clear(){
	 $('#mincomeSum').val('');
	 $('#mcarIncome').val('');
	 $('#mshCarIncome').val('');
	 $('#minsuranceIncome').val('');
	 $('#mcostSum').val('');
	 $('#mdriverCost').val('');
	 $('#mlukatong').val('');
	 $('#minsuranceCost').val('');
	 $('#mcarRepairCost').val('');
	 $('#mdriverPay').val('');
	 $('#mofficePay').val('');
	 $('#mtireCost').val('');
	 $('#mFleetCost').val('');
	 $('#mdriverPay').val('');
	 $('#mofficePay').val('');
	 $('#mtireCost').val('');
	 $('#mFleetCost').val('');
	 $('#yincomeSum').val('');
	 $('#ycarIncome').val('');
	 $('#yshCarIncome').val('');
	 $('#yinsuranceIncome').val('');
	 $('#ycostSum').val('');
	 $('#ydriverCost').val('');
	 $('#ylukatong').val('');
	 $('#yinsuranceCost').val('');
	 $('#ycarRepairCost').val('');
	 $('#ydriverPay').val('');
	 $('#yofficePay').val('');
	 $('#ytireCost').val('');
	 $('#yFleetCost').html('');
	 $('#yrentCost').html('');
	 $('#ytrailerCost').html('');
	 $('#yerWeiCost').html('');
	 $('#yoilCardCost').html('');
}
function clearPrint(){
	 $('#pmincomeSum').val('');
	 $('#pmcarIncome').val('');
	 $('#pmshCarIncome').val('');
	 $('#pminsuranceIncome').val('');
	 $('#pmcostSum').val('');
	 $('#pmdriverCost').val('');
	 $('#pmlukatong').val('');
	 $('#pminsuranceCost').val('');
	 $('#pmcarRepairCost').val('');
	 $('#pmdriverPay').val('');
	 $('#pmofficePay').val('');
	 $('#pmtireCost').val('');
	 $('#pmFleetCost').val('');
	 $('#pmdriverPay').val('');
	 $('#pmofficePay').val('');
	 $('#pmtireCost').val('');
	 $('#pmFleetCost').val('');
	 $('#pyincomeSum').val('');
	 $('#pycarIncome').val('');
	 $('#pyshCarIncome').val('');
	 $('#pyinsuranceIncome').val('');
	 $('#pycostSum').val('');
	 $('#pydriverCost').val('');
	 $('#pylukatong').val('');
	 $('#pyinsuranceCost').val('');
	 $('#pycarRepairCost').val('');
	 $('#pydriverPay').val('');
	 $('#pyofficePay').val('');
	 $('#pytireCost').val('');
	 $('#pyFleetCost').html('');
	 $('#pyrentCost').html('');
	 $('#pytrailerCost').html('');
	 $('#pyerWeiCost').html('');
	 $('#pyoilCardCost').html('');
}
/* 打印功能 */
function printInfo(){
	   clearPrint();
	   var date = new Date();
       var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
       var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
       var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
       var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
       var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
       var localTime= date.getFullYear() + "-" + month + "-" + day+ " " + hours + ":" + minutes + ":" + seconds;
       $('#localTime').html(localTime);
	   var html="";
	   var sendTime=$("#startTime").val();
		var mincomeSum=0;
		var mcostSum=0;
		var yincomeSum=0;
		var ycostSum=0;
		 $.ajax({
			    type : 'POST',
				url : "${ctx}/reportMng/fleetProfit/getListData",
				dataType : 'JSON',
				contentType : "application/json;charset=UTF-8",
				data : JSON.stringify({
					sendTime : sendTime
				}),
				success : function(data) {
					if (data && data.code == 200) {					
						if(data.data.monthProfit!=null){
							 var objM=data.data.monthProfit;
							 $('#pmincomeSum').html(objM.incomeSum);
							 $('#pmcarIncome').html(objM.carIncome);
							 $('#pmshCarIncome').html(objM.shCarIncome);
							 $('#pminsuranceIncome').html(objM.insuranceIncome);
							 $('#pmcostSum').html(objM.costSum);
							 $('#pmdriverCost').html(objM.driverCost);
							 $('#pmlukatong').html(objM.lukatong);
							 $('#pminsuranceCost').html(objM.insuranceCost);
							 $('#pmcarRepairCost').html(objM.carRepairCost);
							 $('#pmdriverPay').html(objM.driverPay);
							 $('#pmofficePay').html(objM.officePay);
							 $('#pmtireCost').html(objM.tireCost);
							 $('#pmFleetCost').html(objM.fleetCost);
							 $('#pmrentCost').html(objM.rentCost);
							 $('#pmtrailerCost').html(objM.trailerCost);
							 $('#pmerWeiCost').html(objM.erWeiCost);
							 $('#pmoilCardCost').html(objM.oilCardCost);

						}if(data.data.yearProfit!=null){
							 var objY=data.data.yearProfit;
							 $('#pyincomeSum').html(objY.incomeSum);
							 $('#pycarIncome').html(objY.carIncome);
							 $('#pyshCarIncome').html(objY.shCarIncome);
							 $('#pyinsuranceIncome').html(objY.insuranceIncome);
							 $('#pycostSum').html(objY.costSum);
							 $('#pydriverCost').html(objY.driverCost);
							 $('#pylukatong').html(objY.lukatong);
							 $('#pyinsuranceCost').html(objY.insuranceCost);
							 $('#pycarRepairCost').html(objY.carRepairCost);
							 $('#pydriverPay').html(objY.driverPay);
							 $('#pyofficePay').html(objY.officePay);
							 $('#pytireCost').html(objY.tireCost);
							 $('#pyFleetCost').html(objY.fleetCost);
							 $('#pyrentCost').html(objY.rentCost);
							 $('#pytrailerCost').html(objY.trailerCost);
							 $('#pyerWeiCost').html(objY.erWeiCost);
							 $('#pyoilCardCost').html(objY.oilCardCost);
						}
						if($('#pmincomeSum').html()!=''){
							mincomeSum=$('#pmincomeSum').html();
						}
						if($('#pmcostSum').html()!=''){
							mcostSum=$('#pmcostSum').html();
						}
						if($('#pyincomeSum').html()!=''){
							yincomeSum=$('#pyincomeSum').html();
						}
						if($('#ycostSum').html()!=''){
							ycostSum=$('#ycostSum').html();
						}
						$('#pmexpandMoney').html(parseFloat(parseFloat(mincomeSum)-parseFloat(mcostSum)).toFixed(2));
						$('#pyexpandMoney').html(parseFloat(parseFloat(yincomeSum)-parseFloat(ycostSum)).toFixed(2));
						doprintForm();
						 
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
	 mode: "rowNumber"
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
   var sendTime=$("#startTime").val();
   var form = $('<form action="${ctx}/reportMng/fleetProfit/exportData" method="post"></form>');
   var sendTimeInput = $('<input id="sendTime" name="sendTime" value="'+sendTime+'" type="hidden" />');
   form.append(sendTimeInput);
   $('body').append(form);
   form.submit();
}

</script>

</body>
</html>






