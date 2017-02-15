<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统异常日志</title>
<link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
		<!-- page specific plugin styles -->
		<!-- ace styles -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" /><!--字体icon-->
		<!-- inline styles related to this page -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
		<!-- ace settings handler -->
		<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
#modal-info{
    width: 800px;
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
			运营管理
			<small>
				<i class="icon-double-angle-right"></i>
				系统异常日志
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">		  
			<label class="title" style="float: left;height: 34px;line-height: 34px;">操作时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 170px;margin-right:15px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width:78px;">结束时间：</label>
		   <div class="input-group input-group-sm" style="float: left;width: 170px;margin-right:20px;height: 34px;line-height: 34px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		   <label class="titletwo" >操作人：</label>
		    <input class="form-box" id="operator" type="text"  placeholder="请输入操作人"/>				   
		   <input type="hidden" id="secho" name="secho">
		   <a class="itemBtn" onclick="dosearch()">查询</a>
		</div>
		<div class="detailInfo">
		<table id="dynamic-table" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>操作人</th>
					<th>操作时间</th>
                    <th>操作名称</th>
                    <th>异常信息</th>
                    <th>IP</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			
			<!-- 查看 -->
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
					<div class="modal-header">
						<button class="close" type="button" onclick="cancel();">×</button>
						<h3 id="myModalLabel">查看异常信息</h3>
					</div>
					<div class="modal-body">
						<div>
							<div class="widget-box dia-widget-box">
								<div class="widget-body">
									<div class="widget-main">
										<div class="add-item">
									     	<label class="title">详细信息：</label>
									     	<input class="form-control" id="id-hidden" type="hidden"/>
									     	<hr class="tree"></hr>
									     	<textarea class="form-control" id="detailInfo" rows="20" cols="10" disabled="disabled"></textarea>
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
<script type="text/javascript">
jQuery(function($) {
	var myTable = loadTable();
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
});

function loadTable(){
	$('#dynamic-table').DataTable( {
		"destroy": true,//如果需要重新加载的时候请加上这个
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/commonSetting/systemErrorLog/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum" ,'width':'4%'},
		    {data: "operatorUser",'width':'8%'},
		    {data: "operateTime",'width':'10%'},
		    {data: "operateName",'width':'8%'},
		    {data: "exceptionName",'width':'52%'},
		    {data: "loginIp",'width':'8%'},
		    {data: null,'width':'5%'}],
		    columnDefs: [
			{
	 			//指定第2列
	 			targets: 2,
       			render: function(data, type, row, meta) 
       			{
       				if(data != null)
       					return format(data,'yyyy-MM-dd HH:mm:ss');
       					return '';
       			}
			},
			{
	 			//指定第6列
	 			targets: 6,
       			render: function(data, type, row, meta) 
       			{
       				return '<a class="table-edit" onclick="doedit('+ row.id +')">查看</a>';
       			}
			}
			],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
  } );
}

//datatables与后台交互获取数据的处理函数
function retrieveData( sSource, aoData, fnCallback ) {   
   var secho=aoData[0]["value"];   
   var pageStartIndex=aoData[3]["value"];
   var pageSize=aoData[4]["value"];
   //console.info('aaa:'+$('#attName').val());
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
			endTime : $.trim($('#endTime').val()),
			operatorUser : $.trim($('#operator').val())
			//operateContent : $.trim($('#operateContent').val())
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.log(JSON.stringify(data.data));								
				obj.iTotalDisplayRecords=data.data.totalCounts;
				obj.iTotalRecords=data.data.totalCounts;
				obj.aaData=data.data.records;		
				obj.sEcho=data.data.frontParams;
			//	console.log(JSON.stringify(obj));
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
				//jQuery.messager.alert('提示:',data.msg,'info');selected="selected" 
			}
			
		}
	}); 
}

//日期格式化
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

function dosearch(){
	 loadTable();	
}

function cancel()
{
	$('#detailInfo').val('');
	$('#id-hidden').val('');
	$('#modal-info').modal('hide');
}

function doedit(id)
{
	$('#id-hidden').val(id);
	$.ajax({
		type : 'GET',
		url : "${ctx}/commonSetting/systemErrorLog/getById/"+id,
		data : {id:id},
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//alert(data.data.detailInfo);
				$('#detailInfo').val(data.data.detailInfo);
			}else{
				bootbox.alert(data.msg);
			}
		}
	});
	
	$('#modal-info').modal('show');	
}
</script>
</body>
</html>