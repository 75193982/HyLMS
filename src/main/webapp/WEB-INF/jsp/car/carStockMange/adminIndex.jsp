
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
				商品车库存查询管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <!-- <label class="title">类型：</label>
		   <select id="search-type" class="form-box">
		     <option value="-1">请选择类型</option>
		     <option value="0">商品车</option>
		     <option value="1">二手车</option>
		   </select>
		   <label class="title">品牌：</label>
		    <select id="search-brand" class="form-box">
		    </select> -->
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">操作时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 234px;margin-right:15px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width:23px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 234px;margin-right:20px;height: 34px;line-height: 34px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title">状态：</label>
		    <select id="search-status" class="form-box">
		     <option value="">全部</option>
		     <option value="0">新建</option>
		     <option value="1">已入库</option>
		     <option value="2">已出库</option>
		    </select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>仓库</th>
					<th>类型</th>
					<th>运单编号</th>
                    <th>供应商名称</th>
                    <th>品牌</th>
                    <th>车架号</th>
                    <th>车型</th>
                    <th>颜色</th>
                    <th>发动机号</th>
                    <th>创建时间</th>
                    <th>备注</th>
                    <th>状态</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 查看商品车 -->
			<div class="modal fade modal_car" id="modal-show" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:0;margin:0;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">查看入库信息</h3>
				</div>
				<div class="modal-body" style="padding:5px 20px;">
					  <div class="widget-box dia-widget-box">
						<div class="widget-body">
						  <div class="widget-main">
							<div class="add-item show-item">
						     <label class="title"><span class="red">*</span>类型：</label>
						     <p id="s-type"></p>
						    </div>
							 <hr class="tree"></hr>	
							 <div class="add-item show-item">
							     <label class="title"><span class="red">*</span>车架号：</label>
							     <p id="s-vin"></p>
							     <input class="form-control" id="s-id-hidden" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item show-item">
							     <label class="title">品牌：</label>
							     <p id="s-brand"></p>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item show-item">
							     <label class="title">车型：</label>
							     <p id="s-model"></p>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item show-item">
							     <label class="title">颜色：</label>
							     <p id="s-color"></p>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item show-item">
							     <label class="title">发动机号：</label>
							     <p id="s-engineNo"></p>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item show-item">
						        <label class="title">运单编号：</label>
						        <p id="s-waybillId"></p>
						    </div>
							 <hr class="tree"></hr>
							 <div class="add-item show-item">
							     <label class="title">备注：</label>
							     <p id="s-remark"></p>
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item show-item">
								     <label class="title">停车位置：</label>
								     <p id="s-position"></p>
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





<script src="${ctx}/staticPublic/js/jquery-2.0.3.min.js"></script>
<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
<!-- ace scripts -->
<script src="${ctx}/staticPublic/js/ace-elements.min.js"></script>
<script src="${ctx}/staticPublic/js/ace.min.js"></script>
<!-- inline scripts related to this page -->
<script type="text/javascript" src="${ctx}/staticPublic/js/bootbox.min.js"></script>
<script src="${ctx}/staticPublic/js/jquery.dataTables.js"></script>
<script src="${ctx}/staticPublic/js/jquery.dataTables.bootstrap.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datetimepicker.js"></script>
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
		 "sAjaxSource": "${ctx}/car/carStockMange/getAllCarListData" , //获取数据的ajax方法的URL							 
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
				columns: [{ data: "rownum",'width':'5%'},
				          	{data: "stockName",'width':'5%'},
						    {data: "type",'width':'6%'},
						    {data: "waybillNo",'width':'10%'},
						    {data: "supplierName",'width':'10%'},
						    {data: "brand",'width':'6%'},
						    {data: "vin",'width':'5%'},
						    {data: "model",'width':'8%'},
						    {data: "color",'width':'6%'},
						    {data: "engineNo",'width':'10%'},
						    {data: "insertTime",'width':'10%'},
						    {data: "mark",'width':'10%'},
						    {data: "status",'width':'5%'},
						    {data: null,'width':'13%'}],
		    columnDefs: [
		      	{
		      		 //操作栏
			    	 targets: 2,
			    	 render: function (data, type, row, meta) {
		                   if(data=="1"){
		                	   return '二手车';
		                   }else{
		                	   return '商品车'; 
		                   }
		                }
		      	},
		      	{
		      		 //操作栏
			    	 targets: 5,
			    	 render: function (data, type, row, meta) {
		                   if(data=="-1"){
		                	   return '';
		                   }else{
		                	   return data; 
		                   }
		                }
		      	},
		      	{
					//时间
					 targets:10,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return format(data,'yyyy-MM-dd HH:mm:ss');
						 }else{
							 return '';
						 }
				       }	       
				},
		      	{
		      		 //操作栏
			    	 targets: 12,
			    	 render: function (data, type, row, meta) {
		                   if(data=="0"){
		                	   return '新建';
		                   }else if(data=="1"){
		                	   return '已入库';
		                   }else if(data=="2"){
		                	   return '已出库';
		                   }
		                }
		      	},
		      	{
			    	 //操作栏
			    	 targets: 13,
			    	 render: function (data, type, row, meta) {
			    			 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
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
		 "sAjaxSource": "${ctx}/car/carStockMange/getAllCarListData" , //获取数据的ajax方法的URL	
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
				 columns: [{ data: "rownum",'width':'5%'},
				           {data: "stockName",'width':'5%'},
						    {data: "type",'width':'6%'},
						    {data: "waybillNo",'width':'10%'},
						    {data: "supplierName",'width':'10%'},
						    {data: "brand",'width':'6%'},
						    {data: "vin",'width':'5%'},
						    {data: "model",'width':'8%'},
						    {data: "color",'width':'6%'},
						    {data: "engineNo",'width':'10%'},
						    {data: "insertTime",'width':'10%'},
						    {data: "mark",'width':'10%'},
						    {data: "status",'width':'5%'},
						    {data: null,'width':'13%'}],
						    columnDefs: [
						      	{
						      		 //操作栏
							    	 targets: 2,
							    	 render: function (data, type, row, meta) {
						                   if(data=="1"){
						                	   return '二手车';
						                   }else{
						                	   return '商品车'; 
						                   }
						                }
						      	},
						      	{
						      		 //操作栏
							    	 targets: 5,
							    	 render: function (data, type, row, meta) {
						                   if(data=="-1"){
						                	   return '';
						                   }else{
						                	   return data; 
						                   }
						                }
						      	},
						      	{
									//时间
									 targets:10,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return format(data,'yyyy-MM-dd HH:mm:ss');
										 }else{
											 return '';
										 }
								       }	       
								},
						      	{
						      		 //操作栏
							    	 targets: 12,
							    	 render: function (data, type, row, meta) {
							    		 if(data=="0"){
						                	   return '新建';
						                   }else if(data=="1"){
						                	   return '已入库';
						                   }else if(data=="2"){
						                	   return '已出库';
						                   }
						                }
						      	},
						      	{
							    	 //操作栏
							    	 targets: 13,
							    	 render: function (data, type, row, meta) {
							    		return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
						                }	       
						    	}  
						      ],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	getBrand();
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
})

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

/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   //var type=$("#search-type").find("option:selected").val(); 
	   var status=$("#search-status").find("option:selected").val();
	   //var brand=$("#search-brand").find('option:selected').html();
	   /* if(type=="-1"){
		   type=null;
	   } */
	   /* if(status=='-1'){
		   status=null;
	   } */
	   /* if(brand=='请选择品牌'){
		   brand=null;
	   } */
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
				endTime :$.trim($('#endTime').val()),
				status :status
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
/* 绑定品牌 */
function getBrand(){
   $.ajax({  
        url: '${ctx}/car/carStockMange/queryCarBrand',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: '',
        success: function (data) {
        	var html ='<option value="-1">请选择品牌</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['brandName']+'</option>';
                		}
            		}
            	}
            	$('#search-brand').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}

/* 查看商品车信息 */
function doshow(id){
	$.ajax({
		type : 'GET',
		url : "${ctx}/car/carStockMange/queryCarStock/"+id,
		data :JSON.stringify({
			id :id
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#s-id-hidden').html(id);
				$('#s-vin').html(data.data.vin);
				$('#s-remark').html(data.data.mark);
				$('#s-waybillId').html(data.data.waybillNo);
				if(data.data.type=='0'){
					$('#s-type').html('商品车');
				}else{
					$('#s-type').html('二手车');
				}
				
				$('#s-model').html(data.data.model);
				$('#s-brand').html(data.data.brand);
				$('#s-color').html(data.data.color);
				$('#s-engineNo').html(data.data.engineNo);
				$('#s-position').html(data.data.position);
				$('#s-addBtn').hide();
				$('#modal-show').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 

}


</script>



</body>
</html>






