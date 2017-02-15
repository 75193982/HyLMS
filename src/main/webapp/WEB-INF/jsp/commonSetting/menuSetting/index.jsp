
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
				菜单管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="content_wrap">
		<div class="zTreeDemoBackground left">
			<ul id="tree" class="ztree"></ul>
		</div>
		<div class="tree-right" id="treeEdit">
		  <div class="widget-box">
				<div class="widget-header">
					<h4>菜单管理</h4>
				</div>
	
				<div class="widget-body">
					<div class="widget-main">
						 <div class="add-item">
						     <label class="title"><span class="red">*</span>菜单名称：</label>
						     <input class="form-control" id="roleName" type="text" placeholder="请输入菜单名称"/>
						     <input class="form-control" id="id-hidden" type="hidden"/>
						 </div>
						  <hr class="tree"></hr>
						  <div class="add-item">
						     <label class="title"><span class="red">*</span>url地址：</label>
						     <input class="form-control" id="roleUrl" type="text" placeholder="请输入url地址"/>
						 </div>
						  <hr class="tree"></hr>
						  <div class="add-item">
						     <label class="title"><span class="red">*</span>上级菜单：</label>
						     <input id="form-pRole" type="text" readonly="readonly" value="" class="form-control" onclick="showMenu();" placeholder="请选择上级菜单" data-parentId="" data-flag="false"/>
						  </div>
						  <div id="menuContent" class="menuContent" style="display:none; position: absolute;z-index: 999;width: 280px;background:#fff;border:1px solid #ddd;">
							 <ul id="treeMenu" class="ztree" style="margin:auto; width:98%; height: 300px;"></ul>
						   </div>
						   <hr class="tree"></hr>
						   <div class="add-item">
						     <label class="title">排序号：</label>
						     <input class="form-control" id="roleIndex" type="text" placeholder="请输入排序号"/>
						  </div>
						   <hr class="tree"></hr>
						   <div class="add-item">
						     <label class="title">备注：</label>
						     <input class="form-control" id="mark" type="text" placeholder="请输入备注"/>
						  </div>
						   <hr class="tree"></hr>
						  <div class="add-item-btn" id="addBtn">
						    <a class="add-itemBtn btnOk" onclick="saveRole();">保存</a>
						    <a class="add-itemBtn btnCancle" onclick="refresh();">重置</a>
						  </div>
						  <div class="add-item-btn" id="editBtn">
						    <a class="add-itemBtn btnOk" onclick="updateRole()">保存</a>
						    <a class="add-itemBtn btnCancle" onclick="refresh()">重置</a>
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
<script type="text/javascript" src="${ctx}/staticPublic/js/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${ctx}/staticPublic/js/ztree/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="${ctx}/staticPublic/js/ztree/jquery.ztree.exedit.js"></script>
<script type="text/javascript">

var setting = {
		view: {
			addHoverDom: addHoverDom,
			removeHoverDom: removeHoverDom,
			selectedMulti: false
		},
		edit: {
			enable: true
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onClick:editOpt,
			beforeEditName: beforeEditName,
			beforeRemove: beforeRemove
		}
	};
var settingMenu = {
		view: {
			dblClickExpand: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onClick: onClick
		}
	};

	function editOpt(event, treeId, treeNode, clickFlag){
		$('#treeEdit').show();
		$('#addBtn').hide();
		$('#editBtn').show();
		clear();
		$('#id-hidden').val(treeNode.id);
		$('#roleUrl').val(treeNode.url);
		$('#roleName').val(treeNode.name);
		$('#mark').val(treeNode.mark);
		if(treeNode.orderId!=null && treeNode.orderId!=''){
			$('#roleIndex').val(treeNode.orderId);
		}
		var zTreeMenu=$.fn.zTree.getZTreeObj("treeMenu");
		var nodeMenu=zTreeMenu.getNodeByParam('id',treeNode.parentId);
		zTreeMenu.selectNode(nodeMenu);
		$('#form-pRole').val(treeNode.parentName);
		$('#form-pRole').attr('data-parentId',treeNode.parentId);
		return false;
	}
	/* 编辑树 */
	function beforeEditName(treeId, treeNode) {
		$('#treeEdit').show();
		$('#addBtn').hide();
		$('#editBtn').show();
		clear();
		$('#id-hidden').val(treeNode.id);
		$('#roleUrl').val(treeNode.url);
		$('#roleName').val(treeNode.name);
		$('#mark').val(treeNode.mark);
		if(treeNode.orderId!=null && treeNode.orderId!=''){
			$('#roleIndex').val(treeNode.orderId);
		}
		var zTreeMenu=$.fn.zTree.getZTreeObj("treeMenu");
		var nodeMenu=zTreeMenu.getNodeByParam('id',treeNode.parentId);
		zTreeMenu.selectNode(nodeMenu);
		$('#form-pRole').val(treeNode.parentName);
		$('#form-pRole').attr('data-parentId',treeNode.parentId);
		return false;
	}
	/* 移除树 */
	function beforeRemove(treeId, treeNode) {
		var flag=false;
		deleteRole(treeNode.id);
		return flag; 
	}
	/* 删除节点 */
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};
	/* 新增节点 */
	function addHoverDom(treeId, treeNode) {
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
		var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
			+ "' title='add node' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		var btn = $("#addBtn_"+treeNode.tId);
		if (btn) btn.bind("click", function(){
			clear();
			$('#treeEdit').show();
			$('#addBtn').show();
			$('#editBtn').hide();
			var zTreeMenu=$.fn.zTree.getZTreeObj("treeMenu");
			var nodeMenu=zTreeMenu.getNodeByParam('id',treeNode.id);
			zTreeMenu.selectNode(nodeMenu);
			$('#form-pRole').val(treeNode.name);
			$('#form-pRole').attr('data-parentId',treeNode.id);
			return false;
		});  
		
	};
	/* 上级部门树 begin */
	function onClick(e, treeId, treeNode) {
		 var cityObj = $("#form-pRole");
	     var zTree = $.fn.zTree.getZTreeObj("treeMenu"),
	     nodeMenuItem = zTree.getSelectedNodes();
	     var vName="",parentId="";
	     if(nodeMenuItem!=null && nodeMenuItem.length>0){
	    	 vName=nodeMenuItem[0].name;
			 parentId=nodeMenuItem[0].id; 
	     }
		 cityObj.val(vName);
		 cityObj.attr("data-parentId", parentId);
		 hideMenu();
		 cityObj.attr("data-flag", "false");
			
		}

		function showMenu() {
			var cityObj = $("#form-pRole");
			if(cityObj.attr("data-flag")=='false'){
				var cityObj = $("#form-pRole");
				var cityOffset = $("#form-pRole").offset();
				$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
				cityObj.attr("data-flag", "true");
				$("body").bind("mousedown", onBodyDown);
			}else{
				hideMenu();
				cityObj.attr("data-flag", "false");
			}
			
		}
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "form-pRole" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
	
	/* 上级部门树 end */
	$(function(){
		getTree();
		getRole();//上级部门下拉数据
	});
	//加载时获取树结构
	function getTree(){
		$.ajax({  
            url: '${ctx}/commonSetting/menuSetting/getListData',  
            type: "post",  
            dataType: 'json',
            data: '',
            success: function (data) {  
                if(data.code == 200){  
                	$.fn.zTree.init($("#tree"), setting, data.data);
                	$.fn.zTree.getZTreeObj("tree").expandAll(true);
                   }else{  
                	   bootbox.alert('加载失败！');
                   }  
            }  
          }); 
	}
	//加载部门树结构
	function getRole(){
		var objs=[];
		$.ajax({  
            url: '${ctx}/commonSetting/menuSetting/getListData',  
            type: "post",  
            dataType: 'json',
            data: '',
            success: function (data) {  
                if(data.code == 200){
                	for(var i=0;i<data.data.length;i++){
                		var obj={};
                		obj.id=data.data[i]['id'];
                		obj.name=data.data[i]['name'];
                		obj.parentId=data.data[i]['parentId'];
                		objs.push(obj);
                		
                	}
                	$.fn.zTree.init($("#treeMenu"), settingMenu, objs);
                	$.fn.zTree.getZTreeObj("treeMenu").expandAll(true);
                   }else{  
                	   bootbox.alert('加载失败！');
                   }  
            }  
          }); 
	}
	
	/* 清空编辑框 */
	function clear(){
		$('#id-hidden').val('');
		$('#roleUrl').val('');
		$('#roleName').val('');
	    $('#roleIndex').val('');
	    $('#mark').val('');
		$('#form-pRole').val('');
		$('#form-pRole').attr('data-parentId','');
		$('#form-pRole').attr('data-flag','false');
	}
	function refresh(){
		$('#id-hidden').val('');
		$('#roleUrl').val('');
		$('#roleName').val('');
	    $('#roleIndex').val('');
	    $('#mark').val('');
		$('#form-pRole').val('');
		$('#form-pRole').attr('data-parentId','');
		$('#form-pRole').attr('data-flag','false');
	}
	/* 保存菜单信息 */
	function saveRole(){
		var url=$('#roleUrl').val();
		var name=$('#roleName').val();
		var parentId=$('#form-pRole').attr('data-parentId'); 
		var orderId=$('#roleIndex').val();
		var mark=$('#mark').val();
		if(name==''|| name==null){
			bootbox.alert('菜单名称不能为空！');
			return;
		}
		if(url==''|| url==null){
			bootbox.alert('URL不能为空！');
			return;
		}
		if(parentId==''|| parentId==null || parentId=='-1'){
			bootbox.alert('上级菜单不能为空！');
			return;
		}
		var flag="false";
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该菜单节点?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : "${ctx}/commonSetting/menuSetting/save",
							data : JSON.stringify({
								url : url,				
								name : name,
								parentId : parentId,
								orderId : orderId,
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
	/* 更新菜单信息 */
	function updateRole(){
		var id=$('#id-hidden').val();
		var url=$('#roleUrl').val();
		var name=$('#roleName').val();
		var parentId=$('#form-pRole').attr('data-parentId'); 
		var orderId=$('#roleIndex').val();
		var mark=$('#mark').val();
		if(name==''|| name==null){
			bootbox.alert('菜单名称不能为空！');
			return;
		}
		if(url==''|| url==null){
			bootbox.alert('URL不能为空！');
			return;
		}
		if(parentId==''|| parentId==null || parentId=='-1'){
			bootbox.alert('上级菜单不能为空！');
			return;
		}
		var flag="false";
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要更新该菜单节点?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : "${ctx}/commonSetting/menuSetting/update",
							data : JSON.stringify({
								id :id,
								url : url,				
								name : name,
								parentId : parentId,
								orderId : orderId,
								mark : mark
							}),
							contentType : "application/json;charset=UTF-8",
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {
									/* getTree();
									clear();
									$('#treeEdit').hide(); */
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
	/*删除菜单信息 */
	function deleteRole(id){
		var flag="false";
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要删除该菜单节点?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : "${ctx}/commonSetting/menuSetting/delete",
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
		
	}
</script>
</body>
</html>






