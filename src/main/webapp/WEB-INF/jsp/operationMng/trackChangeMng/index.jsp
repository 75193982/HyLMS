
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
.searchboxs{width:100%;height:45px;margin-bottom:15px;}
.searchboxs .title{margin-right:8px;font-family:"Microsoft YaHei";}
.searchboxs .titletwo{margin:0 8px 0 12px;font-family:"Microsoft YaHei";}
.searchboxs .form-box{width:180px;font-size:14px;height: 30px;margin-right:15px;}
.searchboxs .itemBtn{width: 65px;height: 34px;display: inline-block;cursor: pointer;
    text-decoration: none;background: #2ca9e1;color: #fff;margin: 0px 15px;text-align: center;
    font-size: 14px;line-height: 30px;border-radius: 3px;padding: 3px;
}  
.searchboxs .itemBtn:hover{background: #2E8EB9;} 
.form-new{
float:right;
width:480px;
}
.table-audit{
	width: 75px;
	height: 30px;
	display: inline-block;
	cursor: pointer;
	text-decoration: none;
	background: #2ca9e1;
	color: #fff;
	text-align: center;
	font-size: 13px;
	line-height: 24px;
	border-radius: 3px;
	padding: 3px;
	margin-right:5px;
	
}
.table-audit:hover{color:#fff;} 
#modal-shedeinfo{
    width: 1200px;
    height: 600px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }
    .modal-dialog{
    width: 1050px;	

}
</style>
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			运营管理
			<small>
				<i class="icon-double-angle-right"></i>
				在途换车管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">		   
			<label class="title">原驾驶员：</label>
		    <input id="fom_oldDriver" class="form-box" type="text" placeholder="请输入原驾驶员"/>
		    <label class="title">新驾驶员：</label>
		    <input id="fom_newDriver" class="form-box" type="text" placeholder="请输入新驾驶员"/>		   
		</div>	
		<div class="searchbox col-xs-12">		   
			<label class="title">调度单号：</label>
		    <input id="fom_scheduleBillNo" class="form-box" type="text" placeholder="请输入调度单号"/>
		    <label class="title" style="width:75px;">状态：</label>
		   <select id="fom_status" class="form-box" style="width:180px;" >	
		    	 <option value="">请选择状态</option>
		    	 <option value='0'>新建</option>
		    	 <option value='1'>待复核</option>	
		    	 <option value='2'>待审核</option>
		    	 <option value='3'>已完成</option>		    	    
			</select>	
			 <a class="itemBtn" onclick="searchInfo()">查询</a>
			 <a class="itemBtn" onclick="doadd()">新建</a>  
		</div>			
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>调度单号</th>
					<th>原装运车号</th>
                    <th>原驾驶员</th>
                    <th>新装运车号</th>
                    <th>新驾驶员</th>
                    <th>原因</th>
                    <th>申请时间</th> 
                    <th>申请人</th> 
                   <!--  <th>提交时间</th> -->
                    <!-- <th>审核时间</th>    
                    <th>审核人</th>  -->
                    <th>状态</th>                                            
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">换车申请</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item">
							     <label class="title"><span class="red">*</span>调度单号：</label>
							     <div class="form-new" id="apply_add">
							     <select id="scheduleBillNo" class="form-control">		      
			                     </select>	
			                     </div>
			                       <div class="form-new" id="apply_edit">
							      <input class="form-control" id="scheduleBillNo_edit" type="text" readonly="readonly"/>
			                     </div> 							     
							     <input class="form-control" id="id-hidden" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title">装运车号：</label>
							     <div class="form-new">
							     <input class="form-control" id="oldCarNumber" type="text" readonly="readonly"/>
							     </div>						     
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title">驾驶员：</label>
							     <div class="form-new">
							    <input class="form-control" id="oldDriver" type="text" readonly="readonly"/>
							    <input class="form-control" id="oldDriverId" type="hidden" readonly="readonly"/>
							    </div>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title"><span class="red">*</span>原因：</label>
							     <div class="form-new">
							     <textarea rows="4" cols="4" class="form-control" id="reason" placeholder="请输入原因"></textarea>
							    </div>
							 </div>							 				  
							    <hr class="tree" style="margin-top: 80px;"></hr>
							    <div class="add-item-btn" id="addBtn">
								    <a class="add-itemBtn btnOk" onclick="save();">保存</a>
								    <a class="add-itemBtn btnCancle" onclick="refresh();">关闭</a>
								 </div>
								 <div class="add-item-btn" id="editBtn">
								    <a class="add-itemBtn btnOk" onclick="update()">更新</a>
								    <a class="add-itemBtn btnCancle" onclick="refresh()">关闭</a>
								  </div> 
								  <!-- <div class="add-item-btn" id="viewBtn">								   
								    <a class="add-itemBtn btnCancle" onclick="refresh()">关闭</a>
								  </div> -->
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
		<div class="modal fade" id="modal-shedeinfo" tabindex="-1" role="dialog">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">调度单信息</h3>
				</div>
				<div class="modal-body">
				   <div><input type="hidden" id="listlength" name="listlength"/>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								<div class="mng">
		   <div class="table-tit">查看调度单<!-- <i class="icon-undo" style="display: inline-block;width: 20px;"></i> --></div>
		   <div class="table-item">
		     <div class="table-itemTit">基本信息</div>
		     <!-- 第一列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>发车日期:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="sendTime" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>交车日期:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="receiveTime" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>台数:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			         <p id="all-amount" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>装运车号:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <p id="carNumber" class="form-control no-border"></p>
				       </div>
			       </div>
		     </div>
		     <!-- 第三列 -->
		     <div class="row newrow">
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>驾驶员:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <p id="driver" class="form-control no-border"></p>
				       </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>联系电话:</label>
				       </div>
			       </div>
				   <div class="col-xs-5">
				     <div class="form-contr">
				       <p id="mobile" class="form-control no-border"></p>
				     </div>
				   </div>
		     </div>
		     <!-- 第五列 -->
		     <div class="row newrow">
		        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>备注:</label>
			       </div>
		       </div>
			   <div class="col-xs-11">
			     <div class="form-contr">
			       <p id="mark" class="form-control no-border"></p>
			     </div>
			   </div>
			 </div>
			  <!-- 添加预付申请信息 -->
			 <div class="table-itemTit">预付申请信息</div>
			 <!-- 预付第一列 -->
			 <div id="prepayList">
		       
		     </div>
		     <!-- 预付第二列 -->
		     
			 <!-- 预付第三列 -->
		     
		     <!--设置商品车详细信息-->
		     <div class="row row-btn-tit" id="carDetail">
		        <div class="col-xs-2 pd-2">
			       <div class="row-tit">
			                           详细信息
			       </div>
		       </div>
		       <div class="col-xs-10" style=" text-align: right;margin-top:3px;"><a class="table-edit" onclick="doprint();" style=" width: 80px;">打印</a></div>
		     </div>
		     
		     
		     <!-- 操作按钮栏 -->
		     <div class="row newrow">
		       <div class="col-xs-5"></div>
		       <div class="col-xs-2">
			       <div class="form-contr">
			          <a class="backbtn" onclick="doback();"><i class="icon-undo" style="display: inline-block;width: 20px;"></i>返回</a>
			       </div>
		       </div>
		       <div class="col-xs-5"></div>
		     </div>
		   </div>
		</div>
								</div>
						  </div>
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
		 "sAjaxSource": "${ctx}/operationMng/trackChangeMng/getListData" , //获取数据的ajax方法的URL							 
		 ordering: false,	
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
				columns: [{ data: "rownum" ,"width":"4%"},
				          {data: "scheduleBillNo","width":"6%"},
						    {data: "oldCarNumber","width":"7%"},
						    {data: "oldDriverName","width":"6%"},
						    {data: "newCarNumber","width":"7%"},
						    {data: "newDriverName","width":"6%"},
						    {data: "reason","width":"10%"},
						    {data: "insertTime","width":"10%"},	
						    {data: "insertUser","width":"7%"},
						    /* {data: "submitTime","width":"10%"},	 */
						   /*  {data: "auditTime","width":"7%"},
						    {data: "auditUser","width":"6%"}, */
						    {data: "status","width":"7%"},			    	
						    {data: null,"width":"12%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 7,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 9,
				 render: function (data, type, row, meta) {
					  if(data=='0'){
						 return '新建';
					 }else if(data=='1'){
						 return '待复核';
					 }else if(data=='2'){
						 return '待审核';
					 }else if(data=='3'){
						 return '已完成';
					 }else {
						 return '';
					 }					
			       }	       
			},{//操作栏
			    	 targets: 10,
			    	 render: function (data, type, row, meta) {		
			    		 if(row.status=='0'){
			    			 return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
			    			    +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
				               +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>' ;	
			    		 }else {
			    			   return '<a class="table-audit" onclick="doview(\''+ row.scheduleBillNo +'\',\''+ row.type +'\')">查看调度单</a>'
			    			  /*  +'<a class="table-audit" onclick="doconfirm('+ row.id +')">审核通过</a>'
					           +'<a class="table-audit" onclick="doapply('+ row.id +')">审核不通过</a>' */;	
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
		 "sAjaxSource": "${ctx}/operationMng/trackChangeMng/getListData", //获取数据的ajax方法的URL	
		 ordering: false,	
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
				columns: [{ data: "rownum" ,"width":"4%"},
				          {data: "scheduleBillNo","width":"6%"},
						    {data: "oldCarNumber","width":"7%"},
						    {data: "oldDriverName","width":"6%"},
						    {data: "newCarNumber","width":"7%"},
						    {data: "newDriverName","width":"6%"},
						    {data: "reason","width":"10%"},
						    {data: "insertTime","width":"10%"},	
						    {data: "insertUser","width":"7%"},
						  /*   {data: "submitTime","width":"10%"},	 */
						   /*  {data: "auditTime","width":"7%"},
						    {data: "auditUser","width":"6%"}, */
						    {data: "status","width":"7%"},			    	
						    {data: null,"width":"12%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 7,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }					
							       }	       
							},{
								 //入职时间
								 targets: 9,
								 render: function (data, type, row, meta) {
									  if(data=='0'){
											 return '新建';
										 }else if(data=='1'){
											 return '待复核';
										 }else if(data=='2'){
											 return '待审核';
										 }else if(data=='3'){
											 return '已完成';
										 }else {
											 return '';
										 }					
							       }	       
							},{//操作栏
							    	 targets: 10,
							    	 render: function (data, type, row, meta) {			    		
							    		 if(row.status=='0'){
							    			 return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
							    			        +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
									               +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>' ;	
							    		 }else {
							    			   return '<a class="table-audit" onclick="doview(\''+ row.scheduleBillNo +'\',\''+ row.type +'\')">查看调度单</a>'
							    			  /*  +'<a class="table-audit" onclick="doconfirm('+ row.id +')">审核通过</a>'
									           +'<a class="table-audit" onclick="doapply('+ row.id +')">审核不通过</a>' */;	
							    		 } 				                 
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	//getOutSourcing();//获取承运商
	//getCarShop();
})

/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var oldDriver=$("#fom_oldDriver").val(); 
	   var newDriver=$("#fom_newDriver").val(); 
	   var status=$("#fom_status").val(); 
	   var scheduleBillNo=$("#fom_scheduleBillNo").val(); 
	   //var endAddress=$("#fom_endAddress").val();
	   //var outSourcing=$("#fom_outSourcing").find("option:selected").val();
	   //var carNumber=$("#fom_carNumber").val();
	   //var insuranceCompany=$("#fom_insuranceCompany").val();
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				oldDriverName :$.trim(oldDriver) ,
				newDriverName : $.trim(newDriver),
				status:$.trim(status),
				scheduleBillNo:$.trim(scheduleBillNo)			
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.info(JSON.stringify(data.data));						
					obj.iTotalDisplayRecords=data.data.totalCounts;
					obj.iTotalRecords=data.data.totalCounts;
					obj.aaData=data.data.records;		
					obj.sEcho=data.data.frontParams;
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
/* 新增信息 */
/* 调度单绑定 */
function bindscheduleBillNo(){
$.ajax({
	type : 'POST',
	url : "${ctx}/operationMng/trackChangeMng/getSchBillNo",
	contentType : "application/json;charset=UTF-8",
	dataType : 'JSON',
	success : function(data) {
		if (data && data.code == 200) {
			var html ='<option value="">请选择调度单号</option>';
			if(data.data!=null && data.data!=''){
        		if(data.data.length>0){
        			for(var i=0;i<data.data.length;i++){
            			html +='<option value='+data.data[i]['scheduleBillNo']+' data-carNumber='+data.data[i]['carNumber']+' data-driverId='+data.data[i]['driverId']+' data-driverName='+data.data[i]['driverName']+'>'+data.data[i]['scheduleBillNo']+'</option>';
            		}
        		}
        	}
        	$('#scheduleBillNo').html(html);
		} else {
			bootbox.alert(data.msg);
		}
	}
	
});
}
	
/*申请信息输入  */
function doadd(){
	clear();
	$('#addBtn').show();
	$('#editBtn').hide();
	$('#myModalLabel').html('换车申请单');	
	$('#modal-info').modal('show');
	$('#apply_add').show();
	$('#apply_edit').hide();
	bindscheduleBillNo();//绑定调度单
	$('#scheduleBillNo').change(function(){
		var scheduleBill=$(this).children('option:selected').val();		
		 if($(this).val()=='' || $(this).val()==null){
			  $('#oldDriver').val('');
			  $('#oldCarNumber').val('');			  
		  }else{
			  //console.info(JSON.stringify(scheduleBill));
			  //console.info($(this).find('option:selected').attr('data-carNumber'));
			  $('#oldCarNumber').val($(this).find('option:selected').attr('data-carNumber'));
			  $('#oldDriver').val($(this).find('option:selected').attr('data-driverName'));
			  $('#oldDriverId').val($(this).find('option:selected').attr('data-driverId'));
		  }
	})
}
/* 关闭窗体 */
function refresh(){
	clear();
	$('#modal-info').modal('hide');
	
}
/* 数据重置 */
function clear(){
	$('#id-hidden').val('');	
	$('#scheduleBillNo').val('');
	$('#oldCarNumber').val('');		
	$('#oldDriver').val('');
	$('#oldDriverId').val('');
	$('#reason').val('');
	
}
/* 保存换车申请信息 */
function save(){
	var flag="false";
	var scheduleBillNo=$("#scheduleBillNo").find("option:selected").val(); 
	//var type=$("#type").find("option:selected").val(); 
	var oldCarNumber=$("#oldCarNumber").val(); 
	var oldDriver=$("#oldDriverId").val(); 
	var reason=$("#reason").val(); 	
	if(scheduleBillNo==''){
		bootbox.alert('调度单号不能为空！');
		return;
	}
	if(reason==''){
		bootbox.alert('原因不能为空！');
		return;
	}		
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该换车申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackChangeMng/trackChangeApply',
						data : JSON.stringify({
							scheduleBillNo : scheduleBillNo,				
							oldCarNumber : oldCarNumber,
							oldDriverId : oldDriver,
							reason : reason
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
											 refresh();
								             reload();
										  }else{
											refresh();
								            reload(); 
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										refresh();
							             reload();
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
//申请提交
function dosubmit(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该换车申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'GET',
						url : '${ctx}/operationMng/trackChangeMng/submit/'+id,
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "提交成功！", 
									  callback: function(result){
										  if(result){
											 flag="true";
											 refresh();
								             reload();
										  }else{
											refresh();
								            reload(); 
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										refresh();
							             reload();
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
//打开编辑页面
function doedit(id){	
	clear();	
	bindscheduleBillNo();//绑定调度单
	$('#scheduleBillNo').change(function(){
		var scheduleBill=$(this).children('option:selected').val();		
		 if($(this).val()=='' || $(this).val()==null){
			  $('#oldDriver').val('');
			  $('#oldCarNumber').val('');			  
		  }else{
			  //console.info(JSON.stringify(scheduleBill));
			  //console.info($(this).find('option:selected').attr('data-carNumber'));
			  $('#oldCarNumber').val($(this).find('option:selected').attr('data-carNumber'));
			  $('#oldDriver').val($(this).find('option:selected').attr('data-driverName'));
			  $('#oldDriverId').val($(this).find('option:selected').attr('data-driverId'));
			 
		  }
	})
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackChangeMng/getDetailData/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑换车申请信息');
				$("#scheduleBillNo_edit").val(data.data.scheduleBillNo);
				$("#oldCarNumber").val(data.data.oldCarNumber); 
				$("#oldDriver").val(data.data.oldDriverName); 
				$('#oldDriverId').val(data.data.oldDriverId);
				$("#reason").val(data.data.reason); 				
				$('#addBtn').hide();
				$('#editBtn').show();
				$('#viewBtn').hide();
				$('#apply_add').hide();
				$('#apply_edit').show();
				$('#modal-info').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
/* 更新 */
function update(){
	var flag="false";
	var id=$('#id-hidden').val();
	var scheduleBillNo=$("#scheduleBillNo_edit").find("option:selected").val(); 
	//var type=$("#type").find("option:selected").val(); 
	var oldCarNumber=$("#oldCarNumber").val(); 
	var oldDriver=$("#oldDriver").val(); 
	var reason=$("#reason").val(); 		
	if(reason==''){
		bootbox.alert('原因不能为空！');
		return;
	}		
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该换车申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackChangeMng/update',
						data : JSON.stringify({
							id : id,
							scheduleBillNo : scheduleBillNo,				
							oldCarNumber : oldCarNumber,
							oldDriver : oldDriver,
							reason : reason
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
											 refresh();
								             reload();
										  }else{
											refresh();
								            reload(); 
										  }
									  }
								 });
								 setTimeout(function(){
										if(flag=="false"){
											refresh();
								             reload();
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
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该换车申请信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/trackChangeMng/delete/"+id,
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "删除成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  reload();
										  }else{
											reload();  
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
							             reload();
										 $('.bootbox').modal('hide');
									}
								},3000);
							}else{
								bootbox.alert(data.msg);
							}
						}
						
					}); 
			  }
		  }
	})
}
function doview(scheduleBillNo,type){
	 if(type=='0'){
	 clearshedeinfo();
	 $('#modal-shedeinfo').modal('show');
	 var html="";
	  var prepayHtml="";
	  var carHtml="";
	  var carAttachmentHtml="";
	  var detailListHtml="";
	  $.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/scheduleMng/getDetailData/"+scheduleBillNo,
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					if(data.data['sendTime']!=''&&data.data['sendTime']!=null){
						$('#sendTime').html(jsonForDateFormat(data.data['sendTime']));
					}else{
						$('#sendTime').html('');
					}
					if(data.data['receiveTime']!=''&&data.data['receiveTime']!=null){
						$('#receiveTime').html(jsonForDateFormat(data.data['receiveTime']));
					}else{
						$('#receiveTime').html('');
					}
					if(data.data['planReachTime']!=''&&data.data['planReachTime']!=null){
						$('#planReachTime').html(jsonForDateFormat(data.data['planReachTime']));
					}else{
						$('#planReachTime').html('');
					}

					$('#all-amount').html(data.data['amount']);
					$('#startAddress').html(data.data['startAddress']);
					$('#endAddress').html(data.data['endAddress']);
					$('#carNumber').html(data.data['carNumber']);
					$('#driver').html(data.data['driverName']);
					$('#mark').html(data.data['mark']);
					if(data.data['preList']!=null && data.data['preList'].length>0){
						for(var k=0;k<data.data['preList'].length;k++){
							var status='';
							var oilAmount=data.data['preList'][k]['oilAmount'];
							if(oilAmount==null){
								oilAmount='';
							}
							var prepayCash=data.data['preList'][k]['prepayCash'];
							if(prepayCash==null){
								prepayCash='';
							}
							var bankName=data.data['preList'][k]['bankName'];
							if(bankName==null){
								bankName='';
							}
							var bankAccount=data.data['preList'][k]['bankAccount'];
							if(bankAccount==null){
								bankAccount='';
							}
							var oilCardNo=data.data['preList'][k]['oilCardNo'];
							if(oilCardNo==null){
								oilCardNo='';
							}
							if(data.data['preList'][k]['status']=='0'){
								status='新建';
							}else if(data.data['preList'][k]['status']=='1'){
								status='待审核';
							}else if(data.data['preList'][k]['status']=='2'){
								status='待付款';
							}else if(data.data['preList'][k]['status']=='3'){
								status='已完成';
							}else if(data.data['preList'][k]['status']=='4'){
								status='已结算';
							}
							prepayHtml+='<div class="border-b-ff9a00"><div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付现金:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayCash'+k+'" class="form-control no-border">'+prepayCash+'</p></div></div>'
						          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>开户行:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="bankName'+k+'" class="form-control no-border">'+bankName+'</p></div></div></div>'
						          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>账号:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="bankAccount'+k+'" class="form-control no-border">'+bankAccount+'</p></div></div>'
						          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付油卡卡号:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="oilCardNo'+k+'" class="form-control no-border">'+oilCardNo+'</p></div></div></div>'
						          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付油费:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="oilAmount'+k+'" class="form-control no-border">'+oilAmount+'</p></div></div>'
						          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付状态:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayStatus'+k+'" class="form-control no-border">'+status+'</p></div></div></div></div>';
						}
					}else{
						prepayHtml='<div class="border-b-ff9a00"><div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付现金:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayCash" class="form-control no-border"></p></div></div>'
					          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>开户行:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="bankName" class="form-control no-border"></p></div></div></div>'
					          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>账号:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="bankAccount" class="form-control no-border"></p></div></div>'
					          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付油卡卡号:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="oilCardNo" class="form-control no-border"></p></div></div></div>'
					          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付油费:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="oilAmount" class="form-control no-border"></p></div></div>'
					          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付状态:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayStatus" class="form-control no-border"></p></div></div></div></div>';
					}
					$('#prepayList').html(prepayHtml);
					$('#mobile').html(data.data['mobile']);
					if(data.data['detailList'].length>0){
						$('#listlength').val(data.data['detailList'].length);
						for(var i=0;i<data.data['detailList'].length;i++){
							var carInfo=data.data['detailList'][i]['carList'];
							var carAttachmentInfo=data.data['detailList'][i]['carAttachmentList'];
							var carHtmlItem="";
							var carAttachmentHtmlItem="";
							/* 车辆信息 */
							if(carInfo!=null && carInfo.length>0){
								for(var j=0;j<carInfo.length>0;j++){
									var carShopName=data.data['detailList'][i]['carShopName'];
									if(carShopName!=null && carShopName!=""){
										carHtmlItem+='<tr><td>'+carInfo[j]['vin']+'</td><td>'+carInfo[j]['model']+'</td>'
										   +'<td>'+carInfo[j]['color']+'</td><td>'+jsonDateFormat(carInfo[j]['insertTime'])+'</td>'
										   +'<td>'+carInfo[j]['waybillNo']+'</td><td>'+carShopName+'</td>'
										   +'<td>'+carInfo[j]['brand']+'</td></tr>';
									}else{
										carHtmlItem+='<tr><td>'+carInfo[j]['vin']+'</td><td>'+carInfo[j]['model']+'</td>'
										   +'<td>'+carInfo[j]['color']+'</td><td>'+jsonDateFormat(carInfo[j]['insertTime'])+'</td>'
										   +'<td>'+carInfo[j]['waybillNo']+'</td><td>二手车</td>'
										   +'<td>'+carInfo[j]['brand']+'</td></tr>';
									}
									
								}
								carHtml='<table class="carList table table-striped table-bordered table-hover">'
							        +'<thead><tr><th>车架号</th><th>车型</th><th>颜色</th><th>入库时间</th><th>运单编号</th><th>经销单位</th><th>品牌</th></tr></thead>'
							        +'<tbody>'+carHtmlItem+'</tbody></table>'; 
							}else{
								carHtmlItem='<tr><td colspan="7">暂无车辆信息</td></tr>'
								carHtml='<table class="carList table table-striped table-bordered table-hover">'
							        +'<thead><tr><th>车架号</th><th>车型</th><th>颜色</th><th>入库时间</th><th>运单编号</th><th>经销单位</th><th>品牌</th></tr></thead>'
							        +'<tbody>'+carHtmlItem+'</tbody></table>';
							}
							/* 配件信息 */
							if(carAttachmentInfo!=null && carAttachmentInfo.length>0){
								for(var k=0;k<carAttachmentInfo.length>0;k++){
									carAttachmentHtmlItem+='<tr><td>'+carAttachmentInfo[k]['attachmentName']+'</td>'
										   +'<td>'+carAttachmentInfo[k]['position']+'</td>'
										   +'<td>'+carAttachmentInfo[k]['count']+'</td>'
										   +'<td>'+carAttachmentInfo[k]['outCount']+'</td></tr>';
									
								}
							}else{
								carAttachmentHtmlItem='<tr><td colspan="4">暂无配件信息</td></tr>'
							}
							carAttachmentHtml='<table class="carList table table-striped table-bordered table-hover">'
						        +'<thead><tr><th>配件</th><th>位置</th><th>库存</th><th>出库数</th></tr></thead>'
						        +'<tbody>'+carAttachmentHtmlItem+'</tbody></table>';
						        var startAddress=data.data['detailList'][i]['startAddress'];
						        var targetProvince=data.data['detailList'][i]['targetProvince'];
						        var targetCity=data.data['detailList'][i]['targetCity'];
						        if(startAddress==null){
						        	startAddress="";
						        }
						        if(targetProvince==null){
						        	targetProvince="";
						        }
						        if(targetCity==null){
						        	targetCity="";
						        }
							if(data.data['detailList'][i]['carShopId']!=null && data.data['detailList'][i]['carShopId']!=''){
								detailListHtml+='<div class="border-b-ff9a00 detailList" id="detailList'+i+'">'
									  +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>经销单位:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="carShopId-item form-control">'+data.data['detailList'][i]['carShopName']+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>数量:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="amount-item form-control">'+data.data['detailList'][i]['amount']+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>详细指令:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="detailMark-item form-control">'+data.data['detailList'][i]['mark']+'</p></div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>始发地:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border">'+startAddress+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>目的省:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border">'+targetProvince+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>目的地:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border">'+targetCity+'</p></div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>车辆信息:</label></div></div>'
						              +'<div class="col-xs-11"><div class="newCarDetail-item">'+carHtml+'</div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>配件信息:</label></div></div>'
						              +'<div class="col-xs-11"><div class="newPartDetail-item">'+carAttachmentHtml+'</div></div></div></div>';
							}else{
								detailListHtml+='<div class="border-b-ff9a00 detailList" id="detailList'+i+'">'
									  +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>经销单位:</label></div></div>'
						              +'<div class="col-xs-4"><div class="form-contr"><p class="carShopId-item form-control">二手车</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>数量:</label></div></div>'
						              +'<div class="col-xs-2"><div class="form-contr"><p class="amount-item form-control">'+data.data['detailList'][i]['amount']+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>详细指令:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="detailMark-item form-control">'+data.data['detailList'][i]['mark']+'</p></div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>始发地:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border">'+startAddress+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>目的省:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border">'+targetProvince+'</p></div></div>'
						              +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>目的地:</label></div></div>'
						              +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border">'+targetCity+'</p></div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>车辆信息:</label></div></div>'
						              +'<div class="col-xs-11"><div class="newCarDetail-item">'+carHtml+'</div></div></div>'
						              +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>配件信息:</label></div></div>'
						              +'<div class="col-xs-11"><div class="newPartDetail-item">'+carAttachmentHtml+'</div></div></div></div>';
							}
							
						}

					}else{
						detailListHtml='<div class="border-b-ff9a00 detailList" id="detailList0"><div class="row newrow"><div class="col-xs-12"><p class="form-control no-border t-c">没有详细信息！</p></div></div>';
					}
					
					html=detailListHtml;

					$('#carDetail').after(html);
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		}); }else{
			var flag="5";
		    var url="${ctx}/operationMng/scheduleMng/fastDetailIndex/"+scheduleBillNo+"/"+flag;
			  bootbox.dialog({  
	              message: '<iframe width=1000 height=550 frameborder=0 scrolling=auto src='+url+'></iframe>',  
	              title: "快速调度信息"  
	          }); 
		}
}
 function doback(){	 
	 $('#modal-shedeinfo').modal('hide');
 }
 function clearshedeinfo(){
	 $('#sendTime').html('');
		$('#receiveTime').html('');
		$('#planReachTime').html('');
		$('#all-amount').html('');
		$('#startAddress').html('');
		$('#endAddress').html('');
		$('#carNumber').html('');
		$('#driver').html('');
		$('#mark').html('');
	 var length= $('#listlength').val();
	 if(length!=''){
		 for(var i=0;i<length;i++){
			 $('#detailList'+i).html('');
		 }		
	 }
	 $('#listlength').val('');
 }
</script>



</body>
</html>






