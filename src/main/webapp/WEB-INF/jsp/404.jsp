

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
		<script type="text/javascript" src="${ctx}/staticPublic/js/jquery-1.9.1.min.js"></script>
		<style type="text/css">
		  .main{width:530px;height:300px;margin:10% auto 0;}
		  .main_left{height:300px;float:left;}
		  .main_right{height:300px;float:right;letter-spacing: 1px;}
		  .main_right .t1{height: 45px;line-height: 45px;color: #666666;font-weight: 600;font-family:"Microsoft YaHei";font-size: 22px;}
		  .main_right .t2{font-size: 14px;height: 20px;line-height: 20px;color: #999999;font-family:"Microsoft YaHei";}
		  .main_right .t3>a{width:105px;height:25px;display:inline-block;line-height:25px;font-size: 14px;font-family:"Microsoft YaHei";text-decoration: none;border:1px solid #ababab;color: #666666;text-align: center;border-radius: 3px;cursor:pointer;}
		  .main_right .t3>a:hover{text-decoration: underline;} 
		</style>
	</head>
	<body>
		<div class="main">
		   <div class="main_left"><img src="${ctx}/staticPublic/images/404.png" /></div>
		   <div class="main_right">
		      <p class="t1">Sorry 您访问的页面不存在</p>
		      <p class="t2">您可以尝试刷新一下</p>
		      <p class="t3"><a href="javascript:;" onclick="refresh();">回到首页 >></a></p>
		   </div>
		</div>
		
		<script type="text/javascript">
  			function refresh(){
  				parent.location.reload();
  			}
        </script>
	</body>
</html>

