<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品车出入库查询</title>
<link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
		<!-- page specific plugin styles -->
		<!-- ace styles -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" /><!--字体icon-->
		<!-- inline styles related to this page -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/datetimepicker.css" />
		<!-- ace settings handler -->
		<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			查询管理
			<small>
				<i class="icon-double-angle-right"></i>
				商品车出入库查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
			 <label class="title" style="float: left;height: 34px;line-height: 34px;">操作时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 200px;margin-right:15px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width:25px;margin-left: 20px;margin-right: 20px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 200px;margin-right:20px;height: 34px;line-height: 34px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>			
		</div>
		<div class="searchbox col-xs-12">
		 <label class="title" style="margin-right:5px;">业务编号：</label>
		   <input id="waybill" class="form-box" type="text" placeholder="请输入业务编号" style="width:200px;"/>		
			<label class="title">类型：</label>
		    <select id="type" class="form-box" style="width:200px;">
		      <option value="0" selected>入库</option>
		      <option value="1">出库</option>
		    </select>		  
		   <input type="hidden" id="secho" name="secho">
		  
		   <a class="itemBtn" onclick="searchInfo()">查询</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>类型</th>
					<th>业务编号</th>
                    <th>台数</th>
                    <th>出入库时间</th>
                    <th>操作人</th>
                    <th>状态</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
		
			<div class="modal fade" id="modal-add" tabindex="-1" role="dialog" aria-hidden="false" data-backdrop="static">
			   <div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
					<div class="modal-header" style="padding:3px 10px;">
						<button class="close" type="button" data-dismiss="modal">×</button>
						<h3 id="myModalLabel">商品车出入库明细查看</h3>
					</div>
					<div class="modal-body">
					   <div>
						  <div class="widget-box dia-widget-box">
								<div class="widget-body">
									<div class="widget-main">	
										<input type="hidden" id="idText">
									 	<table id="tableByDetail" class="table table-striped table-bordered table-hover">
					                      <thead>
						                   <tr>	
								               <th>序号</th>
								               <th>车架号</th>
			                                   <th>品牌</th>
			                                   <th>颜色</th>
			                                   <th>发动机</th>
						                    </tr>
					                      </thead>
					                      <tbody>
					                      </tbody>
					                      </table>							   			  
									    							 
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
</div>
<!--[if !IE]> -->
<script src="${ctx}/staticPublic/js/jquery-2.0.3.min.js"></script>
<!-- <![endif]-->
<!--[if IE]>
<script src="${ctx}/staticPublic/js/jquery-1.10.2.min.js"></script>
<![endif]-->
<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
<!-- page specific plugin scripts -->
<script src="${ctx}/staticPublic/js/jquery.dataTables.js"></script>
<script src="${ctx}/staticPublic/js/jquery.dataTables.bootstrap.js"></script>
<!-- ace scripts -->
<script src="${ctx}/staticPublic/js/ace-elements.min.js"></script>
<script src="${ctx}/staticPublic/js/ace.min.js"></script>		
<!-- inline scripts related to this page -->
<script type="text/javascript" src="${ctx}/staticPublic/js/popbox/Confirm.js"></script>
<script src="${ctx}/staticPublic/js/bootbox.min.js"></script>
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
		 "sAjaxSource": "${ctx}/car/carStockMange/queryCarStockInOut" , //获取数据的ajax方法的URL							 
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
				columns: [{ data: "rownum",'width':'10%'},
						    {data: "type",'width':'10%'},
						    {data: "businessNo",'width':'10%'},
						    {data: "count",'width':'10%'},
						    {data: "insertTime",'width':'15%'},
						    {data: "userName",'width':'10%'},
						    {data: "status",'width':'10%'},
						    {data: null,'width':'25%'}],
						    columnDefs: [
							{
					 			//指定第1列
					 			targets: 1,
				       			render: function(data, type, row, meta) 
				       			{
				       				if(data==0)
				       				{
				       					return '入库'
				       				}else if(data==1)
				       				{
				       					return '出库'
				       				};
				       			}	       
							},
							{
					 			//指定第4列
					 			targets: 4,
				       			render: function(data, type, row, meta) 
				       			{
				       				if(data != null){
				       					return jsonDateFormat(data)
				       				} else{
				       					return ""
				       				};
				       			}	       
							},
						    {
						    	 //指定第6列
						    	 targets: 6,
							        render: function(data, type, row, meta) {
							        	if(data==0){return '新建'}else if(data==1){return '待复核'}else if(data==2){return '已完成'};
							        }	       
						    },
						    {
						    	 //指定第7列
						    	 targets: 7,
							        render: function(data, type, row, meta) {
							        	if(row.status!=0){return '<a class="table-edit" style="width:70px" onclick="doview('+ row.id +')">查看明细</a>'};
							        }	       
						    }],
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
		 "sAjaxSource": "${ctx}/car/carStockMange/queryCarStockInOut" , //获取数据的ajax方法的URL	
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
			columns: [{ data: "rownum",'width':'10%'},
					    {data: "type",'width':'10%'},
					    {data: "businessNo",'width':'10%'},
					    {data: "count",'width':'10%'},
					    {data: "insertTime",'width':'15%'},
					    {data: "userName",'width':'10%'},
					    {data: "status",'width':'10%'},
					    {data: null,'width':'25%'}],
					    columnDefs: [
						{
				 			//指定第1列
				 			targets: 1,
			       			render: function(data, type, row, meta) 
			       			{
			       				if(data==0)
			       				{
			       					return '入库'
			       				}else if(data==1)
			       				{
			       					return '出库'
			       				};
			       			}	       
						},
						{
				 			//指定第4列
				 			targets: 4,
			       			render: function(data, type, row, meta) 
			       			{
			       				if(data != null){
			       					return jsonDateFormat(data)
			       				} else{
			       					return ""
			       				};
			       			}	       
						},
					    {
					    	 //指定第6列
					    	 targets: 6,
						        render: function(data, type, row, meta) {
						        	if(data==0){return '新建'}else if(data==1){return '待复核'}else if(data==2){return '已完成'};
						        }	       
					    },
					    {
					    	 //指定第7列
					    	 targets: 7,
						        render: function(data, type, row, meta) {
						        	if(row.status!=0){return '<a class="table-edit" style="width:70px" onclick="doview('+ row.id +')">查看明细</a>'};
						        }	       
					    }],
				        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

$(function(){
	/* $("#startTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#endTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	}); */
	 $("#startTime").datetimepicker({
			language: 'cn',
		      format: "yyyy-mm-dd hh:ii",
		      autoclose: true,//选中之后自动隐藏日期选择框
		      todayBtn: true
		});
	 
	 $("#endTime").datetimepicker({
			language: 'cn',
		      format: "yyyy-mm-dd hh:ii",
		      autoclose: true,//选中之后自动隐藏日期选择框
		      todayBtn: true
		});
	init();
})

/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   $('#secho').val(secho);
	   var businessId=$('#waybill').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var type=$('#type').val();
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				businessId : businessId,
				startTime : startTime,
				endTime : endTime,
				type : type
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
	/* 查看明细 */
	function doview(id)
	{
		$('#idText').val(id);
		$('#modal-add').modal('show');
		loadDeatilTable();
	}
	function loadDeatilTable(){
		$('#tableByDetail').DataTable( {
			"destroy": true,//如果需要重新加载的时候请加上这个
			 dom: 'Bfrtip',
			 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
			 "bFilter": false,    //不使用过滤功能  
			 "bProcessing": true, //加载数据时显示正在加载信息
			 "bServerSide": true, //指定从服务器端获取数据
			 "sAjaxSource": "${ctx}/car/carStockMange/getDetailByParentId" , //获取数据的ajax方法的URL							 
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
			 columns: [{ data: "rownum",'width':'15%'},
			    {data: "vin",'width':'25%'},
			    {data: "brand",'width':'20%'},
			    {data: "color",'width':'15%'},
			    {data: "engineNo",'width':'25%'}],
			    columnDefs: [
			     ],
		        "fnServerData":retrieveDataDetail //与后台交互获取数据的处理函数
	  } );
	}

	//datatables与后台交互获取数据的处理函数
	function retrieveDataDetail( sSource, aoData, fnCallback ) {   
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
				parentId : $.trim($('#idText').val())
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
</script>
</body>
</html>