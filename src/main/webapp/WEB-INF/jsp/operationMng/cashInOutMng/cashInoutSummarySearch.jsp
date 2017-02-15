
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->

</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			查询管理
			<small>
				<i class="icon-double-angle-right"></i>
				汇总查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title mul-title" style="float: left;height: 34px;line-height: 34px;">时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 180px;margin-right:25px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width: 45px;margin-right: 8px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 180px;margin-right:20px;height: 34px;line-height: 34px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
			<label class="title mul-title">类型：</label>
		    <select id="type" class="form-box mul-form-box" style="width:180px;">
		      <option value="-1">请选择类型</option>
		      <option value="0">收入</option>
		      <option value="1">支出</option>
		    </select>		   
		</div>
		<div class="searchbox col-xs-12">		    
		    <label class="title mul-title" style="float: left;">部门：</label>
		    <select id="dept" class="form-box mul-form-box" style="float: left;width:180px;margin-right:25px;">
		      <option value="">请选择部门</option>
		    </select>
		    <label class="title mul-title" style="float: left;width: 45px;margin-right: 8px;">状态：</label>
		    <select id="status" class="form-box mul-form-box" style="float: left;width:180px;margin-right:20px;">
		      <option value="-1">请选择状态</option>
		      <option value="0">新建</option>
		      <option value="1">已提交</option>
		    </select>
		    <label class="title mul-title" >事由：</label>
		    <input id="mark" class="form-box mul-form-box" type="text" placeholder="请输入事由" style="width:180px;"/>
		</div>
		<div class="searchbox col-xs-12">
		    
		    <label class="title mul-title" style="float: left;">类别：</label>
		    <select id="businessType" class="form-box mul-form-box" style="width:180px;">
		      <option value="">请选择类别</option>
		      <option value="折损费用申请">折损费用申请</option>
		      <option value="油卡">油卡</option>
		      <option value="预付申请">预付申请</option>
		      <option value="折损出库">折损出库</option>
		      <option value="费用申请">费用申请</option>
		      <option value="核销费用申请">核销费用申请</option>
		      <option value="保费申请">保费申请</option>
		      <option value="轮胎入库登记">轮胎入库登记</option>
		      <option value="驾驶员报销折现">驾驶员报销折现</option>
		    </select>
			<a class="itemBtn m-lr5" onclick="searchInfo()">查询</a>			
			<!-- <a class="itemBtn m-lr5" onclick="doadd()">新增</a> -->
			<a class="itemBtn m-lr5" onclick="doprint()">打印</a>
			<a class="itemBtn m-lr5" onclick="doexport()">导出</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th rowspan="2">序号</th>
					<th rowspan="2">月/日</th>
					<th rowspan="2">部门</th>
					<th rowspan="2">经办人</th>
					<th rowspan="2">摘要</th>
					<th colspan="3">金额（元）</th>                 
				</tr>
				<tr>																			
                    <th>收入</th>
                    <th>支出</th>
                    <th>结余</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
		</div>
	</div>	
</div>

<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>现金收支表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>														
					<th rowspan="2">序号</th>
					<th rowspan="2">月/日</th>
					<th rowspan="2">部门</th>
					<th rowspan="2">经办人</th>
					<th rowspan="2">摘要</th>
					<th colspan="3">金额（元）</th>                 
				</tr>
				<tr>																			
                    <th>收入</th>
                    <th>支出</th>
                    <th>结余</th>
				</tr>
		    </thead>
		    <tbody>
		    </tbody>
		  </table>
		  <div id="footerInfo"><h3>盐城辉宇物流有限公司  制</h3></div>
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
<script src="${ctx}/staticPublic/js/jsonDataFormat.js"></script>
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">

function init(){
	 var type=$('#type').val();
	   var status=$('#status').val();
	   var mark=$('#mark').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var dept = $('#dept').val();
	   var businessType = $('#businessType').val();
	   if(type=='' || type==null || type=='-1'){
		   type="";
	   }
	   if(status=='' || status==null || status=='-1'){
		   status="";
	   }
	$.ajax({  
        url: '${ctx}/operationMng/cashInOutMng/getcashInoutSummarySearch',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		data : JSON.stringify({
			type : type,
			businessType : businessType,
			status : status,
			mark : mark,
			startTime : startTime,
			endTime : endTime,
			departmentId:dept
		}),
        success: function (data) {
        	if (data && data.code == 200) {	
        		//console.info(JSON.stringify(data));
        		var length=data.data.length;
        		if(data.data.length>0){
        			for(var i=0;i<data.data.length;i++){
        				data.data[i]["rownum"]=i+1;
        				if(data.data[i]["type"]=="1"){
        					data.data[i]["money2"]=data.data[i]["money"];
        					data.data[i]["money1"]="";
        					data.data[i]["money3"]="";
        				}else if(data.data[i]["type"]=="0"){
        					data.data[i]["money1"]=data.data[i]["money"];
        					data.data[i]["money2"]="";
        					data.data[i]["money3"]="";
        				}
        			}
        			//console.info(length);
        			var sumPrice=data.inCount+"";
					if(sumPrice.indexOf(".")>-1){
						if(sumPrice.split(".")[1].length>3){
							data.inCount=data.inCount.toFixed(3);
						}
					}
					var sumPrice2=data.outCount+"";
					if(sumPrice2.indexOf(".")>-1){
						if(sumPrice2.split(".")[1].length>3){
							data.outCount=data.outCount.toFixed(3);
						}
					}
					var sumPrice3=data.balance+"";
					if(sumPrice3.indexOf(".")>-1){
						if(sumPrice3.split(".")[1].length>3){
							data.balance=data.balance.toFixed(3);
						}
					}//data.year
        			data.data.push({rownum:length+1,exportTime:"",departmentName:"",insertUser:"",mark:"合计",money1:data.inCount,money2:data.outCount,money3:data.balance,type:""});
        		}
        		$('#detailtable').dataTable({
					"destroy" : true,//如果需要重新加载需销毁
					dom : 'Bfrtip',
					"destroy" : true,//如果需要重新加载需销毁
					"bLengthChange" : false,//屏蔽tables的一页展示多少条记录的下拉列表
					"bFilter" : false, //不使用过滤功能  
					"bProcessing" : true, //加载数据时显示正在加载信息	
					"bPaginate" : false,
					"bInfo" : false,
					ordering : false,
					"oLanguage" : {
						"sZeroRecords" : "抱歉， 没有找到",
						"sInfoEmpty" : "没有数据",
						"sInfoFiltered" : "(从 _MAX_ 条数据中检索)",
						"sZeroRecords" : "没有检索到数据"
					},
					data : data.data,
					//使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
					//data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
					columns : [ {data : 'rownum','width':'5%'},
					            {data : "exportTime",'width':'15%'}, 
					            {data : "departmentName",'width':'10%'}, 
					            {data : "insertUser",'width':'10%'}, 
					            {data : "mark",'width':'25%'}, 
					            {data : "money1",'width':'8%'},
					            {data : "money2",'width':'8%'},
					            {data : "money3",'width':'8%'},
					/* {data: "status"} */]
				});
			} else {
				 bootbox.alert(data.msg);
			} 
        }  
      });
}
$(function(){
	$("#startTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#endTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	init();
	getDeptList();
})

/* 获取部门 */
function getDeptList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/costApply/getDeptList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="">请选择部门</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
	                		}
	            		}
	            	}
	            	$('#dept').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
 }

/* 查询 */
function searchInfo(){
	init();
}

/* 导出 */
function doexport(){
	   var status=$('#status').val();
	   var type=$('#type').val();
	   var mark=$('#mark').val();
	   var startTime=$('#startTime').val();
	   var businessType=$('#businessType').val();
	   var endTime=$('#endTime').val();
	   var dept = $('#dept').val();
	   if(type=='' || type==null || type=='-1'){
		   type="";
	   }
	   if(status=='' || status==null || status=='-1'){
		   status="";
	   }
	   var form = $('<form action="${ctx}/operationMng/cashInOutMng/exportcashInoutSummary" method="post"></form>');
	   var typeInput = $('<input id="type" name="type" value="'+type+'" type="hidden" />');
	   var businessTypeInput = $('<input id="businessType" name="businessType" value="'+businessType+'" type="hidden" />');
	   var statusInput = $('<input id="status" name="status" value="'+status+'" type="hidden" />');
	   var markInput = $('<input id="mark" name="mark" value="'+mark+'" type="hidden" />');
	   var startTimeInput = $('<input id="startTime" name="startTime" value="'+startTime+'" type="hidden" />');
	   var endTimeInput = $('<input id="endTime" name="endTime" value="'+endTime+'" type="hidden" />');
	   var deptInput = $('<input id="departmentId" name="departmentId" value="'+dept+'" type="hidden" />');
	   form.append(typeInput);
	   form.append(businessTypeInput);
	   form.append(statusInput);
	   form.append(markInput);
	   form.append(startTimeInput);
	   form.append(endTimeInput);
	   form.append(deptInput);
	   $('body').append(form);
	   form.submit();
}

/* 打印功能 */
function doprint(){
	   var date = new Date();
       var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
       var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
       var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
       var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
       var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
      // var localTime= date.getFullYear() + "-" + month + "-" + day+ " " + hours + ":" + minutes + ":" + seconds;
	   var html="";
	   var status=$('#status').val();
	   var type=$('#type').val();
	   var businessType=$('#businessType').val();
	   var mark=$('#mark').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var dept = $('#dept').val();
	   if(type=='' || type==null || type=='-1'){
		   type="";
	   }
	   if(status=='' || status==null || status=='-1'){
		   status="";
	   }
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/operationMng/cashInOutMng/getcashInoutSummarySearch",
			data : JSON.stringify({
				type : type,
				businessType : businessType,
				mark : mark,
				status : status,
				startTime : startTime,
				endTime : endTime,
				departmentId : dept
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {					
					if(data.data.length>0){
						//console.info(JSON.stringify(data.data));
						for(var i=0;i<data.data.length;i++){
							data.data[i]["rownum"]=i+1;
							var type="收入";
							var insertTime="";
							var mark="";
							var money="";
							var insertUser="";
							var status="新建";
							if(data.data[i]["type"]=="1"){
	        					data.data[i]["money2"]=data.data[i]["money"];
	        					data.data[i]["money1"]="";
	        					data.data[i]["money3"]="";
	        				}else if(data.data[i]["type"]=="0"){
	        					data.data[i]["money1"]=data.data[i]["money"];
	        					data.data[i]["money2"]="";
	        					data.data[i]["money3"]="";
	        				}
							if(data.data[i]["insertTime"]!='' && data.data[i]["insertTime"]!=null){
								insertTime=jsonForDateFormat(data.data[i]["insertTime"]);
							}
							if(data.data[i]["mark"]!='' && data.data[i]["mark"]!=null){
								mark=data.data[i]["mark"];
							}
							if(data.data[i]["money"]!='' && data.data[i]["money"]!=null){
								money=data.data[i]["money"];
							}
							if(data.data[i]["insertUser"]!='' && data.data[i]["insertUser"]!=null){
								insertUser=data.data[i]["insertUser"];
							}
							html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
						    +'<td>'+data.data[i]["exportTime"]+'</td>'
						    +'<td>'+data.data[i]["departmentName"]+'</td>'
						    +'<td>'+data.data[i]["insertUser"]+'</td>'
						    +'<td>'+data.data[i]["mark"]+'</td>'
						    +'<td>'+data.data[i]["money1"]+'</td>'
						    +'<td>'+data.data[i]["money2"]+'</td>'
						    +'<td>'+data.data[i]["money3"]+'</td>'
							+'</tr>';
						}
						var sumPrice=data.inCount+"";
						if(sumPrice.indexOf(".")>-1){
							if(sumPrice.split(".")[1].length>3){
								data.inCount=data.inCount.toFixed(3);
							}
						}
						var sumPrice2=data.outCount+"";
						if(sumPrice2.indexOf(".")>-1){
							if(sumPrice2.split(".")[1].length>3){
								data.outCount=data.outCount.toFixed(3);
							}
						}
						var sumPrice3=data.balance+"";
						if(sumPrice3.indexOf(".")>-1){
							if(sumPrice3.split(".")[1].length>3){
								data.balance=data.balance.toFixed(3);
							}
						}
						var length=parseInt(data.data.length)+1;
						html+='<tr><td>'+length+'</td>'
					    +'<td>'+""+'</td>'
					    +'<td>'+""+'</td>'
					    +'<td>'+""+'</td>'
					    +'<td>'+"合计"+'</td>'
					    +'<td>'+data.inCount+'</td>'
					    +'<td>'+data.outCount+'</td>'
					    +'<td>'+data.balance+'</td>'
						+'</tr>';
						$('#localTime').html(data.year);
						$('#myDataTable tbody').html(html);
					      doprintForm();
					}else{
						bootbox.alert('暂无可打印的数据！');
						return;
					}
					 
				} else {
					 bootbox.alert(data.msg);
				}
				
			}
		}); 
	  
	   
}

function doprintForm(){
		var html=$("#printTable").html();
		$('#breadcrumbs').hide();
		$('.page-content').hide();
		$('#printTable').show();
		$("#myDataTable").printTable({
		 header: "#headerInfo",
         footer: "#footerInfo",
		 mode: "rowNumber",
		 pageSize: 20
	});
		javasricpt:window.print();
		$('#breadcrumbs').show();
		$('.page-content').show();
		$('#printTable').hide();
		$("#printTable").html(html);
	 }

</script>



</body>
</html>






