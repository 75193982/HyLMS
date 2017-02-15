 
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
	    <link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
		<!-- page specific plugin styles -->
		<!-- ace styles -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" />
		<!-- inline styles related to this page -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/staticPublic/themes/default/easyui.css"></link>
		<link rel="stylesheet" type="text/css" href="${ctx}/staticPublic/themes/icon.css"></link>
		<link rel="stylesheet" href="${ctx}/staticPublic/css/datetimepicker.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
	</head>
<body class="white-bg">
	<div class="page-content">
		<div class="page-header">
			<h1>
				日常办公
				<small>
					<i class="icon-double-angle-right"></i>
					工资发放
				</small>
			</h1>
		</div><!-- /.page-header -->
	  <div class="detailInfo p5">
		   <!-- 明细Grid------begin-->
	      <table class="easyui-datagrid" id="mytable" style="width:100%;height:600px" data-options="fitColumns:true,singleSelect:true,rownumbers:true">   
			    <thead>   
			        <tr>    
			            <th data-options="field:'salaryTime',width:'12%',align:'center'">工资归属时间</th>
			            <th data-options="field:'userName',width:'10%',align:'center'">用户名</th>   
			            <th data-options="field:'departmentName',width:'12%',align:'center'">部门</th> 
			            <th data-options="field:'dutyName',width:'10%',align:'center'">岗位</th>
			            <th data-options="field:'basicSalary',width:'10%',align:'center'">基本工资</th>
			            <th data-options="field:'allowanceDistance',width:'10%',align:'center'">里程数(公里)</th>
			            <th data-options="field:'allowanceAmount',width:'10%',align:'center'">补助合计</th>
			            <th data-options="field:'fineAmount',width:'11%',align:'center'">罚扣合计</th>
			            <th data-options="field:'amount',width:'11%',align:'center'">应发合计  </th>    
			        </tr>   
			    </thead>  
			</table>
	     <!-- 明细Grid------end-->
	  </div>
  </div>

<script src="${ctx}/staticPublic/js/jquery-2.0.3.min.js"></script>
<script src="${ctx}/staticPublic/js/easyUI/jquery.easyui.min.js"></script>
<script src="${ctx}/staticPublic/js/easyUI/easyui-lang-zh_CN.js"></script> 
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script> 
<script src="${ctx}/staticPublic/js/easyUI/keyCheckByCode.js"></script>
<script src="${ctx}/staticPublic/js/easyUI/rownumber-util.js"></script> 
<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
<script src="${ctx}/staticPublic/js/bootbox.min.js"></script>
<script src="${ctx}/staticPublic/js/jsonDataFormat.js"></script>
<script src="${ctx}/staticPublic/js/easyUI/setnumcolor.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
	$(function(){
		init();
	});
	
  /* 初始加载 */
  function init(){
	  var driverFlag="${driverFlag}";
	  var userId='${sessionScope.LMS_USER.id}';
	  $.ajax({
			type : 'GET',
			url : "${ctx}/financeManage/salaryPay/getLogs/"+userId,
			data : '',
			dataType : 'JSON',
			success: function(data){
				if (data && data.code == 200){
					if(data.data!=null && data.data!=''){
						$('#mytable').datagrid('loadData',{"total" : data.data.length,"rows" : data.data});
					}else{
						 $('#mytable').datagrid('loadData', { total: 0, rows: [] }); 
					}
				}else{
					bootbox.alert(data.msg);
				}
			}
	  });
  }
 
    </script> 
 </body>
</html>


