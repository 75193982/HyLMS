
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
			运输车辆维护
			<small>
				<i class="icon-double-angle-right"></i>
				轮胎采购申请
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
	    <div class="searchbox col-xs-12">
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">申请时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 234px;margin-right:42px; margin-left: 5px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入申请开始时间" />
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 13px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 234px;margin-right:15px;margin-left: 30px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入申请结束时间" />
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		</div>
		<div class="searchbox col-xs-12">
		   <label class="title">申请部门：</label>
		   <select id="form_dep" class="form-box" style="width:234px;">
		   </select>
		    <label class="title">采购单号：</label>
		    <input id="form_billNo" class="form-box" type="text" placeholder="请输入采购单号" style="width:234px;"/>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="addPrice()">新增</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>申请部门</th>
					<th>采购单号</th>
                    <th>类型</th>
                    <th>品牌</th>
                    <th>尺寸</th>
                    <th>数量</th>
                    <th>价格</th>
                    <th>申请时间</th>
                    <th>状态</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 新增轮胎采购申请-->
			<div class="modal fade modal-reset" id="modal-add" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog dia-widget-box" style="padding:0;width:100%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="refresh();">×</button>
						<h3 id="myModalLabel">新增轮胎采购申请</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <div class="add-item extra-item1">
								     <label class="title"><span class="red">*</span>申请部门：</label>
								     <select id="depInfo" class="form-control">
									 </select>
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-item1">
								       <label class="title"><span class="red">*</span>申请人：</label>
								       <input class="form-control" id="applyUserInfo" type="text" placeholder="请输入申请人" disabled="disabled"/>
								    </div>
								    <hr class="tree"></hr>
								     <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>类型：</label>
									     <select class="form-control" id="typeInfo">
									       <option value="">请选择类型</option>
									       <option value="0">轮胎</option>
									       <option value="1">钢圈</option>
									     </select>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>品牌：</label>
									     <input class="form-control" id="brandInfo" type="text" placeholder="请输入品牌"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>尺寸：</label>
									     <input class="form-control" id="sizeInfo" type="text" placeholder="请输入尺寸"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>数量：</label>
									     <input class="form-control" id="sumInfo" type="text" placeholder="请输入数量"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>价格(元)：</label>
									     <input class="form-control" id="priceInfo" type="text" placeholder="请输入价格"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title">情况说明：</label>
									     <input class="form-control" id="markInfo" type="text" placeholder="请输入情况说明"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="save();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="refresh();">取消</a>
									 </div> 
									</div>
						       </div>
					     </div>
					  </div>
				   </div>
				 </div>
			 </div>
			<!-- 编辑轮胎申请设置 -->
			<div class="modal fade modal-reset" id="modal-edit" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog dia-widget-box" style="padding:0;width:100%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="updateRefresh();">×</button>
						<h3 id="myModalLabel">编辑轮胎采购申请</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <div class="add-item extra-item1">
								     <label class="title"><span class="red">*</span>申请部门：</label>
								     <select id="edepInfo" class="form-control">
									 </select>
									 <input type="hidden" id="id-hidden"/>
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-item1">
								       <label class="title"><span class="red">*</span>申请人：</label>
								       <input class="form-control" id="eapplyUserInfo" type="text" placeholder="请输入申请人" disabled="disabled"/>
								    </div>
								    <hr class="tree"></hr>
								     <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>类型：</label>
									     <select class="form-control" id="etypeInfo">
									       <option value="">请选择类型</option>
									       <option value="0">轮胎</option>
									       <option value="1">钢圈</option>
									     </select>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>品牌：</label>
									     <input class="form-control" id="ebrandInfo" type="text" placeholder="请输入品牌"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>尺寸：</label>
									     <input class="form-control" id="esizeInfo" type="text" placeholder="请输入尺寸"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>数量：</label>
									     <input class="form-control" id="esumInfo" type="text" placeholder="请输入数量"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>价格(元)：</label>
									     <input class="form-control" id="epriceInfo" type="text" placeholder="请输入价格"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title">情况说明：</label>
									     <input class="form-control" id="emarkInfo" type="text" placeholder="请输入情况说明"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="update();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="updateRefresh();">取消</a>
									 </div> 
									</div>
						       </div>
					     </div>
					  </div>
				   </div>
				 </div>
			 </div>
			 <!-- 查看 -->
			 <div class="modal fade modal-reset" id="modal-view" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog dia-widget-box" style="padding:0;width:100%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="viewrefresh();">×</button>
						<h3 id="myModalLabel">查看轮胎采购申请</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <div class="add-item extra-item1">
								     <label class="title"><span class="red">*</span>申请部门：</label>
								     <p id="sdepInfo" class="form-control no-border"></p>
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-item1">
								       <label class="title"><span class="red">*</span>申请人：</label>
								       <p id="sapplyUserInfo" class="form-control no-border"></p>
								    </div>
								    <hr class="tree"></hr>
								     <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>类型：</label>
									     <p id="stypeInfo" class="form-control no-border"></p>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>品牌：</label>
									     <p id="sbrandInfo" class="form-control no-border"></p>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>尺寸：</label>
									     <p id="ssizeInfo" class="form-control no-border"></p>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>数量：</label>
									     <p id="ssumInfo" class="form-control no-border"></p>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>价格(元)：</label>
									     <p id="spriceInfo" class="form-control no-border"></p>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title">情况说明：</label>
									     <p id="smarkInfo" class="form-control no-border"></p>
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
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="${ctx}/staticPublic/js/jquery.dataTables.bootstrap.js"></script>
<script type="text/javascript">
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/trackTyreBuyApply/getListData" , //获取数据的ajax方法的URL							 
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
		    {data: "departmentName","width":"10%"},
		    {data: "billNo","width":"10%"},
		    {data: "type","width":"9%"},
		    {data: "brand","width":"12%"},
		    {data: "size","width":"8%"},
		    {data: "sum","width":"5%"},
		    {data: "price","width":"6%"},
		    {data: "insertTime","width":"10%"},
		    {data: "status","width":"7%"},
		    {data: null,"width":"18%"}],
		    columnDefs: [
                {
                	//类型
			    	 targets: 3,
			    	 render: function (data, type, row, meta) {
		                    if(data=='0'){
		                    	return '轮胎';
		                    }else if(data=='1'){
		                    	return '钢圈';
		                    }else{
		                    	return data;
		                    }
		                }	
                },
                {
                	//申请时间
			    	 targets: 8,
			    	 render: function (data, type, row, meta) {
		                   if(data!=null && data!=''){
		                	  return jsonDateFormat(data);
		                   }else{
		                	   return '';
		                   }
		                }	
                },
                {
                	//状态
			    	 targets: 9,
			    	 render: function (data, type, row, meta) {
		                    if(data=='0'){
		                    	return '新建';
		                    }else if(data=='1'){
		                    	return '待复核';
		                    }else if(data=='2'){
		                    	return '待采购';
		                    }else if(data=='3'){
		                    	return '已完成';
		                    }else if(data=='4'){
		                    	return '已登记';
		                    }else{
		                    	return data;
		                    }
		                }	
                },
		      	{
			    	 //操作栏
			    	 targets: 10,
			    	 render: function (data, type, row, meta) {
			    		 if(row.status=='0'){
			    			  return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
	                    	        +'<a class="table-edit" onclick="dosumbit('+ row.id +')">提交</a>'
					                +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
		                    }else if(row.status=='2'){//待采购
		                    	return '<a class="table-edit" onclick="dosure('+ row.id +')">确认</a>'
		                    	+'<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
		                    }else{
		                    	return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
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
		 "sAjaxSource": "${ctx}/operationMng/trackTyreBuyApply/getListData" , //获取数据的ajax方法的URL	
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
						    {data: "departmentName","width":"10%"},
						    {data: "billNo","width":"10%"},
						    {data: "type","width":"9%"},
						    {data: "brand","width":"12%"},
						    {data: "size","width":"8%"},
						    {data: "sum","width":"5%"},
						    {data: "price","width":"6%"},
						    {data: "insertTime","width":"10%"},
						    {data: "status","width":"7%"},
						    {data: null,"width":"18%"}],
						    columnDefs: [
				                {
				                	//类型
							    	 targets: 3,
							    	 render: function (data, type, row, meta) {
						                    if(data=='0'){
						                    	return '轮胎';
						                    }else if(data=='1'){
						                    	return '钢圈';
						                    }else{
						                    	return data;
						                    }
						                }	
				                },
				                {
				                	//申请时间
							    	 targets: 8,
							    	 render: function (data, type, row, meta) {
						                   if(data!=null && data!=''){
						                	  return jsonDateFormat(data);
						                   }else{
						                	   return '';
						                   }
						                }	
				                },
				                {
				                	//状态
							    	 targets: 9,
							    	 render: function (data, type, row, meta) {
						                    if(data=='0'){
						                    	return '新建';
						                    }else if(data=='1'){
						                    	return '待复核';
						                    }else if(data=='2'){
						                    	return '待采购';
						                    }else if(data=='3'){
						                    	return '已完成';
						                    }else if(data=='4'){
						                    	return '已登记';
						                    }else{
						                    	return data;
						                    }
						                }	
				                },
						      	{
							    	 //操作栏
							    	 targets: 10,
							    	 render: function (data, type, row, meta) {
							    		 if(row.status=='0'){
							    			  return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
					                    	        +'<a class="table-edit" onclick="dosumbit('+ row.id +')">提交</a>'
									                +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
						                    }else if(row.status=='2'){//待采购
						                    	return '<a class="table-edit" onclick="dosure('+ row.id +')">确认</a>'
						                    	+'<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
						                    }
							    		  else{
						                    	return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
						                    }
						                    
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
	getDeptList();
})


/* 获取部门 */
function getDeptList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/trackTyreBuyApply/getDeptList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="">请选择部门</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	                		}
	            		}
	            	}
	            	$('#form_dep').html(html);
	            	$('#depInfo').html(html);
	            	$('#edepInfo').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
 }
 

/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var billNo=$('#form_billNo').val();
	   var departmentId=$('#form_dep').val();
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
				startTime : startTime,
				endTime : endTime,
				billNo :billNo,
				departmentId :departmentId
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

/* 删除 */
function dodelete(id){
	var ids=parseInt(id);
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该申请信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/trackTyreBuyApply/delete/"+ids,
						data :{},
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
/* 提交 */
function dosumbit(id){
	var ids=parseInt(id);
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该申请信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/trackTyreBuyApply/submit/"+ids,
						data :{},
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
};
/*新增信息输入  */
function addPrice(){
	clear();
	$('#modal-add').modal('show');
}
/* 关闭窗体 */
function refresh(){
	$('#modal-add').modal('hide');
	
}
/* 数据重置 */
function clear(){
	$('#depInfo').val('${sessionScope.LMS_USER.departmentId}');
	$('#applyUserInfo').val('${sessionScope.LMS_USER.name}');
	$('#typeInfo').val('');
	$('#brandInfo').val('');
	$('#sizeInfo').val('');
	$('#sumInfo').val('');
	$('#priceInfo').val('');
	$('#markInfo').val('');
	
}
/* 查看申请详细信息 */
function doshow(id){
	var ids=parseInt(id);
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackTyreBuyApply/getById/"+ids,
		data :{},
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#sdepInfo').html(data.data.departmentId);
				$('#sapplyUserInfo').html('${sessionScope.LMS_USER.name}');
				if(data.data.type=='0'){
					$('#stypeInfo').html('轮胎');
				}else{
					$('#stypeInfo').html('钢圈');	
				}				
				$('#sbrandInfo').html(data.data.brand);
				$('#ssizeInfo').html(data.data.size);
				$('#ssumInfo').html(data.data.sum);
				$('#spriceInfo').html(data.data.price);
				$('#smarkInfo').html(data.data.mark);
				$('#modal-view').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
/* 关闭查看窗口 */
function viewrefresh(){
	$('#modal-view').modal('hide');
}
/* 关闭编辑窗口 */
function updateRefresh(){
	$('#modal-edit').modal('hide');
}

function doedit(id){
	$('#id-hidden').val(id);
	var ids=parseInt(id);
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackTyreBuyApply/getById/"+ids,
		data :{},
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#edepInfo').val(data.data.departmentId);
				$('#eapplyUserInfo').val('${sessionScope.LMS_USER.name}');
				$('#etypeInfo').val(data.data.type);
				$('#ebrandInfo').val(data.data.brand);
				$('#esizeInfo').val(data.data.size);
				$('#esumInfo').val(data.data.sum);
				$('#epriceInfo').val(data.data.price);
				$('#emarkInfo').val(data.data.mark);
				$('#modal-edit').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}

/* 保存轮胎采购申请 */
function save(){
	 var flag="false";
	 var objList={};
	 var departmentId=$('#depInfo').val();
	 var applyUserId='${sessionScope.LMS_USER.id}';
	 var type=$('#typeInfo').val();
	 var brand=$('#brandInfo').val();
	 var size=$('#sizeInfo').val();
	 var sum=$('#sumInfo').val();
	 var price=$('#priceInfo').val();
	 var mark=$('#markInfo').val();
	 if(departmentId=='' || departmentId==null){
		 bootbox.alert('请选择申请部门！');
		 return;
	 }
	 if(applyUserId=='' || applyUserId==null){
		 bootbox.alert('请输入申请人！');
		 return;
	 }
	 if(type=='' || type==null){
		 bootbox.alert('请选择类型！');
		 return;
	 }
	 if(brand=='' || brand==null){
		 bootbox.alert('请输入品牌！');
		 return;
	 }
	 if(size=='' || size==null){
		 bootbox.alert('请输入尺寸！');
		 return;
	 }
	 if(sum=='' || sum==null){
		 bootbox.alert('请输入数量！');
		 return;
	 }
	 if(price=='' || price==null){
		 bootbox.alert('请输入价格！');
		 return;
	 }
	 objList.departmentId=departmentId;
	 objList.applyUserId=applyUserId;
	 objList.type=type;
	 objList.brand=brand;
	 objList.size=size;
	 objList.sum=sum;
	 objList.price=price;
	 objList.mark=mark;
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该轮胎申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackTyreBuyApply/save',
						data : JSON.stringify(objList),
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
											  reload();
											  $('#modal-add').modal('hide');
										  }else{
											  reload(); 
											  $('#modal-add').modal('hide');
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										 reload(); 
										 $('.bootbox').modal('hide');
										 $('#modal-add').modal('hide');
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

/* 更新 */
function update(){
	 var id=$('#id-hidden').val();
	 var flag="false";
	 var objList={};
	 var departmentId=$('#edepInfo').val();
	 var applyUserId='${sessionScope.LMS_USER.id}';
	 var type=$('#etypeInfo').val();
	 var brand=$('#ebrandInfo').val();
	 var size=$('#esizeInfo').val();
	 var sum=$('#esumInfo').val();
	 var price=$('#epriceInfo').val();
	 var mark=$('#emarkInfo').val();
	 if(departmentId=='' || departmentId==null){
		 bootbox.alert('请选择申请部门！');
		 return;
	 }
	 if(applyUserId=='' || applyUserId==null){
		 bootbox.alert('请输入申请人！');
		 return;
	 }
	 if(type=='' || type==null){
		 bootbox.alert('请选择类型！');
		 return;
	 }
	 if(brand=='' || brand==null){
		 bootbox.alert('请输入品牌！');
		 return;
	 }
	 if(size=='' || size==null){
		 bootbox.alert('请输入尺寸！');
		 return;
	 }
	 if(sum=='' || sum==null){
		 bootbox.alert('请输入数量！');
		 return;
	 }
	 if(price=='' || price==null){
		 bootbox.alert('请输入价格！');
		 return;
	 }
	 objList.departmentId=departmentId;
	 objList.applyUserId=applyUserId;
	 objList.type=type;
	 objList.brand=brand;
	 objList.size=size;
	 objList.sum=sum;
	 objList.price=price;
	 objList.mark=mark;
	 objList.id=id;
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该轮胎申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackTyreBuyApply/save',
						data : JSON.stringify(objList),
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
											  reload();
											  $('#modal-edit').modal('hide');
										  }else{
											  reload(); 
											  $('#modal-edit').modal('hide');
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										 reload(); 
										 $('.bootbox').modal('hide');
										 $('#modal-edit').modal('hide');
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

//确认
function dosure(id)
{
	var ids=parseInt(id);
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要确认完成该轮胎采购信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/trackTyreBuyApply/sure/"+ids,
						data :{},
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "确认成功！", 
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
</script>



</body>
</html>






