
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
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
				折损反馈管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">		
		<div class="searchbox col-xs-12">
		    <label class="title ">经销单位：</label>
		    <select id="carShopId" class="form-box mul-form-box">
		    </select>
			<a class="itemBtn m-lr5" onclick="searchInfo()">查询</a>
			<a class="itemBtn m-lr5" onclick="doadd()">新增</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>装运时间</th>
					<th>车型</th>
                    <th>经销单位</th>
					<th>联系方式</th>
					<th>备注</th>
					<th>创建人</th>
					<th>创建时间</th>
					<th>状态</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
		</div>
		<!-- 折损反馈新增 开始-->
		<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal" onclick="refresh();">×</button>
					<h3 id="myModalLabel">新增折损反馈信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>装运时间：</label>
							     <div class="input-group input-group-sm" style="width:432px;">
									<input class="form-control" id="transportTime_new" type="text" placeholder="请输入装运时间"  style="height:34px;"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>							   
							    </div>
							     <!-- <input class="form-control" id="id-hidden" type="hidden"/> -->
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>车型：</label>
							     <input class="form-control" id="carType_new" type="text" placeholder="请输入车型 "/>
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>经销单位：</label>
							     <select id="carShopId_new" class="form-control" ><option value="">请选择经销单位</option>	</select>
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">联系方式：</label>
							     <input class="form-control" id="linkMobile_new" type="text" placeholder="请输入联系方式  "/>
							  </div>							 								  
							    <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">情况描述：</label>
							     <textarea class="form-control" rows="3" id="mark_new" name="mark_new" placeholder="请填写情况描述" ></textarea> 
							  </div>							  
							    <hr class="tree" style="margin-top: 60px;"></hr>
							    <div class="add-item-btn" id="addBtn">
								    <a class="add-itemBtn btnOk" onclick="dosave();" style="margin-left: 130px;">保存</a>
								    <a class="add-itemBtn btnOk" onclick="refresh();">关闭</a>
								 </div>								 
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
			<!-- 折损反馈新增 结束-->
			
		<!-- 折损反馈编辑 开始-->
		<div class="modal fade" id="modal-einfo" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal" onclick="refreshe();">×</button>
					<h3 id="myModalLabel">编辑折损反馈信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>装运时间：</label>
							     <div class="input-group input-group-sm">
									<input class="form-control" id="transportTime_edt" type="text" placeholder="请输入装运时间"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>							   
							    </div>
							      <input class="form-control" id="id-hidden" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>车型：</label>
							     <input class="form-control" id="carType_edt" type="text" placeholder="请输入车型 "/>
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>经销单位：</label>
							     <select id="carShopId_edt" class="form-control" ><option value="">请选择经销单位</option>	</select>
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">联系方式：</label>
							     <input class="form-control" id="linkMobile_edt" type="text" placeholder="请输入联系方式  "/>
							  </div>							 								  
							    <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">情况描述：</label>
							     <textarea class="form-control" rows="3" id="mark_edt" name="mark_new" placeholder="请填写情况描述" ></textarea> 
							  </div>							  
							    <hr class="tree" style="margin-top: 60px;"></hr>
							    <div class="add-item-btn" id="editBtn">
								    <a class="add-itemBtn btnOk" onclick="doedsave();" style="margin-left: 130px;">保存</a>
								    <a class="add-itemBtn btnOk" onclick="refreshe();">关闭</a>
								 </div>								 
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
			<!-- 折损反馈编辑 结束-->
			
			<!-- 折损反馈明细查看 开始-->
		 <div class="modal fade" id="modal-message" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal" onclick="refreshview();">×</button>
					<h3 id="myModalLabel">查看折损反馈信息</h3>
				</div>
				<div class="modal-body" style="height:310px;overflow:auto;">
					<div class="mng" style="min-height:380px;">						
						<div class="table-item">
							<div class="table-itemTit">基本信息</div>
							<!-- 第一列 -->
							<div class="row newrow">
								<div class="col-xs-2 pd-2">
									<div class="lab-tit">
										<label>装运时间:</label>
									</div>
								</div>
								<div class="col-xs-10">
									<div class="form-contr">
										<p id="transportTime_view" class="form-control no-border"></p>
									</div>
								</div>								
							</div>
							<!-- 第二列 -->
							<div class="row newrow">
							<div class="col-xs-2 pd-2">
									<div class="lab-tit">
										<label>车型:</label>
									</div>
								</div>
								<div class="col-xs-10">
									<div class="form-contr">
										<p id="carType_view" class="form-control no-border"></p>
									</div>
								</div>							
							</div>
							<!-- 第三列 -->
							<div class="row newrow">
							<div class="col-xs-2 pd-2">
									<div class="lab-tit">
										<label>经销单位:</label>
									</div>
								</div>
								<div class="col-xs-10">
									<div class="form-contr">
										<p id="carShopId_view" class="form-control no-border"></p>
									</div>
								</div>																
								</div>								
							</div>	
							<!-- 第思列 -->
							<div class="row newrow">							
								<div class="col-xs-2 pd-2">
									<div class="lab-tit">
										<label>联系方式:</label>
									</div>
								</div>
								<div class="col-xs-10">
									<div class="form-contr">
										<p id="linkMobile_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							<!-- 第三列 -->
							<div class="row newrow">							
								<div class="col-xs-2 pd-2">
									<div class="lab-tit">
										<label>情况描述:</label>
									</div>
								</div>
								<div class="col-xs-10">
									<div class="form-contr">
										<p id="mark_view" class="form-control no-border"></p>
									</div>
								</div>								
							</div>						
							<!-- 操作按钮栏 -->
							<div class="row newrow">
								<div class="col-xs-5"></div>
								<div class="col-xs-2">
									<div class="form-contr">
										<a class="backbtn" onclick="doback();">
										<i class="icon-undo" style="display: inline-block; width: 20px;"></i>关闭</a>
									</div>
								</div>
								<div class="col-xs-5"></div>
							</div>
						</div>
					</div>
				</div>
			<!-- 折损反馈明细查看 结束-->
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
		 "sAjaxSource": "${ctx}/operationMng/carDamageFeedbackMng/getListData" , //获取数据的ajax方法的URL							 
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
				columns: [{ data: "rownum",'width':'6%'},
						    {data: "transportTime",'width':'8%'},
						    {data: "carType",'width':'8%'},
						    {data: "carShopName",'width':'8%'},
						    {data: "linkMobile",'width':'8%'},
						    {data: "mark",'width':'8%'},
						    {data: "insertUserName",'width':'8%'},
						    {data: "insertTime",'width':'12%'},
						    {data: "status",'width':'13%'},
						    {data: null,'width':'15%'}
							],
						    columnDefs: [
								{
									 //类型
									 targets:1,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonForDateFormat(data);
										 }else{
											 return '';
										 }
								     }	       
								},
								{
									 //类型
									 targets:7,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonDateFormat(data);
										 }else{
											 return '';
										 }
								     }	       
								},
								{
									 //状态
									 targets:8,
									 render: function (data, type, row, meta) {
								          if(data=='0'){
								        	 return '新建'; 
								          }else if(data=='1'){
								        	  return '待运单跟踪确认';
								          }else if(data=='2'){
								        	  return '待折损管理确认';
								          }else if(data=='3'){
								        	  return '待运营负责人确认';
								          }else if(data=='4'){
								        	  return '已完成';
								          }else{
								        	  return data;  
								          }
								      }	       
								},
								{
									 //操作
									 targets: 9,
									 render: function (data, type, row, meta) {
										 if(row.status=='0'){
											 return '<a class="table-edit" onclick="dosumbit('+ row.id +')">提交</a>'
										        +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
								                +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
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
		 "sAjaxSource": "${ctx}/operationMng/carDamageFeedbackMng/getListData" , //获取数据的ajax方法的URL	
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
			columns: [{ data: "rownum",'width':'6%'},
					    {data: "transportTime",'width':'8%'},
					    {data: "carType",'width':'8%'},
					    {data: "carShopName",'width':'8%'},
					    {data: "linkMobile",'width':'8%'},
					    {data: "mark",'width':'8%'},
					    {data: "insertUserName",'width':'8%'},
					    {data: "insertTime",'width':'12%'},
					    {data: "status",'width':'13%'},
					    {data: null,'width':'15%'}
						],
					    columnDefs: [
							{
								 //类型
								 targets:1,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonForDateFormat(data);
									 }else{
										 return '';
									 }
							     }	       
							},
							{
								 //类型
								 targets:7,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }
							     }	       
							},
							{
								 //状态
								 targets:8,
								 render: function (data, type, row, meta) {
							          if(data=='0'){
							        	 return '新建'; 
							          }else if(data=='1'){
							        	  return '待运单跟踪确认';
							          }else if(data=='2'){
							        	  return '待折损管理确认';
							          }else if(data=='3'){
							        	  return '待运营负责人确认';
							          }else if(data=='4'){
							        	  return '已完成';
							          }else{
							        	  return data;  
							          }
							      }	       
							},
							{
								 //操作
								 targets: 9,
								 render: function (data, type, row, meta) {
									 if(row.status=='0'){
										 return '<a class="table-edit" onclick="dosumbit('+ row.id +')">提交</a>'
									        +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
							                +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
									 }else{
										 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
									 }
							       }	           
							}
					      ],
				        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

$(function(){
	init();
	getCarNo();
})

/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   $('#secho').val(secho);
	   var driver=$('#driver').val();
	   var cardNo=$('#carNo').find('option:selected').html();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   if(cardNo=='' || cardNo==null || cardNo=='请选择装运车号'){
		   cardNo="";
	   }
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				carNumber : cardNo,
				driver : driver,
				startTime : startTime,
				endTime : endTime
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

/* 获取经销单位信息 */
function getCarNo(){
	 $.ajax({  
	        url: '${ctx}/basicSetting/carShopMng/getCarShopList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="" data-id="">请选择经销单位</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+' >'+data.data[i]['name']+'</option>';
	                		}
	            		}
	            	}
	            	$('#carShopId').html(html);
	            	$('#carShopId_new').html(html);
	            	$('#carShopId_edt').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
}

/* 车号联动驾驶员 */
function chooseDriver(e){
	var driver=$(e).find('option:selected').attr('data-driver');
	$('#driver').val(driver);
}



/* 新增 */
function doadd(){
	//location.href="${ctx}/operationMng/transportCostMng/addIndex";
	$("#transportTime_new").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$('#addBtn').show();
	$('#modal-info').modal('show');
}
/*新增折损反馈保存*/
function dosave(){
	var flag="false";
	var transportTime=$('#transportTime_new').val();
	var carType=$('#carType_new').val();	
	var carShopId=$('#carShopId_new').val();
	var linkMobile=$('#linkMobile_new').val();
	var mark=$('#mark_new').val();	
	if(transportTime==''|| transportTime==null){
		bootbox.alert('装运时间不能为空！');
		return;
	}
	if(carType==''|| carType==null){
		bootbox.alert('车型不能为空！');
		return;
	}
	if(carShopId==''|| carShopId==null){
		bootbox.alert('经销单位不能为空！');
		return;
	}
	/* if(linkMobile==''|| linkMobile==null){
		bootbox.alert('联系方式不能为空！');
		return;
	} */
		
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增折损反馈信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/carDamageFeedbackMng/save',
						data : JSON.stringify({
							transportTime : transportTime,				
							carType : carType,
							carShopId : carShopId,
							linkMobile : linkMobile,
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
											  flag="false";
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
										refresh();
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
//弹窗关闭
function refresh(){
	clearadd();
	$('#modal-info').modal('hide');
}
function clearadd(){
	$('#transportTime_new').val('');
	$('#carType_new').val('');
	$('#carShopId_new').val('');
	$('#linkMobile_new').val('');
	$('#mark_new').val('');
}
/* 编辑 */
function doedit(id){
	//location.href="${ctx}/operationMng/transportCostMng/editIndex/"+id;
	$("#transportTime_edt").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$('#editBtn').show();
	$('#modal-einfo').modal('show');
	$('#id-hidden').val(id);
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/carDamageFeedbackMng/getDetail/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));				
				if(data.data.transportTime!=''&&data.data.transportTime!=null){
					$('#transportTime_edt').val(jsonForDateFormat(data.data.transportTime));	
				}else{
					$('#transportTime_edt').val('');	
				}
				if(data.data.carShopId!=''&&data.data.carShopId!=null){
					$('#carShopId_edt').val(data.data.carShopId);	
				}else{
					$('#carShopId_edt').val('');	
				}
				$('#carType_edt').val(data.data.carType);
				$('#linkMobile_edt').val(data.data.linkMobile);	
				$('#mark_edt').val(data.data.mark);
				//$('#carShopId_edt').val(data.data.carShopId);	
				$('#editBtn').show();
				$('#modal-einfo').modal('show');
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
	
}

//弹窗关闭
function refreshe(){
	clearedit();
	$('#modal-einfo').modal('hide');
}
function clearedit(){
	$('#transportTime_edt').val('');
	$('#id-hidden').val('');
	$('#carType_edt').val('');
	$('#carShopId_edt').val('');
	$('#linkMobile_edt').val('');
	$('#mark_edt').val('');
}
/*编辑保存*/
function doedsave(){
	var flag="false";
	var transportTime=$('#transportTime_edt').val();
	var carType=$('#carType_edt').val();	
	var carShopId=$('#carShopId_edt').val();
	var linkMobile=$('#linkMobile_edt').val();
	var mark=$('#mark_edt').val();	
	if(transportTime==''|| transportTime==null){
		bootbox.alert('装运时间不能为空！');
		return;
	}
	if(carType==''|| carType==null){
		bootbox.alert('车型不能为空！');
		return;
	}
	if(carShopId==''|| carShopId==null){
		bootbox.alert('经销单位不能为空！');
		return;
	}
	/* if(linkMobile==''|| linkMobile==null){
		bootbox.alert('联系方式不能为空！');
		return;
	} */
	//console.info($('#id-hidden').val());
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增折损反馈信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/carDamageFeedbackMng/update',
						data : JSON.stringify({
							id :$('#id-hidden').val(),
							transportTime : transportTime,				
							carType : carType,
							carShopId : carShopId,
							linkMobile : linkMobile,
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
											  flag="false";
											  refreshe();
											  reload();
										  }else{
											  refreshe();  
											  reload();
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										refreshe();
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
/* 查看 */
function doshow(id){
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/carDamageFeedbackMng/getDetail/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));				
				if(data.data.transportTime!=''&&data.data.transportTime!=null){
					$('#transportTime_view').html(jsonForDateFormat(data.data.transportTime));	
				}else{
					$('#transportTime_view').html('');	
				}
				if(data.data.carShopId!=''&&data.data.carShopId!=null){
					$('#carShopId_view').html(data.data.carShopName);	
				}else{
					$('#carShopId_view').html('');	
				}
				$('#carType_view').html(data.data.carType);
				$('#linkMobile_view').html(data.data.linkMobile);	
				$('#mark_view').html(data.data.mark);
				//$('#carShopId_edt').val(data.data.carShopId);	
				$('#editBtn').show();
				$('#modal-message').modal('show');
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}

/* 删除申请信息 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该折损反馈信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/carDamageFeedbackMng/delete/"+id,
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
 });
}

/* 提交申请信息 */
function dosumbit(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该折损反馈信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/carDamageFeedbackMng/submit/"+id,
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
 });
}

function refreshview(){
	$('#modal-message').modal('hide');
}
function doback(){
	$('#modal-message').modal('hide');
}
</script>



</body>
</html>






