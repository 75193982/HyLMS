
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
			查询管理
			<small>
				<i class="icon-double-angle-right"></i>
				供应商驳运价格查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">供应商：</label>
		   <!-- <select id="supplier_search" class="form-box" onchange="getbrand(this,0);"></select> -->
		   <input id="fom_supplier" class="form-box" type="text" style="width: 150px" placeholder="请填写供应商名称"/>
		   <input id="fom_supplier_id" class="form-box" type="hidden" style="width: 240px" />
		 
			<label class="title">库&nbsp;&nbsp;&nbsp;区：</label>
			<select id="stockSearch" class="form-box" style="width: 150px"><option value="">请选择库区</option>	</select>
			<label class="title">品&nbsp;&nbsp;&nbsp;&nbsp;牌：</label>
			<select id="brandNameSearch" class="form-box" style="width: 150px"><option value="">请选择品牌</option>	</select>
		  <!-- <label class="title">品牌：</label>
		    <select id="brand_search" class="form-box">
		     <option value="-1">请先选择供应商</option>
		   </select> -->
		   <label class="title">车型：</label>
		   <input id="carTypeSearch" class="form-box" type="text" style="width: 150px" placeholder="请填写车型"/>
		</div>
		<div class="searchbox col-xs-12">
			<label class="title">始发地：</label>
		   <input id="startAddressSearch" class="form-box" type="text" style="width: 150px" placeholder="请填写始发地"/>
		   <label class="title">目的省：</label>
		   <input id="endProvinceSearch" class="form-box" type="text" style="width: 150px" placeholder="请填目的省"/>
		   <label class="title">目的地：</label>
		   <input id="endAddressSearch" class="form-box" type="text" style="width: 150px" placeholder="请填写目的地"/>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<!-- <a class="itemBtn" onclick="addPrice()">新增</a> -->
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>供应商</th>
					<th>库区</th>
					<th>品牌</th>
					<th>车型</th>
                    <th>始发地</th>
                    <th>目的省</th>
                    <th>目的地</th>
                    <th>公里数</th>
                    <th>价格(元)</th>
                    <!-- <th>操作</th> -->
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 新增价格设置-->
			<div class="modal fade" id="modal-add" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:6%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="refresh();">×</button>
						<h3 id="myModalLabel">新增价格信息</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>供应商：</label>
								     <select id="supplierName" class="form-control" onchange="getbrand(this,1);"></select>
								    </div>
								    <hr class="tree"></hr>
									<div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>库区：</label>
								     <input class="form-control" id="libName" type="text" placeholder="请输入库区"/>
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>品牌：</label>
								     <select id="brandName" class="form-control">
								       <option value="-1">请先选择品牌</option>
								     </select>
								    </div>
								     <hr class="tree"></hr>
								     <div class="add-item extra-item">
									     <label class="title">车型：</label>
									     <input class="form-control" id="carType" type="text" placeholder="请输入车型"/>
									 </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-item">
									     <label class="title"><span class="red">*</span>始发地：</label>
									     <input class="form-control" id="startAddress" type="text" placeholder="请输入始发地"/>
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item extra-item">
									     <label class="title"><span class="red">*</span>目的省：</label>
									     <input class="form-control" id="endProvince" type="text" placeholder="请输入目的省"/>
									 </div>
								    <hr class="tree"></hr>
								   <div class="add-item extra-item">
									     <label class="title"><span class="red">*</span>目的地：</label>
									     <input class="form-control" id="endAddress" type="text" placeholder="请输入目的地"/>
									 </div>
								    <hr class="tree"></hr>
								     <div class="add-item extra-item">
									     <label class="title">公里数：</label>
									     <input class="form-control" id="distance" type="text" placeholder="请输入公里数"/>
									 </div>
								   <hr class="tree"></hr>
								    <div class="add-item extra-item">
									     <label class="title"><span class="red">*</span>价格(元)：</label>
									     <input class="form-control" id="price" type="text" placeholder="请输入价格"/>
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
			<!-- 编辑价格设置 -->
			<div class="modal fade" id="modal-edit" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:6%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="updateCancle()">×</button>
						<h3>编辑价格信息</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>供应商：</label>
								     <select id="esupplierName" class="form-control"  onchange="getbrand(this,2);"></select>
								    </div>
								    <hr class="tree"></hr>
									<div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>库区：</label>
								     <input class="form-control" id="elibName" type="text" placeholder="请输入库区"/>
								     <input class="form-control" id="id-hidden" type="hidden"/>
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>品牌：</label>
								     <select id="ebrandName" class="form-control">
								       <option value="-1">请先选择供应商</option>
								     </select>
								    </div>
								     <hr class="tree"></hr>
								     <div class="add-item extra-item">
									     <label class="title">车型：</label>
									     <input class="form-control" id="ecarType" type="text" placeholder="请输入车型"/>
									 </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-item">
									     <label class="title"><span class="red">*</span>始发地：</label>
									     <input class="form-control" id="estartAddress" type="text" placeholder="请输入始发地"/>
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item extra-item">
									     <label class="title"><span class="red">*</span>目的省：</label>
									     <input class="form-control" id="eendProvince" type="text" placeholder="请输入目的省"/>
									 </div>
								    <hr class="tree"></hr>
								   <div class="add-item extra-item">
									     <label class="title"><span class="red">*</span>目的地：</label>
									     <input class="form-control" id="eendAddress" type="text" placeholder="请输入目的地"/>
									 </div>
								    <hr class="tree"></hr>
								     <div class="add-item extra-item">
									     <label class="title">公里数：</label>
									     <input class="form-control" id="edistance" type="text" placeholder="请输入公里数"/>
									 </div>
								   <hr class="tree"></hr>
								    <div class="add-item extra-item">
									     <label class="title"><span class="red">*</span>价格(元)：</label>
									     <input class="form-control" id="eprice" type="text" placeholder="请输入价格"/>
									 </div>
								    <hr class="tree"></hr>
									 <div class="add-item-btn dis-block" id="editBtn">
									    <a class="add-itemBtn btnOk" onclick="update()">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="updateCancle()">取消</a>
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
<script type="text/javascript">
jQuery.fn.selectSupplier = function(targetId) {
	var _seft = this;
	var targetId = $(targetId);
	this.keyup(function() {
		var value = _seft.val();
		
		$.ajax({
			type : 'POST',
			url : "${ctx}/basicSetting/transportPriceMng/getSupplierList",
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
			$('#fom_supplier_id').val('');
			targetId.hide();
			$('#brandNameSearch').html('<option value="">请选择品牌</option>');
			$('#stockSearch').html('<option value="">请选择库区</option>');
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
	$('#fom_supplier').val($(e).html());
	$('#fom_supplier_id').val($(e).attr('sid'));
	$('#selectItem').hide();
	var supplierId = $('#fom_supplier_id').val();
	if(supplierId != ''){
		$.ajax({
			type : 'GET',
			url : "${ctx}/basicSetting/transportPriceMng/getSupplierStockList/"+supplierId,
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.info(JSON.stringify(data.data));
					var html ='<option value="">请选择库区</option>';
					if(data.data!=null && data.data!=''){
		        		if(data.data.length>0){
		        			for(var i=0;i<data.data.length;i++){
		            			html +='<option value='+data.data[i]['stocks']+'>'+data.data[i]['stocks']+'</option>';
		            		}
		        		}
		        	}
		        	//$('#fom_supplier').html(html);
		        	$('#stockSearch').html(html);
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		});
		
		 $.ajax({
				type : 'POST',
				url : "${ctx}/basicSetting/carBrandMng/getAllBrandsForSupplier",
				contentType : "application/json;charset=UTF-8",
				data : JSON.stringify({supplierId : supplierId}),
				dataType : 'JSON',
				success : function(data) {
					if (data && data.code == 200) {
						//console.info(JSON.stringify(data.data));
						var html ='<option value="">请选择品牌</option>';
						if(data.data!=null && data.data!=''){
			        		if(data.data.length>0){
			        			for(var i=0;i<data.data.length;i++){
			            			html +='<option value='+data.data[i]['brandName']+'>'+data.data[i]['brandName']+'</option>';
			            		}
			        		}
			        	}
			        	//$('#fom_supplier').html(html);
			        	$('#brandNameSearch').html(html);
					} else {
						bootbox.alert(data.msg);
					}
				}
				
			});
		}
	
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
		 "sAjaxSource": "${ctx}/basicSetting/supplierBusinessPrice/getListData" , //获取数据的ajax方法的URL							 
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
		    {data: "supplierName","width":"20%"},
		    {data: "libName","width":"16%"},
		    {data: "brandName","width":"8%"},
		    {data: "carType","width":"10%"},
		    {data: "startAddress","width":"8%"},
		    {data: "endProvince","width":"8%"},
		    {data: "endAddress","width":"10%"},
		    {data: "distance","width":"8%"},
		    {data: "price","width":"7%"}
		    ],
		    columnDefs: [
		      	
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
		 "sAjaxSource": "${ctx}/basicSetting/supplierBusinessPrice/getListData" , //获取数据的ajax方法的URL	
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
						    {data: "supplierName","width":"20%"},
						    {data: "libName","width":"16%"},
						    {data: "brandName","width":"8%"},
						    {data: "carType","width":"10%"},
						    {data: "startAddress","width":"8%"},
						    {data: "endProvince","width":"8%"},
						    {data: "endAddress","width":"10%"},
						    {data: "distance","width":"8%"},
						    {data: "price","width":"7%"}
						    ],
						    columnDefs: [
						      	
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	getSupplier();
	$("#fom_supplier").selectSupplier("#selectItem");
})

/* 获取供应商，联动品牌 */
function getSupplier(){
	$.ajax({
		type : 'POST',
		url : "${ctx}/basicSetting/carBrandMng/getSupplierList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var html ='<option value="-1">请选择供应商</option>';
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){	            			
	            			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	            		}
	        		}
	        	}
				//$('#supplier_search').html(html);
				$('#supplierName').html(html);
				$('#esupplierName').html(html);
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
}
function getbrand(e,index){
	var id=$(e).val();
	if(id=='-1'){
		var htmlEm ='<option value="-1">请先选择品牌</option>';
		if(index=='0'){
			//$('#brand_search').html(htmlEm);
		}else if(index=='1'){
			$('#brandName').html(htmlEm);
		}else{
			$('#ebrandName').html(htmlEm);
		}
		
	}else{
		$.ajax({
			type : 'POST',
			url : "${ctx}/basicSetting/carBrandMng/getAllBrandsForSupplier",
			data :JSON.stringify({supplierId:id}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					var html ='<option value="-1">请选择品牌</option>';
					if(data.data!=null && data.data!=''){
		        		if(data.data.length>0){
		        			for(var i=0;i<data.data.length;i++){	            			
		            			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['brandName']+'</option>';
		            		}
		        		}
		        	}
					if(index=='0'){
						//$('#brand_search').html(html);
					}else if(index=='1'){
						$('#brandName').html(html);
					}else{
						$('#ebrandName').html(html);
					}
					
		        	
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		});
	}
	
}
function getbrandForSupplier(id,brandId){
	if(id=='-1'){
		var htmlEm ='<option value="-1">请先选择供应商</option>';
		$('#ebrandName').html(htmlEm);
		$('#ebrandName').val('-1');
	}else{
		$.ajax({
			type : 'POST',
			url : "${ctx}/basicSetting/carBrandMng/getAllBrandsForSupplier",
			data :JSON.stringify({supplierId:id}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					var html ='<option value="-1">请选择品牌</option>';
					if(data.data!=null && data.data!=''){
		        		if(data.data.length>0){
		        			for(var i=0;i<data.data.length;i++){	            			
		            			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['brandName']+'</option>';
		            		}
		        		}
		        	}
					$('#ebrandName').html(html);
					$('#ebrandName').val(brandId);
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		});
	}
}
/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var supplierId=$('#fom_supplier_id').val();
	   var libName = $('#stockSearch').val();
	   var brandName=$('#brandNameSearch').val();
	   var carType = $('#carTypeSearch').val();
	   var startAddress = $('#startAddressSearch').val();
	   var endProvince = $('#endProvinceSearch').val();
	   var endAddress = $('#endAddressSearch').val();
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   $('#secho').val(secho);
	   if(supplierId=='-1'){
		   supplierId='';
	   }
	   
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				supplierId : supplierId,
				libName : libName,
				brandName : brandName,
				carType : carType,
				startAddress : startAddress,
				endProvince : endProvince,
				endAddress : endAddress
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
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该价格信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/basicSetting/supplierBusinessPrice/delete/"+id,
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
	$('#libName').val('');
	$('#startAddress').val('');
	$('#endProvince').val('');
	$('#endAddress').val('');
	$('#price').val('');
	$('#distance').val('');
	$('#carType').val('');
	$('#supplierName').val('-1');
	$('#brandName').val('-1');
}
/* 保存新增价格信息 */
function save(){
	var flag="false";
	var libName=$('#libName').val();
	var startAddress=$('#startAddress').val();
	var id="";
	var endProvince=$('#endProvince').val();
	var endAddress=$('#endAddress').val();
	var price=$('#price').val();
	var distance=$('#distance').val();
	var carType=$('#carType').val();
	var supplierId=$('#supplierName').val();
	var businessId=$('#brandName').val();
	if(supplierId=='-1'){
		bootbox.alert('供应商不能为空！');
		return;
	}
	if(businessId=='-1'){
		bootbox.alert('品牌不能为空！');
		return;
	}
	if(libName==''){
		bootbox.alert('库区不能为空！');
		return;
	}
	if(startAddress==''){
		bootbox.alert('始发地不能为空！');
		return;
	}
	if(endProvince==''){
		bootbox.alert('目的省不能为空！');
		return;
	}
	if(endAddress==''){
		bootbox.alert('目的地不能为空！');
		return;
	}
	if(price==''){
		bootbox.alert('价格不能为空！');
		return;
	}
	/* if(distance==''){
		bootbox.alert('公里数不能为空！');
		return;
	}
	if(carType==''){
		bootbox.alert('车型不能为空！');
		return;
	} */
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该价格信息吗?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/supplierBusinessPrice/save',
						data : JSON.stringify({
							id : '',
							supplierId :supplierId,
							businessId :businessId,
							libName : libName,
							startAddress : startAddress,
							endProvince : endProvince,
							endAddress : endAddress,
							price : price,
							distance : distance,
							carType : carType
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
function doedit(id){
	$('#id-hidden').val(id);
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/supplierBusinessPrice/getDetailData/"+id,
		data :{},
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				if(data.data.supplierId!=null && data.data.supplierId!=''){
					$('#esupplierName').val(data.data.supplierId);
				}else{
					$('#esupplierName').val('-1');
				}
				if(data.data.businessId!=null && data.data.businessId!=''){
					getbrandForSupplier(data.data.supplierId,data.data.businessId);
				}else{
					$('#ebrandName').val('-1');
				}
				$('#elibName').val(data.data.libName);
				$('#estartAddress').val(data.data.startAddress);
				$('#eendProvince').val(data.data.endProvince);
				$('#eendAddress').val(data.data.endAddress);
				$('#eprice').val(data.data.price);
				$('#edistance').val(data.data.distance);
				$('#ecarType').val(data.data.carType);
				$('#modal-edit').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
/* 关闭窗体 */
function updateCancle(){
	$('#modal-edit').modal('hide');
	
}
/* 更新 */
function update(){
	var id=$('#id-hidden').val();
	var flag="false";
	var libName=$('#elibName').val();
	var startAddress=$('#estartAddress').val();
	var endProvince=$('#eendProvince').val();
	var endAddress=$('#eendAddress').val();
	var price=$('#eprice').val();
	var distance=$('#edistance').val();
	var carType=$('#ecarType').val();
	var supplierId=$('#esupplierName').val();
	var businessId=$('#ebrandName').val();
	if(supplierId=='-1'){
		bootbox.alert('供应商不能为空！');
		return;
	}
	if(businessId=='-1'){
		bootbox.alert('品牌不能为空！');
		return;
	}
	if(libName==''){
		bootbox.alert('库区不能为空！');
		return;
	}
	if(startAddress==''){
		bootbox.alert('始发地不能为空！');
		return;
	}
	if(endProvince==''){
		bootbox.alert('目的省不能为空！');
		return;
	}
	if(endAddress==''){
		bootbox.alert('目的地不能为空！');
		return;
	}
	if(price==''){
		bootbox.alert('价格不能为空！');
		return;
	}
	/* if(distance==''){
		bootbox.alert('公里数不能为空！');
		return;
	}
	if(carType==''){
		bootbox.alert('车型不能为空！');
		return;
	} */
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该价格信息吗?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/supplierBusinessPrice/save',
						data : JSON.stringify({
							id : id,
							supplierId : supplierId,
							businessId : businessId,
							libName : libName,
							startAddress : startAddress,
							endProvince : endProvince,
							endAddress : endAddress,
							price : price,
							distance : distance,
							carType : carType
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






