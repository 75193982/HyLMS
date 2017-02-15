
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
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
  #modal-down{
    width: 400px;
    height: 300px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    } 
</style>
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">供应商：</label>
		  <!--  <select class="form-box" id="brandSearch"></select> -->
		   <input id="brandSearch" class="form-box" style="width: 200px;" type="text" placeholder="请填写供应商(模糊查询)" onkeyup="searchSchedule(this)"/>
		   <input id="brandSearch-hidden" type="hidden"/>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="doadd()">新增</a>
			<a class="itemBtn" onclick="doback()">返回</a>
			<a class="itemBtn" onclick="showTemple()" style="width: 100px;">模板下载</a>
		</div>
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>承运商</th>
					<th>供应商</th>
					<th>品牌</th>
					<th>结账方式</th>
					<th>结算模式</th>
                    <th>更新人</th>
                    <th>更新时间</th>                  
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 新增/编辑品牌信息 modal begin -->
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static" style="height:430px;">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">新增/编辑供应商信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>供应商：</label>
							     <!-- <select  class="form-control" id="brandName_new"></select> -->
							     <input id="brandName_new" class="form-box" style="width: 180px;" type="text" placeholder="请填写供应商(模糊查询)" onkeyup="searchSchedule2(this)"/>
		   						 <input id="brandName_new-hidden" type="hidden"/>
		   						 
		   						 <div id="selectItem9" class="selectItemhidden" style="height: 150px;">
										<div id="selectItemCount" class="selectItemcont">
											<div id="selectCarNo2" style="height: 150px;">
											
											</div>
										</div>
									</div>
									
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>品牌：</label>
								      <select id="brandNameInfo" class="form-control" style="width: 180px;">
									      <option value="">请选择品牌</option>
									   </select>
								 </div>
						  		<hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>结账方式：</label>
								      <select id="accountType" class="form-control"  style="width: 180px;">
									      <option value="0">开票</option>
									      <option value="1">现金</option>
									    </select>
								     <input class="form-control" id="id-hidden" type="hidden"/>
								      <input class="form-control" id="brandName-hidden" type="hidden"/>
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>结算模式：</label>
									      <select id="balanceType" class="form-control" style="width: 180px;">
										      <option value="0">单台车型模式</option>
										      <option value="1">单台单价模式</option>
										      <option value="2">单台总价模式</option>
										    </select>
									 </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-itemSec" style="position:relative">
									     <label class="title" style="width:140px;">应用到其它供应商：</label>
									     <div class="form-control" style="border:0;padding:0;width:70%;">
									       <input id="euseIds" value="" type="text" readonly="readonly" style="width:70%;" />
									       <input class="form-control" id="suppliedid-hidden" type="hidden"/>
									       <a class="selectBtn" id="selectBtn" onclick="controlUseLoad(this)">选择</a>
									     </div>
									 </div>
							    	<hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
								      <label class="title">价格数据导入：</label>
								      <div class="form-control" style="border:0;height:auto;">
								         <input type="file" id="accountDataFile" /> 
                                         <label class="title" id="accountDataFilename"></label>
                                         <input type="hidden" name="accountDataFilename_hidden" id="accountDataFilename_hidden" />
                                         <input type="hidden" name="accountDataFilepath_hidden" id="accountDataFilepath_hidden" /><br />
                                        <span class="red">*选择或更改结算模式，请上传价格数据模板！</span>
								      </div>
								      
                                    </div>
                                     <hr class="tree"></hr>
							    <div class="add-item-btn" id="addBtn">
								    <a class="add-itemBtn btnOk" onclick="save();">保存</a>
								    <a class="add-itemBtn btnCancle" onclick="refresh();">取消</a>
								 </div>
								 <div class="add-item-btn" id="editBtn">
								    <a class="add-itemBtn btnOk" onclick="update()">保存</a>
								    <a class="add-itemBtn btnCancle" onclick="refresh()">取消</a>
								  </div> 
								</div>
						  </div>
					</div>
				 </div>
				</div>
			
			</div>
		 <!-- 新增/编辑品牌信息 modal end -->
		 <!-- 用户分组 编辑 -->
			<div class="modal fade" id="modal-einfo" tabindex="-1" role="dialog" data-backdrop="static" style="width:620px;">
				<div class="modal-dialog" style="padding-top:5px;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="enodeUserCancle()">×</button>
						<h3 id="myModalLabel">供应商选择</h3>
				    </div>
					<div class="modal-body" style="height:498px;">
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <table id="euserListTable" class="table table-striped table-bordered table-hover">
					                      <thead>
						                    <tr>	
							                    <th class="center"><input type="checkbox" class="checkall" /></th>													
								                <th>序号</th>
												<th>供应商名称</th>                                                                                                    
						                     </tr>
					                      </thead>
					                      <tbody>
					                       
					                      </tbody>
					                 </table>
								<div class="modelBtn" id="treebtn-load">
									<a class="modelBtn-ok" onclick="enodeUserOk();">确定</a>
									<a class="modelBtn-cancle" onclick="enodeUserCancle()">取消</a>
								</div>
						    </div>
					     </div>
				       </div>  
					</div>
				  </div>
				</div>
			</div>
		 <!-- 结算价格，模式设置以及数据导入  modal begin-->
		 <div class="modal fade" id="modal-add" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="accountRefresh();">×</button>
						<h3 id="myModalLabel">设置价格信息</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>结账方式：</label>
								      <select id="accountType" class="form-control">
									      <option value="0">开票</option>
									      <option value="1">现金</option>
									    </select>
								     <input class="form-control" id="id-hidden" type="hidden"/>
								      <input class="form-control" id="brandName-hidden" type="hidden"/>
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>结算模式：</label>
									      <select id="accountPattern" class="form-control">
										      <option value="0">单台车型模式</option>
										      <option value="1">单台单价模式</option>
										      <option value="2">单台总价模式</option>
										    </select>
									 </div>
							  		<hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
								      <label class="title">价格数据导入：</label>
								      <div class="form-control" style="border:0;height:auto;">
								         <input type="file" id="accountDataFile" /> 
                                         <label class="title" id="accountDataFilename"></label>
                                         <input type="hidden" name="accountDataFilename_hidden" id="accountDataFilename_hidden" />
                                         <input type="hidden" name="accountDataFilepath_hidden" id="accountDataFilepath_hidden" /><br />
                                        <span class="red">*选择或更改结算模式，请上传价格数据模板！</span>
								      </div>
								      
                                    </div>
                                     <hr class="tree"></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="accountSave();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="accountRefresh();">取消</a>
									 </div>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
		 <!-- 结算价格，模式设置以及数据导入  modal end-->
		 <!-- 价格模板模板   modal begin -->
			<div class="modal fade" id="modal-down" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header" style="padding-top: 5px;">
					<button class="close" type="button" data-dismiss="modal" style="padding-top: 5px;">×</button>
					<h3 id="myModalLabel">价格模板下载</h3>
				</div>
				<div class="modal-body" style="height: 200px;">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-itemSec">
							     		<a class="table-upload" href="${ctx}/staticPublic/resources/price_template/单台车型模板.xlsx">单台车型模板下载</a>
							 		 </div>
							 		<hr class="tree"></hr>
							 		<div class="add-item extra-itemSec">
							     		<a class="table-upload" href="${ctx}/staticPublic/resources/price_template/单台单价模板.xlsx">单台单价模板下载</a>
							 		 </div>
							 		 <hr class="tree"></hr>
							 		<div class="add-item extra-itemSec">
							     		<a class="table-upload" href="${ctx}/staticPublic/resources/price_template/单台总价模板.xlsx">单台总价模板下载</a>
							 		 </div>
								</div>
						  </div>
					</div>
				 </div>
				</div>
			
			</div>
		 <!-- 价格模板下载  modal end -->
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
<script src="${ctx}/staticPublic/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
function searchSchedule(e){
	var $val=$(e).val();
	$.ajax({
		type : 'POST',
		url : "${ctx}/basicSetting/transportPriceMng/getSupplierList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		data: JSON.stringify({
			name : $val
		}),
		success : function(data) {
			if (data && data.code == 200) {
				var html = "";
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<p id='+data.data[i]['id']+' onclick=\'clickp(this)\'>'+data.data[i]['name']+'</p>';
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
	
	if('' == $val)
	{
		$('#brandSearch-hidden').val('');
		$('#selectItem8').hide();
	}
	
}
function clickp(e){
	$('#brandSearch').val($(e).html());
	$('#brandSearch-hidden').val($(e).attr('id'));
	$('#selectItem8').hide();
};
$(document).click(function(event) {
   $('#selectItem8').hide();
   $('#selectItem9').hide();
});

/* 获取品牌 */
function bindBrandInfo(id,name){
	var html='<option value="">请选择品牌</option>';
	$.ajax({
		type : 'POST',
		url : "${ctx}/basicSetting/outSourcingBusiness/getSupplierBusinessData",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		data: JSON.stringify({
			supplierId : id
		}),
		success : function(data) {
			if (data && data.code == 200) {
				if(data.data!=null){
					for(var i=0;i<data.data.length;i++){
						if(name!='' && name==data.data[i]['brandName']){
							html+='<option value="'+data.data[i]['brandName']+'" selected>'+data.data[i]['brandName']+'</option>';
						}else{
							html+='<option value="'+data.data[i]['brandName']+'">'+data.data[i]['brandName']+'</option>';
						}
						
					}
				}
				$('#brandNameInfo').html(html);
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
	
}

function searchSchedule2(e){
	var $val=$(e).val();
	$.ajax({
		type : 'POST',
		url : "${ctx}/basicSetting/transportPriceMng/getSupplierList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		data: JSON.stringify({
			name : $val
		}),
		success : function(data) {
			if (data && data.code == 200) {
				var html = "";
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	        				html +='<p id='+data.data[i]['id']+' onclick=\'clickpp(this)\'>'+data.data[i]['name']+'</p>';
	            		}
	        		}
	        	}
	        	$('#selectCarNo2').html(html);
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
	var A_top = $(e).offset().top + $(e).outerHeight(true); //  1
	var A_left = $(e).offset().left;
	$('#selectItem9').show().css({
		"position" : "absolute",
		"top" : "40px",
		"left" : "132px"
	});
	if( null == $val || '' == $val)
	{
		$('#brandName_new-hidden').val('');
	}
}
function clickpp(e){
	$('#brandName_new').val($(e).html());
	$('#brandName_new-hidden').val($(e).attr("id"));
	bindBrandInfo($(e).attr('id'),'');
	$('#selectItem9').hide();
};


function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/basicSetting/outSourcingBusiness/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum" ,"width":"10%"},
		    {data: "outSourcingName","width":"10%"},
		    {data: "supplierName","width":"10%"},
		    {data: "brandName","width":"10%"},
		    {data: "accountType","width":"10%"},
		    {data: "balanceType","width":"10%"},
		    {data: "updateUserName","width":"10%"},
		    {data: "updateTime","width":"10%"},		    
		    {data: null,"width":"20%"}],
		    columnDefs: [
				{
					 //结账方式
					 targets: 4,
					 render: function (data, type, row, meta) {
						if(data=='0'){
							return '开票';
						}else if(data=='1'){
							return '现金';
						}else{
							return data;
						}
						
				      }	       
				},
				{
					 //结算模式
					 targets: 5,
					 render: function (data, type, row, meta) {
						if(data=='0'){
							return '单台车型模式';
						}else if(data=='1'){
							return '单台单价模式';
						}else if(data=='2'){
							return '单台总价模式';
						}else{
							return data;
						}
				      }	       
				},
				{
					 //更新时间
					 targets: 7,
					 render: function (data, type, row, meta) {
						if(data!=''){
							return jsonDateFormat(data);
						}else{
							return '';
						}
				       }	       
				},
		      	{
			    	 //操作栏
			    	 targets: 8,
			    	 render: function (data, type, row, meta) {
		                    return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
						           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
		                    /* '<a class="table-edit" style="width:90px" onclick="doset('+ row.id +')">设置结算价格</a>' */
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
		 "sAjaxSource": "${ctx}/basicSetting/outSourcingBusiness/getListData", //获取数据的ajax方法的URL	
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
				columns: [{ data: "rownum" ,"width":"10%"},
						    {data: "outSourcingName","width":"10%"},
						    {data: "supplierName","width":"10%"},
						    {data: "brandName","width":"10%"},
						    {data: "accountType","width":"10%"},
						    {data: "balanceType","width":"10%"},
						    {data: "updateUserName","width":"10%"},
						    {data: "updateTime","width":"10%"},		    
						    {data: null,"width":"20%"}],
						    columnDefs: [
						 				{
						 					 //结账方式
						 					 targets: 4,
						 					 render: function (data, type, row, meta) {
						 						if(data=='0'){
						 							return '开票';
						 						}else if(data=='1'){
						 							return '现金';
						 						}else{
						 							return data;
						 						}
						 						
						 				      }	       
						 				},
						 				{
						 					 //结算模式
						 					 targets: 5,
						 					 render: function (data, type, row, meta) {
						 						if(data=='0'){
						 							return '单台车型模式';
						 						}else if(data=='1'){
						 							return '单台单价模式';
						 						}else if(data=='2'){
						 							return '单台总价模式';
						 						}else{
						 							return data;
						 						}
						 				      }	       
						 				},
						 				{
						 					 //更新时间
						 					 targets: 7,
						 					 render: function (data, type, row, meta) {
						 						if(data!=''){
						 							return jsonDateFormat(data);
						 						}else{
						 							return '';
						 						}
						 				       }	       
						 				},
						 		      	{
						 			    	 //操作栏
						 			    	 targets: 8,
						 			    	 render: function (data, type, row, meta) {
						 		                    return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
						 						           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
						 		                }	       
						 		    	} 
						 		      ],
						 	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
/* 数据导入 */
function upload(){
	$("#accountDataFile").uploadify({
		//按钮额外自己添加点的样式类.upload
        'buttonClass':'upload',
        //限制文件上传大小
        'fileSizeLimit':'200MB',
        //文件选择框显示
        'fileTypeDesc':'选择',
        //文件类型过滤
         'fileTypeExts':'*.xls;*.xlsx',
        //按钮高度
        'height':'30',
        //按钮宽度
        'width':'100',
        //请求类型
        'method':'post',
        //是否支持多文件上传
        'multi':false,
        /* //需要重写的事件
        'overrideEvents'    :    ['onUploadError'], */
        /* //队列ID，用来显示文件上传队列与进度
        'queueID'            :    'photo_queue', */
        //队列一次最多允许的文件数，也就是一次最多进入上传队列的文件数
        'queueSizeLimit': 1,
        //上传动画，插件文件下的swf文件
        'swf':'${ctx}/staticPublic/js/uploadify/uploadify.swf',
        //处理上传文件的服务类
        'uploader':'${ctx}/upload/saveFile?type=task',
        /* //上传文件个数限制
        'uploadLimit': 1, */
        //上传按钮内容显示文本
        'buttonText':'上传',
         //自定义重写的方法，文件上传错误触发
        /*'onUploadError'        :   function(file,errorCode,erorMsg,errorString){
        	alert(erorMsg);
        },
        //文件选择错误触发
        'onSelectError'        :    uploadify_onSelectError, */
        /* //文件队列上传完毕触发
        'onQueueComplete'    :    heightReset,
        //队列开始上传触发
        'onUploadStart'        :   heightFit, */
        //单个文件上传成功触发
        'onUploadSuccess':function(file, data, response){        	
        	//刷新目录
        	var orginFileName = JSON.parse(data).orginFileName;        		
        	var attachFilePath = JSON.parse(data).attachFilePath;
        	var attachFilePaths="${ctx}"+attachFilePath;
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#accountDataFilename').html(html);
        	$('#accountDataFilename_hidden').val(orginFileName);
        	$('#accountDataFilepath_hidden').val(attachFilePath);
        }
 });
}
$(function(){
	init();
	upload();
	//getbrand();
	//getbrandInfo();
});

/* 新增绑定品牌信息 */
function getbrandInfo(){
	//var supplierId="${supplierId}";
	$.ajax({
		type : 'POST',
		url : "${ctx}/basicSetting/carBrandMng/getBrandList",
		data :{},
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var html ='<option value="">请选择供应商</option>';
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){	            			
	            			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['brandName']+'</option>';
	            		}
	        		}
	        	}
				$('#brandName_new').html(html);
				$('#brandSearch').html(html);
	        	
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
}
/* 获取品牌信息 */
/* function getbrand(){
	var supplierId="${supplierId}";
	$.ajax({
		type : 'POST',
		url : "${ctx}/basicSetting/carBrandMng/getAllBrandsForSupplier",
		data :JSON.stringify({id:supplierId}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var html ='<option value="">请选择品牌</option>';
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){	            			
	            			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['brandName']+'</option>';
	            		}
	        		}
	        	}
				$('#brandSearch').html(html);
				
	        	
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
} */
/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var outSourcingId="${outSourcingId}";
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var brandName=$("#brandSearch-hidden").val(); 
	   if($("#brandSearch").val()==''){
		   brandName='';
	   }
	   var carType=$("#carType").val(); 
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				brandName :$.trim(brandName) ,
				outSourcingId :outSourcingId
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

	
/* 删除品牌信息 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除供应商信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/basicSetting/outSourcingBusiness/delete/"+id,
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
	$('#myModalLabel').html('新增供应商信息');	
	$('#modal-info').modal('show');
}
/* 关闭窗体 */
function refresh(){
	clear();
	$('#modal-info').modal('hide');
}
/* 数据重置 */
function clear(){
	$('#id-hidden').val('');
	$('#brandName_new').val('');
	$('#brandNameInfo').html('<option value="">请选择品牌</option>');
	$('#accountType').val('0');
	$('#accountPattern').val('0');
	$('#euseIds').val('');
	$('#suppliedid-hidden').val('');
}
/* 保存新增信息 */
function save(){
	var outSourcingId="${outSourcingId}";
	var flag="false";
	var supplierId=$('#brandName_new-hidden').val();
	var brandName=$('#brandNameInfo').val();
	var accountType=$('#accountType').val();
	var balanceType=$('#balanceType').val();
	var filePath=$('#accountDataFilepath_hidden').val();
	var oids=$('#suppliedid-hidden').val();
	if(supplierId==""){
		bootbox.alert('供应商不能为空！');
		return;
	}
	if(brandName==""){
		bootbox.alert('品牌不能为空！');
		return;
	}

	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增供应商信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/outSourcingBusiness/save',
						data : JSON.stringify({
							id : '',				
							outSourcingId :outSourcingId,
							supplierId :supplierId,
							brandName :brandName,
							accountType:accountType,
							balanceType:balanceType,
							filePath:filePath,
							oids:oids
							
							
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
											  reload();
											  $('#modal-info').modal('hide');
										  }else{
											 reload(); 
											 $('#modal-info').modal('hide');
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										location.reload();
										 $('.bootbox').modal('hide');
										 $('#modal-info').modal('hide');
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
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/outSourcingBusiness/getDetailData/"+id,
		data :{},
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑供应商信息');
				$("#brandName_new").val(data.data['supplierName']);
				$("#brandName_new-hidden").val(data.data['supplierId']);
				bindBrandInfo(data.data['supplierId'],data.data['brandName']);
				$("#accountType").val(data.data['accountType']);
				$("#accountPattern").val(data.data['accountPattern']);
				$('#accountDataFilename').html('');
				$('#accountDataFilename_hidden').val('');
				$('#accountDataFilepath_hidden').val('');
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
	var outSourcingId="${outSourcingId}";
	var flag="false";
	var id=$('#id-hidden').val();
	var supplierId=$('#brandName_new-hidden').val();
	var brandName=$('#brandNameInfo').val();
	var accountType=$('#accountType').val();
	var balanceType=$('#balanceType').val();
	var filePath=$('#accountDataFilepath_hidden').val();
	var oids=$('#suppliedid-hidden').val();
	if(supplierId==""){
		bootbox.alert('供应商不能为空！');
		return;
	}
	if(brandName==""){
		bootbox.alert('品牌不能为空！');
		return;
	}

	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增供应商信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/outSourcingBusiness/save',
						data : JSON.stringify({
							id :id,
							brandName : brandName,				
							outSourcingId :outSourcingId,
							supplierId :supplierId,
							brandName :brandName,
							accountType:accountType,
							balanceType:balanceType,
							filePath:filePath,
							oids:oids
							
							
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
											  reload();
											  $('#modal-info').modal('hide');
										  }else{
											 reload(); 
											 $('#modal-info').modal('hide');
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										location.reload();
										 $('.bootbox').modal('hide');
										 $('#modal-info').modal('hide');
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
/* 返回供应商界面 */
function doback(){
	location.href="${ctx}/basicSetting/outSourcingMng/index";
}
/* 设置 */
function doset(id){
	$('#id-hidden').val(id);
	$('#accountDataFilename').html('');
	$('#accountDataFilename_hidden').val('');
	$('#accountDataFilepath_hidden').val('');
	/* 获取设置信息 */
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/outSourcingBusiness/getDetailData/"+id,
		data :{},
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				if(data.data.accountType!=null && data.data.accountType!=''){
					$('#accountType').val(data.data.accountType);
				}else{
					$('#accountType').val('0');
				}
				if(data.data.balanceType!=null && data.data.balanceType!=''){
					$('#accountPattern').val(data.data.balanceType);
				}else{
					$('#accountPattern').val('0');
				}
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
	$('#modal-add').modal('show');
}

/* 设置信息保存 */
function accountSave(){
	var outSourcingId="${outSourcingId}";
	var flag="false";
	var id=$('#id-hidden').val();
	var billType=$('#accountType').val();
	var settlementType=$('#accountPattern').val();
	var filePath=$('#accountDataFilepath_hidden').val();
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该价格设置信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/outSourcingBusiness/siteSave',
						data : JSON.stringify({
							id :id,
							brandId : id,				
							billType : billType,
							settlementType : settlementType,
							outSourcingId :outSourcingId,
							filePath :filePath
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
										location.reload();
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
/* 设置窗口取消 */
function accountRefresh(){
	$('#modal-add').modal('hide');
}
/* 价格模板下载 */
function showTemple()
{
	$('#myModalLabel').html('价格模板下载');	
	$('#modal-down').modal('show');	
}

/* 其它应用 */
function controlUseLoad(){
	var html='';
	$.ajax({
		type : 'POST',
		url : "${ctx}/basicSetting/outSourcingBusiness/getSelectOutSourcingData",
		data : JSON.stringify({}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {						
				if(data.data.length>0){
					for(var i=0;i<data.data.length;i++){
						html+='<tr data-id='+data.data[i]["id"]+'><td class="text-center"><input type="checkbox" class="checkchild"></td>'
						+'<td>'+(i+1)+'</td>'
					    +'<td>'+data.data[i]["name"]+'</td>'
					    +'</tr>';
					}
					$('#euserListTable tbody').html(html);
				}
			}
		}
	});
	$('#modal-einfo').modal('show');
	echeckChoose('false');
}

function echeckChoose(flag){
	if(flag==true){
		$(".checkall").prop("checked",true); 
	}else{//不全选 
        $(".checkall").prop("checked",false); 
    } 
	 $(".checkall").on('click',function () {
	      var check = $(this).prop("checked");
	      $(".checkchild").prop("checked", check);
	      if(check==true){
	    	  $(".checkchild").parents('tr').addClass('selected');
	      }else{
	    	  $(".checkchild").parents('tr').removeClass('selected');
	      }
	});
   
	$('#euserListTable tbody').on( 'click', 'tr', function () {
	  if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true){
			$(this).toggleClass('selected');
	   } 
	  if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true){
			$(this).toggleClass('selected');
	   }
	  if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') != true){
			$(".checkall").prop("checked",false);
	  }
	  if($("input[class='checkchild']:checked").size()==$("input[class='checkchild']").size() && $("input[class='checkchild']").size()>0 ){//全选 
	        $(".checkall").prop("checked",true); 
	    }
	}); 
}

/* 关闭新增用户选择 */
function enodeUserCancle(){
	$('#modal-einfo').modal('hide');
}

/* 用户选择确认 */
function enodeUserOk(){
	var table=$('#euserListTable tbody');
	var id="";
	var name=""
	for(i=0;i<table.children('tr.selected').length;i++){
		var obj=table.children('tr.selected').eq(i);
		id+=obj.attr("data-id")+',';
		name+=obj.find('td').eq(2).html()+',';
	}
	$('#suppliedid-hidden').val(id.substring(0, id.length-1));
	$('#euseIds').val(name.substring(0, name.length-1));
	$('#modal-einfo').modal('hide');
}




</script>



</body>
</html>






