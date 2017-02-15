
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
			基础信息管理
			<small>
				<i class="icon-double-angle-right"></i>
				储位管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">仓库：</label>
		   <select id="fom_stock" class="form-box">
			</select>		  
		   <label class="titletwo">4S店：</label>
		     <select id="fom_carShop" class="form-box">
			</select>
			<label class="titletwo">省份：</label>
		     <select id="fom_province" class="form-box">
		      <option value="">请选择省份</option>
		      <option value="北京市">北京市</option>
              <option value="浙江省">浙江省</option>
              <option value="天津市">天津市</option>
              <option value="安徽省">安徽省</option>
              <option value="上海市">上海市</option>
              <option value="福建省">福建省</option>
              <option value="重庆市">重庆市</option>
              <option value="江西省">江西省</option>
              <option value="山东省">山东省</option>
              <option value="河南省">河南省</option>
              <option value="湖北省">湖北省</option>
              <option value="湖南省">湖南省</option>
              <option value="广东省">广东省</option>
              <option value="海南省">海南省</option>
              <option value="山西省">山西省</option>
              <option value="青海省">青海省</option>
              <option value="江苏省">江苏省</option>
              <option value="辽宁省">辽宁省</option>
              <option value="吉林省">吉林省</option>
              <option value="台湾省">台湾省</option>
              <option value="河北省">河北省</option>
              <option value="贵州省">贵州省</option>
              <option value="四川省">四川省</option>
              <option value="云南省">云南省</option>
              <option value="陕西省">陕西省</option>
              <option value="甘肃省">甘肃省</option>
              <option value="黑龙江省">黑龙江省</option>
              <option value="香港特别行政区">香港特别行政区</option>
              <option value="澳门特别行政区">澳门特别行政区</option>
              <option value="广西壮族自治区">广西壮族自治区</option>
              <option value="宁夏回族自治区">宁夏回族自治区</option>
              <option value="新疆维吾尔自治区">新疆维吾尔自治区</option>
              <option value="内蒙古自治区">内蒙古自治区</option>
              <option value="西藏自治区">西藏自治区</option>
			</select>				  
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="doadd()">新增</a>
		</div>
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>仓库名称</th>
					<th>省份</th>
                    <th>4s店</th>
                    <th>位置</th>
                    <th>状态</th>
                    <th>创建时间</th>
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
					<h3 id="myModalLabel">新增/编辑品牌信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>仓库：</label>
							      <select id="stockId" class="form-control">
			                      </select>
							     <input class="form-control" id="id-hidden" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>省份：</label>
							     <select id="province" class="form-control">
							       <option value="">请选择省份</option>
		                           <option value="北京市">北京市</option>
                                   <option value="浙江省">浙江省</option>
                                   <option value="天津市">天津市</option>
                                   <option value="安徽省">安徽省</option>
                                   <option value="上海市">上海市</option>
                                   <option value="福建省">福建省</option>
                                   <option value="重庆市">重庆市</option>
                                   <option value="江西省">江西省</option>
                                   <option value="山东省">山东省</option>
                                   <option value="河南省">河南省</option>
                                   <option value="湖北省">湖北省</option>
                                   <option value="湖南省">湖南省</option>
                                   <option value="广东省">广东省</option>
                                   <option value="海南省">海南省</option>
                                   <option value="山西省">山西省</option>
                                   <option value="青海省">青海省</option>
                                   <option value="江苏省">江苏省</option>
                                   <option value="辽宁省">辽宁省</option>
                                   <option value="吉林省">吉林省</option>
                                   <option value="台湾省">台湾省</option>
                                   <option value="河北省">河北省</option>
                                   <option value="贵州省">贵州省</option>
                                   <option value="四川省">四川省</option>
                                   <option value="云南省">云南省</option>
                                   <option value="陕西省">陕西省</option>
                                   <option value="甘肃省">甘肃省</option>
                                   <option value="黑龙江省">黑龙江省</option>
                                   <option value="香港特别行政区">香港特别行政区</option>
                                   <option value="澳门特别行政区">澳门特别行政区</option>
                                   <option value="广西壮族自治区">广西壮族自治区</option>
                                   <option value="宁夏回族自治区">宁夏回族自治区</option>
                                   <option value="新疆维吾尔自治区">新疆维吾尔自治区</option>
                                   <option value="内蒙古自治区">内蒙古自治区</option>
                                   <option value="西藏自治区">西藏自治区</option></select>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>4s店：</label>
							     <select id="carShopId" class="form-control">
			                      </select>
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">位置：</label>
							     <input class="form-control" id="position" type="text" placeholder="请输入位置"/>							    
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
								  <div class="add-item-btn" id="viewBtn">								   
								    <a class="add-itemBtn btnCancle" onclick="refresh()">关闭</a>
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
		 "sAjaxSource": "${ctx}/basicSetting/stockPositionMng/getListData" , //获取数据的ajax方法的URL							 
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
						    {data: "stockName","width":"10%"},
						    {data: "province","width":"10%"},
						    {data: "carShopName","width":"10%"},
						    {data: "position","width":"10%"},
						    {data: "status","width":"10%"},
						    {data: "insertTime","width":"14%"},
						    {data: "insertUser","width":"10%"},		    
						    {data: null,"width":"14%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 5,
				 render: function (data, type, row, meta) {
					 if(data=='N'){
						 return '未使用';
					 }else{
						 return '已使用';
					 }
					
			       }	       
			},{
					 //入职时间
					 targets: 6,
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
			    	 targets: 8,
			    	 render: function (data, type, row, meta) {
			    		 if(row.status=='N'){
			    			   return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
					           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
			    		 }else{
			    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';
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
		 "sAjaxSource": "${ctx}/basicSetting/stockPositionMng/getListData", //获取数据的ajax方法的URL	
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
						    {data: "stockName","width":"10%"},
						    {data: "province","width":"10%"},
						    {data: "carShopName","width":"10%"},
						    {data: "position","width":"10%"},
						    {data: "status","width":"10%"},
						    {data: "insertTime","width":"14%"},
						    {data: "insertUser","width":"10%"},		    
						    {data: null,"width":"14%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 5,
								 render: function (data, type, row, meta) {
									 if(data=='N'){
										 return '未使用';
									 }else{
										 return '已使用';
									 }
									
							       }	       
							},{
									 //入职时间
									 targets: 6,
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
							    	 targets: 8,
							    	 render: function (data, type, row, meta) {
							    		 if(row.status=='N'){
							    			   return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
									           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>' ;
							    		 }else{
							    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';
							    		 }
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	getstock();
	getCarShop();
})
/* 仓库绑定 */
	function getstock(){
		$.ajax({  
            url: '${ctx}/basicSetting/stockMng/getStockList',  
            type: "post",  
            contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
            data: '',
            success: function (data) {
            	var html ='<option value="">请选择仓库</option>';
                if(data.code == 200){  
                	if(data.data!=null && data.data!=''){
                		/* console.log(JSON.stringify(data.data)); */
                		if(data.data.length>0){
                			for(var i=0;i<data.data.length;i++){
                    			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                    		}
                		}
                	}
                	$('#fom_stock').html(html);
                	$('#stockId').html(html);
                   }else{  
                	   bootbox.alert('加载失败！');
                   }  
            }  
          }); 
	}
/* 4s店绑定 */
function getCarShop(){
	$.ajax({  
        url: '${ctx}/basicSetting/stockPositionMng/getCarShopList',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: '',
        success: function (data) {
        	var html ='<option value="">请选择4s店</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		/* console.log(JSON.stringify(data.data)); */
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                		}
            		}
            	}
            	$('#fom_carShop').html(html);
            	$('#carShopId').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}
/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var stockId=$("#fom_stock").val(); 
	   var province=$("#fom_province").val(); 
	   var carShopId=$("#fom_carShop").val(); 	  
	   $('#secho').val(secho);
	   //console.info(stockId+province+carShopId);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				stockId :$.trim(stockId) ,
				province : $.trim(province),
				carShopId:$.trim(carShopId)			
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

	
/* 删除储位信息*/
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除储位信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/basicSetting/stockPositionMng/delete/"+id,
						data :JSON.stringify({
							id :id
						}),
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
	$('#myModalLabel').html('新增储位信息');	
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
	$('#stockId').val('');
	$('#carShopId').val('');
	$('#position').val('');	
	$('#province').val('');	
}
/* 保存新增储位信息 */
function save(){
	var flag="false";
	var stockId=$("#stockId").find("option:selected").val(); 
	var carShopId=$("#carShopId").find("option:selected").val(); 
	var province=$("#province").find("option:selected").val(); 
	var position=$("#position").val(); 
	if(stockId=='-1'){
		bootbox.alert('仓库不能为空！');
		return;
	}
	if(province==''){
		bootbox.alert('省份不能为空！');
		return;
	}
	if(carShopId=='-1'){
		bootbox.alert('4s店不能为空！');
		return;
	}
	
	if(position==''){
		bootbox.alert('位置不能为空！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增储位信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/stockPositionMng/save',
						data : JSON.stringify({
							stockId : stockId,				
							carShopId : carShopId,
							province : province,
							position:position
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
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/stockPositionMng/getDetailData/"+id,
		data :JSON.stringify({
			id :id
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑储位信息');
				$("#stockId").val(data.data.stockId);
				$("#carShopId").val(data.data.carShopId); 
				$("#province").val(data.data.province); 
				$("#position").val(data.data.position); 						
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
	var stockId=$("#stockId").find("option:selected").val(); 
	var carShopId=$("#carShopId").find("option:selected").val(); 
	var province=$("#province").find("option:selected").val(); 
	var position=$("#position").val(); 
	if(stockId=='-1'){
		bootbox.alert('仓库不能为空！');
		return;
	}
	if(province==''){
		bootbox.alert('省份不能为空！');
		return;
	}
	if(carShopId=='-1'){
		bootbox.alert('4s店不能为空！');
		return;
	}
	
	if(position==''){
		bootbox.alert('位置不能为空！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该储位信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/stockPositionMng/update',
						data : JSON.stringify({
							id : id,
							stockId : stockId,				
							carShopId : carShopId,
							province : province,
							position:position
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
function doview(id){
	clear();
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/stockPositionMng/getDetailData/"+id,
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
}
</script>



</body>
</html>






