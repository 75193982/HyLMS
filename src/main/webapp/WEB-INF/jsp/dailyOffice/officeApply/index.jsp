
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css"/>
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->

</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			日常办公
			<small>
				<i class="icon-double-angle-right"></i>
				办公费用申请
			</small>
		</h1>
	</div><!-- /.page-header -->	
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title ">项目名称：</label>
		    <input id="form_itemName" class="form-box mul-form-box" type="text" placeholder="请输入项目名称" />
			<a class="itemBtn " onclick="searchInfo()">查询</a>
			<a class="itemBtn " onclick="doadd()">新增</a>			
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>项目名称</th>
					<th>创建时间</th>
                    <th>最新更新时间</th>
                    <th>状态</th>                   
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
		</div>
		<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">新增/编辑办公费用申请信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item">
							     <label class="title"><span class="red">*</span>业务流程：</label>
							     <div class="form-new">
							    <select id="processId" class="form-control" ></select>
							    </div>
							     <input class="form-control" id="id-hidden" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title"><span class="red">*</span>项目名称：</label>
							     <div class="form-new">
							     <input id="itemName" class="form-control" type="text" placeholder="请填写项目名称"/>
							     </div>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title"><span class="red">*</span>金额：</label>
							     <div class="form-new">
							     <input id="amount" class="form-control" type="text" placeholder="请填写金额"/>
							     </div>
							 </div>
							 <!-- <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title"><span class="red">*</span>预付现金：</label>
							     <div class="form-new">
							     <input id="cashAdvance" class="form-control" type="text" placeholder="请填写预付现金"/>
							     </div>
							 </div> -->
							 <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title">开始时间：</label>
							     <div class="input-group input-group-sm form-new">
									<input class="form-control" id="startTime" type="text" placeholder="请输入开始时间"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>								     
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title">结束时间：</label>
							     <div class="input-group input-group-sm form-new">
									<input class="form-control" id="endTime" type="text" placeholder="请输入结束时间"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>							     
							 </div>
							 <hr class="tree"></hr>
							  <div class="add-item" style="height: 80px;">
							     <label class="title">备注 ：</label>
							     <div class="form-new">
							     <textarea class="form-control" rows="3" id="mark" name="mark" placeholder="请填写备注  " style="height: 80px;"></textarea> 
							     </div>
							  </div>							 						  					  
							    <hr class="tree" ></hr>
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
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
function init(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/dailyOffice/officeApply/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum",'width':'4%'},
		    {data: "itemName",'width':'15%'},
		    {data: "insertTime",'width':'15%'},
		    {data: "updateTime",'width':'15%'},
		    {data: "status",'width':'15%'},
		    {data: null,'width':'20%'}		    
			],
		    columnDefs: [{
					 //类型
					 targets:2,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
						
				     }	       
				},{
					 //类型
					 targets:3,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
						
				     }	       
				},{
					 //状态
					 targets:4,
					 render: function (data, type, row, meta) {
						 if(data=='0'){
				        	 return '新建'; 
				          }else if(data=='1'){
				        	  return '流转中';
				          }else{
				        	  return '已完成';  
				          }
				      }	       
				},{
					 //状态
					 targets:5,
					 render: function (data, type, row, meta) {
						 if(row.status=='0'){
			    			 return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
			    			   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
					           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
			    		 }else{
			    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'
					           /* +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>' */; 
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
		 "sAjaxSource": "${ctx}/dailyOffice/officeApply/getListData" , //获取数据的ajax方法的URL	
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
			 columns: [{ data: "rownum",'width':'4%'},
					    {data: "itemName",'width':'15%'},
					    {data: "insertTime",'width':'15%'},
					    {data: "updateTime",'width':'15%'},
					    {data: "status",'width':'15%'},
					    {data: null,'width':'20%'}		    
						],
					    columnDefs: [{
								 //类型
								 targets:2,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }
									
							     }	       
							},{
								 //类型
								 targets:3,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }
									
							     }	       
							},{
								 //状态
								 targets:4,
								 render: function (data, type, row, meta) {
							          if(data=='0'){
							        	 return '新建'; 
							          }else if(data=='1'){
							        	  return '流转中';
							          }else{
							        	  return '已完成';  
							          }
							      }	       
							},{
								 //状态
								 targets:5,
								 render: function (data, type, row, meta) {
									 if(row.status=='0'){
						    			 return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
						    			   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
								           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
						    		 }else{
						    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'
								           /* +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>' */; 
						    		 }
							      }	       
							}
					      ],
				        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

$(function(){
	
	init();
	//getCarNo();
})

/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   $('#secho').val(secho);
	   var itemName=$('#form_itemName').val();
	   var cardNo=$('#carNo').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   if(cardNo=='' || cardNo==null || cardNo=='-1'){
		   cardNo=null;
	   }
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				itemName : itemName,
				sign : '0'
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
function searchInfo(){
	reload();
}

function doview(id){
	 var url = location.href;
	location.href="${ctx}/dailyOffice/officeApply/detail?"+id+"&"+url;
}
/*办公费用申请新增*/
function doadd(){
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
	clear();
	$('#addBtn').show();
	$('#editBtn').hide();
	$("#processId").attr("disabled",false);
	$("#itemName").attr("disabled",false);
	$("#amount").attr("disabled",false);
/* 	$("#cashAdvance").attr("disabled",false); */
	$("#startTime").attr("disabled",false);
	$("#endTime").attr("disabled",false);
	$("#mark").attr("disabled",false);
	$('#myModalLabel').html('新增办公费用申请');	
	$('#modal-info').modal('show');
	bindprocess();
}
/* 数据重置 */
function clear(){
	$('#id-hidden').val('');
	$('#itemName').val('');
	$('#processId').val('');
	$('#amount').val('');
	/* $('#cashAdvance').val(''); */
	$('#startTime').val('');
	$('#endTime').val('');
	$('#mark').val('');
}
/*绑定业务流程*/
 function bindprocess(){
	  $.ajax({
			type : 'GET',
			url : "${ctx}/basicSetting/processMng/getProcessListForOffice",
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					var html ='<option value="">请选择业务流程</option>';
					if(data.data.length>0){
						for(var i=0;i<data.data.length;i++){
							html +='<option value='+data.data[i]['id']+'>'+data.data[i]['mark']+'</option>';
						}						
					}
					$('#processId').html(html);
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		}); 
}
function save(){
	var flag="false";
	var applyUserId= '${sessionScope.LMS_USER.id}';
	//console.log(name);
	var processId=$('#processId').val();
	var itemName=$('#itemName').val();
	var amount=$('#amount').val();
/* 	var cashAdvance=$('#cashAdvance').val(); */
	var startTime=$('#startTime').val();
	var endTime=$('#endTime').val();
	var mark=$('#mark').val();
	if(processId==''||processId==null){
		bootbox.alert('业务流程不能为空！');
		return;
	}if(itemName==''||itemName==null){
		bootbox.alert('项目名称不能为空！');
		return;
	}if(amount==''||amount==null){
		bootbox.alert('金额不能为空！');
		return;
	}/* if(cashAdvance==''||cashAdvance==null){
		bootbox.alert('预付现金不能为空！');
		return;
	} */if(amount!=''&&isNaN(amount)){
		bootbox.alert('金额请填写数字！');
		return;
	}/* if(cashAdvance!=''&&isNaN(cashAdvance)){
		bootbox.alert('预付现金请填写数字！');
		return;
	} */
	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增办公费用申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/dailyOffice/officeApply/save',
						data : JSON.stringify({
							applyUserId : applyUserId,				
							processId : processId,
							itemName : itemName,
							amount : amount,
							/* cashAdvance : cashAdvance, */
							startTime : startTime,
							endTime : endTime,
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
	clear();
	$('#addBtn').hide();
	$('#editBtn').show();
	$("#processId").attr("disabled",false);
	$("#itemName").attr("disabled",false);
	$("#amount").attr("disabled",false);
	/* $("#cashAdvance").attr("disabled",false); */
	$("#startTime").attr("disabled",false);
	$("#endTime").attr("disabled",false);
	$("#mark").attr("disabled",false);
	$('#myModalLabel').html('编辑办公费用申请');	
	$('#modal-info').modal('show');
	bindprocess();
	$.ajax({
		type : 'GET',
		url : "${ctx}/dailyOffice/officeApply/getDetailInfoForItem/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#processId').val(data.data.item.processId);
				$('#itemName').val(data.data.item.itemName);
				$('#amount').val(data.data.item.amount);	
				/* $('#cashAdvance').val(data.data.item.cashAdvance); */
				if(data.data.item.startTime!=''&&data.data.item.startTime!=null){
					$('#startTime').val(data.data.item.startTime.substring(0,10));	
				}
				if(data.data.item.endTime!=''&&data.data.item.endTime!=null){
					$('#endTime').val(data.data.item.endTime.substring(0,10));	
				}
				//$('#startTime').val(data.data.item.startTime);	
				//$('#endTime').val(data.data.item.endTime);
				$('#mark').val(data.data.item.mark);	
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	});
}
//办公费用申请编辑保存
function update(){
	var flag="false";
	var applyUserId= '${sessionScope.LMS_USER.id}';
	var id=$('#id-hidden').val();
	//console.log(name);
	var processId=$('#processId').val();
	var itemName=$('#itemName').val();
	var amount=$('#amount').val();
	/* var cashAdvance=$('#cashAdvance').val(); */
	var startTime=$('#startTime').val();
	var endTime=$('#endTime').val();
	var mark=$('#mark').val();
	if(processId==''||processId==null){
		bootbox.alert('业务流程不能为空！');
		return;
	}if(itemName==''||itemName==null){
		bootbox.alert('项目名称不能为空！');
		return;
	}if(cashAdvance==''||cashAdvance==null){
		bootbox.alert('金额不能为空！');
		return;
	}/* if(cashAdvance==''||cashAdvance==null){
		bootbox.alert('预付现金不能为空！');
		return;
	} */if(amount!=''&&isNaN(amount)){
		bootbox.alert('金额请填写数字！');
		return;
	}/* if(cashAdvance!=''&&isNaN(cashAdvance)){
		bootbox.alert('预付现金请填写数字！');
		return;
	} */
	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该办公费用申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/dailyOffice/officeApply/save',
						data : JSON.stringify({
							id  : id,
							applyUserId : applyUserId,				
							processId : processId,
							itemName : itemName,
							amount : amount,
							/* cashAdvance : cashAdvance, */
							startTime : startTime,
							endTime : endTime,
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

/* 删除办公费用申请信息 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除办公费用申请信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/dailyOffice/officeApply/delete/"+id,
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
}
/* 提交办公费用申请信息 */
function dosubmit(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交办公费用申请信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/dailyOffice/officeApply/submit/"+id,
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
function refresh(){
	$('#modal-info').modal('hide');	
}
</script>



</body>
</html>






