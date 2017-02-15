<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>折损入库管理</title>
<link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
<!-- page specific plugin styles -->
<!-- ace styles -->
<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
<link rel="stylesheet"
	href="${ctx}/staticPublic/css/font-awesome.min.css" />
<!--字体icon-->
<!-- inline styles related to this page -->
<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
<!-- ace settings handler -->
<script type="text/javascript"
	src="${ctx}/staticPublic/js/ace-extra.min.js"></script>
<!--要预先加载ace的js-->
<style type="text/css">

#modal-info{
    width: 600px;
    height: 300px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }
    
    #modal-carinfo{
    width: 800px;
    height: 600px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }
    
     #modal-attachmentinfo{
    width: 800px;
    height: 600px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }
    
      #modal-detilinfo{
    width: 800px;
    height: 600px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }

.table-audit{
	width: 85px;
	height: 30px;
	display: inline-block;
	cursor: pointer;
	text-decoration: none;
	background: #2ca9e1;
	color: #fff;
	text-align: center;
	font-size: 13px;
	line-height: 24px;
	border-radius: 3px;
	padding: 3px;
	margin-right:5px;
	
}  

.table-bingcars{
	width: 75px;
	height: 30px;
	display: inline-block;
	cursor: pointer;
	text-decoration: none;
	background: #2ca9e1;
	color: #fff;
	text-align: center;
	font-size: 13px;
	line-height: 24px;
	border-radius: 3px;
	padding: 3px;
	margin-left:5px;
	margin-right:5px;
}

.col-xs-12{
    margin-bottom:10px;
    }
</style>
</head>
<body class="white-bg">
	<div class="page-content">
		<div class="page-header">
			<h1>
				运营管理 <small> <i class="icon-double-angle-right"></i> 折损入库管理
				</small>
			</h1>
		</div>
		<!-- /.page-header -->
		<div class="page-content">
			<div class="searchbox col-xs-12">
				<!-- <a id="searchBtn" class="itemBtn" onclick="dosearch()">查询</a> --> 
				<a id="saveBtn" class="itemBtn" onclick="add()">新增</a> 
				<input type="hidden" id="secho" name="secho">
			</div>
			<div class="detailInfo">
				<table id="dynamic-table"
					class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>序号</th>
							<th>入库原因</th>
							<th>入库时间</th>
							<th>状态</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>

				<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
					<div class="modal-header" >
						<button class="close" type="button" onclick="cancel();">×</button>
						<h3 id="myModalLabel">折损入库登记</h3>
					</div>
					<div class="modal-body">
						<div>
							<div class="widget-box dia-widget-box">
								<div class="widget-body">
									<div class="widget-main">
										<div class="add-item extra-itemSec">
									     	<label class="title">入库原因：</label>
									     	<input class="form-control" id="markText" type="text" placeholder="请输入入库原因"/>
									     	<input class="form-control" id="id-hidden" type="hidden"/>
									 	</div>
										<hr class="tree"></hr>
										<div class="add-item-btn" id="addBtn">
											<a class="add-itemBtn btnOk" onclick="save();">保存</a> <a
												class="add-itemBtn btnCancle" onclick="cancel();">取消</a>
										</div>
										<div class="add-item-btn" id="editBtn">
											<a class="add-itemBtn btnOk" onclick="update()">更新</a> <a
												class="add-itemBtn btnCancle" onclick="cancel()">取消</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="modal fade" id="modal-carinfo" tabindex="-1" role="dialog" data-backdrop="static">
					<div class="modal-header">
						<button class="close" type="button" onclick="cancelCarDam()">×</button>
						<h3 id="myModalLabel">绑定折损车信息</h3>
					</div>
					<div class="modal-body">
					   <div>
						  <div class="widget-box dia-widget-box">
								<div class="widget-body">
									<div class="widget-main">	
									<div class="searchbox col-xs-12 ">
				                    <input id="wabillId-hidden" type="hidden"/>	
				                    <!-- 根据sign标记 判断是新加还是更新 加载的数据结构不一样  取数也不一样 -->
				                   <!--  <input id="sign" type="hidden"/>   -->
			                       <label class="titletwo">车架号：</label>
			                       <input class="form-box" id="fom_vin" type="text"  placeholder="请输入车架号"/>
				                   <a class="itemBtn" onclick="searchcarInfo()">查询</a>		
				                   </div>	       						
								 	<table id="cardetable" class="table table-striped table-bordered table-hover">
				                      <thead>
					                   <tr>	
					                   <th class="center">
							           <input type="checkbox" class="checkall" />
						               </th>													
						               <th>序号</th>
						               <th>车架号</th>
	                                   <th>品牌</th>
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
								    <hr class="tree"></hr>
								    <div class="add-item-btn" id="caraddBtn">
									    <a class="add-itemBtn btnOk" onclick="bindCarDamStock();">确定</a>
									    <a class="add-itemBtn btnCancle" onclick="cancelCarDam();">关闭</a>
									 </div>								 
									</div>
							  </div>
						</div>
					</div>
				</div>
			</div>
			
					<div class="modal fade" id="modal-attachmentinfo" tabindex="-1" role="dialog" data-backdrop="static">
						<div class="modal-header">
							<button class="close" type="button" onclick="cancelCarAtt()">×</button>
							<h3 id="myModalLabel">绑定配件信息</h3>
						</div>
						<div class="modal-body">
						   <div>
							  <div class="widget-box dia-widget-box">
									<div class="widget-body">
										<div class="widget-main">	
										<div class="searchbox col-xs-12 add-item">			                   		
					                    <input class="form-control" id="atwabillId-hidden" type="hidden"/>	
					                    <!-- <input id="sign-1" type="hidden"> -->  
				                       <label class="title">配件名称：</label>
				                       <input class="form-box" id="fom_attachmentName" type="text"  placeholder="请输入配件名称"/>		                      
					                   <a class="itemBtn" onclick="searchattachInfo()">查询</a>		
					                   </div>	       						
									 	<table id="attachmentdetable" class="table table-striped table-bordered table-hover">
					                      <thead>
						                   <tr>	
						                   <th class="center">
								           <input type="checkbox" class="checkall" />
							               </th>													
							               <th>序号</th>
							               <th>配件名称</th>
		                                   <th>存放位置</th>
		                                   <th>数量</th>
		                                   <th>备注</th>
		                                   <th>状态</th>                                                                                                             
						                     </tr>
					                      </thead>
					                      <tbody>
					                      </tbody>
					                      </table>							   			  
									    <hr class="tree"></hr>
									    <div class="add-item-btn" id="caratcaddBtn">
										    <a class="add-itemBtn btnOk" onclick="bindAttDamStock();">确定</a>
										    <a class="add-itemBtn btnCancle" onclick="cancelCarAtt();">关闭</a>
										 </div>								 
										</div>
								  </div>
							</div>
						</div>
						</div>
			</div>
			
			<div class="modal fade" id="modal-detilinfo" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">入库单信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							 <div class="add-item col-xs-12">
							      <!-- <label class="title col-xs-2">运单编号：</label><label class="title col-xs-4" id="waybillNo_view"></label> -->
							      <label class="title col-xs-2">入库原因：</label><label class="title col-xs-4" id="mark_view"></label>						     								     							     
							  </div>		
							    <hr class="tree"></hr>
							   <div class="add-item">
							     <label class="title">折损车信息：</label>	
							     <table id="cardetable_view" class="table table-striped table-bordered table-hover">
			                      <thead>
				                   <tr>					                   													
					               <th>序号</th>
						           <th>车架号</th>
	                               <th>品牌</th>
	                               <th>车型</th>
	                               <th>颜色</th> 
	                               <th>发动机号</th> 
	                               <th>备注</th>
				                     </tr>
			                      </thead>
			                      <tbody>
			                      </tbody>
			                      </table>								     
							    </div>	
							      <hr class="tree"></hr>
							   <div class="add-item">
							     <label class="title">折损配件信息：</label>	
							     <table id="attachmentdetable_view" class="table table-striped table-bordered table-hover">
			                      <thead>
				                   <tr>													
					               <th>序号</th>
					               <th>配件名称</th>
                                   <th>存放位置</th>
                                   <th>数量</th>
                                   <th>备注</th>
				                     </tr>
			                      </thead>
			                      <tbody>
			                      </tbody>
			                      </table>									     
							    </div>										   			  
							    <hr class="tree"></hr>							    
								 <div class="add-item-btn" id="viewBtn">								   
								    <a class="add-itemBtn btnCancle" onclick="doclose()">关闭</a>
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
		<!-- <![endif]-->
		<!--[if IE]>
		<script src="${ctx}/staticPublic/js/jquery-1.10.2.min.js"></script>
		<![endif]-->
		<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
		<!-- page specific plugin scripts -->
		<script src="${ctx}/staticPublic/js/jquery.dataTables.js"></script>
		<script src="${ctx}/staticPublic/js/jquery.dataTables.bootstrap.js"></script>
		<script src="${ctx}/staticPublic/js/dataTables.select.js"></script>
		<!-- ace scripts -->
		<script src="${ctx}/staticPublic/js/ace-elements.min.js"></script>
		<script src="${ctx}/staticPublic/js/ace.min.js"></script>		
		<!-- inline scripts related to this page -->
		<script type="text/javascript" src="${ctx}/staticPublic/js/popbox/Confirm.js"></script>
        <script src="${ctx}/staticPublic/js/bootbox.min.js"></script>
<script type="text/javascript">
function init(){
	//initiate dataTables plugin
	var myTable = $('#dynamic-table').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/carDamageInStock/getListRuData" , //获取数据的ajax方法的URL							 
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
						    {data: "mark","width":"24%"},	
						    {data: "insertTime","width":"14%"},	
						    {data: "status","width":"10%"},			    
						    {data: null,"width":"24%"}],
		    columnDefs: [
				{
					 //状态
					 targets: 3,
					 render: function (data, type, row, meta) {
						 if(data=='0'){
							 return '新建';
						 }else if(data=='1'){
							 return '待复核';
						 }else if(data=='2'){
							 return '已复核';
						 }
						 /* else if(data=='3'){
							 return '已回执';
						 }else if(data=='4'){
							 return '已结算';
						 }	 */					
				      }	       
				},{
					 //时间
					 targets:2,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return data.substring(0,19);
						 }else{
							 return '';
						 }
				      }	       
				},
		      	{
			    	 //操作栏
			    	 targets: 4,
			    	 render: function (data, type, row, meta) {	
			    		 if(row.status=='0'){
			    			 return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
					           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
					           +'<a class="table-bingcars" onclick="dobindcar('+ row.id +')">绑定折损车</a>'
					           +'<a class="table-audit" onclick="dobindattachment('+ row.id +')">绑定折损配件</a>'
					           +'<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>';	
			    		 }else {
			    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'
			    		 }
		             }	       
		    	} 
		      ],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
function reload(){
	//reload dataTables plugin
	var myTable = $('#dynamic-table').DataTable({
		"destroy": true,//如果需要重新加载需销毁
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/carDamageInStock/getListRuData", //获取数据的ajax方法的URL	
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
						    {data: "mark","width":"24%"},	
						    {data: "insertTime","width":"14%"},	
						    {data: "status","width":"10%"},			    
						    {data: null,"width":"24%"}],
				columnDefs: [
								{
									 //状态
									 targets: 3,
									 render: function (data, type, row, meta) {
										 if(data=='0'){
											 return '新建';
										 }else if(data=='1'){
											 return '待复核';
										 }else if(data=='2'){
											 return '已复核';
										 }/* else if(data=='3'){
											 return '已回执';
										 }else if(data=='4'){
											 return '已结算';
										 }		 */				
								     }	       
								},{
									 //时间
									 targets:2,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return data.substring(0,19);
										 }else{
											 return '';
										 }
								      }	       
								},
						      	{
							    	 //操作栏
							    	 targets: 4,
							    	 render: function (data, type, row, meta) {			    		
							    		 if(row.status=='0'){
							    			 return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
									           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
									           +'<a class="table-bingcars" onclick="dobindcar('+ row.id +')">绑定折损车</a>'
									           +'<a class="table-audit" onclick="dobindattachment('+ row.id +')">绑定折损配件</a>'
									           +'<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>';	
							    		 }else {
							    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';	
							    		 }    				                 
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){		
	/* var url = location.href;
	//console.log(url);
	if(url.indexOf("?")>0){
    var waybillNo = url.substring(url.indexOf("?")+1,url.length);
    $("#fom_waybillNo").val(waybillNo);
	}	 */
	init();
})

/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   //console.log(pageStartIndex);		
	   var pageSize=aoData[4]["value"];
	   //var waybillNo=$("#fom_waybillNo").val(); 
	  // var status=$("#fom_status").val(); 
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize)
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.log(JSON.stringify(data.data));							
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
function dosearch(){	
	reload();
}

//新增
function add(){
	clear();
	$('#addBtn').show();
	$('#editBtn').hide();
	$('#myModalLabel').html('折损入库登记信息');
	$('#modal-info').modal('show');
}
//清除
function clear()
{
	$('#markText').val('');
	$('#id-hidden').val('');
}
//关闭
function cancel()
{
	clear();
	$('#modal-info').modal('hide');
}
//保存
function save()
{
	var flag="false";
	var mark = $.trim($("#markText").val());
	if(mark == null || mark == "")
	{
		bootbox.alert('入库原因不能为空！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/carDamageInStock/save',
						data : JSON.stringify({
							mark:mark
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
											  cancel();
											  reload();
										  }else{
											  cancel();
											  reload();
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										 cancel();
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

//打开编辑页面
function doedit(id){	
	clear();
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/carDamageInStock/queryWaybill/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑入库单信息');
				$('#markText').val(data.data.mark);
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
	var flag="false";
	var id=$('#id-hidden').val();
	var mark = $.trim($('#markText').val());
	if(mark == null || mark == ""){
		bootbox.alert('入库原因不能为空！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/carDamageInStock/updateWaybill',
						data : JSON.stringify({
							id : id,
							mark:mark
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
											  cancel();
											  reload();
										  }else{
											  cancel();
											  reload();
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										 cancel();
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

/* 删除*/
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该入库单信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/carDamageInStock/deleteWaybill/"+id,
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
							}else{
								bootbox.alert(data.msg);
							}
						}
						
					}); 
			  }
		  }
	})
}

//入库单提交
function dosubmit(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该入库单吗?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/carDamageInStock/submitWaybill/"+id,
						data :JSON.stringify({}),
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

//绑定折损车
function dobindcar(id){	
	$("#cardetable tbody tr").remove();  
	$('#wabillId-hidden').val(id);
	$('#modal-carinfo').modal('show');
	$('#caraddBtn').show();	
	//var bidArray = [];
/* 	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/carDamageInStock/checkRuWaybillId",
		data :JSON.stringify({
			waybillId : id
			}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				if(null != data.data && data.data.length > 0)
				{
					 //存在
					$('#sign').val("1");//标记 是修改
					for(var i = 0;i<data.data.length;i++)
					{
						//console.info(data.data[i]["id"]);
						//var id = data.data[i]["id"];
						bidArray.push(data.data[i]["id"]);
					}
					
					//console.info(JSON.stringify(bidArray));
					
					var html="",htmlItem="";
					   var secho='1';   
					   var pageStartIndex='0';
					   var pageSize=1000;
					   $('#secho').val(secho);
					   var obj = {};
						 $.ajax({
							type : 'POST',
							url : "${ctx}/operationMng/carDamageMng/getListData",
							data : JSON.stringify({
								sEcho : $.trim(secho),				
								pageStartIndex : $.trim(pageStartIndex),
								pageSize : $.trim(pageSize),
							}),
							contentType : "application/json;charset=UTF-8",
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {
									//console.log(JSON.stringify(data.data));								
									obj.iTotalDisplayRecords=data.data.totalCounts;
									obj.iTotalRecords=data.data.totalCounts;
									obj.aaData=data.data.records;		
									obj.sEcho=data.data.frontParams;
								//	console.log(JSON.stringify(obj));
									if(obj.aaData.length>0)
									{
										for(var i=0;i<obj.aaData.length;i++)
										{
											obj.aaData[i]["rownum"]=i+1;
											 if(obj.aaData[i]["status"] == 0)
											{
												obj.aaData[i]["status"] = "新建";
											}
											
											if(bidArray.length > 0)
											{
												for(var j = 0;j<bidArray.length;j++)
												{
													if(obj.aaData[i]["id"] == bidArray[j])
													{
														//console.info(obj.aaData[i]["id"]);
														htmlItem ='<tr class="selected"><td class=" text-center"><input type="checkbox" checked="checked" class="checkchild"></td>'
														     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
														     +'<td>'+obj.aaData[i]["vin"]+'</td>'
														     +'<td>'+obj.aaData[i]["brand"]+'</td>'
														     +'<td>'+obj.aaData[i]["model"]+'</td>'
														     +'<td>'+obj.aaData[i]["color"]+'</td>'
														     +'<td>'+obj.aaData[i]["engineNo"]+'</td>'
														     +'<td>'+obj.aaData[i]["mark"]+'</td>'
														     +'<td>'+obj.aaData[i]["status"]+'</td></tr>';
														     break;//相等就停止循环
														     
													}
													else
													{
														htmlItem ='<tr><td class=" text-center"><input type="checkbox" class="checkchild"></td>'
														     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
														     +'<td>'+obj.aaData[i]["vin"]+'</td>'
														     +'<td>'+obj.aaData[i]["brand"]+'</td>'
														     +'<td>'+obj.aaData[i]["model"]+'</td>'
														     +'<td>'+obj.aaData[i]["color"]+'</td>'
														     +'<td>'+obj.aaData[i]["engineNo"]+'</td>'
														     +'<td>'+obj.aaData[i]["mark"]+'</td>'
														     +'<td>'+obj.aaData[i]["status"]+'</td></tr>';
													}
												}
												//console.info(htmlItem);
												html+=htmlItem;
												
											}
											else
											{
												html='<tr ><td class=" text-center"><input type="checkbox" class="checkchild"></td>'
												     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
												     +'<td>'+obj.aaData[i]["vin"]+'</td>'
												     +'<td>'+obj.aaData[i]["brand"]+'</td>'
												     +'<td>'+obj.aaData[i]["model"]+'</td>'
												     +'<td>'+obj.aaData[i]["color"]+'</td>'
												     +'<td>'+obj.aaData[i]["engineNo"]+'</td>'
												     +'<td>'+obj.aaData[i]["mark"]+'</td>'
												     +'<td>'+obj.aaData[i]["status"]+'</td></tr>';
											}
										}
									}else{
										html+="<tr><td colspan='9'>暂无折损车信息</td></tr>";
									}
									$('#cardetable tbody').html(html);
								} else {
									 bootbox.alert(data.msg);
								}
								
							}
						}); 
				}
				 else
				{
					opencardam(); 
				} 
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	}); */
	opencardam();
	checkCar();
	
}

//折损车勾选控制
function checkCar()
{
	$(".checkall").click(function () {
	      var check = $(this).prop("checked");
	      $(".checkchild").prop("checked", check);
	      
	      $('#cardetable').find('tbody > tr').each(function(){
				var row = this;
				if($(".checkall").is(":checked") != true && $(this).hasClass('selected') != true)//勾选全部，但是下面每个都去掉勾选，再去掉勾选全部，是不执行任何操作，不然又全部选择了。
				{
					//alert('aa');
				} 
				else
				{
					$(this).toggleClass('selected');
				}
				
			});
	});
	var table = $('#cardetable').DataTable();	
	$('#cardetable tbody').on( 'click', 'tr', function () {
		 if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true)
		{
			$(this).toggleClass('selected');
		} 
		 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true)
		{
			$(this).toggleClass('selected');
		}
		 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') != true)
			{
			 $(".checkall").attr("checked",false);
			// $(".checkchild").prop("checked", check);
			}
		 //console.info($("input[type='checkbox']").size()+","+$("input[type='checkbox']:checked").size());	
		 if($("input[type='checkbox']:checked").size()==$("input[type='checkbox']").size()-1)
			{
			 $(".checkall").attr("checked",true);
			}
  }); 
}
	
function searchcarInfo()
{
	opencardam();
}

function opencardam(){
	$('#cardetable').DataTable({
		"destroy": true,//如果需要重新加载需销毁
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/carDamageInStock/queryDamCarStock", //获取数据的ajax方法的URL	
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
				 columns: [{
		             "sClass": "text-center",
		             "data": "id",
		             "render": function (data, type, full, meta) {
		            	 //console.info(JSON.stringify(full));
		            	 //return '<input type="checkbox"  class="checkchild"  value="' + data + '" />';
		            	 if(full.waybillId!=''&&full.waybillId!=null){
		            		 return '<input type="checkbox"  class="checkchild" checked="checked" value="' + data + '" />';
		            	 }else{
		            		 return '<input type="checkbox"  class="checkchild"  value="' + data + '" />'; 
		            	 }
		                
		             },
		             "bSortable": false,
		             "width": "4%"
		         	},{ data: "rownum" },
		         			{data: "vin"},
						    {data: "brand"},
						    {data: "model"},
						    {data: "color"},
						    {data: "engineNo"},
						    {data: "mark"},							   
						    {data: "status"}],
						    columnDefs: [{
								 //状态
								 targets: 8,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
										 return '新建';
									 }else if(data=='1'){
										 return '待复核';
									 }else if(data=='2'){
										 return '已入库';
									 }else if(data=='3'){
										 return '已出库';
									 }else{
										 return '';
									 }					
							       }	       
							}
						      ],
					        "fnServerData":retrieveDatas //与后台交互获取数据的处理函数
    });
}
function retrieveDatas(sSource, aoData, fnCallback){
	var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var vin= $.trim($("#fom_vin").val());
	   //var status = 0;
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				waybillId : $.trim($('#wabillId-hidden').val()),
				vin : vin
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.log(JSON.stringify(data.data));							
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
//清除
function clearCarDam()
{
	$('#fom_vin').val('');
	$('#wabillId-hidden').val('');
	//$('#sign').val('');
}
//关闭
function cancelCarDam()
{
	clearCarDam();
	$('#modal-carinfo').modal('hide');
}
//确定（保存勾选折损车）
function bindCarDamStock()
{
    var	flag="false";
    $('#cardetable tbody tr').each(function(){
		//console.log($(this).find(".checkchild").is(":checked"));
		 if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true)
			{
				$(this).toggleClass('selected');
			} 
			 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true)
			{
				$(this).toggleClass('selected');
			}
	});
	var table = $('#cardetable').DataTable();
	var wabillId= $('#wabillId-hidden').val();
	//var sign = $('#sign').val();
	var ids="";
	/* if(sign == 1)
	{
		//console.info('aa');
		var data = $('#cardetable tbody').children('tr.selected');
		for(i=0;i<data.length;i++)
		{
			var tr=data.eq(i);
			ids +=","+tr.find('td').eq(1).attr('data-id');
		}
	} */
	//else
	//{
		for(var i = 0;i<table.rows('.selected').data().length;i++)
		 {
			 ids+=","+table.rows('.selected').data()[i]['id'];
			 
		 }	
	//}
	ids=ids.substring(1);
	//console.info(ids);
	 if(ids==""){
		 bootbox.alert("请勾选商品车！");
		 return;
	 }
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要绑定折损车吗?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/operationMng/carDamageInStock/bindCarDamStock",
						data :JSON.stringify({
							waybillId : wabillId,
							list : ids
							}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "绑定成功！", 
									  callback: function(result){
										  if(result){
											flag="true";
											cancelCarDam();
											reload();
										  }else{
											cancelCarDam();
											reload();
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										cancelCarDam();
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
		}); 
}





//绑定配件
function dobindattachment(id){	
	$("#attachmentdetable tbody tr").remove();  
	$('#atwabillId-hidden').val(id);
	$('#modal-attachmentinfo').modal('show');
	$('#caratcaddBtn').show();	
	//var bidArray = [];
/* 	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/carDamageInStock/checkRuAttWaybillId",
		data :JSON.stringify({
			waybillId : id
			}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				if(null != data.data && data.data.length > 0)
				{
					//存在
					$('#sign-1').val("1");//标记 是修改
					for(var i = 0;i<data.data.length;i++)
					{
						//console.info(data.data[i]["id"]);
						//var id = data.data[i]["id"];
						bidArray.push(data.data[i]["id"]);
					}
					
					//console.info(JSON.stringify(bidArray));
					
					var html="",htmlItem="";
					   var secho='1';   
					   var pageStartIndex='0';
					   var pageSize=1000;
					   $('#secho').val(secho);
					   var obj = {};
						 $.ajax({
							type : 'POST',
							url : "${ctx}/operationMng/carAttachmentDamMng/getListData",
							data : JSON.stringify({
								sEcho : $.trim(secho),				
								pageStartIndex : $.trim(pageStartIndex),
								pageSize : $.trim(pageSize),
							}),
							contentType : "application/json;charset=UTF-8",
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {
									//console.log(JSON.stringify(data.data));								
									obj.iTotalDisplayRecords=data.data.totalCounts;
									obj.iTotalRecords=data.data.totalCounts;
									obj.aaData=data.data.records;		
									obj.sEcho=data.data.frontParams;
								//	console.log(JSON.stringify(obj));
									if(obj.aaData.length>0)
									{
										for(var i=0;i<obj.aaData.length;i++)
										{
											obj.aaData[i]["rownum"]=i+1;
											 if(obj.aaData[i]["status"] == 0)
											{
												obj.aaData[i]["status"] = "新建";
											}
											
											if(bidArray.length > 0)
											{
												for(var j = 0;j<bidArray.length;j++)
												{
													if(obj.aaData[i]["id"] == bidArray[j])
													{
														//console.info(obj.aaData[i]["id"]);
														htmlItem ='<tr class="selected"><td class=" text-center"><input type="checkbox" checked="checked" class="checkchild-1"></td>'
														     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
														     +'<td>'+obj.aaData[i]["attachmentName"]+'</td>'
														     +'<td>'+obj.aaData[i]["position"]+'</td>'
														     +'<td>'+obj.aaData[i]["count"]+'</td>'
														     +'<td>'+obj.aaData[i]["mark"]+'</td>'
														     +'<td>'+obj.aaData[i]["status"]+'</td></tr>';
														     break;//相等就停止循环
														     
													}
													else
													{
														htmlItem ='<tr><td class=" text-center"><input type="checkbox" class="checkchild-1"></td>'
														     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
														     +'<td>'+obj.aaData[i]["attachmentName"]+'</td>'
														     +'<td>'+obj.aaData[i]["position"]+'</td>'
														     +'<td>'+obj.aaData[i]["count"]+'</td>'
														     +'<td>'+obj.aaData[i]["mark"]+'</td>'
														     +'<td>'+obj.aaData[i]["status"]+'</td></tr>';
													}
												}
												//console.info(htmlItem);
												html+=htmlItem;
												
											}
											else
											{
												html='<tr ><td class=" text-center"><input type="checkbox" class="checkchild-1"></td>'
												     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
												     +'<td>'+obj.aaData[i]["attachmentName"]+'</td>'
												     +'<td>'+obj.aaData[i]["position"]+'</td>'
												     +'<td>'+obj.aaData[i]["count"]+'</td>'
												     +'<td>'+obj.aaData[i]["mark"]+'</td>'
												     +'<td>'+obj.aaData[i]["status"]+'</td></tr>';
											}
										}
									}else{
										html+="<tr><td colspan='7'>暂无配件信息</td></tr>";
									}
									$('#attachmentdetable tbody').html(html);
								} else {
									 bootbox.alert(data.msg);
								}
								
							}
						});
				}
				else
				{
					opencaratt(); 
				}
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	}); */
	opencaratt();
	checkAttch();
	
}

//折损配件勾选控制
function checkAttch()
{
	$(".checkall").click(function () {
	      var check = $(this).prop("checked");
	      $(".checkchild").prop("checked", check);
	      
	      $('#attachmentdetable').find('tbody > tr').each(function(){
				var row = this;
				if($(".checkall").is(":checked") != true && $(this).hasClass('selected') != true)//勾选全部，但是下面每个都去掉勾选，再去掉勾选全部，是不执行任何操作，不然又全部选择了。
				{
					//alert('aa');
				} 
				else
				{
					$(this).toggleClass('selected');
				}
				
			});
	});
	var table = $('#attachmentdetable').DataTable();	
	$('#attachmentdetable tbody').on( 'click', 'tr', function () {
		 if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true)
		{
			$(this).toggleClass('selected');
		} 
		 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true)
		{
			$(this).toggleClass('selected');
		}
		 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') != true)
			{
			 $(".checkall").attr("checked",false);
			// $(".checkchild").prop("checked", check);
			}
		 //console.info($("input[type='checkbox']").size()+","+$("input[type='checkbox']:checked").size());	
		 if($("input[type='checkbox']:checked").size()==$("input[type='checkbox']").size()-1)
			{
			 $(".checkall").attr("checked",true);
			}
  }); 
}
	
function searchattachInfo()
{
	opencaratt();
}

function opencaratt(){
	$('#attachmentdetable').DataTable({
		"destroy": true,//如果需要重新加载需销毁
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/carDamageInStock/queryDamAttachment", //获取数据的ajax方法的URL	
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
				 columns: [{
		             "sClass": "text-center",
		             "data": "id",
		             "render": function (data, type, full, meta) {
		            	 //console.info(JSON.stringify(full));
		            	 //return '<input type="checkbox"  class="checkchild-1"  value="' + data + '" />';
		            	 if(full.waybillId!=''&&full.waybillId!=null){
		            		 return '<input type="checkbox"  class="checkchild" checked="checked" value="' + data + '" />';
		            	 }else{
		            		 return '<input type="checkbox"  class="checkchild"  value="' + data + '" />'; 
		            	 }
		                
		             },
		             "bSortable": false,
		             "width": "4%"
		         	},{ data: "rownum" },
						    {data: "attachmentName"},
						    {data: "position"},
						    {data: "count"},
						    {data: "mark"},							   
						    {data: "status"}],
						    columnDefs: [{
								 //状态
								 targets: 6,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
										 return '新建';
									 }else if(data=='1'){
										 return '待复核';
									 }else if(data=='2'){
										 return '已入库';
									 }else if(data=='3'){
										 return '已出库';
									 }else{
										 return '';
									 }					
							       }	       
							}
						      ],
					        "fnServerData":retrieveAttDatas //与后台交互获取数据的处理函数
    });
}
function retrieveAttDatas(sSource, aoData, fnCallback){
	var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var attachmentName= $.trim($("#fom_attachmentName").val());
	   //var status = 0;
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				attachmentName  : attachmentName,
				waybill_id :$.trim($('#atwabillId-hidden').val())
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.log(JSON.stringify(data.data));							
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
//清除
function clearCarAtt()
{
	$('#fom_attachmentName').val('');
	$('#atwabillId-hidden').val('');
	//$('#sign-1').val('');
}
//关闭
function cancelCarAtt()
{
	clearCarAtt();
	$('#modal-attachmentinfo').modal('hide');
}
//确定（保存勾选折损配件）
function bindAttDamStock()
{
	var flag="false";
	$('#attachmentdetable tbody tr').each(function(){
		//console.log($(this).find(".checkchild").is(":checked"));
		 if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true)
			{
				$(this).toggleClass('selected');
			} 
			 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true)
			{
				$(this).toggleClass('selected');
			}
	});
	var table = $('#attachmentdetable').DataTable();
	var wabillId= $('#atwabillId-hidden').val();
	//var sign = $('#sign-1').val();
	var ids="";
	/* if(sign == 1)
	{
		//console.info('aa');
		var data = $('#attachmentdetable tbody').children('tr.selected');
		for(i=0;i<data.length;i++)
		{
			var tr=data.eq(i);
			ids +=","+tr.find('td').eq(1).attr('data-id');
		}
	}
	else
	{ */
		for(var i = 0;i<table.rows('.selected').data().length;i++)
		 {
			 ids+=","+table.rows('.selected').data()[i]['id'];
			 
		 }	
	//}
	ids=ids.substring(1);
	 //console.info(ids);
	 if(ids==""){
		 bootbox.alert("请勾选配件！");
		 return;
	 }
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要绑定配件吗?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/operationMng/carDamageInStock/bindDamAttStock",
						data :JSON.stringify({
							waybillId : wabillId,
							list : ids
							}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "绑定成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											cancelCarAtt();
											reload();
										  }else{
											cancelCarAtt();
											reload();
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										cancelCarAtt();
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
		});  
}


function doview(id){
	 cleardetil();
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/carDamageInStock/checkWaybill/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				//$('#id-hidden').val(id);
				$('#myModalLabel').html('入库单信息');
				//$("#waybillNo_view").html(data.data.waybillNo);
				$("#mark_view").html(data.data.mark);	
				if(data.data.carDamageStockList.length>0){
					for(var i=0;i<data.data.carDamageStockList.length;i++){
						data.data.carDamageStockList[i]["rownum"]=i+1;
					}
					$('#cardetable_view').dataTable({
						 dom: 'Bfrtip',	
						 destroy: true,
						 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
						 "bFilter": false,    //不使用过滤功能  
						 "bProcessing": true, //加载数据时显示正在加载信息	
						 "bPaginate" : false,
						 "bInfo" : false,
						  ordering: false,
							"oLanguage": {
								"sZeroRecords": "抱歉， 没有找到",
								"sInfoEmpty": "没有数据",
								"sInfoFiltered": "(从 _MAX_ 条数据中检索)",							
								"sZeroRecords": "没有检索到数据"
								},	
						data: data.data.carDamageStockList,
				        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
				        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
				        columns: [	
				            { data: 'rownum' },
				            {data: "vin"},
						    {data: "brand"},
						    {data: "model"},
						    {data: "color"},
						    {data: "engineNo"},
						    {data: "mark"},						   
						    /* {data: "status"} */],
						    columnDefs: [
/* {
								  targets: 1,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
										 return '商品车';
									 }else if(data=='1'){
										 return '二手车';
									 }else{
										 return '';
									 }						
							       }	       
							} */
						      ]
					});
				}
				if(data.data.carAttachmentStockList.length>0){
					for(var i=0;i<data.data.carAttachmentStockList.length;i++){
						data.data.carAttachmentStockList[i]["rownum"]=i+1;
					}
					$('#attachmentdetable_view').dataTable({
						 dom: 'Bfrtip',
						 destroy: true,
						 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
						 "bFilter": false,    //不使用过滤功能  
						 "bProcessing": true, //加载数据时显示正在加载信息	
						 "bPaginate" : false,
						 "bInfo" : false,
						  ordering: false,
							"oLanguage": {
								"sZeroRecords": "抱歉， 没有找到",
								"sInfoEmpty": "没有数据",
								"sInfoFiltered": "(从 _MAX_ 条数据中检索)",							
								"sZeroRecords": "没有检索到数据"
								},	
						data: data.data.carAttachmentStockList,
				        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
				        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
				        columns: [	
				            { data: 'rownum' },
				            {data: "attachmentName"},
						    {data: "position"},
						    {data: "count"},
						    {data: "mark"}						   
						   /*  {data: "status"} */]
					});
				}
				$('#viewBtn').show();
				$('#modal-detilinfo').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
} 
//明细页面管理
function doclose(){	
	 $('#modal-detilinfo').modal('hide'); 
}
function cleardetil(){
		//$("#waybillNo_view").html('');
		$("#mark_view").html('');
		$("#cardetable_view tbody tr").remove();  
		$("#attachmentdetable_view tbody tr").remove();  
}




</script>

</body>
</html>