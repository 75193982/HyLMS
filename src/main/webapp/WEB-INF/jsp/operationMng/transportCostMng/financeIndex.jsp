
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
				驾驶员报销申请管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">申请时间：</label>
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
		    <input id="driver" class="form-box mul-form-box" type="text" placeholder="请输入驾驶员" style="margin-left: -2px;width:180px;"/>
			<a class="itemBtn m-lr5" onclick="searchInfo()">查询</a>
			<a class="itemBtn m-lr5" onclick="doprint()">打印</a>
			<a class="itemBtn m-lr5" onclick="doexport()">导出</a>
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
<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>装运费用核算记录表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
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
				<h2 style="height:40px;line-height:40px;">装运费用核算明细表</h2>
				<div>
				  <p style="width:40%;float:left;font-size: 13px;color: #000;">装运车号:<span id="detail_carNo"></span></p>
				  <p style="width:40%;float:left;font-size: 13px;color: #000;">报账日期:<span id="detail_applyTime"></span></p>
				  <p style="float:right;font-size: 13px;color: #000;">单位:元</p>
				</div>
			</div>
		  <table id="myDataTable-detail" class="table myDataTable myDataTableDetail myDataTableCarDetail" style="margin-bottom:5px;">
		    <tr>
		      <td rowspan="2" style="vertical-align: middle;">装运品牌</td>
		      <td colspan="2">装运日期</td>
		      <td rowspan="2" style="vertical-align: middle;">启运地</td>
		      <td rowspan="2" colspan="2" style="vertical-align: middle;">目的地（4S店）</td>
		      <td rowspan="2" style="vertical-align: middle;">台数</td>
		      <td colspan="4">里程油费核算</td>
		      <td colspan="2">交车费</td>
		      <td colspan="2">带路费</td>
		      <td colspan="2">罚款</td>
		      <td>食宿补贴</td>
		      <td colspan="3">其它支出</td>
		      <td></td>
		    </tr>
		    <tr>
		      <td>发车时间</td>
		      <td>交车时间</td>
		      <td>公里数</td>
		      <td>核定油耗</td>
		      <td>核定油价</td>
		      <td>油费</td>
		      <td>收费单位</td>
		      <td>金额</td>
		      <td>带路地点</td>
		      <td>金额</td>
		      <td>罚款路段</td>
		      <td>金额</td>
		      <td>天数</td>
		      <td colspan="3">项目</td>
		      <td>金额</td>
		    </tr>
		    <tr>
		      <td id="loadBrand0"></td>
		      <td id="loadStartTime0"></td>
		      <td id="loadReceiveTime0"></td>
		      <td id="loadStartAddr0"></td>
		      <td id="loadEndAddr0" colspan="2"></td>
		      <td id="loadSum0"></td>
		      <td id="loadDistance0"></td>
		      <td id="loadOilWear0"></td>
		      <td id="loadOilPrice0"></td>
		      <td id="loadOilSum0"></td>
		      <td id="loadReceiveDep0"></td>
		      <td id="loadReceiveSum0"></td>
		      <td id="loadRoad0"></td>
		      <td id="loadRoadSum0"></td>
		      <td id="loadFine0"></td>
		      <td id="loadFineSum0"></td>
		      <td id="loaddays0"></td>
		      <td colspan="3" id="loadProject0"></td>
		      <td id="loadProjectSum0"></td>
		    </tr>
		    <tr>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td colspan="2"></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td>餐费</td>
		      <td colspan="3" id="loadProject1"></td>
		      <td id="loadProjectSum1"></td>
		    </tr>
		    <tr>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td colspan="2"></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td id="loadMeal0"></td>
		      <td colspan="3" id="loadProject2"></td>
		      <td id="loadProject2"></td>
		    </tr>
		    <tr>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td colspan="2"></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td>住宿</td>
		      <td colspan="3" id="loadProject3"></td>
		      <td id="loadProjectSum3"></td>
		    </tr>
		    <tr>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td colspan="2"></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td id="loadStay0"></td>
		      <td colspan="3" id="loadProject4"></td>
		      <td id="loadProjectSum4"></td>
		    </tr>
		    <tr>
		      <td colspan="6">费用小计:<span id="moneySum">1212</span></td>
		      <td id="loadSumAll"></td>
		      <td id="loadDistanceAll"></td>
		      <td id="loadOilWearAll"></td>
		      <td id="loadOilPriceAll"></td>
		      <td id="loadOilSumAll"></td>
		      <td></td>
		      <td id="loadReceiveSumAll"></td>
		      <td></td>
		      <td id="loadRoadSumAll"></td>
		      <td></td>
		      <td id="loadFineSumAll"></td>
		      <td id="loadMealStaySumAll"></td>
		      <td colspan="3"></td>
		      <td id="loadProjectSumAll"></td>
		    </tr>
		    <tr>
		      <td rowspan="4" style="vertical-align: middle;">预付车费</td>
		      <td>预付时间</td>
		      <td>金额</td>
		      <td rowspan="4" style="vertical-align: middle;">预付油卡</td>
		      <td>预付时间</td>
		      <td>金额</td>
		      <td rowspan="4" style="vertical-align: middle;">费用合计</td>
		      <td colspan="2">项目</td>
		      <td colspan="2">金额</td>
		      <td rowspan="4" style="vertical-align: middle;">结付驾驶员</td>
		      <td>项目</td>
		      <td colspan="2">金额</td>
		      <td colspan="2">返还公司现金</td>
		      <td rowspan="5" style="vertical-align: middle;">其他业务</td>
		      <td colspan="2">其他业务收入</td>
		      <td colspan="2"></td>
		    </tr>
		    <tr>
		      <td id="loadPreMoneyTime0"></td>
		      <td id="loadPreMoneySum0"></td>
		      <td id="loadPreOilTime0"></td>
		      <td id="loadPreOilSum0"></td>
		      <td colspan="2">报账费用</td>
		      <td colspan="2"></td>
		      <td>现金</td>
		      <td colspan="2" id="loadBalanceCash"></td>
		      <td rowspan="3" colspan="2" style="vertical-align: middle;"></td>
		      <td>起运地</td>
		      <td>&nbsp;&nbsp;&nbsp;</td>
		      <td>目的地</td>
		      <td>&nbsp;&nbsp;&nbsp;</td>
		    </tr>
		    <tr>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td colspan="2">鲁通卡</td>
		      <td colspan="2"></td>
		      <td>油卡</td>
		      <td colspan="2" id="loadBalanceOil"></td>
		      <td>台数</td>
		      <td></td>
		      <td>金额</td>
		      <td></td>
		    </tr>
		    <tr>
		      <td>合计</td>
		      <td id="loadPreMoneySumAll"></td>
		      <td>合计</td>
		      <td id="loadPreOilSumAll"></td>
		      <td colspan="2">合计</td>
		      <td colspan="2"></td>
		      <td>合计</td>
		      <td colspan="2" id="loadBalanceSum"></td>
		      <td>付款方式</td>
		      <td></td>
		      <td>付款时间</td>
		      <td></td>
		    </tr>
		    <tr>
		      <td colspan="2">利润核算</td>
		      <td>收入</td>
		      <td colspan="5"></td>
		      <td colspan="2">费用</td>
		      <td colspan="3"></td>
		      <td>利润</td>
		      <td colspan="3"></td>
		      <td colspan="2">业务负责人</td>
		      <td colspan="2"></td>
		    </tr>
		    <tr>
		      <td colspan="2">驾驶员</td>
		      <td colspan="2">调度确认</td>
		      <td colspan="2">费用审核</td>
		      <td colspan="3">数据记录</td>
		      <td colspan="3">运营部负责人</td>
		      <td colspan="3">现金会计</td>
		      <td colspan="3">财务负责人</td>
		      <td colspan="4">总经理</td>
		    </tr> 
		    <tr> 
		      <td rowspan="3" colspan="2"><p id="loadConfirm0"></p><p id="loadConfirmTime0"></p></td>
		      <td rowspan="3" colspan="2"><p id="loadConfirm1"></p><p id="loadConfirmTime1"></p></td>
		      <td rowspan="3" colspan="2"><p id="loadConfirm2"></p><p id="loadConfirmTime2"></p></td>
		      <td rowspan="3" colspan="3"><p id="loadConfirm3"></p><p id="loadConfirmTime3"></p></td>
		      <td rowspan="3" colspan="3"><p id="loadConfirm4"></p><p id="loadConfirmTime4"></p></td>
		      <td rowspan="3" colspan="3"><p id="loadConfirm5"></p><p id="loadConfirmTime5"></p></td>
		      <td rowspan="3" colspan="3"><p id="loadConfirm6"></p><p id="loadConfirmTime6"></p></td>
		      <td rowspan="3" colspan="4"><p id="loadConfirm7"></p><p id="loadConfirmTime7"></p></td>
		    </tr>
		  </table>
		  <div id="footerInfoDetail"><h3 style="margin:0;">盐城辉宇物流有限公司  制</h3></div>
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
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
function init(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/transportCostMng/getFinanceListData" , //获取数据的ajax方法的URL							 
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
						 /* return '<a class="table-upload" onclick="doprintdetil('+ row.id +')">明细打印</a>'; */
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
		 "sAjaxSource": "${ctx}/operationMng/transportCostMng/getFinanceListData" , //获取数据的ajax方法的URL	
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
									 /* return '<a class="table-upload" onclick="doprintdetil('+ row.id +')">明细打印</a>'; */
									 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
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
	   var scheduleBillNo=$('#scheduleBillNo').val();
	   if(cardNo=='' || cardNo==null || cardNo=='-1'){
		   cardNo=null;
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
				scheduleBillNo : scheduleBillNo
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
	                			html +='<option value='+data.data[i]['no']+' data-driver='+data.data[i]['driver']+'>'+data.data[i]['no']+'</option>';
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
	   var scheduleBillNo=$('#scheduleBillNo').val();
	   if(cardNo=='' || cardNo==null || cardNo=='-1'){
		   cardNo='';
	   }	  
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/operationMng/transportCostMng/getFinancePrint",
			data : JSON.stringify({
				driverName : driver,
				carNumber : cardNo,
				startTime : startTime,
				endTime : endTime,
				scheduleBillNo : scheduleBillNo
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
								data.data[i]["status"]='待调度确认';
							}else if(data.data[i]["status"]=='2'){
								data.data[i]["status"]='待费用审核';
							}else if(data.data[i]["status"]=='3'){
								data.data[i]["status"]='待数据记录';
							}else if(data.data[i]["status"]=='4'){
								data.data[i]["status"]='待运营部负责人';
							}else if(data.data[i]["status"]=='5'){
								data.data[i]["status"]='待现金会计';
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
								 data.data[i]["insertTime"]=jsonDateFormat(data.data[i]["insertTime"]);
							 }
							if(data.data[i]["updateTime"]==null || data.data[i]["updateTime"]=='' || parseInt(data.data[i]["updateTime"])<0){
								data.data[i]["updateTime"]=''; 
							 }else{
								 data.data[i]["updateTime"]=jsonDateFormat(data.data[i]["updateTime"]);
							 }
							if(data.data[i]["driverName"]==null || data.data[i]["driverName"]==''){
								data.data[i]["driverName"]=''; 
							 }
							if(data.data[i]["codriverName"]==null || data.data[i]["codriverName"]==''){
								data.data[i]["codriverName"]=''; 
							 }
								html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
							    +'<td>'+data.data[i]["applyTime"]+'</td>'
							    +'<td>'+data.data[i]["scheduleBillNo"]+'</td>'
							    +'<td>'+data.data[i]["carNumber"]+'</td>'
							    +'<td>'+data.data[i]["driverName"]+'</td>'
							    +'<td>'+data.data[i]["codriverName"]+'</td>'
							    +'<td>'+data.data[i]["distance"]+'</td>'
							    +'<td>'+(data.data[i]["oilAmount"]+data.data[i]["amount"])+'</td>'							    
							    +'<td>'+data.data[i]["status"]+'</td>'
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
		 pageSize: 13
	});
		javasricpt:window.print();
		$('.page-content').show();
		$('#printTable').hide();
		$("#printTable").html(html);
	 }


/* 打印明细 */
function doprintdetil(id){
	var proSum=0;
	var sum=0;
	cleardetail();
	   $.ajax({
		    type : 'GET',
			url : "${ctx}/operationMng/transportCostMng/getDetail/" +id,
			data :{},
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					if(data.data["applyTime"]==null || data.data["applyTime"]=='' || parseInt(data.data["applyTime"])<0){
						data.data["applyTime"]=''; 
					 }else{
						 data.data["applyTime"]=jsonForDateFormat(data.data["applyTime"]);
					 }
					var ertra=[];
					if(data.data.costList.length>0){
						for(var i=0;i<data.data.costList.length;i++){
							if(data.data.costList[i]["sendTime"]==null || data.data.costList[i]["sendTime"]=='' || parseInt(data.data.costList[i]["sendTime"])<0){
								data.data.costList[i]["sendTime"]=''; 
							 }else{
								 data.data.costList[i]["sendTime"]=jsonForDateFormat(data.data.costList[i]["sendTime"]);
							 }
							if(data.data.costList[i]["receiveTime"]==null || data.data.costList[i]["receiveTime"]=='' || parseInt(data.data.costList[i]["receiveTime"])<0){
								data.data.costList[i]["receiveTime"]=''; 
							 }else{
								 data.data.costList[i]["receiveTime"]=jsonForDateFormat(data.data.costList[i]["receiveTime"]);
							 }
							$('#loadBrand0').html(data.data.costList[i]['brandName']);
							$('#loadStartTime0').html(data.data.costList[i]['sendTime']);
							$('#loadReceiveTime0').html(data.data.costList[i]['receiveTime']);
							$('#loadStartAddr0').html(data.data.costList[i]['startAddress']);
							$('#loadEndAddr0').html(data.data.costList[i]['endAddress']);
						    $('#loadSum0').html(data.data.costList[i]['count']);
						    /* $('#loadSumAll').html(data.data.costList[i]['count']); *//* 台数总计 */
						    /* $('#loadDistanceAll').html(data.data.costList[i]['distance']); *//* 公里数总计 */
						    /* $('#loadOilWearAll').html(data.data.costList[i]['standardOilWear']); *//* 核定油耗总计 */
						    /* $('#loadOilPriceAll').html(data.data.costList[i]['oilPrice']); *//* 核定油价总计 */
						    $('#loadDistance0').html(data.data.costList[i]['distance']);
						    $('#loadOilWear0').html(data.data.costList[i]['standardOilWear']);
						    $('#loadOilPrice0').html(data.data.costList[i]['oilPrice']);
						    for(var j=0;j<data.data.costList[i]['cashList'].length;j++){
						    	var obj=data.data.costList[i]['cashList'];
						    	if(obj[j]['type']=='0'){
						    		 $('#loadReceiveDep0').html(obj[j]['name']);
						    		 $('#loadReceiveSum0').html(obj[j]['amount']);
						    		 $('#loadReceiveSumAll').html(obj[j]['amount']);/* 交车费总计 */
						    	}else if(obj[j]['type']=='1'){
						    		 $('#loadRoad0').html(obj[j]['name']);
						    		 $('#loadRoadSum0').html(obj[j]['amount']);
						    		 $('#loadRoadSumAll').html(obj[j]['amount']);/* 带路费总计 */
						    	}else if(obj[j]['type']=='2'){
						    		 $('#loadFine0').html(obj[j]['name']);
						    		 $('#loadFineSum0').html(obj[j]['amount']);
						    		 $('#loadFineSumAll').html(obj[j]['amount']);/* 罚款总计 */	
						    	}else if(obj[j]['type']=='3'){
						    		 $('#loadMeal0').html(obj[j]['amount']);
						    	}else if(obj[j]['type']=='4'){
						    		 $('#loadStay0').html(obj[j]['amount']);
						    	}else if(obj[j]['type']=='5'){
						    		var ertraItem={};
							    	ertraItem.name=obj[j]['name'];
							    	ertraItem.amount=obj[j]['amount'];
							    	ertra.push(ertraItem);
						    	}
						    }
						}
						for(var k=0;k<ertra.length;k++){
							 proSum+=parseFloat(ertra[k]['amount']);
							 $('#loadProject'+k+'').html(ertra[k]['name']);
				    		 $('#loadProjectSum'+k+'').html(ertra[k]['amount']);
						}
						
						if(data.data.prepayList!=null && data.data.prepayList.length>0){
							var loadPreMoneyTime=''
							var loadPreMoneySum=''
							var loadPreOilSum=""
							if(data.data.prepayList[0]['applyTime']!='' && data.data.prepayList[0]['applyTime']!=null){
								loadPreMoneyTime=jsonForDateFormat(data.data.prepayList[0]['applyTime']);
							}
							if(data.data.prepayList[0]['prepayCash']!='' && data.data.prepayList[0]['prepayCash']!=null){
								loadPreMoneySum=data.data.prepayList[0]['prepayCash'];
							}
							if(data.data.prepayList[0]['oilAmount']!='' && data.data.prepayList[0]['oilAmount']!=null){
								loadPreOilSum=data.data.prepayList[0]['oilAmount'];
							}
							$('#loadPreMoneyTime0').html(loadPreMoneyTime);/* 预付车费时间 */
		  				  	$('#loadPreMoneySum0').html(loadPreMoneySum);/* 预付车费金额 */
		  				  	$('#loadPreMoneySumAll').html(loadPreMoneySum);/* 预付车费金额总计 */
		  				  	$('#loadPreOilTime0').html(loadPreMoneyTime);/* 预付油卡时间 */
		  				  	$('#loadPreOilSum0').html(loadPreOilSum);/* 预付油卡金额 */
		  				  	$('#loadPreOilSumAll').html(loadPreOilSum);/* 预付油卡金额总计 */
						}
						if(data.data.taskList!=null && data.data.taskList.length>0){
							for(var n=0;n<data.data.taskList.length;n++){
								if(data.data.taskList[n]['operateTime']!=null && data.data.taskList[n]['operateTime']!=''){
									data.data.taskList[n]['operateTime']=jsonForDateFormat(data.data.taskList[n]['operateTime']);
								}
								$('#loadConfirm'+n+'').html(data.data.taskList[n]['operateUserName']);
								$('#loadConfirmTime'+n+'').html(data.data.taskList[n]['operateTime']);
							}
						}
						
					}
					$('#detail_applyTime').html(data.data["applyTime"]);
					$('#detail_carNo').html(data.data["carNumber"]);
					$('#detail_carName').html(data.data["driver"]);
					$('#loadOilSum0').html(data.data['oilAmount']);
					$('#loadOilSumAll').html(data.data['oilAmount']);/* 油费总计 */
					
					if($('#loadMeal0').html()=='' && $('#loadStay0').html()==''){
						sum='';
					}else if($('#loadMeal0').html()=='' && $('#loadStay0').html()!=''){
						sum=(parseFloat($('#loadStay0').html())).toFixed(2);
					}else if($('#loadMeal0').html()!='' && $('#loadStay0').html()==''){
						sum=(parseFloat($('#loadMeal0').html())).toFixed(2);
					}else{
						sum=(parseFloat($('#loadMeal0').html())+parseFloat($('#loadStay0').html())).toFixed(2);
					}
					$('#loadMealStaySumAll').html(sum);/* 食宿总计 */
					if(proSum==0){
						$('#loadProjectSumAll').html('');/* 项目总计 */
					}else{
						$('#loadProjectSumAll').html(proSum.toFixed(2));/* 项目总计 */
					}
					var moneySum=0;
					/* if($('#loadOilSumAll').html()!=''){
						moneySum+=parseFloat($('#loadOilSumAll').html());
					} */
					if($('#loadReceiveSumAll').html()!=''){
						moneySum+=parseFloat($('#loadReceiveSumAll').html());
					}
					if($('#loadFineSumAll').html()!=''){
						moneySum+=parseFloat($('#loadFineSumAll').html());
					}
					if($('#loadMeal0').html()!=''){
						moneySum+=parseFloat($('#loadMeal0').html());
					}
					if($('#loadStay0').html()!=''){
						moneySum+=parseFloat($('#loadStay0').html());
					}
					if($('#loadProjectSumAll').html()!=''){
						moneySum+=parseFloat($('#loadProjectSumAll').html());
					}
					if($('#loadRoadSumAll').html()!=''){
						moneySum+=parseFloat($('#loadRoadSumAll').html());
					}
					$('#moneySum').html(moneySum.toFixed(2));/* 费用总计 */
					$('#loadBalanceCash').html(data.data['balanceCash']);/* 结付驾驶员 */
					$('#loadBalanceOil').html(data.data['balanceOil']);
					var balanceSum=0;
					if($('#loadBalanceCash').html()=='' && $('#loadBalanceOil').html()==''){
						balanceSum='';
					}else if($('#loadBalanceCash').html()=='' && $('#loadBalanceOil').html()!=''){
						balanceSum=(parseFloat($('#loadBalanceOil').html())).toFixed(2);
					}else if($('#loadBalanceCash').html()!='' && $('#loadBalanceOil').html()==''){
						balanceSum=(parseFloat($('#loadBalanceCash').html())).toFixed(2);
					}else{
						balanceSum=(parseFloat($('#loadBalanceCash').html())+parseFloat($('#loadBalanceOil').html())).toFixed(2);
					}
					
					$('#loadBalanceSum').html('');

					doprintFormDetail();
					 
				} else {
					 bootbox.alert(data.msg);
				}
				
			}
		});  
	  
}
/* clear data  */
function cleardetail(){
	$('#loadBrand0').html('');
	$('#loadStartTime0').html('');
	$('#loadReceiveTime0').html('');
	$('#loadStartAddr0').html('');
	$('#loadEndAddr0').html('');
	$('#loadSum0').html('');
	$('#loadDistance0').html('');
	$('#loadOilWear0').html('');
	$('#loadOilPrice0').html('');
	$('#loadOilSum0').html('');
	$('#loadReceiveDep0').html('');
	$('#loadReceiveSum0').html('');
	$('#loadRoad0').html('');
	$('#loadRoadSum0').html('');
	$('#loadFine0').html('');
	$('#loadFineSum0').html('');
	$('#loaddays0').html('');
	$('#loadProject0').html('');
	$('#loadProjectSum0').html('');
	$('#loadMeal0').html('');
	$('#loadProject1').html('');
	$('#loadProjectSum1').html('');
	$('#loadProject2').html('');
	$('#loadProjectSum2').html('');
	$('#loadStay0').html('');
	$('#loadProject3').html('');
	$('#loadProjectSum3').html('');
	$('#loadProject4').html('');
	$('#loadProjectSum4').html('');
	$('#moneySum').html('');
	$('#loadSumAll').html('');
	$('#loadDistanceAll').html('');
	$('#loadOilWearAll').html('');
	$('#loadOilPriceAll').html('');
	$('#loadOilSumAll').html('');
	$('#loadReceiveSumAll').html('');
	$('#loadRoadSumAll').html('');
	$('#loadFineSumAll').html('');
	$('#loadMealStaySumAll').html('');
	$('#loadProjectSumAll').html('');
	$('#loadPreMoneyTime0').html('');
	$('#loadPreMoneySum0').html('');
	$('#loadPreOilTime0').html('');
	$('#loadPreOilSum0').html('');
	$('#loadPreMoneySumAll').html('');
	$('#loadPreOilSumAll').html('');
	$('#loadConfirm0').html('');
	$('#loadConfirmTime0').html('');
	$('#loadConfirm1').html('');
	$('#loadConfirmTime1').html('');
	$('#loadConfirm2').html('');
	$('#loadConfirmTime2').html('');
	$('#loadConfirm3').html('');
	$('#loadConfirmTime3').html('');
	$('#loadConfirm4').html('');
	$('#loadConfirmTime4').html('');
	$('#loadConfirm5').html('');
	$('#loadConfirmTime5').html('');
	$('#loadConfirm6').html('');
	$('#loadConfirmTime6').html('');
	$('#loadConfirm7').html('');
	$('#loadConfirmTime7').html('');
	$('#loadBalanceCash').html('');
	$('#loadBalanceOil').html('');
	$('#loadBalanceSum').html('');

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
/* 导出 */
function doexport()
{
	 var driver=$('#driver').val();
	   var cardNo=$('#carNo').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var scheduleBillNo=$('#scheduleBillNo').val();
	   if(cardNo=='' || cardNo==null || cardNo=='-1'){
		   cardNo='';
	   }	
	   var form = $('<form action="${ctx}/operationMng/transportCostMng/export" method="post"></form>');
	   var driverInput = $('<input id="driverName" name="driverName" value="'+driver+'" type="hidden" />');
	   var cardNoInput = $('<input id="carNumber" name="carNumber" value="'+cardNo+'" type="hidden" />');	   
	   var startTimeInput = $('<input id="startTime" name="startTime" value="'+startTime+'" type="hidden" />');
	   var endTimeInput = $('<input id="endTime" name="endTime" value="'+endTime+'" type="hidden" />');
	   var scheduleBillNoInput = $('<input id="scheduleBillNo" name="scheduleBillNo" value="'+scheduleBillNo+'" type="hidden" />');
	   form.append(driverInput);
	   form.append(cardNoInput);
	   form.append(startTimeInput);
	   form.append(endTimeInput);
	   form.append(scheduleBillNoInput);
	   $('body').append(form);
	   form.submit();
}

/* 查看 */
function doshow(id){
	location.href="${ctx}/operationMng/transportCostMng/queryIndex/"+id+'?type=1';
}
</script>



</body>
</html>






