
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
				轮胎入库管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
	    <div class="searchbox col-xs-12">
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">登记时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 234px;margin-right:42px; margin-left: 5px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入登记开始时间" />
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 13px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 234px;margin-right:15px;margin-left: 30px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入登记结束时间" />
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		</div>
		<div class="searchbox col-xs-12">
		   <label class="title">入库单号：</label>
		   <input id="form_billNo" class="form-box" type="text" placeholder="请输入入库单号" style="width:234px;"/>
		    <label class="title">采购单号：</label>
		    <select id="form_buyBillNo" class="form-box" type="text" style="width:234px;">
		    </select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="addPrice()">新增</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>入库单号</th>
					<th>采购单号</th>
                    <th>登记时间</th>
                    <th>登记人</th>
                    <th>状态</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 新增轮胎入库信息-->
			<div class="modal fade modal-reset" id="modal-add" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog dia-widget-box" style="padding:0;width:100%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="refresh();">×</button>
						<h3 id="myModalLabel">新增轮胎入库信息</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>采购单号：</label>
								     <select id="billNoInfo" class="form-control" onchange="changeBillNo(this,0)">
									 </select>
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-itemSec">
								       <label class="title"><span class="red">*</span>类型：</label>
								       <input class="form-control" id="typeInfo" type="text" placeholder="请输入类型" disabled="disabled" data-type=""/>
								    </div>
								    <hr class="tree"></hr>
								     <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>品牌：</label>
									     <input class="form-control" id="brandInfo" type="text" placeholder="请输入品牌" disabled="disabled"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>尺寸：</label>
									     <input class="form-control" id="sizeInfo" type="text" placeholder="请输入尺寸" disabled="disabled"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>数量：</label>
									     <input class="form-control" id="sumInfo" type="text" placeholder="请输入数量" disabled="disabled"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>价格(元)：</label>
									     <input class="form-control" id="priceInfo" type="text" placeholder="请输入价格" disabled="disabled"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="row row-btn-tit" id="detailListbtn">
					                     <div class="col-xs-3 pd-2">
							                 <div class="row-tit">入库信息</div>
					                     </div>
					                     <div class="col-xs-7"></div>
					                     <div class="col-xs-2">
								             <div class="form-contr-1">
								               <a class="form-btn-1" onclick="addNewTrack(0);"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>添加</a>				             
								             </div>
						                 </div>
					                   </div>
								    <div id="checkInDetail" style="margin:0px auto 12px;">
								      <div id="detailList0" class="border-b-ff9a00 detailList pl-7">
								       <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>品牌：</label>
									     <input class="form-control" id="brandDetailInfo0" type="text" placeholder="请输入品牌"/>
									   </div>
									    <hr class="tree"></hr>
									    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>轮胎编号：</label>
									     <input class="form-control" id="tyreNoDetailInfo0" type="text" placeholder="请输入轮胎编号" />
									   </div>
									    <hr class="tree"></hr>
									    <div class="add-item extra-itemSec">
										     <label class="title"><span class="red">*</span>尺寸：</label>
										     <input class="form-control" id="sizeDetailInfo0" type="text" placeholder="请输入尺寸"/>
										 </div>
									    <hr class="tree"></hr>
									    <div class="add-item extra-itemSec">
										     <label class="title"><span class="red">*</span>价格(元)：</label>
										     <input class="form-control" id="priceDetailInfo0" type="text" placeholder="请输入价格" onkeyup="sumchange(0);"/>
										 </div>
								     </div>
								    </div>
								    
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>总金额(元)：</label>
									     <input class="form-control" id="aMountInfo" type="text" placeholder="总金额" disabled="disabled"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title">备注：</label>
									     <input class="form-control" id="markInfo" type="text" placeholder="请输入备注" />
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
						<h3 id="myModalLabel">编辑轮胎入库信息</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>采购单号：</label>
								     <select id="ebillNoInfo" class="form-control" onchange="changeBillNo(this,1)">
									 </select>
									  <input class="form-control" id="id-hidden" type="hidden"/>
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-itemSec">
								       <label class="title"><span class="red">*</span>类型：</label>
								       <input class="form-control" id="etypeInfo" type="text" placeholder="请输入类型" disabled="disabled" data-type=""/>
								    </div>
								    <hr class="tree"></hr>
								     <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>品牌：</label>
									     <input class="form-control" id="ebrandInfo" type="text" placeholder="请输入品牌" disabled="disabled"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>尺寸：</label>
									     <input class="form-control" id="esizeInfo" type="text" placeholder="请输入尺寸" disabled="disabled"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>数量：</label>
									     <input class="form-control" id="esumInfo" type="text" placeholder="请输入数量" disabled="disabled"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>价格(元)：</label>
									     <input class="form-control" id="epriceInfo" type="text" placeholder="请输入价格" disabled="disabled"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="row row-btn-tit" id="detailListbtn">
					                     <div class="col-xs-3 pd-2">
							                 <div class="row-tit">入库信息</div>
					                     </div>
					                     <div class="col-xs-7"></div>
					                     <div class="col-xs-2">
								             <div class="form-contr-1">
								               <a class="form-btn-1" onclick="addNewTrack(1);"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>添加</a>				             
								             </div>
						                 </div>
					                   </div>
								    <div id="echeckInDetail" style="margin:0px auto 12px;">
								      
								    </div>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>总金额(元)：</label>
									     <input class="form-control" id="eaMountInfo" type="text" placeholder="总金额" disabled="disabled"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title">备注：</label>
									     <input class="form-control" id="emarkInfo" type="text" placeholder="请输入备注" />
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
				        <button class="close" type="button" onclick="viewRefresh();">×</button>
						<h3 id="myModalLabel">查看轮胎入库信息</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>采购单号：</label>
								     <p id="sbillNoInfo" class="form-control no-border"></p>
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-itemSec">
								       <label class="title"><span class="red">*</span>类型：</label>
								        <p id="stypeInfo" class="form-control no-border"></p>
								    </div>
								    <hr class="tree"></hr>
								     <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>品牌：</label>
									     <p id="sbrandInfo" class="form-control no-border"></p>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>尺寸：</label>
									     <p id="ssizeInfo" class="form-control no-border"></p>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>数量：</label>
									     <p id="ssumInfo" class="form-control no-border"></p>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>价格(元)：</label>
									     <p id="spriceInfo" class="form-control no-border"></p>
									 </div>
								    <hr class="tree"></hr>
								    <div class="row row-btn-tit" id="detailListbtn">
					                     <div class="col-xs-3 pd-2">
							                 <div class="row-tit">入库信息</div>
					                     </div>
					                     <div class="col-xs-9"></div>
					                   </div>
								    <div id="scheckInDetail" style="margin:0px auto 12px;">
								      
								    </div>
								    <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>总金额(元)：</label>
									     <p id="saMountInfo" class="form-control no-border"></p>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
									     <label class="title">备注：</label>
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
		 "sAjaxSource": "${ctx}/operationMng/trackTyreRuMng/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum","width":"8%"},
		    {data: "billNo","width":"15%"},
		    {data: "buyBillNo","width":"15%"},
		    {data: "insertTime","width":"15%"},
		    {data: "insertUserName","width":"15%"},
		    {data: "status","width":"12%"},
		    {data: null,"width":"20%"}],
		    columnDefs: [
                {
                	//登记时间
			    	 targets: 3,
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
			    	 targets: 5,
			    	 render: function (data, type, row, meta) {
		                    if(data=='0'){
		                    	return '新建';
		                    }else if(data=='1'){
		                    	return '待复核';
		                    }else if(data=='2'){
		                    	return '已完成';
		                    }else{
		                    	return data;
		                    }
		                }	
                },
		      	{
			    	 //操作栏
			    	 targets: 6,
			    	 render: function (data, type, row, meta) {
			    		 if(row.status=='0'){
			    			  return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
	                    	        +'<a class="table-edit" onclick="dosumbit('+ row.id +')">提交</a>'
					                +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
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
		 "sAjaxSource": "${ctx}/operationMng/trackTyreRuMng/getListData" , //获取数据的ajax方法的URL	
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
				columns: [{ data: "rownum","width":"8%"},
						    {data: "billNo","width":"15%"},
						    {data: "buyBillNo","width":"15%"},
						    {data: "insertTime","width":"15%"},
						    {data: "insertUserName","width":"15%"},
						    {data: "status","width":"12%"},
						    {data: null,"width":"20%"}],
						    columnDefs: [
				                {
				                	//登记时间
							    	 targets: 3,
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
							    	 targets: 5,
							    	 render: function (data, type, row, meta) {
						                    if(data=='0'){
						                    	return '新建';
						                    }else if(data=='1'){
						                    	return '待复核';
						                    }else if(data=='2'){
						                    	return '已完成';
						                    }else{
						                    	return data;
						                    }
						                }	
				                },
						      	{
							    	 //操作栏
							    	 targets: 6,
							    	 render: function (data, type, row, meta) {
							    		 if(row.status=='0'){
							    			  return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
					                    	        +'<a class="table-edit" onclick="dosumbit('+ row.id +')">提交</a>'
									                +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
						                    }else{
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
	getBillList();
})

/* 价格总计 */
function sumchange(flag){
	var countInit=0;
	if(flag=='0'){
		var detailList=$('.detailList').length;
		for(var i=0;i<detailList;i++){
			 if($('#priceDetailInfo'+i+'').val()!=null && $('#priceDetailInfo'+i+'').val()!=''){
				 countInit+=parseFloat($('#priceDetailInfo'+i+'').val());
			 }
		}
		$('#aMountInfo').val(countInit);
	}else{
		var detailList=$('.edetailList').length;
		for(var i=0;i<detailList;i++){
			 if($('#epriceDetailInfo'+i+'').val()!=null && $('#epriceDetailInfo'+i+'').val()!=''){
				 countInit+=parseFloat($('#epriceDetailInfo'+i+'').val());
			 }
		}
		$('#eaMountInfo').val(countInit);
	}
	
}

/* 获取采购单号 */
function getBillList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/trackTyreRuMng/getBuyApplyListData',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="">请选择采购单号</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['billNo']+' data-type='+data.data[i]['type']+' data-brand='+data.data[i]['brand']+' data-size='+data.data[i]['size']+' data-sum='+data.data[i]['sum']+' data-price='+data.data[i]['price']+'>'+data.data[i]['billNo']+'</option>';
	                		}
	            		}
	            	}
	            	$('#billNoInfo').html(html);
	            	$('#ebillNoInfo').html(html);
	            	$('#form_buyBillNo').html(html);
	            	
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
 }
 /* 根据采购单号获取相应的信息 */
 function changeBillNo(e,flag){
	 var typeInfo=$(e).find('option:selected').attr('data-type');
	 var brandInfo=$(e).find('option:selected').attr('data-brand');
	 var sizeInfo=$(e).find('option:selected').attr('data-size');
	 var sumInfo=$(e).find('option:selected').attr('data-sum');
	 var priceInfo=$(e).find('option:selected').attr('data-price');
	 if(typeInfo=='0'){
		 $('#typeInfo').val('轮胎');
		 $('#typeInfo').attr('data-type','0');
	 }else{
		 $('#typeInfo').val('钢圈'); 
		 $('#typeInfo').attr('data-type','1');
	 }
	 if(flag=='0'){
		 $('#brandInfo').val(brandInfo); 
		 $('#sizeInfo').val(sizeInfo); 
		 $('#sumInfo').val(sumInfo); 
		 $('#priceInfo').val(priceInfo);  
	 }else{
		 $('#ebrandInfo').val(brandInfo); 
		 $('#esizeInfo').val(sizeInfo); 
		 $('#esumInfo').val(sumInfo); 
		 $('#epriceInfo').val(priceInfo); 
	 }
	 
 }

/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var billNo=$('#form_billNo').val();
	   var buyBillNo=$('#form_buyBillNo').val();
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
				buyBillNo :buyBillNo
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

/* 新增入库信息 */
function addNewTrack(flag){
	if(flag=='0'){
		 var index=$('.detailList').length;
		 var html='<div id="detailList'+index+'" class="border-b-ff9a00 detailList pl-7">'
		   		  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>品牌：</label>'
		   		  +'<input class="form-control" id="brandDetailInfo'+index+'" type="text" placeholder="请输入品牌"/></div><hr class="tree"></hr>'
		   		  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>轮胎编号：</label>'
		   		  +'<input class="form-control" id="tyreNoDetailInfo'+index+'" type="text" placeholder="请输入轮胎编号" /></div><hr class="tree"></hr>'
			   	  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>尺寸：</label>'
			   	  +'<input class="form-control" id="sizeDetailInfo'+index+'" type="text" placeholder="请输入尺寸"/></div><hr class="tree"></hr>'
			   	  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>价格(元)：</label>'
			   	  +'<input class="form-control" id="priceDetailInfo'+index+'" type="text" placeholder="请输入价格" onkeyup="sumchange(0);"/></div>'
			   	  +'<div class="add-item extra-itemSec"><div class="col-xs-10"></div><div class="col-xs-2 pd-2"><div class="form-contr-1">'
			   	  +'<a class="delete-detail fr" onclick="deleteDetail(this,'+index+',0);"><i class="icon-minus-sign" style="display: inline-block;width: 20px;"></i>删除</a></div></div></div>'
		   		  +'</div>';
	     $('#detailList'+(index-1)+'').after(html);
	}else{
		 var index=$('.edetailList').length;
		 var html='<div id="edetailList'+index+'" class="border-b-ff9a00 edetailList pl-7">'
		   		  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>品牌：</label>'
		   		  +'<input class="form-control" id="ebrandDetailInfo'+index+'" type="text" placeholder="请输入品牌"/></div><hr class="tree"></hr>'
		   		  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>轮胎编号：</label>'
		   		  +'<input class="form-control" id="etyreNoDetailInfo'+index+'" type="text" placeholder="请输入轮胎编号" /></div><hr class="tree"></hr>'
			   	  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>尺寸：</label>'
			   	  +'<input class="form-control" id="esizeDetailInfo'+index+'" type="text" placeholder="请输入尺寸"/></div><hr class="tree"></hr>'
			   	  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>价格(元)：</label>'
			   	  +'<input class="form-control" id="epriceDetailInfo'+index+'" type="text" placeholder="请输入价格" onkeyup="sumchange(1);"/></div>'
			   	  +'<div class="add-item extra-itemSec"><div class="col-xs-10"></div><div class="col-xs-2 pd-2"><div class="form-contr-1">'
			   	  +'<a class="delete-detail fr" onclick="deleteDetail(this,'+index+',1);"><i class="icon-minus-sign" style="display: inline-block;width: 20px;"></i>删除</a></div></div></div>'
		   		  +'</div>';
	     $('#edetailList'+(index-1)+'').after(html);
	}
	 
}

/* 删除入库信息填写框 */
function deleteDetail(e,index,flag){
	if(flag=='0'){
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要删除该入库详细信息?", 
			  callback: function(result){
				  if(result){
					  $(e).parents('#detailList'+index+'').remove();
					  sumchange(flag);
				  }
			  }
		});
	}else{
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要删除该入库详细信息?", 
			  callback: function(result){
				  if(result){
					  $(e).parents('#edetailList'+index+'').remove();
					  sumchange(flag);
				  }
			  }
		});
	}
	
	
}

/* 删除 */
function dodelete(id){
	var ids=parseInt(id);
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该轮胎入库信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/trackTyreRuMng/delete/"+ids,
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
		  message: "确定要提交该轮胎入库信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/trackTyreRuMng/submit/"+ids,
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
	/* $('#depInfo').val('${sessionScope.LMS_USER.departmentId}');
	$('#applyUserInfo').val('${sessionScope.LMS_USER.name}'); */
	$('#billNoInfo').val('');
	$('#typeInfo').val('');
	$('#brandInfo').val('');
	$('#sizeInfo').val('');
	$('#sumInfo').val('');
	$('#priceInfo').val('');
	$('#markInfo').val('');
	$('#aMountInfo').val('');
	var html='<div id="detailList0" class="border-b-ff9a00 detailList pl-7">'
		  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>品牌：</label>'
		  +'<input class="form-control" id="brandDetailInfo0" type="text" placeholder="请输入品牌"/></div><hr class="tree"></hr>'
		  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>轮胎编号：</label>'
		  +'<input class="form-control" id="tyreNoDetailInfo0" type="text" placeholder="请输入轮胎编号" /></div><hr class="tree"></hr>'
	 	  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>尺寸：</label>'
	 	  +'<input class="form-control" id="sizeDetailInfo0" type="text" placeholder="请输入尺寸"/></div><hr class="tree"></hr>'
	 	  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>价格(元)：</label>'
	 	  +'<input class="form-control" id="priceDetailInfo0" type="text" placeholder="请输入价格" onkeyup="sumchange(0);"/></div>'
		  +'</div>';
  $('#checkInDetail').html(html);
}
/* 查看申请详细信息 */
function doshow(id){
	var ids=parseInt(id);
	var html="";
	var count=0;
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackTyreRuMng/getDetail/"+ids,
		data :{},
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var type=data.data.typeEdit;
				if(type=='0'){
					type="轮胎";
				}else{
					type="钢圈";
				}
				$('#sbillNoInfo').html(data.data.buyBillNo);
				$('#stypeInfo').html(type);
				$('#sbrandInfo').html(data.data.brandEdit);
				$('#ssizeInfo').html(data.data.sizeEdit);
				$('#ssumInfo').html(data.data.sumEdit);
				$('#spriceInfo').html(data.data.priceEdit);
				$('#smarkInfo').html(data.data.mark);
				if(data.data.detailList!=null && data.data.detailList!=''){
					for(var i=0;i<data.data.detailList.length;i++){
						var obj=data.data.detailList[i];
						html+='<div id="sdetailList'+i+'" class="border-b-ff9a00 edetailList pl-7">'
				   		  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>品牌：</label>'
				   		  +'<p class="form-control no-border" id="sbrandDetailInfo'+i+'" >'+obj.brand+'</p></div><hr class="tree"></hr>'
				   		  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>轮胎编号：</label>'
				   		  +'<p class="form-control no-border" id="sbrandDetailInfo'+i+'" >'+obj.tyreNo+'</p></div><hr class="tree"></hr>'
					   	  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>尺寸：</label>'
					   	  +'<p class="form-control no-border" id="sbrandDetailInfo'+i+'" >'+obj.size+'</p></div><hr class="tree"></hr>'
					   	  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>价格(元)：</label>'
					   	  +'<p class="form-control no-border" id="sbrandDetailInfo'+i+'" >'+obj.price+'</p></div>'
				   		  +'</div>';
						count+=parseFloat(obj.price);
					}
					
				}else{
					html='<div id="edetailList0" class="border-b-ff9a00 edetailList pl-7">'
			   		  +'<div class="add-item extra-itemSec">暂无入库信息</div><hr class="tree"></hr>'
			   		  +'</div>';
				}
				$('#scheckInDetail').html(html);
				$('#saMountInfo').html(parseFloat(count).toFixed(2));
				$('#modal-view').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
/* 关闭查看窗口 */
function viewRefresh(){
	$('#modal-view').modal('hide');
}
/* 关闭编辑窗口 */
function updateRefresh(){
	$('#modal-edit').modal('hide');
}

function doedit(id){
	$('#id-hidden').val(id);
	var ids=parseInt(id);
	var html="";
	var count=0;
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackTyreRuMng/getDetail/"+ids,
		data :{},
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var type=data.data.typeEdit;
				if(type=='0'){
					type="轮胎";
				}else{
					type="钢圈";
				}
				$('#ebillNoInfo').val(data.data.buyBillNo);
				$('#etypeInfo').val(type);
				$('#etypeInfo').attr('data-type',data.data.typeEdit);
				$('#ebrandInfo').val(data.data.brandEdit);
				$('#esizeInfo').val(data.data.sizeEdit);
				$('#esumInfo').val(data.data.sumEdit);
				$('#epriceInfo').val(data.data.priceEdit);
				$('#emarkInfo').val(data.data.mark);
				if(data.data.detailList!=null && data.data.detailList!=''){
					for(var i=0;i<data.data.detailList.length;i++){
						var obj=data.data.detailList[i];
						if(i==0){
							html+='<div id="edetailList'+i+'" class="border-b-ff9a00 edetailList pl-7">'
					   		  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>品牌：</label>'
					   		  +'<input class="form-control" id="ebrandDetailInfo'+i+'" type="text" placeholder="请输入品牌" value='+obj.brand+' /></div><hr class="tree"></hr>'
					   		  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>轮胎编号：</label>'
					   		  +'<input class="form-control" id="etyreNoDetailInfo'+i+'" type="text" placeholder="请输入轮胎编号" value='+obj.tyreNo+' /></div><hr class="tree"></hr>'
						   	  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>尺寸：</label>'
						   	  +'<input class="form-control" id="esizeDetailInfo'+i+'" type="text" placeholder="请输入尺寸" value='+obj.size+' /></div><hr class="tree"></hr>'
						   	  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>价格(元)：</label>'
						   	  +'<input class="form-control" id="epriceDetailInfo'+i+'" type="text" placeholder="请输入价格" value='+obj.price+' onkeyup="sumchange(1);"/></div>'
					   		  +'</div>';
						}else{
							html+='<div id="edetailList'+i+'" class="border-b-ff9a00 edetailList pl-7">'
					   		  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>品牌：</label>'
					   		  +'<input class="form-control" id="ebrandDetailInfo'+i+'" type="text" placeholder="请输入品牌" value='+obj.brand+' /></div><hr class="tree"></hr>'
					   		  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>轮胎编号：</label>'
					   		  +'<input class="form-control" id="etyreNoDetailInfo'+i+'" type="text" placeholder="请输入轮胎编号" value='+obj.tyreNo+' /></div><hr class="tree"></hr>'
						   	  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>尺寸：</label>'
						   	  +'<input class="form-control" id="esizeDetailInfo'+i+'" type="text" placeholder="请输入尺寸" value='+obj.size+' /></div><hr class="tree"></hr>'
						   	  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>价格(元)：</label>'
						   	  +'<input class="form-control" id="epriceDetailInfo'+i+'" type="text" placeholder="请输入价格" value='+obj.price+' onkeyup="sumchange(1);"/></div>'
						   	  +'<div class="add-item extra-itemSec"><div class="col-xs-10"></div><div class="col-xs-2 pd-2"><div class="form-contr-1">'
						   	  +'<a class="delete-detail fr" onclick="deleteDetail(this,'+i+',1);"><i class="icon-minus-sign" style="display: inline-block;width: 20px;"></i>删除</a></div></div></div>'
					   		  +'</div>';
						}
						count+=parseFloat(obj.price);
					}
					
				}else{
					html='<div id="edetailList0" class="border-b-ff9a00 edetailList pl-7">'
			   		  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>品牌：</label>'
			   		  +'<input class="form-control" id="ebrandDetailInfo0" type="text" placeholder="请输入品牌"/></div><hr class="tree"></hr>'
			   		  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>轮胎编号：</label>'
			   		  +'<input class="form-control" id="etyreNoDetailInfo0" type="text" placeholder="请输入轮胎编号" /></div><hr class="tree"></hr>'
				   	  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>尺寸：</label>'
				   	  +'<input class="form-control" id="esizeDetailInfo0" type="text" placeholder="请输入尺寸"/></div><hr class="tree"></hr>'
				   	  +'<div class="add-item extra-itemSec"><label class="title"><span class="red">*</span>价格(元)：</label>'
				   	  +'<input class="form-control" id="epriceDetailInfo0" type="text" placeholder="请输入价格" onkeyup="sumchange(1);"/></div>'
			   		  +'</div>';
				}
				$('#echeckInDetail').html(html);
				$('#eaMountInfo').val(parseFloat(count).toFixed(2));
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
	 var objs=[];
	 var buyBillNo=$('#billNoInfo').val();
	 var mark=$('#markInfo').val();
	 var typeInfo=$('#typeInfo').attr('data-type');
	 if(buyBillNo=='' || buyBillNo==null){
		 bootbox.alert('请选择采购单号！');
		 return;
	 }
	 var detailList=$('.detailList').length;
	 for(var i=0;i<detailList;i++){
		 var objItem={};
		 objItem.type=typeInfo;
		 if($('#brandDetailInfo'+i+'').val()==null || $('#brandDetailInfo'+i+'').val()==''){
			 bootbox.alert('请输入第'+(i+1)+'条品牌信息！');
			 return;
		 }else{
			 objItem.brand=$('#brandDetailInfo'+i+'').val();
		 }
		 if($('#tyreNoDetailInfo'+i+'').val()==null || $('#tyreNoDetailInfo'+i+'').val()==''){
			 bootbox.alert('请输入第'+(i+1)+'条轮胎编号信息！');
			 return;
		 }else{
			 objItem.tyreNo=$('#tyreNoDetailInfo'+i+'').val();
		 }
		 if($('#sizeDetailInfo'+i+'').val()==null || $('#sizeDetailInfo'+i+'').val()==''){
			 bootbox.alert('请输入第'+(i+1)+'条尺寸信息！');
			 return;
		 }else{
			 objItem.size=$('#sizeDetailInfo'+i+'').val();
		 }
		 if($('#priceDetailInfo'+i+'').val()==null || $('#priceDetailInfo'+i+'').val()==''){
			 bootbox.alert('请输入第'+(i+1)+'条信息价格信息！');
			 return;
		 }else{
			 objItem.price=$('#priceDetailInfo'+i+'').val();
		 }
		 objs.push(objItem);
	 }
	 objList.detailList=objs;
	 objList.buyBillNo=buyBillNo;
	 objList.mark=mark;
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该轮胎申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackTyreRuMng/save',
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
	 var objs=[];
	 var buyBillNo=$('#ebillNoInfo').val();
	 var mark=$('#emarkInfo').val();
	 var typeInfo=$('#etypeInfo').attr('data-type');
	 if(buyBillNo=='' || buyBillNo==null){
		 bootbox.alert('请选择采购单号！');
		 return;
	 }
	 var detailList=$('.edetailList').length;
	 for(var i=0;i<detailList;i++){
		 var objItem={};
		 objItem.type=typeInfo;
		 if($('#ebrandDetailInfo'+i+'').val()==null || $('#ebrandDetailInfo'+i+'').val()==''){
			 bootbox.alert('请输入第'+(i+1)+'条品牌信息！');
			 return;
		 }else{
			 objItem.brand=$('#ebrandDetailInfo'+i+'').val();
		 }
		 if($('#etyreNoDetailInfo'+i+'').val()==null || $('#etyreNoDetailInfo'+i+'').val()==''){
			 bootbox.alert('请输入第'+(i+1)+'条轮胎编号信息！');
			 return;
		 }else{
			 objItem.tyreNo=$('#etyreNoDetailInfo'+i+'').val();
		 }
		 if($('#esizeDetailInfo'+i+'').val()==null || $('#esizeDetailInfo'+i+'').val()==''){
			 bootbox.alert('请输入第'+(i+1)+'条尺寸信息！');
			 return;
		 }else{
			 objItem.size=$('#esizeDetailInfo'+i+'').val();
		 }
		 if($('#epriceDetailInfo'+i+'').val()==null || $('#epriceDetailInfo'+i+'').val()==''){
			 bootbox.alert('请输入第'+(i+1)+'条信息价格信息！');
			 return;
		 }else{
			 objItem.price=$('#epriceDetailInfo'+i+'').val();
		 }
		 objs.push(objItem);
	 }
	 objList.detailList=objs;
	 objList.id=id;
	 objList.buyBillNo=buyBillNo;
	 objList.mark=mark;
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该轮胎申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackTyreRuMng/update',
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
</script>



</body>
</html>






