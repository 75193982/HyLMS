
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
				调度管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">装运时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 150px;margin-right:30px; margin-left: 5px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入时间"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 13px;width:39px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 150px;margin-right:30px;margin-left: 5px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入时间"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			<label class="title">调度单号：</label>
		   <input id="scheduleBillNo" class="form-box" type="text" placeholder="请输入调度单号" style="width:150px;"/>
		</div>
		<div class="searchbox col-xs-12">
		    <label class="title">装运车号：</label>
		    <select id="carNumber" class="form-box" style="width:150px;">
		      <option value="">请选择装运车号</option>
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
		    <label class="title" style="width:60px;">仓&nbsp;&nbsp;库：</label>
		    <select id="stockId" class="form-box" style="width:150px;">
		      <option value="">请选择仓库</option>
		    </select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="doadd()">新增</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>调度单号</th>
					<th>装运时间</th>
                    <th>交车时间</th>
                    <!-- <th>预计到达时间</th> -->
                    <th>货运车号</th>
                    <th>驾驶员</th>
                    <!-- <th>出发地</th>
                    <th>目的地</th> -->
                    <th>仓库</th>
                    <th>状态</th>
                    <th>创建时间</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>			
			<!-- 追加预付信息 开始-->
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal" onclick="refresh();">×</button>
					<h3 id="myModalLabel">追加预付信息</h3>
				</div>
				<div class="modal-body">
				   <div>
                         <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>预付现金：</label>
							     <input class="form-control" id="prepayCash" type="text" placeholder="请输入预付现金" onblur="revaildate(this,0);"/>
							     <input class="form-control" id="id-hidden" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title">开户行：</label>
							     <input class="form-control" id="bankName" type="text" placeholder="请输入开户行"/>
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title">账号：</label>
							     <input class="form-control" id="bankAccount" type="text" placeholder="请输入账号" onblur="cardNoConfirmBlur(this,0);"/>
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title">预付油卡卡号：</label>
							     <input class="form-control" id="oilCardNo" type="text" placeholder="请输入预付油卡卡号" onblur="cardNoConfirmBlur(this,1);"/>
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title">预付油费：</label>
							     <input class="form-control" id="oilAmount" type="text" placeholder="请输入金额" onblur="revaildate(this,1);" />
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">备注：</label>
							     <textarea class="form-control" rows="3" id="mark" name="mark" placeholder="请填写备注" ></textarea> 
							  </div>							  
							    <hr class="tree" style="margin-top: 50px;"></hr>
							    <div class="add-item-btn" id="addBtn">
								    <a class="add-itemBtn btnOk" onclick="dorefsave();" style="margin-left: 130px;">保存</a>
								    <a class="add-itemBtn btnOk" onclick="refresh();">关闭</a>
								 </div>
								 
								</div>
						    </div>
					      </div>
				</div>
			
			</div>
			<!-- 追加预付信息 结束-->
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
		 "sAjaxSource": "${ctx}/operationMng/scheduleMng/getListData" , //获取数据的ajax方法的URL							 
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
						    {data: "scheduleBillNo","width":"13%"},
						    {data: "sendTime","width":"10%"},
						    {data: "receiveTime","width":"10%"},
						    /* {data: "planReachTime","width":"10%"}, */
						    {data: "carNumber","width":"10%"},
						    {data: "driverName","width":"11%"},
						   /*  {data: "startAddress","width":"10%"},
						    {data: "endAddress","width":"10%"}, */
						    {data: "stockName","width":"10%"},
						    {data: "status","width":"8%"},
						    {data: "insertTime","width":"8%"},
						    {data: null,"width":"15%"}],
						    columnDefs: [
											{
												//时间
												 targets:2,
												 render: function (data, type, row, meta) {
											           if(data!=''&& data!=null){
															 return jsonForDateFormat(data);
														 }else{
															 return '';
														 }
											       }	       
											},
											{
												//时间
												 targets:3,
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
											 targets:7,
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
											//创建时间
									    	 targets: 8,
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
									    	 targets: 9,
									    	 render: function (data, type, row, meta) {
									    		 if(row.status=='0'){
									    			 if(row.type=='1'){
									    				 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doeditFast(this)">编辑</a>';
									    			 }else{
									    				 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="dosubmit(this)">提交</a>'
								                           +'<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doedit(this)">编辑</a>'
												           +'<a class="table-delete" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="dodelete(this)">删除</a>'; 
									    			 }
									    			
									    		 }else if(row.status=='1'){
									    			 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.type+')">查看</a>';
							                          
									    		 }else{
									    			 if(row.type=='1')
									    			{
									    				 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.type+')">查看</a>';
										    			 
									    			}
									    			 else
									    			{
									    				 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.type+')">查看</a>' 
										    			 +'<a class="table-edit" style="width:66px;" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doaddref(this)">追加预付</a>';
									    			}
							                          
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
		 "sAjaxSource": "${ctx}/operationMng/scheduleMng/getListData" , //获取数据的ajax方法的URL	
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
						    {data: "scheduleBillNo","width":"13%"},
						    {data: "sendTime","width":"10%"},
						    {data: "receiveTime","width":"10%"},
						    /* {data: "planReachTime","width":"10%"}, */
						    {data: "carNumber","width":"10%"},
						    {data: "driverName","width":"11%"},
						   /*  {data: "startAddress","width":"10%"},
						    {data: "endAddress","width":"10%"}, */
						    {data: "stockName","width":"10%"},
						    {data: "status","width":"8%"},
						    {data: "insertTime","width":"8%"},
						    {data: null,"width":"15%"}],
						    columnDefs: [
											{
												//时间
												 targets:2,
												 render: function (data, type, row, meta) {
											           if(data!=''&& data!=null){
															 return jsonForDateFormat(data);
														 }else{
															 return '';
														 }
											       }	       
											},
											{
												//时间
												 targets:3,
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
											 targets:7,
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
											//创建时间
									    	 targets: 8,
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
									    	 targets: 9,
									    	 render: function (data, type, row, meta) {
									    		 if(row.status=='0'){
									    			 if(row.type=='1'){
									    				 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doeditFast(this)">编辑</a>';
									    			 }else{
									    				 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="dosubmit(this)">提交</a>'
								                           +'<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doedit(this)">编辑</a>'
												           +'<a class="table-delete" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="dodelete(this)">删除</a>'; 
									    			 }
									    		 }else if(row.status=='1'){
									    			 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.type+')">查看</a>';
							                          
									    		 }else{
									    			 if(row.type=='1')
										    			{
										    				 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.type+')">查看</a>';
											    			 
										    			}
										    			 else
										    			{
										    				 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.type+')">查看</a>' 
											    			 +'<a class="table-edit" style="width:66px;" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doaddref(this)">追加预付</a>';
										    			}
									    		 }
								                    
								                }	       
								    	}
								      ],
							        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

/* 获取装运车号 */
 function getCarList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/scheduleMng/getStockList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: JSON.stringify({}),
	        success: function (data) {
	        	var html ='<option value="">请选择货运车号</option>';
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
  }
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
	getCarList();
	getStockList();
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
				scheduleBillNo:$('#scheduleBillNo').val()
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

/* 新增调度单 */
function doadd(){
	location.href="${ctx}/operationMng/scheduleMng/add";
}



/* 删除调度单 */
function dodelete(e){
	var flag="false";
	var scheduleBillNo=$(e).attr("data-scheduleBillNo");
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该调度信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/scheduleMng/delete/"+scheduleBillNo,
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

/* 提交调度单 */
function dosubmit(e){
	var flag="false";
	var scheduleBillNo=$(e).attr("data-scheduleBillNo");
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该调度信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/scheduleMng/submit/"+scheduleBillNo,
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								 bootbox.confirm_alert({ 
									  size: "small",
									  message: "提交成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
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

/* 查看详细调度信息 */
function doshow(e,type){
	var flag="1";
	var scheduleBillNo=$(e).attr("data-scheduleBillNo");
	if(type=='0'){
		location.href="${ctx}/operationMng/scheduleMng/detail/"+scheduleBillNo;
	}else{
		location.href="${ctx}/operationMng/scheduleMng/fastDetailIndex/"+scheduleBillNo+'/'+flag;
	}
	
	
}

/* 编辑详细调度信息 */
function doedit(e){
	var scheduleBillNo=$(e).attr("data-scheduleBillNo");
	location.href="${ctx}/operationMng/scheduleMng/edit/"+scheduleBillNo;
	
}
/* 编辑快速调度信息 */
function doeditFast(e){
	var scheduleBillNo=$(e).attr("data-scheduleBillNo");
	parent.addTabs({id:'1120',title: '快速调度',close : true,url : '${ctx}/operationMng/scheduleMng/fastIndex?scheduleBillNo=' + scheduleBillNo});
	
}
/* 追加预付信息 */
function doaddref(e){
	var scheduleBillNo=$(e).attr("data-scheduleBillNo");

	$('#addBtn').show();
	$('#modal-info').modal('show');
	$('#id-hidden').val(scheduleBillNo);
}
function clear(){
	$('#id-hidden').val('');
	$('#prepayCash').val('');
	$('#bankName').val('');	
	$('#bankAccount').val('');
	$('#oilCardNo').val('');
	$('#oilAmount').val('');
	$('#mark').val('');
}
/*追加装运预付信息*/
function dorefsave(){
	var scheduleBillNo=$('#id-hidden').val();
	var prepayCash=$('#prepayCash').val();
	var bankName=$('#bankName').val();
	var bankAccount=$('#bankAccount').val();
	var oilCardNo=$('#oilCardNo').val();
	var oilAmount=$('#oilAmount').val();
	var mark=$('#mark').val();
	if(prepayCash==''){
		bootbox.alert('预付现金不能为空！');
		return;
	}
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增追加预付信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/scheduleMng/addPrepay',
						data : JSON.stringify({
							scheduleBillNo : scheduleBillNo,
							prepayCash : prepayCash,				
							bankName : bankName,
							bankAccount : bankAccount,
							oilCardNo : oilCardNo,
							oilAmount : oilAmount,
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
/* 金额验证 */
function revaildate(e,flag){
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
    var money = $(e).val();
    if(money!=null && money!=''){
    	if (!reg.test(money)) {
    		if(flag=='0'){//预付现金
    			$('#prepayCash').val('');
    		}else if(flag=='1'){//预付油费
    			$('#oilAmount').val('');
    		}
    		bootbox.alert('请输入正确的金额！');
       }
    }
}
/* 卡号验证 */
function cardNoConfirmBlur(e,flag){
	var reg = /[^\d]/g;
    var cardNo = $(e).val();
    if(cardNo!=null && cardNo!=''){
    	if (reg.test(cardNo)) {
    		if(flag=='0'){//账号
    			$('#bankAccount').val('');
    		}else if(flag=='1'){//预付油卡卡号
    			$('#oilCardNo').val('');
    		}
    		bootbox.alert('请输入正确的卡号！');
       }
    }

}
/* 关闭窗体 */
function refresh(){
	clear();
	$('#modal-info').modal('hide');
	
}
</script>



</body>
</html>






