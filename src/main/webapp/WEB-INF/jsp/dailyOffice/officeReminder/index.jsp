
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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=no"/>
<meta name="renderer" content="webkit|ie-comp|ie-stand" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/Confirm.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<script type="text/javascript" src="${ctx}/staticPublic/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${ctx}/staticPublic/js/popbox/Confirm.js"></script>
<title>主页</title>
<style type="text/css">
#modal-detilinfo{width: 1000px;height: 600px;margin: auto;background: rgb(255, 255, 255);overflow: auto;}  
.well{margin-bottom : 0px;}
</style>
</head>
<body class="white-bg">
<div class="page-content">
	 <div class="page-header">
			<h1>
				日常办公
				<small>
					<i class="icon-double-angle-right"></i>
					我的备忘
				</small>
			</h1>
		</div><!-- /.page-header -->
	    <div class="page-content">
              <div class="searchbox col-xs-12">
				<a class="itemBtn" onclick="doaddreminder()">新增</a>
			  </div>
			  <div class="detailInfo">
			    <table id="detailtable" class="table table-striped table-bordered table-hover">
                       <thead>
                         <tr>
                           <th>标题</th>
                           <th>操作时间</th>
                           <th>操作</th>
                         </tr>
                       </thead>
                       <tbody>
                       </tbody>
                 </table>
                 <!-- 备忘新增Modal---begin---> 
             <div class="modal fade" id="modal-reminder" tabindex="-1" role="dialog" data-backdrop="static">
                  <div class="modal-header">
                    <button class="close" type="button" data-dismiss="modal">×</button>
                    <h3 id="myModalLabel">备忘信息</h3></div>
                  <div class="modal-body">
                    <div>
                      <div class="widget-box dia-widget-box">
                        <div class="widget-body">
                          <div class="widget-main">
                            <div class="add-item ">
                              <input type="hidden" id="reminderid" name="reminderid" />
                              <textarea rows="4" cols="4" class="form-control" id="reminder_mark" placeholder="请输入备忘信息"></textarea>
                            </div>
                            <hr class="tree"></hr>
                            <div class="add-item-btn" id="reminderaddBtn" style="margin-left: 150px;">
                              <a class="add-itemBtn btnOk" onclick="dosavereminder()">保存</a>
                              <a class="add-itemBtn btnOk" onclick="doclosereminder()">关闭</a></div>
                            <div class="add-item-btn" id="remindereditBtn" style="margin-left: 150px;">
                              <a class="add-itemBtn btnOk" onclick="doupreminder()">保存</a>
                              <a class="add-itemBtn btnOk" onclick="doclosereminder()">关闭</a></div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              <!-- 备忘新增Modal---end--->
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
<script src="${ctx}/staticPublic/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
$(function(){
	reminderinit();
});

function reminderinit(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 //"sDom": 'rt',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "bInfo" : false,	
		 "bRetrieve": true,
		 'iDisplayLength': 5,//每页显示个数 
		 "sAjaxSource": "${ctx}/dailyOffice/officeReminder/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{data: "mark","width":"60%"},
		    {data: "updateTime","width":"20%"} ,
		    {data: null,"width":"20%"}], 
		    columnDefs: [{
				 //入职时间
				 targets: 1,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonDateFormat(data);
					 }else{
						 return '';
					 }				
			       }	       
				},{
					 targets: 2,
					 render: function (data, type, row, meta) {
						 return '<a class="table-edit" onclick="doeditreminder('+row.id+')">编辑</a>'
						       +'<a class="table-delete" onclick="dodeletereminder('+row.id+')">删除</a>';
						 
				       }	       
				}
		      ],		   
	        "fnServerData":remretrieveData //与后台交互获取数据的处理函数
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
		 "sAjaxSource": "${ctx}/dailyOffice/officeReminder/getListData", //获取数据的ajax方法的URL	
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
				 columns: [{data: "mark","width":"60%"},
						    {data: "updateTime","width":"20%"} ,
						    {data: null,"width":"20%"}], 
						    columnDefs: [{
								 //入职时间
								 targets: 1,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }				
							       }	       
								},{
									 targets: 2,
									 render: function (data, type, row, meta) {
										 return '<a class="table-edit" onclick="doeditreminder('+row.id+')">编辑</a>'
									            +'<a class="table-delete" onclick="dodeletereminder('+row.id+')">删除</a>';	
								       }	       
								}
						      ],		   
					        "fnServerData":remretrieveData //与后台交互获取数据的处理函数
    });
}

 /* 数据交互 */
	function remretrieveData(sSource, aoData, fnCallback){
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
					mark :''
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
	

function doaddreminder(){	
	clearreminder();
	$('#modal-reminder').modal('show');
	$('#reminderaddBtn').show();
	$('#remindereditBtn').hide();
}
function doclosereminder(){
	$('#modal-reminder').modal('hide');
}
function clearreminder(){
	$('#reminder_mark').val('');
	$('#reminderid').val('');
}
function dosavereminder(){
	var flag="false";
	var reminder_mark=$('#reminder_mark').val();
	if(reminder_mark==''){
		 bootbox.alert('备忘信息不可为空！');
		 return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存吗?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/dailyOffice/officeReminder/save",
						data : JSON.stringify({
							mark : $.trim(reminder_mark)
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
											  doclosereminder();
										  }else{
											reload();
											doclosereminder();
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										 reload();
										 doclosereminder();
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
function doeditreminder(id){
	clearreminder();
	$('#modal-reminder').modal('show');
	$('#reminderaddBtn').hide();
	$('#remindereditBtn').show();
	$.ajax({
		type : 'GET',
		url : "${ctx}/dailyOffice/officeReminder/getDetailData/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {				
				$('#reminder_mark').val(data.data.mark);
				$('#reminderid').val(id);
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	});
}
function doupreminder(){
	var flag="false";
	var reminderid=$('#reminderid').val();
	var reminder_mark=$('#reminder_mark').val();
	if(reminder_mark==''){
		 bootbox.alert('备忘信息不可为空！');
		 return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存吗?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/dailyOffice/officeReminder/update",
						data : JSON.stringify({
							id: $.trim(reminderid),
							mark : $.trim(reminder_mark)
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
											  doclosereminder();
										  }else{
											reload();
											doclosereminder();
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										 reload();
										 doclosereminder();
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

/*删除备份信息*/
function dodeletereminder(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除吗?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/dailyOffice/officeReminder/delete/"+id,
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
										 doclosereminder();
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






