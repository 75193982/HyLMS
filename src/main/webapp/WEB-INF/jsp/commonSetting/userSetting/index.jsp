
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
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			公共设置
			<small>
				<i class="icon-double-angle-right"></i>
				人员管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">查询条件：</label>
		   <input id="searchInfo" class="form-box" type="text" placeholder="工号/姓名/手机号"/>
		   <label class="titletwo">部门：</label>
		    <select id="form-pDep" class="form-box">
			</select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="addUser()">新增</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>姓名</th>
                    <th>部门</th>
                    <th>职位</th>
                    <th>仓库</th>
                    <th>性别</th>
                    <th>手机号码</th>
                    <th>集团短号</th>
                    <th>是否是驾驶员</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" onclick="refresh()">×</button>
					<h3 id="myModalLabel">新增员工</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
							   <div class="widget-main">
								 <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>姓名：</label>
								     <input class="form-control" id="name" type="text" placeholder="请输入姓名"/>
								 </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>手机号码：</label>
								     <input class="form-control" id="userTel" type="text" placeholder="请输入手机号码"/>
								    </div>
								   <hr class="tree"></hr>
								  <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>部门：</label>
								     <select class="form-control" id="depName">
									</select>
								  </div>
								   <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>角色：</label>
								     <input class="form-control" id="userRole" type="text" placeholder="请选择角色" readonly="readonly" style="width:61%;margin-right:2%;"/>
								     <input id="userRoleId-hidden" type="hidden" />
								     <a class="selectBtn" id="selectBtn" onclick="showControl(this)">选择</a>
								     <!-- <select class="form-control" id="userRole">
									</select> -->
								  </div>
								  <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>驾驶员：</label>
								     <select class="form-control" id="userDrinker">
								      <option value='N' selected='selected'>否</option>
								      <option value='Y'>是</option>
									</select>
								  </div>
								  <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>岗位：</label>
								     <select class="form-control" id="dutyId">								      
									</select>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-itemSec">
								     <label class="title">仓库：</label>
								     <select class="form-control" id="userStore">
									</select>
								  </div>
								  <p style="margin-left:120px;"><span class="red">*如果是仓管员，调度员角色必须要选择仓库</span></p>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title">上级人员：</label>
								     <select class="form-control" id="parentName">
									</select>
								  </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title">工号：</label>
								     <input class="form-control" id="code" type="text" placeholder="请输入工号"/>
								     <input class="form-control" id="id-hidden" type="hidden"/>
								  </div>
								  <hr class="tree"></hr>
								    <div class="add-item extra-itemSec">
								     <label class="title">职位：</label>
								     <input class="form-control" id="userTitle" type="text" placeholder="请输入职位"/>
								    </div>
								   <hr class="tree"></hr>
								  <div class="add-item extra-itemSec">
								     <label class="title">性别：</label>
								     <select class="form-control" id="userSex">
								      <option value='1'>男</option>
								      <option value='0'>女</option>
									</select>
								  </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title">身份证号码：</label>
								     <input class="form-control" id="userCard" type="text" placeholder="请输入身份证"/>
								    </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title">生日：</label>
								     <div class="input-group input-group-sm w75">
										<input class="form-control" id="userBirth" type="text" placeholder="请输入生日"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>
									</div>
								    </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title">联系电话：</label>
								     <input class="form-control" id="userPhone" type="text" placeholder="请输入联系电话"/>
								    </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title">集团短号：</label>
								     <input class="form-control" id="userExtra" type="text" placeholder="请输入集团短号"/>
								    </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title">家庭住址：</label>
								     <input class="form-control" id="userAddress" type="text" placeholder="请输入家庭住址"/>
								    </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title">入职时间：</label>
								     <div class="input-group input-group-sm w75">
										<input type="text" id="datepickerIn" class="form-control" placeholder="请选择入职时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>
									</div>
								    </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title">合同签订时间：</label>
								     <div class="input-group input-group-sm w75">
										<input type="text" id="datepicker" class="form-control" placeholder="请选择合同签订时间"/>
										<span class="input-group-addon">
											<i class="icon-calendar"></i>
										</span>
									</div>
								   </div>
								   <hr class="tree"></hr>
								   <!-- <div class="add-item extra-itemSec">
								     <label class="title">从业资格证：</label>
								     <input class="form-control" id="userWorkno" type="text" placeholder="从业资格证号码"/>
								    </div>
								    <hr class="tree"></hr> -->
								    <div class="add-item extra-itemSec">
								     <label class="title">排序：</label>
								     <input class="form-control" id="orderId" type="text" placeholder="请输入排序号" value="999"/>
								    </div>
								    <hr class="tree"></hr>
								    <div class="add-item-btn" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="save();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="refresh();">取消</a>
									 </div>
									 <div class="add-item-btn" id="editBtn">
									    <a class="add-itemBtn btnOk" onclick="update()">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="refresh()">取消</a>
									  </div> 
									</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
		
		</div>
	</div>
	<!-- 获取角色信息Modal--begin -->
	     <div class="modal modal-reset fade" id="modal-role" tabindex="-1" role="dialog" data-backdrop="static" style="width:650px;">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="cancleRole();">×</button>
						<h3>获取角色信息</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box" style="border-bottom:0;">
							<div class="widget-body" style="border:0;">
								<div class="widget-main" style="padding: 3px;">
									<table id="userListTable" class="table table-striped table-bordered table-hover">
					                      <thead>
						                    <tr>	
							                    <th class="center"><input type="checkbox" class="checkall" /></th>													
												<th>角色名称</th>                                                                                                         
						                     </tr>
					                      </thead>
					                      <tbody>
					                      </tbody>
					                </table>
								     <div class="add-item-btn dis-block" id="addBtn">
								        <a class="add-itemBtn btnOk" onclick="saveRole();">保存</a>
								        <a class="add-itemBtn btnCancle" onclick="cancleRole();">取消</a>
								     </div>
								 </div>
							</div>
					     </div>
					   </div> 
					  </div>
					</div>
				 </div>	  
	
	<!-- 获取角色信息Modal--end -->
	<!-- 新增密码Modal--begin -->
	     <div class="modal fade" id="modal-pwd" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="pwdCancle();">×</button>
						<h3>密码重置</h3>
				    </div>
					<div class="modal-body" style="padding: 10px 20px;">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main" style="padding: 3px;">
									<div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>重置密码：</label>
								     <input class="form-control" id="pwdInfo" type="text" placeholder="请输入密码"/>
								     <input type="hidden" id="restPwdId"/>
								    </div>
								    <hr class="tree"></hr>
								     <div class="add-item-btn dis-block" id="addBtn">
								        <a class="add-itemBtn btnOk" onclick="resetPwd();">保存</a>
								        <a class="add-itemBtn btnCancle" onclick="pwdCancle();">取消</a>
								     </div>
								 </div>
							</div>
					     </div>
					   </div> 
					  </div>
					</div>
				 </div>	  
	
	<!-- 新增密码Modal--end -->
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
		 "sAjaxSource": "${ctx}/commonSetting/userSetting/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum","width":"6%"},
		    {data: "name","width":"10%"},
		    {data: "departmentName","width":"9%"},
		    {data: "title","width":"9%"},
		    {data: "stockName","width":"10%"},
		    {data: "sex","width":"6%"},
		    {data: "mobile","width":"10%"},
		    {data: "shortMobile","width":"10%"},
		    {data: "driverFlag","width":"10%"},
		    {data: null,"width":"20%"}],
		    columnDefs: [
				{
					 //性别
					 targets: 5,
					 render: function (data, type, row, meta) {
						 if(data=="1"){
							return '男';
						 }else if(data=="0"){
							 return '女'; 
						 }else{
							 return '';
						 }
				       }	       
				},
				{
					 //是否是司机
					 targets: 8,
					 render: function (data, type, row, meta) {
						 if(data=='Y'){
							return '是';
						 }else{
							 return '否'; 
						 }
				       }	       
				},
		      	{
			    	 //操作栏
			    	 targets: 9,
			    	 render: function (data, type, row, meta) {
		                    return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
						           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
						           +'<a class="table-resetPwd" onclick="dopwd('+ row.id +')">重置密码</a>';
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
		 "sAjaxSource": "${ctx}/commonSetting/userSetting/getListData" , //获取数据的ajax方法的URL	
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
				columns: [{ data: "rownum","width":"6%"},
						    {data: "name","width":"10%"},
						    {data: "departmentName","width":"9%"},
						    {data: "title","width":"9%"},
						    {data: "stockName","width":"10%"},
						    {data: "sex","width":"6%"},
						    {data: "mobile","width":"10%"},
						    {data: "shortMobile","width":"10%"},
						    {data: "driverFlag","width":"10%"},
						    {data: null,"width":"20%"}],
						    columnDefs: [
								{
									 //性别
									 targets: 5,
									 render: function (data, type, row, meta) {
										 if(data=="1"){
											return '男';
										 }else if(data=="0"){
											 return '女'; 
										 }else{
											 return '';
										 }
								       }	       
								},
								{
									 //是否是司机
									 targets: 8,
									 render: function (data, type, row, meta) {
										 if(data=='Y'){
											return '是';
										 }else{
											 return '否'; 
										 }
								       }	       
								},
						      	{
							    	 //操作栏
							    	 targets: 9,
							    	 render: function (data, type, row, meta) {
						                    return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
										           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
										           +'<a class="table-resetPwd" onclick="dopwd('+ row.id +')">重置密码</a>';
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	getDep();
	bindParentName();
	/* bindRole(); */
	bindStore();
})

/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var departmentId=$("#form-pDep").find("option:selected").val(); 
	   if(departmentId=='' || departmentId==null ||departmentId=='1'){
		   departmentId="";
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
				departmentId : departmentId,
				driverFlag : '',
				searchInfo : $.trim($('#searchInfo').val())
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
/* 部门绑定 */
	function getDep(){
		$.ajax({  
            url: '${ctx}/commonSetting/userSetting/getDepartmentList',  
            type: "post",  
            contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
            data: '',
            success: function (data) {
            	/* var html ='<option value="-1">请选择部门</option>'; */
            	var html ="";
                if(data.code == 200){  
                	if(data.data!=null && data.data!=''){
                		if(data.data.length>0){
                			for(var i=0;i<data.data.length;i++){
                    			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                    		}
                		}
                	}
                	$('#form-pDep').html(html);
                   }else{  
                	   bootbox.alert('加载失败！');
                   }  
            }  
          }); 
	}
	
/* 删除人员 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除人员信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/commonSetting/userSetting/delete/"+id,
						data :JSON.stringify({
							id :id
						}),
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
/* 新增员工信息 */
	/* 部门绑定 */
function bindDep(){
	$.ajax({  
        url: '${ctx}/commonSetting/userSetting/getDepartmentList',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: '',
        success: function (data) {
        	var html ='<option value="-1">请选择部门</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                		}
            		}
            	}
            	$('#depName').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}
/* 获取多个角色 */
	function showControl(e){
		bindRole();
		$('#modal-role').modal('show');
	}
	/* 获取角色 */
	function bindRole(){
		var size=0,all=0;
		 var ids =$('#userRoleId-hidden').val();
		 ids.substring(0, ids.length-1);
		 arr = ids.split(',');
		 var html='',htmlItem='';
		$.ajax({  
	        url: '${ctx}/commonSetting/userSetting/getRoleList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	all=data.data.length;
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	            				for(var j=0;j<arr.length;j++){
	    							if(data.data[i]["id"]==arr[j]){
	    								htmlItem ='<tr class="selected" data-id='+data.data[i]["id"]+'><td class="text-center"><input type="checkbox" checked="checked" class="checkchild"></td>'
		                				 +'<td>'+data.data[i]['name']+'</td></tr>';
	    								 size++;
	    								 break;
	    							}else{
	    								htmlItem ='<tr data-id='+data.data[i]["id"]+'><td class="text-center"><input type="checkbox" class="checkchild"></td>'
		                				 +'<td>'+data.data[i]['name']+'</td></tr>';
	    							}
	                		}
	            			html+=htmlItem;
	            		}
	            	}
	            	$('#userListTable tbody').html(html);
	            	if(size==all && size>0){
						 checkChoose(true);
					 }else{
						 checkChoose(false); 
					 }
	               }
	            }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
	}
	/* 确认选择 */
	function checkChoose(flag){
		if(flag==true){
			$(".checkall").prop("checked",true); 
		}else{//不全选 
	        $(".checkall").prop("checked",false); 
	    } 
		 $(".checkall").on('click',function () {
		      var check = $(this).prop("checked");
		      $(".checkchild").prop("checked", check);
		      if(check==true){
		    	  $(".checkchild").parents('tr').addClass('selected');
		      }else{
		    	  $(".checkchild").parents('tr').removeClass('selected');
		      }
		});
	   
		$('#userListTable tbody').on( 'click', 'tr', function () {
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
	/* 关闭角色选择 */
	function cancleRole(){
		$('#modal-role').modal('hide');
	}

	/* 用户选择确认 */
	function saveRole(){
		var table=$('#userListTable tbody');
		var id="";
		var name=""
		for(i=0;i<table.children('tr.selected').length;i++){
			var obj=table.children('tr.selected').eq(i);
			id+=obj.attr("data-id")+',';
			name+=obj.find('td').eq(1).html()+',';
		}
		$('#userRoleId-hidden').val(id.substring(0, id.length-1));
		$('#userRole').attr('value',name.substring(0, name.length-1));
		$('#modal-role').modal('hide');
	}
	/* 获取上级 */
	function bindParentName(){
	$.ajax({  
        url: '${ctx}/commonSetting/userSetting/getParent',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: '',
        success: function (data) {
        	var html ='<option value="-1">请选择上级</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                		}
            		}
            	}
            	$('#parentName').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}
	/* 获取仓库 */
function bindStore(){
	$.ajax({  
        url: '${ctx}/commonSetting/userSetting/getStockList',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: '',
        success: function (data) {
        	var html ='<option value="-1">请选择仓库</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                		}
            		}
            	}
            	$('#userStore').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}
	
/* 获取岗位 */
function bindduty(){
	$.ajax({  
        url: '${ctx}/basicSetting/dutyMng/getAllData',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		data: JSON.stringify({
			name : ''
		}),
        success: function (data) {
        	var html ='<option value="-1">请选择岗位</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                		}
            		}
            	}
            	$('#dutyId').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}	
/*新增信息输入  */
function addUser(){
	clear();
	$('#addBtn').show();
	$('#editBtn').hide();
	$('#myModalLabel').html('新增员工');
	$("#datepickerIn").datepicker({
		 language: 'cn',
         autoclose: true,//选中之后自动隐藏日期选择框
         format: "yyyy-mm-dd"//日期格式
	});
	$("#datepicker").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#userBirth").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	bindDep();
	bindRole();
	bindStore();
	bindParentName();
	bindduty();
	$('#modal-info').modal('show');
}
/* 关闭窗体 */
function refresh(){
	clear();
	$('#modal-info').modal('hide');
	
}
/* 数据重置 */
function clear(){
	$('#id-hidden').val('');
	$('#code').val('');
	$('#name').val('');
	$('#depName').find("option[value='-1']").attr("selected",true);
	$('#parentName').find("option[value='-1']").attr("selected",true);
	$('#dutyId').find("option[value='-1']").attr("selected",true);
	$('#userTitle').val('');
	$('#userRole').find("option[value='-1']").attr("selected",true);
	$('#userStore').find("option[value='-1']").attr("selected",true);
	$('#userSex').val('1');
	$('#userCard').val('');
	$('#userBirth').val('');
	$('#userTel').val('');
	$('#userPhone').val('');
	$('#userExtra').val('');
	$('#userAddress').val('');
	$('#datepickerIn').val('');
	$('#datepicker').val('');
	$("#userDrinker").val("N");
	$('#userWorkno').val('');
	$('#orderId').val('999');
	$("#userRoleId-hidden").val('');
	$('#userRole').attr('value','');
}
/* 保存新增人员信息 */
function save(){
	var orderId=$('#orderId').val();
	var workNo=$('#code').val();
	var name=$('#name').val();
	var departmentId=$("#depName").find("option:selected").val(); 
	var title=$('#userTitle').val();
	var brithday=$('#userBirth').val();
	var sex=$("#userSex").find("option:selected").val(); 
	var telephone=$('#userPhone').val();
	var mobile=$('#userTel').val();
	var shortMobile=$('#userExtra').val();
	var address=$('#userAddress').val();
	var idCard=$('#userCard').val();
	var hiredate=$('#datepickerIn').val();
	var signmentTime=$('#datepicker').val();
	var driverFlag=$("#userDrinker").find("option:selected").val(); 
	var certificate=$('#userWorkno').val();
	var stockId=$("#userStore").find("option:selected").val(); 
	var roleId=$("#userRoleId-hidden").val();
	var roleName=$('#userRole').val();
	var salary=0;
	var discountLimit=0;
	var discountPoint=0;
	var parentId=$("#parentName").find("option:selected").val();
	var dutyId=$("#dutyId").find("option:selected").val();
	if(name==''|| name==null){
		bootbox.alert('姓名不能为空！');
		return;
	}
	if(departmentId==''|| departmentId==null || departmentId=='-1'){
		bootbox.alert('部门不能为空！');
		return;
	}
	if(roleName==''|| roleName==null || roleId=='' || roleId==null){
		bootbox.alert('角色不能为空！');
		return;
	}
	if(parentId==''|| parentId==null || parentId=='-1'){
		parentId="";
	}
	if(dutyId==''|| dutyId==null || dutyId=='-1'){
		dutyId="";
	}
	if(sex==''|| sex==null || sex=='-1'){
		sex="";
	}
	/* if(stockId==''|| stockId==null || stockId=='-1'){
		bootbox.alert('仓库不能为空！');
		return;
	} */
	if(mobile==''|| mobile==null){
		bootbox.alert('手机号码不能为空！');
		return;
	}
	if(dutyId==''){
		bootbox.alert('岗位不能为空！');
		return;
	}
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增人员信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/commonSetting/userSetting/save',
						data : JSON.stringify({
							workNo : workNo,				
							name : name,
							departmentId : departmentId,
							title : title,
							brithday : brithday,
							sex : sex,				
							telephone : telephone,
							mobile : mobile,
							shortMobile : shortMobile,
							address : address,
							idCard : idCard,				
							hiredate : hiredate,
							signmentTime : signmentTime,
							driverFlag : driverFlag,
							certificate : certificate,
							stockId : stockId,				
							roleId : roleId,
							salary : salary,
							parentId : parentId,
							orderId : orderId,
							dutyId : dutyId
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
											  reload();
											  $('#modal-info').modal('hide');
										  }else{
											  reload();
											  $('#modal-info').modal('hide');
										  }
									  }
								});
								setTimeout(function(){
									if(flag=="false"){
										reload();
										$('#modal-info').modal('hide');
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
function doedit(id){
	$("#datepickerIn").datepicker({
		 language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#datepicker").datepicker({
		language: 'cn',
       autoclose: true,//选中之后自动隐藏日期选择框
       format: "yyyy-mm-dd"//日期格式
	});
	$("#userBirth").datepicker({
		language: 'cn',
       autoclose: true,//选中之后自动隐藏日期选择框
       format: "yyyy-mm-dd"//日期格式
	});
	bindDep();
	bindRole();
	bindStore();
	bindduty();
	clear();
	$.ajax({
		type : 'GET',
		url : "${ctx}/commonSetting/userSetting/getDetailData/"+id,
		data :JSON.stringify({
			id :id
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑员工');
				$('#code').val(data.data.workNo);
				$('#name').val(data.data.name);
				if(data.data.departmentId==''|| data.data.departmentId==null || data.data.departmentId=='-1'){
					$('#depName').val('-1');
				}else{
					$('#depName').val(data.data.departmentId);
				}
				if(data.data.parentId==''|| data.data.parentId==null || data.data.parentId=='-1'){
					$('#parentName').val('-1');
				}else{
					$('#parentName').val(data.data.parentId);
				}
				$('#userTitle').val(data.data.title);
				$('#userRoleId-hidden').val(data.data.roleId);
				$('#userRole').attr('value',data.data.roleName);
				//$('#userStore').val(data.data.stockId);
				if(data.data.stockId==''|| data.data.stockId==null || data.data.stockId=='-1'){
					$('#userStore').val('-1');
				}else{
					$('#userStore').val(data.data.stockId);
				}
				//$('#dutyId').val(data.data.dutyId);
				if(data.data.dutyId==''|| data.data.dutyId==null || data.data.dutyId=='-1'){
					$('#dutyId').val('-1');
				}else{
					$('#dutyId').val(data.data.dutyId);
				}
				if(data.data.sex==''|| data.data.sex==null){
					$('#userSex').val('1');
				}else{
					$('#userSex').val(data.data.sex);
				}
				$('#userCard').val(data.data.idCard);
				if(data.data.brithday==''|| data.data.brithday==null){
					$('#userBirth').val('');
				}else{
					$('#userBirth').val(jsonForDateFormat(data.data.brithday));
				}
				$('#userTel').val(data.data.mobile);
				$('#userPhone').val(data.data.telephone);
				$('#userExtra').val(data.data.shortMobile);
				$('#userAddress').val(data.data.address);
				if(data.data.hiredate==''|| data.data.hiredate==null){
					$('#datepickerIn').val('');
				}else{
					$('#datepickerIn').val(jsonForDateFormat(data.data.hiredate));
				}
				if(data.data.signmentTime==''|| data.data.signmentTime==null){
					$('#datepicker').val('');
				}else{
					$('#datepicker').val(jsonForDateFormat(data.data.signmentTime));
				}
				if(data.data.driverFlag==''|| data.data.driverFlag==null || data.data.driverFlag=='-1'){
					$('#userDrinker').val('N');
				}else{
					$('#userDrinker').val(data.data.driverFlag);
				}
				//$("#userDrinker").val(data.data.driverFlag);
				$('#userWorkno').val(data.data.certificate);
				$('#orderId').val(data.data.orderId);
				$('#addBtn').hide();
				$('#editBtn').show();
				$('#modal-info').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}

/* 重置密码 */

function dopwd(id){
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要重置该人员密码信息?", 
		  callback: function(result){
			  if(result){
				 $("#restPwdId").val(id);
				 $("#pwdInfo").val('');
				 $('#modal-pwd').modal('show');
			  }
			 }
	  });
	
}

function resetPwd(){
	var flag="false";
	var id=parseInt($("#restPwdId").val());
	var password=$("#pwdInfo").val();
	if(password!='' && password!=null){
		bootbox.confirm_alert({ 
			  size: "small",
			  message: "确定要重置密码？", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : "${ctx}/commonSetting/userSetting/passwordReset",
							data : JSON.stringify({
								id:id,
								password:password
							}),
							contentType : "application/json;charset=UTF-8",
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {
									bootbox.confirm_alert({ 
										  size: "small",
										  message: "密码重置成功！", 
										  callback: function(result){
											  if(result){
												  flag="true";
												  $('#modal-pwd').modal('hide');
													reload();
											  }else{
												  $('#modal-pwd').modal('hide');
													reload();
											  }
										  }
									 });
									
									setTimeout(function(){
										if(flag=="false"){
											$('#modal-pwd').modal('hide');
											$('.bootbox').modal('hide');
											reload();  
										}
									},3000); 
								}else{
									bootbox.alert(data.msg);
								}
							}
						});
				  }
			  }
		 });
		 
	}else{
		bootbox.alert('请填写重置的密码！');
	}
	
	
}

function pwdCancle(){
	$('#modal-pwd').modal('hide');
	$("#pwdInfo").val('');
}

/* 更新 */
function update(){
	var id=$('#id-hidden').val();
	var orderId=$('#orderId').val();
	var workNo=$('#code').val();
	var name=$('#name').val();
	var departmentId=$("#depName").find("option:selected").val(); 
	var title=$('#userTitle').val();
	var brithday=$('#userBirth').val();
	var sex=$("#userSex").find("option:selected").val(); 
	var telephone=$('#userPhone').val();
	var mobile=$('#userTel').val();
	var shortMobile=$('#userExtra').val();
	var address=$('#userAddress').val();
	var idCard=$('#userCard').val();
	var hiredate=$('#datepickerIn').val();
	var signmentTime=$('#datepicker').val();
	var driverFlag=$("#userDrinker").find("option:selected").val(); 
	var certificate=$('#userWorkno').val();
	var stockId=$("#userStore").find("option:selected").val(); 
	var roleId=$("#userRoleId-hidden").val();
	var roleName=$('#userRole').val();
	var salary=0;
	var discountLimit=0;
	var discountPoint=0;
	var parentId=$("#parentName").find("option:selected").val();
	var password='123456';
	var dutyId=$("#dutyId").find("option:selected").val();
	if(name==''|| name==null){
		bootbox.alert('姓名不能为空！');
		return;
	}
	if(departmentId==''|| departmentId==null || departmentId=='-1'){
		bootbox.alert('部门不能为空！');
		return;
	}
	if(roleName==''|| roleName==null || roleId=='' || roleId==null){
		bootbox.alert('角色不能为空！');
		return;
	}
	if(parentId==''|| parentId==null || parentId=='-1'){
		parentId="";
	}
	if(dutyId==''|| dutyId==null || dutyId=='-1'){
		dutyId="";
	}
	if(sex==''|| sex==null || sex=='-1'){
		sex="";
	}
	/* if(stockId==''|| stockId==null || stockId=='-1'){
		bootbox.alert('仓库不能为空！');
		return;
	} */
	if(mobile==''|| mobile==null){
		bootbox.alert('手机号码不能为空！');
		return;
	}
	if(dutyId==''){
		bootbox.alert('岗位不能为空！');
		return;
	}
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该人员信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/commonSetting/userSetting/update',
						data : JSON.stringify({
							id : id,
							workNo : workNo,				
							name : name,
							departmentId : departmentId,
							title : title,
							brithday : brithday,
							sex : sex,				
							telephone : telephone,
							mobile : mobile,
							shortMobile : shortMobile,
							address : address,
							idCard : idCard,				
							hiredate : hiredate,
							signmentTime : signmentTime,
							driverFlag : driverFlag,
							certificate : certificate,
							stockId : stockId,				
							roleId : roleId,
							salary : salary,
							parentId : parentId,
							orderId : orderId,
							dutyId : dutyId
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
											  reload();
											  $('#modal-info').modal('hide');
										  }else{
											  reload();
											  $('#modal-info').modal('hide');
										  }
									  }
								});
								setTimeout(function(){
									if(flag=="false"){
										reload();
										$('#modal-info').modal('hide');
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

</script>



</body>
</html>






