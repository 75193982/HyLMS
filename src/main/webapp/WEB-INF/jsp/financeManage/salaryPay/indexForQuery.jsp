 
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
				查询管理
				<small>
					<i class="icon-double-angle-right"></i>
					工资发放查询
				</small>
			</h1>
		</div><!-- /.page-header -->
	  <div class="detailInfo p5">
	     <div class="searchbox col-xs-12">
               <label class="title" style="float: left;height: 34px;line-height: 34px;">工资归属时间：</label>
			    <div class="input-group input-group-sm" style="float: left;width: 234px;height:34px;margin-right:30px; margin-left: 5px;">
					<input class="form-control" id="startTime" type="text" placeholder="工资归属时间" style="height: 34px;font-size: 14px;"/>
						<span class="input-group-addon">
							<i class="icon-calendar"></i>
						</span>
				</div>
		        <a class="itemBtn" id="openSchedule" onclick="searchInfo()">查询</a>
				<a class="itemBtn" id="printSchedule" onclick="printInfo()">打印汇总</a>
				<a class="itemBtn" id="printSchedule" onclick="printDetailInfo()">打印明细</a>
				<a class="itemBtn" id="printSchedule" onclick="doexport()">导出汇总</a>
				<a class="itemBtn" id="printSchedule" onclick="exportDetail()">导出明细</a>
		       <div class="clear"></div>
		   </div>
		   <!-- 明细Grid------begin-->
		   <div class="col-xs-12"></div>
	      <table  style="width:100%;height:450px;min-height:450px;min-width:1300px;" >
			<tr>
				<td width="35%">
					<table class="easyui-datagrid" id="dg1" style="width:100%;height:100%" data-options="fitColumns:true,singleSelect:true,onLoadSuccess:onLoadSuccess,onClickRow:getDetail">   
					    <thead>   
					        <tr>  
					            <th data-options="field:'salaryTime',width:'20%',align:'center'">工资归属时间</th>   
					            <th data-options="field:'userCount',width:'11%',align:'center'">人数</th>
					            <th data-options="field:'amount',width:'17%',align:'center'">发放总金额</th>  
					            <th data-options="field:'status',width:'12%',align:'center',formatter:formatterStaus">状态</th>   
					            <th data-options="field:'updateTime',width:'28%',align:'center'">操作时间</th> 
					            <th data-options="field:'updateUserName',width:'12%',align:'center'">操作人</th> 
					        </tr>   
					    </thead>   
					</table> 
				</td>
				<td width="65%">
				   <table class="easyui-datagrid" id="dg2" style="width:100%;height:100%" data-options="fitColumns:true,singleSelect:true,rownumbers:true">   
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
				  </td>
				</tr>
			</table>
	     <!-- 明细Grid------end-->
	  </div>
	 <!-- 打印模板   begin-->
	<div class="printTable" id="printTable">
	     <div id="print-content" class="printcenter">
				<div id="headerInfo">
					<h2>工资汇总单</h2>
					<p id="localTime" style="text-align: right;"></p>
				</div>
				  <table id="myDataTable" class="table myDataTable">
				    <thead>
				      <tr>
				            <th>工资归属时间</th>   
				            <th>人数</th>
				            <th>发放总金额</th>  
				            <th>状态</th>   
				            <th>操作时间</th>
				            <th>操作人</th> 
				      </tr>
				    </thead>
				    <tbody>
				    </tbody>
				  </table>
				  
			  <div id="footerInfo">
			     <h3>盐城辉宇物流有限公司  制</h3>
			  </div>
		  </div>
	</div>

	<!-- 打印模板   end-->
	<!-- 打印模板明细   begin-->
	<div class="printTable" id="printTableDetail">
	     <div id="print-contentDetail" class="printcenter">
				<div id="headerInfo1">
					<h2>工资明细单</h2>
					<p id="localTimeDetail" style="text-align: right;"></p>
				</div>
				  <table id="myDataTable-detail" class="table myDataTable" style="border-top:1px solid #000;">
				    <thead>
				      <tr>
				            <th>工资归属时间</th>
				            <th>用户名</th>   
				            <th>部门</th> 
				            <th>岗位</th>  
				            <th>基本工资</th>
				            <th>里程数(公里)</th>
				            <th>补助合计</th>
				            <th>罚扣合计</th>
				            <th>应发合计</th>  
				      </tr>
				    </thead>
				    <tbody>
				    </tbody>
				  </table>
				  
			  <div id="footerInfo1">
			     <h3>盐城辉宇物流有限公司  制</h3>
			  </div>
		  </div>
	</div>

	<!-- 打印模板明细   end-->
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
		$("#startTime").datetimepicker({
			language: 'cn',
	        format: 'yyyy-mm',
	        weekStart: 1,  
            autoclose: true,  
            startView: 3,  
            minView: 3,  
            forceParse: false
	    });
		searchInfo();
	});
	
	/* 工资归属时间 */
	function formatterMonth(val,row,index){
		if(val!=null && val!=''){
			return jsonForDateMonthFormat(val);
		}else{
			return '';
		}
	}
	/* 状态 */
	function formatterStaus(val,row,index){
		if(val=='0'){
			return '新建';
		}else if(val=='1'){
			return '发放';
		}else{
			return val;
		}
	}
	/* 插入时间 */
	function formatterTime(val,row,index){
		if(val!=null && val!=''){
			return jsonDateFormat(val);
		}else{
			return '';
		}
	}
	
	/* 添加合计 */
	function onLoadSuccess() {
	    var rows = $('#dg1').datagrid('getRows');
	    if(rows.length>0){
	    	  $('#dg1').datagrid('appendRow', {
	    		  salaryTime: '<span class="subtotal">合计</span>',
	    		  amount: '<span class="subtotal">' + compute("amount") + '</span>'
	    	    });
	    	  $('#dg1').datagrid('mergeCells',{
	    	        index:rows.length-1,
	    	        field:'status',
	    	        colspan:3

	    	    });
	    	  
	    }
	  
	}
	//指定列求和
	function compute(colName) {
	    var rows = $('#dg1').datagrid('getRows');
	    var total = 0;
	    for (var i = 0; i < rows.length; i++) {
	        total += parseFloat(rows[i][colName]);
	    }
	    return total.toFixed(2);
	    
	}
	/* 加载详细信息 */
	function getDetail(index, data) {
		  var id=data.id;
		  $.ajax({
				type : 'GET',
				url : "${ctx}/financeManage/salaryPay/getDetailData/"+id,
				data : '',
				dataType : 'JSON',
				success: function(data){
					if (data && data.code == 200){
						if(data.data.detailList!=null && data.data.detailList!=''){
							$('#dg2').datagrid('loadData',{"total" : data.data.detailList.length,"rows" : data.data.detailList});
						}
						
					}else{
						$('#dg2').datagrid('loadData', { total: 0, rows: [] }); 
					}
				}
		  });
  }
  /* 查询 */
  function searchInfo(){
	  var salaryTime=$('#startTime').val();
	  var driverFlag='N';
	  $.ajax({
			type : 'POST',
			url : "${ctx}/financeManage/salaryPay/getAllListData",
			data : JSON.stringify({
				salaryTime :salaryTime,
				driverFlag:driverFlag
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success: function(data){
				if (data && data.code == 200){
					if(data.data!=null && data.data!=''){
						for(var i=0;i<data.data.length;i++){
							if(data.data[i]["updateTime"]!=null && data.data[i]["updateTime"]!=''){
								data.data[i]["updateTime"]=jsonDateFormat(data.data[i]["updateTime"]);
							}else{
								data.data[i]["updateTime"]='';
							}
						}
						$('#dg1').datagrid('loadData',{"total" : data.data.length,"rows" : data.data});
						$('#dg2').datagrid('loadData',{"total" : 0,"rows" :[]});
					}else{
						$('#dg1').datagrid('loadData',{"total" : 0,"rows" :[]});
						$('#dg2').datagrid('loadData',{"total" : 0,"rows" :[]});
					}
				
				}
			}
	  });
  }
	
	/* grid end */
	

   /* 打印功能 */
   function printInfo(){
	   var driverFlag='N';
	   var date = new Date();
       var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
       var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
       var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
       var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
       var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
       var localTime= date.getFullYear() + "-" + month + "-" + day+ " " + hours + ":" + minutes + ":" + seconds;
       $('#localTime').html(localTime);
       var salaryTime=$('#startTime').val();
       var html="";
 	  $.ajax({
 			type : 'POST',
 			url : "${ctx}/financeManage/salaryPay/getAllListData",
 			data : JSON.stringify({
 				salaryTime :salaryTime,
 				driverFlag:driverFlag
 			}),
 			contentType : "application/json;charset=UTF-8",
 			dataType : 'JSON',
 			success: function(data){
 				if (data && data.code == 200){
 					if(data.data!=null && data.data!=''){
 						for(var i=0;i<data.data.length;i++){
 							if(data.data[i]["updateTime"]!=null && data.data[i]["updateTime"]!=''){
 								data.data[i]["updateTime"]=jsonDateFormat(data.data[i]["updateTime"]);
 							}else{
 								data.data[i]["updateTime"]="";
 							}
 							if(data.data[i]["status"]=='0'){
 								data.data[i]["status"]='新建';
 							}else if(data.data[i]["status"]=='1'){
 								data.data[i]["status"]='发放';
 							}
 							html+='<tr><td>'+data.data[i]["salaryTime"]+'</td>'
 							    +'<td>'+data.data[i]["userCount"]+'</td>'
 							    +'<td>'+data.data[i]["amount"]+'</td>'
 							    +'<td>'+data.data[i]["status"]+'</td>'
 							    +'<td>'+data.data[i]["updateTime"]+'</td>'
 							    +'<td>'+data.data[i]["updateUserName"]+'</td>'
 							    +'</tr>';
 						}
 						$('#myDataTable tbody').html(html);
 						doprintForm();
 						
 					}else{
 						bootbox.alert('没有可打印的汇总数据！');
 					}
 				
 				}else{
 					bootbox.alert(data.msg);
 				}
 			}
 	  });
	   	  
   }
   function doprintForm(){
		var html=$("#printTable").html();
		$('.page-header').hide();
		$('.detailInfo').hide();
		$('#printTable').show();
		$("#myDataTable").printTable({
		 header: "#headerInfo",
         footer: "#footerInfo",
		 mode: "rowNumber",
		 pageSize: 20
	});
		javasricpt:window.print();
		$('.page-header').show();
		$('.detailInfo').show();
		$('#printTable').hide();
		$("#printTable").html(html);
	 }
   /* 打印明细 */
   function printDetailInfo(){
	   var date = new Date();
       var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
       var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
       var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
       var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
       var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
       var localTime= date.getFullYear() + "-" + month + "-" + day+ " " + hours + ":" + minutes + ":" + seconds;
       $('#localTimeDetail').html(localTime);
       var html="";
       var rowSelected = $('#dg1').datagrid('getSelected');
       if(rowSelected=='' || rowSelected==null){
    	   bootbox.alert('请先选择汇总数据！');
       }else{
	       var ids=rowSelected.id;
	       var html="";
	       $.ajax({
				type : 'GET',
				url : "${ctx}/financeManage/salaryPay/getDetailData/"+ids,
				data : '',
				dataType : 'JSON',
				success: function(data){
					if (data && data.code == 200){
						if(data.data.detailList!=null && data.data.detailList!=''){
							for(var i=0;i<data.data.detailList.length;i++){
								if(data.data.detailList[i]["departmentName"]==null || data.data.detailList[i]["departmentName"]==""){
									data.data.detailList[i]["departmentName"]='';
								}
								if(data.data.detailList[i]["dutyName"]==null || data.data.detailList[i]["dutyName"]==""){
									data.data.detailList[i]["dutyName"]='';
								}
	 							html+='<tr><td>'+data.data.detailList[i]["salaryTime"]+'</td>'
	 							    +'<td>'+data.data.detailList[i]["userName"]+'</td>'
	 							    +'<td>'+data.data.detailList[i]["departmentName"]+'</td>'
	 							    +'<td>'+data.data.detailList[i]["dutyName"]+'</td>'
	 							    +'<td>'+data.data.detailList[i]["basicSalary"]+'</td>'
	 							   +'<td>'+data.data.detailList[i]["allowanceDistance"]+'</td>'
	 							    +'<td>'+data.data.detailList[i]["allowanceAmount"]+'</td>'
	 							    +'<td>'+data.data.detailList[i]["fineAmount"]+'</td>'
	 							    +'<td>'+data.data.detailList[i]["amount"]+'</td>'
	 							    +'</tr>';
	 						}
	 						$('#myDataTable-detail tbody').html(html);
	 						doprintFormDetail();
						}else{
							bootbox.alert('没有可打印的明细数据！');
						}
						
					}else{
						bootbox.alert(data.msg);
					}
				}
		  });
	       
       }
	   	  
   }
   function doprintFormDetail(){
		var html=$("#printTableDetail").html();
		$('.page-header').hide();
		$('.detailInfo').hide();
		$('#printTableDetail').show();
		$("#myDataTable-detail").printTable({
		 header: "#headerInfo1",
         footer: "#footerInfo1",
		 mode: "rowNumber",
		 pageSize: 20
		 
	});
		javasricpt:window.print();
		$('.page-header').show();
		$('.detailInfo').show();
		$('#printTableDetail').hide();
		$("#printTableDetail").html(html);
	 }
   /* 导出汇总 */
	function doexport(){
		   var driverFlag='N';	   
	       var salaryTime=$('#startTime').val();
		   var form = $('<form action="${ctx}/financeManage/salaryPay/exportTotal" method="post"></form>');
		   var driverFlagInput = $('<input id="driverFlag" name="driverFlag" value="'+driverFlag+'" type="hidden" />');
		   var salaryTimeInput = $('<input id="salaryTime" name="salaryTime" value="'+salaryTime+'" type="hidden" />');
		   form.append(driverFlagInput);
		   form.append(salaryTimeInput);
		   $('body').append(form);
		   form.submit();
	}
	/* 导出明细 */
	function exportDetail(){  
		   var rowSelected = $('#dg1').datagrid('getSelected');
	       if(rowSelected=='' || rowSelected==null){
	    	   bootbox.alert('请先选择汇总数据！');
	       }else{
		       var id=rowSelected.id;
			   var form = $('<form action="${ctx}/financeManage/salaryPay/exportDetail" method="post"></form>');
			   var idInput = $('<input id="id" name="id" value="'+id+'" type="hidden" />');
			   form.append(idInput);
			   $('body').append(form);
			   form.submit();
	       }
	}
    </script> 
 </body>
</html>


