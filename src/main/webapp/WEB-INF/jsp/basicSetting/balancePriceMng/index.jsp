
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
				结算价格管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">供应商：</label>
		   <select id="fom_supplier" class="form-box" >	</select>
		    <label class="title">结算方式：</label>
		   <select id="fom_balanceType" class="form-box" >
		   <option value="">请选择结算方式</option>
		   <option value="0">单价模式</option>
		   <option value="1">公里数模式</option>
		   <option value="2">总价模式</option>
		   	</select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="doadd()">新增</a>
		</div>
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>结算方式</th>
					<!-- <th>收款方</th> -->
                    <th>供应商名称</th>
                    <th>品牌</th>
                    <th>单价（元）</th>
                    <th>承运商结算价格</th>
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
					<h3 id="myModalLabel">新增/编辑结算价格信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>供应商：</label>
							    <select id="supplierId" class="form-control" >	</select>
							     <input class="form-control" id="id-hidden" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>结算模式：</label>
							     <select id="balanceType" class="form-control" >	
							     <option value="">请选择结算方式</option>
		                         <option value="0">单价模式</option>
		                         <option value="1">公里数模式</option>
		                         <option value="2">总价模式</option>
							     </select>
							 </div>
							 <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>品牌 ：</label>
							     <select id="brand" class="form-control" >	</select>
							     <!-- <input class="form-control" id="brand" type="text" placeholder="请输入品牌  "/> -->
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>价格（元） ：</label>
							     <input class="form-control" id="price" type="text" placeholder="请输入价格  "/>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>承运商价格（元） ：</label>
							     <input class="form-control" id="outSourcingPrice" type="text" placeholder="请输入承运商价格  "/>
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
		 "sAjaxSource": "${ctx}/basicSetting/balancePriceMng/getListData" , //获取数据的ajax方法的URL							 
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
		    {data: "balanceType"},
		   /*  {data: "receivingName"}, */
		    {data: "supplierName"},
		    {data: "brand"},
		    {data: "price"},
		    {data: "outSourcingPrice"},
		    {data: "insertTime"},
		    {data: "insertUser"},		    
		    {data: null}],
		    columnDefs: [{
				 //入职时间
				 targets: 1,
				 render: function (data, type, row, meta) {
					if(data=='0'){
						return '单价模式';
					}else if(data=='1'){
						return '公里数模式';
					}else if(data=='2'){
						return '总价模式';
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
		                    return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
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
		 "sAjaxSource": "${ctx}/basicSetting/balancePriceMng/getListData", //获取数据的ajax方法的URL	
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
						    {data: "balanceType","width":"10%"},
						   /*  {data: "receivingName","width":"10%"}, */
						    {data: "supplierName","width":"20%"},
						    {data: "brand","width":"10%"},
						    {data: "price","width":"10%"},
						    {data: "outSourcingPrice","width":"10%"},
						    {data: "insertTime","width":"10%"},
						    {data: "insertUser","width":"10%"},		    
						    {data: null,"width":"15%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 1,
								 render: function (data, type, row, meta) {
									if(data=='0'){
										return '单价模式';
									}else if(data=='1'){
										return '公里数模式';
									}else if(data=='2'){
										return '总价模式';
									}
							       }	       
							},{
									 //入职时间
									 targets: 6,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonForDateFormat(data); 
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
$(function(){
	init();
	BindSup();//绑定供应商
	//BindOutSour();//绑定供应商
})
function BindSup(){
	$.ajax({
		type : 'POST',
		url : "${ctx}/basicSetting/balancePriceMng/getSupplierList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var html ='<option value="">请选择供应商</option>';
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	            		}
	        		}
	        	}
	        	$('#fom_supplier').html(html);
	        	$('#supplierId').html(html);
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
	   var supplierId=$("#fom_supplier").val(); 
	   var balanceType=$("#fom_balanceType").val(); 
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
				supplierId :$.trim(supplierId),
				balanceType :$.trim(balanceType)
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

	
/* 删除驳板价格信息 */
function dodelete(id){
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除结算价格信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/basicSetting/balancePriceMng/delete/"+id,
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "删除成功！", 
									  callback: function(result){
										  if(result){
											  reload();
										  }else{
											reload();  
										  }
									  }
								 });
								
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
	$('#myModalLabel').html('新增结算价格信息');	
	$('#modal-info').modal('show');
	bindbrand();//绑定品牌
}
//绑定品牌
function bindbrand(){
	$.ajax({
		type : 'POST',
		url : "${ctx}/basicSetting/balancePriceMng/getBrandList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var html ='<option value="">请选择品牌</option>';
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<option value='+data.data[i]['brandName']+'>'+data.data[i]['brandName']+'</option>';
	            		}
	        		}
	        	}
	        	$('#brand').html(html);
	        	
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
	$('#supplierId').val('');
	$('#brand').val('');	
	$('#price').val('');
	$('#outSourcingPrice').val('');
}
/* 保存新增人员信息 */
function save(){
	var supplierId=$('#supplierId').val();
	var balanceType=$('#balanceType').val();	
	var brand=$('#brand').val();
	var price=$('#price').val();
	var outSourcingPrice=$('#outSourcingPrice').val();
	if(supplierId==''|| supplierId==null){
		bootbox.alert('供应商不能为空！');
		return;
	}
	if(balanceType==''|| balanceType==null){
		bootbox.alert('结算方式不能为空！');
		return;
	}
	if(brand==''|| brand==null){
		bootbox.alert('品牌不能为空！');
		return;
	}	
	if(price==''|| price==null){
		bootbox.alert('价格不能为空！');
		return;
	}	
	if(outSourcingPrice==''|| outSourcingPrice==null){
		bootbox.alert('承运商价格不能为空！');
		return;
	}		
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增结算价格信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/balancePriceMng/save',
						data : JSON.stringify({
							supplierId : supplierId,				
							brand : brand,
							outSourcingPrice : outSourcingPrice,
							balanceType : balanceType,
							price : price
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
											  location.reload();
										  }else{
											 location.reload();  
										  }
									  }
								 });
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
		url : "${ctx}/basicSetting/transportPriceMng/getDetailData/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑品牌信息');
				$('#supplierId').val(data.data.supplierId);
				$('#brand').val(data.data.brand);
				$('#outSourcingPrice').val(data.data.outSourcingPrice);
				$('#balanceType').val(data.data.balanceType);
				$('#price').val(data.data.price);				
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
	var id=$('#id-hidden').val();
	var supplierId=$('#supplierId').val();
	var balanceType=$('#balanceType').val();	
	var brand=$('#brand').val();
	var price=$('#price').val();
	var outSourcingPrice=$('#outSourcingPrice').val();
	if(supplierId==''|| supplierId==null){
		bootbox.alert('供应商不能为空！');
		return;
	}
	if(balanceType==''|| balanceType==null){
		bootbox.alert('结算方式不能为空！');
		return;
	}
	if(brand==''|| brand==null){
		bootbox.alert('品牌不能为空！');
		return;
	}	
	if(price==''|| price==null){
		bootbox.alert('价格不能为空！');
		return;
	}	
	if(outSourcingPrice==''|| outSourcingPrice==null){
		bootbox.alert('承运商价格不能为空！');
		return;
	}		
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该驳板价格信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/transportPriceMng/update',
						data : JSON.stringify({
							id : id,
							supplierId : supplierId,				
							brand : brand,
							outSourcingPrice : outSourcingPrice,
							balanceType : balanceType,
							price : price
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "更新成功！", 
									  callback: function(result){
										  if(result){
											  location.reload();
										  }else{
											 location.reload();  
										  }
									  }
								 });
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






