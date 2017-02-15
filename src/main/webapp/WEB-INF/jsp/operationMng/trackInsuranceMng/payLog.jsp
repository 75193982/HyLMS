
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
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
				保费支付查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		<label class="title" style="float: left;height: 34px;line-height: 34px;">创建时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 234px;margin-right:15px; margin-left: 2px;">
				<input class="form-control" id="form_startTime" type="text" placeholder="请输入时间"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 13px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 234px;margin-right:15px;margin-left: 2px;">
				<input class="form-control" id="form_endTime" type="text" placeholder="请输入时间"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>			
		   <label class="title">类型：</label>
		   <select id="fom_type" class="form-box" style="width:200px;">
		   <option value="">请选择类型</option>
		   <option value="0">支付参加保险费用</option>
		   <option value="1">报保险的赔付费用</option>		   		  
		   	</select>	
		   	<a class="itemBtn" onclick="searchInfo()">查询</a>
			<!-- <a class="itemBtn" onclick="doadd()">新增</a>	 -->
		  	</div>
		</div>
		
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>保单号</th>
                    <th>金额</th>
                    <th>备注</th>                    
                    <th>创建人 </th>
                    <th>创建时间</th>                   
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">保单明细</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item">
							    <table id="Paydetailtable" class="table table-striped table-bordered table-hover">
			                    <thead>
				                 <tr>														
					            <th>序号</th>
					            <th>保单号</th>
                                <th>金额</th>
                                <th>备注</th>                    
                                <th>创建人 </th>
                                <th>创建时间</th>                   
                               
				                </tr>
			                    </thead>
			                    <tbody>
			                    </tbody>
			                    </table>
							     <input class="form-control" id="id-hidden" type="hidden"/>
							  </div>							  
							  
							    <hr class="tree"></hr>
							    <div class="add-item-btn" id="addBtn">
								    <a class="add-itemBtn btnOk" onclick="save();" style="margin-left: 130px;">保存</a>
								    <a class="add-itemBtn btnOk" onclick="refresh();">关闭</a>
								 </div>
								 <div class="add-item-btn" id="editBtn">
								    <a class="add-itemBtn btnOk" onclick="update()" style="margin-left: 130px;">更新</a>
								    <a class="add-itemBtn btnOk" onclick="refresh()">关闭</a>
								  </div> 
								   <div class="add-item-btn" id="viewBtn">
								   <!--  <a class="add-itemBtn btnOk" onclick="update()" style="margin-left: 130px;">更新</a> -->
								    <a class="add-itemBtn btnOk" onclick="refresh()" style="margin-left: 130px;">关闭</a>
								  </div> 
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
		 "sAjaxSource": "${ctx}/operationMng/trackInsuranceMng/getPayListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum" },
		    {data: "insuranceNo"},
		    {data: "amount"},
		    {data: "mark"},
		    {data: "insertUser"},
		    {data: "insertTime"},		    
		    {data: null}],
		    columnDefs: [{
					 //入职时间
					 targets: 5,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
						
				       }	       
				},{
			    	 //操作栏
			    	 targets: 6,
			    	 render: function (data, type, row, meta) {
			    		 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';
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
		 "sAjaxSource": "${ctx}/operationMng/trackInsuranceMng/getPayListData", //获取数据的ajax方法的URL	
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
				columns: [{ data: "rownum" ,"width":"4%"},
						    {data: "insuranceNo","width":"15%"},
						    {data: "amount","width":"15%"},
						    {data: "mark","width":"20%"},
						    {data: "insertUser","width":"10%"},
						    {data: "insertTime","width":"10%"},		    
						    {data: null,"width":"15%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 5,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }
									
							       }	       
							},{
						    	 //操作栏
						    	 targets: 6,
						    	 render: function (data, type, row, meta) {
						    		 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';
					                }	       
					    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	//BindCarNo();//绑定货运车carNumber
	//BindOutSour();//绑定供应商
	$("#form_startTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#form_endTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
})
/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var carNumber=$("#fom_carNumber").val(); 
	   var type=$("#fom_type").val(); 
	
	   var startTime=$("#form_startTime").val();
	   var endTime=$("#form_endTime").val(); 
	   if(type==""){
		   type="0,1";
	   }
	  // var carType=$("#carType").val(); 
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				startTime :$.trim(startTime),
				endTime :$.trim(endTime),
				type :$.trim(type)
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

/* 关闭窗体 */
function refresh(){
	$('#modal-info').modal('hide');	
}


function doview(id){
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackInsuranceMng/getPayDetailList/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data));
				//console.info(data.data.length);
				$('#id-hidden').val(id);
				$('#myModalLabel').html('保费明细信息');
				if(data.data.length>0){
					for(var i=0;i<data.data.length;i++){
						data.data[i]['rownum']=i+1;
					}					
				}
				$('#Paydetailtable').dataTable({
					"destroy": true,//如果需要重新加载需销毁
					 dom: 'Bfrtip',
					 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
					 "bFilter": false,    //不使用过滤功能  
					 "bProcessing": true, //加载数据时显示正在加载信息	
					 "bPaginate" : false,
					 "bInfo" : false,
					  ordering: false,
						"oLanguage": {
							"sZeroRecords": "抱歉， 没有找到",
							"sInfoEmpty": "没有数据",
							"sInfoFiltered": "(从 _MAX_ 条数据中检索)",							
							"sZeroRecords": "没有检索到数据"
							},	
					data: data.data,
			        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
			        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
			        columns: [	
			            { data: 'rownum' },
			            {data: "insuranceNo"},
					    {data: "amount"},
					    {data: "mark"},
					    {data: "insertUser"},
					    {data: "insertTime"}],
					    columnDefs: [{
							 //入职时间
							 targets: 5,
							 render: function (data, type, row, meta) {
								 if(data!=''&&data!=null){
									 return jsonDateFormat(data);
								 }else{
									 return '';
								 }			
						       }	       
						} ]
				});
				$('#addBtn').hide();
				$('#editBtn').hide();
				$('#viewBtn').show();
				$('#modal-info').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
</script>



</body>
</html>






