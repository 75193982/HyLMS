<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>折损车库存管理</title>
	<link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" /><!--字体icon-->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
		<script src="${ctx}/staticPublic/js/ace-extra.min.js"></script>
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			查询管理
			<small>
				<i class="icon-double-angle-right"></i>
				折损库存管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">品牌：</label>
		   <!--  <select id="search-brand" class="form-box"> </select>-->
		   <input id="search-brand" class="form-box" type="text" placeholder="请输入品牌" />
		    <label class="title">状态：</label>
		    <select id="search-status" class="form-box">
		     <option value="">请选择状态</option>
		     <option value="0">新建</option>
		     <option value="1">已入库</option>
		     <option value="2">已出库</option>
		    </select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<!-- <a class="itemBtn" onclick="addInfo()">新增</a> -->
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
                    <th>品牌</th>
                    <th>车架号</th>
                    <th>车型</th>
                    <th>颜色</th>
                    <th>发动机号</th>
                    <th>备注</th>
                    <th>状态</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 新增折损车 -->
			<div class="modal fade" id="modal-add" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
					  <button class="close" type="button" data-dismiss="modal">×</button>
					  <h3 id="myModalLabel">入库登记</h3>
				     </div>
				<div class="modal-body" style="padding:5px 20px;">
					  <div class="widget-box dia-widget-box">
						<div class="widget-body">
						  <div class="widget-main">
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>车架号：</label>
							     <input class="form-control" id="vin" type="text" placeholder="请输入车架号"/>
							     <input class="form-control" id="id-hidden" type="hidden"/>
							  </div>
							   <hr class="tree"></hr>
							   <div class="add-item extra-itemSec">
							     <label class="title">品牌：</label>
							     <select class="form-control" id="brand" onChange="changebrand(this);">
							     </select> 
							     <!-- <input class="form-control" type="text" id="brand" placeholder="请输入品牌"/> -->
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">车型：</label>
							     <select class="form-control" id="model">
							     </select> 
							     <!-- <input class="form-control" id="model" type="text" placeholder="请输入车型"/> -->
							  </div>
							 
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
								     <label class="title">颜色：</label>
								     <input class="form-control" id="color" type="text" placeholder="请输入颜色"/>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
								     <label class="title">发动机号：</label>
								     <input class="form-control" id="engineNo" type="text" placeholder="请输入发动机号"/>
							 </div>
							 <hr class="tree"></hr>
							 <!-- <div class="add-item">
						     <label class="title"><span class="red">*</span>入库单号：</label>
						     <select class="form-control" id="waybillId">
							 </select>
						    </div> 
						    <hr class="tree"></hr>-->
							 
							 <div class="add-item extra-itemSec">
							     <label class="title">备注：</label>
							     <input class="form-control" id="remark" type="text" placeholder="请输入备注"/>
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
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
			<div class="modal fade" id="modal-show" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">查看入库信息</h3>
				</div>
				<div class="modal-body" style="padding:5px 20px;">
					  <div class="widget-box dia-widget-box">
						<div class="widget-body">
						  <div class="widget-main">
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>车架号：</label>
							     <input class="form-control" id="s-vin" type="text" readonly='readonly' placeholder="请输入车架号"/> 
							     <input class="form-control" id="s-id-hidden"  type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">车型：</label>
							     <input class="form-control" id="s-model" type="text" readonly='readonly' placeholder="请输入车型"/>
							  </div>
							  <hr class="tree"></hr>
							   <div class="add-item extra-itemSec">
							     <label class="title">品牌：</label>
							     <input class="form-control" id="s-brand" type="text" readonly='readonly' placeholder="请输入品牌"/>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
								     <label class="title">颜色：</label>
								     <input class="form-control" id="s-color" type="text" readonly='readonly' placeholder="请输入颜色"/>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
								     <label class="title">发动机号：</label>
								     <input class="form-control" id="s-engineNo" type="text" readonly='readonly' placeholder="请输入发动机号"/>
							 </div>
							 <hr class="tree"></hr>
							 <!-- <div class="add-item">
						     <label class="title"><span class="red">*</span>入库单号：</label>
						     <select class="form-control" id="s-waybillId" disabled='disabled'>
							 </select>
						    </div>
							 <hr class="tree"></hr> -->
							 <div class="add-item extra-itemSec">
							     <label class="title">备注：</label>
							     <input class="form-control" id="s-remark" type="text" readonly='readonly' placeholder="请输入备注"/>
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
								     <label class="title">停车位置：</label>
								     <input class="form-control" id="s-position" type="text" readonly='readonly' placeholder="停车位置"/>
							 </div>
							</div>
						  </div>
					</div>
				</div>
				  </div>
				</div>
			</div>
			<!-- 编辑商品车 -->
			<div class="modal fade" id="modal-edit" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">编辑入库信息</h3>
				</div>
				<div class="modal-body" style="padding:5px 20px;">
					  <div class="widget-box dia-widget-box">
						<div class="widget-body">
						  <div class="widget-main">
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>车架号：</label>
							     <input class="form-control" id="e-vin" type="text" placeholder="请输入车架号"/>
							     <input class="form-control" id="e-id-hidden" type="hidden"/>
							  </div>
							   <hr class="tree"></hr>
							   <div class="add-item extra-itemSec">
							     <label class="title">品牌：</label>
							     <select class="form-control" id="e-brand" onChange="changebrand(this);">
							     </select> 
							     <!-- <input class="form-control" type="text" id="e-brand" placeholder="请输入品牌"/> -->
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">车型：</label>
							      <select class="form-control" id="e-model">
							     </select> 
							     <!-- <input class="form-control" id="e-model" type="text" placeholder="请输入车型"/> -->
							  </div>
							 
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
								     <label class="title">颜色：</label>
								     <input class="form-control" id="e-color" type="text" placeholder="请输入颜色"/>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
								     <label class="title">发动机号：</label>
								     <input class="form-control" id="e-engineNo" type="text" placeholder="请输入发动机号"/>
							 </div>
							 <hr class="tree"></hr>
							 <!-- <div class="add-item">
						     <label class="title"><span class="red">*</span>入库单号：</label>
						     <select class="form-control" id="e-waybillId">
							 </select>
						    </div>
							 <hr class="tree"></hr> -->
							 <div class="add-item extra-itemSec">
							     <label class="title">备注：</label>
							     <input class="form-control" id="e-remark" type="text" placeholder="请输入备注"/>
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
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

<!--[if !IE]> -->
		<script src="${ctx}/staticPublic/js/jquery-2.0.3.min.js"></script>
		<!-- <![endif]-->
		<!--[if IE]>
		<script src="${ctx}/staticPublic/js/jquery-1.10.2.min.js"></script>
		<![endif]-->
		<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
		<!-- page specific plugin scripts -->
		<script src="${ctx}/staticPublic/js/jquery.dataTables.js"></script>
		<script src="${ctx}/staticPublic/js/jquery.dataTables.bootstrap.js"></script>
		<!-- ace scripts -->
		<script src="${ctx}/staticPublic/js/ace-elements.min.js"></script>
		<script src="${ctx}/staticPublic/js/ace.min.js"></script>		
		<!-- inline scripts related to this page -->
		<script type="text/javascript" src="${ctx}/staticPublic/js/popbox/Confirm.js"></script>
        <script src="${ctx}/staticPublic/js/bootbox.min.js"></script>
        <script src="${ctx}/staticPublic/js/jsonDataFormat.js"></script>
        
<script type="text/javascript">	
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/carDamageMng/getAdminListData" , //获取数据的ajax方法的URL							 
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
				columns: [{ data: "rownum","width":"4%" },
						    {data: "brand","width":"10%"},
						    {data: "vin","width":"10%"},
						    {data: "model","width":"10%"},
						    {data: "color","width":"10%"},
						    {data: "engineNo","width":"10%"},
						    {data: "mark","width":"16%"},
						    {data: "status","width":"10%"}],
		    columnDefs: [
		      	
		      	{
		      		 //状态
			    	 targets: 7,
			    	 render: function (data, type, row, meta) {
		                   if(data=="0"){
		                	   return '新建';
		                   }else if(data=="1"){
		                	   return '已入库';
		                   }else if(data=="2"){
		                	   return '已出库';
		                   }
		                }
		      	}/* ,
		      	{
			    	 //操作栏
			    	 targets: 8,
			    	 render: function (data, type, row, meta) {
		                    return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>'
		                    	   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
						           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
		                }	       
		    	}  */
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
		 "sAjaxSource": "${ctx}/operationMng/carDamageMng/getListData" , //获取数据的ajax方法的URL	
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
				columns: [{ data: "rownum","width":"4%" },
						    {data: "brand","width":"10%"},
						    {data: "vin","width":"10%"},
						    {data: "model","width":"10%"},
						    {data: "color","width":"10%"},
						    {data: "engineNo","width":"10%"},
						    {data: "mark","width":"16%"},
						    {data: "status","width":"10%"}],
						    columnDefs: [
						      	
						      	{
						      		 //状态
							    	 targets: 7,
							    	 render: function (data, type, row, meta) {
							    		 if(data=="0"){
						                	   return '新建';
						                   }else if(data=="1"){
						                	   return '已入库';
						                   }else if(data=="2"){
						                	   return '已出库';
						                   }
						                }
						      	}/* ,
						      	{
							    	 //操作栏
							    	 targets: 8,
							    	 render: function (data, type, row, meta) {
							    		 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>'
				                    	   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
								           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
						                }	       
						    	}  */
						      ],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	getBrand();
	//getBill();
})

/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var status=$("#search-status").find("option:selected").val();
	   //var brand=$("#search-brand").find("option:selected").val();
	   var brand = $.trim($("#search-brand").val());
	   if(status=='-1'){
		   status=null;
	   }
	   /* if(brand=='-1'){
		   brand=null;
	   } */
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
				var html ='<option value="" data-carType="">请选择品牌</option>';
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){	            			
	            			html +='<option value='+data.data[i]['brandName']+' data-carType='+data.data[i]['carType']+'>'+data.data[i]['brandName']+'</option>';
	            		}
	        		}
	        	}
				/* $('#search-brand').html(html); */
            	$('#brand').html(html);           	
	        	
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});	
} 
/* 绑定入库单号 */
/* function getBill(){
	$.ajax({  
        url: '${ctx}/car/carStockMange/queryWaybill',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: '',
        success: function (data) {
        	var html ='<option value="-1">请选择入库单号</option>';
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
            	$('#s-waybillId').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
} */

/* 删除 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该折损车信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/carDamageMng/delete/"+id,
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
};
	
/*新增*/
function addInfo(){
	clear();
	$('#modal-add').modal('show');
}
/* 关闭窗体 */
function refresh(){
	clear();
	$('#modal-add').modal('hide');
}
function updataCancle(){
	$('#modal-edit').modal('hide');
}
/* 数据重置 */
function clear(){
	$('#id-hidden').val('');
	$('#vin').val('');
	$('#model').val('');
	//$('#brand').find("option[value='-1']").attr("selected",true);
	$('#brand').val('');
	$('#color').val('');
	$('#engineNo').val('');
	$('#remark').val('');
	$('#position').val('');
	//$('#waybillId').find("option[value='-1']").attr("selected",true);
	//$('#type').find("option[value='0']").attr("selected",true);
	
}
/* 保存*/
function save(){
	var flag="false";
	//var type=$('#type').val();
	//var waybillId=$('#waybillId').val();
	var brand=$('#brand').val();
	var vin=$('#vin').val();
	var model=$('#model').val();
	var color=$('#color').val();
	var engineNo=$('#engineNo').val();
	var mark=$('#remark').val();
	var position=$('#position').val();
	if(vin==''|| vin==null){
		bootbox.alert('车架号不能为空！');
		return;
	}
	/* if(waybillId==''|| waybillId==null || waybillId=='-1'){
		bootbox.alert('运单号不能为空！');
		return;
	} */
	/* if(brand==''|| brand==null || brand=='-1'){
		brand="";
	} */
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/carDamageMng/save',
						data : JSON.stringify({
							brand :brand,
							vin :vin,
							color :color,
							model :model,
							engineNo :engineNo,
							position :position,
							mark :mark
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
/* 查看商品车信息 */
function doshow(id){
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/carDamageMng/getcarDamagetList/"+id,
		data :JSON.stringify({
			id :id
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#s-id-hidden').val(id);
				$('#s-vin').val(data.data.vin);
				$('#s-remark').val(data.data.mark);
				//$('#s-waybillId').find("option[value="+data.data.waybillId+"]").attr("selected",true);
				//$('#s-type').val(data.data.type);
				$('#s-model').val(data.data.model);
				$('#s-brand').val(data.data.brand);
				$('#s-color').val(data.data.color);
				$('#s-engineNo').val(data.data.engineNo);
				$('#s-position').val(data.data.position);
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
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/carDamageMng/getcarDamagetList/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#e-id-hidden').val(id);
				$('#e-vin').val(data.data.vin);
				$('#e-remark').val(data.data.mark);
				//$('#e-waybillId').find("option[value="+data.data.waybillId+"]").attr("selected",true);
				//$('#e-type').val(data.data.type);
				/* $('#e-model').val(data.data.model);
				$('#e-brand').val(data.data.brand); */
				if(data.data.brand==null || data.data.brand=='' || data.data.brand==null){
					$("#e-brand").val('');
				}else{
					bindbrands(data.data.brand,data.data.model);
					//$("#e-brand option:contains('"+data.data.brand+"')").attr("selected",true);					
				}
				$('#e-color').val(data.data.color);
				$('#e-engineNo').val(data.data.engineNo);
				$('#e-position').val(data.data.position);
				$('#modal-edit').modal('show');
				
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
	//var type=$('#e-type').val();
	//var waybillId=$('#e-waybillId').val();
	var brand=$('#e-brand').val();
	var vin=$('#e-vin').val();
	var model=$('#e-model').val();
	var color=$('#e-color').val();
	var engineNo=$('#e-engineNo').val();
	var mark=$('#e-remark').val();
	var position=$('#e-position').val();
	/* if(brand==''|| brand==null || brand=='-1'){
		brand="";
	} */
	if(vin==''|| vin==null){
		bootbox.alert('车架号不能为空！');
		return;
	}
	/* if(waybillId==''|| waybillId==null || waybillId=='-1'){
		bootbox.alert('运单号不能为空！');
		return;
	} */
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要编辑该折损车信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/operationMng/carDamageMng/update",
						data :JSON.stringify({
							id :id,
							brand :brand,
							vin :vin,
							color :color,
							model :model,
							engineNo :engineNo,
							position :position,
							mark :mark
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

/*品牌绑定车型*/
function changebrand(e){
	var brand=$(e).val();
	var carType=$(e).find('option:selected').attr('data-carType');
	//console.log(JSON.stringify(carType));
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
				var html ='<option value="" data-carType="">请选择品牌</option>';
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
  					var html='<option value="">请选择车型</option>';
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
</script>
</body>
</html>