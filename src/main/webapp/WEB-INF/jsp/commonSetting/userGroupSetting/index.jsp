
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
			公共设置
			<small>
				<i class="icon-double-angle-right"></i>
				用户分组管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">查询条件：</label>
		   <input id="searchInfo" class="form-box" type="text" placeholder="请输入用户分组名称"/>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="addUser()">新增</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>用户组名称</th>
					<th>组员名称</th>
                    <th>排序</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 新增用户分组 -->
			<div class="modal fade" id="modal-add" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:6%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="refresh();">×</button>
						<h3 id="myModalLabel">新增用户分组</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>用户分组：</label>
								     <input class="form-control" id="name" type="text" placeholder="请输入用户分组名称"/>
								     <input class="form-control" id="id-hidden" type="hidden"/>
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-item">
									     <label class="title">备注：</label>
									     <input class="form-control" id="remark" type="text" placeholder="请输入备注"/>
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item extra-item">
									     <label class="title">排序值：</label>
									     <input class="form-control" id="orderFlag" type="text" placeholder="请输入排序值"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item" style="position:relative">
									     <label class="title">用户分组：</label>
									     <div class="form-control" style="border:0;padding:0">
									       <input id="role" value="" type="text" readonly="readonly" style="width:80%;" />
									       <input class="form-control" id="useid-hidden" type="hidden"/>
									       <a class="selectBtn" id="selectBtn" onclick="showControl(this)">用户分组</a>
									     </div>
									 </div>
							    	<hr class="tree"></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="save();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="refresh();">取消</a>
									 </div> 
									</div>
						       </div>
					     </div>
					  </div>
				   </div>
				 </div>
			 </div>
			<!-- 编辑用户分组 -->
			<div class="modal fade" id="modal-edit" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:6%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="updateCancle()">×</button>
						<h3>编辑用户分组</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>用户分组：</label>
								     <input class="form-control" id="e-name" type="text" placeholder="请输入用户分组名称"/>
								     <input class="form-control" id="e-id-hidden" type="hidden"/>
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-item">
									     <label class="title">备注：</label>
									     <input class="form-control" id="e-remark" type="text" placeholder="请输入备注"/>
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item extra-item">
									     <label class="title">排序值：</label>
									     <input class="form-control" id="e-orderFlag" type="text" placeholder="请输入排序值"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item" style="position:relative">
									     <label class="title">权限：</label>
									     <div class="form-control" style="border:0;padding:0">
									       <input id="e-role" value="" type="text" readonly="readonly" style="width:80%;" />
									       <input class="form-control" id="e-useid-hidden" type="hidden"/>
									       <a class="selectBtn" id="selectBtn" onclick="controlLoad(this)">用户分组</a>
									     </div>
									 </div>
							    	<hr class="tree"></hr>
									 <div class="add-item-btn dis-block" id="editBtn">
									    <a class="add-itemBtn btnOk" onclick="update()">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="updateCancle()">取消</a>
									  </div>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
			<!-- 用户分组 新增 -->
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static" style="width:620px;">
				<div class="modal-dialog" style="padding-top:5px;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="nodeCancle()">×</button>
						<h3 id="myModalLabel">用户分组选择</h3>
				    </div>
					<div class="modal-body" style="height:498px;">
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <table id="userListTable" class="table table-striped table-bordered table-hover">
					                      <thead>
						                    <tr>	
							                   <th class="center"><input type="checkbox" class="checkall" /></th>													
								               <th>序号</th>
								               <th>工号</th>
			                                   <th>姓名</th>
			                                   <th>部门</th>
			                                   <th>职位</th> 
			                                   <th>手机号码</th>                                                                                                          
						                     </tr>
					                      </thead>
					                      <tbody>
					                       
					                      </tbody>
					                 </table>
								<div class="modelBtn" id="treebtn-load">
									<a class="modelBtn-ok" onclick="nodeOk();">确定</a>
									<a class="modelBtn-cancle" onclick="nodeCancle()">取消</a>
								</div>
						    </div>
					     </div>
				       </div>  
					</div>
				  </div>
				</div>
			</div>
			<!-- 用户分组 编辑 -->
			<div class="modal fade" id="modal-einfo" tabindex="-1" role="dialog" data-backdrop="static" style="width:620px;">
				<div class="modal-dialog" style="padding-top:5px;">
				  <div class="modal-content" style="border:0;">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="enodeCancle()">×</button>
						<h3 id="myModalLabel">用户分组选择</h3>
				    </div>
					<div class="modal-body" style="height:498px;">
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <table id="euserListTable" class="table table-striped table-bordered table-hover">
					                      <thead>
						                    <tr>	
							                   <th class="center"><input type="checkbox" class="checkall" /></th>													
								               <th>序号</th>
								               <th>工号</th>
			                                   <th>姓名</th>
			                                   <th>部门</th>
			                                   <th>职位</th> 
			                                   <th>手机号码</th>                                                                                                          
						                     </tr>
					                      </thead>
					                      <tbody>
					                       
					                      </tbody>
					                 </table>
							
								<input id="hidden-roleName" type="hidden"/>
								<input id="hidden-roleid" type="hidden"/>
								<div class="modelBtn" id="treebtn-load">
									<a class="modelBtn-ok" onclick="enodeOk();">确定</a>
									<a class="modelBtn-cancle" onclick="enodeCancle()">取消</a>
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
<script type="text/javascript" src="${ctx}/staticPublic/js/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${ctx}/staticPublic/js/ztree/jquery.ztree.excheck.js"></script>
<script type="text/javascript">
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/commonSetting/userGroupSetting/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum","width":"10%"},
		    {data: "name","width":"15%"},
		    {data: "userNames","width":"35%"},
		    {data: "orderId","width":"10%"},
		    {data: null,"width":"30%"}],
		    columnDefs: [
				{
					 //用户名
					 targets: 2,
					 render: function (data, type, row, meta) {
				           return data.substring(0, data.length-1);
				       }	       
				}, 
		      	{
			    	 //操作栏
			    	 targets: 4,
			    	 render: function (data, type, row, meta) {
		                    return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
						           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
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
		 "sAjaxSource": "${ctx}/commonSetting/userGroupSetting/getListData" , //获取数据的ajax方法的URL	
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
				columns: [{ data: "rownum","width":"10%"},
						    {data: "name","width":"15%"},
						    {data: "userNames","width":"35%"},
						    {data: "orderId","width":"10%"},
						    {data: null,"width":"30%"}],
						    columnDefs: [
								{
									 //用户名
									 targets: 2,
									 render: function (data, type, row, meta) {
								          return data.substring(0, data.length-1);
								      }	       
								}, 
						      	{
							    	 //操作栏
							    	 targets: 4,
							    	 render: function (data, type, row, meta) {
						                    return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
										           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
})

/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
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
				name : $.trim($('#searchInfo').val())
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
/* 选择用户 */
function showControl(e){
	var secho='1';   
	var pageStartIndex='0';
	var pageSize=1000;
	$('#secho').val(secho);
	var size=0,all=0;
	var obj = {};
	var html='',htmlItem='';
	var arr=[];
	var ids =$('#useid-hidden').val();
	 ids.substring(0, ids.length-1);
	 arr = ids.split(',');
	$.ajax({
		type : 'POST',
		url : "${ctx}/commonSetting/userSetting/getListData",
		data : JSON.stringify({
			sEcho : $.trim(secho),				
			pageStartIndex : $.trim(pageStartIndex),
			pageSize : $.trim(pageSize),
			departmentId : '',
			driverFlag : '',
			searchInfo : ''
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {						
				obj.iTotalDisplayRecords=data.data.totalCounts;
				obj.iTotalRecords=data.data.totalCounts;
				obj.aaData=data.data.records;		
				obj.sEcho=data.data.frontParams;
				all=obj.aaData.length;
				if(obj.aaData.length>0){
					for(var i=0;i<obj.aaData.length;i++){
						obj.aaData[i]["rownum"]=i+1;
						if(obj.aaData[i]["workNo"]==null){
							obj.aaData[i]["workNo"]=''
						}
						if(obj.aaData[i]["name"]==null){
							obj.aaData[i]["name"]=''
						}
						if(obj.aaData[i]["departmentName"]==null){
							obj.aaData[i]["departmentName"]=''
						}
						if(obj.aaData[i]["title"]==null){
							obj.aaData[i]["title"]=''
						}
						if(obj.aaData[i]["mobile"]==null){
							obj.aaData[i]["mobile"]=''
						}
						for(var j=0;j<arr.length;j++){
							if(obj.aaData[i]["id"]==arr[j]){
								htmlItem='<tr class="selected" data-id='+obj.aaData[i]["id"]+'><td class="text-center"><input type="checkbox" checked="checked" class="checkchild"></td>'
								+'<td>'+obj.aaData[i]["rownum"]+'</td>'
							    +'<td>'+obj.aaData[i]["workNo"]+'</td>'
							    +'<td>'+obj.aaData[i]["name"]+'</td>'
							    +'<td>'+obj.aaData[i]["departmentName"]+'</td>'
							    +'<td>'+obj.aaData[i]["title"]+'</td>'
							    +'<td>'+obj.aaData[i]["mobile"]+'</td>'
							    +'</tr>';
							    size++;
								break;
							}else{
								htmlItem='<tr data-id='+obj.aaData[i]["id"]+'><td class="text-center"><input type="checkbox" class="checkchild"></td>'
								+'<td>'+obj.aaData[i]["rownum"]+'</td>'
							    +'<td>'+obj.aaData[i]["workNo"]+'</td>'
							    +'<td>'+obj.aaData[i]["name"]+'</td>'
							    +'<td>'+obj.aaData[i]["departmentName"]+'</td>'
							    +'<td>'+obj.aaData[i]["title"]+'</td>'
							    +'<td>'+obj.aaData[i]["mobile"]+'</td>'
							    +'</tr>';
							}
						}
						html+=htmlItem;
					}
					$('#userListTable tbody').html(html);
					if(size==all && size>0){
						 checkChoose(true);
					 }else{
						 checkChoose(false); 
					 }
				}
			}
		}
	});
	$('#modal-info').modal('show');
}
/* 关闭用户选择 */
function nodeCancle(){
	$('#modal-info').modal('hide');
}

/* 用户选择确认 */
function nodeOk(){
	var table=$('#userListTable tbody');
	var id="";
	var name=""
	for(i=0;i<table.children('tr.selected').length;i++){
		var obj=table.children('tr.selected').eq(i);
		id+=obj.attr("data-id")+',';
		name+=obj.find('td').eq(3).html()+',';
	}
	$('#useid-hidden').val(id.substring(0, id.length-1));
	$('#role').attr('value',name.substring(0, name.length-1));
	$('#modal-info').modal('hide');
}
/* 确认选择 */
function checkChoose(flag){
	if(flag==true){
		$(".checkall").prop("checked",true); 
	}else{//不全选 
        $(".checkall").prop("checked",false); 
    } 
 $(".checkall").on('click',function () {
      var check = $(this).prop("checked");
      $(".checkchild").prop("checked", check);
      if(check==true){
    	  $(".checkchild").parents('tr').addClass('selected');
      }else{
    	  $(".checkchild").parents('tr').removeClass('selected');
      }
});
   
$('#userListTable tbody').on( 'click', 'tr', function () {
  if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true){
		$(this).toggleClass('selected');
   } 
  if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true){
		$(this).toggleClass('selected');
   }
  if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') != true){
		$(".checkall").prop("checked",false);
  }
  if($("input[class='checkchild']:checked").size()==$("input[class='checkchild']").size() && $("input[class='checkchild']").size()>0 ){//全选 
        $(".checkall").prop("checked",true); 
    }
}); 
}
/* 编辑确认选择 */
function echeckChoose(flag){
	if(flag==true){
		$(".checkall").prop("checked",true); 
	}else{//不全选 
        $(".checkall").prop("checked",false); 
    } 
 $(".checkall").on('click',function () {
      var check = $(this).prop("checked");
      $(".checkchild").prop("checked", check);
      if(check==true){
    	  $(".checkchild").parents('tr').addClass('selected');
      }else{
    	  $(".checkchild").parents('tr').removeClass('selected');
      }
});
   
$('#euserListTable tbody').on( 'click', 'tr', function () {
  if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true){
		$(this).toggleClass('selected');
   } 
  if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true){
		$(this).toggleClass('selected');
   }
  if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') != true){
		$(".checkall").prop("checked",false);
  }
  if($("input[class='checkchild']:checked").size()==$("input[class='checkchild']").size() && $("input[class='checkchild']").size()>0 ){//全选 
        $(".checkall").prop("checked",true); 
    }
}); 
}
/* 删除人员 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该用户分组信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/commonSetting/userGroupSetting/delete/"+id,
						data :{},
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "删除成功！", 
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
							} else {
								bootbox.alert(data.msg);
							}
						}
						
					}); 
			  }
		  }
	})
};

/*新增信息输入  */
function addUser(){
	clear();
	$('#modal-add').modal('show');
}
/* 关闭窗体 */
function refresh(){
	clear();
	$('#modal-add').modal('hide');
	
}
/* 数据重置 */
function clear(){
	$('#useid-hidden').val('');
	$('#name').val('');
	$('#remark').val('');
	$('#orderFlag').val('');
	$('#role').attr('value','');	
}
/* 保存新增用户分组信息 */
function save(){
	var flag="false";
	var name=$('#name').val();
	var mark=$('#remark').val();
	var orderId=$('#orderFlag').val();
	var userIds=$('#useid-hidden').val();
	if(name==''|| name==null){
		bootbox.alert('分组名称不能为空！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该用户分组信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/commonSetting/userGroupSetting/save',
						data : JSON.stringify({
							name : name,
							mark : mark,
							orderId : orderId,
							userIds : userIds
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
											  location.reload();
										  }else{
											 location.reload();  
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										location.reload();
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
/* 获取编辑数据 */
function doedit(id){
	$('#e-id-hidden').val(id);
	$.ajax({
		type : 'GET',
		url : "${ctx}/commonSetting/userGroupSetting/getDetailData/"+id,
		data :{},
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var useNameList=data.data['userNames'];
				var idList=data.data['userIds'];
				$('#e-name').val(data.data['name']);
				$('#e-remark').val(data.data['mark']);
				$('#e-orderFlag').val(data.data['orderId']);
				$('#e-role').attr('value',useNameList.substring(0, useNameList.length-1));
				$('#e-useid-hidden').val(idList);
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	}); 
	$('#modal-edit').modal('show');
}

/* 更新 */
function update(){
	var flag="false";
	var name=$('#e-name').val();
	var mark=$('#e-remark').val();
	var orderId=$('#e-orderFlag').val();
	var userIds=$('#e-useid-hidden').val();
	var id=$('#e-id-hidden').val();
	if(name==''|| name==null){
		bootbox.alert('分组名称不能为空！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该修改分组信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/commonSetting/userGroupSetting/update',
						data : JSON.stringify({
							id : id,
							name : name,
							mark : mark,
							orderId : orderId,
							userIds : userIds
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
											  location.reload();
										  }else{
											 location.reload();  
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										location.reload();
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
/* 选择用户编辑 */
function controlLoad(e){
	var secho='1';   
	var pageStartIndex='0';
	var pageSize=1000;
	$('#secho').val(secho);
	var size=0,all=0;
	var obj = {};
	var html='',htmlItem='';
	var arr=[];
	var ids =$('#e-useid-hidden').val();
	 ids.substring(0, ids.length-1);
	 arr = ids.split(',');
	$.ajax({
		type : 'POST',
		url : "${ctx}/commonSetting/userSetting/getListData",
		data : JSON.stringify({
			sEcho : $.trim(secho),				
			pageStartIndex : $.trim(pageStartIndex),
			pageSize : $.trim(pageSize),
			departmentId : '',
			driverFlag : '',
			searchInfo : ''
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {						
				obj.iTotalDisplayRecords=data.data.totalCounts;
				obj.iTotalRecords=data.data.totalCounts;
				obj.aaData=data.data.records;		
				obj.sEcho=data.data.frontParams;
				all=obj.aaData.length;
				if(obj.aaData.length>0){
					for(var i=0;i<obj.aaData.length;i++){
						obj.aaData[i]["rownum"]=i+1;
						if(obj.aaData[i]["workNo"]==null){
							obj.aaData[i]["workNo"]=''
						}
						if(obj.aaData[i]["name"]==null){
							obj.aaData[i]["name"]=''
						}
						if(obj.aaData[i]["departmentName"]==null){
							obj.aaData[i]["departmentName"]=''
						}
						if(obj.aaData[i]["title"]==null){
							obj.aaData[i]["title"]=''
						}
						if(obj.aaData[i]["mobile"]==null){
							obj.aaData[i]["mobile"]=''
						}
						for(var j=0;j<arr.length;j++){
							if(obj.aaData[i]["id"]==arr[j]){
								htmlItem='<tr class="selected" data-id='+obj.aaData[i]["id"]+'><td class="text-center"><input type="checkbox" checked="checked" class="checkchild"></td>'
								+'<td>'+obj.aaData[i]["rownum"]+'</td>'
							    +'<td>'+obj.aaData[i]["workNo"]+'</td>'
							    +'<td>'+obj.aaData[i]["name"]+'</td>'
							    +'<td>'+obj.aaData[i]["departmentName"]+'</td>'
							    +'<td>'+obj.aaData[i]["title"]+'</td>'
							    +'<td>'+obj.aaData[i]["mobile"]+'</td>'
							    +'</tr>';
							    size++;
								break;
							}else{
								htmlItem='<tr data-id='+obj.aaData[i]["id"]+'><td class="text-center"><input type="checkbox" class="checkchild"></td>'
								+'<td>'+obj.aaData[i]["rownum"]+'</td>'
							    +'<td>'+obj.aaData[i]["workNo"]+'</td>'
							    +'<td>'+obj.aaData[i]["name"]+'</td>'
							    +'<td>'+obj.aaData[i]["departmentName"]+'</td>'
							    +'<td>'+obj.aaData[i]["title"]+'</td>'
							    +'<td>'+obj.aaData[i]["mobile"]+'</td>'
							    +'</tr>';
							}
						}
						html+=htmlItem;
					}
					$('#euserListTable tbody').html(html);
					if(size==all && size>0){
						 echeckChoose(true);
					 }else{
						 echeckChoose(false); 
					 }
				}
			}
		}
	});
	$('#modal-einfo').modal('show');
}

/* 用户选择确认编辑 */
function enodeOk(){
	var table=$('#euserListTable tbody');
	var id="";
	var name=""
	for(i=0;i<table.children('tr.selected').length;i++){
		var obj=table.children('tr.selected').eq(i);
		id+=obj.attr("data-id")+',';
		name+=obj.find('td').eq(3).html()+',';
	}
	$('#e-useid-hidden').val(id.substring(0, id.length-1));
	$('#e-role').attr('value',name.substring(0, name.length-1));
	$('#modal-einfo').modal('hide');
}

/* 关闭用户选择编辑 */
function enodeCancle(){
	$('#modal-einfo').modal('hide');
}
function updateCancle(){
	$('#modal-edit').modal('hide');
}



</script>



</body>
</html>






