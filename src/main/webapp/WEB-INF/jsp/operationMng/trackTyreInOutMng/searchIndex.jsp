
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/chosen.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
	.chosen-container{
	width:400px;
	}
	.aa{
	width: 65px;
    height: 36px;
    display: block;
    float: left;
    cursor: pointer;
    text-decoration: none;
    background: #2ca9e1;
    color: #fff;
    text-align: center;
    font-size: 14px;
    line-height: 30px;
    border-radius: 3px;
    padding: 3px;
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
				轮胎出入库查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">		
			 <label class="title" style="float: left;height: 34px;line-height: 34px;">开始时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 175px;margin-right:15px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="form_startTime" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width:75px;">结束时间：</label>
		   <div class="input-group input-group-sm" style="float: left;width: 175px;margin-right:15px;height: 34px;line-height: 34px;">
				<input class="form-control" id="form_endTime" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
							   
		</div>
		<div class="searchbox col-xs-12">			
		   <!-- <label class="title">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</label> -->
		   <!-- <select id="fom_status" class="form-box" style="width:170px;">
			   <option value="">请选择状态</option>
			   <option value="0">新建</option>
			   <option value="1">待复核</option>
			   <option value="2">已完成</option>
		   	</select> -->
		   	<label class="title">出入库单号：</label>
			<input id="form_billNo" class="form-box" type="text" placeholder="请输入出入库单号" style="width:170px;" />
			<label class="title" style="width: 75px;">类型：</label>
		   	<select id="fom_type" class="form-box" >
		   		<option value="">请选择类型</option>
		   		<option value="0">入库</option>
		   		<option value="1">出库</option>
		   	</select>
			<label class="title" style="width: 75px;">状态：</label>
		   	<select id="fom_status" class="form-box" >
		   		<option value="">请选择状态</option>
		   		<option value="0">新建</option>
		   		<option value="1">待复核</option>
		   		<option value="2">已完成</option>
		   	</select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<!-- <a class="itemBtn" onclick="doadd()">新增</a> -->
		</div>
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>出库单号</th>
                    <th>类型</th>
                    <th>备注</th>                                        
                    <th>创建时间</th>
                    <th>创建人</th>
                    <th>状态</th>                   
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">新增轮胎出库信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							  <div id="biilno-hidden">
							 <div class="add-item extra-item">
							     <label class="title">单据号：</label>
							       <p id="billNo" class="form-control no-border"></p>
							  <!--  <input id="billNo" class="form-control" type="text" placeholder="请填写单据号"/>			 -->				    
							  </div>
							  <hr class="tree"></hr>
							 </div> 
								
							<div class="add-item extra-item">
							     <label class="title"><span class="red">*</span>类型：</label>
							     <p id="type" class="form-control no-border">出库</p>
							     <input class="form-control" id="id-hidden" type="hidden"/>
							  </div>	
							   <div id="tyreNo-hidden">						  
							 <hr class="tree"  ></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-3" style="margin-left:-25px;"><span class="red">*</span>轮胎信息 ：</label>
							     <a class="form-btn col-xs-9" id="addtyreItem" onclick="bindTyre()" style="margin-bottom:10px;"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>选择轮胎</a>
							     <div id="newTyreDetail"></div>
							  </div>
							  </div>							   
							  <hr class="tree"></hr>
							  <div class="add-item extra-item">
							     <label class="title"><span class="red">*</span>备注 ：</label>
							    <textarea class="form-control" rows="3" id="mark" name="mark" placeholder="请填写备注  " ></textarea> 							    
							  </div>
							  <div id="tyreNos-hidden">						  
							 <hr class="tree" style="margin-top: 50px;"></hr>
							  <div class="add-item">
							     <label class="title"><span class="red">*</span>轮胎 ：</label>							   
							      <table id="tyreNo_detailtable" class="table table-striped table-bordered table-hover">
			                              <thead>
					                           <tr>														
					                        	<th>序号</th>
					                           	<th>轮胎编号</th>				                      
	                                            <th>尺寸</th>
	                                            <th>装运车号</th>                                        
	                                            <th>备注 </th>                                            
					                            </tr>
			                                 </thead>
			                                   <tbody>
			                                   </tbody>
		                                    	</table>							     
							  </div>
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
								   <div class="add-item-btn" id="viewBtn">
								   <!--  <a class="add-itemBtn btnOk" onclick="update()" style="margin-left: 130px;">更新</a> -->
								    <a class="add-itemBtn btnOk" onclick="refresh()" style="margin-left: 130px;">关闭</a>
								  </div> 
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
			<!-- 新增轮胎信息--Modal begin-->
	<div class="modal fade" id="modal-addCar" tabindex="-1" role="dialog" style="width:1000px;">
		     <div class="modal-header" style="padding:0 15px;">
		        <button class="close" type="button" data-dismiss="modal">×</button>
				<h3 id="myModalLabel">选择轮胎</h3>
		    </div>
			<div class="modal-body" style="height:498px;">
			  <div class="widget-box dia-widget-box">
					<div class="widget-body">
						<div class="widget-main">
							
						<div class="add-item extra-item">
							   <label class="title" style="float: left;width: 50px;">类型：</label>
						<select id="typeSearch" class="form-box" style="width: 234px;float: left">
		   					<option value="">请选择状态</option>
		   					<option value="0">轮胎</option>
		   					<option value="1">钢圈</option>
		   				</select>
						<label class="title" style="float: left;width: 50px;margin-left: 20px;">品牌：</label>	    
						<input id="brandSearch" class="form-box" type="text" placeholder="请输入品牌" style="width:170px;float: left;" />
						<label class="title" style="float: left;width: 50px;margin-left: 20px;">尺寸：</label>
						<input id="sizeSearch" class="form-box" type="text" placeholder="请输入尺寸" style="width:170px;float: left;" /> 
						<a class="add-itemBtntr" onclick="searchChoose()">查询</a>
						 </div>	
					    <hr class="tree"  ></hr>
						  <table id="tyreTable" class="table table-striped table-bordered table-hover">
			                      <thead>
				                    <tr>	
					                   <th class="center"><input type="checkbox" class="checkall" /></th>													
						               <th>序号</th>
						               <th>类型</th>
						               <th>轮胎编号</th>
						               <th>品牌</th>
	                                   <th>尺寸</th>	                                                                                                                                           
				                     </tr>
			                      </thead>
			                      <tbody>
			                       
			                      </tbody>
			                 </table>							   			  
							 <hr class="tree"></hr>
							 <div class="add-item-btn dis-block">
								  <a class="add-itemBtn btnOk" onclick="savetyre();">保存</a>
								  <a class="add-itemBtn btnCancle" onclick="cancleTyre();">关闭</a>
							  </div>			
						</div>
					</div>
			  </div>
			</div>
	</div>
	<!-- 新增轮胎信息--Modal end-->
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
<script src="${ctx}/staticPublic/js/chosen.jquery.min.js"></script>
<script type="text/javascript">
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/trackTyreInOutMng/getAdminListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{data: "rownum",'width':"10%"},
		    {data: "billNo",'width':"15%"},
		    {data: "type",'width':"10%"},
		    {data: "mark",'width':"10%"},
		    {data: "insertTime",'width':"15%"},
		    {data: "insertUserName",'width':"10%"},
		    {data: "status",'width':"10%"},
		    {data: null,'width':"20%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 2,
				 render: function (data, type, row, meta) {
					if(data=='0'){
						return '入库';
					}else if(data=='1'){
						return '出库';
					}
			       }	       
			},{
				 //入职时间
				 targets: 6,
				 render: function (data, type, row, meta) {
					if(data=='0'){
						return '新建';
					}else if(data=='1'){
						return '待复核';
					}else if(data=='2'){
						return '已完成';
					}
			       }	       
			},{
					 //入职时间
					 targets: 4,
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
			    	 targets: 7,
			    	 render: function (data, type, row, meta) {
			    		 /* if(row.status=='0'){
			    			 return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
			    			   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
					           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
			    		 }else{
			    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'; 
			    		 } */
			    		 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'; 
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
		 "sAjaxSource": "${ctx}/operationMng/trackTyreInOutMng/getAdminListData", //获取数据的ajax方法的URL	
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
				columns: [{data: "rownum",'width':"10%"},
						    {data: "billNo",'width':"15%"},
						    {data: "type",'width':"10%"},
						    {data: "mark",'width':"10%"},
						    {data: "insertTime",'width':"15%"},
						    {data: "insertUserName",'width':"10%"},
						    {data: "status",'width':"10%"},
						    {data: null,'width':"20%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 2,
								 render: function (data, type, row, meta) {
									if(data=='0'){
										return '入库';
									}else if(data=='1'){
										return '出库';
									}
							       }	       
							},{
								 //入职时间
								 targets: 6,
								 render: function (data, type, row, meta) {
									if(data=='0'){
										return '新建';
									}else if(data=='1'){
										return '待复核';
									}else if(data=='2'){
										return '已完成';
									}
							       }	       
							},{
									 //入职时间
									 targets: 4,
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
							    	 targets: 7,
							    	 render: function (data, type, row, meta) {
							    		 /* if(row.status=='0'){
							    			 return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
							    			   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
									           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
							    		 }else{
							    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'; 
							    		 } */
							    		 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'; 
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	//BindCarNo();//绑定货运车carNumbertyreNo
	//BindOutSour();//绑定供应商
	$("#form_startTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#form_endTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
})

/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var startTime=$("#form_startTime").val();
	   var endTime=$("#form_endTime").val(); 
	   var status=$("#fom_status").val(); 
	   var type=$("#fom_type").val(); 
	   var billNo=$("#form_billNo").val(); 
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				startTime :$.trim(startTime),
				endTime :$.trim(endTime),
				status : status,
				type : type,
				billNo : $.trim(billNo)
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

	
/* 删除轮胎出/入库信息 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该轮胎出库信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/trackTyreInOutMng/delete/"+id,
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
	$('#myModalLabel').html('新增轮胎出库信息');	
	$('#modal-info').modal('show');
	$('#biilno-hidden').hide();
	$('#tyreNos-hidden').hide();
	$('#tyreNo-hidden').show();
	$("#type").attr("disabled",false);
	$("#tyreNo").attr("disabled",false);
	$("#mark").attr("disabled",false);
}
//绑定轮胎
/* function BindCarNo(){
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackTyreInOutMng/queryTrackTyre",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var html ='<option value="">请选择轮胎</option>';
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	        				
	            			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['tyreNo']+'-'+data.data[i]['size']+'</option>';
	            		}
	        		}
	        	}
	        	$('#tyreNo').html(html);
	        	$('#tyreNo').addClass('tag-input-style');
	        	$('.chosen-select').chosen({allow_single_deselect:true}); 
	        		$('#modal-info').find('.chosen-container').each(function(){
	        			$(this).css('width' , '580px');
    					$(this).find('a:first-child').css('width' , '100%');
    					$(this).find('.default').css('width' , '100%');
    					$(this).find('.default').css('height' , '30px');
    					$(this).find('.chosen-drop').css('width' , '100%');
    					$(this).find('.chosen-search input').css('width' , '100%');
	        		});
	        				
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
} */


/* 关闭窗体 */
function refresh(){
	clear();
	$('#modal-info').modal('hide');
	
}
/* 数据重置 */
function clear(){
	$('#id-hidden').val('');
	$('#type').val('1');
	$('#tyreNo').val('');	
	$('#mark').val('');
	$('#newTyreDetail').html('');
}
/* 保存新增轮胎库存信息 */
function save(){
	var flag="false";
	var type="1";
	var tyreNo=$('#tyreNo').val();	
	var mark=$('#mark').val();	
	var tyreNos="";
	if(mark==''|| mark==null){
		bootbox.alert('备注不能为空！');
		return;
	}
	 var tyreList=$('#newTyreDetail tbody').children('tr');
	 var tyreIds="";
	 if(tyreList.length>0){
		 for(var j=0;j<tyreList.length;j++){
			 var carTr=tyreList.eq(j);
			 tyreIds+=","+carTr.find('td').eq(0).attr('data-id');
		 } 
		 tyreIds=tyreIds.substring(1);
	 }else{
		 tyreIds='';
	 }
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该轮胎出库信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackTyreInOutMng/save',
						data : JSON.stringify({				
							ids : tyreIds,
							mark : mark
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
function doedit(id){	
	clear();
	//BindCarNo();//绑定轮胎
	$('#biilno-hidden').hide();
	$('#tyreNos-hidden').hide();
	$('#tyreNo-hidden').show();
	$("#type").attr("disabled",false);
	$("#tyreNo").attr("disabled",false);
	$("#mark").attr("disabled",false);
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackTyreInOutMng/getDetail/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑轮胎出库信息');
				$('#type').val(data.data.type);
				var type=data.data.type;
				var ids = data.data.buyBillNo;//轮胎出库 这个字段存的是轮胎库存的id，
				 var tyreIds=ids.split(",");
				/* if(tyreIds.length>0){
					for(var i=0;i<tyreIds.length;i++){
						$("#tyreNo option[value='"+tyreIds[i]+"']").attr("selected",true);  	
					}
				}  */
				//console.info(JSON.stringify(tyreIds));
				var size=0;
				var htmlItem='',html="";
				var hl = "";
				 $.ajax({
						type : 'POST',
						url : "${ctx}/operationMng/trackTyreInOutMng/queryTrackTyre",
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						data : JSON.stringify({
							
						}),
						success : function(data) {
							if (data && data.code == 200) {	
								if(data.data.length>0){
									if(tyreIds.length>0){
										for(var j=0;j<tyreIds.length;j++){
										
										for(var i=0;i<data.data.length;i++){
											if("0" == data.data[i]["type"])
											{
												data.data[i]["type"] = '轮胎';
											}else if("1" == data.data[i]["type"]){
												data.data[i]["type"] = '钢圈';
											}else{
												data.data[i]["type"] = '';
											}
											if("null" == data.data[i]["brand"] || null == data.data[i]["brand"])
											{
												data.data[i]["brand"] = '';
											}
												if(data.data[i]["id"]==tyreIds[j]){
													htmlItem='<tr><td data-id='+data.data[i]["id"]+'>'+data.data[i]["type"]+'</td>'
														 +'<td>'+data.data[i]["tyreNo"]+'</td>'
														 +'<td>'+data.data[i]["brand"]+'</td>'
														 +'<td>'+data.data[i]["size"]+'</td>'
													     +'<td><a class="deleteBtn" onclick="deleteTyre(this)">删除</a></td></tr>';
													     size++;
													     break;
												}
											}
											//console.info(htmlItem);
											hl += htmlItem
											//console.info(hl);
											//html+=htmlItem;
										}
									}
									
								}else{
									html+="<tr><td colspan='9'>暂无轮胎信息</td></tr>";
								}
								html='<table class="carList table table-striped table-bordered table-hover">'
							        +'<thead><tr><th>类型</th><th>轮胎编号</th><th>品牌</th><th>尺寸</th><th>操作</th></tr></thead>'
							        +'<tbody>'+hl+'</tbody>';
								$('#newTyreDetail').html(html);
								
							} 
							
						}
					 });
				$("#tyreNo").trigger("chosen:updated");
				$('#mark').val(data.data.mark);				
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
	var type=$('#type').val();
	//var tyreNo=$('#tyreNo').val();	
	var mark=$('#mark').val();	
	var tyreNos="";
	if(type==''|| type==null){
		bootbox.alert('类型不能为空！');
		return;
	}
	if(mark==''|| mark==null){
		bootbox.alert('备注不能为空！');
		return;
	}
	 var tyreList=$('#newTyreDetail tbody').children('tr');
	 var tyreIds="";
	 if(tyreList.length>0){
		 for(var j=0;j<tyreList.length;j++){
			 var carTr=tyreList.eq(j);
			 tyreIds+=","+carTr.find('td').eq(0).attr('data-id');
		 } 
		 tyreIds=tyreIds.substring(1);
	 }else{
		 tyreIds='';
	 }
	 //console.info(tyreIds);
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该轮胎信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackTyreInOutMng/update',
						data : JSON.stringify({
							id : id,			
							ids : tyreIds,
							mark : mark
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
//提交信息
function dosubmit(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该轮胎出库信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'GET',
						url : '${ctx}/operationMng/trackTyreInOutMng/submit/'+id,
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
function doview(id){
	clear();
	$('#biilno-hidden').show();
	$('#tyreNos-hidden').show();
	$('#tyreNo-hidden').hide();
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackTyreInOutMng/getInoutDetail/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('轮胎出库信息');
				$('#billNo').html(data.data.billNo);
				$('#type').val(data.data.type);
				$('#mark').val(data.data.mark);	
				$("#billNo").attr("disabled",true);				
				$("#type").attr("disabled",true);
				$("#mark").attr("disabled",true);
				if(data.data.detailList.length>0){
					for(var i=0;i<data.data.detailList.length;i++){
						data.data.detailList[i]["rownum"]=i+1;
						if(data.data.detailList[i]["carNumber"]==null){
							data.data.detailList[i]["carNumber"]="";
						}
						if(data.data.detailList[i]["mark"]==null){
							data.data.detailList[i]["mark"]="";
						}
					}
					$('#tyreNo_detailtable').dataTable({
						 dom: 'Bfrtip',
						 "destroy": true,//如果需要重新加载需销毁
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
						data: data.data.detailList,
				        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
				        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
				        columns: [	
				            { data: 'rownum' },
				            {data: "tyreNo"},
						    {data: "size"},
						    {data: "carNumber"},
						    {data: "mark"},							   
						    /* {data: "status"} */]
					});	
				}
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

/* 选择轮胎信息 */
function bindTyre(){
	     var size=0,all=0;
		 var html="",htmlItem="";
		 var partId="";
		 var arr=[];
		 $('#newTyreDetail table tbody').find('tr').each(function(){
			 var partItem=$(this).find('td').eq(0).attr('data-id');
			 if(partItem!=null && partItem!=''){
				 partId+=partItem+',';
			 }
			
		 });
		 var type=$('#type').val();
			 partId = partId.substring(0, partId.length-1);
			 arr = partId.split(',');
			 var obj = {};
				 $.ajax({
					type : 'POST',
					url : "${ctx}/operationMng/trackTyreInOutMng/queryTrackTyre",
					contentType : "application/json;charset=UTF-8",
					dataType : 'JSON',
					data : JSON.stringify({
						type : $.trim($('#typeSearch').val()),
						brand : $.trim($('#brandSearch').val()),
						ssize : $.trim($('#sizeSearch').val())
					}),
					success : function(data) {
						if (data && data.code == 200) {	
							if(data.data.length>0){
								for(var i=0;i<data.data.length;i++){
									data.data[i]["rownum"]=i+1;
									if("0" == data.data[i]["type"])
									{
										data.data[i]["type"] = '轮胎';
									}else if("1" == data.data[i]["type"])
									{
										data.data[i]["type"] = '钢圈';
									}else{
										data.data[i]["type"] = '';
									}
									
									if(null == data.data[i]["brand"] || "" == data.data[i]["brand"])
									{
										data.data[i]["brand"] = '';
									}
									if(arr.length>0){
										for(var j=0;j<arr.length;j++){
											if(data.data[i]["id"]==arr[j]){
												htmlItem='<tr class="selected"><td class="text-center"><input type="checkbox" checked="checked" class="checkchild"></td>'
												     +'<td data-id="'+data.data[i]["id"]+'">'+data.data[i]["rownum"]+'</td>'
												     +'<td>'+data.data[i]["type"]+'</td>'
												     +'<td>'+data.data[i]["tyreNo"]+'</td>'	
												     +'<td>'+data.data[i]["brand"]+'</td>'
												     +'<td>'+data.data[i]["size"]+'</td></tr>';
												     size++;
												     break;
											}else{
												htmlItem='<tr><td class=" text-center"><input type="checkbox" class="checkchild"></td>'
													 +'<td data-id="'+data.data[i]["id"]+'">'+data.data[i]["rownum"]+'</td>'
												     +'<td>'+data.data[i]["type"]+'</td>'
												     +'<td>'+data.data[i]["tyreNo"]+'</td>'	
												     +'<td>'+data.data[i]["brand"]+'</td>'
												     +'<td>'+data.data[i]["size"]+'</td></tr>';
											}
											
										}
										html+=htmlItem;
									}else{
										html+='<tr><td class="text-center"><input type="checkbox" class="checkchild"></td>'
											 +'<td data-id="'+data.data[i]["id"]+'">'+data.data[i]["rownum"]+'</td>'
											 +'<td>'+data.data[i]["type"]+'</td>'
										     +'<td>'+data.data[i]["tyreNo"]+'</td>'	
										     +'<td>'+data.data[i]["brand"]+'</td>'
										     +'<td>'+data.data[i]["size"]+'</td></tr>';
									}
								}
								if(size==all && size>0){
									 checkChooseCar(true);
								 }else{
									 checkChooseCar(false); 
								 }
							}else{
								html+="<tr><td colspan='9'>暂无轮胎信息</td></tr>";
							}
							$('#tyreTable tbody').html(html);
							
						} 
						
					}
				 });
				 $('#modal-addCar').modal('show');
		 
 } 
 
 function searchChoose()
 {
	 bindTyre();
 }
/* 轮胎多选框选择 */
function checkChooseCar(flag){
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
	   
	$('#tyreTable tbody').on( 'click', 'tr', function () {
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
/* 保存轮胎信息 */
function savetyre(){
	 var idList="";
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要新增轮胎信息?", 
		  callback: function(result){
			  if(result){
				    var index=$("#detail-Id").val()
					var table=$('#tyreTable tbody');
					var objs=[];
					var htmlItem='',html="";
					for(i=0;i<table.children('tr.selected').length;i++){
						var obj={};
						var tr=table.children('tr.selected').eq(i);
						obj.id=tr.find('td').eq(1).attr('data-id');
						obj.type=tr.find('td').eq(2).html();
						obj.tyreNo=tr.find('td').eq(3).html();
						obj.brand=tr.find('td').eq(4).html();
						obj.size=tr.find('td').eq(5).html();
						objs.push(obj);
						htmlItem+='<tr><td data-id='+obj.id+'>'+obj.type+'</td><td>'+obj.tyreNo+'</td><td>'+obj.brand+'</td><td>'+obj.size+'</td>'						    
						    +'<td><a class="deleteBtn" onclick="deleteTyre(this)">删除</a></td></tr>';
					}
					html='<table class="carList table table-striped table-bordered table-hover">'
				        +'<thead><tr><th>类型</th><th>轮胎编号</th><th>品牌</th><th>尺寸</th><th>操作</th></tr></thead>'
				        +'<tbody>'+htmlItem+'</tbody>';
					$('#newTyreDetail').html(html);
					$('#modal-addCar').modal('hide');

					
			  }
		  }
	 });
}
/* 删除轮胎信息 */
function deleteTyre(e){
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该轮胎信息?", 
		  callback: function(result){
			  if(result){
				  $(e).parents('tr').remove();
			  }
		  }
	 })
}
/* 关闭轮胎信息 */
function cancleTyre(){
	 $('#modal-addCar').modal('hide');
}
</script>



</body>
</html>






