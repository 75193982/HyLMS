
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
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
				4S店管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">经销商代码：</label>
		   <input id="fom_orgCode" class="form-box" type="text" placeholder="请填写经销商代码"/>		   	  
		  <label class="title">经销单位名称：</label>
		  <input id="fom_name" class="form-box" type="text" placeholder="请填写经销单位名称"/>				  
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="doadd()">新增</a>
		</div>
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover" style="table-layout:fixed;">
			<thead>
				<tr>														
					<th>序号</th>
					<th>经销单位代码</th>
					<th>经销单位名称</th>
                    <th>省份</th>
                    <th>城市</th>
                    <th>地址</th>
                    <th>联系人</th>
                    <th>联系人出生日期</th>
                    <th>联系电话</th> 
                    <th>手机号码</th>                    
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">新增/编辑经销单位信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>经销单位名称：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							      <input class="form-control " id="name" type="text" placeholder="请输入经销单位名称"/>
							     <input class="form-control" id="id-hidden" type="hidden"/>
							     </div>							      
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>省份：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <select id="province" class="form-control">
							     </select>
							     </div>
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>城市：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <select id="city" class="form-control">
							     </select>
								 </div>
							</div>
							  <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>地址：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="address" type="text" placeholder="请输入地址"/>
							     	</div>					   					    
							  </div>	
							   <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>联系人：</label>
							      <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="linkUser" type="text" placeholder="请输入联系人"/>
							     </div>
							    </div>			
							  <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>联系电话：</label>
							     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="linkTelephone" type="text" placeholder="请输入联系电话"/>
							     </div>
							  </div>
							   <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4">经销单位编码：</label>
							      <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="orgCode" type="text" placeholder="请输入经销单位编码"/>
							     </div>
							 </div>
							 <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">生日：</label>
							    <div class="input-group input-group-sm col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
									<input class="form-control" id="brithday" type="text" placeholder="请输入生日"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>	
							    </div>		
							     <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">手机号码：</label>
							      <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
							     <input class="form-control" id="linkMobile" type="text" placeholder="请输入手机号码"/>
							     </div>
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
								  <!-- <div class="add-item-btn" id="viewBtn">								   
								    <a class="add-itemBtn btnCancle" onclick="refresh()">关闭</a>
								  </div> -->
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
<script src="${ctx}/staticPublic/js/city.js"></script>
<script type="text/javascript">
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/basicSetting/carShopMng/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum" ,"width":"6%"},
		    {data: "orgCode","width":"10%","class":"wordwear"},
		    {data: "name","width":"10%","class":"wordwear"},
		    {data: "province","width":"8%"},
		    {data: "city","width":"8%"},
		    {data: "address","width":"12%","class":"wordwear"},
		    {data: "linkUser","width":"8%","class":"wordwear"},
		    {data: "brithday","width":"11%","class":"wordwear"},
		    {data: "linkTelephone","width":"8%","class":"wordwear"},	
		    {data: "linkMobile","width":"8%","class":"wordwear"},	
		    {data: null,"width":"15%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 7,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonForDateFormat(data);
					 }else{
						 return '';
					 }
					
			       }	       
			},{
			    	 //操作栏
			    	 targets: 10,
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
		 "sAjaxSource": "${ctx}/basicSetting/carShopMng/getListData", //获取数据的ajax方法的URL	
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
				columns: [{ data: "rownum" ,"width":"6%"},
						    {data: "orgCode","width":"10%"},
						    {data: "name","width":"10%"},
						    {data: "province","width":"8%"},
						    {data: "city","width":"8%"},
						    {data: "address","width":"12%","class":"wordwear"},
						    {data: "linkUser","width":"8%"},
						    {data: "brithday","width":"11%"},
						    {data: "linkTelephone","width":"8%"},	
						    {data: "linkMobile","width":"8%"},	
						    {data: null,"width":"15%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 7,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonForDateFormat(data);
									 }else{
										 return '';
									 }
									
							       }	       
							},{
							    	 //操作栏
							    	 targets: 10,
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
	//getstock();
	//getCarShop();
})
/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var name=$("#fom_name").val(); 
	   var fom_orgCode=$("#fom_orgCode").val(); 	  
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				name :$.trim(name) ,
				orgCode : $.trim(fom_orgCode)			
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

	
/* 删除经销单位信息*/
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除经销单位信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/basicSetting/carShopMng/delete/"+id,
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
	//创建省份  
    createProvinces();
    //默认显示请选择
    for(var i=0;i<province.options.length;i++){ 
	    if ( province.options[i].value == "---请选择省份---")                
	    {          
	    	province.options[i].selected = true; 
	    	city.options.add(new Option('---请选择市县---','---请选择市县---')); 
	    }   
    }
     //选择省份后，切换对应城市列表  
    province.onchange=createCities;  
     
	$('#addBtn').show();
	$('#editBtn').hide();
	$('#myModalLabel').html('新增经销单位信息');	
	$('#modal-info').modal('show');
	$("#brithday").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
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
	$('#name').val('');
	$('#address').val('');
	$('#linkUser').val('');	
	$('#brithday').val('');	
	$('#linkTelephone').val('');	
	$('#linkMobile').val('');
	$('#orgCode').val('');
	//$('#province').val('');
	document.getElementById("province").options.length = 0;
	//$('#city').val('');
	document.getElementById("city").options.length = 0;
}
/* 保存新增经销单位信息 */
function save(){
	var flag="false";
	var name=$("#name").val(); 
	var orgCode=$("#orgCode").val(); 
	var province=$("#province").val(); 
	var address=$("#address").val(); 
	var linkUser=$("#linkUser").val(); 
	var linkTelephone=$("#linkTelephone").val(); 
	var linkMobile=$("#linkMobile").val(); 
	var brithday=$("#brithday").val(); 
	var city=$("#city").val(); 
	if(name==''){
		bootbox.alert('经销单位名称不能为空！');
		return;
	}
	if(province=='' || province=='---请选择省份---'){
		bootbox.alert('省份不能为空！');
		return;
	}
	if(city=='' || city == '---请选择市县---'){
		bootbox.alert('城市不能为空！');
		return;
	}
	if(address==''){
		bootbox.alert('地址不能为空！');
		return;
	}
	if(linkUser==''){
		bootbox.alert('联系人不能为空！');
		return;
	}	
	if(linkTelephone==''){
		bootbox.alert('联系电话不能为空！');
		return;
	}
	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增经销单位信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/carShopMng/save',
						data : JSON.stringify({
							name : $.trim(name),				
							address :$.trim(address) ,
							orgCode : $.trim(orgCode),
				  			province : $.trim(province),
				  			city : $.trim(city),
							brithday : $.trim(brithday),
							linkUser : $.trim(linkUser) ,
							linkTelephone : $.trim(linkTelephone),
							linkMobile : $.trim(linkMobile)
							
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
	//创建省份  
    createProvinces();
     //选择省份后，切换对应城市列表  
    province.onchange=createCities;
     
	$("#brithday").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/carShopMng/getDetailData/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑经销单位信息');
				$("#name").val(data.data.name);
				$("#address").val(data.data.address); 
				$("#linkUser").val(data.data.linkUser); 
				$("#linkTelephone").val(data.data.linkTelephone); 
				$("#linkMobile").val(data.data.linkMobile); 		
				$("#orgCode").val(data.data.orgCode);
				$("#province").val(data.data.province);
				//根据省加载城市 ww2017.2.10
				loadcitys(data.data.province);
				$("#city").val(data.data.city);
				if(data.data.brithday!=''&&data.data.brithday!=null){
				$("#brithday").val(jsonForDateFormat(data.data.brithday));	
				}else{
					$("#brithday").val('');	
				}							
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
	var name=$("#name").val(); 
	var orgCode=$("#orgCode").val(); 
	var province=$("#province").val(); 
	var address=$("#address").val(); 
	var linkUser=$("#linkUser").val(); 
	var linkTelephone=$("#linkTelephone").val(); 
	var linkMobile=$("#linkMobile").val(); 
	var brithday=$("#brithday").val(); 
	var city=$("#city").val(); 
	if(name==''){
		bootbox.alert('经销单位名称不能为空！');
		return;
	}
	if(province=='' || province == '---请选择省份---'){
		bootbox.alert('省份不能为空！');
		return;
	}
	if(city=='' || city == '---请选择市县---'){
		bootbox.alert('城市不能为空！');
		return;
	}
	if(address==''){
		bootbox.alert('地址不能为空！');
		return;
	}
	if(linkUser==''){
		bootbox.alert('联系人不能为空！');
		return;
	}	
	if(linkTelephone==''){
		bootbox.alert('联系电话不能为空！');
		return;
	}

	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该经销单位信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/carShopMng/update',
						data : JSON.stringify({
							id : id,
							name : $.trim(name),				
							address :$.trim(address) ,
							orgCode : $.trim(orgCode),
				  			province : $.trim(province),
				  			city : $.trim(city),
							brithday : $.trim(brithday),
							linkUser : $.trim(linkUser) ,
							linkTelephone : $.trim(linkTelephone),
							linkMobile : $.trim(linkMobile)
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
/* function doview(id){
	clear();
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/outSourcingMng/getDetailData/"+id,
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
} */
</script>



</body>
</html>






