<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/datetimepicker.css" />
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
				核销申请管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">申请时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 170px;height:34px;margin-right:20px; margin-left: 5px;">
				<input class="form-control" id="applyStartTime" type="text" placeholder="请输入开始时间" style="height: 34px;font-size: 14px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 13px;width:15px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 170px;height:34px; margin-right:30px;margin-left: 5px;">
				<input class="form-control" id="applyEndTime" type="text" placeholder="请输入结束时间" style="height: 34px;font-size: 14px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			<label class="title">预付申请单号：</label>
		    <select id="preBillNo" class="form-box" style="width:170px;">
		      <option value="">请选择预付申请单号</option>
		    </select>
		</div>
		<div class="searchbox col-xs-12">
		    <label class="title">申请部门：</label>
		    <select id="department" class="form-box" style="width:170px;">
		      <option value="">请选择申请部门</option>
		    </select>		
			
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="doadd()">新增</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>预付申请单号</th>
					<th>申请部门</th>
                    <th>申请人</th>
                    <th>申请时间</th>
                    <th>金额</th>
                    <th>状态</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>			
			<!-- 新增核算Modal 开始-->
			<div class="modal fade modal_car" id="modal-add" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding:0;margin:auto;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
					  <button class="close" type="button" data-dismiss="modal" onclick="cancel();">×</button>
					  <h3 id="myModalLabel" style="margin:5px;">新增核销申请信息</h3>
				     </div>
					 <div class="modal-body" style="padding:5px 20px;">
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							  <div class="widget-main">
								<div class="add-item extra-item">
							     <label class="title" style="width:115px;"><span class="red">*</span>预付申请单号：</label>
							     <select class="form-control" id="billNoInfo" onchange="changeBillNo(this,0);">
							      <option value="">请选择预付申请单号</option>
								</select>
							    </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>申请部门：</label>
								     <input class="form-control" data-id="" id="depName" type="text" disabled="disabled" placeholder="申请部门"/>
								  </div>
								  <hr class="tree"></hr>
								 <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>申请人：</label>
								     <input class="form-control" data-id="" id="applyName" type="text" disabled="disabled" placeholder="申请人"/>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>申请时间：</label>
								     <input class="form-control" data-id="" id="applyTime" type="text" disabled="disabled" placeholder="申请时间"/>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>预付金额：</label>
								     <input class="form-control" id="preAmount" type="text" disabled="disabled" placeholder="预付金额"/>
								  </div>
								  <hr class="tree"></hr>
								 <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>实际使用金额：</label>
								     <input class="form-control" id="costAmount" type="text" placeholder="请输入实际使用金额" onkeyup="getReturn(this,0);" />
								 </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
							     <label class="title" style="width:115px;"><span class="red">*</span>应退还金额：</label>
							     	<input class="form-control" id="returnAmount" type="text" placeholder="应退还金额" disabled="disabled" />
							    </div>
								 <hr class="tree"></hr>			  
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="save();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="cancel();">取消</a>
									 </div>
									</div>
							  </div>
						</div>
					</div>
				  </div>
				</div>
			</div>
			<!-- 新增核算Modal 结束-->
			<!-- 编辑核算Modal 开始-->
			<div class="modal fade modal_car" id="modal-edit" tabindex="-1" role="dialog"  data-backdrop="static">
				<div class="modal-dialog" style="padding:0;margin:auto;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
					  <button class="close" type="button" data-dismiss="modal" onclick="updateCancel();">×</button>
					  <h3 id="myModalLabel">编辑核销申请信息</h3>
				     </div>
					 <div class="modal-body" style="padding:5px 20px;">
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							  <div class="widget-main">
								<div class="add-item extra-item">
							     <label class="title" style="width:115px;"><span class="red">*</span>预付申请单号：</label>
							     <select class="form-control" id="ebillNoInfo" onchange="changeBillNo(this,1);">
							      <option value="">请选择预付申请单号</option>
								</select>
							    </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>申请部门：</label>
								     <input class="form-control" data-id="" id="edepName" type="text" disabled="disabled" placeholder="申请部门"/>
								     <input id="id-hidden" type="hidden"/>
								  </div>
								  <hr class="tree"></hr>
								 <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>申请人：</label>
								     <input class="form-control" data-id="" id="eapplyName" type="text" disabled="disabled" placeholder="申请人"/>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>申请时间：</label>
								     <input class="form-control" data-id="" id="eapplyTime" type="text" disabled="disabled" placeholder="申请时间"/>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>预付金额：</label>
								     <input class="form-control" id="epreAmount" type="text" disabled="disabled" placeholder="预付金额"/>
								  </div>
								  <hr class="tree"></hr>
								 <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>实际使用金额：</label>
								     <input class="form-control" id="ecostAmount" type="text" placeholder="请输入实际使用金额" onkeyup="getReturn(this,1);" />
								 </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
							     <label class="title" style="width:115px;"><span class="red">*</span>应退还金额：</label>
							     	<input class="form-control" id="ereturnAmount" type="text" placeholder="应退还金额" disabled="disabled" />
							    </div>
								 <hr class="tree"></hr>			  
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="update();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="updateCancel();">取消</a>
									 </div>
									</div>
							  </div>
						</div>
					</div>
				  </div>
				</div>
			</div>
			<!-- 编辑核算Modal 结束-->
			<!-- 查看核算Modal 开始-->
		 <div class="modal fade modal_car" id="modal-show" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal" onclick="showCancel();">×</button>
					<h3 id="myModalLabel">查看核销申请信息</h3>
				</div>
				<div class="modal-body" style="padding:5px 20px;">
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							  <div class="widget-main">
								<div class="add-item extra-item">
							     <label class="title" style="width:115px;"><span class="red">*</span>预付申请单号：</label>
							       <p class="form-control no-border" id="sbillNoInfo"></p>
							     </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>申请部门：</label>
								     <p class="form-control no-border" id="sdepName"></p>
								  </div>
								  <hr class="tree"></hr>
								 <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>申请人：</label>
								     <p class="form-control no-border" id="sapplyName"></p>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>申请时间：</label>
								     <p class="form-control no-border" id="sapplyTime"></p>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>预付金额：</label>
								     <p class="form-control no-border" id="spreAmount"></p>
								  </div>
								  <hr class="tree"></hr>
								 <div class="add-item extra-item">
								     <label class="title" style="width:115px;"><span class="red">*</span>实际使用金额：</label>
								     <p class="form-control no-border" id="scostAmount"></p>
								 </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
							     <label class="title" style="width:115px;"><span class="red">*</span>应退还金额：</label>
							     <p class="form-control no-border" id="sreturnAmount"></p>
							    </div>
							 </div>
						  </div>
						</div>
					</div>
				</div>
			<!-- 查看核算Modal 结束-->		
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
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
function init(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/costApplyReturn/getListData" , //获取数据的ajax方法的URL							 
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
		    {data: "costApplyBillNo","width":"15%"},
		    {data: "departmentName","width":"15%"},
		    {data: "applyUserName","width":"10%"},
		    {data: "applyTime","width":"15%"},
		    {data: "prepayAmount","width":"10%"},
		    {data: "status","width":"10%"},
		    {data: null,"width":"20%"}],
		    columnDefs: [
				{
					//时间
					targets:4,
					render: function (data, type, row, meta) {
						if(data!=''&& data!=null){
							return jsonDateFormat(data);
						}else{
							return '';
						}
				 	}	       
				},
				{
					 //状态
					 targets:6,
					 render: function (data, type, row, meta) {
						 if(data=='0'){
				        	   return '新建';
				           }else if(data=='1'){
				        	   return '部门负责人审核';
				           }else if(data=='2'){
				        	   return '财务复核';
				           }else if(data=='3'){
				        	   return '总经理审核';
				           }else if(data=='4'){
				        	   return '现金会计';
				           }else if(data=='5'){
				        	   return '已完成';
				           }else{
				        	   return '';
				           }
				       }	       
				},
		      	{
			    	 //操作栏
			    	 targets: 7,
			    	 render: function (data, type, row, meta) {
			    		 if(row.status=='0'){
		                    return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
		                    	+'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
						        +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
		                  }else{
			    			 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
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
		 "sAjaxSource": "${ctx}/operationMng/costApplyReturn/getListData" , //获取数据的ajax方法的URL	
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
						    {data: "costApplyBillNo","width":"15%"},
						    {data: "departmentName","width":"15%"},
						    {data: "applyUserName","width":"10%"},
						    {data: "applyTime","width":"15%"},
						    {data: "prepayAmount","width":"10%"},
						    {data: "status","width":"10%"},
						    {data: null,"width":"20%"}],
						    columnDefs: [
								{
									//时间
									targets:4,
									render: function (data, type, row, meta) {
										if(data!=''&& data!=null){
											return jsonDateFormat(data);
										}else{
											return '';
										}
								 	}	       
								},
								{
									 //状态
									 targets:6,
									 render: function (data, type, row, meta) {
										 if(data=='0'){
								        	   return '新建';
								           }else if(data=='1'){
								        	   return '部门负责人审核';
								           }else if(data=='2'){
								        	   return '财务复核';
								           }else if(data=='3'){
								        	   return '总经理审核';
								           }else if(data=='4'){
								        	   return '现金会计';
								           }else if(data=='5'){
								        	   return '已完成';
								           }else{
								        	   return '';
								           }
								       }	       
								},
						      	{
							    	 //操作栏
							    	 targets: 7,
							    	 render: function (data, type, row, meta) {
							    		 if(row.status=='0'){
						                    return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
						                    	+'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
										        +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
						                  }else{
							    			 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
							    		  }
							    	}
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				startTime : $.trim($('#applyStartTime').val()),
				endTime :$.trim($('#applyEndTime').val()),
				departmentId :$.trim($('#department').val()),
				costApplyBillNo :$.trim($('#preBillNo').val())
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

function searchInfo(){
	reload();
}
/* 获取申请部门 */
function getDeptList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/costApply/getDeptList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="">请选择申请部门</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	                		}
	            		}
	            	}
	            	$('#department').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
 }
/* 获取预付申请单号 */
function getPreBillList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/costApplyReturn/getCostApplyListData',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="">请选择预付申请单号</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['billNo']+'>'+data.data[i]['billNo']+'</option>';
	                		}
	            		}
	            	}
	            	$('#preBillNo').html(html);
	            	$('#billNoInfo').html(html);
	            	$('#ebillNoInfo').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
 }
 
 /* 根据预付单号获取相应的申请信息 */
function changeBillNo(e,flag){
	 var costApplyBillNo=$(e).find('option:selected').val();
	 $.ajax({  
	        url: '${ctx}/operationMng/costApplyReturn/getCostApplyDeatilData',  
	        type: "post",  
			dataType : 'JSON',
	        data: {
	        	costApplyBillNo :costApplyBillNo
	        },
	        success: function (data) {
	        	if (data && data.code == 200){ 
	            	if(data.data!=null && data.data!=''){
	            		/* 0新增,1编辑 */
	            		if(flag=='0'){
	            			$('#depName').val(data.data.departmentName);
		            		$('#depName').attr('data-id',data.data.departmentId);
		            		$('#applyName').val(data.data.applyUserName);
		            		$('#applyName').attr('data-id',data.data.applyUserId);
		            		$('#preAmount').val(data.data.amount);
		            		if(data.data.applyTime!=null && data.data.applyTime!=''){
		            			$('#applyTime').val(jsonDateFormat(data.data.applyTime));
		            		}else{
		            			$('#applyTime').val('');
		            		}
	            		}else{
	            			$('#edepName').val(data.data.departmentName);
		            		$('#edepName').attr('data-id',data.data.departmentId);
		            		$('#eapplyName').val(data.data.applyUserName);
		            		$('#eapplyName').attr('data-id',data.data.applyUserId);
		            		$('#epreAmount').val(data.data.amount);
		            		if(data.data.applyTime!=null && data.data.applyTime!=''){
		            			$('#eapplyTime').val(jsonDateFormat(data.data.applyTime));
		            		}else{
		            			$('#eapplyTime').val('');
		            		}
	            		}
	            	}
	            
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
 }
 
 
 $(function(){
	$("#applyStartTime").datetimepicker({
		language: 'cn',
		format: "yyyy-mm-dd hh:ii",//日期格式
        autoclose: true,//选中之后自动隐藏日期选择框
        todayBtn: true
	});
	$("#applyEndTime").datetimepicker({
		language: 'cn',
		format: "yyyy-mm-dd hh:ii",//日期格式
        autoclose: true,//选中之后自动隐藏日期选择框
        todayBtn: true
	});
	init();
	getDeptList();
	getPreBillList();
});
	//清空
	function clear(){
		$('#billNoInfo').val('');
		$('#depName').val('');
		$('#applyName').val('');
		$('#applyTime').val('');
		$('#preAmount').val('');
		$('#costAmount').val('');
		$('#returnAmount').val('');
		$('#depName').attr('data-id','');
		$('#applyName').attr('data-id','');
	}
	//关闭
	function cancel(){
	 $('#modal-add').modal('hide');
	}
	//新增核算申请管理
	function doadd(){
		clear();
		$('#modal-add').modal('show');
	}
   /* 自动计算应退金额 */
   function getReturn(e,flag){
	   var preAmount=0;
	   var costAmount=0;
	   /* 新增 */
	   if(flag=='0'){
		   if($('#preAmount').val()!=null && $('#preAmount').val()!=''){
			   preAmount=parseFloat($('#preAmount').val());
		   }
		   if($(e).val()!=null && $(e).val()!=''){
			   costAmount=parseFloat($(e).val());
		   }
		   $('#returnAmount').val((preAmount-costAmount).toFixed(2));
	   }else{
		   if($('#epreAmount').val()!=null && $('#epreAmount').val()!=''){
			   preAmount=parseFloat($('#epreAmount').val());
		   }
		   if($(e).val()!=null && $(e).val()!=''){
			   costAmount=parseFloat($(e).val());
		   }
		   $('#ereturnAmount').val((preAmount-costAmount).toFixed(2));
	   }
	  
   }
   
   //保存
function save(){
	var flag="false";
	var costApplyBillNo=$('#billNoInfo').val();
	var departmentId=$('#depName').attr('data-id');
	var applyUserId=$('#applyName').attr('data-id');
	var prepayAmount=$('#preAmount').val();
	var realUseAmount=$('#costAmount').val();
	var returnAmount=$('#returnAmount').val();
	var applyTime=$('#applyTime').val();
	if(costApplyBillNo==''|| costApplyBillNo==null){
		bootbox.alert('预付申请单号不能为空！');
		return;
	}
	if($('#depName').val()==''|| $('#depName').val()==null){
		bootbox.alert('申请部门不能为空！');
		return;
	}
	if($('#applyName').val()==''|| $('#applyName').val()==null){
		bootbox.alert('申请人不能为空！');
		return;
	}
	if(applyTime==''|| applyTime==null){
		bootbox.alert('申请时间不能为空！');
		return;
	}
	if(prepayAmount==''|| prepayAmount==null){
		bootbox.alert('预付金额不能为空！');
		return;
	}
	if(realUseAmount==''|| realUseAmount==null){
		bootbox.alert('实际使用金额不能为空！');
		return;
	}
	if(returnAmount==''|| returnAmount==null){
		bootbox.alert('应退还金额不能为空！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该核销申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/costApplyReturn/save',
						data : JSON.stringify({
							costApplyBillNo :costApplyBillNo,
							departmentId :departmentId,
							applyUserId : applyUserId,
							prepayAmount : prepayAmount,
							realUseAmount :realUseAmount, 
							returnAmount : returnAmount,
							applyTime : new Date(applyTime)
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
										 $('#modal-add').modal('hide');
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

//编辑
function doedit(id)
{
	$('#id-hidden').val(id);
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/costApplyReturn/getById/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				if(data.data.costApplyBillNo==null || data.data.costApplyBillNo==''){
					$('#ebillNoInfo').val('');
				}else{
					$('#ebillNoInfo').val(data.data.costApplyBillNo);
				}
				if(data.data.applyTime==null || data.data.applyTime==''){
					$('#eapplyTime').val('');
				}else{
					$('#eapplyTime').val(jsonDateFormat(data.data.applyTime));
				}
				$('#edepName').val(data.data.departmentName);
				$('#eapplyName').val(data.data.applyUserName);
				$('#epreAmount').val(data.data.prepayAmount);
				$('#ecostAmount').val(data.data.realUseAmount);
				$('#ereturnAmount').val(data.data.returnAmount);
				$('#edepName').attr('data-id',data.data.departmentId);
				$('#eapplyName').attr('data-id',data.data.applyUserId);
				$('#modal-edit').modal('show');
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
	
}
//更新
function update()
{
	var flag="false";
	var id = $('#id-hidden').val();
	var costApplyBillNo=$('#ebillNoInfo').val();
	var departmentId=$('#edepName').attr('data-id');
	var applyUserId=$('#eapplyName').attr('data-id');
	var prepayAmount=$('#epreAmount').val();
	var realUseAmount=$('#ecostAmount').val();
	var returnAmount=$('#ereturnAmount').val();
	var applyTime=$('#eapplyTime').val();
	if(costApplyBillNo==''|| costApplyBillNo==null){
		bootbox.alert('预付申请单号不能为空！');
		return;
	}
	if($('#edepName').val()==''|| $('#edepName').val()==null){
		bootbox.alert('申请部门不能为空！');
		return;
	}
	if($('#eapplyName').val()==''|| $('#eapplyName').val()==null){
		bootbox.alert('申请人不能为空！');
		return;
	}
	if(applyTime==''|| applyTime==null){
		bootbox.alert('申请时间不能为空！');
		return;
	}
	if(prepayAmount==''|| prepayAmount==null){
		bootbox.alert('预付金额不能为空！');
		return;
	}
	if(realUseAmount==''|| realUseAmount==null){
		bootbox.alert('实际使用金额不能为空！');
		return;
	}
	if(returnAmount==''|| returnAmount==null){
		bootbox.alert('应退还金额不能为空！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该核销申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/costApplyReturn/save',
						data : JSON.stringify({
							id :id,
							costApplyBillNo :costApplyBillNo,
							departmentId :departmentId,
							applyUserId : applyUserId,
							prepayAmount : prepayAmount,
							realUseAmount :realUseAmount, 
							returnAmount : returnAmount,
							applyTime : new Date(applyTime)
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
										 $('#modal-edit').modal('hide');
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

function updateCancel()
{
	$('#modal-edit').modal('hide');
}
//查看
function doshow(id)
{
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/costApplyReturn/getById/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				if(data.data.costApplyBillNo==null || data.data.costApplyBillNo==''){
					$('#sbillNoInfo').html('');
				}else{
					$('#sbillNoInfo').html(data.data.costApplyBillNo);
				}
				if(data.data.applyTime==null || data.data.applyTime==''){
					$('#sapplyTime').html('');
				}else{
					$('#sapplyTime').html(jsonDateFormat(data.data.applyTime));
				}
				$('#sdepName').html(data.data.departmentName);
				$('#sapplyName').html(data.data.applyUserName);
				$('#spreAmount').html(data.data.prepayAmount);
				$('#scostAmount').html(data.data.realUseAmount);
				$('#sreturnAmount').html(data.data.returnAmount);
				$('#modal-show').modal('show');
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}

function showCancel()
{
	$('#modal-show').modal('hide');	
}
//提交
function dosubmit(id)
{
		var flag="false";
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要提交该核销申请信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'GET',
							url : "${ctx}/operationMng/costApplyReturn/submit/"+id,
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
		
}


//删除
function dodelete(id)
{
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该核销申请信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/costApplyReturn/delete/"+id,
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
		
}
</script>

</body>
</html>