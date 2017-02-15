
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
					已阅消息
				</small>
			</h1>
		</div><!-- /.page-header -->
	    <div class="page-content">
			  <div class="detailInfo">
			    <table id="detailtable" class="table table-striped table-bordered table-hover">
                       <thead>
                         <tr>
                           <th>标题</th>
                           <th>操作时间</th>
                           <th>发送时间</th>
                         </tr>
                       </thead>
                       <tbody>
                       </tbody>
                 </table>
                 <!-- 查看消息Modal---begin---> 
             		<div class="modal fade" id="modal-message" tabindex="-1" role="dialog" data-backdrop="static">
                       <div class="modal-header">
                         <button class="close" type="button" data-dismiss="modal" onclick="refresh()">×</button>
                         <h3 id="myMesgModalLabel">已阅消息</h3></div>
                       <div class="modal-body">
                         <div>
                           <div class="widget-box dia-widget-box">
                             <div class="widget-body">
                               <div class="widget-main">
                                 <input type="hidden" id="messageid" name="messageid" />
                                 <div class="add-item">
                                   <p id="mesagetype" class="form-control no-border" style="height: 150px;"></p>
                                 </div>
                                 <div class="add-item-btn" id="messageviewBtn" style="margin-left: 250px;display:block;">
                                   <a class="add-itemBtn btnOk" onclick="refresh()">关闭</a></div>
                               </div>
                             </div>
                           </div>
                         </div>
                       </div>
                     </div>
                 <!-- 查看消息Modal---end--->
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
	init();
});
function init(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/dailyOffice/message/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{data: "mark","width":"70%"},
		    {data: "insertTime","width":"20%"},
		    {data: null,"width":"10%"}], 
		    columnDefs: [{
				 //时间
				 targets: 1,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonDateFormat(data);
					 }else{
						 return '';
					 }				
			       }	       
			   },
			    {
					 targets: 2,
					 render: function (data, type, row, meta) {
						 return '<a class="table-edit" onclick="doedit('+row.id+')">查看</a>';
				       }	       
				}
		      ],		   
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
 });
}
function reload(){
	var myTable = $('#detailtable').DataTable({
		"destroy": true,//如果需要重新加载需销毁
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据 
		 "sAjaxSource": "${ctx}/dailyOffice/message/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{data: "mark","width":"70%"},
		    {data: "insertTime","width":"20%"},
		    {data: null,"width":"10%"}], 
		    columnDefs: [{
				 //时间
				 targets: 1,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonDateFormat(data);
					 }else{
						 return '';
					 }				
			       }	       
			   },
			    {
					 targets: 2,
					 render: function (data, type, row, meta) {
						 return '<a class="table-edit" onclick="doedit('+row.id+')">查看</a>';
				       }	       
				}
		      ],		   
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
 });
}
function retrieveData(sSource, aoData, fnCallback){
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
				name :'',
				status :'Y'
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
						var totalCounts=data.data.totalCounts;
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
/* 获取查看数据 */
function doedit(id){
	$('#modal-message').modal('show');
	$.ajax({
		type : 'GET',
		url : "${ctx}/dailyOffice/message/getDetailData/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#mesagetype').html(data.data.mark);
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	});
}
function refresh(){
	$('#modal-message').modal('hide');
}
</script>

</body>
</html>






