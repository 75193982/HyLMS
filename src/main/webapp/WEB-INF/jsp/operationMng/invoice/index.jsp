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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发票管理</title>
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
#modal-view{
    width: 600px;
    height: 600px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }  
</style>
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			财务管理
			<small>
				<i class="icon-double-angle-right"></i>
				发票管理
			</small>
		</h1>
	</div>
	<div class="page-content">
		<div class="searchbox col-xs-12">
			<label class="title" style="float: left;">发票号：</label>
		    <input id="invoiceNoSearch" class="form-box" type="text" placeholder="请输入发票号" style="float: left;width:234px;"/>
			
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">开票时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 234px;height:34px;margin-right:30px; margin-left: 5px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入时间" style="height: 34px;font-size: 14px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 13px;width:39px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 234px;height:34px; margin-right:30px;margin-left: 5px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入时间" style="height: 34px;font-size: 14px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		</div>
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;">收款方：</label>
		   <input id="titleSearch" class="form-box" type="text" placeholder="请输入收款方" style="width:234px;"/>
		    
		    <label class="title" style="width: 70px;">备注：</label>
		    <input id="markSearch" class="form-box" type="text" placeholder="请输入备注" style="width:234px;"/>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="doadd()">新增</a>
			<a class="itemBtn " onclick="doprint()">打印</a>
			<a class="itemBtn " onclick="doexport()">导出</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>发票号</th>
					<th>开票时间</th>
                    <th>收款方</th>
                    <th>开票金额</th>
                    <th>税金</th>
                    <th>价税合计</th>
                    <th>备注</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>			
			<!-- 新增 开始-->
			<div class="modal fade modal_car" id="modal-add" tabindex="-1" role="dialog"  data-backdrop="static">
				<div class="modal-dialog" style="padding:0;margin:auto;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
					  <button class="close" type="button" data-dismiss="modal">×</button>
					  <h3 id="myModalLabel">新增发票信息</h3>
				     </div>
					<div class="modal-body" style="padding:5px 20px;">
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							  <div class="widget-main">
								  <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>发票号：</label>
								      <input class="form-control" id="invoiceNo_add" type="text" placeholder="请输入发票号" style="height: 32px;"/>
								  </div>
								  <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title"><span class="red">*</span>开票时间：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px; ">
										<input class="form-control" style="font-size: 14px;padding: 5px 4px;" id="operateTime_add" style="height: 32px;" type="text" placeholder="请输入开票时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>收款方：</label>
								     <input class="form-control" id="title_add" type="text" placeholder="请输入收款方" style="height: 32px;"/>
								  </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
									  <label class="title"><span class="red">*</span>开票金额：</label>
									  <input class="form-control" id="amount_add" type="text" placeholder="请输入开票金额" style="height: 32px;"/>
								 </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
							        <label class="title"><span class="red">*</span>税金：</label>
							     	<input class="form-control" id="duty_add" type="text" placeholder="请输入金额" style="height: 32px;"/>
							    </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title">备注：</label>
								     <input class="form-control" id="mark_add" type="text" placeholder="请输入备注" style="height: 32px;"/>
								 </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
								 	<label class="title">扫描件上传</label>
								 	<div class="form-control" style="border:0;height:auto;">
								         <input type="file" id="file" />
                                         <label id="filename"></label>
                                         <input type="hidden" name="filename_hidden" id="filename_hidden" />
                                         <input type="hidden" name="filepath_hidden" id="filepath_hidden" />
								      </div>
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
			<!-- 新增 结束-->
			<!-- 编辑 开始-->
			<div class="modal fade modal_car" id="modal-edit" tabindex="-1" role="dialog"  data-backdrop="static">
				<div class="modal-dialog" style="padding:0;margin:auto;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
					  <button class="close" type="button" data-dismiss="modal">×</button>
					  <h3 id="myModalLabel">编辑发票信息</h3>
				     </div>
					<div class="modal-body" style="padding:5px 20px;">
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							  <div class="widget-main">
							  	 <input type="hidden" id="id-hidden">
								 <div class="add-item extra-item">
								      <label class="title"><span class="red">*</span>发票号：</label>
								      <input class="form-control" id="invoiceNo_edit" type="text" placeholder="请输入发票号" style="height: 32px;"/>
								  </div>
								  <hr class="tree"></hr>
								<div class="add-item extra-item" style="position:relative">
								     <label class="title">开票时间：</label>
								     <div class="input-group input-group-sm w75" style="font-size: 14px;">
										<input class="form-control"  style="font-size: 14px;padding: 5px 4px;" id="operateTime_edit" type="text" placeholder="请输入开票时间"/>
										<span class="input-group-addon" >
											<i class="icon-calendar"></i>
										</span>									
									 </div>
							     </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>收款方：</label>
								     <input class="form-control" id="title_edit" type="text" style="height: 32px;"/>
								  </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
									 <label class="title">开票金额：</label>
									 <input class="form-control" id="amount_edit" type="text" placeholder="请输入开票金额" style="height: 32px;"/>
								 </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
							     	<label class="title"><span class="red">*</span>税金：</label>
							     	<input class="form-control" id="duty_edit" type="text" placeholder="请输入金额" style="height: 32px;"/>
							    </div>
								 <hr class="tree"></hr>	
								 <div class="add-item extra-item">
								     <label class="title">备注：</label>
								     <input class="form-control" id="mark_edit" type="text" placeholder="请输入备注" style="height: 32px;"/>
								 </div>
								 <hr class="tree"></hr>
								 <div class="add-item extra-item">
								 	<label class="title">扫描件上传</label>
								 	<div class="form-control" style="border:0;height:auto;">
                                         <input type="file" id="file_edit" />
                                         <label id="filename_edit"></label>
                                         <input type="hidden" name="filename_hidden_edit" id="filename_hidden_edit" />
                                         <input type="hidden" name="filepath_hidden_edit" id="filepath_hidden_edit" />
								      </div>
								 </div>
								  <hr class="tree"></hr>					  
								    <div class="add-item-btn dis-block" id="editBtn">
									    <a class="add-itemBtn btnOk" onclick="saveEdit();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="cancelEdit();">取消</a>
									 </div>
									</div>
							  </div>
						</div>
					</div>
				  </div>
				</div>
			</div>
			<!-- 编辑 结束-->
			<!-- 查看 开始-->
		 <div class="modal fade" id="modal-view" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal" >×</button>
					<h3 id="myModalLabel" style="margin:5px;">查看发票信息</h3>
				</div>
				<div class="modal-body" style="height:510px;overflow:auto;">
					<div class="mng" style="min-height:480px;">						
						<div class="table-item">
							<!-- 第一列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">发票号:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="invoiceNo_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							<!-- 第二列 -->
							<div class="row newrow">
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">开票时间:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="operateTime_view" class="form-control no-border"></p>
									</div>
								</div>								
							</div>
							<!-- 第三列 -->
							<div class="row newrow">
							<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">收款方:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="title_view" class="form-control no-border"></p>
									</div>
								</div>							
							</div>
							<!-- 第四列 -->
							<div class="row newrow">
							<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">开票金额:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="amount_view" class="form-control no-border"></p>
									</div>
								</div>																
								</div>	
							<!-- 第五列 -->	
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">税金:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="duty_view" class="form-control no-border" ></p>
									</div>
								</div>																
							</div>	
							<!-- 第六列 -->	
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">备注:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="mark_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							<!-- 第七列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">扫描件:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="filePath_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							
							<!-- 操作按钮栏 -->
							<div class="row newrow">
								<div class="col-xs-5"></div>
								<div class="col-xs-2">
									<div class="form-contr">
										<a class="backbtn" onclick="cancelView();"><i
											class="icon-undo" style="display: inline-block; width: 20px;"></i>关闭</a>
									</div>
								</div>
								<div class="col-xs-5"></div>
							</div>
															
							</div>	
						</div>
					</div>
				</div>
			<!-- 查看 结束-->		
		</div>
	</div>
</div>

<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>发票信息</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>														
					<th>序号</th>
					<th>发票号</th>
					<th>开票时间</th>
                    <th>收款方</th>
                    <th>开票金额</th>
                    <th>税金</th>
                    <th>价税合计</th>
                    <th>备注</th>
				</tr>
		    </thead>
		    <tbody>
		    </tbody>
		  </table>
		  <div id="footerInfo"><h3>盐城辉宇物流有限公司  制</h3></div>
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
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script>
<script src="${ctx}/staticPublic/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
function init(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/invoice/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum","width":"6%"},
				    {data: "invoiceNo","width":"12%"},
				    {data: "operateTime","width":"11%"},
				    {data: "title","width":"15%"},
				    {data: "amount","width":"10%"},
				    {data: "duty","width":"6%"},
				    {data: null,"width":"10%"},
				    {data: "mark","width":"10%"},
				    {data: null,"width":"20%"}],
		    columnDefs: [
				{
					//时间
					targets:2,
					render: function (data, type, row, meta) {
						if(data!=''&& data!=null){
							return jsonDateFormat(data);
						}else{
							return '';
						}
				 	}	       
				},
				{
					//价税合计
					targets:6,
					render: function (data, type, row, meta) {
						return Number((row.amount+row.duty).toFixed(2));
						
				 	}	       
				},
		      	{
			    	 //操作栏
			    	 targets: 8,
			    	 render: function (data, type, row, meta) {
			    		 if(row.status=='0'){
		                    return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
		                    	+'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
						        +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
		                }
			    		 else
			    		{
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
		 "sAjaxSource": "${ctx}/operationMng/invoice/getListData" , //获取数据的ajax方法的URL	
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
				 columns: [{ data: "rownum","width":"6%"},
						    {data: "invoiceNo","width":"12%"},
						    {data: "operateTime","width":"11%"},
						    {data: "title","width":"15%"},
						    {data: "amount","width":"10%"},
						    {data: "duty","width":"6%"},
						    {data: null,"width":"10%"},
						    {data: "mark","width":"10%"},
						    {data: null,"width":"20%"}],
						    columnDefs: [
										{
											//时间
											targets:2,
											render: function (data, type, row, meta) {
												if(data!=''&& data!=null){
													return jsonDateFormat(data);
												}else{
													return '';
												}
										 	}	       
										},
										{
											//价税合计
											targets:6,
											render: function (data, type, row, meta) {
												return Number((row.amount+row.duty).toFixed(2));
										 	}	       
										},
											{
											 //操作栏
											 targets: 8,
											 render: function (data, type, row, meta) {
												 if(row.status=='0'){
										            return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
										            	+'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
												        +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
										        }
												 else
												{
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
				startTime : $.trim($('#startTime').val()),
				endTime :$.trim($('#endTime').val()),
				invoiceNo :$.trim($('#invoiceNoSearch').val()),
				title :$.trim($('#titleSearch').val()),
				mark :$('#markSearch').val()
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

function searchInfo(){
	reload();
}

/* 数据导入  新增*/
function upload(){
	$("#file").uploadify({
		//按钮额外自己添加点的样式类.upload
        'buttonClass':'upload',
        //限制文件上传大小
        'fileSizeLimit':'200MB',
        //文件选择框显示
        'fileTypeDesc':'选择',
        //文件类型过滤
        /*  'fileTypeExts':'*.xls;*.xlsx', */
        //按钮高度
        'height':'30',
        //按钮宽度
        'width':'100',
        //请求类型
        'method':'post',
        //是否支持多文件上传
        'multi':false,
        /* //需要重写的事件
        'overrideEvents'    :    ['onUploadError'], */
        /* //队列ID，用来显示文件上传队列与进度
        'queueID'            :    'photo_queue', */
        //队列一次最多允许的文件数，也就是一次最多进入上传队列的文件数
        'queueSizeLimit': 1,
        //上传动画，插件文件下的swf文件
        'swf':'${ctx}/staticPublic/js/uploadify/uploadify.swf',
        //处理上传文件的服务类
        'uploader':'${ctx}/upload/saveFile?type=task',
        /* //上传文件个数限制
        'uploadLimit': 1, */
        //上传按钮内容显示文本
        'buttonText':'上传',
         //自定义重写的方法，文件上传错误触发
        /*'onUploadError'        :   function(file,errorCode,erorMsg,errorString){
        	alert(erorMsg);
        },
        //文件选择错误触发
        'onSelectError'        :    uploadify_onSelectError, */
        /* //文件队列上传完毕触发
        'onQueueComplete'    :    heightReset,
        //队列开始上传触发
        'onUploadStart'        :   heightFit, */
        //单个文件上传成功触发
        'onUploadSuccess':function(file, data, response){        	
        	//刷新目录
        	var orginFileName = JSON.parse(data).orginFileName;        		
        	var attachFilePath = JSON.parse(data).attachFilePath;
        	var attachFilePaths="${ctx}"+attachFilePath;
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#filename').html(html);
        	$('#filename_hidden').val(orginFileName);
        	$('#filepath_hidden').val(attachFilePath);
        }
 });
}

/* 数据导入  编辑 */
function uploadEdit(){
	$("#file_edit").uploadify({
		//按钮额外自己添加点的样式类.upload
        'buttonClass':'upload',
        //限制文件上传大小
        'fileSizeLimit':'200MB',
        //文件选择框显示
        'fileTypeDesc':'选择',
        //文件类型过滤
         /* 'fileTypeExts':'*.xls;*.xlsx', */
        //按钮高度
        'height':'30',
        //按钮宽度
        'width':'100',
        //请求类型
        'method':'post',
        //是否支持多文件上传
        'multi':false,
        /* //需要重写的事件
        'overrideEvents'    :    ['onUploadError'], */
        /* //队列ID，用来显示文件上传队列与进度
        'queueID'            :    'photo_queue', */
        //队列一次最多允许的文件数，也就是一次最多进入上传队列的文件数
        'queueSizeLimit': 1,
        //上传动画，插件文件下的swf文件
        'swf':'${ctx}/staticPublic/js/uploadify/uploadify.swf',
        //处理上传文件的服务类
        'uploader':'${ctx}/upload/saveFile?type=task',
        /* //上传文件个数限制
        'uploadLimit': 1, */
        //上传按钮内容显示文本
        'buttonText':'上传',
         //自定义重写的方法，文件上传错误触发
        /*'onUploadError'        :   function(file,errorCode,erorMsg,errorString){
        	alert(erorMsg);
        },
        //文件选择错误触发
        'onSelectError'        :    uploadify_onSelectError, */
        /* //文件队列上传完毕触发
        'onQueueComplete'    :    heightReset,
        //队列开始上传触发
        'onUploadStart'        :   heightFit, */
        //单个文件上传成功触发
        'onUploadSuccess':function(file, data, response){        	
        	//刷新目录
        	var orginFileName = JSON.parse(data).orginFileName;        		
        	var attachFilePath = JSON.parse(data).attachFilePath;
        	var attachFilePaths="${ctx}"+attachFilePath;
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#filename_edit').html(html);
        	$('#filename_hidden_edit').val(orginFileName);
        	$('#filepath_hidden_edit').val(attachFilePath);
        }
 });
}

$(function(){
	$("#startTime").datetimepicker({
		language: 'cn',
		 format: "yyyy-mm-dd hh:ii",//日期格式
        autoclose: true,//选中之后自动隐藏日期选择框
        todayBtn: true
	});
	$("#endTime").datetimepicker({
		language: 'cn',
		format: "yyyy-mm-dd hh:ii",//日期格式
        autoclose: true,//选中之后自动隐藏日期选择框
        todayBtn: true
	});
	init();
	upload();
	uploadEdit();
});
//清空
function clear(){
	$('#invoiceNo_add').val('');
	$('#operateTime_add').val('');
	$('#title_add').val('');
	$('#amount_add').val('');
	$('#duty_add').val('');
	$('#mark_add').val('');
	$('#remark_add').val('');
	$('#filename').html('');
	$('#filename_hidden').val('');
	$('#filepath_hidden').val('');
}
//关闭
function cancel()
{
	 clear();
	$('#modal-add').modal('hide');
}
//新增
function doadd()
{
	clear();
	$("#operateTime_add").datetimepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd hh:ii", //日期格式
        todayBtn: true
	});
	$("#amount_add").on('input',function(e){  
		   var a = $(this).val();
		   $('#duty_add').val(a*0.11);
		});  
	$('#modal-add').modal('show');
}

//保存
function save(){
	var flag="false";
	var invoiceNo=$('#invoiceNo_add').val();
	var operateTime=$('#operateTime_add').val();
	var title=$('#title_add').val();
	var amount=$('#amount_add').val();
	var duty=$('#duty_add').val();
	var mark=$('#mark_add').val();
	var filePath = $('#filepath_hidden').val();
	if(invoiceNo==''|| invoiceNo==null){
		bootbox.alert('发票号不能为空！');
		return;
	}
	if(operateTime==''|| operateTime==null){
		bootbox.alert('开票时间不能为空！');
		return;
	}
	
	if(title==''|| title==null ){
		bootbox.alert('收款方不能为空！');
		return;
	}
	if(amount==''|| amount==null){
		bootbox.alert('开票金额不能为空！');
		return;
	}
	if(duty==''|| duty==null){
		bootbox.alert('税金不能为空！');
		return;
	}
	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该发票信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/invoice/save',
						data : JSON.stringify({
							id : '',
							invoiceNo :invoiceNo,
							operateTime : new Date(operateTime),
							title : title,
							amount : amount,
							duty :duty, 
							mark : mark,
							filePath : filePath
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
	
	$("#operateTime_edit").datetimepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd hh:ii", //日期格式
        todayBtn: true
	});
	$("#amount_edit").on('input',function(e){  
		   var a = $(this).val();
		   $('#duty_edit').val(a*0.11);
		});  
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/invoice/getById/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				console.info(JSON.stringify(data.data));
				$('#id-hidden').val(id);				
				$('#invoiceNo_edit').val(data.data.invoiceNo);
				if(null != data.data.operateTime && "" != data.data.operateTime)
				{
					$("#operateTime_edit").val(format(data.data.operateTime, 'yyyy-MM-dd HH:mm'));
				}
				$("#title_edit").val(data.data.title); 
				$("#amount_edit").val(data.data.amount);
				$("#duty_edit").val(data.data.duty);
				$("#mark_edit").val(data.data.mark);
				if(null != data.data.filePath && "" != data.data.filePath)
				{
					$("#filepath_hidden_edit").val(data.data.filePath);
					var pathHtml ='<p><a href=${ctx}'+data.data.filePath+' target="_blank">扫描件</a></p>';
					$('#filename_edit').html(pathHtml);
				}
				else
				{
					$("#filepath_hidden_edit").val("");
					$('#filename_edit').html("");
				}
				$('#modal-edit').modal('show');
				$('#editBtn').show();							
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
	
}
//更新
function saveEdit()
{
	var flag="false";
	var id = $('#id-hidden').val();
	var invoiceNo=$('#invoiceNo_edit').val();
	var operateTime=$('#operateTime_edit').val();
	var title=$('#title_edit').val();
	var amount=$('#amount_edit').val();
	var duty=$('#duty_edit').val();
	var mark=$('#mark_edit').val();
	var filePath=$('#filepath_hidden_edit').val();
	
	if(invoiceNo==''|| invoiceNo==null){
		bootbox.alert('发票号不能为空！');
		return;
	}
	if(operateTime==''|| operateTime==null){
		bootbox.alert('开票时间不能为空！');
		return;
	}
	
	if(title==''|| title==null ){
		bootbox.alert('收款方不能为空！');
		return;
	}
	if(amount==''|| amount==null){
		bootbox.alert('开票金额不能为空！');
		return;
	}
	if(duty==''|| duty==null){
		bootbox.alert('税金不能为空！');
		return;
	}
	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该发票信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/invoice/save',
						data : JSON.stringify({
							id : id,
							invoiceNo :invoiceNo,
							operateTime :new Date(operateTime),
							title : title,
							amount : amount,
							duty :duty, 
							mark : mark,
							filePath : filePath
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

function cancelEdit()
{
	$('#modal-edit').modal('hide');
}
//查看
function doshow(id)
{
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/invoice/getById/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				//$('#id-hidden').val(id);	
				$('#invoiceNo_view').html(data.data.invoiceNo);
				if(null != data.data.operateTime )
				{
					$("#operateTime_view").html(format(data.data.operateTime, 'yyyy-MM-dd HH:mm'));
				}
				else
				{
					$("#operateTime_view").html('');
				}
				$("#title_view").html(data.data.title); 
				$("#amount_view").html(data.data.amount); 
				$("#duty_view").html(data.data.duty);
				$("#mark_view").html(data.data.mark);
				if(null != data.data.filePath && "" != data.data.filePath)
				{
					$("#filePath_view").html("<a href=${ctx}"+data.data.filePath+" target=\"_blank\">扫描件</a>");
				}
				else
				{
					$("#filePath_view").html("");
				}
				$('#modal-view').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}

function cancelView()
{
	$('#modal-view').modal('hide');	
}
//提交
function dosubmit(id)
{
		var flag="false";
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要提交该开票信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'GET',
							url : "${ctx}/operationMng/invoice/submit/"+id,
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

var format = function(time, format){
    var t = new Date(time);
    var tf = function(i){return (i < 10 ? '0' : '') + i};
    return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a){
        switch(a){
            case 'yyyy':
                return tf(t.getFullYear());
                break;
            case 'MM':
                return tf(t.getMonth() + 1);
                break;
            case 'mm':
                return tf(t.getMinutes());
                break;
            case 'dd':
                return tf(t.getDate());
                break;
            case 'HH':
                return tf(t.getHours());
                break;
            case 'ss':
                return tf(t.getSeconds());
                break;
        }
    })
}
//删除
function dodelete(id)
{
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该开票信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/invoice/delete/"+id,
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

/* 打印功能 */
function doprint(){
	   var date = new Date();
       var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
       var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
       var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
       var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
       var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
       var localTime= date.getFullYear() + "-" + month + "-" + day+ " " + hours + ":" + minutes + ":" + seconds;
	   var html="";
	   var invoiceNo=$.trim($('#invoiceNoSearch').val());
	   var startTime=$.trim($('#startTime').val());
	   var endTime=$.trim($('#endTime').val());
	   var title=$.trim($('#titleSearch').val());
	   var mark=$.trim($('#markSearch').val());
	   
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/operationMng/invoice/getPrintData",
			data : JSON.stringify({
				invoiceNo : invoiceNo,
				startTime : startTime,
				endTime : endTime,
				title : title,
				mark : mark
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {					
					if(data.data.length>0){
						for(var i=0;i<data.data.length;i++){
							data.data[i]["rownum"]=i+1;
							
							if(data.data[i]["operateTime"]==null || data.data[i]["operateTime"]=='' || parseInt(data.data[i]["operateTime"])<0){
								data.data[i]["operateTime"]=''; 
							 }else{
								 data.data[i]["operateTime"]=jsonForDateFormat(data.data[i]["operateTime"]);
							 }
							if(data.data[i]["title"]==null || data.data[i]["title"]=='' || data.data[i]["operateTime"] == "null"){
								data.data[i]["title"]=''; 
							 }
						
								html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
							    +'<td>'+data.data[i]["invoiceNo"]+'</td>'
							    +'<td>'+data.data[i]["operateTime"]+'</td>'
							    +'<td>'+data.data[i]["title"]+'</td>'
							    +'<td>'+data.data[i]["amount"]+'</td>'
							    +'<td>'+data.data[i]["duty"]+'</td>'
							    +'<td>'+Number((parseFloat(data.data[i]["amount"])+parseFloat(data.data[i]["duty"])).toFixed(2))+'</td>'
							    +'<td>'+data.data[i]["mark"]+'</td>'							    							    
						}
						$('#localTime').html(localTime);
						$('#myDataTable tbody').html(html);
					      doprintForm();
					}else{
						bootbox.alert('暂无可打印的数据！');
						return;
					}
					 
				} else {
					 bootbox.alert(data.msg);
				}
				
			}
		}); 
	  
	   
}

function doprintForm(){
		var html=$("#printTable").html();
		$('#breadcrumbs').hide();
		$('.page-content').hide();
		$('#printTable').show();
		$("#myDataTable").printTable({
		 header: "#headerInfo",
         footer: "#footerInfo",
		 mode: "rowNumber",
		 pageSize: 23
	});
		javasricpt:window.print();
		$('#breadcrumbs').show();
		$('.page-content').show();
		$('#printTable').hide();
		$("#printTable").html(html);
	 }
	 
/* 导出 */
function doexport()
{
		var invoiceNo=$.trim($('#invoiceNoSearch').val());
	   var startTime=$.trim($('#startTime').val());
	   var endTime=$.trim($('#endTime').val());
	   var title=$.trim($('#titleSearch').val());
	   var mark=$.trim($('#markSearch').val());
	   
	   var form = $('<form action="${ctx}/operationMng/invoice/export" method="post"></form>');
	   var invoiceNoInput = $('<input id="invoiceNo" name="invoiceNo" value="'+invoiceNo+'" type="hidden" />');
	   var startTimeInput = $('<input id="startTime" name="startTime" value="'+startTime+'" type="hidden" />');	   
	   var endTimeInput = $('<input id="endTime" name="endTime" value="'+endTime+'" type="hidden" />');
	   var titleInput = $('<input id="title" name="title" value="'+title+'" type="hidden" />');
	   var markInput = $('<input id="mark" name="mark" value="'+mark+'" type="hidden" />');
	   form.append(invoiceNoInput);
	   form.append(startTimeInput);
	   form.append(endTimeInput);
	   form.append(titleInput);
	   form.append(markInput);
	   $('body').append(form);
	   form.submit();
}
</script>

</body>
</html>