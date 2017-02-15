
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/ztree/demo.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
 
    .col-xs-12{
    margin-bottom:10px;
    }
</style>
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			查询管理
			<small>
				<i class="icon-double-angle-right"></i>
				运单查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">		
		<div class="searchbox col-xs-12">
			<label class="title">运单编号：</label>
		      <input class="form-box" id="fom_waybillNo" type="text"  placeholder="请输入运单编号"/>
			<label class="titletwo">状态：</label>
		    	 <select id="fom_status" class="form-box" >	
		    	 <option value="">请选择状态</option>
		    	 <option value='0'>新建</option>
		    	 <option value='1'>待复核</option>	
		    	 <option value='2'>待回执</option>
		    	 <option value='3'>已完成</option>   
			</select>				  
			<a class="itemBtn" onclick="searchInfo()">查询</a>		
			</div>	
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>运单编号</th>
					<th>类型</th>
                    <th>供应商名称</th>
                    <th>品牌</th>
                    <th>经销单位</th>
                    <th>始发地</th>
                    <th>目的省</th>
                    <th>目的地</th>
                    <th>下单日期</th> 
                    <th>创建时间</th>
                    <th>状态</th>                                      
                     <th>操作</th> 
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div class="modal fade" id="modal-detilinfo" tabindex="-1" role="dialog">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">运单信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item col-xs-12">
							     <label class="title col-xs-2">类型：</label><label class="title col-xs-4" id="type_view"></label>	
							      <label class="title col-xs-2">运单编号：</label><label class="title col-xs-4" id="waybillNo_view"></label>						     								     							     
							  </div>		
							  <div id="hidden1">				
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12 " >
							     <label class="title col-xs-2">品牌：</label><label class="title col-xs-4" id="brand_view"></label>
							     <label class="title col-xs-2">经销单位：</label><label class="title col-xs-4" id="carShopId_view"></label>									     						   
							 </div>							 
							   <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							  <label class="title col-xs-2">供应商：</label><label class="title col-xs-10" id="supplierId_view"></label>								    							     						   
							 </div>	
							 </div>
							   <hr class="tree"></hr>
							 <div class="add-item col-xs-12">	
							  <label class="title col-xs-2">下单日期：</label><label class="title col-xs-10" id="sendTime_view"></label>	
							  </div>
							  <div id="hidden2">							
							 <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-2">运输价格：</label><label class="title col-xs-4" id="amount_view"></label>	
							    <label class="title col-xs-2">接车联系人电话：</label><label class="title col-xs-4" id="receiveUserTelephone_view"></label>						    
							 </div>																												 
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							  <label class="title col-xs-2">接车联系人：</label><label class="title col-xs-4" id="receiveUser_view"></label>								  
							     <label class="title col-xs-2">接车联系人手机：</label><label class="title col-xs-4" id="receiveUserMobile_view"></label>							
							 </div>	
							 </div>
							   <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-2">始发地：</label><label class="title col-xs-10" id="startAddress_view"></label>	
							    </div>	
							     <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-2">目的地：</label><label class="title col-xs-10" id="targetAddress_view"></label>								    
							    </div>
							     <div id="hidden4">				
							  <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-2">目的省 ：</label><label class="title col-xs-10" id="targetProvince_view"></label>							     
							    </div>
							    </div>
							    <div id="hidden3">				
							  <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-2">公里数 ：</label><label class="title col-xs-10" id="distance_view"></label>							     
							    </div>
							    </div>
							     <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-2">附件：</label><label class="title col-xs-10" id="file_view"></label>							    								    
							    </div>
							    <hr class="tree"></hr>
							   <div class="add-item">
							     <label class="title">商品车信息：</label>	
							     <table id="cardetable_view" class="table table-striped table-bordered table-hover">
			                      <thead>
				                   <tr>					                   													
					               <th>序号</th>
					               <th>类型</th>
                                  <!--  <th >供应商名称</th> -->
                                   <th>品牌</th>
                                   <th>车架号</th>
                                   <th>车型</th>
                                   <th>颜色</th> 
                                   <th>发动机号</th> 
                                   <th>备注</th>
                                   <!-- <th>状态</th>   -->                                                                           
				                     </tr>
			                      </thead>
			                      <tbody>
			                      </tbody>
			                      </table>								     
							    </div>	
							      <hr class="tree"></hr>
							   <div class="add-item">
							     <label class="title">配件信息：</label>	
							     <table id="attachmentdetable_view" class="table table-striped table-bordered table-hover">
			                      <thead>
				                   <tr>													
					               <th>序号</th>
					               <th>配件名称</th>
                                   <th>存放位置</th>
                                   <th>数量</th>
                                   <th>备注</th>
                                 <!--   <th>状态</th>        -->                                                                                                      
				                     </tr>
			                      </thead>
			                      <tbody>
			                      </tbody>
			                      </table>									     
							    </div>										   			  
							    <hr class="tree"></hr>							    
								 <div class="add-item-btn" id="viewBtn">								   
								    <a class="add-itemBtn btnCancle" onclick="doclose()">关闭</a>
								  </div> 
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
			
			<div class="modal fade" id="modal-upload" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">操作日志信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">							
							   <div class="add-item">
							     <table id="processtable" class="table table-striped table-bordered table-hover">
			                      <thead>
				                   <tr>
                                              <th>序号</th>
                                              <th>流程步骤名称</th>
                                              <th>操作人名称</th>
                                              <th>操作时间</th>
                                              <th>审核意见</th>
                                              <th>附件</th></tr>
			                      </thead>
			                      <tbody>
			                      </tbody>
			                      </table>								     
							    </div>								  									   			  
							    <hr class="tree"></hr>							    
								 <div class="add-item-btn" id="viewBtns">								   
								    <a class="add-itemBtn btnCancle" onclick="doproceclose()">关闭</a>
								  </div> 
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
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
		 "sAjaxSource": "${ctx}/waybill/waybillManage/getAdminiWaybillList" , //获取数据的ajax方法的URL							 
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
				columns: [{ data: "rownum" ,"width": "5%"},
						    {data: "waybillNo","width": "8%"},
						    {data: "type","width": "5%"},
						    {data: "supplierName","width": "8%"},
						    {data: "brand","width": "6%"},
						    {data: "carShopName","width": "7%"},
						    {data: "startAddress","width": "7%"},
						    {data: "targetProvince","width": "7%"},/* 目的省 */
						    {data: "targetCity","width": "7%"},		
						    {data: "sendTime","width": "9%"},	
						    {data: "insertTime","width": "8%"},
						    {data: "status","width": "6%"},						   
						    {data: null,"width": "15%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 2,
				 render: function (data, type, row, meta) {
					 if(data=='0'){
						 return '商品车';
					 }else if(data=='1'){
						 return '二手车';
					 }else{
						 return data;
					 }
			       }	       
			},{
				 //入职时间
				 targets: 10,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return data.substr(0,19);
					 }else{
						 return '';
					 }
					
			       }	       
			},{
				 //入职时间
				 targets: 11,
				 render: function (data, type, row, meta) {
					 if(data=='0'){
						 return '新建';
					 }else if(data=='1'){
						 return '待复核';
					 }else if(data=='2'){
						 return '待回执';
					 }else if(data=='3'){
						 return '已完成';
					 }else {
						 return data;
					 }						
			       }	       
			},
		      	{
			    	 //操作栏
			    	 targets: 12,
			    	 render: function (data, type, row, meta) {	
			    		 if(row.status=='0'){
			    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';	
			    		 }else{
			    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'
				    		 +'<a class="table-edit" onclick="doviewtask('+ row.id +')" style="width:70px;">操作日志</a>';	
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
		 "sAjaxSource": "${ctx}/waybill/waybillManage/getAdminiWaybillList", //获取数据的ajax方法的URL	
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
				columns: [{ data: "rownum" ,"width": "5%"},
						    {data: "waybillNo","width": "8%"},
						    {data: "type","width": "5%"},
						    {data: "supplierName","width": "8%"},
						    {data: "brand","width": "6%"},
						    {data: "carShopName","width": "7%"},
						    {data: "startAddress","width": "7%"},
						    {data: "targetProvince","width": "7%"},/* 目的省 */
						    {data: "targetCity","width": "7%"},		
						    {data: "sendTime","width": "9%"},	
						    {data: "insertTime","width": "8%"},
						    {data: "status","width": "6%"},						   
						    {data: null,"width": "15%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 2,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
										 return '商品车';
									 }else if(data=='1'){
										 return '二手车';
									 }else{
										 return data;
									 }			
							       }	       
							},{
								 //入职时间
								 targets: 10,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return data.substr(0,19);
									 }else{
										 return '';
									 }
									
							       }	       
							},{
								 //入职时间
								 targets: 11,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
										 return '新建';
									 }else if(data=='1'){
										 return '待复核';
									 }else if(data=='2'){
										 return '待回执';
									 }else if(data=='3'){
										 return '已完成';
									 }else {
										 return data;
									 }						
							       }	       
							},
						      	{
							    	 //操作栏
							    	 targets: 12,
							    	 render: function (data, type, row, meta) {			    		
							    		 if(row.status=='0'){
							    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';	
							    		 }else{
							    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'
								    		 +'<a class="table-edit" onclick="doviewtask('+ row.id +')" style="width:70px;">操作日志</a>';	
							    		 }				                 
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){		
	var url = location.href;
	//console.log(url);
	if(url.indexOf("?")>0){
    var waybillNo = url.substring(url.indexOf("?")+1,url.length);
    $("#fom_waybillNo").val(waybillNo);
	}	
	//console.log(paraString);
	init();
	//getOutSourcing();//获取外协单位
	//getCarShop();
})

/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   //console.log(pageStartIndex);		
	   var pageSize=aoData[4]["value"];
	   var waybillNo=$("#fom_waybillNo").val(); 
	   var status=$("#fom_status").val(); 
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				waybillNo :$.trim(waybillNo) ,
				status : $.trim(status)				
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
				   // console.log(JSON.stringify(data.data));							
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
 function doview(id){
	 cleardetil();
	$.ajax({
		type : 'GET',
		url : "${ctx}/waybill/waybillManage/checkWaybill/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				$('#id-hidden').val(id);
				$('#myModalLabel').html('运单信息');
				$("#waybillNo_view").html(data.data.waybillNo);
				if(data.data.type=='1'){
					$("#type_view").html('二手车'); 
					$('#hidden1').hide();
					$('#hidden3').hide();
					$('#hidden2').show();
					$('#hidden4').hide();
				}else{
					$("#type_view").html('商品车'); 
					$('#hidden1').show();
					$('#hidden2').hide();
					$('#hidden3').hide();
					$('#hidden4').show();
				}				
				$("#supplierId_view").html(data.data.supplierName); 
				$("#amount_view").html(data.data.amount); 
				$("#brand_view").html(data.data.brand); 
				$("#carShopId_view").html(data.data.carShopName);
				$("#sendTime_view").html(data.data.sendTime); 
				$("#receiveUser_view").html(data.data.receiveUser); 
				$("#receiveUserTelephone_view").html(data.data.receiveUserTelephone); 
				$("#receiveUserMobile_view").html(data.data.receiveUserMobile); 
				$("#startAddress_view").html(data.data.startAddress);
				$("#targetAddress_view").html(data.data.targetCity);
				$("#targetProvince_view").html(data.data.targetProvince);
				$("#distance_view").html(data.data.distance);
				if(data.data.attachFileName!=''&&data.data.attachFileName!=null){
					var attachFilePaths="${ctx}"+data.data.attachFilePath;
					$("#file_view").html('<a  href='+attachFilePaths+' target="_blank">'+data.data.attachFileName+'</a>');
				}
				if(data.data.carStockList.length>0){
					for(var i=0;i<data.data.carStockList.length;i++){
						data.data.carStockList[i]["rownum"]=i+1;
					}
					$('#cardetable_view').dataTable({
						 dom: 'Bfrtip',	
						 destroy: true,
						 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
						 "bFilter": false,    //不使用过滤功能  
						 "bProcessing": true, //加载数据时显示正在加载信息	
						 "bPaginate" : false,
						 "bInfo" : false,
						  ordering: false,
							"oLanguage": {
								"sZeroRecords": "抱歉， 没有找到",
								"sInfoEmpty": "没有数据",
								"sInfoFiltered": "(从 _MAX_ 条数据中检索)",							
								"sZeroRecords": "没有检索到数据"
								},	
						data: data.data.carStockList,
				        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
				        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
				        columns: [	
				            { data: 'rownum' },
				            {data: "type"},
						    /* {data: "supplierName"}, */
						    {data: "brand"},
						    {data: "vin"},
						    {data: "model"},
						    {data: "color"},
						    {data: "engineNo"},
						    {data: "mark"},							   
						    /* {data: "status"} */],
						    columnDefs: [{
								 targets: 1,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
										 return '商品车';
									 }else if(data=='1'){
										 return '二手车';
									 }else{
										 return '';
									 }						
							       }	       
							}
						      ]
					});
				}
				if(data.data.carAttachmentStockList.length>0){
					for(var i=0;i<data.data.carAttachmentStockList.length;i++){
						data.data.carAttachmentStockList[i]["rownum"]=i+1;
					}
					$('#attachmentdetable_view').dataTable({
						 dom: 'Bfrtip',
						 destroy: true,
						 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
						 "bFilter": false,    //不使用过滤功能  
						 "bProcessing": true, //加载数据时显示正在加载信息	
						 "bPaginate" : false,
						 "bInfo" : false,
						  ordering: false,
							"oLanguage": {
								"sZeroRecords": "抱歉， 没有找到",
								"sInfoEmpty": "没有数据",
								"sInfoFiltered": "(从 _MAX_ 条数据中检索)",							
								"sZeroRecords": "没有检索到数据"
								},	
						data: data.data.carAttachmentStockList,
				        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
				        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
				        columns: [	
				            { data: 'rownum' },
				            {data: "attachmentName"},
						    {data: "position"},
						    {data: "count"},
						    {data: "mark"},							   
						   /*  {data: "status"} */]
					});
				}
				$('#viewBtn').show();
				$('#modal-detilinfo').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
} 
 //明细页面管理
 function doclose(){	
	 $('#modal-detilinfo').modal('hide'); 
 }
 function cleardetil(){
	    $("#waybillNo_view").html('');					
		$("#supplierId_view").html(''); 
		$("#amount_view").html(''); 
		$("#brand_view").html(''); 
		$("#carShopId_view").html('');
		$("#sendTime_view").html(''); 
		$("#receiveUser_view").html(''); 
		$("#receiveUserTelephone_view").html(''); 
		$("#receiveUserMobile_view").html(''); 
		$("#startAddress_view").html('');
		$("#targetAddress_view").html('');
		$("#distance_view").html('');
		$("#cardetable_view tbody tr").remove();  
		$("#attachmentdetable_view tbody tr").remove();  
 }
 
 function doproceclose(){
	 $('#modal-upload').modal('hide'); 
 }
 /*获取操作日志的详细信息*/
 function doviewtask(detailId){	 
	 $('#viewBtns').show();
	 $('#modal-upload').modal('show');
	 $.ajax({
			type : 'POST',
			url : "${ctx}/dailyOffice/waitingDo/getDetailInfoDetailId",
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			data : JSON.stringify({
				detailId : $.trim(detailId),
				type : 'WD'
			}),
			success : function(data) {
				if (data && data.code == 200) {
					console.log(JSON.stringify(data.data));	
					if(data.data.logList.length>0){
						for(var i=0;i<data.data.logList.length;i++){
							data.data.logList[i]["rownum"]=i+1;
						}
						$('#processtable').dataTable({
							 "destroy": true,//如果需要重新加载需销毁
							 dom: 'Bfrtip',
							 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
							 "bFilter": false,    //不使用过滤功能  
							 "bProcessing": true, //加载数据时显示正在加载信息	
							 "bPaginate" : false,
							 "bInfo" : false,
							  ordering: false,
								"oLanguage": {
									"sZeroRecords": "抱歉， 没有找到",
									"sInfoEmpty": "没有数据",
									"sInfoFiltered": "(从 _MAX_ 条数据中检索)",							
									"sZeroRecords": "没有检索到数据"
									},	
							data: data.data.logList,
					        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
					        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
					        columns: [	
					            { data: 'rownum' },
					            {data: "processDetailName"},
							    {data: "operateUserName"},
							    {data: "operateTime"},
							    {data: "mark"},
							    {data: "attachFileName"}],
							    columnDefs: [{
									 //入职时间
									 targets: 3,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonDateFormat(data);
										 }else{
											 return '';
										 }			
								       }	       
								},{
									 //入职时间
									 targets: 5,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 var attachFilePaths="${ctx}"+row.attachFilePath;
											 return '<a  href='+attachFilePaths+' target="_blank">'+data+'</a>';
										 }else{
											 return '';
										 }			
								       }	       
								}
							      ]
						});
				}}}
			});
 }
</script>



</body>
</html>






