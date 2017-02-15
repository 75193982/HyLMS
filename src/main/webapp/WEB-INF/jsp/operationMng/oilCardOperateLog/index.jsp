<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
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
<title>油卡收支信息管理</title>
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			油卡管理
			<small>
				<i class="icon-double-angle-right"></i>
				收支信息管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title" style="float: left;margin-left: 20px;">类型：</label>
		    <select id="fom_type" class="form-box" style="width: 180px;float: left;">
			   <option value="">请选择类型</option>
			   <option value="0">充值</option>
			   <option value="1">消费</option>
		   	</select>
		   	<label class="title" style="float:left;">创建时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 175px;margin-right:30px; margin-left: 5px;height:35px;line-height:35px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入创建开始时间" style="height:35px;line-height:35px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 5px;width:39px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 175px;margin-right:30px;margin-left: 5px;height:35px;line-height:35px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入创建结束时间" style="height:35px;line-height:35px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		</div>
		<div class="searchbox col-xs-12">
		   <label class="title">使用人：</label>
		    <input id="fom_receiveUser" class="form-box" type="text" placeholder="请填写使用人(模糊查询)" onkeyup="searchSchedule2(this)"/>
		    <input id="fom_receiveUser_hidden" class="form-box" type="hidden" />
		    <div id="selectItem9" class="selectItemhidden" style="height: 150px;width: 200px;">
										<div id="selectItemCount" class="selectItemcont">
											<div id="selectCarNo2" style="height: 150px;">
											
											</div>
										</div>
									</div>
		    
		   	<label class="title" style="padding-left: 20px;">状态：</label>
		   	<select id="fom_status" class="form-box" style="width: 180px;">
			   <option value="">请选择状态</option>
			   <option value="0">新建</option>
			   <option value="1">待确认</option>
			   <option value="2">已完成</option>
		   	</select>
			<a class="itemBtn m-lr5" onclick="searchInfo()">查询</a>
			<a class="itemBtn m-lr5" onclick="doadd()">新增</a>
		</div>
		<div class="detailInfo">
			<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>类型</th>
					<th>申请金额</th>
					<th>实付金额</th>
                    <th>使用人</th>
                    <th>卡号</th>
                    <th>备注</th>
                    <th>状态</th> 
                    <th>创建人</th>
                    <th>创建时间</th>  
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div id="sumCount" class="sumCount" style="width: 600px;">
			   <p class="sumInfo">当页总计(元)：<span id="localSum"></span></p>
			   <p class="sumInfo">费用总计(元)：<span id="allSum" ></span></p>
			</div>
				<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static" style="height: 450px;">
				     <div class="modal-header" >
				        <button class="close" type="button" onclick="cancel();">×</button>
						<h3 id="myModalLabel">新增收支信息</h3>
				    </div>
					<div class="modal-body" >
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>类型：</label>
								      <select id="type" class="form-control">
									      <option value="">请选择类型</option>
									      <option value="0">充值</option>
									      <option value="1">消费</option>
									    </select>
								     <input class="form-control" id="id-hidden" type="hidden"/>
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>实付金额：</label>
									     <input class="form-control" id="money" type="text" placeholder="请填写金额"/>
									 </div>
									  <div id="showdiv">
								  		<hr class="tree"></hr>
										<div class="add-item extra-itemSec">
										     <label class="title"><span class="red">*</span>使用人：</label>
										     <input class="form-control" id="receiveUserId" type="text" placeholder="请填写使用人(模糊查询)" onkeyup="searchSchedule(this)"/>
										 	<input class="form-control" id="receiveUserId-hidden" type="hidden"/>
										 </div>
										 <div id="selectItem8" class="selectItemhidden" style="height: 150px;">
											<div id="selectItemCount" class="selectItemcont">
												<div id="selectCarNo" style="height: 150px;">
											
												</div>
											</div>
										</div>
										</div>
									    <hr class="tree"></hr>
									    <div class="add-item extra-itemSec">
										     <label class="title"><span class="red">*</span>卡号：</label>
										     <select id="oilCardNo" class="form-control" >
											   <option value="">请选择卡号</option>
											   
										   	</select>
										     <!-- <input class="form-control" id="oilCardNo" type="text" placeholder="请填写卡号"/> -->
										 </div>
								    <hr class="tree"></hr>
									<div class="add-item extra-itemSec">
									     <label class="title"><span class="red" ></span>备注：</label>
									     <input class="form-control" id="mark" type="text" placeholder="请填写备注"/>
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
			
					<div class="modal fade" id="modal-einfo" tabindex="-1" role="dialog" data-backdrop="static" style="height: 500px;">
				     <div class="modal-header" >
				        <button class="close" type="button" onclick="cancelSure();">×</button>
						<h3 id="myModalLabel">确认收支信息</h3>
				    </div>
					<div class="modal-body" >
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-itemSec">
								     <label class="title">驾驶员：</label>
								     <input class="form-control" id="sureUser" type="text" readonly="readonly"/>
								     <input class="form-control" id="sureIdHidden" type="hidden" />
								    </div>
							  		<hr class="tree"></hr>
									<div class="add-item extra-itemSec">
									     <label class="title">上期结余：</label>
									     <input class="form-control" id="jieyu" type="text" readonly="readonly"/>
									</div>
								  	<hr class="tree"></hr>
									<div class="add-item extra-itemSec">
										 <label class="title">申请金额：</label>
										 <input class="form-control" id="applyMoney" type="text" readonly="readonly"/>
									</div>
									<hr class="tree"></hr>
									<div class="add-item extra-itemSec">
										 <label class="title"><span class="red">*</span>实付金额：</label>
										 <input class="form-control" id="sureMoney" type="text" placeholder="请填写金额"/>
								    </div>
								    <hr class="tree"></hr>
									<div class="add-item extra-itemSec">
									     <label class="title"><span class="red" >*</span>选择卡号：</label>
									     <select id="sureOilCardNo" class="form-control" >
											   <option value="">请选择卡号</option>
										 </select>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="queDing();">确定</a>
									    <a class="add-itemBtn btnCancle" onclick="cancelSure();">取消</a>
									 </div>
									</div>
						  </div>
					  </div>
					</div>
			</div>
			
		<!-- 查看油卡收支信息-->
			<div class="modal fade" id="modal-show" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="showRefresh();">×</button>
						<h3 id="myModalLabel">查看油卡收支信息</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item show-item">
								     <label class="title">类型：</label>
								     <p id="showType"></p> 
								    </div>
								    <hr class="tree"></hr>
									 <div class="add-item show-item">
									     <label class="title">申请金额：</label>
									     <p id="showApplyMoney"></p> 
									 </div>
							  		<hr class="tree"></hr>
									 <div class="add-item show-item">
									     <label class="title">实付金额：</label>
									     <p id="showMoney"></p> 
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item show-item">
									     <label class="title">使用人：</label>
									     <p id="showUser"></p> 
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item show-item">
									     <label class="title">卡号：</label>
									     <p id="showCardNo"></p> 
									 </div>
								    <hr class="tree"></hr>
									<div class="add-item show-item">
									     <label class="title">备注：</label>
									     <p id="showMark"></p> 
									 </div>
								    <hr class="tree"></hr>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
	
	<!-- 查看油卡收支信息--end -->
			
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
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script>
<script type="text/javascript">
function searchSchedule(e){
	var $val=$(e).val();
	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/oilCardOperateLog/getReceiveUser",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		data: JSON.stringify({
			name : $val
		}),
		success : function(data) {
			if (data && data.code == 200) {
				var html = "";
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<p id='+data.data[i]['id']+' onclick=\'clickp(this)\'>【'+data.data[i]['departmentName']+'】'+data.data[i]['name']+'</p>';
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
		"top" : "157px",
		"left" : "132px"
	});
	if( null == $val || '' == $val)
	{
		$('#receiveUserId-hidden').val('');
		bindCardNo('','');
	}
}
function clickp(e){
	$('#receiveUserId').val($(e).html());
	$('#receiveUserId-hidden').val($(e).attr("id"));
	bindCardNo($(e).attr("id"),'');
	$('#selectItem8').hide();
};
$(document).click(function(event) {
   $('#selectItem8').hide();
   $('#selectItem9').hide();
});

function searchSchedule2(e){
	var $val=$(e).val();
	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/oilCardOperateLog/getReceiveUser",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		data: JSON.stringify({
			name : $val
		}),
		success : function(data) {
			if (data && data.code == 200) {
				var html = "";
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<p id='+data.data[i]['id']+' onclick=\'clickpp(this)\'>【'+data.data[i]['departmentName']+'】'+data.data[i]['name']+'</p>';
	            		}
	        		}
	        	}
	        	$('#selectCarNo2').html(html);
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
	var A_top = $(e).offset().top + $(e).outerHeight(true); //  1
	var A_left = $(e).offset().left;
	$('#selectItem9').show().css({
		"position" : "absolute",
		"top" : "34px",
		"left" : "86px",
	});
	if( null == $val || '' == $val)
	{
		$('#fom_receiveUser_hidden').val('');
		bindCardNo('','');
	}
}
function clickpp(e){
	$('#fom_receiveUser').val($(e).html());
	$('#fom_receiveUser_hidden').val($(e).attr("id"));
	bindCardNo($(e).attr("id"),'');
	$('#selectItem9').hide();
};

//绑定卡号
function bindCardNo(receiveUser,cardNo)
{
	$.ajax({  
        url: '${ctx}/operationMng/oilCardOperateLog/getCardNo',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",  
		dataType : 'JSON',
        data: JSON.stringify({
        	receiveUser : receiveUser
        }),
        success: function (data) {
        	var html ='<option value="" data-id="">请选择卡号</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
            				if(data.data[i]['cardNo'] == cardNo)
            				{
            					html +='<option selected value='+data.data[i]['cardNo']+' rUser='+data.data[i]['receiveUser']+'>'+data.data[i]['cardNo']+'</option>';
            				}else{
            					html +='<option value='+data.data[i]['cardNo']+' rUser='+data.data[i]['receiveUser']+'>'+data.data[i]['cardNo']+'</option>';
            				}
                		}
            		}
            	}
            	$('#oilCardNo').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}
	
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/oilCardOperateLog/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum" ,"width":"5%"},
		    {data: "type","width":"5%"},
		    {data: "applyMoney","width":"8%"},
		    {data: "money","width":"8%"},
		    {data: "receiveUserName","width":"9%"},
		    {data: "oilCardNo","width":"10%"},
		    {data: "mark","width":"10%"},
		    {data: "status","width":"10%"},
		    {data: "insertUserName","width":"10%"},
		    {data: "insertTime","width":"10%"},		   		       
		    {data: null,"width":"15%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 1,
				 render: function (data, type, row, meta) {
					if(data=='0'){
						return '充值';
					}else if(data=='1'){
						return '消费';
					}else{
						return '';
					}
			       }	       
			},{
				 //状态
				 targets: 7,
				 render: function (data, type, row, meta) {
					if(data=='0'){
						return '新建';
					}else if(data=='1'){
						return '待确认';
					}else if(data=='2'){
						return '已完成';
					}else{
						return '';
					}
			       }	       
			},{
				 //入职时间
				 targets: 9,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonDateFormat(data);
					 }else{
						 return '';
					 }
					
			       }	       
			},{
			    	 //操作栏
			    	 targets: 10,
			    	 render: function (data, type, row, meta) {
			    			if(row.status=='0')
			    			{
			    				return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
				    			   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
						           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
			    			}
			    			else if(row.status=='1')
			    			{
			    				return '<a class="table-edit" onclick="dosure('+ row.id +')">确认</a>'
			    				+'<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';	
			    			}
			    			else{
			    				return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';	
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
		 "sAjaxSource": "${ctx}/operationMng/oilCardOperateLog/getListData", //获取数据的ajax方法的URL	
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
				columns: [{ data: "rownum" ,"width":"5%"},
						    {data: "type","width":"5%"},
						    {data: "applyMoney","width":"8%"},
						    {data: "money","width":"8%"},
						    {data: "receiveUserName","width":"9%"},	
						    {data: "oilCardNo","width":"10%"},
						    {data: "mark","width":"10%"},
						    {data: "status","width":"10%"},
						    {data: "insertUserName","width":"10%"},
						    {data: "insertTime","width":"10%"},		   		       
						    {data: null,"width":"15%"}],
						    columnDefs: [
									{
										 //入职时间
										 targets: 1,
										 render: function (data, type, row, meta) {
											if(data=='0'){
												return '充值';
											}else if(data=='1'){
												return '消费';
											}else{
												return '';
											}
									      }	       
									},{
										 //状态
										 targets: 7,
										 render: function (data, type, row, meta) {
											if(data=='0'){
												return '新建';
											}else if(data=='1'){
												return '待确认';
											}else if(data=='2'){
												return '已完成';
											}else{
												return '';
											}
									      }	       
									},{
										 //入职时间
										 targets: 9,
										 render: function (data, type, row, meta) {
											 if(data!=''&&data!=null){
												 return jsonDateFormat(data);
											 }else{
												 return '';
											 }
											
									      }	       
									},{
									   	 //操作栏
									   	 targets: 10,
									   	 render: function (data, type, row, meta) {
								    			if(row.status=='0')
								    			{
								    				return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
									    			   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
											           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
								    			}
								    			else if(row.status=='1')
								    			{
								    				return '<a class="table-edit" onclick="dosure('+ row.id +')">确认</a>'
								    				+'<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';	
								    			}
								    			else{
								    				return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';	
								    			}
									               
									     }	       
									} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
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
	$('#showdiv').hide();
})
/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var type=$("#fom_type").val(); 
	   var status=$("#fom_status").val(); 
	   var receiveUserId = $("#fom_receiveUser_hidden").val();
	   var startTime=$("#startTime").val(); 
	   var endTime=$("#endTime").val(); 
	   
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				type :$.trim(type),
				status :$.trim(status),
				receiveUserId :$.trim(receiveUserId),
				startTime :$.trim(startTime),
				endTime :$.trim(endTime)
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {	
					
					obj.iTotalDisplayRecords=data.data.totalCounts;
					obj.iTotalRecords=data.data.totalCounts;
					obj.aaData=data.data.records;		
					obj.sEcho=data.data.frontParams;
					var sum=0;
					var allsum=0;
					var income=0;
					var outcome=0;
					var allincome=data.inCount;
					var alloutcome=data.outCount;
					if(obj.aaData.length>0){
						for(var i=0;i<obj.aaData.length;i++){
							obj.aaData[i]["rownum"]=i+1;
							if(obj.aaData[i]["type"]=='0'){
								income+=parseFloat(obj.aaData[i]["money"]);
							}else{
								outcome+=parseFloat(obj.aaData[i]["money"]);
							} 
						}
					}else{
						obj.aaData=[];
					}
					allsum=parseFloat(parseFloat(allincome).toFixed(2)-parseFloat(alloutcome).toFixed(2)).toFixed(2);
					sum=parseFloat(income.toFixed(2)-outcome.toFixed(2)).toFixed(2);
					fnCallback(obj); //服务器端返回的对象的returnObject部分是要求的格式  	
					$('#localSum').html('充值：'+income.toFixed(2)+'&nbsp;&nbsp;消费：'+outcome.toFixed(2)+'&nbsp;&nbsp;余额：'+sum);
					$('#allSum').html('充值：'+parseFloat(allincome).toFixed(2)+'&nbsp;&nbsp;消费：'+parseFloat(alloutcome).toFixed(2)+'&nbsp;&nbsp;余额：'+allsum);
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

/*新增信息输入  */
function doadd(){
	clear();
	$('#type').change(function(){
		var p1=$(this).children('option:selected').val();
		if("1" == p1)
		{
			$('#showdiv').show();
		}
		else
		{
			bindCardNo('','');
			$('#showdiv').hide();
		}
	});
	bindCardNo('','');
	$('#oilCardNo').change(function(){
		var p1=$(this).children('option:selected').attr('rUser');
		if("" == p1 || "null" == p1 || null == p1)
		{
			bootbox.alert('请先发放卡！');
			return;
		}
		
	});
	$('#addBtn').show();
	$('#editBtn').hide();
	$('#myModalLabel').html('新增收支信息');	
	$('#modal-info').modal('show');
}

/* 数据重置 */
function clear(){
	$('#id-hidden').val('');
	$('#type').val('');
	$('#money').val('');
	$('#receiveUserId').val('');
	$('#oilCardNo').val('');
	$('#mark').val('');
}
function cancel()
{
	clear();
	$('#modal-info').modal('hide');
	$('#showdiv').hide();
}

/* 新增保存 */
function save(){
	var flag="false";
	   var type=$('#type').val();
	   var money=$('#money').val();
	   var receiveUserId="";
	   var oilCardNo=$('#oilCardNo').val();
	   var oilF=$("#oilCardNo option:selected").attr("rUser");
	   var mark=$('#mark').val();
	   if("1" == type)
	   {
		   receiveUserId = $('#receiveUserId-hidden').val();
		   if(receiveUserId=='' || receiveUserId==null){
			   bootbox.alert('使用人不能为空！');
			   return;
		   }
	   }
	   console.info(oilF);
	   if(type=='' || type==null){
		   bootbox.alert('类型不能为空！');
		   return;
	   }
	   if(money=='' || money==null){
		   bootbox.alert('金额不能为空！');
		   return;
	   }
	   
	   if(oilCardNo=='' || oilCardNo==null){
		   bootbox.alert('油卡不能为空！');
		   return;
	   }
	   if(oilF=='' || oilF==null || "null" == oilF){
		   bootbox.alert('请先发放卡！');
		   return;
	   }
	   
	   bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该油卡收支信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : "${ctx}/operationMng/oilCardOperateLog/save",
							data : JSON.stringify({
								id : $.trim($('#id-hidden').val()),
								type : type,
								money : money,
								receiveUserId : receiveUserId,
								oilCardNo : oilCardNo,
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
												  $('#modal-info').modal('hide');
													reload();
											  }else{
												  $('#modal-info').modal('hide');
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

function doedit(id)
{
	$('#id-hidden').val(id);
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/oilCardOperateLog/getById/"+id,
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#type').val(data.data.type);
				$('#money').val(data.data.money);
				if("1" == data.data.type)
				{
					$('#receiveUserId').val(data.data.receiveUserName);
					$('#receiveUserId-hidden').val(data.data.receiveUserId);
					bindCardNo(data.data.receiveUserId,data.data.oilCardNo);
					//$('#oilCardNo').val(data.data.cardNo); 
					$('#showdiv').show();
				}
				else
				{
					$('#receiveUserId').val('');
					$('#receiveUserId-hidden').val('');
					bindCardNo('',data.data.oilCardNo);
				}
				$('#mark').val(data.data.mark);
				
				$('#type').change(function(){
					var p1=$(this).children('option:selected').val();
					if("1" == p1)
					{
						bindCardNo(data.data.receiveUserId,'');
						$('#showdiv').show();
					}
					else
					{
						bindCardNo('','');
						$('#showdiv').hide();
					}
				});
				
			} else {
				 bootbox.alert(data.msg);
			}
			
		}
	}); 
	
	$('#addBtn').show();
	$('#editBtn').hide();
	$('#myModalLabel').html('编辑收支信息');	
	$('#modal-info').modal('show');
}
//提交
function dosubmit(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该油卡支付信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/oilCardOperateLog/submit/"+id,
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

/* 删除*/
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该油卡收支信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/oilCardOperateLog/delete/"+id,
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
//查看
function doview(id)
{
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/oilCardOperateLog/getById/"+id,
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				if("1" == data.data.type)
				{
					data.data.type = '消费';
				}
				else if("0" == data.data.type){
					data.data.type = '充值';
				}
				else
				{
					data.data.type = '';
				}
				$('#showType').html(data.data.type);
				$('#showApplyMoney').html(data.data.applyMoney);
				$('#showMoney').html(data.data.money);
				$('#showUser').html(data.data.receiveUserName);
				$('#showCardNo').html(data.data.oilCardNo);
				$('#showMark').html(data.data.mark);
			} else {
				 bootbox.alert(data.msg);
			}
		}
	}); 
	
	$('#modal-show').modal('show');
}
/* 关闭取消窗口 */
function showRefresh(){
	$('#modal-show').modal('hide');
}

//确认
function dosure(id)
{
	$('#sureIdHidden').val(id);
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/oilCardOperateLog/dosure/"+id,
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#sureUser').val(data.data.receiveUserName);
				$('#jieyu').val(data.data.jieyu);
				$('#applyMoney').val(data.data.applyMoney);
				//$('#sureOilCardNo').html(data.data.mark);
					$.ajax({  
				        url: '${ctx}/operationMng/oilCardOperateLog/getCardNo',  
				        type: "post",  
				        contentType : "application/json;charset=UTF-8",  
						dataType : 'JSON',
				        data: JSON.stringify({
				        	receiveUser : data.data.receiveUserId
				        }),
				        success: function (data) {
				        	var html ='<option value="" data-id="">请选择卡号</option>';
				            if(data.code == 200){  
				            	if(data.data!=null && data.data!=''){
				            		if(data.data.length>0){
				            			for(var i=0;i<data.data.length;i++){
				            				html +='<option value='+data.data[i]['cardNo']+' rUser='+data.data[i]['receiveUser']+'>'+data.data[i]['cardNo']+'</option>';
				                		}
				            		}
				            	}
				            	$('#sureOilCardNo').html(html);
				               }else{  
				            	   bootbox.alert('加载失败！');
				               }  
				        }  
				      }); 
			} else {
				 bootbox.alert(data.msg);
			}
		}
	}); 
	
	$('#modal-einfo').modal('show');
}
//关闭
function cancelSure(){
	$('#modal-einfo').modal('hide');
}
//确认 保存
function queDing()
{
	var flag="false";
	   var money=$('#sureMoney').val();
	   var oilCardNo=$('#sureOilCardNo').val();
	   
	   if(money=='' || money==null){
		   bootbox.alert('金额不能为空！');
		   return;
	   }
	   
	   if(oilCardNo=='' || oilCardNo==null){
		   bootbox.alert('卡号不能为空！');
		   return;
	   }
	   
	   bootbox.confirm({ 
			  size: "small",
			  message: "确定该油卡收支信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : "${ctx}/operationMng/oilCardOperateLog/sureSave",
							data : JSON.stringify({
								id : $.trim($('#sureIdHidden').val()),
								money : money,
								oilCardNo : oilCardNo
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
												  $('#modal-einfo').modal('hide');
													reload();
											  }else{
												  $('#modal-einfo').modal('hide');
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
</script>
</body>
</html>