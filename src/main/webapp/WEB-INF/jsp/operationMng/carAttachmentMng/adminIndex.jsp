<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>配件库存管理</title>
		<link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" /><!--字体icon-->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
		<script src="${ctx}/staticPublic/js/ace-extra.min.js"></script>
</head>
<body class="white-bg">

<div class="page-content">
	<div class="page-header">
		<h1>
			查询管理
			<small>
				<i class="icon-double-angle-right"></i>
				配件库存查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title">运单编号： </label> 
		    <input id="waybill" class="form-box" type="text" placeholder="请输入运单编号" />
		     <label class="title">配件名称： </label> 
		     <input id="attName" class="form-box" type="text" placeholder="请输入配件名称"/>
		     <label class="titletwo">状态：</label>
		    	 <select id="fom_status" class="form-box" >	
		    	 <option value="">请选择状态</option>
		    	 <option value='0'>新建</option>
		    	 <option value='1'>已入库</option>	
		    	 <option value='2'>已出库</option>
			</select>	
			<a id="searchBtn" class="itemBtn"  onclick="dosearch()">查询</a>			
			<input type="hidden" id="secho" name="secho">
		</div>
		<div class="detailInfo">
		<table id="dynamic-table" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>运单编号</th>
					<th>配件名称</th>
                    <th>存放位置</th>
                    <th>数量</th>
                    <th>创建时间</th>
                    <th>状态</th>
                  <th>操作</th> 
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" style="height: 450px;" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" onclick="cancel()">×</button>
					<h3 id="myModalLabel">配件入库登记</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									 <div class="add-item extra-itemSec">
									     <label class="title">配件名称：</label>
									     <input class="form-control" id="name" type="text" placeholder="请输入配件名称"/>
									     <input class="form-control" id="id-hidden" type="hidden"/>
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item extra-itemSec">
									     <label class="title">数量：</label>
									     <input class="form-control" id="count" type="text" placeholder="请输入数量"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
								     	<label class="title">位置：</label>
								     	<input class="form-control" id="position" type="text" placeholder="请输入位置"/>
								    </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
								     	<label class="title">运单编号：</label>
								     	<select class="form-control" id="waybill2">
										</select>
								    </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-itemSec">
								     	<label class="title">备注：</label>
								     	<input class="form-control" id="mark" type="text" placeholder="请输入备注"/>
								    </div>
								    <hr class="tree"></hr>
								     <div class="add-item-btn" id="addBtn">
								    	<a class="add-itemBtn btnOk" onclick="save();">保存</a>
								    	<a class="add-itemBtn btnCancle" onclick="cancel();">取消</a>
									 </div>
									 <div class="add-item-btn" id="editBtn">
								   	 	<a class="add-itemBtn btnOk" onclick="update()">更新</a>
								    	<a class="add-itemBtn btnCancle" onclick="cancel()">取消</a>
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
        
<script type="text/javascript">	
jQuery(function($) {
	var myTable = loadTable();
			
})

$(function(){
	bindWaybill();
});

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
			waybillNo : $.trim($('#waybill').val()),
			attachmentName : $.trim($('#attName').val()),
			status:$.trim($('#fom_status').val())
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

function loadTable(){
	$('#dynamic-table').DataTable( {
		"destroy": true,//如果需要重新加载的时候请加上这个
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/carAttachmentMng/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum","width": "4%" },
		    {data: "waybillNo","width": "14%"},
		    {data: "attachmentName","width": "14%"},
		    {data: "position","width": "14%"},
		    {data: "count","width": "14%"},
		    {data: "insertTime","width": "14%"},
		    { data: "status","width": "14%"},
		    { data: null,"width": "10%"}],
		    columnDefs: [
		    {
		    	 //指定第五列
		    	 targets: 6,
			        render: function(data, type, row, meta) {
			        	if(data==0){return '新建'}else if(data==1){return '已入库'}else if(data==2){return '已出库'};
			        }	       
		    },
		    {
		        //指定第最后一列
		        targets: 5,
		        render: function(data, type, row, meta) {
		        	 if(data!=''&&data!=null){
						 return jsonDateFormat(data);
					 }else{
						 return '';
					 }
		        }
		    },
	      	{
		    	 //操作栏
		    	 targets: 7,
		    	 render: function (data, type, row, meta) {	
		    		 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';	
		    			  		    				                 
	                }	       
	    	} 
		    ],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
  } );
}

/* 获取运单id */
function bindWaybill(){
	var type = "'0','1'";
$.ajax({  
    url: '${ctx}/operationMng/carAttachmentMng/getWaybillList',  
    type: "post",  
    contentType : "application/json;charset=UTF-8",
	dataType : 'JSON',
    data: '',
    success: function (data) {
    	var html ='<option value="">请选择运单编号</option>';
        if(data.code == 200){  
        	if(data.data!=null && data.data!=''){
        		if(data.data.length>0){
        			for(var i=0;i<data.data.length;i++){
            			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['waybillNo']+'</option>';
            		}
        		}
        	}
        	$('#waybill2').html(html);
           }else{  
        	   bootbox.alert('加载失败！');
           }  
    }  
  }); 
}
function dosearch(){
	 loadTable();	
}
function doview(id){
	 cleardetil();
	 $('#modal-info').modal('show');
	 $.ajax({
			type : 'POST',
			url : "${ctx}/operationMng/carAttachmentMng/getCarAttachmentList",	
			data:{id:id},
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) 
				{
					
						//console.log(JSON.stringify(data.data));	
						var name=data.data.attachmentName;
						var count=data.data.count;
						var position = data.data.position;
						var waybillId = data.data.waybillId;
						var mark = data.data.mark;
						$("#id-hidden").val(id);
						$("#name").val(name);
						$("#count").val(count);
						$("#position").val(position);
						$("#waybill2").val(waybillId);
						//$('#waybill2').find("option[value='"+waybillId+"']").attr("selected",true);
						$("#mark").val(mark);											
						$("#name").attr("disabled",true);
						$("#count").attr("disabled",true);
						$("#position").attr("disabled",true);
						$("#waybill2").attr("disabled",true);
						$("#mark").attr("disabled",true);
						$('#addBtn').hide();
						$('#editBtn').hide();
				} else {
					 bootbox.alert(data.msg);
				}
				
			}
		});
} 
//明细页面管理
function cancel(){	
	 $('#modal-info').modal('hide'); 
}
function cleardetil(){
	$("#id-hidden").val('');
	$("#name").val('');
	$("#count").val('');
	$("#position").val('');
	$("#waybill2").val('');
	//$('#waybill2').find("option[value='"+waybillId+"']").attr("selected",true);
	$("#mark").val('');				
}
</script>        

</body>
</html>