

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
		  .main{width:550px;height:350px;margin:10% auto 0;position:relative;}
		  .backIndex{width:150px;height:32px;display:inline-block;line-height:32px;font-size: 16px;font-family:"Microsoft YaHei";text-decoration: none;border:1px solid #e0a138;color: #e0a138;text-align: center;border-radius: 3px;cursor:pointer;position: absolute;bottom: 35px;left:90px;}
		  .backIndex:hover{text-decoration: underline;}
		</style>
	</head>
	<body>
		<div class="main">
		  <img src="${ctx}/staticPublic/images/500.png" />
		  <a class="backIndex" href="javascript:;" onclick="refresh();">返回首页</a>
		</div>
		
		<script type="text/javascript">
  			function refresh(){
  				location.href="${ctx}/index";
  			}
        </script>
	</body>
</html>

