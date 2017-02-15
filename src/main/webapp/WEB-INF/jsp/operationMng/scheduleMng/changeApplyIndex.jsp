
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
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
				快速调度修改申请
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
	  <div class="contentDetail">
		<div class="searchbox col-xs-12">
		  <label class="title" style="width:65px;">状态：</label>
		    <select id="status" class="form-box" style="width:234px;">
		      <option value="-1">请选择状态</option>
		      <option value="0">待复核</option>
		      <option value="1">审核通过</option>
		      <option value="2">审核未通过</option>
		      <option value="3">已修改</option>
		    </select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" id="printSchedule" onclick="printInfo()">打印</a>
		</div>
		<div class="detailInfo">
			<table id="detailtable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>										
						<th>序号</th>
						<th>调度单号</th>
						<th>申请人</th>
	                    <th>申请时间</th>
	                    <th>申请原因</th>
	                    <th>审核人</th>
	                    <th>审核时间</th>
	                    <th>审核意见</th>
	                    <th>状态</th>
	                    <th>操作</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>			
	</div>
		</div>
		<!-- 打印模板   begin-->
			<div class="printTable" id="printTable">
			     <div id="print-content" class="printcenter">
						<div id="headerInfo">
							<h2>快速调度修改申请</h2>
							<p id="localTime" style="text-align: right;"></p>
						</div>
						  <table id="myDataTable" class="table myDataTable">
						    <thead>
						      <tr>														
								<th>序号</th>
								<th>调度单号</th>
								<th>申请人</th>
			                    <th>申请时间</th>
			                    <th>申请原因</th>
			                    <th>审核人</th>
			                    <th>审核时间</th>
			                    <th>审核意见</th>
			                    <th>状态</th>
							</tr>
						    </thead>
						    <tbody>
						    </tbody>
						  </table>
						  
					  <div id="footerInfo">
					     <h3>盐城辉宇物流有限公司  制</h3>
					  </div>
				  </div>
			</div>

			<!-- 打印模板   end-->
   </div>
   
</div>
<script src="${ctx}/staticPublic/js/jquery-2.0.3.min.js"></script>
<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
<!-- ace scripts -->
<script src="${ctx}/staticPublic/js/ace-elements.min.js"></script>
<script src="${ctx}/staticPublic/js/ace.min.js"></script>
<!-- inline scripts related to this page -->
<script type="text/javascript" src="${ctx}/staticPublic/js/bootbox.min.js"></script>
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script> 
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
		 "sAjaxSource": "${ctx}/operationMng/scheduleMng/getScheduleBillChangeApplyListData" , //获取数据的ajax方法的URL							 
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
				columns: [ 
				            {data: "rownum","width":"5%"},
						    {data: "scheduleBillNo","width":"10%"},
						    {data: "applyUserName","width":"8%"},
						    {data: "insertTime","width":"10%"},
						    {data: "reason","width":"15%"},
						    {data: "auditUserName","width":"8%"},
						    {data: "auditTime","width":"10%"},
						    {data: "auditSuggest","width":"8%"},
						    {data: "status","width":"10%"},
						    {data: null,"width":"16%"}],
						    columnDefs: [
											{
												//时间
												 targets:3,
												 render: function (data, type, row, meta) {
											           if(data!=''&& data!=null){
															 return jsonDateFormat(data);
														 }else{
															 return '';
														 }
											       }	       
											},
											{
												//时间
												 targets:6,
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
											 targets:8,
											 render: function (data, type, row, meta) {
												 if(data=='0'){
										        	   return '待复核';
										           }
										           if(data=='1'){
										        	   return '审核通过';
										           }
										           if(data=='2'){
										        	   return '审核未通过';
										           }
										           if(data=='3'){
										        	   return '已修改';
										           }else{
										        	   return '';
										           }
										       }
										},
										{
									    	 //操作栏
									    	 targets: 9,
									    	 render: function (data, type, row, meta) {
									    		 if(row.status=='1'){
									    			 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="dosubmit(this,'+row.id+')">修改</a>'
							                           +'<a class="table-edit" style="width:75px;" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.id+')">查看调度</a>';
									    		 }else{
									    			 return '<a class="table-edit" style="width:75px;" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.id+')">查看调度</a>';
							                          
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
		 "sAjaxSource": "${ctx}/operationMng/scheduleMng/getScheduleBillChangeApplyListData" , //获取数据的ajax方法的URL	
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
				columns: [
							{data: "rownum","width":"5%"},
							{data: "scheduleBillNo","width":"10%"},
							{data: "applyUserName","width":"8%"},
							{data: "insertTime","width":"10%"},
							{data: "reason","width":"15%"},
							{data: "auditUserName","width":"8%"},
							{data: "auditTime","width":"10%"},
							{data: "auditSuggest","width":"8%"},
							{data: "status","width":"10%"},
							{data: null,"width":"16%"}],
						    columnDefs: [
											{
												//时间
												 targets:3,
												 render: function (data, type, row, meta) {
											           if(data!=''&& data!=null){
															 return jsonDateFormat(data);
														 }else{
															 return '';
														 }
											       }	       
											},
											{
												//时间
												 targets:6,
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
											 targets:8,
											 render: function (data, type, row, meta) {
												 if(data=='0'){
										        	   return '待复核';
										           }
										           if(data=='1'){
										        	   return '审核通过';
										           }
										           if(data=='2'){
										        	   return '审核未通过';
										           }
										           if(data=='3'){
										        	   return '已修改';
										           }else{
										        	   return '';
										           }
										       }
										},
										{
									    	 //操作栏
									    	 targets: 9,
									    	 render: function (data, type, row, meta) {
									    		 if(row.status=='1'){
									    			 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="dosubmit(this,'+row.id+')">审核</a>'
							                           +'<a class="table-edit" style="width:75px;" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.id+')">查看调度</a>';
									    		 }else{
									    			 return '<a class="table-edit" style="width:75px;" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.id+')">查看调度</a>';
							                          
									    		 }
								                    
								                }	       
								    	}
								      ],
							        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

$(function(){
	init();

	
});

/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var status=$('#status').val();
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
				status : status
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
												
					obj.iTotalDisplayRecords=data.data.totalCounts;
					obj.iTotalRecords=data.data.totalCounts;
					obj.aaData=data.data.records;		
					obj.sEcho=data.data.frontParams;
					$(".checkall").prop("checked",false);//点击分页初始化全选框
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
function doshow(e,id){
	var scheduleBillNo=$(e).attr("data-scheduleBillNo");
	var flag="4";
	location.href="${ctx}/operationMng/scheduleMng/fastDetailIndex/"+scheduleBillNo+"/"+flag;
}
/* 修改详细调度信息 */
function dosubmit(e,id){
	var scheduleBillNo=$(e).attr("data-scheduleBillNo");
	parent.addTabs({id:'1120',title: '快速调度',close : true,url : '${ctx}/operationMng/scheduleMng/fastIndex?scheduleBillNo=' + scheduleBillNo});
}
/* 打印功能 */
function printInfo(){
	var date = new Date();
    var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
    var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
    var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
    var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
    var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
    var localTime= date.getFullYear() + "-" + month + "-" + day+ " " + hours + ":" + minutes + ":" + seconds;
    var html="";
    var scheduleBillNo = $('#wayBillInfo').val();
    var secho='1';   
	var pageStartIndex='0';
	var pageSize=1000;
    var status=$('#status').val();
    if(status==null || status=='' || status=='-1'){
	   status="";
     }
	   $('#secho').val(secho);
		$.ajax({
			type : 'POST',
			url : "${ctx}/operationMng/scheduleMng/getScheduleBillChangeApplyListData",
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				status : status
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success: function(data){
				if (data && data.code == 200){
					var status=""
					if(data.data!=null && data.data!=''){
						for(var i=0;i<data.data.records.length;i++){
							var objs=data.data.records[i];
							if(objs.status=='0'){
								  status= '待复核';
					         }else if(objs.status=='1'){
					        	 status= '审核通过';
					         }else if(objs.status=='2'){
					        	 status='审核未通过';
					         }else if(objs.status=='3'){
					        	 status= '已修改';
					         }else{
					        	 status= '';
					          }
							if(objs.mark==null || objs.mark==''){
								objs.mark='';
							}
								html+='<tr>'
								    +'<td>'+(i+1)+'</td>'
								    +'<td>'+objs.scheduleBillNo+'</td>'
								    +'<td>'+objs.applyUserName+'</td>'
								    +'<td>'+jsonDateFormat(objs.insertTime)+'</td>'
								    +'<td>'+objs.reason+'</td>'
								    +'<td>'+objs.auditUserName+'</td>'
								    +'<td>'+jsonDateFormat(objs.auditTime)+'</td>'
								    +'<td>'+objs.auditSuggest+'</td>'
								    +'<td>'+status+'</td>'
									+'</tr>';
							
						}
						$('#localTime').html(localTime);
						$('#myDataTable tbody').html(html);
						doprintForm();
					}else{
						bootbox.alert('暂时没有可打印的数据！');
					}
					
					
				}else{
					bootbox.alert(data.msg);
				}
			}
		});
	   	  
}
function doprintForm(){
		var html=$("#printTable").html();
		$('.page-header').hide();
		$('.contentDetail').hide();
		$('#printTable').show();
		$("#myDataTable").printTable({
		 header: "#headerInfo",
         footer: "#footerInfo",
		 mode: "rowNumber",
		 pageSize: 20
	});
		javasricpt:window.print();
		$('.page-header').show();
		$('.contentDetail').show();
		$('#printTable').hide();
		$("#printTable").html(html);
	 }
</script>



</body>
</html>






