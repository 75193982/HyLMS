
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
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
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
				折损费用申请查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：</label>
		   <select id="typeSearch" class="form-box" style="width:234px;">
		     <option value="-1">请选择类型</option>
		     <option value="0">直接赔付</option>
		     <option value="1">买断</option>
		   </select>
		    <label class="title">调度单：</label>
		    <input id="scheduleSearch" class="form-box" type="text" placeholder="请输入调度单号" style="width:234px;"/>
		    
		</div>
		<div class="searchbox col-xs-12">
		   <label class="title">装运车号：</label>
		    <input id="carNumberSearch" class="form-box" type="text" placeholder="请输入装运车号" style="width:234px;" />
		    <label class="title">驾驶员：</label>
		    <input id="driverSearch" class="form-box" type="text" placeholder="请输入驾驶员" style="width:234px;" />
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<!-- <a class="itemBtn" onclick="addPrice()">新增</a> -->
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>调度单号</th>
					<th>类型</th>
                    <th>开户行</th>
                    <th>名称</th>
                    <th>账号</th>
                    <th>总金额</th>
                    <th>是否走保险</th>
                    <th>状态</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 新增折损费用申请-->
			<div class="modal fade modal-reset" id="modal-add" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog dia-widget-box" style="padding:0;width:100%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="refresh();">×</button>
						<h3 id="myModalLabel">折损费用申请</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <div class="add-item extra-item1">
								     <label class="title"><span class="red">*</span>处理类型：</label>
								     <select id="typeInfo" class="form-control">
									     <option value="0">直接赔付</option>
									     <option value="1">买断</option>
									   </select>
								    </div>
								    <hr class="tree"></hr>
								     <div class="add-item extra-item1" style="position: relative;">
									     <label class="title"><span class="red">*</span>装运车号：</label>
									     <input class="form-control" id="carNo" type="text" placeholder="请输入装运车号（模糊查询）" onkeyup="getStockList(this)"/>
									     <div id="selectItem9" class="selectItemhidden">
											<div class="selectItemcont">
												<div id="selectCarNo">
													
												</div>
											</div>
										</div>
									 </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-item1">
								     <label class="title"><span class="red">*</span>调度单号：</label>
								      <select id="scheduleInfo" class="form-control" style="width: 76%;margin-right: 2%;">
									     <option value="-1">请选择调度单号</option>
									   </select>
									   <a class="selectBtn" id="selectBtn" onclick="showControl(this,0)">选择</a>
									   <input type="hidden" id="controlFlag" value="0"/>
								    </div>
								    <!-- 折损车辆信息 -->
								    <div class="add-item">
								      <div id="newPartDetail">
								        <table id="pdetailTable" class="table table-striped table-bordered table-hover">
					                      <thead>
						                    <tr>													
								               <th>运单原始编号</th>
								               <th>品牌</th>
								               <th>车型</th>
			                                   <th>车架号</th>
			                                   <th>颜色</th> 
			                                   <th>发动机号</th>
			                                   <th>4S店</th> 
			                                   <th>金额</th> 
			                                   <th>删除</th>                                                                                                
						                     </tr>
					                      </thead>
					                      <tbody>
					                        <tr class="noneInfo"><td colspan="9">暂无车辆信息</td></tr>
					                      </tbody>
					                 </table>		
								      </div>
								    </div>
							  		
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>驾驶员：</label>
									     <input class="form-control" id="driver" type="text" placeholder="请输入驾驶员" readonly="readonly"/>
									     <input class="form-control" id="driverId" type="hidden" readonly="readonly"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>情况说明：</label>
									     <input class="form-control" id="mark" type="text" placeholder="请输入情况说明"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
								      <label class="title">照片上传：</label>
								      <div class="form-control" style="border:0;height:auto;">
								         <div id="fileQueue"></div>
								         <input type="file" id="file" />
                                         <label id="filename"></label>
                                         <input type="hidden" name="filename_hidden" id="filename_hidden" />
                                         <input type="hidden" name="filepath_hidden" id="filepath_hidden" />
								      </div>
								      <div class="clear"></div>
                                    </div>
                                     <hr class="tree"></hr>
                                    <div class="add-item extra-item1">
								     <label class="title"><span class="red">*</span>开户行：</label>
								     <input class="form-control" id="bankName" type="text" placeholder="请输入开户行"/>
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>名称：</label>
									     <input class="form-control" id="accountName" type="text" placeholder="请输入名称"/>
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>账号：</label>
									     <input class="form-control" id="accountNo" type="text" placeholder="请输入账号"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
								         <label class="title"><span class="red">*</span>保险：</label>
									     <input class="form-control" id="insuranceFlag" type="checkbox" style="width:25px;height:25px;margin-right:10px;"/>
									     <span class="title">是否走保险</span>
									 </div>
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
			<!-- 编辑申请设置 -->
			<div class="modal fade modal-reset" id="modal-edit" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog dia-widget-box" style="padding:0;width:100%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="updateRefresh();">×</button>
						<h3 id="myModalLabel">编辑折损费用</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <input type="hidden" id="id-hidden"/>
								   <div class="add-item extra-item1">
								     <label class="title"><span class="red">*</span>处理类型：</label>
								     <select id="etypeInfo" class="form-control">
									     <option value="0">直接赔付</option>
									     <option value="1">买断</option>
									   </select>
								    </div>
								    <hr class="tree"></hr>
								     <div class="add-item extra-item1" style="position: relative;">
									     <label class="title"><span class="red">*</span>装运车号：</label>
									     <input class="form-control" id="ecarNo" type="text" placeholder="请输入装运车号（模糊查询）" onkeyup="getStockLists(this)"/>
									     <div id="selectItem8" class="selectItemhidden">
											<div class="selectItemcont">
												<div id="eselectCarNo">
													
												</div>
											</div>
										</div>
									 </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-item1">
								     <label class="title"><span class="red">*</span>调度单号：</label>
								      <select id="escheduleInfo" class="form-control" style="width: 76%;margin-right: 2%;">
									     <option value="-1">请选择调度单号</option>
									   </select>
									   <a class="selectBtn" id="selectBtn" onclick="showControl(this,1)">选择</a>
								    </div>
								    <!-- 折损车辆信息 -->
								    <div class="add-item">
								      <div id="newPartDetail">
								        <table id="epdetailTable" class="table table-striped table-bordered table-hover">
					                      <thead>
						                    <tr>													
								               <th>运单原始编号</th>
								               <th>品牌</th>
								               <th>车型</th>
			                                   <th>车架号</th>
			                                   <th>颜色</th> 
			                                   <th>发动机号</th>
			                                   <th>4S店</th> 
			                                   <th>金额</th> 
			                                   <th>删除</th>                                                                                                
						                     </tr>
					                      </thead>
					                      <tbody>
					                         <tr class="noneInfo"><td colspan="9">暂无车辆信息</td></tr>
					                      </tbody>
					                 </table>		
								      </div>
								    </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>驾驶员：</label>
									     <input class="form-control" id="edriver" type="text" placeholder="请输入驾驶员" readonly="readonly"/>
									     <input class="form-control" id="edriverId" type="hidden" readonly="readonly"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>情况说明：</label>
									     <input class="form-control" id="emark" type="text" placeholder="请输入情况说明" />
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
								      <label class="title">照片上传：</label>
								      <div class="form-control" style="border:0;height:auto;">
								         <div id="efileQueue"></div>
								         <input type="file" id="efile" />
                                         <label id="efilename"></label>
                                         <input type="hidden" name="efilename_hidden" id="efilename_hidden" />
                                         <input type="hidden" name="efilepath_hidden" id="efilepath_hidden" />
								      </div>
								      <div class="clear"></div>
                                    </div>
                                     <hr class="tree"></hr>
                                    <div class="add-item extra-item1">
								     <label class="title"><span class="red">*</span>开户行：</label>
								     <input class="form-control" id="ebankName" type="text" placeholder="请输入开户行"/>
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>名称：</label>
									     <input class="form-control" id="eaccountName" type="text" placeholder="请输入名称"/>
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>账号：</label>
									     <input class="form-control" id="eaccountNo" type="text" placeholder="请输入账号"/>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
								         <label class="title"><span class="red">*</span>保险：</label>
									     <input class="form-control" id="einsuranceFlag" type="checkbox" style="width:25px;height:25px;margin-right:10px;"/>
									     <span class="title">是否走保险</span>
									 </div>
								   
								    <div class="add-item-btn dis-block" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="update();">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="updateRefresh();">取消</a>
									 </div> 
									</div>
						       </div>
					     </div>
					  </div>
				   </div>
				 </div>
			 </div>
			 <!-- 查看 -->
			 <div class="modal fade modal-reset" id="modal-view" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog dia-widget-box" style="padding:0;width:100%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="viewrefresh();">×</button>
						<h3 id="myModalLabel">查看折损费用</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								   <div class="add-item extra-item1 extra-itemS">
								     <label class="title"><span class="red">*</span>处理类型：</label>
								     <p id="stypeInfo"></p>
								    </div>
								    <hr class="tree"></hr>
							  		 <div class="add-item extra-item1 extra-itemS">
									     <label class="title"><span class="red">*</span>装运车号：</label>
									     <p id="scarNo"></p>
									 </div>
							  		<hr class="tree"></hr>
							  		<div class="add-item extra-item1 extra-itemS">
								     <label class="title"><span class="red">*</span>调度单号：</label>
								     <p id="sscheduleInfo"></p>
								    </div>
								    <!-- 折损车辆信息 -->
								    <div class="add-item">
								      <div id="newPartDetail">
								        <table id="spdetailTable" class="table table-striped table-bordered table-hover">
					                      <thead>
						                    <tr>													
								               <th>运单原始编号</th>
								               <th>品牌</th>
								               <th>车型</th>
			                                   <th>车架号</th>
			                                   <th>颜色</th> 
			                                   <th>发动机号</th>
			                                   <th>4S店</th> 
			                                   <th>金额</th>                                                                                              
						                     </tr>
					                      </thead>
					                      <tbody>
					                        
					                      </tbody>
					                 </table>		
								      </div>
								    </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
									     <label class="title"><span class="red">*</span>驾驶员：</label>
									     <p id="sdriver"></p>
									 </div>
								    <hr class="tree"></hr>
									<div class="add-item extra-item1 extra-itemS">
									     <label class="title"><span class="red">*</span>情况说明：</label>
									     <p id="smark"></p>
									 </div>
								    <hr class="tree"></hr>
								    <div class="add-item extra-item1">
								      <label class="title">照片上传：</label>
								      <div class="form-control" style="border:0;height:auto;">
                                         <label id="sfilename"></label>
								      </div>
								      <div class="clear"></div>
                                    </div>
                                     <hr class="tree"></hr>
								   <!-- <div class="add-item extra-item1 extra-itemS">
									     <label class="title"><span class="red">*</span>总金额：</label>
									     <p id="samount"></p>
									 </div>
								    <hr class="tree"></hr> -->
								    <div class="add-item extra-item1 extra-itemS">
								         <label class="title"><span class="red">*</span>保险：</label>
									     <input class="form-control" id="sinsuranceFlag" type="checkbox" style="width:25px;height:25px;margin-right:10px;"/>
									     <span class="title">是否走保险</span>
									 </div>
								    <hr class="tree"></hr>
								    
                                    <div class="add-item extra-item1 extra-itemS">
								     <label class="title"><span class="red">*</span>开户行：</label>
								     <p id="sbankName"></p>
								    </div>
							  		<hr class="tree"></hr>
									 <div class="add-item extra-item1 extra-itemS">
									     <label class="title"><span class="red">*</span>名称：</label>
									     <p id="saccountName"></p>
									 </div>
							  		<hr class="tree"></hr>
									<div class="add-item extra-item1 extra-itemS">
									     <label class="title"><span class="red">*</span>账号：</label>
									     <p id="saccountNo"></p>
									 </div>
								   
									</div>
						       </div>
					     </div>
					  </div>
				   </div>
				 </div>
			 </div>
			<!-- 根据调度单选择车辆信息 -->
			<div class="modal fade modal-reset" id="modal-show" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog dia-widget-box" style="padding:0;width:100%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" data-dismiss="modal" onclick="canclePart();">×</button>
						<h3 id="myModalLabel">选择车辆信息</h3>
				    </div>
					<div class="modal-body">
					  <div class="widget-box">
							<div class="widget-body" style="height:498px;">
								<div class="widget-main">
								  <table id="partTable" class="table table-striped table-bordered table-hover">
					                      <thead>
						                    <tr>	
							                   <th class="center"><input type="checkbox" class="checkall" /></th>													
								               <th>序号</th>
								               <th>运单原始编号</th>
								               <th>品牌</th>
								               <th>车型</th>
			                                   <th>车架号</th>
			                                   <th>颜色</th> 
			                                   <th>发动机号</th>
			                                   <th>4S店</th>                                                                                                  
						                     </tr>
					                      </thead>
					                      <tbody>
					                      </tbody>
					                 </table>							   			  
									 <hr class="tree"></hr>
									 <div class="add-item-btn dis-block">
										  <a class="add-itemBtn btnOk" onclick="savePart();">保存</a>
										  <a class="add-itemBtn btnCancle" onclick="canclePart();">关闭</a>
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
<script src="${ctx}/staticPublic/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/carDamageCostMng/getListDataForQuery" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum","width":"5%"},
		    {data: "scheduleBillNo","width":"10%"},
		    {data: "type","width":"10%"},
		    {data: "bankName","width":"10%"},
		    {data: "accountName","width":"10%"},
		    {data: "accountNo","width":"10%"},
		    {data: "amount","width":"10%"},
		    {data: "insuranceFlag","width":"10%"},
		    {data: "status","width":"7%"},
		    {data: null,"width":"18%"}],
		    columnDefs: [
                {
                	//类型
			    	 targets: 2,
			    	 render: function (data, type, row, meta) {
		                    if(data=='0'){
		                    	return '直接赔付';
		                    }else if(data=='1'){
		                    	return '买断';
		                    }else{
		                    	return data;
		                    }
		                }	
                },
                {
                	//是否走保险
			    	 targets: 7,
			    	 render: function (data, type, row, meta) {
		                    if(data=='Y'){
		                    	return '是';
		                    }else if(data=='N'){
		                    	return '否';
		                    }else{
		                    	return data;
		                    }
		                }	
                },
                {
                	//状态
			    	 targets: 8,
			    	 render: function (data, type, row, meta) {
		                    if(data=='0'){
		                    	return '新建';
		                    }else if(data=='1'){
		                    	return '待复核';
		                    }else if(data=='2'){
		                    	return '待付款';
		                    }else if(data=='3'){
		                    	return '待现金付款';
		                    }else if(data=='4'){
		                    	return '已完成';
		                    }else{
		                    	return data;
		                    }
		                }	
                },
		      	{
			    	 //操作栏
			    	 targets: 9,
			    	 render: function (data, type, row, meta) {
			    		 /* if(row.status=='0'){
			    			  return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
	                    	        +'<a class="table-edit" onclick="dosumbit('+ row.id +')">提交</a>'
					                +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
		                    }else{
		                    	return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
		                    } */
			    		 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';  
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
		 "sAjaxSource": "${ctx}/operationMng/carDamageCostMng/getListDataForQuery" , //获取数据的ajax方法的URL	
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
				 columns: [{ data: "rownum","width":"5%"},
						    {data: "scheduleBillNo","width":"10%"},
						    {data: "type","width":"10%"},
						    {data: "bankName","width":"10%"},
						    {data: "accountName","width":"10%"},
						    {data: "accountNo","width":"10%"},
						    {data: "amount","width":"10%"},
						    {data: "insuranceFlag","width":"10%"},
						    {data: "status","width":"7%"},
						    {data: null,"width":"18%"}],
						    columnDefs: [
						                 {
						                 	//类型
						 			    	 targets: 2,
						 			    	 render: function (data, type, row, meta) {
						 		                    if(data=='0'){
						 		                    	return '直接赔付';
						 		                    }else if(data=='1'){
						 		                    	return '买断';
						 		                    }else{
						 		                    	return data;
						 		                    }
						 		                }	
						                 },
						                 {
						                 	//是否走保险
						 			    	 targets: 7,
						 			    	 render: function (data, type, row, meta) {
						 		                    if(data=='Y'){
						 		                    	return '是';
						 		                    }else if(data=='N'){
						 		                    	return '否';
						 		                    }else{
						 		                    	return data;
						 		                    }
						 		                }	
						                 },
						                 {
						                 	//状态
						 			    	 targets: 8,
						 			    	 render: function (data, type, row, meta) {
						 		                    if(data=='0'){
						 		                    	return '新建';
						 		                    }else if(data=='1'){
						 		                    	return '待复核';
						 		                    }else if(data=='2'){
						 		                    	return '待付款';
						 		                    }else if(data=='3'){
						 		                    	return '待现金付款';
						 		                    }else if(data=='4'){
						 		                    	return '已完成';
						 		                    }else{
						 		                    	return data;
						 		                    }
						 		                }	
						                 },
						                 {
									    	 //操作栏
									    	 targets: 9,
									    	 render: function (data, type, row, meta) {
									    		 /* if(row.status=='0'){
									    			  return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
							                    	        +'<a class="table-edit" onclick="dosumbit('+ row.id +')">提交</a>'
											                +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
								                    }else{
								                    	return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
								                    } */
									    		 return '<a class="table-edit" onclick="doshow('+ row.id +')">查看</a>';
								                }	       
								    	}
						 		      ],
						 	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

/* 上传凭证 */
function upload(){
	//刷新目录
	var html=""
	var orginName="";
	var attachPath="";
	$("#file").uploadify({
		//按钮额外自己添加点的样式类.upload
        'buttonClass':'upload',
        //限制文件上传大小
        'fileSizeLimit':'200MB',
        //文件选择框显示
        'fileTypeDesc':'选择',
        //文件类型过滤
         /* 'fileTypeExts':'*.gif;*.jpg;*.png', */
        //按钮高度
        'height':'30',
        //按钮宽度
        'width':'100',
        //请求类型
        'method':'post',
        //是否支持多文件上传
        'multi':true,
        /* //需要重写的事件
        'overrideEvents'    :    ['onUploadError'], */
        //队列ID，用来显示文件上传队列与进度
        'queueID' : 'fileQueue',
        //队列一次最多允许的文件数，也就是一次最多进入上传队列的文件数
        'queueSizeLimit': 10,
        //上传动画，插件文件下的swf文件
        'swf':'${ctx}/staticPublic/js/uploadify/uploadify.swf',
        //处理上传文件的服务类
        'uploader':'${ctx}/upload/saveFile?type=cardamage',
        /* //上传文件个数限制
        'uploadLimit': 1, */
        //上传按钮内容显示文本
        'buttonText':'上传',
         //自定义重写的方法，文件上传错误触发
        /*'onUploadError'        :   function(file,errorCode,erorMsg,errorString){
        	alert(erorMsg);
        },
        //文件选择错误触发
        'onSelectError'        :    uploadify_onSelectError, */
        /* //文件队列上传完毕触发
        'onQueueComplete'    :    heightReset,
        //队列开始上传触发
        'onUploadStart'        :   heightFit, */
        //单个文件上传成功触发
        'onUploadSuccess':function(file, data, response){        	
        	var obj=JSON.parse(data);
        	var orginFileName = JSON.parse(data).orginFileName;        		
        	var attachFilePath = JSON.parse(data).attachFilePath;
        	var attachFilePaths="${ctx}"+attachFilePath;
        	orginName+=orginFileName+';';
        	attachPath+=attachFilePath+';';
        	html+='<p><a href='+attachFilePaths+' target="_blank">'+orginFileName+'</a></p>';
        	$('#filename').html(html);
        	$('#filename_hidden').val(orginName);
        	$('#filepath_hidden').val(attachPath);
        },
       //文件队列上传完毕触发
        'onQueueComplete':function(file){ 
        	//刷新目录
        	html=""
			orginName="";
			attachPath="";
        }
 });
}

/* 编辑上传凭证 */
function eupload(){
	//刷新目录
	var html=""
	var orginName="";
	var attachPath="";
	$("#efile").uploadify({
		//按钮额外自己添加点的样式类.upload
        'buttonClass':'upload',
        //限制文件上传大小
        'fileSizeLimit':'200MB',
        //文件选择框显示
        'fileTypeDesc':'选择',
        //文件类型过滤
        /*  'fileTypeExts':'*.gif;*.jpg;*.png', */
        //按钮高度
        'height':'30',
        //按钮宽度
        'width':'100',
        //请求类型
        'method':'post',
        //是否支持多文件上传
        'multi':true,
        /* //需要重写的事件
        'overrideEvents'    :    ['onUploadError'], */
        //队列ID，用来显示文件上传队列与进度
        'queueID' : 'efileQueue',
        //队列一次最多允许的文件数，也就是一次最多进入上传队列的文件数
        'queueSizeLimit': 10,
        //上传动画，插件文件下的swf文件
        'swf':'${ctx}/staticPublic/js/uploadify/uploadify.swf',
        //处理上传文件的服务类
        'uploader':'${ctx}/upload/saveFile?type=cardamage',
        /* //上传文件个数限制
        'uploadLimit': 1, */
        //上传按钮内容显示文本
        'buttonText':'上传',
         //自定义重写的方法，文件上传错误触发
        /*'onUploadError'        :   function(file,errorCode,erorMsg,errorString){
        	alert(erorMsg);
        },
        //文件选择错误触发
        'onSelectError'        :    uploadify_onSelectError, */
        /* //文件队列上传完毕触发
        'onQueueComplete'    :    heightReset,
        //队列开始上传触发
        'onUploadStart'        :   heightFit, */
        //单个文件上传成功触发
        'onUploadSuccess':function(file, data, response){        	
        	var obj=JSON.parse(data);
        	var orginFileName = JSON.parse(data).orginFileName;        		
        	var attachFilePath = JSON.parse(data).attachFilePath;
        	var attachFilePaths="${ctx}"+attachFilePath;
        	orginName+=orginFileName+';';
        	attachPath+=attachFilePath+';';
        	html+='<p><a href='+attachFilePaths+' target="_blank">'+orginFileName+'</a></p>';
        	$('#efilename').html(html);
        	$('#efilename_hidden').val(orginName);
        	$('#efilepath_hidden').val(attachPath);
        },
       //文件队列上传完毕触发
        'onQueueComplete':function(file){ 
        	//刷新目录
        	html=""
			orginName="";
			attachPath="";
        }
 });
}

$(function(){
	init();
	//getScheduleList('');
	upload();
	eupload();
})

/* 获取装运车信息 */
	/* 新增 */
	function getStockList(e){
		  var $val=$(e).val();
		  $.ajax({  
		        url: '${ctx}/operationMng/scheduleMng/getStockList',  
		        type: "post",  
		        contentType : "application/json;charset=UTF-8",
				dataType : 'JSON',
		        data: JSON.stringify({
		        	no:$val
		        }),
		        success: function (data) {
		        	var html ='';
		            if(data.code == 200){  
		            	if(data.data!=null && data.data!=''){
		            		if(data.data.length>0){
		            			for(var i=0;i<data.data.length;i++){
		                			html +='<p onclick="getScheduleList(this)" data-no='+data.data[i]['no']+' data-driverId='+data.data[i]['driverId']+' data-driverName='+data.data[i]['driverName']+' >'+data.data[i]['no']+'</p>';
		                		}
		            			$('#selectCarNo').html(html);
		            		}
		            		
		            	}  
		          }else{  
		            	   bootbox.alert('加载失败！');
		            	   $('#carNo').val('');
		               } 
		        }
		      }); 
		    var A_top = $(e).offset().top + $(e).outerHeight(true);
			var A_left = $(e).offset().left;
			$('#selectItem9').show().css({
				"position" : "absolute",
				"top" : "34px",
				"left" : "84px"
			});
}
/* 编辑 */
  function getStockLists(e){
	  var $val=$(e).val();
	  $.ajax({  
	        url: '${ctx}/operationMng/scheduleMng/getStockList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: JSON.stringify({
	        	no:$val
	        }),
	        success: function (data) {
	        	var html ='';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<p onclick="getScheduleLists(this)" data-no='+data.data[i]['no']+' data-driverId='+data.data[i]['driverId']+' data-driverName='+data.data[i]['driverName']+' >'+data.data[i]['no']+'</p>';
	                		}
	            			$('#eselectCarNo').html(html);
	            		}
	            		
	            	}  
	          }else{  
	            	   bootbox.alert('加载失败！');
	            	   $('#ecarNo').val('');
	               } 
	        }
	      }); 
	    var A_top = $(e).offset().top + $(e).outerHeight(true);
		var A_left = $(e).offset().left;
		$('#selectItem8').show().css({
			"position" : "absolute",
			"top" : "34px",
			"left" : "84px"
		});
}
$(document).click(function(event) {
	   $('#selectItem8').hide();
	   $('#selectItem9').hide();
	});
/* 获取调度单 */
/* 新增 */
function getScheduleList(e){
	 var carNumber=$(e).html();
	 $('#carNo').val(carNumber);
	 var driverName=$(e).attr('data-driverName');
	 var driverId=$(e).attr('data-driverId');
	 if(driverName!=null && driverId!=null){
		 $('#driver').val(driverName);
		 $('#driverId').val(driverId);
		}
	  $.ajax({  
	        url: '${ctx}/operationMng/transportCostMng/getScheduleList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",  
			dataType : 'JSON',
	        data: JSON.stringify({
	        	carNumber : carNumber
	        }),
	        success: function (data) {
	        	var html ='<option value="-1" data-id="-1">请选择调度单</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	            				html +='<option value='+data.data[i]['id']+'>'+data.data[i]['scheduleBillNo']+'</option>';
	                		}
	            		}
	            	}
	            	$('#scheduleInfo').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
  }
/* 编辑 */
function getScheduleLists(e){
	 var carNumber=$(e).html();
	 $('#ecarNo').val(carNumber);
	 var driverName=$(e).attr('data-driverName');
	 var driverId=$(e).attr('data-driverId');
	 if(driverName!=null && driverId!=null){
		 $('#edriver').val(driverName);
		 $('#edriverId').val(driverId);
		}
	  $.ajax({  
	        url: '${ctx}/operationMng/transportCostMng/getScheduleList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",  
			dataType : 'JSON',
	        data: JSON.stringify({
	        	carNumber : carNumber
	        }),
	        success: function (data) {
	        	var html ='<option value="-1" data-id="-1">请选择调度单</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	            				html +='<option value='+data.data[i]['id']+'>'+data.data[i]['scheduleBillNo']+'</option>';
	                		}
	            		}
	            	}
	            	$('#escheduleInfo').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
}
function getScheduleListInit(carNumber,scheduleBillNo){
	  $.ajax({  
	        url: '${ctx}/operationMng/transportCostMng/getScheduleList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",  
			dataType : 'JSON',
	        data: JSON.stringify({
	        	carNumber : carNumber
	        }),
	        success: function (data) {
	        	var html ='<option value="-1" data-id="-1">请选择调度单</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	            				if(data.data[i]['scheduleBillNo']==scheduleBillNo){
	            					html +='<option selected value='+data.data[i]['id']+'>'+data.data[i]['scheduleBillNo']+'</option>';
	            				}else{
	            					html +='<option value='+data.data[i]['id']+'>'+data.data[i]['scheduleBillNo']+'</option>';
	            				}
	            				
	                		}
	            		}
	            	}
	            	$('#escheduleInfo').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
}
/* 数据交互 */
function retrieveData(sSource, aoData, fnCallback ) {
	   var type=$('#typeSearch').val();
	   var scheduleBillNo=$('#scheduleSearch').val();
	   var carNumber=$('#carNumberSearch').val();
	   var driver=$('#driverSearch').val();
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   $('#secho').val(secho);
	   if(type=='-1'){
		   type='';
	   }
	   if($('#scheduleSearch').val()=='-1'){
		   scheduleBillNo='';
	   }
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				type : type,
				scheduleBillNo : scheduleBillNo,
				carNumber :carNumber,
				driverName :driver
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

/* 删除 */
function dodelete(id){
	var ids=parseInt(id);
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该申请信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/carDamageCostMng/delete/"+ids,
						data :{},
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
/* 提交 */
function dosumbit(id){
	var ids=parseInt(id);
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该申请信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/carDamageCostMng/submit/"+ids,
						data :{},
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "提交成功！", 
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
function addPrice(){
	clear();  
	$('#modal-add').modal('show');
	
}
/* 关闭窗体 */
function refresh(){
	$('#modal-add').modal('hide');
}
/* 数据重置 */
function clear(){
	$('#typeInfo').val('0');
	$('#scheduleInfo').val('-1');
	$('#filepath_hidden').val();
	$('#mark').val('');
	$('#bankName').val('');
	$('#accountName').val('');
	$('#accountNo').val('');
	$('#amount').val('');
	$('#pdetailTable tbody').html('<tr class="noneInfo"><td colspan="9">暂无车辆信息</td></tr>');
	$('#filepath_hidden').val('');
	$('#filename_hidden').val('');
	$('#carNo').val('');
	$('#driver').val('');
	$('#filename').html('');
	$('#insuranceFlag').prop('checked',false);
}
/* 查看申请详细信息 */
function doshow(id){
	var arr=[];
	var path="";
	var pathlist="";
	var ids=parseInt(id);
	var html="";
	var pathHtml="";
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/carDamageCostMng/getDetail/"+id,
		data :{},
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				if(data.data.type=='0'){
					$('#stypeInfo').html('直接赔付');
				}else if(data.data.type=='1'){
					$('#stypeInfo').html('买断');
				}else{
					$('#stypeInfo').html('');
				}
				if(data.data.insuranceFlag=="Y"){
					$('#sinsuranceFlag').prop('checked',true);
				}else{
					$('#sinsuranceFlag').prop('checked',false);
				}
				
				$('#sscheduleInfo').html(data.data.scheduleBillNo);
				$('#sbankName').html(data.data.bankName);
				$('#saccountName').html(data.data.accountName);
				$('#saccountNo').html(data.data.accountNo);
				$('#samount').html(data.data.amount);
				$('#smark').html(data.data.mark);
				$('#scarNo').html(data.data.carNumber);
				$('#sdriver').html(data.data.driverName);
				if(data.data.detailList!=null && data.data.detailList.length>0){
					var objs=data.data.detailList;
					var carlist=data.data.carStockList;
					for(var i=0;i<objs.length;i++){
						html+='<tr>'
						     +'<td>'+carlist[i]["waybillNo"]+'</td>'
						     +'<td>'+carlist[i]["brand"]+'</td>'
						     +'<td>'+carlist[i]["model"]+'</td>'
						     +'<td>'+carlist[i]["vin"]+'</td>'
						     +'<td>'+carlist[i]["color"]+'</td>'
						     +'<td>'+carlist[i]["engineNo"]+'</td>'
						     +'<td>'+carlist[i]["carShopName"]+'</td>'
						     +'<td>'+objs[i]["amount"]+'</td>'
						     +'</tr>';
					}
				}
				if(data.data.attachFilePath!=null && data.data.attachFilePath!=''){
					 path=data.data.attachFilePath
					 pathlist = path.substring(0, path.length-1);
					 arr = pathlist.split(';');
					 if(arr!=null && arr!="" && arr.length>0){
						 for(var k=0;k<arr.length;k++){
							 var attachFilePaths="${ctx}"+arr[k];
							 pathHtml+='<p><a href='+attachFilePaths+' target="_blank">照片'+(k+1)+'</a></p>';
						 }
						 
					 }
				}
				
				$('#spdetailTable tbody').html(html);
				$('#sfilename').html(pathHtml);
				$('#modal-view').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
/* 关闭查看窗口 */
function viewrefresh(){
	$('#modal-view').modal('hide');
}
/* 关闭编辑窗口 */
function updateRefresh(){
	$('#modal-edit').modal('hide');
}

function doedit(id){
	
	$('#id-hidden').val(id);
	var arr=[];
	var path="";
	var pathlist="";
	var ids=parseInt(id);
	var html="";
	var pathHtml="";
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/carDamageCostMng/getDetail/"+ids,
		data :{},
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#etypeInfo').val(data.data.type);
				if(data.data.insuranceFlag=="Y"){
					$('#einsuranceFlag').prop('checked',true);
				}else{
					$('#einsuranceFlag').prop('checked',false);
				}
				getScheduleListInit(data.data.carNumber,data.data['scheduleBillNo']); 
				/* $("#escheduleInfo option:contains('"+data.data['scheduleBillNo']+"')").attr('selected',true); */
				$('#ebankName').val(data.data.bankName);
				$('#eaccountName').val(data.data.accountName);
				$('#eaccountNo').val(data.data.accountNo);
				$('#eamount').val(data.data.amount);
				$('#emark').val(data.data.mark);
				$('#ecarNo').val(data.data.carNumber);
				$('#edriver').val(data.data.driverName);
				$('#edriverId').val(data.data.driverId);
				if(data.data.detailList!=null && data.data.detailList.length>0){
					var objs=data.data.detailList;
					var carlist=data.data.carStockList;
					for(var i=0;i<objs.length;i++){
						html+='<tr>'
						     +'<td data-id='+objs[i]["carStockId"]+'>'+carlist[i]["waybillNo"]+'</td>'
						     +'<td>'+carlist[i]["brand"]+'</td>'
						     +'<td>'+carlist[i]["model"]+'</td>'
						     +'<td>'+carlist[i]["vin"]+'</td>'
						     +'<td>'+carlist[i]["color"]+'</td>'
						     +'<td>'+carlist[i]["engineNo"]+'</td>'
						     +'<td>'+carlist[i]["carShopName"]+'</td>'
						     +'<td><input type="text" id="edameMoney'+i+'" value="'+objs[i]["amount"]+'" placeholder="请输入金额" /></td>'
						     +'<td><a class="deleteBtn" onclick="deletePart(this)">删除</a></td>'
						     +'</tr>';
					}
				}
				if(data.data.attachFilePath!=null && data.data.attachFilePath!=''){
					 path=data.data.attachFilePath
					 pathlist = path.substring(0, path.length-1);
					 $('#efilepath_hidden').val(data.data.attachFilePath);
					 arr = pathlist.split(';');
					 if(arr!=null && arr!="" && arr.length>0){
						 for(var k=0;k<arr.length;k++){
							 var attachFilePaths="${ctx}"+arr[k];
							 pathHtml+='<p><a href='+attachFilePaths+' target="_blank">照片'+(k+1)+'</a></p>';
						 }
						 
					 }
				}
				
				$('#epdetailTable tbody').html(html);
				$('#efilename').html(pathHtml);
				$('#modal-edit').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}


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
   
$('#partTable tbody').on( 'click', 'tr', function () {
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
/* 根据调度单选择车辆信息 */
function  showControl(e,flag){
	$('#controlFlag').val(flag);
	if(flag=="0"){
		 var id=$('#scheduleInfo').find('option:selected').html();
		 var html="",htmlItem="";
		 var size=0,all=0;
		 var partId="";
		 if($('#scheduleInfo').val()=="" || $('#scheduleInfo').val()== null || $('#scheduleInfo').val()=="-1"){
			 bootbox.alert('请先选择调度单！');
		 }else{
			 var arr=[];
			 $('#newPartDetail table tbody').find('tr').each(function(){
				 var partItem=$(this).find('td').eq(0).attr('data-id');
				 if(partItem!=null && partItem!=''){
					 partId+=partItem+',';
				 }
				
			 });
				 partId = partId.substring(0, partId.length-1);
				 arr = partId.split(',');
			   var obj = {};
				 $.ajax({
					type : 'POST',
					url : "${ctx}/operationMng/scheduleMng/getCarListForScheduleBillNo/"+id,
					data : JSON.stringify({
						scheduleBillNo :$.trim(id)
					}),
					contentType : "application/json;charset=UTF-8",
					dataType : 'JSON',
					success : function(data) {
						if (data && data.code == 200) {						
							all=data.data.length;
							if(data.data.length>0){
								for(var i=0;i<data.data.length;i++){
									data.data[i]["rownum"]=i+1;
									if(arr.length>0){
										for(var j=0;j<arr.length;j++){
											if(data.data[i]["id"]==arr[j]){
												htmlItem='<tr class="selected"><td class="text-center"><input type="checkbox" checked="checked" class="checkchild"></td>'
												     +'<td data-id="'+data.data[i]["id"]+'">'+data.data[i]["rownum"]+'</td>'
												     +'<td>'+data.data[i]["waybillNo"]+'</td>'
												     +'<td>'+data.data[i]["brand"]+'</td>'
												     +'<td>'+data.data[i]["model"]+'</td>'
												     +'<td>'+data.data[i]["vin"]+'</td>'
												     +'<td>'+data.data[i]["color"]+'</td>'
												     +'<td>'+data.data[i]["engineNo"]+'</td>'
												     +'<td>'+data.data[i]["carShopName"]+'</td>'
												     +'</tr>';
												     size++;
												     break;
											}else{
												htmlItem='<tr><td class="text-center"><input type="checkbox" class="checkchild"></td>'
												     +'<td data-id="'+data.data[i]["id"]+'">'+data.data[i]["rownum"]+'</td>'
												     +'<td>'+data.data[i]["waybillNo"]+'</td>'
												     +'<td>'+data.data[i]["brand"]+'</td>'
												     +'<td>'+data.data[i]["model"]+'</td>'
												     +'<td>'+data.data[i]["vin"]+'</td>'
												     +'<td>'+data.data[i]["color"]+'</td>'
												     +'<td>'+data.data[i]["engineNo"]+'</td>'
												     +'<td>'+data.data[i]["carShopName"]+'</td>'
												     +'</tr>';
											}
											
										}
										html+=htmlItem;
									}else{
										html+='<tr><td class="text-center"><input type="checkbox" class="checkchild"></td>'
										     +'<td data-id="'+data.data[i]["id"]+'">'+data.data[i]["rownum"]+'</td>'
										     +'<td>'+data.data[i]["waybillNo"]+'</td>'
										     +'<td>'+data.data[i]["brand"]+'</td>'
										     +'<td>'+data.data[i]["model"]+'</td>'
										     +'<td>'+data.data[i]["vin"]+'</td>'
										     +'<td>'+data.data[i]["color"]+'</td>'
										     +'<td>'+data.data[i]["engineNo"]+'</td>'
										     +'<td>'+data.data[i]["carShopName"]+'</td>'
										     +'</tr>';
									}
								}
								if(size==all && size>0){
									 checkChoose(true);
								 }else{
									 checkChoose(false); 
								 }
							}else{
								html+="<tr><td colspan='8'>暂无车辆信息</td></tr>";
							}
							$('#partTable tbody').html(html);
						} 
						
					}
				 });
			 $('#modal-show').modal('show');
			 
		 }
	}else{
		 var id=$('#escheduleInfo').find('option:selected').html();
		 var html="",htmlItem="";
		 var size=0,all=0;
		 var partId="";
		 if($('#escheduleInfo').val()=="" || $('#escheduleInfo').val()== null || $('#escheduleInfo').val()=="-1"){
			 bootbox.alert('请先选择调度单！');
		 }else{
			 var arr=[];
			 $('#newPartDetail table tbody').find('tr').each(function(){
				 var partItem=$(this).find('td').eq(0).attr('data-id');
				 if(partItem!=null && partItem!=''){
					 partId+=partItem+',';
				 }
				
			 });
				 partId = partId.substring(0, partId.length-1);
				 arr = partId.split(',');
			   var obj = {};
				 $.ajax({
					type : 'POST',
					url : "${ctx}/operationMng/scheduleMng/getCarListForScheduleBillNo/"+id,
					data : JSON.stringify({
						scheduleBillNo :$.trim(id)
					}),
					contentType : "application/json;charset=UTF-8",
					dataType : 'JSON',
					success : function(data) {
						if (data && data.code == 200) {						
							all=data.data.length;
							if(data.data.length>0){
								for(var i=0;i<data.data.length;i++){
									data.data[i]["rownum"]=i+1;
									if(arr.length>0){
										for(var j=0;j<arr.length;j++){
											if(data.data[i]["id"]==arr[j]){
												htmlItem='<tr class="selected"><td class="text-center"><input type="checkbox" checked="checked" class="checkchild"></td>'
												     +'<td data-id="'+data.data[i]["id"]+'">'+data.data[i]["rownum"]+'</td>'
												     +'<td>'+data.data[i]["waybillNo"]+'</td>'
												     +'<td>'+data.data[i]["brand"]+'</td>'
												     +'<td>'+data.data[i]["model"]+'</td>'
												     +'<td>'+data.data[i]["vin"]+'</td>'
												     +'<td>'+data.data[i]["color"]+'</td>'
												     +'<td>'+data.data[i]["engineNo"]+'</td>'
												     +'<td>'+data.data[i]["carShopName"]+'</td>'
												     +'</tr>';
												     size++;
												     break;
											}else{
												htmlItem='<tr><td class="text-center"><input type="checkbox" class="checkchild"></td>'
												     +'<td data-id="'+data.data[i]["id"]+'">'+data.data[i]["rownum"]+'</td>'
												     +'<td>'+data.data[i]["waybillNo"]+'</td>'
												     +'<td>'+data.data[i]["brand"]+'</td>'
												     +'<td>'+data.data[i]["model"]+'</td>'
												     +'<td>'+data.data[i]["vin"]+'</td>'
												     +'<td>'+data.data[i]["color"]+'</td>'
												     +'<td>'+data.data[i]["engineNo"]+'</td>'
												     +'<td>'+data.data[i]["carShopName"]+'</td>'
												     +'</tr>';
											}
											
										}
										html+=htmlItem;
									}else{
										html+='<tr><td class="text-center"><input type="checkbox" class="checkchild"></td>'
										     +'<td data-id="'+data.data[i]["id"]+'">'+data.data[i]["rownum"]+'</td>'
										     +'<td>'+data.data[i]["waybillNo"]+'</td>'
										     +'<td>'+data.data[i]["brand"]+'</td>'
										     +'<td>'+data.data[i]["model"]+'</td>'
										     +'<td>'+data.data[i]["vin"]+'</td>'
										     +'<td>'+data.data[i]["color"]+'</td>'
										     +'<td>'+data.data[i]["engineNo"]+'</td>'
										     +'<td>'+data.data[i]["carShopName"]+'</td>'
										     +'</tr>';
									}
								}
								if(size==all && size>0){
									 checkChoose(true);
								 }else{
									 checkChoose(false); 
								 }
							}else{
								html+="<tr><td colspan='8'>暂无车辆信息</td></tr>";
							}
							$('#partTable tbody').html(html);
						} 
						
					}
				 });
			 $('#modal-show').modal('show');
			 
		 }
	}
	
}

function savePart(){
	var flag=$('#controlFlag').val();
	if(flag=='0'){
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要新增该车辆信息?", 
			  callback: function(result){
				  if(result){
						var table=$('#partTable tbody');
						var objs=[];
						var html="";
						for(i=0;i<table.children('tr.selected').length;i++){
							var obj={};
							var tr=table.children('tr.selected').eq(i);
							obj.id=tr.find('td').eq(1).attr('data-id');
							obj.waybillNo=tr.find('td').eq(2).html();
							obj.brand=tr.find('td').eq(3).html();
							obj.model=tr.find('td').eq(4).html();
							obj.vin=tr.find('td').eq(5).html();
							obj.color=tr.find('td').eq(6).html();
							obj.engineNo=tr.find('td').eq(7).html();
							obj.carShopName=tr.find('td').eq(8).html();
							objs.push(obj);
							html+='<tr><td data-id='+obj.id+'>'+obj.waybillNo+'</td><td>'+obj.brand+'</td>'
							    +'<td>'+obj.model+'</td><td>'+obj.vin+'</td>'
							    +'<td>'+obj.color+'</td><td>'+obj.engineNo+'</td>'
							    +'<td>'+obj.carShopName+'</td><td><input type="text" id="dameMoney'+i+'" value="0" placeholder="请输入金额" /></td>'
							    +'<td><a class="deleteBtn" onclick="deletePart(this)">删除</a></td></tr>';
						}
						$('#newPartDetail table#pdetailTable tbody').html(html);
						$('#modal-show').modal('hide');
						
				  }
			  }
		 });
	}else{
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要新增该车辆信息?", 
			  callback: function(result){
				  if(result){
						var table=$('#partTable tbody');
						var objs=[];
						var html="";
						for(i=0;i<table.children('tr.selected').length;i++){
							var obj={};
							var tr=table.children('tr.selected').eq(i);
							obj.id=tr.find('td').eq(1).attr('data-id');
							obj.waybillNo=tr.find('td').eq(2).html();
							obj.brand=tr.find('td').eq(3).html();
							obj.model=tr.find('td').eq(4).html();
							obj.vin=tr.find('td').eq(5).html();
							obj.color=tr.find('td').eq(6).html();
							obj.engineNo=tr.find('td').eq(7).html();
							obj.carShopName=tr.find('td').eq(8).html();
							objs.push(obj);
							html+='<tr><td data-id='+obj.id+'>'+obj.waybillNo+'</td><td>'+obj.brand+'</td>'
							    +'<td>'+obj.model+'</td><td>'+obj.vin+'</td>'
							    +'<td>'+obj.color+'</td><td>'+obj.engineNo+'</td>'
							    +'<td>'+obj.carShopName+'</td><td><input type="text" id="edameMoney'+i+'" value="0" placeholder="请输入金额" /></td>'
							    +'<td><a class="deleteBtn" onclick="deletePart(this)">删除</a></td></tr>';
						}
						$('#newPartDetail table#epdetailTable tbody').html(html);
						$('#modal-show').modal('hide');
						
				  }
			  }
		 });
	}
	 
}
/* 关闭车辆选择窗口 */
function canclePart(){
	$('#modal-show').modal('hide');
}
/* 删除所选车辆信息 */
function deletePart(e){
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该车辆详细信息?", 
		  callback: function(result){
			  if(result){
				  $(e).parents('tr').remove();
			  }
		  }
	 })
}

/* 保存折损费用申请 */
function save(){
	 var flag="false";
	 var objs=[];
	 var objList={};
	 var type=$('#typeInfo').val();
	 var scheduleBillNo=$('#scheduleInfo').find('option:selected').html();
	 var attachFilePath=$('#filepath_hidden').val();
	 var mark=$('#mark').val();
	 var bankName=$('#bankName').val();
	 var accountName=$('#accountName').val();
	 var accountNo=$('#accountNo').val();
	 var insuranceFlag='N';
	 var carNumber=$('#carNo').val();
	 var driver=$('#driverId').val();
	 if($('#insuranceFlag').is(':checked')==true){
		 insuranceFlag='Y';
	 }
	 if($('#scheduleInfo').val()=='' || $('#scheduleInfo').val()==null){
		 bootbox.alert('请选择调度单号！');
		 return;
	 }
	 if($('#carNo').val()=='' || $('#carNo').val()==null){
		 bootbox.alert('请输入装运车号！');
		 return;
	 }
	 if($('#driver').val()=='' || $('#driver').val()==null){
		 bootbox.alert('请输入驾驶员！');
		 return;
	 }
	 if($('#mark').val()=='' || $('#mark').val()==null){
		 bootbox.alert('请输入详细情况！');
		 return;
	 }
	 if($('#bankName').val()=='' || $('#bankName').val()==null){
		 bootbox.alert('请输入开户行！');
		 return;
	 }
	 if($('#accountName').val()=='' || $('#accountName').val()==null){
		 bootbox.alert('请输入名称！');
		 return;
	 }
	 if($('#accountNo').val()=='' || $('#accountNo').val()==null){
		 bootbox.alert('请输入账号！');
		 return;
	 }
	 var partList=$('#pdetailTable tbody').children('tr');
	 if(partList.length>0){
		 if(partList.length==1 && partList.eq(0).attr('class')=='noneInfo'){
			 bootbox.alert('请选择车辆信息！');
			 return;
		 }else{
			 for(var i=0;i<partList.length;i++){
				 var obj=partList.eq(i);
				 var objItem={};
				 objItem.carStockId=obj.find('td').eq(0).attr('data-id');
				 objItem.amount=$('#dameMoney'+i+'').val();
				 objs.push(objItem);
			 }
		 }
		 
	 }
	 objList.carNumber=carNumber;
	 objList.driverId=driver;
	 objList.type=type;
	 objList.scheduleBillNo=scheduleBillNo;
	 objList.attachFilePath=attachFilePath.substring(0, attachFilePath.length-1);
	 objList.mark=mark;
	 objList.bankName=bankName;
	 objList.accountName=accountName;
	 objList.accountNo=accountNo;
	 objList.insuranceFlag=insuranceFlag;
	 objList.detailList=objs;
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该折损申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/carDamageCostMng/save',
						data : JSON.stringify(objList),
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
		});
	 
}

/* 更新 */
function update(){
	 var id=$('#id-hidden').val();
	 var flag="false";
	 var objs=[];
	 var objList={};
	 var type=$('#etypeInfo').val();
	 var scheduleBillNo=$('#escheduleInfo').find('option:selected').html();
	 var attachFilePath=$('#efilepath_hidden').val();
	 var mark=$('#emark').val();
	 var bankName=$('#ebankName').val();
	 var accountName=$('#eaccountName').val();
	 var accountNo=$('#eaccountNo').val();
	 var insuranceFlag='N';
	 var carNumber=$('#ecarNo').val();
	 var driver=$('#edriverId').val();
	 if($('#einsuranceFlag').is(':checked')==true){
		 insuranceFlag='Y';
	 }
	 if($('#escheduleInfo').val()=='' || $('#escheduleInfo').val()==null){
		 bootbox.alert('请选择调度单号！');
		 return;
	 }
	 if($('#ecarNo').val()=='' || $('#ecarNo').val()==null){
		 bootbox.alert('请输入装运车号！');
		 return;
	 }
	 if($('#edriver').val()=='' || $('#edriver').val()==null){
		 bootbox.alert('请输入驾驶员！');
		 return;
	 }
	 if($('#emark').val()=='' || $('#emark').val()==null){
		 bootbox.alert('请输入详细情况！');
		 return;
	 }
	 if($('#ebankName').val()=='' || $('#ebankName').val()==null){
		 bootbox.alert('请输入开户行！');
		 return;
	 }
	 if($('#eaccountName').val()=='' || $('#eaccountName').val()==null){
		 bootbox.alert('请输入名称！');
		 return;
	 }
	 if($('#eaccountNo').val()=='' || $('#eaccountNo').val()==null){
		 bootbox.alert('请输入账号！');
		 return;
	 }
	 var partList=$('#epdetailTable tbody').children('tr');
	 if(partList.length>0){
		 if(partList.length==1 && partList.eq(0).attr('class')=='noneInfo'){
			 bootbox.alert('请选择车辆信息！');
			 return;
		 }else{
			 for(var i=0;i<partList.length;i++){
				 var obj=partList.eq(i);
				 var objItem={};
				 objItem.carStockId=obj.find('td').eq(0).attr('data-id');
				 objItem.amount=$('#edameMoney'+i+'').val();
				 objs.push(objItem);
			 }
		 }
		 
	 }
	 objList.id=id;
	 objList.carNumber=carNumber;
	 objList.driverId=driver;
	 objList.type=type;
	 objList.scheduleBillNo=scheduleBillNo;
	 objList.attachFilePath=attachFilePath.substring(0, attachFilePath.length-1);
	 objList.mark=mark;
	 objList.bankName=bankName;
	 objList.accountName=accountName;
	 objList.accountNo=accountNo;
	 objList.insuranceFlag=insuranceFlag;
	 objList.detailList=objs;
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该折损申请信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/carDamageCostMng/update',
						data : JSON.stringify(objList),
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
		});
}
</script>



</body>
</html>






