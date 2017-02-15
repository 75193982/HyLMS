
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
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->

</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			财务管理
			<small>
				<i class="icon-double-angle-right"></i>
				成本查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
			<label class="title mul-title" style="width:75px;">承运商：</label>
		    <select id="outSourcingId" class="form-box mul-form-box" style="width:200px;">
		    </select>
		    <label class="title mul-title" style="width:95px;">品牌：</label>
		    <select id="brand" class="form-box mul-form-box" style="width:200px;">
		    </select>
		    <label class="title mul-title" style="width:75px;">调度单号：</label>
		    <input id="scheduleBillNo" class="form-box mul-form-box" type="text" style="width:200px;" placeholder="请输入调度单号"/>
		</div>
		<div class="searchbox col-xs-12">
		  <label class="title mul-title" style="float: left;height: 34px;line-height: 34px;width:75px;">下单日期：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 200px;margin-right:20px; margin-left: 5px;height: 34px;line-height: 34px;">
				<input class="form-control" id="waybillDate" type="text" placeholder="请输入下单日期" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title mul-title" style="float: left;height: 34px;line-height: 34px;width:98px;">装运日期：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 200px;margin-right:20px; margin-left: 5px;height: 34px;line-height: 34px;">
				<input class="form-control" id="scheduleDate" type="text" placeholder="请输入装运日期" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		</div>
		<div class="searchbox col-xs-12">
		   
		    <label class="title mul-title" style="width:75px;">运单状态：</label>
		    <select id="waybillStatus" class="form-box mul-form-box" style="width:200px;">
		       <option value="">请选择运单状态</option>
		       <option value="1">待复核</option>
		       <option value="2">待回执</option>
		       <option value="3">已完成</option>
		    </select>
		    <label class="title mul-title" style="width:95px;">调度单状态：</label>
		    <select id="scheduleStatus" class="form-box mul-form-box" style="width:200px;">
		       <option value="">请选择调度单状态</option>
		       <option value="3">在途</option>
		       <option value="4">已完成</option>
		    </select>
			<a class="itemBtn m-lr5" onclick="searchInfo()">查询</a>
			<a class="itemBtn m-lr5" onclick="doprint()">打印</a>
			<a class="itemBtn m-lr5" onclick="doexport()">导出</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover" style="overflow-x:auto;width:1800px;">
			<thead>
				<tr>														
					<th>序号</th>
					<th>承运商</th>
					<th>品牌</th>
                    <th>车型</th>
                    <th>车架号</th>
					<th>下单日期</th>
					<th>运单编号</th>
					<th>装运车号</th>
					<th>装运日期</th>
                    <th>调度单号</th>
                    <th>起运地</th>
                    <th>目的地</th>
                    <th>台数</th>
                    <th>公里数</th>
                    <th>结算单价</th>
                    <th>结算运费</th>
                    <th>驳板费</th>
                    <th>加价运费</th>
                    <th>其他扣除</th>
                    <th>最终费用</th>
                    <th>运单状态</th> 
                    <th>调度单状态</th>                    
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			
		</div>
		<div id="sumCount" class="sumCount">
		   <p class="sumInfo">当页总计(元)：<span id="localSum"></span></p>
		   <p class="sumInfo">费用总计(元)：<span id="allSum" ></span></p>
		</div>
	</div>
</div>
<!-- 编辑额外计费Modal--Begin -->
      <div class="modal fade" id="modal-add" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="refresh();">×</button>
						<h3 id="myModalLabelAdd">新增加价运费</h3>
						<input id="modalAddFlag" type="hidden" />
						<input id="carStockId" type="hidden" />
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <div class="add-item extra-item">
								        <label class="title"><span class="red">*</span>金额：</label>
								        <input class="form-control" type="text" id="amountInfo" placeholder="请输入金额"/><span class="unit">(元)</span>
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-item">
								        <label class="title">备注：</label>
								        <input class="form-control" type="text" id="markInfo" placeholder="请输入备注"/>
								    </div>
							  		<hr class="tree"></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="addSave();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="refresh();">取消</a>
									 </div>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
<!-- 新增额外计费Modal--End -->

<!-- 查看额外计费Modal--Begin -->
      <div class="modal fade" id="modal-show" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:5%;width:900px;margin:auto;">
				  <div class="modal-content" style="width:980px;margin:auto;">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="showRefresh();">×</button>
						<h3 id="myModalLabelShow">查看加价运费记录</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main" id="detailList" style="padding:5px;">
								</div>
								<div class="row newrow">
							       <div class="col-xs-4"></div>
							       <div class="col-xs-4">
								       <div class="form-contr">
								          <a class="backbtn" onclick="showRefresh();"><i class="icon-undo" style="display: inline-block;width: 20px;"></i>返回</a>
								       </div>
							       </div>
							       <div class="col-xs-4"></div>
							     </div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
<!-- 查看额外计费Modal--End -->
<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>收入管理信息表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable myDataTableCarDetail">
		    <thead>
		      <tr>
		            <th>序号</th>
					<th>承运商</th>
					<th>品牌</th>
                    <th>车型</th>
                    <th>车架号</th>
					<th>下单日期</th>
					<th>运单编号</th>
					<th>装运车号</th>
					<th>装运日期</th>
                    <th>调度单号</th>
                    <th>起运地</th>
                    <th>目的地</th>
                    <th>台数</th>
                    <th>公里数</th>
                    <th>结算单价</th>
                    <th>结算运费</th>
                    <th>驳板费</th>
                    <th>加价运费</th>
                    <th>其他扣除</th>
                    <th>最终费用</th>
                    <th>运单状态</th> 
                    <th>调度单状态</th>     
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
<script type="text/javascript">

function init(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/costMng/getListData" , //获取数据的ajax方法的URL							 
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
						    {data: "outSourcingName",'width':'5%'},
						    {data: "brand",'width':'4%'},
						    {data: "model",'width':'4%'},
						    {data: "vin",'width':'4%'},
						    {data: "waybillDate",'width':'5%'},
						    {data: "waybillNo",'width':'4%'},
						    {data: "carNumber",'width':'4%'},
						    {data: "scheduleDate",'width':'5%'},
						    {data: "scheduleBillNo",'width':'5%'},
						    {data: "startAddress",'width':'4%'},
						    {data: "targetCity",'width':'4%'},
						    {data: "count",'width':'4%'},
						    {data: "distance",'width':'4%'},
						    {data: "price",'width':'4%'},
						    {data: "balancePrice",'width':'4%'},
						    {data: "bargePrice",'width':'4%'},
						    {data: "farePrice",'width':'7%'},
						    {data: "otherDeduct",'width':'7%'},
						    {data: "sumPrice",'width':'4%'},
						    {data: "waybillStatus",'width':'4%'},
						    {data: "scheduleStatus",'width':'4%'}
							],
						    columnDefs: [
								
								{
									 //加价运费
									 targets:17,
									 render: function (data, type, row, meta) {
										 return '<p><span style="width:50px;float:left;">'+data+'</span>'
										 		+'<a class="cur" onclick="editPrice('+row.id+',0)" style="width:20px;float:left;height:12px;"><img src="${ctx}/staticPublic/images/addAmount.png"/></a>'
										        +'<a class="cur" onclick="showPrice('+row.id+',0)" style="width:20px;float:left;height:12px;"><img src="${ctx}/staticPublic/images/editAmount.png"/></a>'
										        +'</p>';
								     }	       
								},
								{
									 //其它扣除
									 targets:18,
									 render: function (data, type, row, meta) {
										 return '<p><span style="width:50px;float:left;">'+data+'</span>'
									 		+'<a class="cur" onclick="editPrice('+row.id+',1)" style="width:20px;float:left;height:12px;"><img src="${ctx}/staticPublic/images/addAmount.png"/></a>'
									        +'<a class="cur" onclick="showPrice('+row.id+',1)" style="width:20px;float:left;height:12px;"><img src="${ctx}/staticPublic/images/editAmount.png"/></a>'
									        +'</p>';
								     }	       
								},
								{
									 //状态
									 targets:20,
									 render: function (data, type, row, meta) {
								          if(data=='1'){
								        	  return '待复核';
								          }else if(data=='2'){
								        	  return '待回执';
								          }else if(data=='3'){
								        	  return '已完成';
								          }else{
								        	  return data;
								          }
								      }	       
								},
								{
									 //状态
									 targets:21,
									 render: function (data, type, row, meta) {
								          if(data=='3'){
								        	  return '在途';
								          }else if(data=='4'){
								        	  return '已完成';
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
		 "sAjaxSource": "${ctx}/operationMng/costMng/getListData" , //获取数据的ajax方法的URL	
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
					    {data: "outSourcingName",'width':'5%'},
					    {data: "brand",'width':'4%'},
					    {data: "model",'width':'4%'},
					    {data: "vin",'width':'4%'},
					    {data: "waybillDate",'width':'5%'},
					    {data: "waybillNo",'width':'4%'},
					    {data: "carNumber",'width':'4%'},
					    {data: "scheduleDate",'width':'5%'},
					    {data: "scheduleBillNo",'width':'5%'},
					    {data: "startAddress",'width':'4%'},
					    {data: "targetCity",'width':'4%'},
					    {data: "count",'width':'4%'},
					    {data: "distance",'width':'4%'},
					    {data: "price",'width':'4%'},
					    {data: "balancePrice",'width':'4%'},
					    {data: "bargePrice",'width':'4%'},
					    {data: "farePrice",'width':'7%'},
					    {data: "otherDeduct",'width':'7%'},
					    {data: "sumPrice",'width':'4%'},
					    {data: "waybillStatus",'width':'4%'},
					    {data: "scheduleStatus",'width':'4%'}
						],
					    columnDefs: [
							
							{
								 //加价运费
								 targets:17,
								 render: function (data, type, row, meta) {
									 return '<p><span style="width:50px;float:left;">'+data+'</span>'
									 		+'<a class="cur" onclick="editPrice('+row.id+',0)" style="width:20px;float:left;height:12px;"><img src="${ctx}/staticPublic/images/addAmount.png"/></a>'
									        +'<a class="cur" onclick="showPrice('+row.id+',0)" style="width:20px;float:left;height:12px;"><img src="${ctx}/staticPublic/images/editAmount.png"/></a>'
									        +'</p>';
							     }	       
							},
							{
								 //其它扣除
								 targets:18,
								 render: function (data, type, row, meta) {
									 return '<p><span style="width:50px;float:left;">'+data+'</span>'
								 		+'<a class="cur" onclick="editPrice('+row.id+',1)" style="width:20px;float:left;height:12px;"><img src="${ctx}/staticPublic/images/addAmount.png"/></a>'
								        +'<a class="cur" onclick="showPrice('+row.id+',1)" style="width:20px;float:left;height:12px;"><img src="${ctx}/staticPublic/images/editAmount.png"/></a>'
								        +'</p>';
							     }	       
							},
							{
								 //状态
								 targets:20,
								 render: function (data, type, row, meta) {
							          if(data=='1'){
							        	  return '待复核';
							          }else if(data=='2'){
							        	  return '待回执';
							          }else if(data=='3'){
							        	  return '已完成';
							          }else{
							        	  return data;
							          }
							      }	       
							},
							{
								 //状态
								 targets:21,
								 render: function (data, type, row, meta) {
							          if(data=='3'){
							        	  return '在途';
							          }else if(data=='4'){
							        	  return '已完成';
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
	$("#waybillDate").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#scheduleDate").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	init();
	bindOutSourcing();
	bindBrand();
	moneySum();
});

/* 获取数据总金额 */
function moneySum(){
	   var supplierId=$('#supplierId').val();
	   var brand=$('#brand').val();
	   var waybillDate=$('#waybillDate').val();
	   var scheduleDate=$('#scheduleDate').val();
	   var scheduleBillNo=$('#scheduleBillNo').val();
	   var waybillStatus=$('#waybillStatus').val();
	   $.ajax({
			type : 'POST',
			url : '${ctx}/operationMng/costMng/getSumPrice',
			data : JSON.stringify({
				supplierId : supplierId,
				scheduleBillNo : scheduleBillNo,
				brand : brand,
				waybillDate : waybillDate,
				scheduleDate : scheduleDate,
				waybillStatus : waybillStatus
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					$('#allSum').html(data.data);
				}else{
					$('#allSum').html('');
				}
			}
	   });
}


/* 绑定承运商 */
function bindOutSourcing(){
	$.ajax({  
        url: '${ctx}/operationMng/costMng/getOutSourcingList',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: '',
        success: function (data) {
        	var html ='<option value="">请选择承运商 </option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                		}
            		}
            	}
            	$('#outSourcingId').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}
/* 绑定品牌 */
function bindBrand(){
	$.ajax({  
        url: '${ctx}/operationMng/incomeMng/getCarBrandList',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: '',
        success: function (data) {
        	var html ='<option value="">请选择品牌</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['brandName']+'>'+data.data[i]['brandName']+'</option>';
                		}
            		}
            	}
            	$('#brand').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}
/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   $('#secho').val(secho);
	   var outSourcingId=$('#outSourcingId').val();
	   var brand=$('#brand').val();
	   var waybillDate=$('#waybillDate').val();
	   var scheduleDate=$('#scheduleDate').val();
	   var scheduleBillNo=$('#scheduleBillNo').val();
	   var waybillStatus=$('#waybillStatus').val();
	   var scheduleStatus=$('#scheduleStatus').val();
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				outSourcingId : outSourcingId,
				scheduleBillNo : scheduleBillNo,
				brand : brand,
				waybillDate : waybillDate,
				scheduleDate : scheduleDate,
				waybillStatus : waybillStatus,
				scheduleStatus : scheduleStatus
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {	
					obj.iTotalDisplayRecords=data.data.totalCounts;
					obj.iTotalRecords=data.data.totalCounts;
					obj.aaData=data.data.records;		
					obj.sEcho=data.data.frontParams;
					var sum=0;
					if(obj.aaData.length>0){
						for(var i=0;i<obj.aaData.length;i++){
							obj.aaData[i]["rownum"]=i+1;
							sum+=parseFloat(obj.aaData[i]["sumPrice"]);
						}
					}else{
						obj.aaData=[];
					}
					fnCallback(obj); //服务器端返回的对象的returnObject部分是要求的格式  	
					$('#localSum').html((parseFloat(sum)).toFixed(2));
					/* var showimg = "<input id='localSumShow' type='hidden' value="+sum+" />";
					$('#detailtable_info').append(showimg); */ 
					/* console.info(JSON.stringify($('#detailtable_info').html())); */
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
/* 新增加价运费 以及其它扣除*/
function editPrice(id,flag){
	$('#amountInfo').val('');
	$('#markInfo').val('');
	$('#modalAddFlag').val(flag);
	$('#carStockId').val(id);
	if(flag=="0"){
		$('#myModalLabelAdd').html('添加加价运费');
	}else{
		$('#myModalLabelAdd').html('添加其它扣除');
	}
	$('#modal-add').modal('show');
}

/* 查看加价运费以及其它扣除 */

function showPrice(id,flag){
	var html="";
	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/costMng/getAttachDetail",
		data : JSON.stringify({
			carStockId : id,
			chargeType :flag
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				if(data.data.length>0){
					for(var i=0;i<data.data.length;i++){
						if(data.data[i]['amount']==null){
							data.data[i]['amount']='';
						}
						html+='<div class="extraList border-b-ff9a00">'
							+'<div class="row newrow" style="padding:0;"><div class="col-xs-1 pd-2"><div class="lab-tit" style="text-align:left;"><label>金额(元)：</label></div></div>'
							+'<div class="col-xs-5"><div class="form-contr"><p class="form-control no-border" id="listAmount'+i+'">'+data.data[i]['amount']+'</p></div></div>'
							+'<div class="col-xs-1 pd-2"><div class="lab-tit" style="text-align:left;"><label>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</label></div></div>'
							+'<div class="col-xs-5"><div class="form-contr"><p class="form-control no-border" id="listMark'+i+'">'+data.data[i]['mark']+'</p></div></div></div>'
							+'<div class="row newrow" style="padding:0;"><div class="col-xs-1 pd-2"><div class="lab-tit" style="text-align:left;"><label>修改人：</label></div></div>'
							+'<div class="col-xs-5"><div class="form-contr"><p class="form-control no-border" id="listInsertUser'+i+'">'+data.data[i]['insertUser']+'</p></div></div>'
							+'<div class="col-xs-1 pd-2"><div class="lab-tit" style="text-align:left;"><label>修改时间：</label></div></div>'
							+'<div class="col-xs-5"><div class="form-contr"><p class="form-control no-border" id="listInsertTime'+i+'">'+jsonDateFormat(data.data[i]['insertTime'])+'</p></div></div></div>'
							+'</div>';
					}
				}else {
					html+='<div class="extraList border-b-ff9a00">'
						+'<div class="row newrow"><div class="col-xs-12 pd-2"><p class="form-control no-border">暂无修改信息</p></div></div>'
						+'</div>';
				}
				if(flag=='0'){
					$('#myModalLabelShow').html('查看加价运费记录');
				}else{
					$('#myModalLabelShow').html('查看其它扣除记录');
				}
				$('#detailList').html(html);
				$('#modal-show').modal('show');
			}else{
				bootbox.alert(data.msg);
			} 
		}
	}); 
	
}
/* 取消 */
function refresh(){
	$('#modalAddFlag').val('');
	$('#carStockId').val('');
	$('#modal-add').modal('hide');
}
/* 查看取消 */
function showRefresh(){
	$('#modal-show').modal('hide');
}
/* 保存 新增费用*/
function addSave(){
	var flag="false";
	var chargeType=$('#modalAddFlag').val();
	var carStockId=$('#carStockId').val();
	var amount=$('#amountInfo').val();
	var mark=$('#markInfo').val();
	if(amount==null || amount==''){
		bootbox.alert('请输入金额');
		return;
	}else{
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该信息?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : "${ctx}/operationMng/costMng/save",
							data : JSON.stringify({
								chargeType : chargeType,
								carStockId : carStockId,
								amount : amount,
								mark : mark
							}),
							contentType : "application/json;charset=UTF-8",
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {
									bootbox.confirm_alert({ 
										  size: "small",
										  message: "新增成功！", 
										  callback: function(result){
											  if(result){
												  flag="true";
												$('#modal-add').modal('hide');
												reload();
											  }else{
												  $('#modal-add').modal('hide');
													reload();  
											  }
										  }
									 });
									setTimeout(function(){
										if(flag=="false"){
											  $('#modal-add').modal('hide');
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
	

}
/* 执行对账 */
function dobalance(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要执行对账吗?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/incomeMng/balance/"+id,
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "执行对账成功！", 
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
							}
						}
					});
			  }
		  }
	});
}
/* 导出 */
function doexport()
{
	   var scheduleBillNo=$('#scheduleBillNo').val();
	   var brand=$('#brand').val();
	   var waybillDate=$('#waybillDate').val();
	   var scheduleDate=$('#scheduleDate').val();
	   var supplierId=$('#supplierId').val();
	   var waybillStatus=$('#waybillStatus').val();
	   var form = $('<form action="${ctx}/operationMng/incomeMng/export" method="post"></form>');
	   var brandInput = $('<input id="brand" name="brand" value="'+brand+'" type="hidden" />');
	   var waybillDateInput = $('<input id="waybillDate" name="waybillDate" value="'+waybillDate+'" type="hidden" />');
	   var scheduleDateInput = $('<input id="scheduleDate" name="scheduleDate" value="'+scheduleDate+'" type="hidden" />');
	   var scheduleBillNoInput = $('<input id="scheduleBillNo" name="scheduleBillNo" value="'+scheduleBillNo+'" type="hidden" />');
	   var supplierIdInput = $('<input id="supplierId" name="supplierId" value="'+supplierId+'" type="hidden" />');
	   var waybillStatusInput = $('<input id="waybillStatus" name="waybillStatus" value="'+waybillStatus+'" type="hidden" />');
	   form.append(waybillDateInput);
	   form.append(brandInput);
	   form.append(scheduleDateInput);
	   form.append(scheduleBillNoInput);
	   form.append(supplierIdInput);
	   form.append(waybillStatusInput);
	   $('body').append(form);
	   form.submit();
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
	   var outSourcingId=$('#outSourcingId').val();
	   var brand=$('#brand').val();
	   var waybillDate=$('#waybillDate').val();
	   var scheduleDate=$('#scheduleDate').val();
	   var scheduleBillNo=$('#scheduleBillNo').val();
	   var waybillStatus=$('#waybillStatus').val();
	   var scheduleStatus=$('#scheduleStatus').val();
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/operationMng/costMng/getPrint",
			data : JSON.stringify({
				outSourcingId : outSourcingId,
				brand : brand,
				waybillDate : waybillDate,
				scheduleDate : scheduleDate,
				scheduleBillNo : scheduleBillNo,
				waybillStatus : waybillStatus,
				scheduleStatus : scheduleStatus
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {					
					if(data.data.length>0){
						for(var i=0;i<data.data.length;i++){
							    data.data[i]["rownum"]=i+1;
							     if(data.data[i]["waybillStatus"]=='1'){
							    	 data.data[i]["waybillStatus"]='待复核'; 
						         }else if(data.data[i]["waybillStatus"]=='2'){
						        	 data.data[i]["waybillStatus"]='待回执';
						         }else{
						        	 data.data[i]["waybillStatus"]='已完成';
						         }
							     if(data.data[i]["scheduleStatus"]=='3'){
							    	 data.data[i]["scheduleStatus"]='在途'; 
						         }else{
						        	 data.data[i]["scheduleStatus"]='已完成';
						         }
							     if(data.data[i]["outSourcingName"]==null || data.data[i]["outSourcingName"]==''){
							    	 data.data[i]["outSourcingName"]="";
							     }
							     if(data.data[i]["brand"]=='' || data.data[i]["brand"]==null){
							    	 data.data[i]["brand"]='';
							     }
							     if(data.data[i]["model"]=='' || data.data[i]["model"]==null){
							    	 data.data[i]["model"]='';
							     }
							     if(data.data[i]["waybillDate"]=='' || data.data[i]["waybillDate"]==null){
							    	 data.data[i]["waybillDate"]='';
							     }else{
							    	 data.data[i]["waybillDate"]=jsonForDateFormat(data.data[i]["waybillDate"]);
							     }
							     if(data.data[i]["waybillNo"]=='' || data.data[i]["waybillNo"]==null){
							    	 data.data[i]["waybillNo"]='';
							     }
							     if(data.data[i]["scheduleDate"]=='' || data.data[i]["scheduleDate"]==null){
							    	 data.data[i]["scheduleDate"]='';
							     }else{
							    	 data.data[i]["scheduleDate"]=jsonForDateFormat(data.data[i]["scheduleDate"]);
							     }
							     if(data.data[i]["scheduleBillNo"]=='' || data.data[i]["scheduleBillNo"]==null){
							    	 data.data[i]["scheduleBillNo"]='';
							     }
							     if(data.data[i]["startAddress"]=='' || data.data[i]["startAddress"]==null){
							    	 data.data[i]["startAddress"]='';
							     }
							     if(data.data[i]["targetCity"]=='' || data.data[i]["targetCity"]==null){
							    	 data.data[i]["targetCity"]='';
							     }
							     if(data.data[i]["count"]=='' || data.data[i]["count"]==null){
							    	 data.data[i]["count"]='';
							     }
							     if(data.data[i]["distance"]=='' || data.data[i]["distance"]==null){
							    	 data.data[i]["distance"]='';
							     }
							     if(data.data[i]["carNumber"]=='' || data.data[i]["carNumber"]==null){
							    	 data.data[i]["carNumber"]='';
							     }
							     if(data.data[i]["price"]=='' || data.data[i]["price"]==null){
							    	 data.data[i]["price"]='0';
							     }
							     if(data.data[i]["balancePrice"]==null || data.data[i]["balancePrice"]==''){
							    	 data.data[i]["balancePrice"]='0';
							     }
							     if(data.data[i]["bargePrice"]=='' || data.data[i]["bargePrice"]==null){
							    	 data.data[i]["bargePrice"]='0';
							     }
							     if(data.data[i]["farePrice"]=='' || data.data[i]["farePrice"]==null){
							    	 data.data[i]["farePrice"]='0';
							     }
							     if(data.data[i]["otherDeduct"]==null || data.data[i]["otherDeduct"]==''){
							    	 data.data[i]["otherDeduct"]='0';
							     }
							     if(data.data[i]["sumPrice"]==null || data.data[i]["sumPrice"]==''){
							    	 data.data[i]["sumPrice"]='0';
							     }
							     if(data.data[i]["vin"]==null || data.data[i]["vin"]==''){
							    	 data.data[i]["vin"]='';
							     }
								html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
							    +'<td>'+data.data[i]["outSourcingName"]+'</td>'
							    +'<td>'+data.data[i]["brand"]+'</td>'
							    +'<td>'+data.data[i]["model"]+'</td>'
							    +'<td>'+data.data[i]["vin"]+'</td>'
							    +'<td>'+data.data[i]["waybillDate"]+'</td>'
							    +'<td>'+data.data[i]["waybillNo"]+'</td>'
							    +'<td>'+data.data[i]["carNumber"]+'</td>'
							    +'<td>'+data.data[i]["scheduleDate"]+'</td>'
							    +'<td>'+data.data[i]["scheduleBillNo"]+'</td>'
							    +'<td>'+data.data[i]["startAddress"]+'</td>'
							    +'<td>'+data.data[i]["targetCity"]+'</td>'
							    +'<td>'+data.data[i]["count"]+'</td>'
							    +'<td>'+data.data[i]["distance"]+'</td>'
							    +'<td>'+data.data[i]["price"]+'</td>'
							    +'<td>'+data.data[i]["balancePrice"]+'</td>'
							    +'<td>'+data.data[i]["bargePrice"]+'</td>'
							    +'<td>'+data.data[i]["farePrice"]+'</td>'
							    +'<td>'+data.data[i]["otherDeduct"]+'</td>'
							    +'<td>'+data.data[i]["sumPrice"]+'</td>'
							    +'<td>'+data.data[i]["waybillStatus"]+'</td>'
							    +'<td>'+data.data[i]["scheduleStatus"]+'</td>'
							    +'</tr>';	
						      
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
		 pageSize: 15
		});
		javasricpt:window.print();
		$('#breadcrumbs').show();
		$('.page-content').show();
		$('#printTable').hide();
		$("#printTable").html(html);
	 }

</script>



</body>
</html>






