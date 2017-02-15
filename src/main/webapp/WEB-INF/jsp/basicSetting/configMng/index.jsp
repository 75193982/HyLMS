
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
			基础信息管理
			<small>
				<i class="icon-double-angle-right"></i>
				全局配置管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="pwd-reset">
		   <div class="line">
			   <fieldset id="configItem1">
				    <legend class="legcss">快速调度是否使用流程</legend>
				    <div class="configInfo">
				      <label class="zicss"><input name="firstConfig" id="firstConfigY" type="radio" class="radioConfig" value="Y" /><span>使用</span></label>
				   	  <label class="zicss"><input name="firstConfig" id="firstConfigN" type="radio" class="radioConfig" value="N" /><span>不使用</span></label>
				   	</div>
				   	<a href="javascript:;" class="form-btn form-btn-config" onclick="save();">保存</a> 
				</fieldset>
				<fieldset id="configItem1">
				    <legend class="legcss">驾驶员的里程补贴配置</legend>
				    <div class="configInfo">
					    <label class="title">里程下限(公里)：</label>
					    <input id="distance" class="form-box mul-form-box" type="text" placeholder="请输入里程下限" />
					    <label class="title">里程单价(元)：</label>
					    <input id="price" class="form-box mul-form-box" type="text" placeholder="请输入里程单价" />
					</div>
				   	<a href="javascript:;" class="form-btn form-btn-config" onclick="saveDistance();">保存</a>
				   	<div class="both"></div>
				</fieldset>
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
<script type="text/javascript">

 $(function(){
    var flag='${fastScheduleUseProcess}';
    var distance='${distance}';
    var price='${price}';
    if(flag=='Y'){
    	$('#firstConfigY').prop('checked','true');
    }else{
    	$('#firstConfigN').prop('checked','true');
    }
    $('#distance').val(distance);
    $('#price').val(price);
 });
 
  /* 全局配置保存*/
  function save(){
	     var flag="false";
	     var fastScheduleUseProcess=$('#configItem1 input[name="firstConfig"]:checked').val();
		  bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : '${ctx}/basicSetting/configMng/save',
							data : JSON.stringify({
								fastScheduleUseProcess : fastScheduleUseProcess
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
  /* 保存驾驶员的里程补贴配置 */
  function saveDistance(){
	     var flag="false";
	     var distance=$('#distance').val();
	     var price=$('#price').val();
		  bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : '${ctx}/basicSetting/configMng/saveForDriverDistance',
							data : JSON.stringify({
								distance : distance,
								price :price
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
</script>



</body>
</html>






