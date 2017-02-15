
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
			基础信息管理
			<small>
				<i class="icon-double-angle-right"></i>
				津贴管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">名称：</label>
		   <input id="fom_name" class="form-box" type="text" style="width: 200px" placeholder="请填写名称" onkeyup="searchSchedule(this)"/>
		    <input id="fom_name_id" class="form-box" type="hidden" style="width: 240px" />
		  <!--  <select id="fom_name" class="form-box" >	</select> -->
		   <!--  <label class="title">结算方式：</label>
		   <select id="fom_balanceType" class="form-box" >
		   <option value="">请选择结算方式</option>
		   <option value="0">单价模式</option>
		   <option value="1">公里数模式</option>
		   <option value="2">总价模式</option>
		   	</select> -->
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="doadd()">新增</a>
		</div>
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>津贴名称</th>
                    <th>类型</th>
                    <th>创建时间</th>
                    <th>创建人</th>                               
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 新增津贴开始-->
			<div class="modal fade" id="modal-add" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:6%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="refresh();">×</button>
						<h3 id="myModalLabel">新增津贴信息</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>名称：</label>
								     <input class="form-control" id="name_add" type="text" placeholder="请输入名称"/>
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-item">
									     <label class="title"><span class="red">*</span>类型：</label>
									      <select id="type_add" class="form-control" >
		                                   <option value="">请选择类型</option>
		                                   <option value="0">补助</option>
		                                   <option value="1">罚扣</option>
		                                  </select>									    
									 </div>
							  		<hr class="tree"></hr>
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="save();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="refresh();">取消</a>
									 </div> 
									</div>
						       </div>
					     </div>
					  </div>
				   </div>
				 </div>
			 </div>
		   <!-- 新增津贴结束 -->
		   <!-- 编辑津贴开始 -->
			<div class="modal fade" id="modal-edit" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:6%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="updateCancle()">×</button>
						<h3>编辑津贴信息</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <div class="add-item extra-item">
								     <label class="title"><span class="red">*</span>名称：</label>
								     <input class="form-control" id="name_edit" type="text" placeholder="请输入名称"/>
								     <input type="hidden" id="id-hidden"/>
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-item">
									     <label class="title"><span class="red">*</span>类型：</label>
									      <select id="type_edit" class="form-control" >
		                                   <option value="">请选择类型</option>
		                                   <option value="0">补助</option>
		                                   <option value="1">罚扣</option>
		                                  </select>	
									 </div>
							  		<hr class="tree"></hr>
									 <div class="add-item-btn dis-block" id="editBtn">
									    <a class="add-itemBtn btnOk" onclick="update()">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="updateCancle()">取消</a>
									  </div>
									</div>
						  </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
			<!-- 编辑津贴结束 -->
		</div>
	</div>
</div>
<div id="selectItem8" class="selectItemhidden" style="height: 150px;">
	<div id="selectItemCount" class="selectItemcont">
		<div id="selectCarNo" style="height: 150px;">
											
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
function searchSchedule(e){
	var $val=$(e).val();
	$.ajax({
		type : 'POST',
		url : "${ctx}/basicSetting/salaryAllowanceTypeMng/getAllData",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		data: JSON.stringify({
			name : $val
		}),
		success : function(data) {
			if (data && data.code == 200) {
				var html = "";
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<p id='+data.data[i]['id']+' onclick=\'clickp(this)\'>'+data.data[i]['name']+'</p>';
	            		}
	        		}
	        	}
	        	$('#selectCarNo').html(html);
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
	var A_top = $(e).offset().top + $(e).outerHeight(true); //  1
	var A_left = $(e).offset().left;
	$('#selectItem8').show().css({
		"position" : "absolute",
		"top" : A_top + "px",
		"left" : A_left + "px"
	});
	
	if('' == $val)
	{
		$('#fom_name_id').val('');
		$('#selectItem8').hide();
	}
	
}

function clickp(e){
	$('#fom_name').val($(e).html());
	$('#fom_name_id').val($(e).attr('id'));
	$('#selectItem8').hide();
};
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/basicSetting/salaryAllowanceTypeMng/getListData" , //获取数据的ajax方法的URL							 
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
		    {data: "name","width":"10%"},
		   /*  {data: "receivingName"}, */
		    {data: "type","width":"10%"},
		    {data: "insertTime","width":"10%"},
		    {data: "insertUserName","width":"10%"},	    
		    {data: null,"width":"10%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 2,
				 render: function (data, type, row, meta){
					if(data=='0'){
						return '补助';
					}else if(data=='1'){
						return '罚扣';
					}else{
						return '';
					}
			       }	       
			},{
					 //入职时间
					 targets: 3,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
						
				       }	       
				},
		      	{
			    	 //操作栏
			    	 targets: 5,
			    	 render: function (data, type, row, meta) {
		                    return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
						           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
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
		 "sAjaxSource": "${ctx}/basicSetting/salaryAllowanceTypeMng/getListData", //获取数据的ajax方法的URL	
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
						    {data: "name","width":"10%"},
						   /*  {data: "receivingName"}, */
						    {data: "type","width":"10%"},
						    {data: "insertTime","width":"10%"},
						    {data: "insertUserName","width":"10%"},	    
						    {data: null,"width":"10%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 2,
								 render: function (data, type, row, meta){
									if(data=='0'){
										return '补助';
									}else if(data=='1'){
										return '罚扣';
									}else{
										return '';
									}
							       }	       
							},{
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
							    	 //操作栏
							    	 targets: 5,
							    	 render: function (data, type, row, meta) {
						                    return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
										           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	//BindSup();//绑定供应商
	//BindOutSour();//绑定供应商
})

/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var name=$("#fom_name").val(); 
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				name :$.trim(name),
				delFlag :'N'
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

	
/* 删除驳板价格信息 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除津贴信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/basicSetting/salaryAllowanceTypeMng/delete/"+id,
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

/*新增信息输入  */
function doadd(){
	clear();
	$('#modal-add').modal('show');
}
/* 关闭窗体 */
function refresh(){
	$('#modal-add').modal('hide');
	
}
/* 数据重置 */
function clear(){	
	$('#name_add').val('');
	$('#type_add').val('');
}
/* 保存新增津贴信息 */
function save(){
	var flag="false";
	var name=$('#name_add').val();
	var type=$('#type_add').val();	
	if(name==''|| name==null){
		bootbox.alert('名称不能为空！');
		return;
	}
	if(type==''|| type==null){
		bootbox.alert('类型不能为空！');
		return;
	}		
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增津贴信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/salaryAllowanceTypeMng/save',
						data : JSON.stringify({
							name : name,				
							type : type
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
											  $('#modal-add').modal('hide');
										  }else{
											 reload();
											 $('#modal-add').modal('hide');
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										 reload();
										 $('.bootbox').modal('hide');
										 $('#modal-add').modal('hide');
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
/**打开编辑页面**/
function doedit(id){	
	$('#id-hidden').val(id);
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/salaryAllowanceTypeMng/getDetailData/"+id,
		data :{},
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				if(data.data.name!=null){
					$('#name_edit').val(data.data.name);
				}else{
					$('#name_edit').val('');
				}
				$('#type_edit').val(data.data.type);
				$('#modal-edit').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
/* 关闭窗体 */
function updateCancle(){
	$('#modal-edit').modal('hide');
	
}
/* 更新 */
function update(){
	var id=$('#id-hidden').val();
	var name=$('#name_edit').val();
	var type=$('#type_edit').val();	
	if(name==''|| name==null){
		bootbox.alert('名称不能为空！');
		return;
	}
	if(type==''|| type==null){
		bootbox.alert('类型不能为空！');
		return;
	}		
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该津贴信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/salaryAllowanceTypeMng/save',
						data : JSON.stringify({
							id : id,
							name : name,				
							type : type
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
											  $('#modal-edit').modal('hide');
										  }else{
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

</script>



</body>
</html>






