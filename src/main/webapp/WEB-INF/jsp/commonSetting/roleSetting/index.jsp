
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
				角色管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">查询条件：</label>
		   <input id="searchInfo" class="form-box" type="text" placeholder="请输入角色名称"/>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="addUser()">新增</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>角色名称</th>
					<th>备注</th>
                    <th>排序</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 新增角色 -->
			<div class="modal fade" id="modal-add" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:6%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="refresh();">×</button>
						<h3 id="myModalLabel">新增角色</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>角色名称：</label>
								     <input class="form-control" id="name" type="text" placeholder="请输入角色名称"/>
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
								    <!-- <div class="add-item">
								     <label class="title"><span class="red">*</span>上级角色：</label>
								     <select class="form-control" id="parentName">
									</select>
								    </div>
							  		<hr class="tree"></hr> -->
								    <div class="add-item extra-item" style="position:relative">
									     <label class="title">权限：</label>
									     <div class="form-control" style="border:0;padding:0">
									       <input id="role" value="" type="text" readonly="readonly" style="width:80%;" />
									       <input class="form-control" id="roleid-hidden" type="hidden"/>
									       <a class="selectBtn" id="selectBtn" onclick="showControl(this)">选择</a>
									     </div>
									 </div>
							    	<hr class="tree"></hr>
							    	<div class="add-item extra-item" style="position:relative">
									     <label class="title">通讯群组：</label>
									     <div class="form-control" style="border:0;padding:0">
									       <input id="useIds" value="" type="text" readonly="readonly" style="width:80%;" />
									       <input class="form-control" id="useid-hidden" type="hidden"/>
									       <a class="selectBtn" id="selectBtn" onclick="showUseControl(this)">选择</a>
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
			<!-- 编辑角色 -->
			<div class="modal fade" id="modal-edit" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:6%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="updateCancle()">×</button>
						<h3>编辑角色</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>角色名称：</label>
								     <input class="form-control" id="e-name" type="text" placeholder="请输入角色名称"/>
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
								    <!-- <div class="add-item">
								     <label class="title"><span class="red">*</span>上级角色：</label>
								     <select class="form-control" id="parentName">
									</select>
								    </div>
							  		<hr class="tree"></hr> -->
								    <div class="add-item extra-item" style="position:relative">
									     <label class="title">权限：</label>
									     <div class="form-control" style="border:0;padding:0">
									       <input id="e-role" value="" type="text" readonly="readonly" style="width:80%;" />
									       <input class="form-control" id="e-roleid-hidden" type="hidden"/>
									       <a class="selectBtn" id="selectBtn" onclick="controlLoad(this)">选择</a>
									     </div>
									 </div>
							    	<hr class="tree"></hr>
							    	<div class="add-item extra-item" style="position:relative">
									     <label class="title">通讯群组：</label>
									     <div class="form-control" style="border:0;padding:0">
									       <input id="euseIds" value="" type="text" readonly="readonly" style="width:80%;" />
									       <input class="form-control" id="euseid-hidden" type="hidden"/>
									       <a class="selectBtn" id="selectBtn" onclick="controlUseLoad(this)">选择</a>
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
			<!-- 权限树 -->
			<div class="modal fade modal-style" id="modal-tree" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="padding-top:6%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
						<h3 id="myModalLabel">权限选择</h3>
				    </div>
					<div class="modal-body">
					    <div id="menuContent" class="menuContent">
						   <ul id="treeRole" class="ztree" style="margin-top:0; width:98%; height: 400px;"></ul>
						</div>
						<input id="hidden-roleName" type="hidden"/>
						<input id="hidden-roleid" type="hidden"/>
						<div class="modelBtn" id="treebtn-load">
							<a class="modelBtn-ok" onclick="nodeOk();">确定</a>
							<a class="modelBtn-cancle" onclick="nodeCancle()">取消</a>
						</div>
						<div class="modelBtn" id="treebtn-reload">
							<a class="modelBtn-ok" onclick="nodeReOk();">确定</a>
							<a class="modelBtn-cancle" id="nodeIsFirst" onclick="nodeReCancle(this)" data-flag='first'>取消</a>
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
				        <button class="close" type="button" onclick="nodeUserCancle()">×</button>
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
												<th>用户组名称</th>
												<th>组员名称</th>
							                    <th>排序</th>                                                                                                     
						                     </tr>
					                      </thead>
					                      <tbody>
					                       
					                      </tbody>
					                 </table>
								<div class="modelBtn" id="treebtn-load">
									<a class="modelBtn-ok" onclick="nodeUserOk();">确定</a>
									<a class="modelBtn-cancle" onclick="nodeUserCancle()">取消</a>
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
				        <button class="close" type="button" onclick="enodeUserCancle()">×</button>
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
												<th>用户组名称</th>
												<th>组员名称</th>
							                    <th>排序</th>                                                                                                          
						                     </tr>
					                      </thead>
					                      <tbody>
					                       
					                      </tbody>
					                 </table>
								<div class="modelBtn" id="treebtn-load">
									<a class="modelBtn-ok" onclick="enodeUserOk();">确定</a>
									<a class="modelBtn-cancle" onclick="enodeUserCancle()">取消</a>
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
/* 权限树加载以及赋值-------begin */
var setting = {
		check: {
			enable: true,
			chkboxType: { "Y" : "ps", "N" : "ps" }
		},
		view: {
			dblClickExpand: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			beforeClick: beforeClick,
			onCheck: onCheck
		}
	};
	function beforeClick(treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeRole");
		zTree.checkNode(treeNode, !treeNode.checked, null, true);
		return false;
	}
	function onCheck(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeRole"),
		nodes = zTree.getCheckedNodes(true),
		v = "",
		m="";
		for (var i=0, l=nodes.length; i<l; i++) {
			v += nodes[i].name + ",";
			m += nodes[i].id + ",";
		}
		if (v.length > 0 ) v = v.substring(0, v.length-1);
		if (m.length > 0 ) m = m.substring(0, m.length-1);
		var roleObj = $("#hidden-roleName");
		var roleId=$("#hidden-roleid")
		roleObj.attr("value", v);
		roleId.attr("value", m);
	}
	function showControl(e){
		$('#modal-tree').modal('show');
		$('#treebtn-load').show();
		$('#treebtn-reload').hide();
		loadTree();
	}
	
	function controlLoad(e){
		$('#modal-tree').modal('show');
		$('#treebtn-load').hide();
		$('#treebtn-reload').show();
		if($('#nodeIsFirst').attr('data-flag')=='first'){
			reloadTree();
			$('#nodeIsFirst').attr('data-flag','noFirst');
		}
	}
	
	/* 编辑加载树 */
	function reloadTree(){
		var nodeNamelist="";
		var nodeNameid="";
		$.ajax({  
	        url: '${ctx}/commonSetting/menuSetting/getListData',  
	        type: "post",  
	        dataType: 'json',
	        data: '',
	        success: function (data) {  
	            if(data.code == 200){ 
	            	if(data.data.length>0){
	            		var id=$('#e-id-hidden').val();
	            		if(id!=null && id!=''){
	            			$.ajax({  
	            		        url: '${ctx}/commonSetting/roleSetting/getRoleMenuListData',  
	            		        type: "post",  
	            		        dataType: 'json',
	            		        data: {id:id},
	            		        success: function (list) {  
	            		            if(list.code == 200){ 
	            		            	if(list.data.length>0){
	            		            		var objs=[];
						            		for(i=0;i<data.data.length;i++){
						            			var obj={};
						            			obj.id=data.data[i]['id'];
						            			obj.name=data.data[i]['name'];
						            			obj.orderId=data.data[i]['orderId'];
						            			obj.parentId=data.data[i]['parentId'];
						            			obj.checked='false';
						            			for(var j=0;j<list.data.length;j++){
							            			if(data.data[i]['id']==list.data[j]['menuId']){
							            				obj.checked='true';
							            				nodeNamelist+=data.data[i]['name'] + ',';
							            				nodeNameid+=data.data[i]['id'] + ',';
							            			}
						            		}
						            		objs.push(obj);	
						            	}
						            	$.fn.zTree.init($("#treeRole"), setting, objs);
						            	$.fn.zTree.getZTreeObj("treeRole").expandAll(true);
						            	if (nodeNameid.length > 0 ) nodeNameid = nodeNameid.substring(0, nodeNameid.length-1);
						        		if (nodeNamelist.length > 0 ) nodeNamelist = nodeNamelist.substring(0, nodeNamelist.length-1);
						        		$("#e-role").attr('value',nodeNamelist);
						        		$("#e-roleid-hidden").attr('value',nodeNameid);
										}
	            		               }else{  
	            		            	   bootbox.alert('加载失败！');
	            		               }  
	            		        }  
	            		      });
	            		}else{
	            			bootbox.alert('该角色不存在！');
	            		}
	            	}
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      });
		
		
	}
	/* 初始加载树 */
	function loadTree(){
		$.ajax({  
	        url: '${ctx}/commonSetting/menuSetting/getListData',  
	        type: "post",  
	        dataType: 'json',
	        data: '',
	        success: function (data) {  
	            if(data.code == 200){ 
	            	if(data.data.length>0){
	            		var objs=[];
	            		for(i=0;i<data.data.length;i++){
	            			var obj={};
	            			obj.id=data.data[i]['id'];
	            			obj.name=data.data[i]['name'];
	            			obj.orderId=data.data[i]['orderId'];
	            			obj.parentId=data.data[i]['parentId'];
	            			obj.checked='false';
	            			objs.push(obj);
	            		}
	            	}
	            	$.fn.zTree.init($("#treeRole"), setting, objs);
	            	$.fn.zTree.getZTreeObj("treeRole").expandAll(true);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      });
	}
	/* 确定权限菜单 */
	function nodeOk(){
		$("#role").attr('value',$("#hidden-roleName").attr('value'));
		$("#roleid-hidden").attr('value',$("#hidden-roleid").attr('value'));
		$("#modal-tree").modal('hide');
	}
	function nodeReOk(){
		$("#e-role").attr('value',$("#hidden-roleName").attr('value'));
		$("#e-roleid-hidden").attr('value',$("#hidden-roleid").attr('value'));
		$("#modal-tree").modal('hide');
	}
	function nodeCancle(){
		$("#modal-tree").modal('hide');
	}
	function nodeReCancle(e){
		$("#modal-tree").modal('hide');
		$(e).attr('data-flag','noFirst');
	}

	/* 权限树加载以及赋值-------end */
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/commonSetting/roleSetting/getListData" , //获取数据的ajax方法的URL							 
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
		    {data: "name","width":"25%"},
		    {data: "mark","width":"25%"},
		    {data: "orderId","width":"10%"},
		    /* {data: "parentName"}, */
		    {data: null,"width":"30%"}],
		    columnDefs: [
				/* {
					 //操作栏
					 targets:4,
					 render: function (data, type, row, meta) {
				           if(data==null || data==""){
				        	   return '无';
				           }else{
				        	   return data;
				           }
				       }	       
				}, */
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
		 "sAjaxSource": "${ctx}/commonSetting/roleSetting/getListData" , //获取数据的ajax方法的URL	
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
						    {data: "name","width":"25%"},
						    {data: "mark","width":"25%"},
						    {data: "orderId","width":"10%"},
						    /* {data: "parentName"}, */
						    {data: null,"width":"30%"}],
						    columnDefs: [
								/* {
									 //操作栏
									 targets:4,
									 render: function (data, type, row, meta) {
								          if(data==null || data==""){
								       	   return '无';
								          }else{
								       	   return data;
								          }
								      }	       
								}, */
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
				name : $.trim($('#searchInfo').val()),
				mark :'',
				order_id :'',
				parentName :''
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

/* 删除人员 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该角色信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/commonSetting/roleSetting/delete",
						data :{
							id :id
						},
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "删除成功！", 
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
	})
};
/* 新增角色信息 */
	/* 获取上级角色*/
function bindParent(){
	$.ajax({  
        url: '${ctx}/commonSetting/roleSetting/getParent',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: '',
        success: function (data) {
        	var html ='<option value="-1">请选择上级角色</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                		}
            		}
            	}
            	$('#parentName').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}

/*新增信息输入  */
function addUser(){
	clear();
	/* bindParent(); */
	$('#modal-add').modal('show');
}
/* 关闭窗体 */
function refresh(){
	clear();
	$('#modal-add').modal('hide');
	
}
/* 数据重置 */
function clear(){
	$('#id-hidden').val('');
	$('#name').val('');
	$('#remark').val('');
	/* $('#parentName').find("option[value='-1']").attr("selected",true); */
	$('#orderFlag').val('');
	$('#role').attr('value','');	
}
/* 保存新增角色信息 */
function save(){
	var flag="false";
	var name=$('#name').val();
	var mark=$('#remark').val();
	var parentId="";
	var orderId=$('#orderFlag').val();
	var menulist=$('#roleid-hidden').val();
	var groupsList=$('#useid-hidden').val();
	var menusList={};
	var obj={};
	var objs=[];
	var groups=[];
	if(name==''|| name==null){
		bootbox.alert('角色名称不能为空！');
		return;
	}
	/* if(menulist==''|| menulist==null || menulist=='-1'){
		bootbox.alert('权限不能为空！');
		return;
	} */else{
		var groupArr=groupsList.split(',');
		var arr = menulist.split(',');
		if(arr.length>0){
			for(var i=0;i<arr.length;i++){
				var objlist={};
				objlist.roleId='';
				objlist.menuId=arr[i];
				objs.push(objlist);
			}
			obj.menusList=objs;
		}
		if(groupArr.length>0){
			for(var i=0;i<groupArr.length;i++){
				var grouplist={};
				grouplist.roleId='';
				grouplist.userGroupId=groupArr[i];
				groups.push(grouplist);
			}
			obj.userGroupsList=groups;
		}
		obj.name=name;
		obj.mark=mark;
		obj.parentId=parentId;
		obj.orderId=orderId;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该角色信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/commonSetting/roleSetting/save',
						data : JSON.stringify(obj),
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
		})
}
function doedit(id){
	var names="";
	var ids="";
	/* bindParent(); */
	$.ajax({
		type : 'POST',
		url : "${ctx}/commonSetting/roleSetting/getRoleById",
		data :{
			id :id
		},
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#e-id-hidden').val(id);
				$('#e-name').val(data.data.name);
				$('#e-remark').val(data.data.mark);
				$('#e-orderFlag').val(data.data.orderId);
				if(data.data.userGroupsList.length>0){
					for(var i=0;i<data.data.userGroupsList.length;i++){
						if(data.data.userGroupsList[i]['userGroupName']!=null && data.data.userGroupsList[i]['userGroupName']!=''){
							names+=data.data.userGroupsList[i]['userGroupName']+',';
						}
						if(data.data.userGroupsList[i]['userGroupId']!=null && data.data.userGroupsList[i]['userGroupId']!=''){
							ids+=data.data.userGroupsList[i]['userGroupId']+',';
						}
					}
				}
				$('#euseid-hidden').val(ids.substring(0, ids.length-1));
				$('#euseIds').attr('value',names.substring(0, names.length-1));
				reloadTree();
				$('#modal-edit').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 

}

/* 更新 */
function update(){
	$('#nodeIsFirst').attr('data-flag','first');
	var id=$('#e-id-hidden').val();
	var name=$('#e-name').val();
	var mark=$('#e-remark').val();
	var parentId="";
	var orderId=$('#e-orderFlag').val();
	var menulist=$('#e-roleid-hidden').val();
	var groupsList=$('#euseid-hidden').val();
	var menusList={};
	var obj={};
	var objs=[];
	var groups=[];
	if(name==''|| name==null){
		bootbox.alert('角色名称不能为空！');
		return;
	}
	/* if(menulist==''|| menulist==null || menulist=='-1'){
		bootbox.alert('权限不能为空！');
		return;
	} */else{
		var arr = menulist.split(',');
		var groupArr=groupsList.split(',');
		if(arr.length>0){
			for(var i=0;i<arr.length;i++){
				var objlist={};
				objlist.roleId='';
				objlist.menuId=arr[i];
				objs.push(objlist);
			}
			obj.menusList=objs;
			if(groupArr.length>0){
				for(var i=0;i<groupArr.length;i++){
					var grouplist={};
					grouplist.roleId='';
					grouplist.userGroupId=groupArr[i];
					groups.push(grouplist);
				}
				obj.userGroupsList=groups;
			}
			obj.name=name;
			obj.mark=mark;
			obj.parentId=parentId;
			obj.orderId=orderId;
			obj.id=id;
		}
	}
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要修改该角色信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/commonSetting/roleSetting/update',
						data : JSON.stringify(obj),
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
		})
}

function updateCancle(){
	$('#nodeIsFirst').attr('data-flag','first');
	$('#modal-edit').modal('hide');
}
/* 用户群组新增-----------------begin */
/* 新增用户群组 */
function showUseControl(){
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
		url : "${ctx}/commonSetting/userGroupSetting/getListData",
		data : JSON.stringify({
			sEcho : $.trim(secho),				
			pageStartIndex : $.trim(pageStartIndex),
			pageSize : $.trim(pageSize),
			name  : ''
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
						if(obj.aaData[i]["name"]==null){
							obj.aaData[i]["name"]=''
						}
						if(obj.aaData[i]["userNames"]==null){
							obj.aaData[i]["userNames"]=''
						}
						if(obj.aaData[i]["title"]==null){
							obj.aaData[i]["title"]=''
						}
						if(obj.aaData[i]["mobile"]==null){
							obj.aaData[i]["mobile"]=''
						}
						if(obj.aaData[i]["orderId"]==null){
							obj.aaData[i]["orderId"]=''
						}
						for(var j=0;j<arr.length;j++){
							if(obj.aaData[i]["id"]==arr[j]){
								htmlItem='<tr class="selected" data-id='+obj.aaData[i]["id"]+'><td class="text-center"><input type="checkbox" checked="checked" class="checkchild"></td>'
								+'<td>'+obj.aaData[i]["rownum"]+'</td>'
							    +'<td>'+obj.aaData[i]["name"]+'</td>'
							    +'<td>'+obj.aaData[i]["userNames"]+'</td>'
							    +'<td>'+obj.aaData[i]["orderId"]+'</td>'
							    +'</tr>';
							    size++;
								break;
							}else{
								htmlItem='<tr data-id='+obj.aaData[i]["id"]+'><td class="text-center"><input type="checkbox" class="checkchild"></td>'
								+'<td>'+obj.aaData[i]["rownum"]+'</td>'
							    +'<td>'+obj.aaData[i]["name"]+'</td>'
							    +'<td>'+obj.aaData[i]["userNames"]+'</td>'
							    +'<td>'+obj.aaData[i]["orderId"]+'</td>'
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
/* 关闭新增用户选择 */
function nodeUserCancle(){
	$('#modal-info').modal('hide');
}

/* 用户选择确认 */
function nodeUserOk(){
	var table=$('#userListTable tbody');
	var id="";
	var name=""
	for(i=0;i<table.children('tr.selected').length;i++){
		var obj=table.children('tr.selected').eq(i);
		id+=obj.attr("data-id")+',';
		name+=obj.find('td').eq(2).html()+',';
	}
	$('#useid-hidden').val(id.substring(0, id.length-1));
	$('#useIds').attr('value',name.substring(0, name.length-1));
	$('#modal-info').modal('hide');
}
/* 用户群组新增-----------------end */
 
/* 用户群组编辑-----------------begin */
/* 编辑用户群组 */
function controlUseLoad(){
	var secho='1';   
	var pageStartIndex='0';
	var pageSize=1000;
	$('#secho').val(secho);
	var size=0,all=0;
	var obj = {};
	var html='',htmlItem='';
	var arr=[];
	var ids =$('#euseid-hidden').val();
	 ids.substring(0, ids.length-1);
	 arr = ids.split(',');
	$.ajax({
		type : 'POST',
		url : "${ctx}/commonSetting/userGroupSetting/getListData",
		data : JSON.stringify({
			sEcho : $.trim(secho),				
			pageStartIndex : $.trim(pageStartIndex),
			pageSize : $.trim(pageSize),
			name  : ''
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
						if(obj.aaData[i]["name"]==null){
							obj.aaData[i]["name"]=''
						}
						if(obj.aaData[i]["userNames"]==null){
							obj.aaData[i]["userNames"]=''
						}
						if(obj.aaData[i]["title"]==null){
							obj.aaData[i]["title"]=''
						}
						if(obj.aaData[i]["mobile"]==null){
							obj.aaData[i]["mobile"]=''
						}
						if(obj.aaData[i]["orderId"]==null){
							obj.aaData[i]["orderId"]=''
						}
						for(var j=0;j<arr.length;j++){
							if(obj.aaData[i]["id"]==arr[j]){
								htmlItem='<tr class="selected" data-id='+obj.aaData[i]["id"]+'><td class="text-center"><input type="checkbox" checked="checked" class="checkchild"></td>'
								+'<td>'+obj.aaData[i]["rownum"]+'</td>'
							    +'<td>'+obj.aaData[i]["name"]+'</td>'
							    +'<td>'+obj.aaData[i]["userNames"]+'</td>'
							    +'<td>'+obj.aaData[i]["orderId"]+'</td>'
							    +'</tr>';
							    size++;
								break;
							}else{
								htmlItem='<tr data-id='+obj.aaData[i]["id"]+'><td class="text-center"><input type="checkbox" class="checkchild"></td>'
								+'<td>'+obj.aaData[i]["rownum"]+'</td>'
							    +'<td>'+obj.aaData[i]["name"]+'</td>'
							    +'<td>'+obj.aaData[i]["userNames"]+'</td>'
							    +'<td>'+obj.aaData[i]["orderId"]+'</td>'
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

/* 确认选择 */
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
/* 关闭新增用户选择 */
function enodeUserCancle(){
	$('#modal-einfo').modal('hide');
}

/* 用户选择确认 */
function enodeUserOk(){
	var table=$('#euserListTable tbody');
	var id="";
	var name=""
	for(i=0;i<table.children('tr.selected').length;i++){
		var obj=table.children('tr.selected').eq(i);
		id+=obj.attr("data-id")+',';
		name+=obj.find('td').eq(2).html()+',';
	}
	$('#euseid-hidden').val(id.substring(0, id.length-1));
	$('#euseIds').attr('value',name.substring(0, name.length-1));
	$('#modal-einfo').modal('hide');
}


/* 用户群组编辑-----------------end */
</script>



</body>
</html>






