
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/ztree/zTreeStyle/zTreeStyle.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/select.dataTables.min.css" type="text/css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
	#modal-setuser{
    width: 1000px;
    height: 600px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
   
   } 
	
	</style>
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			基础信息管理
			<small>
				<i class="icon-double-angle-right"></i>
				业务流程管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">流程名称：</label>
		   <input id="fom_name" class="form-box" type="text" placeholder="请填写流程名称"/>		   	  
		   <label class="titletwo">状态：</label>
		     <select id="fom_status" class="form-box">
		      <option value="">请选择状态</option>
		     <option value='0'>新建</option>
		     <option value='1'>使用中</option>
		     <option value='2'>已停用</option>
			</select>							  
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="doadd()">新增</a>
		</div>
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>流程名称</th>
					<th>仓库</th>
                    <th>创建时间</th>
                    <th>创建人</th>
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
					<h3 id="myModalLabel">新增/编辑业务流程信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>名称：</label>
							     <select id="processName" class="form-control" placeholder="请选择名称"></select>
							     <input class="form-control" id="id-hidden" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>仓库：</label>
							    <select id="stock" class="form-control" placeholder="请选择仓库"></select>
							 </div>	
							 <div id="editstatus">
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							   <label class="title">状态：</label>
							   <select id="status" class="form-control">		                       
		                       <option value='0'>新建</option>
		                       <option value='1'>使用中</option>
		                       <option value='2'>已停用</option>
			                    </select>
							  </div>
							 </div>						  			  				  
							    <hr class="tree"></hr>
							    <div class="add-item-btn" id="addBtn">
								    <a class="add-itemBtn btnOk" onclick="save();">保存</a>
								    <a class="add-itemBtn btnCancle" onclick="refresh();">取消</a>
								 </div>
								 <div class="add-item-btn" id="editBtn">
								    <a class="add-itemBtn btnOk" onclick="update()">更新</a>
								    <a class="add-itemBtn btnCancle" onclick="refresh()">取消</a>
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
		 <div class="modal fade" id="modal-setprice" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="mysetpriceLabel">业务流程设置</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">																
							 <div class="row row-btn-tit">
		                     <div class="col-xs-3 pd-2">
			                 <div class="row-tit">
			                                                         设置业务流程信息
			                </div>
		                    </div>
		                  <div class="col-xs-7"></div>
		                  <div class="col-xs-2">
				          <div class="form-contr-1">
				          <input type="hidden" id="processid" name="processid" /> 
				          <a class="form-btn-1" onclick="newadd();"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>新增</a>				    
				         </div>
			             </div>
		                 </div>
		                  <div id="kmmodel">
		                  <!-- 第一条详细信息 -->
		     <div id="detailList0" class="border-b-ff9a00 detailList">
		       <!-- 第一列 -->
		     <div class="row newrow">
		       <div class="col-xs-3 pd-2">
			       <div class="lab-tit">
			          <label class="title" style="padding-top: 10px;"><span class="red">*</span>节点名称:</label>
			       </div>
		       </div>
		       <div class="col-xs-9">
			       <div class="form-contr">
			           <input id="newsetporce0" name="newsetporce0" type="text" class="form-control" placeholder="请填写名称"/>
			       </div>
		       </div>		       		       
		     </div>
		     <!-- 第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-3 pd-2">
			       <div class="lab-tit">
			          <label class="title" style="padding-top: 10px;">操作人:</label>
			       </div>
		       </div>
		       <div class="col-xs-9">
			        <div class="form-control" style="border:0;padding:0">
									       <input id="newuser0" value="" type="text" readonly="readonly" style="width:70%;height: 35px;margin-top: 5px;" />
									       <input class="form-control" id="newuserid0" type="hidden"/>
									       <a class="selectBtn" id="selectBtn" onclick="newmodel('0');">选择</a>
									       <a class="selectBtn" id="selectBtn" onclick="removemodel('0');">清除</a>
									     </div>
		       </div>		     		       
		     </div>
		      <!-- 第三列 -->
		     <div class="row newrow">
		       <div class="col-xs-3 pd-2">
			       <div class="lab-tit">
			          <label class="title" style="padding-top: 10px;"><span class="red">*</span>操作类型:</label>
			       </div>
		       </div>
		       <div class="col-xs-9">
			        <div class="form-contr">
			          <select id="type0" class="form-control">	
			          <option value=''>请选择操作类型</option>	                       
		              <option value='0' >审核操作</option>
		              <option value='1'>确认操作</option>
			          </select>
			       </div>
		       </div>		     		       
		     </div>
		     <!-- 第四列 -->
		     <div class="row newrow">
		       <div class="col-xs-3 pd-2">
			       <div class="lab-tit">
			          <label class="title" style="padding-top: 10px;width: 170px;"><span class="red">*</span>是否需要填写审核意见:</label>
			       </div>
		       </div>
		       <div class="col-xs-9">
			        <div class="form-contr">
			          <select id="needSuggestFlag0" class="form-control">	                      
		              <option value='Y' >是</option>
		              <option value='N'>否</option>
			          </select>
			       </div>
		       </div>		     		       
		     </div>
		     </div>
							 </div>	  
							 							  						  
							    <hr class="tree"></hr>
							    <div class="add-item-btn" id="uploadBtn">
								    <a class="add-itemBtn btnOk" onclick="finishsave();" style="margin-left: 130px;">确认</a>
								    <a class="add-itemBtn btnOk" onclick="finishrefresh();">关闭</a>
								 </div>
								
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
			<div class="modal fade" id="modal-setuser" tabindex="-1" role="dialog">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myfinishLabel">选择操作人</h3>
				</div>
				<div class="modal-body">
				<div class="treeleft"> 
                <ul id="tree" class="ztree"></ul>
                </div>
				   <div class="userlistright">
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">	
								<input type="hidden" id="lindex" name="lindex" /> 													  
							 <table id="usertable" class="table  table-bordered dataTable no-footer">
                             <thead>
							 <tr>							 														
							 <th>序号</th>														
					         <th>姓名</th>  
					         <th>职位</th>                                                      
						     </tr>
							 </thead>
							 <tbody>
							 </tbody>
                             </table>								  						  
							    <hr class="tree" style="margin-top: 120px;"></hr>
							    <div class="add-item-btn" id="operBtn">
								    <a class="add-itemBtn btnOk" onclick="usersave();" style="margin-left: 130px;">确认</a>
								    <a class="add-itemBtn btnOk" onclick="userrefresh();">关闭</a>
								 </div>
								
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
			<div class="modal fade" id="modal-procedetinfo" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">业务流程明细信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							    <div class="add-item col-xs-12" id="detilinfo">
							   				     								     							     
							   </div>									 						 					   			  
							    						    
								 <div class="add-item-btn" id="viewBtn">								   
								    <a class="add-itemBtn btnCancle" onclick="doclose()">关闭</a>
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
<!-- basic scripts -->
		<!--[if !IE]> -->
		<script src="${ctx}/staticPublic/js/jquery-2.0.3.min.js"></script>
		<!-- <![endif]-->
		<!--[if IE]>
		<script src="${ctx}/staticPublic/js/jquery-1.10.2.min.js"></script>
		<![endif]-->
		<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
		<!-- page specific plugin scripts -->
		<script src="${ctx}/staticPublic/js/jquery.dataTables.js"></script>
		<script src="${ctx}/staticPublic/js/jquery.dataTables.bootstrap.js"></script>
		<!-- ace scripts -->
		<script src="${ctx}/staticPublic/js/ace-elements.min.js"></script>
		<script src="${ctx}/staticPublic/js/ace.min.js"></script>		
		<!-- inline scripts related to this page -->
		<script type="text/javascript" src="${ctx}/staticPublic/js/popbox/Confirm.js"></script>
        <script src="${ctx}/staticPublic/js/bootbox.min.js"></script>
        <script src="${ctx}/staticPublic/js/jsonDataFormat.js"></script>
        <script type="text/javascript" src="${ctx}/staticPublic/js/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${ctx}/staticPublic/js/ztree/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="${ctx}/staticPublic/js/ztree/jquery.ztree.exedit.js"></script>
	<script type="text/javascript" src="${ctx}/staticPublic/js/dataTables.select.min.js"></script>
<script type="text/javascript">
var setting = {
		view: {
			selectedMulti: false
		},
		edit: {
			enable: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {			
			onClick: zTreeOnClick
		}
	};
function zTreeOnClick(event, treeId, treeNode) {
	//console.info(JSON.stringify(treeNode));
	var departmentId=treeNode.id;
	//console.info(departmentId);
	var html="";
	 $.ajax({
			type : 'GET',
			url : "${ctx}/commonSetting/userSetting/getUserListByDepartmentId/"+departmentId,				
			dataType : 'JSON',
			
			success : function(data) {
				if (data && data.code == 200) {
					//console.log(JSON.stringify(data.data));	
					if(data.data.length>0){
						for(var i=0;i<data.data.length;i++){
							data.data[i]["rownum"]=i+1;
							
						}
					}
					
					$('#usertable').dataTable({
						"destroy": true,//如果需要重新加载的时候请加上这个
						 dom: 'Bfrtip',
						 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
						 "bFilter": false,    //不使用过滤功能  
						 "bProcessing": true, //加载数据时显示正在加载信息	
						 select: true,
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
						data: data.data,
				        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
				        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
				        columns: [	
				            { data: 'rownum' },
				            { data: 'name' },
				            { data: 'title' }
				        ]
					});

				} else {
					 bootbox.alert(data.msg);
					//jQuery.messager.alert('提示:',data.msg,'info'); 
				}
				
			}
		});		
	//console.info(treeNode.tId + ", " + treeNode.name+ ", " + treeNode.url+ ", " + treeNode.orderId+ ", " + treeNode.pId+ ", " + treeNode.id);	
};
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/basicSetting/processMng/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum" },
		    {data: "processName"},
		    {data: "stockName"},
		    {data: "insertTime"},
		    {data: "insertUserName"},
		    {data: "status"},
		    {data: null}],
		    columnDefs: [{
				 //入职时间
				 targets: 3,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonDateFormat(data);
					 }else{
						 return '';
					 }
					
			       }	       
			},{
					 //入职时间
					 targets: 5,
					 render: function (data, type, row, meta) {
						 if(data==0){return '新建'}else if(data==1){return '使用中'}else{return '已停用'};
						
				       }	       
				},{
			    	 //操作栏
			    	 targets: 6,
			    	 render: function (data, type, row, meta) {	
			    		 if(row.status==0){
				        		return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
					               +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
					               +'<a class="table-upload" onclick="dosetdetil('+ row.id +')">流程设置</a>'
					               + '<a class="table-edit" onclick="modifyY('+ row.id +')">启用</a>' ;
				        	}else if(row.status==1){
				        		return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'
					               +'<a class="table-edit" onclick="modifyN('+ row.id +')">停用</a>' ;
				        	}else if(row.status==2){
				        		return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'
					                +'<a class="table-edit" onclick="modifyY('+ row.id +')">启用</a>';
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
		 "sAjaxSource": "${ctx}/basicSetting/processMng/getListData", //获取数据的ajax方法的URL	
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
				 columns: [{ data: "rownum" ,"width": "4%"},
						    {data: "processName","width": "26%"},
						    {data: "stockName","width": "15%"},
						    {data: "insertTime","width": "15%"},
						    {data: "insertUserName","width": "10%"},
						    {data: "status","width": "10%"},
						    {data: null,"width": "15%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 3,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }
									
							       }	       
							},{
									 //入职时间
									 targets: 5,
									 render: function (data, type, row, meta) {
										 if(data==0){return '新建'}else if(data==1){return '使用中'}else{return '已停用'};
										
								       }	       
								},{
							    	 //操作栏
							    	 targets: 6,
							    	 render: function (data, type, row, meta) {			    		
							    		 if(row.status==0){
								        		return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
									               +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
									               +'<a class="table-upload" onclick="dosetdetil('+ row.id +')">流程设置</a>'
									               + '<a class="table-edit" onclick="modifyY('+ row.id +')">启用</a>' ;
								        	}else if(row.status==1){
								        		return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'
									               +'<a class="table-edit" onclick="modifyN('+ row.id +')">停用</a>' ;
								        	}else if(row.status==2){
								        		return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'
									                +'<a class="table-edit" onclick="modifyY('+ row.id +')">启用</a>';
								        	}	    				                 
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	//getstock();
	//getCarShop();
})
/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var name=$("#fom_name").val(); 
	   var fom_status=$("#fom_status").find("option:selected").val();   
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				processName :$.trim(name) ,
				status : $.trim(fom_status)	
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
												
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

	
/* 删除流程类型信息*/
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除业务流程信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/basicSetting/processMng/delete/"+id,
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
							} else {
								bootbox.alert(data.msg);
							}
						}
						
					}); 
			  }
		  }
	})
};

/*绑定项目名称*/
function binditem(){
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/itemTypeMng/getAllData",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				if(data.data.length>0){
					for(var i=0;i<data.data.length;i++){
						$("#processName").append("<option value='" + data.data[i].id + "'>" + data.data[i].name + "</option>");
					}
				
				}
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
}
/*绑定仓库*/
function bindstock(){
	$.ajax({
		type : 'POST',
		url : "${ctx}/basicSetting/stockMng/getStockList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.log(JSON.stringify(data.data));	
				if(data.data.length>0){
					for(var i=0;i<data.data.length;i++){
						$("#stock").append("<option value='" + data.data[i].id + "'>" + data.data[i].name + "</option>");	
					}
				
				}
				
			} else {
				 bootbox.alert(data.msg);
				//jQuery.messager.alert('提示:',data.msg,'info');selected="selected" 
			}
			
		}
	});
}
/*新增信息输入  */
function doadd(){
	clear();
	$('#addBtn').show();//editstatus
	$('#editBtn').hide();
	$('#editstatus').hide();
	$('#myModalLabel').html('新增业务流程信息');	
	$('#modal-info').modal('show');
	binditem();
	bindstock();
}
/* 关闭窗体 */
function refresh(){
	clear();
	$('#modal-info').modal('hide');
	
}
/* 数据重置 */
function clear(){
	$('#id-hidden').val('');	
	$('#processName').val('');
	$('#stock').val('');
}
/* 保存新增外协单位信息 */
function save(){
	var flag="false";
	var processName=$("#processName").find("option:selected").val(); 
	var stock=$("#stock").find("option:selected").val(); 
	if(processName==''){
		bootbox.alert('名称不能为空！');
		return;
	}
	if(stock==''){
		bootbox.alert('仓库不能为空！');
		return;
	}	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增业务流程信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/processMng/save',
						data : JSON.stringify({
							itemTypeId : processName,											
							stockId : stock,
				  			status:0
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
		})
}
//打开编辑页面
function doedit(id){	
	clear();
	binditem();
	bindstock();
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/processMng/getDetailData/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑业务流程信息');
				$("#processName").find("option[value='"+data.data.itemTypeId+"']").attr("selected",true);;
				$("#stock").find("option[value='"+data.data.stockId+"']").attr("selected",true);
				$("#status").find("option[value='"+data.data.status+"']").attr("selected",true);
				$('#addBtn').hide();
				$('#editBtn').show();
				$('#editstatus').show();
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
	var processName=$("#processName").val(); 
	var stock=$("#stock").find("option:selected").val(); 
	if(processName==''){
		bootbox.alert('名称不能为空！');
		return;
	}
	if(stock==''){
		bootbox.alert('仓库不能为空！');
		return;
	}
	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该业务流程信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/processMng/save',
						data : JSON.stringify({
							id : id,
							itemTypeId : $.trim($('#processName').val()),
				  			stockId : $.trim($('#stock').val()),
				  			status:$.trim($('#status').val())
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "更新成功！", 
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
		})
}
//停用
function modifyN(id){
	//console.log(JSON.stringify(id)); 	
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要停用吗?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/basicSetting/processMng/modifyStatus/"+id+"/N",				
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "停用成功！", 
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
										location.reload();
										 $('.bootbox').modal('hide');
									}
								},3000);
							} else {
								 bootbox.alert(data.msg);
								//jQuery.messager.alert('提示:',data.msg,'info'); 
							}
							
						}
					});
			  }
		  }
		});
}
//启用
function modifyY(id){
	//console.log(JSON.stringify(id));
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要启用吗?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/basicSetting/processMng/modifyStatus/"+id+"/Y",				
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "启用成功！", 
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
										location.reload();
										 $('.bootbox').modal('hide');
									}
								},3000);
							} else {
								 bootbox.alert(data.msg);
								//jQuery.messager.alert('提示:',data.msg,'info'); 
							}
							
						}
					});
			  }
		  }
		});
}
function cleardetil(){
	$('#processid').val('');
	$('#newsetporce0').val('');	
	$('#newuser0').val('');
	$('#newuserid0').val('');	
	$('#type0').val('');	
	 $('.editclass').remove(); 	
}
//流程设置
function dosetdetil(id){
	cleardetil();
	$('#modal-setprice').modal('show');
	$('#uploadBtn').show();
	$("#processid").val(id);
	 $.ajax({
			type : 'GET',
			url : "${ctx}/basicSetting/processMng/getProcessDetailList/"+id,				
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.log(JSON.stringify(data.data));
					var html="";
					if(data.data.length>0){
						for(var i=0;i<data.data.length;i++){
							if(data.data[i]['operateUserName']==null){
								data.data[i]['operateUserName']='';
							}
							if(i==0){
								$("#newsetporce0").val(data.data[i]['name']);
								$("#newuser0").val(data.data[i]['operateUserName']);
								$("#newuserid0").val(data.data[i]['operateUserId']);
								$("#type0").val(data.data[i]['type']);
								$("#needSuggestFlag0").val(data.data[i]['needSuggestFlag']);	
							}else{
								if(data.data[i]['type']=='0'&&data.data[i]['needSuggestFlag']=='Y'){
									html+='<div class="addclass border-b-ff9a00 detailList editclass" id="detailList'+i+'">'
								      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title" style="padding-top: 10px;"><span class="red">*</span>节点名称:</label></div></div>'       
								      +'<div class="col-xs-9"><div class="form-contr"><input id="newsetporce'+i+'" name="newsetporce'+i+'" value="'+data.data[i]['name']+'"  type="text" class="form-control" placeholder="请填写名称"/></div></div></div>'
								      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title"><span class="red">*</span>操作人:</label></div></div>'
								      +'<div class="col-xs-9"><div class="form-control" style="border:0;padding:0"><input id="newuser'+i+'" type="text" readonly="readonly"  value="'+data.data[i]['operateUserName']+'" style="width:70%;height: 35px;margin-top: 5px;margin-right: 5px;" />'
								      +'<input class="form-control" id="newuserid'+i+'" value="'+data.data[i]['operateUserId']+'" type="hidden"/><a class="selectBtn" id="selectBtn" onclick="newmodel('+i+');">选择</a><a class="selectBtn" id="selectBtn" style="margin-left:5px;" onclick="removemodel('+i+');">清除</a></div></div></div>'
								      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title" style="padding-top: 10px;"><span class="red">*</span>操作类型:</label></div></div>'       
								      +'<div class="col-xs-9"><div class="form-contr"><select id="type'+i+'" class="form-control"><option value="">请选择操作类型</option><option value="0" selected="selected">审核操作</option><option value="1">确认操作</option></select></div></div></div>'
								      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title" style="padding-top: 10px;width: 170px;"><span class="red">*</span>是否需要填写审核意见:</label></div></div>'       
								      +'<div class="col-xs-9"><div class="form-contr"><select id="needSuggestFlag'+i+'" class="form-control"><option value="Y" selected="selected">是</option><option value="N">否</option></select></div></div></div>'
								      +'<div class="row newrow"><div class="col-xs-10"></div><div class="col-xs-2 pd-2"><div class="form-contr-1"> <a class="delete-detail fr" onclick="deletindex(this,'+i+');"><i class="icon-minus-sign" style="display: inline-block;width: 20px;"></i>删除</a></div></div></div>'
								      +'</div>'; 
								}else if(data.data[i]['type']=='0'){
									html+='<div class="addclass border-b-ff9a00 detailList editclass" id="detailList'+i+'">'
								      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title" style="padding-top: 10px;"><span class="red">*</span>节点名称:</label></div></div>'       
								      +'<div class="col-xs-9"><div class="form-contr"><input id="newsetporce'+i+'" name="newsetporce'+i+'" value="'+data.data[i]['name']+'"  type="text" class="form-control" placeholder="请填写名称"/></div></div></div>'
								      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title"><span class="red">*</span>操作人:</label></div></div>'
								      +'<div class="col-xs-9"><div class="form-control" style="border:0;padding:0"><input id="newuser'+i+'" type="text" readonly="readonly"  value="'+data.data[i]['operateUserName']+'" style="width:70%;height: 35px;margin-top: 5px;margin-right: 5px;" />'
								      +'<input class="form-control" id="newuserid'+i+'" value="'+data.data[i]['operateUserId']+'" type="hidden"/><a class="selectBtn" id="selectBtn" onclick="newmodel('+i+');">选择</a><a class="selectBtn" id="selectBtn" style="margin-left:5px;" onclick="removemodel('+i+');">清除</a></div></div></div>'
								      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title" style="padding-top: 10px;"><span class="red">*</span>操作类型:</label></div></div>'       
								      +'<div class="col-xs-9"><div class="form-contr"><select id="type'+i+'" class="form-control"><option value="">请选择操作类型</option><option value="0" selected="selected">审核操作</option><option value="1">确认操作</option></select></div></div></div>'
								      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title" style="padding-top: 10px;width: 170px;"><span class="red">*</span>是否需要填写审核意见:</label></div></div>'       
								      +'<div class="col-xs-9"><div class="form-contr"><select id="needSuggestFlag'+i+'" class="form-control"><option value="Y" selected="selected">是</option><option value="N" >否</option></select></div></div></div>'
								      +'<div class="row newrow"><div class="col-xs-10"></div><div class="col-xs-2 pd-2"><div class="form-contr-1"> <a class="delete-detail fr" onclick="deletindex(this,'+i+');"><i class="icon-minus-sign" style="display: inline-block;width: 20px;"></i>删除</a></div></div></div>'
								      +'</div>'; 
								}else{
									html+='<div class="addclass border-b-ff9a00 detailList editclass" id="detailList'+i+'">'
								      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title" style="padding-top: 10px;"><span class="red">*</span>节点名称:</label></div></div>'       
								      +'<div class="col-xs-9"><div class="form-contr"><input id="newsetporce'+i+'" name="newsetporce'+i+'" value="'+data.data[i]['name']+'"  type="text" class="form-control" placeholder="请填写名称"/></div></div></div>'
								      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title">操作人:</label></div></div>'
								      +'<div class="col-xs-9"><div class="form-control" style="border:0;padding:0"><input id="newuser'+i+'"  type="text" readonly="readonly"  value="'+data.data[i]['operateUserName']+'" style="width:70%;height: 35px;margin-top: 5px;margin-right: 5px;" />'
								      +'<input class="form-control" id="newuserid'+i+'" value="'+data.data[i]['operateUserId']+'" type="hidden"/><a class="selectBtn" id="selectBtn" onclick="newmodel('+i+');">选择</a><a class="selectBtn" id="selectBtn" style="margin-left:5px;" onclick="removemodel('+i+');">清除</a></div></div></div>'
								      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title" style="padding-top: 10px;"><span class="red">*</span>操作类型:</label></div></div>'       
								      +'<div class="col-xs-9"><div class="form-contr"><select id="type'+i+'" class="form-control"><option value="">请选择操作类型</option><option value="0" >审核操作</option><option value="1" selected="selected">确认操作</option></select></div></div></div>'
								      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title" style="padding-top: 10px;width: 170px;"><span class="red">*</span>是否需要填写审核意见:</label></div></div>'       
								      +'<div class="col-xs-9"><div class="form-contr"><select id="needSuggestFlag'+i+'" class="form-control"><option value="Y" selected="selected">是</option><option value="N">否</option></select></div></div></div>'
								      +'<div class="row newrow"><div class="col-xs-10"></div><div class="col-xs-2 pd-2"><div class="form-contr-1"> <a class="delete-detail fr" onclick="deletindex(this,'+i+');"><i class="icon-minus-sign" style="display: inline-block;width: 20px;"></i>删除</a></div></div></div>'
								      +'</div>'; 
								}
								
							}
						}						
						$('#detailList0').after(html);
					}
				} else {
					 bootbox.alert(data.msg);
					//jQuery.messager.alert('提示:',data.msg,'info'); 
				}
				
			}
		}); 
}
/* 新增业务流程信息 */
function newadd(){
	 var index=$('.detailList').length;
	   var html='<div class="addclass border-b-ff9a00 detailList editclass" id="detailList'+index+'">'
      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title" style="padding-top: 10px;"><span class="red">*</span>节点名称:</label></div></div>'       
      +'<div class="col-xs-9"><div class="form-contr"><input id="newsetporce'+index+'" name="newsetporce'+index+'" type="text" class="form-control" placeholder="请填写名称"/></div></div></div>'
      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title"><span class="red">*</span>操作人:</label></div></div>'
      +'<div class="col-xs-9"><div class="form-control" style="border:0;padding:0"><input id="newuser'+index+'" value="" type="text" readonly="readonly" style="width:70%;height: 35px;margin-top: 5px;margin-right: 5px;" />'
      +'<input class="form-control" id="newuserid'+index+'" type="hidden"/><a class="selectBtn" id="selectBtn" onclick="newmodel('+index+');">选择</a> <a class="selectBtn" id="selectBtn" onclick="removemodel('+index+');">清除</a></div></div></div>'
      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title" style="padding-top: 10px;"><span class="red">*</span>操作类型:</label></div></div>'       
      +'<div class="col-xs-9"><div class="form-contr"><select id="type'+index+'" class="form-control"><option value="">请选择操作类型</option><option value="0">审核操作</option><option value="1">确认操作</option></select></div></div></div>'
      +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title" style="padding-top: 10px;width: 170px;"><span class="red">*</span>是否需要填写审核意见:</label></div></div>'       
      +'<div class="col-xs-9"><div class="form-contr"><select id="needSuggestFlag'+index+'" class="form-control"><option value="Y" selected="selected">是</option><option value="N">否</option></select></div></div></div>'
      +'<div class="row newrow"><div class="col-xs-10"></div><div class="col-xs-2 pd-2"><div class="form-contr-1"> <a class="delete-detail fr" onclick="deletindex(this,'+index+');"><i class="icon-minus-sign" style="display: inline-block;width: 20px;"></i>删除</a></div></div></div>'
      +'</div>'; 
      $('#detailList'+(index-1)+'').after(html);
}
/**操作人弹出框**/
function newmodel(index){
	getTree();
	$('#usertable').dataTable({
		"destroy": true,//如果需要重新加载的时候请加上这个
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息	
		 select: true,
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
		data: [],
        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
        columns: [	
            { data: 'rownum' },
            { data: 'id' },
            { data: 'name' }
        ]
	});
	$("#lindex").val(index);
	$("#modal-setuser").modal({show:true});//operBtn
	$('#operBtn').show();
}
/**选中操作人**/
function usersave(){
	var table = $('#usertable').DataTable();	
	var userid=table.rows('.selected').data()[0].id;
	var username=table.rows('.selected').data()[0].name;
	var index=$("#lindex").val();
	//console.log('dfsdfsdf'+username);
	$("#newuser"+index).val(username);
	$("#newuserid"+index).val(userid);
	$('#modal-setuser').modal('hide');
}

function deletindex(e,index){
	//console.info(JSON.stringify(e));
	var html=$('#detailList'+(index)+'').html();
	//console.info(JSON.stringify(html));	
	$('#detailList'+(index)+'').removeClass("border-b-ff9a00");
	$('#detailList'+(index)+'').html('');
}

/**流程设置保存**/
 function finishsave(){
	 var flag="false";
	 var newArray = [];
	  var objes={};
	  objes.id=$("#processid").val();
	     var objs=[];
		 var objList={};
		 var j=0;
	  var detailList=$('.detailList').length;
		 for(var i=0;i<detailList;i++){
			 var html=$('#detailList'+(i)+'').html();			
			 var objItem={};
			 if(html!=''){
				if($('#newsetporce'+i+'').val()==null || $('#newsetporce'+i+'').val()==''){
					 bootbox.alert('请输入第'+(j+1)+'个节点名称！');
					 return;
				 }else{
					 objItem.name=$('#newsetporce'+i+'').val();
				 }
				/* if($('#newuserid'+i+'').val()==null || $('#newuserid'+i+'').val()==''){
					 bootbox.alert('请选择第'+(j+1)+'个操作人！');
					 return;
				 }else{
					 objItem.operateUserId=$('#newuserid'+i+'').val();
				 } */
				if($('#type'+i+'').val()==null || $('#type'+i+'').val()==''){
					 bootbox.alert('请选择第'+(j+1)+'个操作类型！');
					 return;
				 }else{
					 objItem.type=$('#type'+i+'').val();
				 }
				 //objItem.orderNo=j;
				 objItem.operateUserId=$('#newuserid'+i+'').val();
				 objItem.processId=$("#processid").val();
				 objItem.needSuggestFlag=$('#needSuggestFlag'+i+'').val();
				j=j+1; 				
				objs.push(objItem);
			 }
						
		 }
	  objes.detailList=objs;	
	  //console.info(JSON.stringify(objes));
	  bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存吗?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
				  		type : 'POST',
				  		url : "${ctx}/basicSetting/processMng/saveProcessDetailList",
				  		data : JSON.stringify({	
				  			id:$.trim($("#processid").val()),
				  			detailList : objs
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
				  				//jQuery.messager.alert('提示:',data.msg,'info'); 
				  			}
				  			
				  		}
				  	});				
			  }
		  }
		})
}

 /*关闭*/
 function finishrefresh(){
 	$('#modal-setprice').modal('hide');
 }
//查看
function doview(id){
	cleardetils();
	 $.ajax({
			type : 'GET',
			url : "${ctx}/basicSetting/processMng/getProcessDetailList/"+id,				
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.log(JSON.stringify(data.data));	
					if(data.data.length>0){
						var htmls='';
						if(data.data.length>0){							
							for(var m=0;m<data.data.length;m++){
								if(data.data[m]['type']=='0'){
									data.data[m]['typename']='审核操作';
								}else{
									data.data[m]['typename']='确认操作';
								}
								if(data.data[m]['needSuggestFlag']=='Y'){
									data.data[m]['needSuggestFlagname']='是';
								}else{
									data.data[m]['needSuggestFlagname']='否';
								}
								if(data.data[m]['operateUserName']==null||data.data[m]['operateUserName']=='null'){
									data.data[m]['operateUserName']='';
								}
								var html='';
								html+='<div class="detile"><div class="add-item col-xs-12 "> <label class="title col-xs-2">节点名称：</label> <div class="col-xs-9"><div class="form-contr"><p class="form-control no-border" style="margin-top: -8px;">'+data.data[m]['name']+'</p></div></div> </div>';
								html+='<div class="add-item col-xs-12"> <label class="title col-xs-2">操作人：</label> <div class="col-xs-9"><div class="form-contr"><p class="form-control no-border" style="margin-top: -8px;">'+data.data[m]['operateUserName']+'</p></div></div> </div>';
								html+='<div class="add-item col-xs-12"> <label class="title col-xs-2">操作类型：</label> <div class="col-xs-9"><div class="form-contr"><p class="form-control no-border" style="margin-top: -8px;">'+data.data[m]['typename']+'</p></div></div> </div>';
								html+='<div class="add-item col-xs-12"> <label class="title col-xs-3" style="width:190px;">是否需要填写审核意见：</label> <div class="col-xs-8"><div class="form-contr"><p class="form-control no-border" style="margin-top: -8px;">'+data.data[m]['needSuggestFlagname']+'</p></div></div> </div>';		
								htmls+=html;
								htmls+='<hr class="tree"></hr> </div>';
							}
						}	
						$('#detilinfo').after(htmls);
						$('#modal-procedetinfo').modal('show');						
						$('#viewBtn').show();
						//console.log(JSON.stringify(html));						
						//弹框
						/* bootbox.dialog({
							 title : "流程设置明细",
							message: "<div class='well ' style='margin-top:5px;'><form class='form-horizontal' role='form'>"+htmls+"</form></div>",
							buttons:
							{
								"cancer" :
								{
									"label" : "关闭",
									"className" : "btn-sm icon-info",
									"callback": function() {
										//Example.show("uh oh, look out!");
									}
								}
							}
						});	 */
					}else{
						 bootbox.alert('未设置流程！');
					}
					
				} else {
					 bootbox.alert(data.msg);
					//jQuery.messager.alert('提示:',data.msg,'info'); 
				}
				
			}
		});

}
function cleardetils(){
	 $('.detile').remove();
}
/**选择操作人弹框关闭**/
 function userrefresh(){
	 //$("#modal-setuser").modal({show:true});//operBtn
	 $('#modal-setuser').modal('hide');
}

function doclose(){
	$('#modal-procedetinfo').modal('hide');			
}
//加载时获取树结构
function getTree(){
	$.ajax({  
        url: '${ctx}/commonSetting/departmentSetting/getListData',  
        type: "post",  
        dataType: 'json',
        data: '',
        success: function (data) {  
            if(data.code == 200){  
            	$.fn.zTree.init($("#tree"), setting, data.data);
            	$.fn.zTree.getZTreeObj("tree").expandAll(true);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}
/*清除所选人*/
function removemodel(index){
	$('#newuser'+index).val('');
	$('#newuserid'+index).val('');
}
</script>



</body>
</html>






