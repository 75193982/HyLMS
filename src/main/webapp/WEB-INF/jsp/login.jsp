
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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=no"/>
<meta name="renderer" content="webkit|ie-comp|ie-stand" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/Confirm.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/jquery-ui-1.10.3.full.min.css" />
<script type="text/javascript" src="${ctx}/staticPublic/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${ctx}/staticPublic/js/jquery.cookie.js"></script>
<script type="text/javascript" src="${ctx}/staticPublic/js/popbox/Confirm.js"></script>
<script type="text/javascript" src="${ctx}/staticPublic/js/ace.min.js"></script>
<script type="text/javascript" src="${ctx}/staticPublic/js/jquery-ui-1.10.3.full.min.js"></script>
<title>登录</title>
<style type="text/css">
ul,li{margin:0; padding:0; list-sytle:none;}
.login_b .name_list{position:absolute;top:120px;left:110px;border:1px solid #fff;width:305px;height:200px;background:#fff;overflow-x:hidden;z-index:999;padding-top:15px;border-radius:3px;display:none;font-family: "microsoft yahei";}
.login_b .name_list li{width: 305px;height:29px;line-height:28px;font-size:14px;border-bottom:1px dashed #ddd;}
.login_b .name_list li>a{width:305px;padding:0px 15px;height:100%;display: inline-block;}
.login_b .name_list li:hover{border-bottom:1px dashed #fff;}
.login_b .name_list li>a:hover{background:#82C8BF;color:#fff;}
#mobile{cursor:pointer;}
</style>
</head>
 <body class="login-layout green-login">
		<div class="main-container login-main-container">
			<div class="main-content">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1">
							<div class="position-relative">
								<div class="login_submit">
								   <div class="login_submitMain">
								   	 <div>
								   	    <div class="form-control login_b">
								   	       <label>用户名</label>								   	       
								           <input type="text" id="mobile" class="form-control" placeholder="请输入登录账号" />
										  <div class="name_list">
											<ul></ul>
										</div>
										<!-- <div class="space-4"></div> -->
								   	    </div>
								     </div>
								     <p id="nameError"></p>
								     <div>
								        <div class="form-control login_b">
								          <label>密&nbsp;码</label>
								           <input type="password" id="password" class="form-control" placeholder="请输入密码" />
								        </div>
								        <p id="pwdError"></p>
								     </div>
								     <div>
								          <a class="login_on_btn" onclick="login()">登录</a>
								     </div>
								   </div>
								 
								</div>						
							</div><!-- /.position-relative -->
					</div><!-- /.col10 -->
				</div><!-- /.row -->
			</div><!-- /.main-content -->
		</div><!-- /.main-container -->
		<p class="footer_Area">Copyright © 2016 江苏华普软件有限公司 版权所有 </p>
 <script type="text/javascript">
 var namelist="";
 $(function(){	 
	 //console.info('${LMS_USER.mobile}');
	/* if('${LMS_USER.mobile}'!=''){
		$('#mobile').val('${LMS_USER.mobile}');
	} */
	var list=null;
	 if($.cookie('mobile')!=null&&$.cookie('mobile').split(';').length>0){
		 list=$.cookie('mobile').split(';');
		 //console.info(JSON.stringify(list));
		 $( "#mobile" ).val($.cookie('mobile').split(';')[0]);
	} 
	if(list!=null){
		var name=[];
		var html="";
		for (i = 0; i < list.length; i++) {							
			html+="<li><a href='javascript:;' id='name_"+i+"' onclick='checkname(this,"+i+")'>"+list[i]+"</a></li>"
			name.push(list[i]);
		}
		$('.name_list ul').append(html);
		namelist=name;
		/*  $( "#mobile" ).autocomplete({
				source: list
			}); */
	}			  				
	//$.cookie('mobile');
	})
	
		//账户选择,预防注入
	function checkname(e,index){
		$('#mobile').val(namelist[index]);
		$('.name_list').hide();
	}
	//判断是否是name的点击事件，即非input区域下拉失效
	$(document).on('click', function(e) {
		  var e = e || window.event; //浏览器兼容性
		  var elem = e.target || e.srcElement;
		  while (elem) {
		    //循环判断至选择的节点
		    if (elem.id && elem.id == 'mobile' &&$.cookie('mobile')!=''&&$.cookie('mobile')!=null) {
		    	$('.name_list').show();
		    	return;
		    }else{
		    	  $('.name_list').hide();
		    	  return;
		    } 
		  }
		});
	function login() {
		if($('#mobile').val()==''&& $('#password').val()!=''){
    		$('#nameError').html('用户名不能为空！');
    		$('#pwdError').html('');
    	}else if($('#password').val()=='' && $('#mobile').val()!=''){
    		$('#pwdError').html('密码不能为空！');
    		$('#nameError').html('');
    	}else if($('#password').val()=='' && $('#mobile').val()==''){
    		$('#pwdError').html('密码不能为空！');
    		$('#nameError').html('用户名不能为空！');
    	}else{
    		$('#nameError').html('');
    		$('#pwdError').html('');
    		$.ajax({
    			type : 'POST',
    			url : "${ctx}/validate",
    			data : JSON.stringify({
    				mobile : $.trim($('#mobile').val()),				
    				password : $.trim($('#password').val())
    			}),
    			contentType : "application/json;charset=UTF-8",
    			dataType : 'JSON',
    			success : function(data) {
    				if (data && data.code == 200) {
    					//setCookie('mobile',$.trim($('#mobile').val()));
    					var mobile='';
    					if($.cookie('mobile')!=null&&$.cookie('mobile')!=undefined&&$.cookie('mobile')!=''){
    						//console.info($.cookie('mobile').indexOf($('#mobile').val()));
    						if($.cookie('mobile').indexOf($('#mobile').val())==-1){
    							 mobile=$.cookie('mobile')+";"+$.trim($('#mobile').val());
    						}else{
    							mobile=$.cookie('mobile');
    						}    						
    					}else{
    						mobile=$.trim($('#mobile').val());
    					}
    					$.cookie('mobile', mobile);
    					location.href = '${ctx}/index';
    				} else {
    					$.Confirm(data.msg,$.Confirm.typeEnum.warning);
    				}
    				
    			}
    		});
    	}
		
	}
	$('#password').keydown(function (e) {
        if (e.keyCode == 13) {
          login();
        }
    });
	
	
	  				
	  			

</script>
</body>
</html>






