
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/ztree/zTreeStyle/zTreeStyle.css" type="text/css" />
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
				内部通讯录
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">部门查询：</label>
		    <select id="form-dep" class="form-box">
			</select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>工号</th>
					<th>姓名</th>
                    <th>部门</th>
                    <th>职务</th>
                    <th>出生日期</th>
					<th>性别</th>
                    <th>电话号码</th>
                    <th>手机号码</th>
                    <th>集团短号</th>
                    <th>家庭住址</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
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
<script type="text/javascript">

function init(){
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/commonSetting/intAddBook/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum" },
		    {data: "workNo"},
		    {data: "name"},
		    {data: "departmentName"},
		    {data: "title"},
		    {data: "brithday"},
		    {data: "sex"},
		    {data: "telephone"},
		    {data: "mobile"},
		    {data: "shortMobile"},
		    {data: "address"}
			],
		    columnDefs: [
				{
					 //日期
					 targets:5,
					 render: function (data, type, row, meta) {
				           if(data!=''&&data!=null){
								 return jsonForDateFormat(data);
							 }else{
								 return '';
							 }
				       }	       
				},
				{
					 //性别
					 targets: 6,
					 render: function (data, type, row, meta) {
						 if(data=="1"){
							return '男';
						 }else{
							 return '女'; 
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
		 "sAjaxSource": "${ctx}/commonSetting/intAddBook/getListData" , //获取数据的ajax方法的URL	
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
			 columns: [{ data: "rownum",'width': "5%"},
					    {data: "workNo",'width': "10%"},
					    {data: "name",'width': "13%"},
					    {data: "departmentName",'width': "10%"},
					    {data: "title",'width': "10%"},
					    {data: "brithday",'width': "10%"},
					    {data: "sex",'width': "5%"},
					    {data: "telephone",'width': "10%"},
					    {data: "mobile",'width': "10%"},
					    {data: "shortMobile",'width': "7%"},
					    {data: "address",'width': "10%"}
						],
					    columnDefs: [
							{
								 //日期
								 targets:5,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonForDateFormat(data);
									 }else{
										 return '';
									 }
							       }	       
							},
							{
								 //性别
								 targets: 6,
								 render: function (data, type, row, meta) {
									 if(data=="1"){
										return '男';
									 }else{
										 return '女'; 
									 }
							       }	       
							}
					      ],
				        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
/* 获取部门信息 */
function getdep(){
	$.ajax({  
        url: '${ctx}/commonSetting/intAddBook/getDepartmentList',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: '',
        success: function (data) {
        	/* var html ='<option value="-1">请选择部门</option>'; */
        	var html="";
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                		}
            		}
            	}
            	$('#form-dep').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}


$(function(){
	init();
	getdep();
})

/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   $('#secho').val(secho);
	   var departmentId=$.trim($('#form-dep').val());
	   if(departmentId=='1' || departmentId=='' || departmentId==null){
		   departmentId=null;
	   }
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				departmentId : departmentId,
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

</script>



</body>
</html>






