
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
				部门管理
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
					<h4>部门管理</h4>
				</div>
	
				<div class="widget-body">
					<div class="widget-main">
						<!-- <div class="add-item">
						     <label class="title"><span class="red">*</span>部门编码：</label>
						     <input class="form-control" id="depId" type="text" placeholder="请输入部门编码"/>
						  </div>
						  <hr class="tree"></hr> -->
						 <div class="add-item">
						     <label class="title"><span class="red">*</span>部门名称：</label>
						     <input class="form-control" id="depName" type="text" placeholder="请输入部门名称"/>
						     <input class="form-control" id="id-hidden" type="hidden"/>
						 </div>
						  <hr class="tree"></hr>
						  <div class="add-item">
						     <label class="title"><span class="red">*</span>上级部门：</label>
						     <select class="form-control" id="form-pDep">
							</select>
						  </div>
						   <hr class="tree"></hr>
						   <div class="add-item">
						     <label class="title">部门负责人：</label>
						     <select class="form-control" id="form-depManage">
							</select>
						  </div>
						   <hr class="tree"></hr>
						    <div class="add-item">
						     <label class="title">排序号：</label>
						     <input class="form-control" id="depIndex" type="text" placeholder="请输入排序号"/>
						  </div>
						   <hr class="tree"></hr>
						  <div class="add-item-area">
						     <label class="title">备注：</label>
						     <textarea class="form-control" id="textarea" placeholder="请输入备注"></textarea>
						  </div>
						   <hr class="tree"></hr>
						  <div class="add-item-btn" id="addBtn">
						    <a class="add-itemBtn btnOk" onclick="saveDep();">保存</a>
						    <a class="add-itemBtn btnCancle" onclick="refresh();">重置</a>
						  </div>
						  <div class="add-item-btn" id="editBtn">
						    <a class="add-itemBtn btnOk" onclick="updateDep()">保存</a>
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
	function editOpt(event, treeId, treeNode, clickFlag){
		$('#treeEdit').show();
		$('#addBtn').hide();
		$('#editBtn').show();
		clear();
		$('#id-hidden').val(treeNode.id);
		/* $('#depId').val(treeNode.code); */
		$('#depName').val(treeNode.name);
		if(treeNode.orderId!=null && treeNode.orderId!=''){
			$('#depIndex').val(treeNode.orderId);
		}
		if(treeNode.mark!=null && treeNode.mark!=''){
			$('#textarea').val(treeNode.mark);
		}
		$('#form-pDep').val(treeNode.parentId);
		if(treeNode.leaderId!=null && treeNode.leaderId!=''){
			$('#form-depManage').val(treeNode.leaderId);
		}else{
			$('#form-depManage').val('-1');
		}
		return false;
	}
	/* 编辑树 */
	function beforeEditName(treeId, treeNode) {
		$('#treeEdit').show();
		$('#addBtn').hide();
		$('#editBtn').show();
		clear();
		$('#id-hidden').val(treeNode.id);
		/* $('#depId').val(treeNode.code); */
		$('#depName').val(treeNode.name);
		if(treeNode.orderId!=null && treeNode.orderId!=''){
			$('#depIndex').val(treeNode.orderId);
		}
		if(treeNode.mark!=null && treeNode.mark!=''){
			$('#textarea').val(treeNode.mark);
		}
		$('#form-pDep').val(treeNode.parentId);
		if(treeNode.leaderId!=null && treeNode.leaderId!=''){
			$('#form-depManage').val(treeNode.leaderId);
		}else{
			$('#form-depManage').val('-1');
		}
		return false;
	}
	/* 移除树 */
	function beforeRemove(treeId, treeNode) {
		var flag=false;
		deleteDep(treeNode.id);
		return flag; 
	}
	function onRemove(e, treeId, treeNode) {
		/* deleteDep(treeNode.id); */
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
			$('#form-pDep').val(treeNode.id);
			$('#form-depManage').val('-1');
			return false;
		});  
		
	};
	$(function(){
		getTree();
		getDep();//上级部门下拉数据
		getDepManage();//获取部门负责人
	});
	//加载时获取树结构
	function getTree(){
		$.ajax({  
            url: '${ctx}/commonSetting/departmentSetting/getListData',  
            type: "post",  
            dataType: 'json',
            data: '',
            success: function (data) {  
                if(data.code == 200){  
                	$.fn.zTree.init($("#tree"), setting, data.data);
                	$.fn.zTree.getZTreeObj("tree").expandAll(true)
                   }else{  
                	   bootbox.alert('加载失败！');
                   }  
            }  
          }); 
	}
	//上级部门
	function getDep(){
		$.ajax({  
            url: '${ctx}/commonSetting/departmentSetting/getListData',  
            type: "post",  
            dataType: 'json',
            data: '',
            success: function (data) {
            	var html ='<option value="-1">请选择上级部门</option>';
                if(data.code == 200){  
                	if(data.data!=null && data.data!=''){
                	  if(data.data.length>0){
	                		for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	                		}
                		}
                	}
                	$('#form-pDep').html(html);
                   }else{  
                	   bootbox.alert('加载失败！');
                   }  
            }  
          }); 
	}
	/* 部门负责人 */
	function getDepManage(){
		$.ajax({  
	        url: '${ctx}/commonSetting/userSetting/getParent',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="-1">请选择部门负责人</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	                		}
	            		}
	            	}
	            	$('#form-depManage').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
	}
	/* 清空编辑框 */
	function clear(){
		$('#id-hidden').val('');
		/* $('#depId').val(''); */
		$('#depName').val('');
	    $('#depIndex').val('');
		$('#textarea').val('');
	}
	function refresh(){
		$('#id-hidden').val('');
		/* $('#depId').val(''); */
		$('#depName').val('');
	    $('#depIndex').val('');
		$('#textarea').val('');
		$('#form-pDep').val('-1');
		$('#form-depManage').val('-1');
	}
	/* 保存部门信息 */
	function saveDep(){
		/* var code=$('#depId').val(); */
		var code="";
		var name=$('#depName').val();
		var parentId=$("#form-pDep").val(); 
		var depManage=$("#form-depManage").val(); 
		var orderId=$('#depIndex').val();
		var mark=$('#textarea').val();
		/* if(code==''|| code==null){
			bootbox.alert('部门编码不能为空！');
			return;
		} */
		if(name==''|| name==null){
			bootbox.alert('部门名称不能为空！');
			return;
		}
		if(parentId==''|| parentId==null || parentId=='-1'){
			bootbox.alert('上级部门不能为空！');
			return;
		}
		if(depManage==null || depManage=='-1'){
			depManage='';
		}
		var flag="false";
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该部门节点?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : "${ctx}/commonSetting/departmentSetting/save",
							data : JSON.stringify({
								code : code,
								leaderId : depManage,
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
	/* 更新部门信息 */
	function updateDep(){
		var id=$('#id-hidden').val();
		/* var code=$('#depId').val(); */
		var code="";
		var name=$('#depName').val();
		var parentId=$("#form-pDep").val(); 
		var depManage=$("#form-depManage").val(); 
		var orderId=$('#depIndex').val();
		var mark=$('#textarea').val();
		/* if(code==''|| code==null){
			bootbox.alert('部门编码不能为空！');
			return;
		} */
		if(name==''|| name==null){
			bootbox.alert('部门名称不能为空！');
			return;
		}
		if(parentId==''|| parentId==null || parentId=='-1'){
			bootbox.alert('上级部门不能为空！');
			return;
		}
		if(parentId==''|| parentId==null || parentId=='-1'){
			bootbox.alert('上级部门不能为空！');
			return;
		}
		if(depManage==null || depManage=='-1'){
			depManage='';
		}
		var flag="false";
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要更新部门节点?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : "${ctx}/commonSetting/departmentSetting/update",
							data : JSON.stringify({
								id :id,
								code : code,
								leaderId : depManage,
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
	/*删除部门信息 */
	function deleteDep(id){
		var flag="false";
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要删除该部门节点?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : "${ctx}/commonSetting/departmentSetting/delete",
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






