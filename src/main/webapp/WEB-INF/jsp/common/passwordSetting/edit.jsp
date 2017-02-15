
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
			日常办公
			<small>
				<i class="icon-double-angle-right"></i>
				密码修改
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
	    <input type="hidden" id="oldFlag" value="false" />
	    <input type="hidden" id="newFlag" value="false"  />
	    <input type="hidden" id="confirmFlag" value="false" />
		<div class="pwd-reset">
		   <div class="regLine">
		        <div class="item1">原密码：</div>
		        <div class="item2"><input type="password" id="oldPwd" placeholder="请输入原密码" class="form-control" maxlength="20" onkeydown="if(event.keyCode==13){$('#newPwd').focus();}" /></div>
		        <div class="item3" style="display: none;"></div>
		        <div class="item4" style="display: block;">请输入原密码</div> 
		        <div class="item6" style="display: none;">初始密码输入错误</div> 
		        <div class="clear"></div>
		    </div>
		    <div class="regLine">
		        <div class="item1">新密码：</div>
		        <div class="item2"><input type="password" id="newPwd" placeholder="请输入新密码" class="form-control" maxlength="20" onkeydown="if(event.keyCode==13){$('#confirmPwd').focus();}" /></div>
		        <div class="item3" style="display: none;"></div>
		        <div class="item4" style="display: none;">请输入新密码</div>  
		        <div class="clear"></div>
		    </div>
		    <div class="regLine">
		        <div class="item1">确认密码：</div>
		        <div class="item2"><input type="password" id="confirmPwd" placeholder="请确认新密码" class="form-control" maxlength="20" onkeydown="if(event.keyCode==13){$('#oldPwd').focus();}" /></div>
		        <div class="item3" style="display: none;"></div>
		        <div class="item4" style="display: none;">请再次输入新密码</div>
		        <div class="item6" style="display: none;">两次输入的密码不正确</div>  
		        <div class="clear"></div>
		    </div>
		   <div class="regLine">
		      <div class="item5">
		         <a href="javascript:;" class="form-btn form-btn-pwd" onclick="updatePwd();">确定</a>
		         <a href="javascript:;" class="form-btn cancle form-btn-pwd" onclick="reset();">清空</a>
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
<script type="text/javascript">

 $(function(){
	 $('#newPwd').blur(function(){
		 checkNew();
		 
	 });
	 $('#newPwd').focus(function(){
		 $(this).parents('.regLine').find('.item3').hide(); 
		 $(this).parents('.regLine').find('.item4').hide();
	 });
	 $('#confirmPwd').blur(function(){
		 confirmPwd();
	 });
	 $('#confirmPwd').focus(function(){
		 $(this).parents('.regLine').find('.item3').hide(); 
		 $(this).parents('.regLine').find('.item4').hide();
		 $(this).parents('.regLine').find('.item6').hide();
	 });
	 $('#oldPwd').blur(function(){
		 checkOld();
	 });
	 $('#oldPwd').focus(function(){
		 $(this).parents('.regLine').find('.item3').hide(); 
		 $(this).parents('.regLine').find('.item4').hide();
		 $(this).parents('.regLine').find('.item6').hide(); 
	 });
 });
 /* 原密码 */
  function checkOld(){
	  if($('#oldPwd').val()!='' && $('#oldPwd').val()!=null){
			 var password=$.trim($('#oldPwd').val());
			 //判断原密码输入
			 validate(password);
		 }else{
			 $('#oldPwd').parents('.regLine').find('.item4').show(); 
			 $('#oldPwd').parents('.regLine').find('.item3').hide();
			 $('#oldPwd').parents('.regLine').find('.item6').hide();
			 $('#oldFlag').val('false');
		 }
  }
 /* 新密码 */
  function checkNew(){
	  if($('#newPwd').val()!='' && $('#newPwd').val()!=null){
		  $('#newPwd').parents('.regLine').find('.item3').show(); 
		  $('#newPwd').parents('.regLine').find('.item4').hide();
		  $('#newFlag').val('true');
		 }else{
			 $('#newPwd').parents('.regLine').find('.item4').show();
			 $('#newFlag').val('false');
		 }
  }
 /* 确认新密码 */
  function confirmPwd(){
	  if($('#confirmPwd').val()!='' && $('#confirmPwd').val()!=null){
			 if($.trim($('#confirmPwd').val())==$.trim($('#newPwd').val())){
				 $('#confirmPwd').parents('.regLine').find('.item3').show(); 
				 $('#confirmPwd').parents('.regLine').find('.item4').hide();
				 $('#confirmPwd').parents('.regLine').find('.item6').hide();
				 $('#confirmFlag').val('true');
			 }else{
				 $('#confirmPwd').parents('.regLine').find('.item6').show(); 
				 $('#confirmPwd').parents('.regLine').find('.item3').hide();
				 $('#confirmPwd').parents('.regLine').find('.item4').hide();
				 $('#confirmFlag').val('false');
			 }
			 
		 }else{
			 $('#confirmPwd').parents('.regLine').find('.item4').show(); 
			 $('#confirmPwd').parents('.regLine').find('.item3').hide();
			 $('#confirmPwd').parents('.regLine').find('.item6').hide();
			 $('#confirmFlag').val('false');
		 }
  }
  //判断原密码输入
  function validate(password){
	  $.ajax({
			type : 'GET',
			url : "${ctx}/common/passwordSetting/validateOldPassword/"+password,
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					 $('#oldPwd').parents('.regLine').find('.item3').show(); 
					 $('#oldPwd').parents('.regLine').find('.item4').hide();
					 $('#oldPwd').parents('.regLine').find('.item6').hide();
					 $('#oldFlag').val('true');
				} else {
					$('#oldPwd').parents('.regLine').find('.item6').show(); 
					$('#oldPwd').parents('.regLine').find('.item3').hide();
					$('#oldPwd').parents('.regLine').find('.item4').hide();
					$('#oldFlag').val('false');
				}
			}
			
		}); 
  }
  /* 密码修改 */
  function updatePwd(){
	  var newPwd=$('#newPwd').val();
	  var oldPwd=$('#oldPwd').val();
	  if($('#oldFlag').val()=="true" && $('#newFlag').val()=="true" && $('#confirmFlag').val()=="true"){
		  bootbox.confirm({ 
			  size: "small",
			  message: "确定要修改密码?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : '${ctx}/common/passwordSetting/update',
							data : JSON.stringify({
								oldPassword : oldPwd,
								password : newPwd
							}),
							contentType : "application/json;charset=UTF-8",
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {
									bootbox.alert('密码修改成功！');
									reset();
								} else {
									bootbox.alert(data.msg);
								}
								
							}
							
						});
				  }
			  }
			});
	  }
	  else{
		  checkOld();
		  checkNew();
		  confirmPwd();
	  }
	  
  }

  /* 重置文本框 */
  
  function reset(){
	  $('#oldPwd').val('');
	  $('#newPwd').val('');
	  $('#confirmPwd').val('');
	  $('#oldPwd').parents('.regLine').find('.item4').show();
	  $('#oldPwd').parents('.regLine').find('.item3').hide();
	  $('#oldPwd').parents('.regLine').find('.item6').hide();
	  $('#confirmPwd').parents('.regLine').find('.item3').hide();
	  $('#confirmPwd').parents('.regLine').find('.item4').hide();
	  $('#confirmPwd').parents('.regLine').find('.item6').hide();
	  $('#newPwd').parents('.regLine').find('.item3').hide();
	  $('#newPwd').parents('.regLine').find('.item4').hide();
  }
</script>



</body>
</html>






