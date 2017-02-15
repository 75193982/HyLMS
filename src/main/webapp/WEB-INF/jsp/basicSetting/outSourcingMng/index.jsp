
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/ztree/demo.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
  .selectItemcont {
	padding: 0px;
}

#selectItem {
	background: #FFF;
	position: absolute;
	top: 0px;
	left: center;
	border: 1px solid #F59942;
	overflow: hidden;
	width: 240px;
	z-index: 1000;
	overflow:auto; 
}

.selectItemhidden {
	display: none;
}
 #selectSub p{
 	cursor: pointer;
 	font-size: 13px;
 	
 }
 .overb{
 background: #F59942;
 }
 </style>
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			基础信息管理
			<small>
				<i class="icon-double-angle-right"></i>
				承运商管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">承运商：</label>
		   <input id="fom_name" class="form-box" type="text" style="width: 240px" placeholder="请填写承运商"/>		   	  
		  <!--  <label class="titletwo">是否需要提供发票：</label>
		     <select id="fom_needInvoice" class="form-box" style="width:190px;">
		      <option value="">请选择是否需要提供发票</option>
		      <option value="N">否</option>
              <option value="Y">是</option>
			</select> -->	
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="doadd()">新增</a>		
		</div>
		<!-- <div class="searchbox col-xs-12">		  
			<label class="title">开票方式：</label>
		     <select id="fom_invoiceOrder" class="form-box">
		      <option value="">请选择开票方式</option>
		      <option value="0">票前</option>
              <option value="1">票后</option>              
			</select>				  
			
		</div> -->
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>承运商</th>
					<th>地址</th>
                    <th>联系人</th>
                    <th>联系电话</th>
                    <th>手机号码</th>
                    <th>生日</th>
                    <th>合同开始日期</th> 
                    <th>合同结束日期</th> 
                   <!--  <th>是否需要提供发票</th> 
                    <th>开票方式</th>    -->   
                    <th>油费计算比例(%)</th>     
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">新增/编辑承运商信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>承运商：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							       <input class="form-control" id="name" type="text" placeholder="请输入承运商"/>
							     <input class="form-control" id="id-hidden" type="hidden"/>
							     </div>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>地址：</label>
							      <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="address" type="text" placeholder="请输入地址"/>
							     </div>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>联系人：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							    <input class="form-control" id="linkUser" type="text" placeholder="请输入联系人"/>
							    </div>
							 </div>
							 <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>联系电话：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="linkTelephone" type="text" placeholder="请输入联系电话"/>
							     </div>
							    </div>			
							  <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">手机号码：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="linkMobile" type="text" placeholder="请输入手机号码"/>
							     </div>
							    </div>	
							  <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4">生日：</label>
							     <div class="input-group input-group-sm col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
									<input class="form-control" id="brithday" type="text" placeholder="请输入联系人生日"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>							   					    
							  </div>	
							   	
							  <!--    <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>是否需要提供发票：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <select class="form-control" id="needInvoiceFlag">							      							      
							      <option value='N'>否</option>
							      <option value='Y'>是</option>
								</select>
								</div>
							  </div>
							   <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>开票方式：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <select class="form-control" id="invoiceOrder">							      
							      <option value='0'>票前</option>
							      <option value='1'>票后</option>
								</select>
								</div>
							  </div> -->
							    <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4">合同开始时间：</label>
							     <div class="input-group input-group-sm col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
									<input class="form-control" id="startTime" type="text" placeholder="请输入合同开始时间"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>							   					    
							  </div>
							   <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4">合同结束时间：</label>
							     <div class="input-group input-group-sm col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
									<input class="form-control" id="endTime" type="text" placeholder="请输入合同结束时间"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>							   					    
							  </div>	
							    <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">油费占运费比例(%)：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="transportOilCostRatio" type="text" placeholder="请输入油费占运费比例"/>
							     </div>
							    </div>						  			  				  
							    <hr class="tree"></hr>
							    <div class="add-item-btn" id="addBtn">
								    <a class="add-itemBtn btnOk" onclick="save();">保存</a>
								    <a class="add-itemBtn btnCancle" onclick="refresh();">取消</a>
								 </div>
								 <div class="add-item-btn" id="editBtn">
								    <a class="add-itemBtn btnOk" onclick="update()">更新</a>
								    <a class="add-itemBtn btnCancle" onclick="refresh()">取消</a>
								  </div> 
								  <!-- <div class="add-item-btn" id="viewBtn">								   
								    <a class="add-itemBtn btnCancle" onclick="refresh()">关闭</a>
								  </div> -->
								</div>
						  </div>
					</div>
				</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="selectItem" class="selectItemhidden">
		<div id="selectItemCount" class="selectItemcont">
			<div id="selectSub">
				
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
jQuery.fn.selectSupplier = function(targetId) {
	var _seft = this;
	var targetId = $(targetId);
	this.keyup(function() {
		var value = _seft.val();
		
		$.ajax({
			type : 'POST',
			url : "${ctx}/basicSetting/outSourcingMng/getOutSourcingList",
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			data: JSON.stringify({
				name : value
			}),
			success : function(data) {
				if (data && data.code == 200) {
					var html = "";
					if(data.data!=null && data.data!=''){
		        		if(data.data.length>0){
		        			for(var i=0;i<data.data.length;i++){
		            			html +='<p sid='+data.data[i]['id']+' onclick=\'clickp(this)\' onmouseover=\'mv(this)\' onmouseout=\'mo(this)\'>'+data.data[i]['name']+'</p>';
		            		}
		        		}
		        	}
		        	$('#selectSub').html(html);
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		});
		
		var A_top = $(this).offset().top + $(this).outerHeight(true); //  1
		var A_left = $(this).offset().left;
		//targetId.bgiframe();
		targetId.show().css({
			"position" : "absolute",
			"top" : A_top + "px",
			"left" : A_left + "px"
		});
		
		 if(value == '')
		{
			//$('#fom_supplier_id').val('');
			targetId.hide();
			//$('#brandNameSearch').html('<option value="">请选择品牌</option>');
			//$('#stockSearch').html('<option value="">请选择库区</option>');
		} 
	});
	

	$(document).click(function(event) {
		if (event.target.id != _seft.selector.substring(1)) {
			targetId.hide();
		}
	});

	targetId.click(function(e) {
		e.stopPropagation(); //  2
	});
	return this;
	
}
function clickp(e){
	$('#fom_name').val($(e).html());
	$('#selectItem').hide();
	
};

function mv(e){
	$(e).addClass("overb");
}

function mo(e){
	$(e).removeClass("overb");
}

function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/basicSetting/outSourcingMng/getListData" , //获取数据的ajax方法的URL							 
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
				columns: [{ data: "rownum" ,"width": "4%"},
						    {data: "name","width": "13%"},
						    {data: "address","width": "15%"},
						    {data: "linkUser","width": "8%"},
						    {data: "linkTelephone","width": "8%"},
						    {data: "linkMobile","width": "8%"},
						    {data: "brithday","width": "8%"},
						    {data: "startTime","width": "8%"},
						    {data: "endTime","width": "8%"},	
						   /*  {data: "needInvoiceFlag","width": "7%"},	
						    {data: "invoiceOrder","width": "8%"}, */
						    {data: "transportOilCostRatio","width": "5%"},	
						    {data: null,"width": "23%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 6,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonForDateFormat(data);
									 }else{
										 return '';
									 }
									
							       }	       
							}/* ,{
								 //入职时间
								 targets: 9,
								 render: function (data, type, row, meta) {
									 if(data=='N'){
										 return '否';
									 }else{
										 return '是';
									 }
									
							       }	       
							} */,{
									 //入职时间
									 targets: 7,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonForDateFormat(data);
										 }else{
											 return '';
										 }
										
								       }	       
								},{
									 //入职时间
									 targets: 8,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonForDateFormat(data);
										 }else{
											 return '';
										 }
										
								       }	       
								},
								/* {
									 //入职时间
									 targets: 10,
									 render: function (data, type, row, meta) {
										 if(data=='0'){
											 return '票前';
										 }else{
											 return '票后';
										 }
										
								       }	       
								}, */
						      	{
							    	 //操作栏
							    	 targets: 10,
							    	 render: function (data, type, row, meta) {			    		
							    			   return '<a class="table-bigbtn" style="width:80px;" onclick="dobrand('+ row.id +')">供应商管理</a>'
							    			   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
									           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';			    				                 
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
		 "sAjaxSource": "${ctx}/basicSetting/outSourcingMng/getListData", //获取数据的ajax方法的URL	
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
				 columns: [{ data: "rownum" ,"width": "4%"},
						    {data: "name","width": "13%"},
						    {data: "address","width": "15%"},
						    {data: "linkUser","width": "8%"},
						    {data: "linkTelephone","width": "8%"},
						    {data: "linkMobile","width": "8%"},
						    {data: "brithday","width": "8%"},
						    {data: "startTime","width": "8%"},
						    {data: "endTime","width": "8%"},	
						   /*  {data: "needInvoiceFlag","width": "7%"},	
						    {data: "invoiceOrder","width": "8%"}, */
						    {data: "transportOilCostRatio","width": "5%"},	
						    {data: null,"width": "23%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 6,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonForDateFormat(data);
									 }else{
										 return '';
									 }
									
							       }	       
							}/* ,{
								 //入职时间
								 targets: 9,
								 render: function (data, type, row, meta) {
									 if(data=='N'){
										 return '否';
									 }else{
										 return '是';
									 }
									
							       }	       
							} */,{
									 //入职时间
									 targets: 7,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonForDateFormat(data);
										 }else{
											 return '';
										 }
										
								       }	       
								},{
									 //入职时间
									 targets: 8,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonForDateFormat(data);
										 }else{
											 return '';
										 }
										
								       }	       
								},
								/* {
									 //入职时间
									 targets: 10,
									 render: function (data, type, row, meta) {
										 if(data=='0'){
											 return '票前';
										 }else{
											 return '票后';
										 }
										
								       }	       
								}, */
						      	{
							    	 //操作栏
							    	 targets: 10,
							    	 render: function (data, type, row, meta) {			    		
							    			   return '<a class="table-bigbtn" style="width:80px;" onclick="dobrand('+ row.id +')">供应商管理</a>' 
							    			   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
									           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';			    				                 
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	//getstock();
	//getCarShop();
	$("#fom_name").selectSupplier("#selectItem");
})
/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var name=$("#fom_name").val(); 
	   //var needInvoice=$("#fom_needInvoice").find("option:selected").val(); 
	  // var invoiceOrder=$("#fom_invoiceOrder").find("option:selected").val(); 	  
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				name :$.trim(name) ,
				needInvoiceFlag : '',
				invoiceOrder:''			
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

	
/* 删除承运商信息*/
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该承运商信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/basicSetting/outSourcingMng/delete/"+id,
						contentType : "application/json;charset=UTF-8",
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
	})
};

/*新增信息输入  */
function doadd(){
	clear();
	$('#addBtn').show();
	$('#editBtn').hide();
	$('#myModalLabel').html('新增承运商信息');	
	$('#modal-info').modal('show');
	$("#brithday").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
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
}
/* 关闭窗体 */
function refresh(){
	clear();
	$('#modal-info').modal('hide');
	
}
/* 数据重置 */
function clear(){
	$('#id-hidden').val('');	
	$('#name').val('');
	$('#address').val('');
	$('#linkUser').val('');	
	$('#brithday').val('');	
	$('#linkTelephone').val('');	
	$('#linkMobile').val('');
	//$('#needInvoiceFlag').val('N');
	//$('#invoiceOrder').val('0');
	$('#startTime').val('');
	$('#endTime').val('');
	$('#transportOilCostRatio').val('');
}
/* 保存新增承运商信息 */
function save(){
	var flag="false";
	var name=$("#name").val(); 
	var address=$("#address").val(); 
	var linkUser=$("#linkUser").val(); 
	var linkTelephone=$("#linkTelephone").val(); 
	var linkMobile=$("#linkMobile").val(); 
	var needInvoiceFlag=$("#needInvoiceFlag").find("option:selected").val(); 
	var invoiceOrder=$("#invoiceOrder").find("option:selected").val(); 
	var brithday=$("#brithday").val(); 
	var startTime=$("#startTime").val(); 
	var endTime=$("#endTime").val(); 
	var transportOilCostRatio=$("#transportOilCostRatio").val(); 
	if(name==''){
		bootbox.alert('承运商不能为空！');
		return;
	}
	if(address==''){
		bootbox.alert('地址不能为空！');
		return;
	}
	if(linkUser==''){
		bootbox.alert('联系人不能为空！');
		return;
	}	
	if(linkTelephone==''){
		bootbox.alert('联系电话不能为空！');
		return;
	}
	/* if(linkMobile==''){
		bootbox.alert('手机号码不能为空！');
		return;
	} */
	/* if(needInvoiceFlag==''){
		bootbox.alert('是否需要提供发票不能为空！');
		return;
	}
	if(invoiceOrder==''){
		bootbox.alert('开票方式不能为空！');
		return;
	} */
/* 	if(brithday==''){
		bootbox.alert('生日不能为空！');
		return;
	}
	if(startTime==''){
		bootbox.alert('合同签订开始时间不能为空！');
		return;
	}if(endTime==''){
		bootbox.alert('合同签订结束时间不能为空！');
		return;
	} */
	if(transportOilCostRatio!=''&&isNaN(transportOilCostRatio)){
		bootbox.alert('油费占运费比例请填写数字！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增承运商信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/outSourcingMng/save',
						data : JSON.stringify({
							name : name,				
							address : address,
							brithday : brithday,
							linkUser : linkUser,
							linkTelephone : linkTelephone,
							linkMobile : linkMobile,
							needInvoiceFlag : '',
							invoiceOrder : '',
							transportOilCostRatio : transportOilCostRatio,
							startTime : startTime,
							endTime : endTime
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "保存成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											 refresh();
								             reload();
										  }else{
											refresh();
								            reload(); 
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										location.reload();
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
		})
}
//打开编辑页面
function doedit(id){	
	clear();
	$("#brithday").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
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
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/outSourcingMng/getDetailData/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑承运商信息');
				$("#name").val(data.data.name);
				$("#address").val(data.data.address); 
				$("#linkUser").val(data.data.linkUser); 
				$("#linkTelephone").val(data.data.linkTelephone); 
				$("#linkMobile").val(data.data.linkMobile); 		
				//$("#needInvoiceFlag").val(data.data.needInvoiceFlag);
				//$("#invoiceOrder").val(data.data.invoiceOrder);
				if(data.data.brithday!=''&&data.data.brithday!=null){
					$("#brithday").val(jsonForDateFormat(data.data.brithday));
				}else{
					$("#brithday").val('');
				}
				if(data.data.startTime!=''&&data.data.startTime!=null){
					$("#startTime").val(jsonForDateFormat(data.data.startTime));
				}else{
					$("#startTime").val('');
				}
				if(data.data.endTime!=''&&data.data.endTime!=null){
					$("#endTime").val(jsonForDateFormat(data.data.endTime));
				}else{
					$("#endTime").val('');
				}
				$("#transportOilCostRatio").val(data.data.transportOilCostRatio);
				$('#addBtn').hide();
				$('#editBtn').show();
				$('#viewBtn').hide();
				$('#modal-info').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
/* 更新 */
function update(){
	var flag="false";
	var id=$('#id-hidden').val();
	var name=$("#name").val(); 
	var address=$("#address").val(); 
	var linkUser=$("#linkUser").val(); 
	var linkTelephone=$("#linkTelephone").val(); 
	var linkMobile=$("#linkMobile").val(); 
	//var needInvoiceFlag=$("#needInvoiceFlag").find("option:selected").val(); 
	//var invoiceOrder=$("#invoiceOrder").find("option:selected").val(); 
	var brithday=$("#brithday").val(); 
	var startTime=$("#startTime").val(); 
	var endTime=$("#endTime").val();
	var transportOilCostRatio=$("#transportOilCostRatio").val(); 
	if(name==''){
		bootbox.alert('承运商不能为空！');
		return;
	}
	if(address==''){
		bootbox.alert('地址不能为空！');
		return;
	}
	if(linkUser==''){
		bootbox.alert('联系人不能为空！');
		return;
	}	
	if(linkTelephone==''){
		bootbox.alert('联系电话不能为空！');
		return;
	}
	/* if(linkMobile==''){
		bootbox.alert('手机号码不能为空！');
		return;
	} */
	/* if(needInvoiceFlag==''){
		bootbox.alert('是否需要提供发票不能为空！');
		return;
	}
	if(invoiceOrder==''){
		bootbox.alert('开票方式不能为空！');
		return;
	} */
	/* if(brithday==''){
		bootbox.alert('生日不能为空！');
		return;
	}
	if(startTime==''){
		bootbox.alert('合同签订开始时间不能为空！');
		return;
	}if(endTime==''){
		bootbox.alert('合同签订结束时间不能为空！');
		return;
	} */
	if(transportOilCostRatio!=''&&isNaN(transportOilCostRatio)){
		bootbox.alert('油费占运费比例请填写数字！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该承运商信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/outSourcingMng/update',
						data : JSON.stringify({
							id : id,
							name : name,				
							address : address,
							brithday : brithday,
							linkUser : linkUser,
							linkTelephone : linkTelephone,
							linkMobile : linkMobile,
							needInvoiceFlag : '',
							invoiceOrder : '',
							transportOilCostRatio : transportOilCostRatio,
							startTime : startTime,
							endTime : endTime
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "保存成功！", 
									  callback: function(result){
										  if(result){
											 flag="true";
											 refresh();
								             reload();
										  }else{
											refresh();
								            reload(); 
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										location.reload();
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
		})
}
/* function doview(id){
	clear();
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/outSourcingMng/getDetailData/"+id,
		data :JSON.stringify({
			id :id
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('储位信息');
				$("#stockId").val(data.data.stockId);				
				$("#carShopId").val(data.data.carShopId); 
				$("#province").val(data.data.province); 
				$("#position").val(data.data.position); 
				$("#stockId").attr("disabled",true);
				$("#carShopId").attr("disabled",true);
				$("#province").attr("disabled",true);
				$("#position").attr("disabled",true);
				$('#addBtn').hide();
				$('#editBtn').hide();
				$('#viewBtn').show();
				$('#modal-info').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
} */

/*供应商设置*/
function dobrand(id){
	location.href="${ctx}/basicSetting/outSourcingBusiness/index/"+id;
}


</script>



</body>
</html>






