
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
<%-- <link rel="stylesheet" href="${ctx}/staticPublic/css/bootstrap-datetimepicker.css" /> --%>
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->


</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			运营管理
			<small>
				<i class="icon-double-angle-right"></i>
				快速调度审核
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
	  <div class="contentDetail">
		<div class="searchbox col-xs-12">
		  <label class="title" style="width:65px;">状态：</label>
		    <select id="status" class="form-box" style="width:234px;">
		      <option value="-1">请选择状态</option>
		      <option value="0">待复核</option>
		      <option value="1">审核通过</option>
		      <option value="2">审核未通过</option>
		      <option value="3">已修改</option>
		    </select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" id="printSchedule" onclick="printInfo()">打印</a>
			<a class="itemBtn" onclick="confirmMulit()">批量审核</a>
		</div>
		<div class="detailInfo">
			<table id="detailtable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>	
					    <th><input type="checkbox" class="checkall" /></th>											
						<th>序号</th>
						<th>调度单号</th>
						<th>申请人</th>
	                    <th>申请时间</th>
	                    <th>申请原因</th>
	                    <th>审核人</th>
	                    <th>审核时间</th>
	                    <th>审核意见</th>
	                    <th>状态</th>
	                    <th>操作</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>			
	</div>
	<!-- 调度修改审核 begin-->
	<div class="modal fade modal-reset" id="modal-edit" tabindex="-1" role="dialog" data-backdrop="static" style="width:600px;height:315px;">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">调度修改审核</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								    <div class="add-item col-xs-12">
									     <label class="title col-xs-4"><span class="red">*</span>调度单号：</label>
									     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
									        <p class="form-control no-border" id="applyScheduleNo" ></p>
									     </div>
									     <input type="hidden" id="schId-hidden"/>				      
									  </div>
									  <hr class="tree"></hr>
									<div class="add-item col-xs-12">
									     <label class="title col-xs-4"><span class="red">*</span>审核意见：</label>
									     <div class="col-xs-8" style="margin-top: -3px;margin-bottom: 10px;">
									        <textarea rows="4" cols="4" class="form-control" id="applyReason" placeholder="请输入审核意见"></textarea>
									     </div>							      
									  </div>
									  <hr class="tree"></hr>
								    <div class="add-item-btn" id="addBtn" style="display:block">
									    <a class="add-itemBtn btnOk" onclick="saveApply();">通过</a>
									    <a class="add-itemBtn btnCancle" onclick="refuseApply();">不通过</a>
									 </div>
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
		<!-- 调度修改审核 end-->
		</div>
		<!-- 打印模板   begin-->
			<div class="printTable" id="printTable">
			     <div id="print-content" class="printcenter">
						<div id="headerInfo">
							<h2>快速调度记录单</h2>
							<p id="localTime" style="text-align: right;"></p>
						</div>
						  <table id="myDataTable" class="table myDataTable">
						    <thead>
						      <tr>														
								<th>序号</th>
								<th>调度单号</th>
								<th>申请人</th>
			                    <th>申请时间</th>
			                    <th>申请原因</th>
			                    <th>审核人</th>
			                    <th>审核时间</th>
			                    <th>审核意见</th>
			                    <th>状态</th>
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
   </div>
   
</div>
<script src="${ctx}/staticPublic/js/jquery-2.0.3.min.js"></script>
<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
<!-- ace scripts -->
<script src="${ctx}/staticPublic/js/ace-elements.min.js"></script>
<script src="${ctx}/staticPublic/js/ace.min.js"></script>
<!-- inline scripts related to this page -->
<script type="text/javascript" src="${ctx}/staticPublic/js/bootbox.min.js"></script>
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script> 
<script src="${ctx}/staticPublic/js/jquery.dataTables.js"></script>
<script src="${ctx}/staticPublic/js/jquery.dataTables.bootstrap.js"></script>
<script src="${ctx}/staticPublic/js/jsonDataFormat.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/scheduleMng/getScheduleBillChangeApplyAuditListData" , //获取数据的ajax方法的URL							 
		 "ordering": false,	
			"oLanguage": {
				"sLengthMenu": "每页显示 _MENU_ 条记录",
				"sZeroRecords": "抱歉， 没有找到",
				"sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
				"sInfoEmpty": "没有数据",
				"sInfoFiltered": "(从 _MAX_ 条数据中检索)",
				"oPaginate": {
				"sFirst": "首页",
				"sPrevious": "上一页",
				"sNext": "下一页",
				"sLast": "尾页"
				},
				"sZeroRecords": "没有检索到数据"
				},		
				columns: [  
							{
							    "sClass": "text-center",
							    "data": "id",
							    "render": function (data, type, full, meta) {
							        return '<input type="checkbox"  class="checkchild"  value="' + data + '" />';
							    },
							    "bSortable": false
							},
				            {data: "rownum","width":"5%"},
						    {data: "scheduleBillNo","width":"10%"},
						    {data: "applyUserName","width":"8%"},
						    {data: "insertTime","width":"10%"},
						    {data: "reason","width":"15%"},
						    {data: "auditUserName","width":"8%"},
						    {data: "auditTime","width":"10%"},
						    {data: "auditSuggest","width":"8%"},
						    {data: "status","width":"10%"},
						    {data: null,"width":"16%"}],
						    columnDefs: [
											{
												//时间
												 targets:4,
												 render: function (data, type, row, meta) {
											           if(data!=''&& data!=null){
															 return jsonDateFormat(data);
														 }else{
															 return '';
														 }
											       }	       
											},
											{
												//时间
												 targets:7,
												 render: function (data, type, row, meta) {
											           if(data!=''&& data!=null){
															 return jsonDateFormat(data);
														 }else{
															 return '';
														 }
											       }	       
											},
											{
											 //状态
											 targets:9,
											 render: function (data, type, row, meta) {
												 if(data=='0'){
										        	   return '待复核';
										           }
										           if(data=='1'){
										        	   return '审核通过';
										           }
										           if(data=='2'){
										        	   return '审核未通过';
										           }
										           if(data=='3'){
										        	   return '已修改';
										           }else{
										        	   return '';
										           }
										       }
										},
										{
									    	 //操作栏
									    	 targets: 10,
									    	 render: function (data, type, row, meta) {
									    		 if(row.status=='0'){
									    			 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="dosubmit(this,'+row.id+')">审核</a>'
							                           +'<a class="table-edit" style="width:75px;" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.id+')">查看调度</a>';
									    		 }else{
									    			 return '<a class="table-edit" style="width:75px;" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.id+')">查看调度</a>';
							                          
									    		 }
								                    
								                }	       
								    	}
								      ],
							        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
function reload(){
	//reload dataTables plugin
	var myTable = $('#detailtable').DataTable({
		"destroy": true,//如果需要重新加载需销毁
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/scheduleMng/getScheduleBillChangeApplyAuditListData" , //获取数据的ajax方法的URL	
		 "ordering": false,	
			"oLanguage": {
				"sLengthMenu": "每页显示 _MENU_ 条记录",
				"sZeroRecords": "抱歉， 没有找到",
				"sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
				"sInfoEmpty": "没有数据",
				"sInfoFiltered": "(从 _MAX_ 条数据中检索)",
				"oPaginate": {
				"sFirst": "首页",
				"sPrevious": "上一页",
				"sNext": "下一页",
				"sLast": "尾页"
				},
				"sZeroRecords": "没有检索到数据"
				},		
				columns: [
							{
							    "sClass": "text-center",
							    "data": "id",
							    "render": function (data, type, full, meta) {
							        return '<input type="checkbox"  class="checkchild"  value="' + data + '" />';
							    },
							    "bSortable": false
							},
							 {data: "rownum","width":"5%"},
						     {data: "scheduleBillNo","width":"10%"},
						     {data: "applyUserName","width":"8%"},
						     {data: "insertTime","width":"10%"},
						     {data: "reason","width":"15%"},
						     {data: "auditUserName","width":"8%"},
						     {data: "auditTime","width":"10%"},
						     {data: "auditSuggest","width":"8%"},
						     {data: "status","width":"10%"},
						     {data: null,"width":"16%"}],
						    columnDefs: [
											{
												//时间
												 targets:4,
												 render: function (data, type, row, meta) {
											           if(data!=''&& data!=null){
															 return jsonDateFormat(data);
														 }else{
															 return '';
														 }
											       }	       
											},
											{
												//时间
												 targets:7,
												 render: function (data, type, row, meta) {
											           if(data!=''&& data!=null){
															 return jsonDateFormat(data);
														 }else{
															 return '';
														 }
											       }	       
											},
											{
											 //状态
											 targets:9,
											 render: function (data, type, row, meta) {
												 if(data=='0'){
										        	   return '待复核';
										           }
										           if(data=='1'){
										        	   return '审核通过';
										           }
										           if(data=='2'){
										        	   return '审核未通过';
										           }
										           if(data=='3'){
										        	   return '已修改';
										           }else{
										        	   return '';
										           }
										       }
										},
										{
									    	 //操作栏
									    	 targets: 10,
									    	 render: function (data, type, row, meta) {
									    		 if(row.status=='0'){
									    			 return '<a class="table-edit" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="dosubmit(this,'+row.id+')">审核</a>'
							                           +'<a class="table-edit" style="width:75px;" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.id+')">查看调度</a>';
									    		 }else{
									    			 return '<a class="table-edit" style="width:75px;" data-scheduleBillNo="'+row.scheduleBillNo+'" onclick="doshow(this,'+row.id+')">查看调度</a>';
							                          
									    		 }
								                    
								                }	       
								    	}
								      ],
							        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

$(function(){
	init();
	bindCheckMore();
	
	
});
/* 批量审核多选框 */
function bindCheckMore(){
	$(".checkall").on('click',function () {
	      var check = $(this).prop("checked");
	      $(".checkchild").prop("checked", check);
	      if(check==true){
	    	  $(".checkchild").parents('tr').addClass('selected');
	      }else{
	    	  $(".checkchild").parents('tr').removeClass('selected');
	      }
	});
	$('#detailtable tbody').on( 'click', 'tr', function () {
		  if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true){
				$(this).toggleClass('selected');
		   } 
		  if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true){
				$(this).toggleClass('selected');
		   }
		  if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') != true){
				$(".checkall").prop("checked",false);
		  }
		  if($("input[class='checkchild']:checked").size()==$("input[class='checkchild']").size() && $("input[class='checkchild']").size()>0 ){//全选 
		        $(".checkall").prop("checked",true); 
		    }
	   }); 
}


/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var status=$('#status').val();
	   if(status==null || status=='' || status=='-1'){
		   status="";
	   }
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				status : status
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
												
					obj.iTotalDisplayRecords=data.data.totalCounts;
					obj.iTotalRecords=data.data.totalCounts;
					obj.aaData=data.data.records;		
					obj.sEcho=data.data.frontParams;
					$(".checkall").prop("checked",false);//点击分页初始化全选框
					if(obj.aaData.length>0){
						for(var i=0;i<obj.aaData.length;i++){
							obj.aaData[i]["rownum"]=i+1;
						}
						
					}else{
						obj.aaData=[];
					}
					fnCallback(obj); //服务器端返回的对象的returnObject部分是要求的格式  	
				} else {
					 bootbox.alert(data.msg);
				}
				
			}
		}); 
	   
	}
/* 查询 */
function searchInfo(){
	reload();
}

/* 审核调度单修改申请 */
function dosubmit(e,id){
	var scheduleBillNo=$(e).attr("data-scheduleBillNo");
	$('#applyScheduleNo').html(scheduleBillNo);
	$('#schId-hidden').val(id);
	$('#applyReason').val('');
	$('#modal-edit').modal('show');
};

/* 审核通过 */
function saveApply(){
	var flag="false";
	var scheduleBillNo=$('#applyScheduleNo').html();
	var auditSuggest=$('#applyReason').val();
	var id=$('#schId-hidden').val();
	if(auditSuggest==''){
		bootbox.alert('请输入审核意见！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要通过该调度审核?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/operationMng/scheduleMng/auditScheduleBillChangeApply",
						data : JSON.stringify({
							scheduleBillApplyIds : id,
							auditResult: 'Y',
							auditSuggest : auditSuggest
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								 bootbox.confirm_alert({ 
									  size: "small",
									  message: "审核成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  reload();
											  $('#modal-edit').modal('hide');
										  }
									  }
								 });
								 setTimeout(function(){
										if(flag=="false"){
											reload();
											 $('.bootbox').modal('hide');
											 $('#modal-edit').modal('hide');
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
/* 审核不通过 */
function refuseApply(){
	var flag="false";
	var scheduleBillNo=$('#applyScheduleNo').html();
	var auditSuggest=$('#applyReason').val();
	var id=$('#schId-hidden').val();
	if(auditSuggest==''){
		bootbox.alert('请输入审核意见！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要不通过该调度审核?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : "${ctx}/operationMng/scheduleMng/auditScheduleBillChangeApply",
						data : JSON.stringify({
							scheduleBillApplyIds : id,
							auditResult: 'N',
							auditSuggest : auditSuggest
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								 bootbox.confirm_alert({ 
									  size: "small",
									  message: "审核成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  reload();
											  $('#modal-edit').modal('hide');
										  }
									  }
								 });
								 setTimeout(function(){
										if(flag=="false"){
											reload();
											 $('.bootbox').modal('hide');
											 $('#modal-edit').modal('hide');
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

/* 批量审核 */
function confirmMulit(){
	var table=$('#detailtable tbody');
	var ids='';
	if(table.children('tr.selected').length>0){
		var trFirst=table.children('tr.selected').eq(0);
		var scheduleBillNo=trFirst.find('td').eq(2).html()+'等';
		for(i=0;i<table.children('tr.selected').length;i++){
			var tr=table.children('tr.selected').eq(i);
			var td=tr.find('td').eq(0);
			if(tr.find('td').eq(9).html()!='待复核'){
				bootbox.alert('请检查已选择的调度信息，已审核的不可重复审核！');
				return;
			}else{
				ids+=td.find('input').val()+';';
			}
			
		}
		$('#applyScheduleNo').html(scheduleBillNo);
		$('#schId-hidden').val(ids.substring(0,ids.length-1));
		$('#applyReason').val('');
		$('#modal-edit').modal('show');
	}else{
		bootbox.alert('请先选择要审核的调度信息！');
	}
	
}

/* 查看详细调度信息 */
function doshow(e,id){
	var scheduleBillNo=$(e).attr("data-scheduleBillNo");
	var type="0";
	location.href="${ctx}/operationMng/scheduleMng/fastDetailIndex/"+scheduleBillNo+"/"+type;
}

/* 打印功能 */
function printInfo(){
	var date = new Date();
    var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
    var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
    var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
    var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
    var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
    var localTime= date.getFullYear() + "-" + month + "-" + day+ " " + hours + ":" + minutes + ":" + seconds;
    var html="";
    var scheduleBillNo = $('#wayBillInfo').val();
    var secho='1';   
	var pageStartIndex='0';
	var pageSize=1000;
    var status=$('#status').val();
    if(status==null || status=='' || status=='-1'){
	   status="";
     }
	   $('#secho').val(secho);
		$.ajax({
			type : 'POST',
			url : "${ctx}/operationMng/scheduleMng/getScheduleBillChangeApplyAuditListData",
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				status : status
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success: function(data){
				if (data && data.code == 200){
					var status=""
					if(data.data!=null && data.data!=''){
						for(var i=0;i<data.data.records.length;i++){
							var objs=data.data.records[i];
							if(objs.status=='0'){
								  status= '待复核';
					         }else if(objs.status=='1'){
					        	 status= '审核通过';
					         }else if(objs.status=='2'){
					        	 status='审核未通过';
					         }else if(objs.status=='3'){
					        	 status= '已修改';
					         }else{
					        	 status= '';
					          }
							if(objs.mark==null || objs.mark==''){
								objs.mark='';
							}
								html+='<tr>'
								    +'<td>'+(i+1)+'</td>'
								    +'<td>'+objs.scheduleBillNo+'</td>'
								    +'<td>'+objs.applyUserName+'</td>'
								    +'<td>'+jsonDateFormat(objs.insertTime)+'</td>'
								    +'<td>'+objs.reason+'</td>'
								    +'<td>'+objs.auditUserName+'</td>'
								    +'<td>'+jsonDateFormat(objs.auditTime)+'</td>'
								    +'<td>'+objs.auditSuggest+'</td>'
								    +'<td>'+status+'</td>'
									+'</tr>';
							
						}
						$('#localTime').html(localTime);
						$('#myDataTable tbody').html(html);
						doprintForm();
					}else{
						bootbox.alert('暂时没有可打印的数据！');
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
		$('.contentDetail').hide();
		$('#printTable').show();
		$("#myDataTable").printTable({
		 header: "#headerInfo",
         footer: "#footerInfo",
		 mode: "rowNumber",
		 pageSize: 20
	});
		javasricpt:window.print();
		$('.page-header').show();
		$('.contentDetail').show();
		$('#printTable').hide();
		$("#printTable").html(html);
	 }
</script>



</body>
</html>






