
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
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->

</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			财务管理
			<small>
				<i class="icon-double-angle-right"></i>
				待付管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 180px;margin-right:25px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width: 68px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 180px;margin-right:20px;height: 34px;line-height: 34px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			 <label class="title mul-title">部门：</label>
			 <select id="departmentId" class="form-box mul-form-box" style="width:180px;">
		    </select>		    
		</div>
		<div class="searchbox col-xs-12">		   
		    <label class="title" style="text-align: left;float: left;">状态：</label>
		    <select id="status" class="form-box" style="width:180px;float: left;">
		    <option value="">请选择状态</option>
		    <option value="0">未支付</option>
		    <option value="1">已支付</option>
		    </select>
		    <label class="title" style="text-align: left;">业务类型：</label>
		     <input id="businessType" class="form-box mul-form-box" type="text" style="width:180px;" placeholder="请输入业务类型"/>
		      <label class="title mul-title" style="">事由：</label>
		     <input id="mark" class="form-box mul-form-box" type="text" style="width:180px;" placeholder="请输入事由"/>
			<a class="itemBtn m-lr5" onclick="searchInfo()">查询</a>
			<!-- <a class="itemBtn m-lr5" onclick="doprint()">打印</a>
			<a class="itemBtn m-lr5" onclick="doexport()">导出</a> -->
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>待付时间</th>
					<th>部门</th>
					<th>业务类型</th>
                    <th>事由</th>
                    <th>金额</th>                   
                    <th>收款人</th>
                    <th>创建人</th>
                    <th>创建时间</th>
                    <th>支付人</th>
                    <th>支付时间</th>
					<th>状态</th>										
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
		</div>
	</div>
	</div>	
	<!-- 查看待付信息Modal--begin -->
	<div class="modal fade" id="modal-info" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="showRefresh();">×</button>
						<h3 id="myModalLabel">查看待付信息</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item show-item">
								     <label class="title">部门：</label>
								     <p id="deptShow"></p> 
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item show-item">
								     <label class="title">收款人：</label>
								     <p id="receiveShow"></p> 
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item show-item">
								     <label class="title">业务类型：</label>
								     <p id="businessShow"></p> 
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item show-item">
									     <label class="title">事由：</label>
									     <p id="markShow"></p> 
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item show-item">
									     <label class="title">金额：</label>
									     <p id="moneyShow"></p> 
									 </div>
									<!--  <hr class="tree"></hr>
									<div class="add-item show-item">
									     <label class="title">状态：</label>
									     <p id="statusShow"></p> 
									 </div> -->
									 <hr class="tree"></hr>
									<div class="add-item show-item">
									     <label class="title">创建人：</label>
									     <p id="insertUserShow"></p> 
									 </div>
									 <hr class="tree"></hr>
									<div class="add-item show-item">
									     <label class="title">创建时间：</label>
									     <p id="insertTimeShow"></p> 
									 </div>
									  <hr class="tree"></hr>
									<div class="add-item show-item">
									     <label class="title">待付时间：</label>
									     <p id="payTimeShow"></p> 
									 </div>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
	
	<!-- 查看待付信息Modal--end -->
</div>
<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>成本管理信息记录表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>
		            <th>序号</th>
					<th>调度单号</th>
					<th>车队类型</th>
                    <th>装运车号</th>
                    <th>驳运费用(现金)</th>                   
                    <th>油费</th>
                    <th>总金额</th>
					<th>状态</th>					
					<th>时间</th>
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
		 "sAjaxSource": "${ctx}/operationMng/cashWaitingPayLogMng/getListData" , //获取数据的ajax方法的URL							 
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
		    {data: "payTime",'width':'8%'},
		    {data: "departmentName",'width':'6%'},
		    {data: "businessType",'width':'6%'},
		    {data: "mark",'width':'6%'},
		    {data: "money",'width':'6%'},
		    {data: "receiveUserName",'width':'8%'},
		    {data: "insertUserName",'width':'8%'},
		    {data: "insertTime",'width':'8%'},
		    {data: "updateUserName",'width':'8%'},
		    {data: "updateTime",'width':'8%'},
		    {data: "status",'width':'8%'},    
		    {data: null,"width":"10%"}
			],
		    columnDefs: [{
					 //类型
					 targets:1,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonForDateFormat(data);
						 }else{
							 return '';
						 }
				     }	       
				},{
					 //类型
					 targets:8,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
				     }	       
				},{
					 //类型
					 targets:10,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
				     }	       
				},{
					 //状态
					 targets:11,
					 render: function (data, type, row, meta) {
				          if(data=='0'){
				        	 return '未支付'; 
				          }else if(data=='1'){
				        	  return '已支付';
				          }else{
				        	  return data;
				          }
				      }	       
				},{
			    	 //操作栏
			    	 targets: 12,
			    	 render: function (data, type, row, meta) {
			    		 if(row.status=='0'){
							 return '<a class="table-edit" style="width:45px;margin-left:5px;" onclick="dopay('+ row.id +')">支付</a>';
						 }else{
							 return ''; 
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
		 "sAjaxSource": "${ctx}/operationMng/cashWaitingPayLogMng/getListData" , //获取数据的ajax方法的URL	
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
					    {data: "payTime",'width':'8%'},
					    {data: "departmentName",'width':'6%'},
					    {data: "businessType",'width':'6%'},
					    {data: "mark",'width':'6%'},
					    {data: "money",'width':'6%'},
					    {data: "receiveUserName",'width':'8%'},
					    {data: "insertUserName",'width':'8%'},
					    {data: "insertTime",'width':'8%'},
					    {data: "updateUserName",'width':'8%'},
					    {data: "updateTime",'width':'8%'},
					    {data: "status",'width':'8%'},    
					    {data: null,"width":"10%"}
						],
					    columnDefs: [{
								 //类型
								 targets:1,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonForDateFormat(data);
									 }else{
										 return '';
									 }
							     }	       
							},{
								 //类型
								 targets:8,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }
							     }	       
							},{
								 //类型
								 targets:10,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }
							     }	       
							},{
								 //状态
								 targets:11,
								 render: function (data, type, row, meta) {
							          if(data=='0'){
							        	 return '未支付'; 
							          }else if(data=='1'){
							        	  return '已支付';
							          }else{
							        	  return data;
							          }
							      }	       
							},{
						    	 //操作栏
						    	 targets: 12,
						    	 render: function (data, type, row, meta) {
						    		 if(row.status=='0'){
										 return '<a class="table-edit" style="width:45px;margin-left:5px;" onclick="dopay('+ row.id +')">支付</a>';
									 }else{
										 return ''; 
									 } 
					                }	       
					    	}
					      ],
				        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
/* 部门绑定 */
function getDep(){
	$.ajax({  
        url: '${ctx}/commonSetting/userSetting/getDepartmentList',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: '',
        success: function (data) {
        	 var html ='<option value="">请选择部门</option>'; 
        	//var html ="";
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                		}
            		}
            	}
            	$('#departmentId').html(html);
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
	getDep();
	//getCarNo();
})

/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   $('#secho').val(secho);
	   var businessType=$('#businessType').val();
	   var status=$('#status').val();
	   var departmentId=$('#departmentId').val();
	   var mark=$('#mark').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	  /*  if(cardNo=='' || cardNo==null || cardNo=='-1'){
		   cardNo=null;
	   } */
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				businessType : businessType,
				status : status,
				departmentId : departmentId,
				mark : mark,
				startTime : startTime,
				endTime : endTime
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
/* 查询 */
function searchInfo(){
	reload();
}
/*支付*/
 function dopay(id){
		var flag="false";
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要支付吗?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'GET',
							url : "${ctx}/operationMng/cashWaitingPayLogMng/pay/"+id,
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {
									bootbox.confirm_alert({ 
										  size: "small",
										  message: "支付成功！", 
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
								}else{
									bootbox.alert(data.msg);	
								}
							}
						});
				  }
			  }
		});
}
function doview(id){
	$('#modal-info').modal('show');
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/cashWaitingPayLogMng/getDetail/"+id,
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				$('#deptShow').html(data.data.departmentName);
				$('#receiveShow').html(data.data.receiveUserName);
				$('#businessShow').html(data.data.businessType);
				$('#markShow').html(data.data.mark);
				$('#moneyShow').html(data.data.money);
				$('#insertUserShow').html(data.data.insertUser);
				if(data.data.insertTime!=''&&data.data.insertTime!=null){
					$('#insertTimeShow').html(jsonDateFormat(data.data.insertTime));	
				}else{
					$('#insertTimeShow').html('');	
				}
								
			} else {
				 bootbox.alert(data.msg);
			}
			
		}
	}); 
}
/* 关闭取消窗口 */
function showRefresh(){
	$('#modal-info').modal('hide');
}
</script>



</body>
</html>






