
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
			运营管理
			<small>
				<i class="icon-double-angle-right"></i>
				维修保养管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">	
			<label class="title" style="float: left;height: 34px;line-height: 34px;">开始时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 234px;margin-right:22px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="form_startTime" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width:78px;">结束时间：</label>
		   <div class="input-group input-group-sm" style="float: left;width: 234px;margin-right:20px;height: 34px;line-height: 34px;">
				<input class="form-control" id="form_endTime" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>			
		   <label class="title">状态：</label>
		   <select id="fom_status" class="form-box" style="width:200px;">
		   <option value="">请选择状态</option>
		   <option value="0">新建</option>
		   <option value="1">待复核</option>
		   <option value="2">已完成</option>		  
		   	</select>		
		  	</div>
		</div>
		<div class="searchbox col-xs-12">
		    <label class="title" style="margin-left: 18px;">装运车号：</label>
		    <input id="fom_carNumber" class="form-box" type="text" placeholder="请输入装运车号" style="width:234px;"/>
		    <label class="title" style="width:78px;text-align:right;">保养内容：</label>		    
		   <input id="fom_detailInfo" class="form-box" type="text" placeholder="请输入保养内容(关键字)" style="width:234px;"/>
		   
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="doadd()">新增</a>
		</div>
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>装运车号</th>
					<!-- <th>收款方</th> -->
                    <th>目前公里数</th>
                    <th>保养详情</th>                    
                    <th>保养费用</th>
                    <th>备注</th>
                    <th>状态</th>
                    <th>创建时间</th>
                    <th>更新时间</th>                   
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">维修保养新增</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>装运车号：</label>
							     <div class="col-xs-9" style="margin-bottom: 10px;">
							     <select id="carNumber" class="form-control" >	</select>
							     <input class="form-control" id="id-hidden" type="hidden"/>
							     </div>							    
							  </div>							  
							 <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>目前公里数 ：</label>
							      <div class="col-xs-9" style="margin-bottom: 10px;">
							     <input class="form-control" id="currentMileage" type="text" placeholder="请输入目前公里数 "/>
							     <!-- <input class="form-control" id="brand" type="text" placeholder="请输入品牌  "/> -->
							     </div>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>保养费用：</label>
							     <div class="col-xs-9" style="margin-bottom: 10px;">
							     <input class="form-control" id="amount" type="text" placeholder="请输入保养费用"/>
							     <!-- <input class="form-control" id="brand" type="text" placeholder="请输入品牌  "/> -->
							      </div>
							  </div>
							   <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>保养详情 ：</label>
							     <div class="col-xs-9" style="margin-bottom: 10px;">
							     <textarea class="form-control" rows="3" id="detailInfo" name="detailInfo" placeholder="请填写保养详情   " ></textarea> 
							      </div>									    
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red"></span>备注 ：</label>
							     <div class="col-xs-9" style="margin-bottom: 10px;">
							    <textarea class="form-control" rows="3" id="mark" name="mark" placeholder="请填写备注  " ></textarea> 	
							    </div>						    
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
		 "sAjaxSource": "${ctx}/operationMng/trackMaintMng/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum" },
		    {data: "carNumber"},
		   /*  {data: "receivingName"}, */
		    {data: "currentMileage"},
		    {data: "detailInfo"},
		    {data: "amount"},
		    {data: "mark"},
		    {data: "status"},
		    {data: "insertTime"},
		    {data: "updateTime"},		    
		    {data: null}],
		    columnDefs: [{
				 //入职时间
				 targets: 6,
				 render: function (data, type, row, meta) {
					if(data=='0'){
						return '新建';
					}else if(data=='1'){
						return '待复核';
					}else if(data=='2'){
						return '已完成';
					}else{
						return '';
					}
			       }	       
			},{
					 //入职时间
					 targets: 7,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
						
				       }	       
				},{
					 //入职时间
					 targets: 8,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
						
				       }	       
				},{
			    	 //操作栏
			    	 targets: 9,
			    	 render: function (data, type, row, meta) {
			    		 if(row.status=='0'){
			    			 return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
			    			   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
					           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
			    		 }else{
			    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'
					           /* +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>' */; 
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
		 "sAjaxSource": "${ctx}/operationMng/trackMaintMng/getListData", //获取数据的ajax方法的URL	
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
				columns: [{ data: "rownum" ,"width":"4%"},
						    {data: "carNumber","width":"8%"},
						   /*  {data: "receivingName","width":"10%"}, */
						    {data: "currentMileage","width":"10%"},
						    {data: "detailInfo","width":"16%"},
						    {data: "amount","width":"8%"},
						    {data: "mark","width":"10%"},
						    {data: "status","width":"8%"},
						    {data: "insertTime","width":"10%"},
						    {data: "updateTime","width":"10%"},		    
						    {data: null,"width":"15%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 6,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
											return '新建';
										}else if(data=='1'){
											return '待复核';
										}else if(data=='2'){
											return '已完成';
										}else{
											return '';
										}
							       }	       
							},{
									 //入职时间
									 targets: 7,
									 render: function (data, type, row, meta) {
										 return jsonDateFormat(data);
								       }	       
								},{
									 //入职时间
									 targets: 8,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonDateFormat(data);
										 }else{
											 return '';
										 }
										
								       }	       
								},{
							    	 //操作栏
							    	 targets: 9,
							    	 render: function (data, type, row, meta) {
							    		 if(row.status=='0'){
							    			 return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
							    			   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
									           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
							    		 }else{
							    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'
									           /* +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>' */; 
							    		 }
						                   
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	//BindCarNo();//绑定货运车carNumber
	//BindOutSour();//绑定供应商
	$("#form_startTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#form_endTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
})
function BindCarNo(){
	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/trackTyreMng/getStockList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		data: JSON.stringify({
		}),
		success : function(data) {
			if (data && data.code == 200) {
				var html ='<option value="">请选择装运车号</option>';
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
	   var carNumber=$("#fom_carNumber").val(); 
	   var status=$("#fom_status").val(); 
	   var detailInfo=$("#fom_detailInfo").val(); 
	   var startTime=$("#form_startTime").val();
	   var endTime=$("#form_endTime").val(); 
	  // var carType=$("#carType").val(); 
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				startTime :$.trim(startTime),
				endTime :$.trim(endTime),
				detailInfo :$.trim(detailInfo),
				carNumber :$.trim(carNumber),
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
		  message: "确定要删除该维修保养信息?", 
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
	$('#viewBtn').hide();
	$('#myModalLabel').html('新增维修保养信息');	
	$('#modal-info').modal('show');
	$("#carNumber").attr("disabled",false);
	$("#currentMileage").attr("disabled",false);
	$("#amount").attr("disabled",false);
	$("#detailInfo").attr("disabled",false);
	$("#mark").attr("disabled",false);
	bindcarNumber();//绑定货运车
}
//绑定单号
function bindcarNumber(){
	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/trackMaintMng/getStockList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var html ='<option value="">请选择装运车号</option>';
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<option value='+data.data[i]['no']+'>'+data.data[i]['no']+'</option>';
	            		}
	        		}
	        	}
	        	$('#carNumber').html(html);
	        	
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
	$('#carNumber').val('');
	$('#currentMileage').val('');
	$('#detailInfo').val('');
	$('#mark').val('');
	$('#amount').val('');
}
/* 保存新增轮胎库存信息 */
function save(){
	var flag="false";
	var carNumber=$('#carNumber').val();
	var currentMileage=$('#currentMileage').val();	
	var mark=$('#mark').val();
	var detailInfo=$('#detailInfo').val();
	var amount=$('#amount').val();
	if(carNumber==''|| carNumber==null){
		bootbox.alert('装运车号不能为空！');
		return;
	}if(currentMileage==''|| currentMileage==null){
		bootbox.alert('目前公里数不能为空！');
		return;
	}if(detailInfo==''|| detailInfo==null){
		bootbox.alert('保养详情不能为空！');
		return;
	}if(amount==''|| amount==null){
		bootbox.alert('保养费用不能为空！');
		return;
	}if(currentMileage!=''&&isNaN(currentMileage)){
		bootbox.alert('目前公里数请填写数字！');
		return;
	}if(amount!=''&&isNaN(amount)){
		bootbox.alert('保养费用请填写数字！');
		return;
	}	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存维修保养信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackMaintMng/save',
						data : JSON.stringify({
							carNumber : carNumber,				
							currentMileage : currentMileage,
							detailInfo   : detailInfo,
							amount   : amount,
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
	bindcarNumber();//绑定货运车
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackMaintMng/getDetail/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑维修保养信息');
				$('#carNumber').val(data.data.carNumber);
				$('#currentMileage').val(data.data.currentMileage);
				$('#amount').val(data.data.amount);
				$('#detailInfo').val(data.data.detailInfo);				
				$('#mark').val(data.data.mark);	
				$("#carNumber").attr("disabled",false);
				$("#currentMileage").attr("disabled",false);
				$("#amount").attr("disabled",false);
				$("#detailInfo").attr("disabled",false);
				$("#mark").attr("disabled",false);
				$('#addBtn').hide();
				$('#viewBtn').hide();
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
	var carNumber=$('#carNumber').val();
	var currentMileage=$('#currentMileage').val();	
	var mark=$('#mark').val();
	var detailInfo=$('#detailInfo').val();
	var amount=$('#amount').val();
	if(carNumber==''|| carNumber==null){
		bootbox.alert('装运车号不能为空！');
		return;
	}if(currentMileage==''|| currentMileage==null){
		bootbox.alert('目前公里数不能为空！');
		return;
	}if(detailInfo==''|| detailInfo==null){
		bootbox.alert('保养详情不能为空！');
		return;
	}if(amount==''|| amount==null){
		bootbox.alert('保养费用不能为空！');
		return;
	}if(currentMileage!=''&&isNaN(currentMileage)){
		bootbox.alert('目前公里数请填写数字！');
		return;
	}if(amount!=''&&isNaN(amount)){
		bootbox.alert('保养费用请填写数字！');
		return;
	}	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该维修保养信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackMaintMng/update',
						data : JSON.stringify({
							id : id,
							carNumber : carNumber,				
							currentMileage : currentMileage,
							detailInfo   : detailInfo,
							amount   : amount,
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
/**提交**/
function dosubmit(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该维修保养信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'GET',
						url : '${ctx}/operationMng/trackMaintMng/submit/'+id,
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "提交成功！", 
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
}
function doview(id){
	clear();
	bindcarNumber();//绑定货运车
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackMaintMng/getDetail/"+id,
		data :JSON.stringify({
			id :id
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('查看维修保养信息');
				$('#carNumber').val(data.data.carNumber);
				$('#currentMileage').val(data.data.currentMileage);
				$('#amount').val(data.data.amount);
				$('#detailInfo').val(data.data.detailInfo);				
				$('#mark').val(data.data.mark);								
				$("#carNumber").attr("disabled",true);
				$("#currentMileage").attr("disabled",true);
				$("#amount").attr("disabled",true);
				$("#detailInfo").attr("disabled",true);
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






