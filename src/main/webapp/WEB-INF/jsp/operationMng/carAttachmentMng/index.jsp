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
		<style type="text/css">
		#modal-view{
    width: 600px;
    height: 500px;
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
				配件库存管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title">运单编号： </label> 
		    <input id="waybill" class="form-box" type="text" placeholder="请输入运单编号" />
		     <label class="title">配件名称： </label> 
		     <input id="attName" class="form-box" type="text" placeholder="请输入配件名称"/>
			<a id="searchBtn" class="itemBtn"  onclick="dosearch()">查询</a>
			<a id="saveBtn" class="itemBtn" onclick="doadd()">新增</a> 
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
                    <th>状态</th>
                    <th>创建时间</th>
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
									     <label class="title"><span class="red">*</span>配件名称：</label>
									     <select class="form-control" id="name">
									     <option value="">请选择配件</option>
									     <option value="工具">工具</option>
									     <option value="三角架">三角架</option>
									     <option value="说明书">说明书</option>
									     <option value="脚垫">脚垫</option>
									     <option value="灭火器">灭火器</option>
									     <option value="其它">其它</option>
										</select>
									     <!-- <input class="form-control" id="name" type="text" placeholder="请输入配件名称"/> -->
									     <input class="form-control" id="id-hidden" type="hidden"/>
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item extra-itemSec">
									     <label class="title"><span class="red">*</span>数量：</label>
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
			
			<!-- 查看开始 -->
			<div class="modal fade" id="modal-view" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal" >×</button>
					<h3 id="myModalLabel">查看费用申请</h3>
				</div>
				<div class="modal-body" style="height:400px;overflow:auto;">
					<div class="mng" style="min-height:350px;">						
						<div class="table-item">
							<div class="table-itemTit">基本信息</div>
							<!-- 第五列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">配件名称:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="name_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							<!-- 第一列 -->
							<div class="row newrow">
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">数量:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="count_view" class="form-control no-border"></p>
									</div>
								</div>								
							</div>
							<!-- 第二列 -->
							<div class="row newrow">
							<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">位置:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="p_view" class="form-control no-border"></p>
									</div>
								</div>							
							</div>
							<!-- 第三列 -->
							<div class="row newrow">
							<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">编号:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="no_view" class="form-control no-border"></p>
									</div>
								</div>																
								</div>								
							</div>	
							<!-- 第四列 -->
							<div class="row newrow">							
								<div class="col-xs-4 pd-2">
									<div style="padding-top:9px;">
										<label class="title">备注:</label>
									</div>
								</div>
								<div class="col-xs-8">
									<div class="form-contr">
										<p id="mark_view" class="form-control no-border"></p>
									</div>
								</div>																
							</div>
							<!-- 操作按钮栏 -->
							<div class="row newrow">
								<div class="col-xs-5"></div>
								<div class="col-xs-2">
									<div class="form-contr">
										<a class="backbtn" onclick="cancelView();"><i
											class="icon-undo" style="display: inline-block; width: 20px;"></i>关闭</a>
									</div>
								</div>
								<div class="col-xs-5"></div>
							</div>
						</div>
					</div>
				</div>
			<!-- 查看结束-->
			
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
			position:''
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
		 columns: [{ data: "rownum",'width':'5%' },
		    {data: "waybillNo",'width':'15%'},
		    {data: "attachmentName",'width':'15%'},
		    {data: "position",'width':'10%'},
		    {data: "count",'width':'10%'},
		    {data: "status",'width':'10%'},
		    {data: "insertTime",'width':'15%'},
		    { data: "status",'width':'20%'}],
		    columnDefs: [
		    {
		    	 //指定第五列
		    	 targets: 5,
			        render: function(data, type, row, meta) {
			        	if(data==0){return '新建'}else if(data==1){return '已入库'}else if(data==2){return '已出库'};
			        }	       
		    },
		    {
		    	 //指定第五列
		    	 targets: 6,
			        render: function(data, type, row, meta) {
			        	if(data==null || data==''|| parseInt(data)<0){
							return ''; 
						 }else{
							 return jsonDateFormat(data);
						 }
			        }	       
		    },
		    {
		        //指定第最后一列
		        targets: 7,
		        render: function(data, type, row, meta) {
		             if(data==0){return '<a class="table-edit" onclick="doedit('+ row.id +','+row.status+')" >编辑</a>'+
		            	 '&nbsp;&nbsp;<a class="table-delete" onclick="del('+ row.id +')" >删除</a>'}
		             else {return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'};
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

//新增
function doadd()
{
	clear();
	$('#addBtn').show();
	$('#editBtn').hide();
	$('#myModalLabel').html('配件入库登记');
	bindWaybill();
	$('#modal-info').modal('show');
}
/* 关闭窗体 */
function cancel(){
	clear();
	$('#modal-info').modal('hide');
}
function clear()
{
	$("#id-hidden").val('');
	$("#name").val('');
	$("#count").val('');
	$("#position").val('');
	$('#waybill2').find("option[value='']").attr("selected",true);
	$("#mark").val('');
}
//保存
function save()
{
	var flag="false";
	var attachmentName = $.trim($("#name").val());
    var count = $.trim($("#count").val());
    var position = $.trim($("#position").val());
    var waybillId = $.trim($("#waybill2").find("option:selected").val());
    var mark = $.trim($("#mark").val());
    console.info(waybillId);
    if(attachmentName == "")
    {
        bootbox.alert("配件名称不能为空！");
        return false;
    }
    if(count == "")
    {
        bootbox.alert("数量不能为空！");
        return false;
    }if(count!=''&&isNaN(count)){
		bootbox.alert('数量请填写数字！');
		return;
	}
    /* if(position == "")
    {
        bootbox.alert("位置不能为空！");
        return false;
    } */
    /*  if(waybillId == "" || waybillId == null)
    {
        bootbox.alert("运单编号不能为空！");
        return false;
    }  */
	bootbox.confirm({
		size: "small",
		message: "确定要保存该信息?",
		callback: function(result){
			  if(result){
				  $.ajax({
	            		type : 'POST',
	            		url : "${ctx}/operationMng/carAttachmentMng/save",
	            		data : JSON.stringify({		            			
	            			attachmentName : attachmentName,
	            			count : count,
	            			position : position,
	            			waybillId : waybillId,
	            			mark : mark
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
											  loadTable();
					            				cancel();
										  }else{
											  loadTable();
					            				cancel();
										  }
									  }
								 });
	            				setTimeout(function(){
									if(flag=="false"){
										loadTable();
			            				cancel();
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
	});	
}
//编辑
function doedit(id,status)
{
	//alert(status);
	clear();
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
					$('#myModalLabel').html('配件入库编辑');
					$('#modal-info').modal('show');
					
				if(status == 0)
				{
					$('#addBtn').hide();
					$('#editBtn').show();
				}
				/* else
				{
					$("#name").attr("disabled",true);
					$("#count").attr("disabled",true);
					$("#position").attr("disabled",true);
					$("#waybill2").attr("disabled",true);
					$("#mark").attr("disabled",true);
					$('#addBtn').hide();
					$('#editBtn').hide();
				} */
			} else {
				 bootbox.alert(data.msg);
			}
			
		}
	});
}

//更新
function update()
{
	var flag="false";
	var attachmentName = $.trim($("#name").val());
    var count = $.trim($("#count").val());
    var position = $.trim($("#position").val());
    var waybillId = $.trim($("#waybill2").find("option:selected").val());
    var id = $.trim($("#id-hidden").val());
    var mark = $.trim($("#mark").val());
    if(attachmentName == "")
    {
        bootbox.alert("配件名称不能为空！");
        return false;
    }
    if(count == "")
    {
        bootbox.alert("数量不能为空！");
        return false;
    }if(count!=''&&isNaN(count)){
		bootbox.alert('数量请填写数字！');
		return;
	}
    /* if(position == "")
    {
        bootbox.alert("位置不能为空！");
        return false;
    } */
    /*  if(waybillId == "" || waybillId== null)
    {
        bootbox.alert("运单编号不能为空！");
        return false;
    } */
    
    bootbox.confirm({ 
		  size: "small",
		  message: "确定要修改该数据?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/operationMng/carAttachmentMng/update",
						data : JSON.stringify({
							id:id,
							attachmentName : attachmentName,
							count : count,
							position : position,
							waybillId : waybillId,
							mark : mark
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								// console.log(JSON.stringify(data));
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "保存成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  loadTable();
					            				cancel();
										  }else{
											  loadTable();
					            				cancel();
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										loadTable();
			            				cancel();
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
    });
    
}

//提交
/* function submit(id)
{
	bootbox.confirm({
		size:"small",
		message:"确定提交该数据？",
		callback:function(result){
			if(result)
			{
				$.ajax({
					type:'post',
					url : "${ctx}/operationMng/carAttachmentMng/submit",
            		data : JSON.stringify({
            			id:id
            		}),
            		contentType : "application/json;charset=UTF-8",
            		dataType : 'JSON',
            		success : function(data){
            			if(data && data.code == 200)
            			{
            				 loadTable();
            			}else
            			{
            				bootbox.alert(data.msg);
            			}
            		}
				});
			}
		}
	});
} */ 

//删除
function del(id)
{
	var flag="false";
	bootbox.confirm({
		size:"small",
		message:"确定删除？",
		callback:function(result){
			if(result)
			{
				//alert(id);
				$.ajax({
					type:'post',
					url : "${ctx}/operationMng/carAttachmentMng/delete",
            		data : {id:id},
            		//contentType : "application/json;charset=UTF-8",
            		dataType : 'JSON',
            		success : function(data){
            			if(data && data.code == 200)
            			{
            				bootbox.confirm_alert({ 
								  size: "small",
								  message: "删除成功！", 
								  callback: function(result){
									  if(result){
										  flag="true";
										  loadTable();
									  }else{
										  loadTable();
									  }
								  }
							 });
            				setTimeout(function(){
								if(flag=="false"){
									loadTable();
									 $('.bootbox').modal('hide');
								}
							},3000);
            			}else
            			{
            				bootbox.alert(data.msg);
            			}
            		}
				});
			}
		}
	});	
}

function dosearch(){
	 loadTable();	
}

function doview(id){
	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/carAttachmentMng/getCarAttachmentList/",
		data:{id:id},
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				console.info(JSON.stringify(data.data));
				$("#name_view").html(data.data.attachmentName);
				$("#count_view").html(data.data.count);
				$("#p_view").html(data.data.position);
				$("#no_view").html(data.data.waybillNo);
				$("#mark_view").html(data.data.mark);
				$('#modal-view').modal('show');
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
	
}
function cancelView()
{
	$('#modal-view').modal('hide');	
}

</script>        

</body>
</html>