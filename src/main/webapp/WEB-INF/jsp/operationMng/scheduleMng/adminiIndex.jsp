
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
<%-- <link rel="stylesheet" href="${ctx}/staticPublic/css/bootstrap-datetimepicker.css" /> --%>
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->


</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			查询管理
			<small>
				<i class="icon-double-angle-right"></i>
				调度查询管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">装运时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 200px;margin-right:30px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入时间"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 13px;width:35px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 200px;margin-right:30px;margin-left: 5px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入时间"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			<label class="title">仓库：</label>
		    <select id="stockId" class="form-box" style="width:200px;">
		      <option value="">请选择仓库</option>
		    </select>
		</div>
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;">装运车号：</label>
		    <input id="carNumber" class="form-box" type="text" style="width:200px;float: left;" placeholder="请填写装运车号(模糊查询)" onkeyup="searchSchedule(this)"/>
		    <!-- <select id="carNumber" class="form-box" style="width:200px;float: left;" placeholder="请填写货运车号(模糊查询)" onkeyup="searchSchedule(this)">
		      <option value="">请选择货运车号</option>
		    </select> -->
		     <label class="title" style="float: left;">调度员：</label>
		    <select id="operUser" class="form-box" style="width:200px;float: left;">
		      <option value="">请选择调度员</option>
		    </select>
		    <!-- <label class="title" style="width:65px;">状态：</label>
		    <select id="status" class="form-box" style="width:234px;">
		      <option value="-1">请选择状态</option>
		      <option value="0">新建</option>
		      <option value="1">待复核</option>
		      <option value="2">待仓管员已确认</option>
		      <option value="3">待驾驶员确认</option>
		      <option value="4">在途</option>
		      <option value="5">已完成</option>
		    </select> -->
		   <!--  <label class="title" style="width:60px;">仓库：</label>
		    <select id="stockId" class="form-box" style="width:200px;">
		      <option value="">请选择仓库</option>
		    </select> -->
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="searchall()" style="width:80px;">汇总查询</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>仓库</th>
					<th>调度员</th>
					<th>调度单号</th>
					<th>装运时间</th>
					<th>台数</th>
					<th>装运车号</th>
					<th>驾驶员</th>
                    <th>联系电话</th>
                    <th>状态</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 新增车辆信息 -->
			<div class="modal fade" id="modal-add" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
					 <div class="modal-header" style="padding:0 15px;">
						  <button class="close" type="button" data-dismiss="modal">×</button>
						  <h3 id="myModalLabel">入库登记</h3>
				     </div>
				     <div class="modal-body" style="padding:5px 20px;">
				       
				     </div>
				  </div>
				</div>
			</div>
			<div class="modal fade" id="modal-upload" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">操作日志信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">							
							   <div class="add-item">
							     <table id="processtable" class="table table-striped table-bordered table-hover">
			                      <thead>
				                   <tr>
                                              <th>序号</th>
                                              <th>流程步骤名称</th>
                                              <th>操作人名称</th>
                                              <th>操作时间</th>
                                              <th>审核意见</th>
                                              <th>附件</th></tr>
			                      </thead>
			                      <tbody>
			                      </tbody>
			                      </table>								     
							    </div>								  									   			  
							    <hr class="tree"></hr>							    
								 <div class="add-item-btn" id="viewBtns">								   
								    <a class="add-itemBtn btnCancle" onclick="doproceclose()">关闭</a>
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
<script type="text/javascript">
/* 获取装运车号 */
function searchSchedule(e){
	var $val=$(e).val();
	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/scheduleMng/getStockList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		data: JSON.stringify({
			no : $val
		}),
		success : function(data) {
			if (data && data.code == 200) {
				var html = "";
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<p id='+data.data[i]['id']+' onclick=\'clickp(this)\'>'+data.data[i]['no']+'</p>';
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
	
}
function clickp(e){
	$('#carNumber').val($(e).html());
	$('#selectItem8').hide();
};
$(document).click(function(event) {
   $('#selectItem8').hide();
});
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/scheduleMng/getAdminiListData" , //获取数据的ajax方法的URL							 
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
				          {data: "stockName","width":"8%"},
				          {data: "insertUserName","width":"8%"},
						  {data: "scheduleBillNo","width":"8%"},
						  {data: "sendTime","width":"8%"},
						  {data: "amount","width":"8%"},						   
						  {data: "carNumber","width":"8%"},
						  {data: "driverName","width":"8%"},
						  {data: "mobile","width":"8%"}, 
						  {data: "status","width":"12%"},
						  {data: null,"width":"19%"}],
						    columnDefs: [
											{
												//时间
												 targets:4,
												 render: function (data, type, row, meta) {
											           if(data!=''&& data!=null){
															 return jsonForDateFormat(data);
														 }else{
															 return '';
														 }
											       }	       
											},
											{
											 //状态
											 targets:9,
											 render: function (data, type, row, meta) {
												 if(data=='0'){
										        	   return '新建';
										           }
										           if(data=='1'){
										        	   return '待仓管员已确认';
										           }
										           if(data=='2'){
										        	   return '待驾驶员确认';
										           }
										           if(data=='3'){
										        	   return '在途';
										           }
										           if(data=='4'){
										        	   return '已完成';
										           }else{
										        	   return '已完成';
										           }
										       }	       
										},
										{
									    	 //操作栏
									    	 targets: 10,
									    	 render: function (data, type, row, meta) {
									    		 if(row.status=='0'){
									    			 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.type+')">查看</a>';
									    		 }else{
									    			 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.type+')">查看</a>'
										    			+'<a class="table-edit" onclick="doviewtask('+ row.id +')" style="width:70px;">操作日志</a>'; 
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
		 "sAjaxSource": "${ctx}/operationMng/scheduleMng/getAdminiListData" , //获取数据的ajax方法的URL	
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
				          {data: "stockName","width":"8%"},
				          {data: "insertUserName","width":"8%"},
						  {data: "scheduleBillNo","width":"8%"},
						  {data: "sendTime","width":"8%"},
						  {data: "amount","width":"8%"},						   
						  {data: "carNumber","width":"8%"},
						  {data: "driverName","width":"8%"},
						  {data: "mobile","width":"8%"}, 
						  {data: "status","width":"12%"},
						  {data: null,"width":"19%"}],
						  columnDefs: [
										{
											//时间
											 targets:4,
											 render: function (data, type, row, meta) {
										           if(data!=''&& data!=null){
														 return jsonForDateFormat(data);
													 }else{
														 return '';
													 }
										       }	       
										},
										{
										 //状态
										 targets:9,
										 render: function (data, type, row, meta) {
											 if(data=='0'){
									        	   return '新建';
									           }
									           if(data=='1'){
									        	   return '待仓管员已确认';
									           }
									           if(data=='2'){
									        	   return '待驾驶员确认';
									           }
									           if(data=='3'){
									        	   return '在途';
									           }
									           if(data=='4'){
									        	   return '已完成';
									           }else{
									        	   return '已完成';
									           }
									       }	       
									},
									{
								    	 //操作栏
								    	 targets: 10,
								    	 render: function (data, type, row, meta) {
								    		 if(row.status=='0'){
								    			 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.type+')">查看</a>';
								    		 }else{
								    			 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.type+')">查看</a>'
									    			+'<a class="table-edit" onclick="doviewtask('+ row.id +')" style="width:70px;">操作日志</a>'; 
								    		 }
							                    
							                }	       
							    	}
								      ],
							        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

/* 获取装运车号 */
/* function getCarList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/scheduleMng/getStockList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: JSON.stringify({}),
	        success: function (data) {
	        	var html ='<option value="">请选择货运车</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['no']+'>'+data.data[i]['no']+'</option>';
	                		}
	            		}
	            	}
	            	$('#carNumber').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
 } */
/* 获取仓库号 */
function getStockList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/scheduleMng/getBasicStockList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="">请选择仓库</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	                		}
	            		}
	            	}
	            	$('#stockId').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
 }
 //获取调度员
 function getSchUser(){
	 $.ajax({  
	        url: '${ctx}/operationMng/scheduleMng/getSchUser',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        success: function (data) {
	        	var html ='<option value="">请选择调度员</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	                		}
	            		}
	            	}
	            	$('#operUser').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
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
	//getCarList();
	getStockList();
	getSchUser();
});

/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var status=$.trim($('#status').val());
	   if(status==null || status=='' || status=='-1'){
		   status="";
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
				sendTimeStart : $.trim($('#startTime').val()),
				sendTimeEnd :$.trim($('#endTime').val()),
				carNumber :$.trim($('#carNumber').val()),
				stockId :$('#stockId').val(),
				insertUser : $('#operUser').val()
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.info(JSON.stringify(data.data));					
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

/* 查看详细调度信息 */
function doshow(e,type){
	var flag="2";
	var scheduleBillNo=$(e).attr("data-scheduleBillNo");
	if(type=='0'){
		location.href="${ctx}/operationMng/scheduleMng/adminiDetail/"+scheduleBillNo;
	}else{
		location.href="${ctx}/operationMng/scheduleMng/fastDetailIndex/"+scheduleBillNo+'/'+flag;
	}
	
	
}

function doproceclose(){
	 $('#modal-upload').modal('hide'); 
}
/*获取操作日志的详细信息*/
function doviewtask(detailId){	 
	 $('#viewBtns').show();
	 $('#modal-upload').modal('show');
	 $.ajax({
			type : 'POST',
			url : "${ctx}/dailyOffice/waitingDo/getDetailInfoDetailId",
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			data : JSON.stringify({
				detailId : $.trim(detailId),
				type : 'DDD'
			}),
			success : function(data) {
				if (data && data.code == 200) {
					console.log(JSON.stringify(data.data));	
					if(data.data.logList.length>0){
						for(var i=0;i<data.data.logList.length;i++){
							data.data.logList[i]["rownum"]=i+1;
						}
						$('#processtable').dataTable({
							 "destroy": true,//如果需要重新加载需销毁
							 dom: 'Bfrtip',
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
							data: data.data.logList,
					        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
					        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
					        columns: [	
					            { data: 'rownum' },
					            {data: "processDetailName"},
							    {data: "operateUserName"},
							    {data: "operateTime"},
							    {data: "mark"},
							    {data: "attachFileName"}],
							    columnDefs: [{
									 //入职时间
									 targets: 3,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonDateFormat(data);
										 }else{
											 return '';
										 }			
								       }	       
								},{
									 //入职时间
									 targets: 5,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 var attachFilePaths="${ctx}"+row.attachFilePath;
											 return '<a  href='+attachFilePaths+' target="_blank">'+data+'</a>';
										 }else{
											 return '';
										 }			
								       }	       
								}
							      ]
						});
				}}}
			});
}
function searchall(){
	parent.addTabs({id : '99999',title : '汇总查询',close : true,url : '${ctx}/operationMng/scheduleMng/sumSearchIndex'});
}
</script>



</body>
</html>






