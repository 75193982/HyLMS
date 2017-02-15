
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
				轮胎库存查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
			 <label class="title" style="float: left;height: 34px;line-height: 34px;">入库时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 150px;margin-right:15px; height:35px;line-height:35px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入入库开始时间" style="height:35px;line-height:35px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 150px;margin-right:15px;margin-left: 15px;height:35px;line-height:35px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入入库结束时间" style="height:35px;line-height:35px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			<label class="title" >入库单号：</label>
		   <input id="fom_billNo" class="form-box"  type="text" placeholder="请填写入库单号" style="width: 150px;"/>
		   <label class="title" >装运车号：</label>
		  <!--  <select id="fom_carNumber" class="form-box" ></select> -->
		   <input id="fom_carNumber" class="form-box" style="width: 150px;" type="text" placeholder="请填写装运车号(模糊查询)" onkeyup="searchSchedule(this)"/>
		</div>
		<div class="searchbox col-xs-12">
			<label class="title" style="float: left;">类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：</label>
			<select id="fom_type" class="form-box" style="width: 150px;float: left;">
		   		<option value="">请选择状态</option>
		   		<option value="0">轮胎</option>
		   		<option value="1">钢圈</option>
		   	</select>
		   <label class="title" style="float: left;">轮胎编号：</label>
		   <input id="fom_tyreNo" class="form-box" type="text" placeholder="请填写轮胎编号" style="width: 150px;float: left;"/>
		    <label class="title" >状态：</label>
		   	<select id="fom_status" class="form-box" style="width: 150px;">
		   		<option value="">请选择状态</option>
		   		<option value="1">已入库</option>
		   		<option value="2">使用中</option>
		   		<option value="3">已出库</option>
		   		<option value="4">已作废</option>
		   	</select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<!-- <a class="itemBtn" onclick="doadd()">新增</a> -->
		</div>
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>类型</th>
					<th>入库单号</th>
					<th>轮胎编号</th>
					<th>品牌</th>
                    <th>尺寸</th>
                    <th>价格</th>         
                    <th>备注</th>
                    <th>状态</th>
                    <th>入库时间</th>
                    <th>创建人</th>                   
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">轮胎入库登记</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								<div class="add-item">
							     <label class="title">类型：</label>
							    <input class="form-control" id="type" type="text" />
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title">入库单号：</label>
							    <input class="form-control" id="billNo" type="text" placeholder="请输入入库单号 "/>
							  </div>							  
							 <hr class="tree"></hr>
							  <div class="add-item">
							     <label class="title"><span class="red">*</span>轮胎编号 ：</label>
							     <input class="form-control" id="tyreNo" type="text" placeholder="请输入轮胎编号 "/>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item">
							     <label class="title">品牌 ：</label>
							     <input class="form-control" id="brand" type="text" placeholder="请输入品牌"/>
							  </div>
							   <hr class="tree"></hr>
							  <div class="add-item">
							     <label class="title">尺寸 ：</label>
							     <input class="form-control" id="size" type="text" placeholder="请输入尺寸"/>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item">
							     <label class="title">价格 ：</label>
							     <input class="form-control" id="price" type="text" placeholder="请输入价格"/>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item">
							     <label class="title">备注 ：</label>
							    <textarea class="form-control" rows="3" id="mark" name="mark" placeholder="" ></textarea> 							    
							  </div>
							  						  
							    <hr class="tree"></hr>
							    <div class="add-item-btn" id="addBtn">
								    <a class="add-itemBtn btnOk" onclick="save();" style="margin-left: 130px;">保存</a>
								    <a class="add-itemBtn btnOk" onclick="refresh();">关闭</a>
								 </div>
								 <div class="add-item-btn" id="editBtn">
								    <a class="add-itemBtn btnOk" onclick="update()" style="margin-left: 130px;">更新</a>
								    <a class="add-itemBtn btnOk" onclick="refresh()">关闭</a>
								  </div> 
								   <div class="add-item-btn" id="viewBtn">
								   <!--  <a class="add-itemBtn btnOk" onclick="update()" style="margin-left: 130px;">更新</a> -->
								    <a class="add-itemBtn btnOk" onclick="refresh()" style="margin-left: 130px;">关闭</a>
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

<div id="selectItem8" class="selectItemhidden" style="height: 150px;">
	<div id="selectItemCount" class="selectItemcont">
		<div id="selectCarNo" style="height: 150px;">
											
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

function searchSchedule(e){
	var $val=$(e).val();
	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/trackTyreMng/getStockList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		data: JSON.stringify({
			no : $val
		}),
		success : function(data) {
			if (data && data.code == 200) {
				var html = "";
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<p id='+data.data[i]['id']+' onclick=\'clickp(this)\'>'+data.data[i]['no']+'</p>';
	            		}
	        		}
	        	}
	        	$('#selectCarNo').html(html);
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
	var A_top = $(e).offset().top + $(e).outerHeight(true); //  1
	var A_left = $(e).offset().left;
	$('#selectItem8').show().css({
		"position" : "absolute",
		"top" : A_top + "px",
		"left" : A_left + "px"
	});
	
}
function clickp(e){
	$('#fom_carNumber').val($(e).html());
	$('#selectItem8').hide();
};
$(document).click(function(event) {
   $('#selectItem8').hide();
});


function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/trackTyreMng/getListData" , //获取数据的ajax方法的URL							 
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
				columns: [{data: "rownum" ,"width":"5%"},
				            {data: "type" ,"width":"5%"},
				            {data: "billNo" ,"width":"10%"},
						    {data: "tyreNo","width":"10%"},
						    {data: "brand","width":"10%"}, 
						    {data: "size","width":"10%"},
						    {data: "price","width":"10%"},
						    {data: "mark","width":"5%"},
						    {data: "status","width":"5%"},
						    {data: "insertTime","width":"10%"},
						    {data: "insertUser","width":"5%"},		    
						    {data: null,"width":"15%"}],
		    columnDefs: [
		                 {
				 targets: 1,
				 render: function (data, type, row, meta) {
					if(data=='0'){
						return '轮胎';
					}else if(data=='1'){
						return '钢圈';
					}else{
						return '';
					}
			       }	       
			},
			{
				 //入职时间
				 targets: 8,
				 render: function (data, type, row, meta) {
					if(data=='0'){
						return '新建';
					}else if(data=='1'){
						return '已入库';
					}else if(data=='2'){
						return '使用中';
					}else if(data=='3'){
						return '已出库';
					}else if(data=='4'){
						return '已作废';
					}
			       }	       
			},{
					 //入职时间
					 targets: 9,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
						
				       }	       
				},
		      	{
			    	 //操作栏
			    	 targets: 11,
			    	 render: function (data, type, row, meta) {
			    		 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'
				           /* +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>' */; 
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
		 "sAjaxSource": "${ctx}/operationMng/trackTyreMng/getListData", //获取数据的ajax方法的URL	
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
				columns: [{data: "rownum" ,"width":"5%"},
				            {data: "type" ,"width":"5%"},
				            {data: "billNo" ,"width":"10%"},
						    {data: "tyreNo","width":"10%"},
						    {data: "brand","width":"10%"}, 
						    {data: "size","width":"10%"},
						    {data: "price","width":"10%"},
						    {data: "mark","width":"5%"},
						    {data: "status","width":"5%"},
						    {data: "insertTime","width":"10%"},
						    {data: "insertUser","width":"5%"},		    
						    {data: null,"width":"15%"}],
						    columnDefs: [
								{
									 targets: 1,
									 render: function (data, type, row, meta) {
										if(data=='0'){
											return '轮胎';
										}else if(data=='1'){
											return '钢圈';
										}else{
											return '';
										}
								      }	       
								},
						        {
								 //入职时间
								 targets: 8,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
											return '新建';
										}else if(data=='1'){
											return '已入库';
										}else if(data=='2'){
											return '使用中';
										}else if(data=='3'){
											return '已出库';
										}
										else if(data=='4'){
											return '已作废';
										}
							       }	       
							},{
									 //入职时间
									 targets: 9,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonDateFormat(data);
										 }else{
											 return '';
										 }
								       }	       
								},
						      	{
							    	 //操作栏
							    	 targets: 11,
							    	 render: function (data, type, row, meta) {
							    		 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'
								           /* +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>' */; 
						                   
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
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
	init();
	//BindCarNo();//绑定货运车carNumber
})
function BindCarNo(){
	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/trackTyreMng/getStockList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var html ='<option value="">请选择货运车</option>';
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<option value='+data.data[i]['no']+'>'+data.data[i]['no']+'</option>';
	            		}
	        		}
	        	}
	        	//$('#fom_supplier').html(html);
	        	$('#fom_carNumber').html(html);
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
}

/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var startTime = $("#startTime").val();
	   var endTime = $("#endTime").val();
	   var billNo = $("#fom_billNo").val();
	   var carNumber=$("#fom_carNumber").val(); 
	   var type = $("#fom_type").val();
	   var tyreNo=$("#fom_tyreNo").val(); 
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
				startTime : startTime,
				endTime : endTime,
				billNo : billNo,
				carNumber :$.trim(carNumber),
				type : type,
				tyreNo :$.trim(tyreNo),
				status :$.trim(status)
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

	
/* 删除轮胎库存信息 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该轮胎信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/trackTyreMng/delete/"+id,
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
	$('#myModalLabel').html('轮胎入库登记');	
	$('#modal-info').modal('show');
	bindbillNo();//绑定单号
}
//绑定单号
function bindbillNo(){
	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/trackTyreMng/queryBillNo",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var html ='<option value="">请选择单据号</option>';
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['billNo']+'</option>';
	            		}
	        		}
	        	}
	        	$('#billId').html(html);
	        	
			} else {
				bootbox.alert(data.msg);
			}
		}
		
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
	$('#billId').val('');
	$('#tyreNo').val('');	
	$('#mark').val('');
	$('#spec').val('');
}
/* 保存新增轮胎库存信息 */
function save(){
	var flag="false";
	var billId=$('#billId').val();
	var tyreNo=$('#tyreNo').val();	
	var mark=$('#mark').val();
	var spec=$('#spec').val();
	if(tyreNo==''|| tyreNo==null){
		bootbox.alert('轮胎编号不能为空！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该轮胎入库信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackTyreMng/save',
						data : JSON.stringify({
							billId : billId,				
							tyreNo : tyreNo,
							spec   : spec,
							mark : mark
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
											  location.reload();
										  }else{
											 location.reload();  
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
function doedit(id){	
	clear();
	bindbillNo();
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackTyreMng/getDetail/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑轮胎信息');
				 $('#billId').val(data.data.billId); 
				$('#tyreNo').val(data.data.tyreNo);
				$('#spec').val(data.data.spec);
				$('#mark').val(data.data.mark);				
				$('#addBtn').hide();
				$('#editBtn').show();
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
	var billId=$('#billId').val();
	var tyreNo=$('#tyreNo').val();	
	var spec=$('#spec').val();
	var mark=$('#mark').val();
	if(tyreNo==''|| tyreNo==null){
		bootbox.alert('轮胎编号不能为空！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该轮胎信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackTyreMng/update',
						data : JSON.stringify({
							id : id,
							billId : billId,				
							tyreNo : tyreNo,
							spec : spec,
							mark : mark
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
											  location.reload();
										  }else{
											 location.reload();  
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
function doview(id){
	clear();
	bindbillNo();//绑定单号
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackTyreMng/getDetail/"+id,
		data :JSON.stringify({
			id :id
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				console.info(JSON.stringify(data.data));
				$('#id-hidden').val(id);
				$('#myModalLabel').html('查看轮胎信息');
				if("0" == data.data.type)
				{
					$('#type').val('轮胎');
				}
				else if("1" == data.data.type)
				{
					$('#type').val('钢圈');
				}
				else
				{
					$('#type').val('');
				}
				$('#billNo').val(data.data.billNo);
				$('#tyreNo').val(data.data.tyreNo);
				$('#brand').val(data.data.brand);
				$('#price').val(data.data.price);
				$('#size').val(data.data.size);
				$('#mark').val(data.data.mark);	
				$('#type').attr("disabled",true);
				$("#billNo").attr("disabled",true);
				$("#tyreNo").attr("disabled",true);
				$("#brand").attr("disabled",true);
				$("#price").attr("disabled",true);
				$("#size").attr("disabled",true);
				$("#mark").attr("disabled",true);
				$('#addBtn').hide();
				$('#editBtn').hide();
				$('#viewBtn').show();
				$('#modal-info').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
</script>



</body>
</html>






