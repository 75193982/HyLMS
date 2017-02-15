
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/datetimepicker.css" />
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
				商品车库存管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">类型：</label>
		   <select id="search-type" class="form-box">
		     <option value="-1">请选择类型</option>
		     <option value="0">商品车</option>
		     <option value="1">二手车</option>
		   </select>
		   <label class="title">品牌：</label>
		    <select id="search-brand" class="form-box">
		    </select>
		    <label class="title">状态：</label>
		    <select id="search-status" class="form-box">
		     <option value="-1">请选择状态</option>
		     <option value="0">新建</option>
		     <option value="1">已入库</option>
		     <option value="2">已出库</option>
		    </select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="addInfo()">新增</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>类型</th>
					<th>运单编号</th>
                    <th>供应商名称</th>
                    <th>品牌</th>
                    <th>车架号</th>
                    <th>车型</th>
                    <th>颜色</th>
                    <th>发动机号</th>
                    <th>备注</th>
                    <th>状态</th>
                    <th>创建时间</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 新增商品车 -->
			<div class="modal fade modal_car" id="modal-add" tabindex="-1" role="dialog"  data-backdrop="static">
				<div class="modal-dialog" style="padding:0;margin:auto;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
					  <button class="close" type="button" data-dismiss="modal">×</button>
					  <h3 id="myModalLabel">入库登记</h3>
				     </div>
					<div class="modal-body" style="padding:5px 20px;">
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							  <div class="widget-main">
								<div class="add-item extra-item">
							     <label class="title"><span class="red">*</span>类型：</label>
							     <select class="form-control" id="type">
							      <option value="0" selected="selected">商品车</option>
							      <option value="1">二手车</option>
								</select>
							    </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>车架号：</label>
								     <input class="form-control" id="vin" type="text" placeholder="请输入车架号"/>
								     <input class="form-control" id="id-hidden" type="hidden"/>
								  </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>品牌：</label>
								     <select class="form-control" id="brand" onChange="changebrand(this);">
								     </select>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>车型：</label>
								      <select class="form-control" id="model">
								        <option value="-1">请选择车型</option>
								     </select>
								    <!--  <input class="form-control" id="model" type="text" placeholder="请输入车型"/> -->
								  </div>
								 <div id="pricediv">
								 	<hr class="tree"></hr>
								  	<div class="add-item extra-item">
									     <label class="title"><span class="red">*</span>运输价格：</label>
									     <input class="form-control" id="price" type="text" placeholder="请输入运输价格"/>
								 	</div>
								 </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-item">
									     <label class="title">颜色：</label>
									     <input class="form-control" id="color" type="text" placeholder="请输入颜色"/>
								 </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
									     <label class="title">发动机号：</label>
									     <input class="form-control" id="engineNo" type="text" placeholder="请输入发动机号"/>
								 </div>
								
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
							     <label class="title">运单编号：</label>
							     <select class="form-control" id="waybillId">
								 </select>
							    </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item" style="position:relative">
								     <label class="title">入库时间：</label>
								     <div class="input-group input-group-sm col-xs-5">
									<input class="form-control" id="storageTime" type="text" placeholder="请输入入库时间"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>									
								</div>
								<div class="col-xs-5"> <p class="title"><input type="checkbox" name="after_flag" id="after_flag" value="Y" onclick="dochecked(this)"/>补入库</p>
								 <input type="hidden" name="afterFlag" id="afterFlag" />	</div>
							    </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title">备注：</label>
								     <input class="form-control" id="remark" type="text" placeholder="请输入备注"/>
								 </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-item">
									     <label class="title">停车位置：</label>
									     <input class="form-control" id="position" type="text" placeholder="停车位置"/>
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
			<!-- 查看商品车 -->
			<div class="modal fade modal_car" id="modal-show" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:0;margin:0;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">查看入库信息</h3>
				</div>
				<div class="modal-body" style="padding:5px 20px;">
					  <div class="widget-box dia-widget-box">
						<div class="widget-body">
						  <div class="widget-main">
							<div class="add-item show-item">
						     <label class="title"><span class="red">*</span>类型：</label>
						     <p id="s-type"></p>
						    </div>
							 <hr class="tree"></hr>	
							 <div class="add-item show-item">
							     <label class="title"><span class="red">*</span>车架号：</label>
							     <p id="s-vin"></p>
							     <input class="form-control" id="s-id-hidden" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item show-item">
							     <label class="title"><span class="red">*</span>品牌：</label>
							     <p id="s-brand"></p>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item show-item">
							     <label class="title"><span class="red">*</span>车型：</label>
							     <p id="s-model"></p>
							  </div>
							  <div id="s_pricediv">
								 	<hr class="tree"></hr>
								  	<div class="add-item show-item">
									     <label class="title" style="width: 85px;"><span class="red">*</span>运输价格：</label>
									     <p id="s_price"></p>
								 	</div>
								 </div>
							  <hr class="tree"></hr>
							  <div class="add-item show-item">
							     <label class="title">颜色：</label>
							     <p id="s-color"></p>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item show-item">
							     <label class="title">发动机号：</label>
							     <p id="s-engineNo"></p>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item show-item">
						        <label class="title">运单编号：</label>
						        <p id="s-waybillId"></p>
						    </div>
							 <hr class="tree"></hr>
							 <div class="add-item show-item">
								     <label class="title">入库时间：</label>
								     <p id="s-storageTime"></p>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item show-item">
							     <label class="title">备注：</label>
							     <p id="s-remark"></p>
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item show-item">
								     <label class="title">停车位置：</label>
								     <p id="s-position"></p>
							 </div>
							</div>
						  </div>
					</div>
				</div>
				  </div>
				</div>
			</div>
			<!-- 编辑商品车 -->
			<div class="modal fade modal_car" id="modal-edit" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding:0;margin:0;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">编辑入库信息</h3>
				</div>
				<div class="modal-body" style="padding:5px 20px;">
				    <div>
					  <div class="widget-box dia-widget-box">
						<div class="widget-body">
						     <div class="widget-main">
							<div class="add-item extra-item">
						     <label class="title"><span class="red">*</span>类型：</label>
						     <select class="form-control" id="e-type">
						      <option value="0" selected="selected">商品车</option>
						      <option value="1">二手车</option>
							</select>
						    </div>
							 <hr class="tree"></hr>	
							 <div class="add-item extra-item">
							     <label class="title"><span class="red">*</span>车架号：</label>
							     <input class="form-control" id="e-vin" type="text" placeholder="请输入车架号"/>
							     <input class="form-control" id="e-id-hidden" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							   <div class="add-item extra-item">
							     <label class="title"><span class="red">*</span>品牌：</label>
							     <select class="form-control" id="e-brand" onChange="changebrand(this);">
							     </select>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-item">
							     <label class="title"><span class="red">*</span>车型：</label>
							     <select class="form-control" id="e-model">
							       <option value="-1">请选择车型</option>
							     </select>
							     <!-- <input class="form-control" id="e-model" type="text" placeholder="请输入车型"/> -->
							  </div>
							  <div id="e_pricediv">
								 	<hr class="tree"></hr>
								  	<div class="add-item extra-item">
									     <label class="title"><span class="red">*</span>运输价格：</label>
									     <input class="form-control" id="e_price" type="text" placeholder="请输入运输价格"/>
								 	</div>
								 </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-item">
								     <label class="title">颜色：</label>
								     <input class="form-control" id="e-color" type="text" placeholder="请输入颜色"/>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item extra-item">
								     <label class="title">发动机号：</label>
								     <input class="form-control" id="e-engineNo" type="text" placeholder="请输入发动机号"/>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item extra-item">
						     <label class="title">运单编号：</label>
						     <select class="form-control" id="e-waybillId">
							 </select>
						    </div>
							 <hr class="tree"></hr>
							 <div class="add-item extra-item" style="position:relative">
								     <label class="title">入库时间：</label>
								     <div class="input-group input-group-sm col-xs-5">
									<input class="form-control" id="e-storageTime" type="text" placeholder="请输入入库时间"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>									
								</div>
								<div class="col-xs-5"> <p class="title"><input type="checkbox" name="e-after_flag" id="e-after_flag" value="Y" onclick="dochecked(this)"/>补入库</p>
								 <input type="hidden" name="e-afterFlag" id="e-afterFlag" />	</div>
							    </div>
							 <hr class="tree"></hr>
							 <div class="add-item extra-item">
							     <label class="title">备注：</label>
							     <input class="form-control" id="e-remark" type="text" placeholder="请输入备注"/>
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-item">
								     <label class="title">停车位置：</label>
								     <input class="form-control" id="e-position" type="text" placeholder="停车位置"/>
							 </div>
							  <hr class="tree"></hr>
								 
							 <div class="add-item-btn dis-block" id="editBtn">
								    <a class="add-itemBtn btnOk" onclick="update()">保存</a>
								    <a class="add-itemBtn btnCancle" onclick="updataCancle()">取消</a>
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
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="${ctx}/staticPublic/js/jsonDataFormat.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/car/carStockMange/getCarListData" , //获取数据的ajax方法的URL							 
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
				columns: [{ data: "rownum",'width':'5%'},
						    {data: "type",'width':'6%'},
						    {data: "waybillNo",'width':'10%'},
						    {data: "supplierName",'width':'9%'},
						    {data: "brand",'width':'6%'},
						    {data: "vin",'width':'9%'},
						    {data: "model",'width':'8%'},
						    {data: "color",'width':'6%'},
						    {data: "engineNo",'width':'7%'},
						    {data: "mark",'width':'9%'},
						    {data: "status",'width':'6%'},
						    {data: "insertTime",'width':'6%'},
						    {data: null,'width':'13%'}],
		    columnDefs: [
		      	{
		      		 //操作栏
			    	 targets: 1,
			    	 render: function (data, type, row, meta) {
		                   if(data=="1"){
		                	   return '二手车';
		                   }else{
		                	   return '商品车'; 
		                   }
		                }
		      	},
		      	{
		      		 //操作栏
			    	 targets: 4,
			    	 render: function (data, type, row, meta) {
		                   if(data=="-1"){
		                	   return '';
		                   }else{
		                	   return data; 
		                   }
		                }
		      	},
		      	{
		      		 //操作栏
			    	 targets: 10,
			    	 render: function (data, type, row, meta) {
		                   if(data=="0"){
		                	   return '新建';
		                   }else if(data=="1"){
		                	   return '已入库';
		                   }
		                   else if(data=="2"){
		                	   return '已出库';
		                   }
		                }
		      	},
		      	{
		      		 //创建时间
			    	 targets: 11,
			    	 render: function (data, type, row, meta) {
			    		 if(data==null || data==''|| parseInt(data)<0){
								return ''; 
							 }else{
								 return jsonDateFormat(data);
							 }
		                }
		      	},
		      	{
			    	 //操作栏
			    	 targets: 12,
			    	 render: function (data, type, row, meta) {
			    		 if(row.status=='0'){
			    			 return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
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
		 "sAjaxSource": "${ctx}/car/carStockMange/getCarListData" , //获取数据的ajax方法的URL	
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
				 columns: [{ data: "rownum",'width':'5%'},
						    {data: "type",'width':'6%'},
						    {data: "waybillNo",'width':'10%'},
						    {data: "supplierName",'width':'9%'},
						    {data: "brand",'width':'6%'},
						    {data: "vin",'width':'9%'},
						    {data: "model",'width':'8%'},
						    {data: "color",'width':'6%'},
						    {data: "engineNo",'width':'7%'},
						    {data: "mark",'width':'9%'},
						    {data: "status",'width':'6%'},
						    {data: "insertTime",'width':'6%'},
						    {data: null,'width':'13%'}],
						    columnDefs: [
						      	{
						      		 //操作栏
							    	 targets: 1,
							    	 render: function (data, type, row, meta) {
						                   if(data=="1"){
						                	   return '二手车';
						                   }else{
						                	   return '商品车'; 
						                   }
						                }
						      	},
						      	{
						      		 //操作栏
							    	 targets: 4,
							    	 render: function (data, type, row, meta) {
						                   if(data=="-1"){
						                	   return '';
						                   }else{
						                	   return data; 
						                   }
						                }
						      	},
						      	{
						      		 //操作栏
							    	 targets: 10,
							    	 render: function (data, type, row, meta) {
							    		 if(data=="0"){
						                	   return '新建';
						                   }else if(data=="1"){
						                	   return '已入库';
						                   }
						                   else if(data=="2"){
						                	   return '已出库';
						                   }
						                }
						      	},
						      	{
						      		 //创建时间
							    	 targets: 11,
							    	 render: function (data, type, row, meta) {
							    		 if(data==null || data==''|| parseInt(data)<0){
												return ''; 
											 }else{
												 return jsonDateFormat(data);
											 }
						                }
						      	},
						      	{
							    	 //操作栏
							    	 targets: 12,
							    	 render: function (data, type, row, meta) {
							    		 if(row.status=='0'){
							    			 return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
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
	init();
	getBrand();
	getBill();
})
  /* 初始强制赋值当前时间 */
  function bindTime(){
	  var date = new Date();
      var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
      var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
      var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
      var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
      var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
      var localTime= date.getFullYear() + "-" + month + "-" + day+" "+hours+":"+minutes;
	  $('#storageTime').val(localTime);
  }
  
/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var type=$("#search-type").find("option:selected").val(); 
	   var status=$("#search-status").find("option:selected").val();
	   var brand=$("#search-brand").find('option:selected').html();
	   if(type=="-1"){
		   type='';
	   }
	   if(status=='-1'){
		   status='';
	   }
	   if(brand=='请选择品牌'){
		   brand='';
	   }
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				brand : brand,
				type :type,
				status :status
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
	getBill();
}
/* 绑定品牌 */
function getBrand(){
/* 	$.ajax({  
        url: '${ctx}/car/carStockMange/queryCarBrand',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: '',
        success: function (data) {
        	var html ='<option value="-1">请选择品牌</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['brandName']+'</option>';
                		}
            		}
            	}
            	$('#search-brand').html(html);
            	$('#brand').html(html);
            	$('#e-brand').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      });  */
	$.ajax({
		type : 'POST',
		url : "${ctx}/basicSetting/carBrandMng/getBrandList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));	
				var html ='<option value="-1" data-carType="">请选择品牌</option>';
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){	            			
	            			html +='<option value='+data.data[i]['brandName']+' data-carType='+data.data[i]['carType']+'>'+data.data[i]['brandName']+'</option>';
	            		}
	        		}
	        	}
				$('#search-brand').html(html);
            	$('#brand').html(html);
            	 $('#e-brand').html(html); 
	        	
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});	
}
/* 绑定运单 */
function getBill(){
	$.ajax({  
        url: '${ctx}/car/carStockMange/queryWaybill',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: {},
        success: function (data) {
        	var html ='<option value="-1">请选择运单</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['waybillNo']+'</option>';
                		}
            		}
            	}
            	$('#waybillId').html(html);
            	$('#e-waybillId').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}

/* 删除人员 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该商品车信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/car/carStockMange/deleteCarStock/"+id,
						data :{
							id :id
						},
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
	
/*新增商品车入库  */
function addInfo(){
	clear();
	$('#modal-add').modal('show');
	$('#pricediv').hide();
	$('#type').change(function(){
		//alert($(this).children('option:selected').val()); 
		var type=$(this).children('option:selected').val();
		if(type=='1'){
			 $("#pricediv").show();
		}
		else
		{
			$("#pricediv").hide();
		}
	})
	/*  $("#storageTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	}); */
	 $("#storageTime").datetimepicker({
		language: 'cn',
	      format: "yyyy-mm-dd hh:ii",
	      autoclose: true,//选中之后自动隐藏日期选择框
	      todayBtn: true
	}); 
	$('#after_flag').prop('checked', true);
	bindTime();
	getBill();
}
/* 关闭窗体 */
function refresh(){
	clear();
	$('#modal-add').modal('hide');
}
function updataCancle(){
	clearedit();
	$('#modal-edit').modal('hide');
}
/* 数据重置 */
function clear(){
	$('#id-hidden').val('');
	$('#vin').val('');
	//$('#model').val('-1');
	$('#brand').find("option[value='-1']").attr("selected",true);
	$('#model').find("option[value='-1']").attr("selected",true);
	$('#color').val('');
	$('#engineNo').val('');
	$('#remark').val('');
	$('#position').val('');
	$('#waybillId').find("option[value='-1']").attr("selected",true);
	$('#type').find("option[value='0']").attr("selected",true);
	$('#after_flag').prop('checked', true);
	$('#storageTime').val('');
	
}
function clearedit(){
	$('#e-id-hidden').val('');
	$('#e-vin').val('');
	$('#e-model').val('-1');
	$('#e-brand').find("option[value='-1']").attr("selected",true);
	$('#e-color').val('');
	$('#e-engineNo').val('');
	$('#e-remark').val('');
	$('#e-position').val('');
	$('#e-waybillId').find("option[value='-1']").attr("selected",true);
	$('#e-type').find("option[value='0']").attr("selected",true);
	$('#e-after_flag').prop('checked', true);
	$('#e-storageTime').val('');
}
/* 保存新增人员信息 */
function save(){
	var flag="false";
	var type=$('#type').val();
	var waybillId=$('#waybillId').val();
	var brand=$('#brand').find('option:selected').html();
	var vin=$('#vin').val();
	var model=$('#model').val();
	var price = $('#price').val();//运输价格
	var color=$('#color').val();
	var engineNo=$('#engineNo').val();
	var mark=$('#remark').val();
	var position=$('#position').val();
	var storageTime='';
	var afterFlag='';
	if(vin==''|| vin==null){
		bootbox.alert('车架号不能为空！');
		return;
	}
	if(brand=='-1'|| brand==null || brand=='请选择品牌'){
		bootbox.alert('请选择品牌！');
		return;
	}
	if(type == '1')
	{
		if(price==''|| price==null || price=='请输入运输价格'){
			bootbox.alert('请输入运输价格！');
			return;
		}
	}
	
	if(waybillId==''|| waybillId==null || waybillId=='-1'){
		waybillId="";
	}
	if(model==''|| model==null || model=='-1'){
		bootbox.alert('车型不能为空！');
		return;
	}
	if($('#after_flag').prop("checked")){
		storageTime=$('#storageTime').val();		
		afterFlag='Y';
	}else{
		afterFlag='N';
	}
	if(storageTime!=''&&storageTime!=null){
		storageTime = new Date(storageTime);
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该车信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/car/carStockMange/carStockIn',
						data : JSON.stringify({
							type :type,
							waybillId :waybillId,  
							brand :brand,
							vin :vin,
							color :color,
							model :model,
							transportPrice:price,
							engineNo :engineNo,
							position :position,
							mark :mark,
							storageTime : storageTime,
							afterFlag : afterFlag
						
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
										 reload();
										 $('#modal-add').modal('hide');
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
/* 查看商品车信息 */
function doshow(id){
	$.ajax({
		type : 'GET',
		url : "${ctx}/car/carStockMange/queryCarStock/"+id,
		data :JSON.stringify({
			id :id
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				console.info(JSON.stringify(data.data));
				$('#s-id-hidden').html(id);
				$('#s-vin').html(data.data.vin);
				$('#s-remark').html(data.data.mark);
				$('#s-waybillId').html(data.data.waybillNo);
				if(data.data.type=='0'){
					$('#s-type').html('商品车');
					$('#s_pricediv').hide();
					$('#s_price').val("");
				}else{
					$('#s-type').html('二手车');
					$('#s_pricediv').show();
					//alert(data.data.transportPrice);
					$('#s_price').html(data.data.transportPrice);
				}
				
				$('#s-model').html(data.data.model);
				$('#s-brand').html(data.data.brand);
				$('#s-color').html(data.data.color);
				$('#s-engineNo').html(data.data.engineNo);
				$('#s-position').html(data.data.position);
				if(data.data.storageTime!=''&&data.data.storageTime!=null){
					$('#s-storageTime').html(jsonForDateMinutFormat(data.data.storageTime));	
				}				
				$('#s-addBtn').hide();
				$('#modal-show').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 

}
/* 编辑商品车信息 */
function doedit(id){
	/* clearedit(); */
	/* $("#e-storageTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	}); */
	
	$("#e-storageTime").datetimepicker({
		language: 'cn',
	      format: "yyyy-mm-dd hh:ii",
	      autoclose: true,//选中之后自动隐藏日期选择框
	      todayBtn: true
	});
	$.ajax({
		type : 'GET',
		url : "${ctx}/car/carStockMange/queryCarStock/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#e-id-hidden').val(id);
				$('#e-vin').val(data.data.vin);
				$('#e-remark').val(data.data.mark);
				if(data.data.waybillId==null){
					$('#e-waybillId').val('-1');
				}else{
					$('#e-waybillId').val(data.data.waybillId);
				}
				
				/* $('#e-waybillId').find("option[value="+data.data.waybillId+"]").attr("selected",true); */
				$('#e-type').val(data.data.type);
				//$('#e-model').val(data.data.model);
				$('#e-type').change(function(){
					var type=$(this).children('option:selected').val();
					if(type=='1'){
			 			$("#e_pricediv").show();
					}
					else
					{
						$("#e_pricediv").hide();
					}
				});
				if(data.data.type == '1')
				{
					$('#e_pricediv').show();
					$('#e_price').val(data.data.transportPrice);
				}
				else
				{
					$('#e_pricediv').hide();
					$('#e_price').val("");
				}
				if(data.data.brand==null || data.data.brand==''){
					$("#e-brand").val('-1');
				}else{
					bindbrands(data.data.brand,data.data.model);
					//$("#e-brand option:contains('"+data.data.brand+"')").attr("selected",true);					
				}
				$('#e-color').val(data.data.color);
				$('#e-engineNo').val(data.data.engineNo);
				$('#e-position').val(data.data.position);
				$('#modal-edit').modal('show');
				if(data.data.afterFlag=='Y'){
					$('#e-after_flag').prop('checked', true);
					if(data.data.storageTime!=''&&data.data.storageTime!=null){
						$('#e-storageTime').val(jsonForDateMinutFormat(data.data.storageTime));
					}
				
				}else{
					$('#e-after_flag').prop('checked', false);
					if(data.data.storageTime!=''&&data.data.storageTime!=null){
						$('#e-storageTime').val(jsonForDateMinutFormat(data.data.storageTime));
					}
				}
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
/* 编辑保存 */
function update(){
	var flag="false";
	var id=$('#e-id-hidden').val();
	var type=$('#e-type').val();
	var waybillId=$('#e-waybillId').val();
	var brand=$('#e-brand').find('option:selected').html();
	var vin=$('#e-vin').val();
	var model=$('#e-model').val();
	var price = $('#e_price').val();//运输价格
	var color=$('#e-color').val();
	var engineNo=$('#e-engineNo').val();
	var mark=$('#e-remark').val();
	var position=$('#e-position').val();
	var storageTime='';
	var afterFlag='';
	if(brand==''|| brand==null || brand=='请选择品牌'){
		bootbox.alert('请选择品牌！');
		return;
	}
	if(waybillId==''|| waybillId==null || waybillId=='-1'){
		waybillId="";
	}
	if(model==''|| model==null || model=='-1'){
		bootbox.alert('车型不能为空！');
		return;
	}
	if(vin==''|| vin==null){
		bootbox.alert('车架号不能为空！');
		return;
	}
	if(type == '1')
	{
		if(price==''|| price==null || price=='请输入运输价格'){
			bootbox.alert('请输入运输价格！');
			return;
		}
	}
	if($('#e-after_flag').prop("checked")){
		storageTime=$('#e-storageTime').val();
		afterFlag='Y';
	}else{
		afterFlag='N';
	}
	if(storageTime!=''&&storageTime!=null){
		storageTime = new Date(storageTime);
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要编辑该车信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/car/carStockMange/editCarStock",
						data :JSON.stringify({
							id :id,
							type :type,
							waybillId :waybillId,  
							brand :brand,
							vin :vin,
							color :color,
							model :model,
							transportPrice :price,
							engineNo :engineNo,
							position :position,
							mark :mark,
							storageTime : storageTime,
							afterFlag : afterFlag
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
										  $('#modal-edit').modal('hide');
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
/*品牌绑定车型*/
function changebrand(e){
	var brand=$(e).val();
	var carType=$(e).find('option:selected').attr('data-carType');
	var carTypeList="";
	var html='<option value="">请选择车型</option>';
	if(carType!=''){
		if(carType.indexOf("|")>0){
			carTypeList=carType.split("|");
			for(var i=0;i<carTypeList.length;i++){	            			
    			html +='<option value='+carTypeList[i]+'>'+carTypeList[i]+'</option>';
    		}
		}else{
			html +='<option value='+carType+'>'+carType+'</option>';
		}
	}
	$('#model').html(html);
	$('#e-model').html(html);
}

function bindbrands(brands,type){
	 var carType="";
	$.ajax({
		type : 'POST',
		url : "${ctx}/basicSetting/carBrandMng/getBrandList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));	
				var html ='<option value="-1" data-carType="">请选择品牌</option>';
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	        				html +='<option value='+data.data[i]['brandName']+' data-carType='+data.data[i]['carType']+'>'+data.data[i]['brandName']+'</option>';	  
	        				if(data.data[i]['brandName']==brands){
	        					carType=data.data[i]['carType'];
	        				}
	            		}
	        		}
	        	}
	        	$('#e-brand').html(html);
	        	$("#e-brand option:contains('"+brands+"')").attr("selected",true);
  			      var carTypeList="";
  					var html='<option value="-1">请选择车型</option>';
  					if(carType!='' && carType!=""){
  						if(carType.indexOf("|")>0){
  							carTypeList=carType.split("|");
  							for(var j=0;j<carTypeList.length;j++){	            			
  			        			html +='<option value='+carTypeList[j]+'>'+carTypeList[j]+'</option>';
  			        		}
  						}else{
  							html +='<option value='+carType+'>'+carType+'</option>';
  						}
  					}
  					$('#e-model').html(html);
  					$("#e-model option[value='"+type+"']").attr("selected",true);
	        	
			} else {
				bootbox.alert(data.msg);
			}
		}		
	});

}
function dochecked(e){
	/* console.info($(e).prop("checked")); */
	 if($(e).prop("checked")){
		 $("#storageTime").attr("disabled",false); 
		 $("#e-storageTime").attr("disabled",false);  
		 
	 }else{
		 $('#storageTime').val('');
		 $("#storageTime").attr("disabled",true); 
		 $("#e-storageTime").attr("disabled",true); 
	 }
	 
}
</script>



</body>
</html>






