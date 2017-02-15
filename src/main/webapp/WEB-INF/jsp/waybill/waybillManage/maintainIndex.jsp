
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/ztree/demo.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/datetimepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
 
    .col-xs-12{
    margin-bottom:10px;
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
				运单维护
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">		
		<div class="searchbox col-xs-12">
			<label class="title">运单编号：</label>
		      <input class="form-box" id="fom_waybillNo" type="text"  placeholder="请输入运单编号"/>
			<label class="titletwo">状态：</label>
		    	 <select id="fom_status" class="form-box" >	
		    	 <option value="">请选择状态</option>
		    	 <option value='0'>新建</option>
		    	 <option value='1'>待复核</option>	
		    	 <option value='2'>待回执</option>
		    	 <option value='3'>已完成</option>   
			</select>				  
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			</div>	
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>运单编号</th>
					<th>类型</th>
                    <th>供应商名称</th>
                    <th>品牌</th>
                    <th>经销单位</th>
                    <th>始发地</th>
                    <th>目的省</th>
                    <th>目的地</th>
                    <th>下单日期</th> 
                    <th>创建时间</th>
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
					<h3 id="myModalLabel">新增/编辑运单信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main ">
								<div class="row">
							<div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>类型：</label>
							     <div class="col-xs-9">
							     <select id="type" class="form-control">
							     <option value='0'>商品车</option>
		    	                 <option value='1'>二手车</option>			      
			                     </select>	
			                     </div>							     
							     <input  id="id-hidden" type="hidden"/>
							  </div>
							  <div id="newcarview">
							   <hr class="tree"></hr>
							 <div class="add-item col-xs-12" >
							     <label class="title col-xs-3"><span class="red">*</span>运单编号：</label>
							    <div class="col-xs-9"> <input class="form-control" id="waybillNo" type="text" placeholder="请输入运单编号"/>	 </div>						     
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>供应商：</label>
							   <div class="col-xs-9"> <select id="supplierId" class="form-control">							          
			                    </select>	</div>	
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>品牌：</label>
							   <div class="col-xs-9"><select id="brand" class="form-control">							          
			                    </select></div>	
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>经销单位：</label>
							    <div class="col-xs-9">
								    <select id="carShopId" class="form-control" onchange="chooseStart(this);">							          
				                    </select>
			                    </div>		
							 </div>
							<hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>下单日期：</label>
							     <div class="col-xs-9">
							   <div class="input-group input-group-sm">
									<input class="form-control" id="sendTime_first" type="text" placeholder="请输入下单日期"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>
								</div>	
							 </div>
							  <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>始发地：</label>
							     <div class="col-xs-9"> <input class="form-control" id="startAddress_first" type="text" placeholder="请输入始发地"/></div>
							    </div>	
							     <hr class="tree"></hr>
							     <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>目的省：</label>
							     <div class="col-xs-9"> <input class="form-control" id="targetProvince_first" type="text" placeholder="请输入目的省"/></div>
							    </div>				
							  <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>目的地：</label>
							     <div class="col-xs-9"> <input class="form-control" id="targetAddress_first" type="text" placeholder="请输入目的地"/></div>
							    </div>				
							  <!-- <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>公里数 ：</label>
							    <div class="col-xs-9"> <input class="form-control" id="distance" type="text" placeholder="请输入公里数"/></div>
							    </div> -->									   			
							  </div>
							 <div id="nextcarview">
							 <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>下单日期：</label>
							   <div class="input-group input-group-sm col-xs-9">
									<input class="form-control" id="sendTime_next" type="text" placeholder="请输入下单日期"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>	
							 </div>
							  <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>始发地：</label>
							      <div class="col-xs-9"><input class="form-control" id="startAddress_next" type="text" placeholder="请输入始发地"/></div>
							    </div>	
							    <hr class="tree"></hr>
							     <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>目的省：</label>
							     <div class="col-xs-9"> <input class="form-control" id="targetProvince_next" type="text" placeholder="请输入目的省"/></div>
							    </div>	
							     <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>目的地：</label>
							     <div class="col-xs-9"><input class="form-control" id="targetAddress_next" type="text" placeholder="请输入目的地"/></div>
							    </div>
							    <!-- <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>运输价格：</label>
							    <div class="col-xs-9"><input class="form-control" id="amount" type="text" placeholder="请输入运输价格"/></div>
							 </div>	 -->
							     <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-3"><span class="red">*</span>接车联系人：</label>
							    <div class="col-xs-9"><input class="form-control" id="receiveUser" type="text" placeholder="请输入接车联系人"/></div>
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>接车联系人电话：</label>
							     <div class="col-xs-8"><input class="form-control" id="receiveUserTelephone" type="text" placeholder="请输入接车联系人电话"/></div>					   					    
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							   <label class="title col-xs-4"><span class="red">*</span>接车联系人手机：</label>
							   <div class="col-xs-8"> <input class="form-control" id="receiveUserMobile" type="text" placeholder="请输入接车联系人手机"/></div>
							 </div>								  						 										
							 </div>	
							 <hr class="tree"></hr>
							 <div class="add-item col-xs-12" style="margin-bottom: 10px;margin-top: 20px;" id="hidden6">
                                          <label class="title col-xs-2">附件 ：</label>
                                          <div class="col-xs-10">
                                            <input type="file" id="inputfile" />
                                            <label class="title" id="filename"></label>
                                            <input type="hidden" name="filename_hidden" id="filename_hidden" />
                                            <input type="hidden" name="filepath_hidden" id="filepath_hidden" /></div>
                                        </div>							
							</div>							   
							    <div class="add-item-btn" id="addBtn">
								    <a class="add-itemBtn btnOk" onclick="save();" style="margin-left: 130px;">保存</a>
								    <a class="add-itemBtn btnOk" onclick="refresh();">关闭</a>
								 </div>
								 <div class="add-item-btn" id="editBtn">
								    <a class="add-itemBtn btnOk" onclick="update()" style="margin-left: 130px;">更新</a>
								    <a class="add-itemBtn btnOk" onclick="refresh()">关闭</a>
								  </div> 
								 <!-- <div class="add-item-btn" id="viewBtn">								   
								    <a class="add-itemBtn btnCancle" onclick="refresh()">关闭</a>
								  </div>  -->
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
		<div class="modal fade" id="modal-carinfo" tabindex="-1" role="dialog" data-backdrop="static" style="width:1000px;">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">绑定商品车信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">	
								<div class="searchbox col-xs-12 ">
			                    <label class="title">类型：</label>
		                      <select id="fom_type" class="form-box" >	
		    	              <option value="">请选择类型</option>
		    	               <option value='0'>商品车</option>
		    	               <option value='1'>二手车</option>			    	                   
			                   </select>			
			                    <input class="form-control" id="wabillId-hidden" type="hidden"/>	  
		                       <label class="titletwo">车架号：</label>
		                       <input class="form-box" id="fom_vin" type="text"  placeholder="请输入车架号"/>
		                       <!-- <label class="titletwo">状态：</label>
		                       <select id="fom_carstatus" class="form-box" >	
		    	               <option value="">请选择状态</option>
		    	               <option value='0'>新建</option>
		    	               <option value='1'>待复核</option>	
		    	               <option value='2'>已入库</option>
		    	               <option value='3'>已出库</option>	     	               
			                   </select> -->		
			                   <a class="itemBtn" onclick="searchcarInfo()">查询</a>		
			                   </div>	       						
							 	<table id="cardetable" class="table table-striped table-bordered table-hover">
			                      <thead>
				                   <tr>	
				                   <th class="center">
						           <input type="checkbox" class="checkall" />
					               </th>													
					               <th>序号</th>
					               <th>类型</th>
                                   <th>供应商名称</th>
                                   <th>品牌</th>
                                   <th>车架号</th>
                                   <th>车型</th>
                                   <th>颜色</th> 
                                   <th>发动机号</th> 
                                   <th>备注</th>
                                   <th>状态</th>                                                                             
				                     </tr>
			                      </thead>
			                      <tbody>
			                      </tbody>
			                      </table>							   			  
							    <hr class="tree"></hr>
							    <div class="add-item-btn" id="caraddBtn">
								    <a class="add-itemBtn btnOk" onclick="bindCarStock();">确定</a>
								    <a class="add-itemBtn btnCancle" onclick="refresh_carinfo();">关闭</a>
								 </div>								 
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
				<div class="modal fade" id="modal-attachmentinfo" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">绑定配件信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">	
								<div class="searchbox col-xs-12 add-item">			                   		
			                    <input class="form-control" id="atwabillId-hidden" type="hidden"/>	  
		                       <label class="title">配件名称：</label>
		                       <input class="form-box" id="fom_attachmentName" type="text"  placeholder="请输入配件名称"/>		                      
			                   <a class="itemBtn" onclick="searchattachInfo()">查询</a>		
			                   </div>	       						
							 	<table id="attachmentdetable" class="table table-striped table-bordered table-hover">
			                      <thead>
				                   <tr>	
				                   <th class="center">
						           <input type="checkbox" class="checkall" />
					               </th>													
					               <th>序号</th>
					               <th>配件名称</th>
                                   <th>存放位置</th>
                                   <th>数量</th>
                                   <th>备注</th>
                                   <th>状态</th>                                                                                                             
				                     </tr>
			                      </thead>
			                      <tbody>
			                      </tbody>
			                      </table>							   			  
							    <hr class="tree"></hr>
							    <div class="add-item-btn" id="caratcaddBtn">
								    <a class="add-itemBtn btnOk" onclick="bindattachment();">确定</a>
								    <a class="add-itemBtn btnCancle" onclick="refresh_attachmentinfo();">关闭</a>
								 </div>								 
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
			<div class="modal fade" id="modal-detilinfo" tabindex="-1" role="dialog">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">运单信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item col-xs-12">
							     <label class="title col-xs-2">类型：</label><label class="title col-xs-4" id="type_view"></label>	
							      <label class="title col-xs-2">运单编号：</label><label class="title col-xs-4" id="waybillNo_view"></label>						     								     							     
							  </div>		
							  <div id="hidden1">				
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12 " >
							     <label class="title col-xs-2">品牌：</label><label class="title col-xs-4" id="brand_view"></label>
							     <label class="title col-xs-2">经销单位：</label><label class="title col-xs-4" id="carShopId_view"></label>									     						   
							 </div>							 
							   <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							  <label class="title col-xs-2">供应商：</label><label class="title col-xs-10" id="supplierId_view"></label>								    							     						   
							 </div>	
							 </div>
							   <hr class="tree"></hr>
							 <div class="add-item col-xs-12">	
							  <label class="title col-xs-2">下单日期：</label><label class="title col-xs-10" id="sendTime_view"></label>	
							  </div>
							  <div id="hidden2">							
							 <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-2">运输价格：</label><label class="title col-xs-4" id="amount_view"></label>	
							    <label class="title col-xs-2">接车联系人电话：</label><label class="title col-xs-4" id="receiveUserTelephone_view"></label>						    
							 </div>																												 
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							  <label class="title col-xs-2">接车联系人：</label><label class="title col-xs-4" id="receiveUser_view"></label>								  
							     <label class="title col-xs-2">接车联系人手机：</label><label class="title col-xs-4" id="receiveUserMobile_view"></label>							
							 </div>	
							 </div>
							   <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-2">始发地：</label><label class="title col-xs-10" id="startAddress_view"></label>	
							    </div>	
							     <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-2">目的省：</label><label class="title col-xs-4" id="targetProvince_view"></label>
							     <label class="title col-xs-2">目的地：</label><label class="title col-xs-4" id="targetAddress_view"></label>								    
							    </div>
							     <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-2">附件：</label><label class="title col-xs-10" id="file_view"></label>							    								    
							    </div>
							    <!-- <div id="hidden3">				
							  <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-2">公里数 ：</label><label class="title col-xs-10" id="distance_view"></label>							     
							    </div>
							    </div> -->
							    <hr class="tree"></hr>
							   <div class="add-item">
							     <label class="title">商品车信息：</label>	
							     <table id="cardetable_view" class="table table-striped table-bordered table-hover">
			                      <thead>
				                   <tr>					                   													
					               <th>序号</th>
					               <th>类型</th>
                                  <!--  <th >供应商名称</th> -->
                                   <th>品牌</th>
                                   <th>车架号</th>
                                   <th>车型</th>
                                   <th>颜色</th> 
                                   <th>发动机号</th> 
                                   <th>备注</th>
                                   <!-- <th>状态</th>   -->                                                                           
				                     </tr>
			                      </thead>
			                      <tbody>
			                      </tbody>
			                      </table>								     
							    </div>	
							      <hr class="tree"></hr>
							   <div class="add-item">
							     <label class="title">配件信息：</label>	
							     <table id="attachmentdetable_view" class="table table-striped table-bordered table-hover">
			                      <thead>
				                   <tr>													
					               <th>序号</th>
					               <th>配件名称</th>
                                   <th>存放位置</th>
                                   <th>数量</th>
                                   <th>备注</th>
                                 <!--   <th>状态</th>        -->                                                                                                      
				                     </tr>
			                      </thead>
			                      <tbody>
			                      </tbody>
			                      </table>									     
							    </div>										   			  
							    <hr class="tree"></hr>							    
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
<script src="${ctx}/staticPublic/js/uploadify/jquery.uploadify.min.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/waybill/waybillManage/getWaybillList" , //获取数据的ajax方法的URL							 
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
						    {data: "waybillNo","width": "8%"},
						    {data: "type","width": "5%"},
						    {data: "supplierName","width": "7%"},
						    {data: "brand","width": "6%"},
						    {data: "carShopName","width": "7%"},
						    {data: "startAddress","width": "7%"},
						    {data: "targetProvince","width": "7%"},/* 目的省 */
						    {data: "targetCity","width": "7%"},		
						    {data: "sendTime","width": "9%"},	
						    {data: "insertTime","width": "8%"},
						    {data: "status","width": "6%"},						   
						    {data: null,"width": "17%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 2,
				 render: function (data, type, row, meta) {
					 if(data=='0'){
						 return '商品车';
					 }else if(data=='1'){
						 return '二手车';
					 }else{
						 return data;
					 }				
			       }	       
			},{
				 //入职时间
				 targets: 9,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return data.substr(0,16);
					 }else{
						 return '';
					 }
					
			       }	       
			},{
				 //入职时间
				 targets: 10,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return data.substr(0,19);
					 }else{
						 return '';
					 }
					
			       }	       
			},{
				 //入职时间
				 targets: 11,
				 render: function (data, type, row, meta) {
					 if(data=='0'){
						 return '新建';
					 }else if(data=='1'){
						 return '待复核';
					 }else if(data=='2'){
						 return '待回执';
					 }else if(data=='3'){
						 return '已完成';
					 }else {
						 return data;
					 }						
			       }	       
			},
		      	{
			    	 //操作栏
			    	 targets: 12,
			    	 render: function (data, type, row, meta) {	
			    		 return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>';
			    			  		    				                 
		                }	       
		    	} 
		      ],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
	doupload();
}
/*附件上传*/
function doupload(){
	$("#inputfile").uploadify({
		//按钮额外自己添加点的样式类.upload
        'buttonClass':'upload',
        //限制文件上传大小
        'fileSizeLimit':'200MB',
        //文件选择框显示
        'fileTypeDesc':'选择',
        //文件类型过滤
       /*  'fileTypeExts':'*.pdf;*.jpg;*.jpeg;*.png;*.gif;*.bmp;*.tiff;*.ai;*.cdr;*.eps',  */
        //按钮高度
        'height':'30',
        //按钮宽度
        'width':'100',
        //请求类型
        'method':'post',
        //是否支持多文件上传
        'multi':false,
        /* //需要重写的事件
        'overrideEvents'    :    ['onUploadError'], */
        /* //队列ID，用来显示文件上传队列与进度
        'queueID'            :    'photo_queue', */
        //队列一次最多允许的文件数，也就是一次最多进入上传队列的文件数
        'queueSizeLimit': 1,
        //上传动画，插件文件下的swf文件
        'swf':'${ctx}/staticPublic/js/uploadify/uploadify.swf',
        //处理上传文件的服务类
        'uploader':'${ctx}/upload/saveFile?type=waybill',
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
        	//刷新目录
        	var orginFileName = JSON.parse(data).orginFileName;        		
        	var attachFilePath = JSON.parse(data).attachFilePath;
        	 var attachFilePaths="${ctx}"+attachFilePath;
        	//console.info(attachFilePath);
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#filename').html(html);
        	$('#filename_hidden').val(orginFileName);
        	$('#filepath_hidden').val(attachFilePath);
        }
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
		 "sAjaxSource": "${ctx}/waybill/waybillManage/getWaybillList", //获取数据的ajax方法的URL	
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
						    {data: "waybillNo","width": "8%"},
						    {data: "type","width": "5%"},
						    {data: "supplierName","width": "7%"},
						    {data: "brand","width": "6%"},
						    {data: "carShopName","width": "7%"},
						    {data: "startAddress","width": "7%"},
						    {data: "targetProvince","width": "7%"},/* 目的省 */
						    {data: "targetCity","width": "7%"},	
						    {data: "sendTime","width": "9%"},	
						    {data: "insertTime","width": "8%"},
						    {data: "status","width": "6%"},						   
						    {data: null,"width": "17%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 2,
				 render: function (data, type, row, meta) {
					 if(data=='0'){
						 return '商品车';
					 }else if(data=='1'){
						 return '二手车';
					 }else{
						 return data;
					 }				
			       }	       
			},{
				 //入职时间
				 targets: 9,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return data.substr(0,16);
					 }else{
						 return '';
					 }
					
			       }	       
			},{
				 //入职时间
				 targets: 10,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return data.substr(0,19);
					 }else{
						 return '';
					 }
					
			       }	       
			},{
				 //入职时间
				 targets: 11,
				 render: function (data, type, row, meta) {
					 if(data=='0'){
						 return '新建';
					 }else if(data=='1'){
						 return '待复核';
					 }else if(data=='2'){
						 return '待回执';
					 }else if(data=='3'){
						 return '已完成';
					 }else {
						 return data;
					 }						
			       }	       
			},
		      	{
			    	 //操作栏
			    	 targets: 12,
			    	 render: function (data, type, row, meta) {	
			    		 return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>';
			    			  		    				                 
		                }	       
		    	} 
		      ],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){		
	var url = location.href;
	if(url.indexOf("?")>0){
    var waybillNo = url.substring(url.indexOf("?")+1,url.length);
    $("#fom_waybillNo").val(waybillNo);
	}	
	init();
	bindSup();
	bindbrand();
	bindCarShop();
	//getOutSourcing();//获取外协单位
	//getCarShop();
})

/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   //console.log(pageStartIndex);		
	   var pageSize=aoData[4]["value"];
	   var waybillNo=$("#fom_waybillNo").val(); 
	   var status=$("#fom_status").val(); 
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				waybillNo :$.trim(waybillNo) ,
				status : $.trim(status)				
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.log(JSON.stringify(data.data));							
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

	
/* 删除运输车辆信息*/
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该运单信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/waybill/waybillManage/deleteWaybill/"+id,
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
};
/* 新增信息 */
/* 供应商绑定 */
function bindSup(){
$.ajax({
	type : 'GET',
	url : "${ctx}/waybill/waybillManage/getBasicSuppliersList",
	data :JSON.stringify({}),
	contentType : "application/json;charset=UTF-8",
	dataType : 'JSON',
	success : function(data) {
		if (data && data.code == 200) {
			var html ='<option value="">请选择供应商</option>';
			if(data.data!=null && data.data!=''){
        		if(data.data.length>0){
        			for(var i=0;i<data.data.length;i++){
            			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
            		}
        		}
        	}
        	$('#supplierId').html(html);
		} else {
			bootbox.alert(data.msg);
		}
	}
	
});
}
/* 品牌绑定 */
function bindbrand(){
$.ajax({
	type : 'GET',
	url : "${ctx}/waybill/waybillManage/getCarBrandList",
	data :JSON.stringify({}),
	contentType : "application/json;charset=UTF-8",
	dataType : 'JSON',
	success : function(data) {
		if (data && data.code == 200) {
			var html ='<option value="">请选择品牌</option>';
			if(data.data!=null && data.data!=''){
        		if(data.data.length>0){
        			for(var i=0;i<data.data.length;i++){
            			html +='<option value='+data.data[i]['brandName']+'>'+data.data[i]['brandName']+'</option>';
            		}
        		}
        	}
        	$('#brand').html(html);
		} else {
			bootbox.alert(data.msg);
		}
	}
	
});
}
/* 经销单位（4s店）绑定 */
function bindCarShop(){
$.ajax({
	type : 'GET',
	url : "${ctx}/waybill/waybillManage/getCarShopList",
	data :JSON.stringify({}),
	contentType : "application/json;charset=UTF-8",
	dataType : 'JSON',
	success : function(data) {
		if (data && data.code == 200) {
			var html ='<option value="">请选择经销单位</option>';
			if(data.data!=null && data.data!=''){
        		if(data.data.length>0){
        			for(var i=0;i<data.data.length;i++){
            			html +='<option value='+data.data[i]['id']+' data-province='+data.data[i]['province']+' data-city='+data.data[i]['city']+'>'+data.data[i]['name']+'</option>';
            		}
        		}
        	}
        	$('#carShopId').html(html);
		} else {
			bootbox.alert(data.msg);
		}
	}
	
});
}
/* 根据4S店获取目的省，目的地 */
function chooseStart(e){
	var province=$(e).find('option:selected').attr('data-province');
	var city=$(e).find('option:selected').attr('data-city');
	if(province!=null){
		$('#targetProvince_first').val(province);
	}
	if(city!=null){
		$('#targetAddress_first').val(city);
	}
	
	
	
}
/*新增信息输入  */
function doadd(){
	clear();
	bindSup();
	bindbrand();
	bindCarShop();
	$('#addBtn').show();
	$('#editBtn').hide();
	$('#myModalLabel').html('新增运单信息');	
	 $("#newcarview").show();
	 $("#nextcarview").hide();
	$('#modal-info').modal('show');
	$('#type').change(function(){
		//alert($(this).children('option:selected').val()); 
		var type=$(this).children('option:selected').val();
		if(type=='0'){
			 $("#newcarview").show();
			 $("#nextcarview").hide();
		}else{
			 $("#newcarview").hide();
			 $("#nextcarview").show();			
		}
	})
	/* $("#sendTime_first").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	}); */
	$("#sendTime_first").datetimepicker({
	      language: 'cn',
	      format: "yyyy-mm-dd hh:ii",
	      autoclose: true,
	      todayBtn: true
	   });
	$("#sendTime_next").datetimepicker({
		language: 'cn',
	      format: "yyyy-mm-dd hh:ii",
	      autoclose: true,//选中之后自动隐藏日期选择框
	      todayBtn: true
	});
}
/* 关闭窗体 */
function refresh(){
	clear();
	$('#modal-info').modal('hide');
	
}
/* 数据重置 */
function clear(){
	$('#id-hidden').val('');	
	$('#waybillNo').val('');
	$('#type').val('0');
	$('#supplierId').val('');	
	$('#amount').val('');	
	$('#brand').val('');	
	$('#carShopId').val('');
	$('#sendTime_next').val('');
	$('#sendTime_first').val('');
	$('#receiveUser').val('');
	$('#receiveUserTelephone').val('');
	$('#receiveUserMobile').val('');
	$('#startAddress_first').val('');
	$('#startAddress_next').val('');
	$('#targetAddress_first').val('');
	$('#targetAddress_next').val('');
	$('#targetProvince_first').val('');
	$('#distance').val('');	
	$('#inputfile').val('');
	$('#filename').html('');
	$('#filename_hidden').val('');
	$('#filepath_hidden').val('');
	$("#type").attr("disabled",false);
}
/* 保存新增外协单位信息 */
function save(){
	var flag="false";
	var supplierId=$("#supplierId").find("option:selected").val(); 
	var type=$("#type").find("option:selected").val(); 
	var waybillNo=$("#waybillNo").val(); 
	//var amount=$("#amount").val(); 
	var brand=$("#brand").val(); 
	var carShopId=$("#carShopId").find("option:selected").val();
	var sendTime_first=$("#sendTime_first").val(); 
	var sendTime_next=$("#sendTime_next").val(); 
	var receiveUser=$("#receiveUser").val(); 
	var receiveUserTelephone=$("#receiveUserTelephone").val(); 
	var receiveUserMobile=$("#receiveUserMobile").val(); 
	var startAddress_first=$("#startAddress_first").val(); 
	var startAddress_next=$("#startAddress_next").val(); 
	var targetAddress_first=$("#targetAddress_first").val(); 
	var targetProvince_first=$("#targetProvince_first").val();
	var targetProvince_next=$("#targetProvince_next").val();
	var targetAddress_next=$("#targetAddress_next").val(); 
	/* var distance=$("#distance").val();	 */
	var filename=$("#filename_hidden").val();
	var filepath=$("#filepath_hidden").val();
	if(type=='0'){
		sendTime=sendTime_first;
		startAddress=startAddress_first;
		targetAddress=targetAddress_first;
		targetProvince=targetProvince_first;
		if(waybillNo=='' || waybillNo==null){
			bootbox.alert('运单编号不能为空！');
			return;
		}
		if(supplierId=='' || supplierId==null || supplierId=='-1'){
			bootbox.alert('供应商不能为空！');
			return;
		}
		if(brand=='' || brand==null || brand=='-1'){
			bootbox.alert('品牌不能为空！');
			return;
		}
		if(carShopId=='' || carShopId==null || carShopId=='-1'){
			bootbox.alert('经销单位不能为空！');
			return;
		}
		if(sendTime_first=='' || sendTime_first==null){
			bootbox.alert('下单日期不能为空！');
			return;
		}
		if(startAddress_first=='' || startAddress_first==null){
			bootbox.alert('始发地不能为空！');
			return;
		}
		if(targetProvince_first=='' || targetProvince_first==null){
			bootbox.alert('目的省不能为空！');
			return;
		}
		if(targetAddress_first=='' || targetAddress_first==null){
			bootbox.alert('目的地不能为空！');
			return;
		}
		
	}else{
		sendTime=sendTime_next;
		startAddress=startAddress_next;
		targetAddress=targetAddress_next;
		targetProvince=targetProvince_next;
		if(sendTime_next=='' || sendTime_next==null){
			bootbox.alert('下单日期不能为空！');
			return;
		}
		if(startAddress_next=='' || startAddress_next==null){
			bootbox.alert('始发地不能为空！');
			return;
		}
		if(targetProvince_next=='' || targetProvince_next==null){
			bootbox.alert('目的省不能为空！');
			return;
		}
		if(targetAddress_next=='' || targetAddress_next==null){
			bootbox.alert('目的地不能为空！');
			return;
		}
		if(receiveUser=='' || receiveUser==null ){
			bootbox.alert('接车联系人不能为空！');
			return;
		}
		if(receiveUserTelephone=='' || receiveUserTelephone==null){
			bootbox.alert('接车联系人电话不能为空！');
			return;
		}
		if(receiveUserMobile=='' || receiveUserMobile==null){
			bootbox.alert('接接车联系人手机不能为空！');
			return;
		}
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增运单信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/waybill/waybillManage/insertWaybill',
						data : JSON.stringify({
							waybillNo : waybillNo,				
							type : type,
							supplierId : supplierId,
							//amount : amount,
							brand : brand,
							carShopId : carShopId,
							sendTime : sendTime,
							receiveUser : receiveUser,
							receiveUserTelephone : receiveUserTelephone,
							receiveUserMobile : receiveUserMobile,
							startAddress : startAddress,
							targetCity : targetAddress,
							attachFileName: $.trim(filename),
							attachFilePath : $.trim(filepath),
							targetProvince : targetProvince
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
//打开编辑页面
function doedit(id){	
	clear();
	$("#sendTime_first").datetimepicker({
	      language: 'cn',
	      format: "yyyy-mm-dd hh:ii",//日期格式
	      autoclose: true,//选中之后自动隐藏日期选择框
	      todayBtn: true
	   });
	$("#sendTime_next").datetimepicker({
		language: 'cn',
	      format: "yyyy-mm-dd hh:ii",//日期格式
	      autoclose: true,//选中之后自动隐藏日期选择框
	      todayBtn: true
	});
	
	$("#type").attr("disabled",true);
	$.ajax({
		type : 'GET',
		url : "${ctx}/waybill/waybillManage/queryWaybill/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑运单信息');
				$("#waybillNo").val(data.data.waybillNo); 
				$("#type").val(data.data.type); 
				if(data.data.type=='0'){
					 $("#newcarview").show();
					 $("#nextcarview").hide();
				}else{
					 $("#newcarview").hide();
					 $("#nextcarview").show();			
				}
				$("#supplierId").val(data.data.supplierId); 
				$("#amount").val(data.data.amount); 
				$("#brand").val(data.data.brand); 
				$("#carShopId").val(data.data.carShopId);				
				$("#receiveUser").val(data.data.receiveUser); 
				$("#receiveUserTelephone").val(data.data.receiveUserTelephone); 
				$("#receiveUserMobile").val(data.data.receiveUserMobile); 				
				$("#sendTime_first").val(data.data.sendTime); 
				$("#startAddress_first").val(data.data.startAddress);
				$("#targetAddress_first").val(data.data.targetCity);
				$("#targetProvince_first").val(data.data.targetProvince);
				$("#targetProvince_next").val(data.data.targetProvince);
				$("#sendTime_next").val(data.data.sendTime); 
				$("#startAddress_next").val(data.data.startAddress);
				$("#targetAddress_next").val(data.data.targetCity);
				$("#filename_hidden").val(data.data.attachFileName);
				$("#filepath_hidden").val(data.data.attachFilePath);
				var attachFilePath=data.data.attachFilePath;
				if(data.data.attachFilePath!=''&&data.data.attachFilePath!=null){
					var attachFilePaths="${ctx}"+attachFilePath;
					var htmls='<a  href='+attachFilePaths+' target="_blank">'+data.data.attachFileName+'</a>';
					$('#filename').html(htmls);
				}
				$('#addBtn').hide();
				$('#editBtn').show();				
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
	var supplierId=$("#supplierId").find("option:selected").val(); 
	var type=$("#type").find("option:selected").val(); 
	var waybillNo=$("#waybillNo").val(); 
	//var amount=$("#amount").val(); 
	var brand=$("#brand").val(); 
	var carShopId=$("#carShopId").find("option:selected").val();
	var sendTime_first=$("#sendTime_first").val(); 
	var sendTime_next=$("#sendTime_next").val(); 
	var receiveUser=$("#receiveUser").val(); 
	var receiveUserTelephone=$("#receiveUserTelephone").val(); 
	var receiveUserMobile=$("#receiveUserMobile").val(); 
	var startAddress_first=$("#startAddress_first").val(); 
	var startAddress_next=$("#startAddress_next").val(); 
	var targetAddress_first=$("#targetAddress_first").val();
	var targetProvince_first=$("#targetProvince_first").val();
	var targetProvince_next=$("#targetProvince_next").val();
	var targetAddress_next=$("#targetAddress_next").val(); 	
	var filename=$("#filename_hidden").val();
	var filepath=$("#filepath_hidden").val();
	if(type=='0'){
		sendTime=sendTime_first;
		startAddress=startAddress_first;
		targetAddress=targetAddress_first;
		targetProvince=targetProvince_first;
		if(waybillNo=='' || waybillNo==null){
			bootbox.alert('运单编号不能为空！');
			return;
		}
		if(supplierId=='' || supplierId==null || supplierId=='-1'){
			bootbox.alert('供应商不能为空！');
			return;
		}
		if(brand=='' || brand==null || brand=='-1'){
			bootbox.alert('品牌不能为空！');
			return;
		}
		if(carShopId=='' || carShopId==null || carShopId=='-1'){
			bootbox.alert('经销单位不能为空！');
			return;
		}
		if(sendTime_first=='' || sendTime_first==null){
			bootbox.alert('下单日期不能为空！');
			return;
		}
		if(startAddress_first=='' || startAddress_first==null){
			bootbox.alert('始发地不能为空！');
			return;
		}
		if(targetProvince_first=='' || targetProvince_first==null){
			bootbox.alert('目的省不能为空！');
			return;
		}
		if(targetAddress_first=='' || targetAddress_first==null){
			bootbox.alert('目的地不能为空！');
			return;
		}
		
	}else{
		sendTime=sendTime_next;
		startAddress=startAddress_next;
		targetAddress=targetAddress_next;
		targetProvince=targetProvince_next;
		if(sendTime_next=='' || sendTime_next==null){
			bootbox.alert('下单日期不能为空！');
			return;
		}
		if(startAddress_next=='' || startAddress_next==null){
			bootbox.alert('始发地不能为空！');
			return;
		}
		if(targetProvince_next=='' || targetProvince_next==null){
			bootbox.alert('目的省不能为空！');
			return;
		}
		if(targetAddress_next=='' || targetAddress_next==null){
			bootbox.alert('目的地不能为空！');
			return;
		}
		if(receiveUser=='' || receiveUser==null ){
			bootbox.alert('接车联系人不能为空！');
			return;
		}
		if(receiveUserTelephone=='' || receiveUserTelephone==null){
			bootbox.alert('接车联系人电话不能为空！');
			return;
		}
		if(receiveUserMobile=='' || receiveUserMobile==null){
			bootbox.alert('接接车联系人手机不能为空！');
			return;
		}
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该运单信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/waybill/waybillManage/updateWaybill',
						data : JSON.stringify({
							id : id,
							waybillNo : waybillNo,				
							type : type,
							supplierId : supplierId,
							//amount : amount,
							brand : brand,
							carShopId : carShopId,
							sendTime : sendTime,
							receiveUser : receiveUser,
							receiveUserTelephone : receiveUserTelephone,
							receiveUserMobile : receiveUserMobile,
							startAddress : startAddress,
							targetCity : targetAddress,
							attachFileName: $.trim(filename),
							attachFilePath : $.trim(filepath),
							targetProvince : targetProvince
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
//绑定商品车
function dobindcar(id){	
	$("#cardetable tbody tr").remove();  
	$('#wabillId-hidden').val(id);
	$('#modal-carinfo').modal('show');
	$('#caraddBtn').show();		
	 $(".checkall").click(function () {
	      var check = $(this).prop("checked");
	      $(".checkchild").prop("checked", check);
	      
	      $('#cardetable').find('tbody > tr').each(function(){
				var row = this;
				if($(".checkall").is(":checked") != true && $(this).hasClass('selected') != true)//勾选全部，但是下面每个都去掉勾选，再去掉勾选全部，是不执行任何操作，不然又全部选择了。
				{
					//alert('aa');
				} 
				else
				{
					$(this).toggleClass('selected');
				}
				
			});
	});
	
	var table = $('#cardetable').DataTable();	
	opencar();
	$('#cardetable tbody').on( 'click', 'tr', function () {
		 if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true)
		{
			$(this).toggleClass('selected');
		} 
		 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true)
		{
			$(this).toggleClass('selected');
		}
		 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') != true)
			{
			 $(".checkall").attr("checked",false);
			// $(".checkchild").prop("checked", check);
			}
		// console.info($("input[type='checkbox']").size()+","+$("input[type='checkbox']:checked").size());	
		 if($("input[type='checkbox']:checked").size()==$("input[type='checkbox']").size()-1)
			{
			 $(".checkall").attr("checked",true);
			}
  }); 
}
function opencar(){
	$('#cardetable').DataTable({
		"destroy": true,//如果需要重新加载需销毁
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/waybill/waybillManage/queryCarStock", //获取数据的ajax方法的URL	
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
				 columns: [{
		             "sClass": "text-center",
		             "data": "id",
		             "render": function (data, type, full, meta) {
		            	 if(full.waybillId!=''&&full.waybillId!=null){
		            		 return '<input type="checkbox"  class="checkchild" checked="checked" value="' + data + '" />';
		            	 }else{
		            		 return '<input type="checkbox"  class="checkchild"  value="' + data + '" />'; 
		            	 }
		                
		             },
		             "bSortable": false,
		             "width": "4%"
		         	},{ data: "rownum" ,"width": "6%"},
				            {data: "type","width": "8%"},
						    {data: "supplierName","width": "17%"},
						    {data: "brand","width": "8%"},
						    {data: "vin","width": "10%"},
						    {data: "model","width": "10%"},
						    {data: "color","width": "8%"},
						    {data: "engineNo","width": "10%"},
						    {data: "mark","width": "10%"},							   
						    {data: "status","width": "10%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 2,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
										 return '商品车';
									 }else if(data=='1'){
										 return '二手车';
									 }else{
										 return '';
									 }						
							       }	       
							},{
								 //入职时间
								 targets: 10,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
										 return '新建';
									 }else if(data=='1'){
										 return '待复核';
									 }else if(data=='2'){
										 return '已入库';
									 }else if(data=='3'){
										 return '已出库';
									 }else{
										 return '';
									 }					
							       }	       
							}
						      ],
					        "fnServerData":retrieveDatas //与后台交互获取数据的处理函数
    });
}
function retrieveDatas(sSource, aoData, fnCallback){
	var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var type=$("#fom_type").val(); 
	   var vin=$("#fom_vin").val();
	  // var carstatus=$("#fom_carstatus").val();
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				type :$.trim(type) ,
				vin  :$.trim(vin),				
				waybillId :$.trim($('#wabillId-hidden').val())	
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
//绑定商品车查询
function searchcarInfo(){
	opencar();
}
function refresh_carinfo(){
	$('#modal-carinfo').modal('hide');	
}
//绑定商品车保存
function bindCarStock(){
	var flag="false";
	$('#cardetable tbody tr').each(function(){
		//console.log($(this).find(".checkchild").is(":checked"));
		 if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true)
			{
				$(this).toggleClass('selected');
			} 
			 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true)
			{
				$(this).toggleClass('selected');
			}
	});
	var table = $('#cardetable').DataTable();
	var wabillId= $('#wabillId-hidden').val();
	var ids="";
	 for(var i = 0;i<table.rows('.selected').data().length;i++)
	 {
		 ids+=","+table.rows('.selected').data()[i]['id'];
		// console.info(JSON.stringify(table.rows('.selected').data()[i]));
	 }	
	 ids=ids.substring(1);
	 if(ids==""){
		 bootbox.alert("请勾选商品车！");
		 return;
	 }
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要绑定商品车吗?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'GET',
							url : "${ctx}/waybill/waybillManage/batchBindCarStock/"+wabillId+"/"+ids,		
							contentType : "application/json;charset=UTF-8",
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {									
									bootbox.confirm_alert({ 
										  size: "small",
										  message: "绑定成功！", 
										  callback: function(result){
											  if(result){
												  flag="true";
												refresh_carinfo();
												reload();
											  }else{
												refresh_carinfo();
												reload(); 
											  }
										  }
									 });
									setTimeout(function(){
										if(flag=="false"){
											refresh_carinfo();
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
//绑定配件
function dobindattachment(id){	
	$("#attachmentdetable tbody tr").remove();  
	$('#atwabillId-hidden').val(id);
	$('#modal-attachmentinfo').modal('show');
	$('#caratcaddBtn').show();		
	 $(".checkall").click(function () {
	      var check = $(this).prop("checked");
	      $(".checkchild").prop("checked", check);
	      
	      $('#attachmentdetable').find('tbody > tr').each(function(){
				var row = this;
				if($(".checkall").is(":checked") != true && $(this).hasClass('selected') != true)//勾选全部，但是下面每个都去掉勾选，再去掉勾选全部，是不执行任何操作，不然又全部选择了。
				{
					//alert('aa');
				} 
				else
				{
					$(this).toggleClass('selected');
				}
				
			});
	});
	
	var table = $('#attachmentdetable').DataTable();	
	openattachment();
	$('#attachmentdetable tbody').on( 'click', 'tr', function () {
		 if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true)
		{
			$(this).toggleClass('selected');
		} 
		 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true)
		{
			$(this).toggleClass('selected');
		}
		 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') != true)
			{
			 $(".checkall").attr("checked",false);
			// $(".checkchild").prop("checked", check);
			}
		// console.info($("input[type='checkbox']").size()+","+$("input[type='checkbox']:checked").size());	
		 if($("input[type='checkbox']:checked").size()==$("input[type='checkbox']").size()-1)
			{
			 $(".checkall").attr("checked",true);
			}
  }); 
}
//配件数据信息
function openattachment(){
	$('#attachmentdetable').DataTable({
		"destroy": true,//如果需要重新加载需销毁
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/waybill/waybillManage/queryCarAttachment", //获取数据的ajax方法的URL	
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
				 columns: [{
		             "sClass": "text-center",
		             "data": "id",
		             "render": function (data, type, full, meta) {
		            	 if(full.waybillId!=''&&full.waybillId!=null){
		            		 return '<input type="checkbox"  class="checkchild" checked="checked" value="' + data + '" />';
		            	 }else{
		            		 return '<input type="checkbox"  class="checkchild"  value="' + data + '" />'; 
		            	 }
		                
		             },
		             "bSortable": false,
		             "width": "4%"
		         	},{ data: "rownum" ,"width": "4%"},
				            {data: "attachmentName","width": "8%"},
						    {data: "position","width": "15%"},
						    {data: "count","width": "8%"},
						    {data: "mark","width": "10%"},							   
						    {data: "status","width": "10%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 6,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
										 return '新建';
									 }else if(data=='1'){
										 return '待复核';
									 }else if(data=='2'){
										 return '已入库';
									 }else if(data=='3'){
										 return '已出库';
									 }else{
										 return '';
									 }					
							       }	       
							}
						      ],
					        "fnServerData":retrieveDataatments //与后台交互获取数据的处理函数
    });
}
function retrieveDataatments(sSource, aoData, fnCallback){
	var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var attachmentName=$("#fom_attachmentName").val(); 	   
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				attachmentName :$.trim(attachmentName) ,				
				waybill_id :$.trim($('#atwabillId-hidden').val())	
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

//绑定配件查询
function searchattachInfo(){
	openattachment();
}
function refresh_attachmentinfo(){
	$('#modal-attachmentinfo').modal('hide');	
}
//绑定配件保存
function bindattachment(){
	var flag="false";
	$('#attachmentdetable tbody tr').each(function(){
		//console.log($(this).find(".checkchild").is(":checked"));
		 if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true)
			{
				$(this).toggleClass('selected');
			} 
			 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true)
			{
				$(this).toggleClass('selected');
			}
	});
	var table = $('#attachmentdetable').DataTable();
	var wabillId= $('#atwabillId-hidden').val();
	var ids="";
	 for(var i = 0;i<table.rows('.selected').data().length;i++)
	 {
		 ids+=","+table.rows('.selected').data()[i]['id'];
		// console.info(JSON.stringify(table.rows('.selected').data()[i]));
	 }	
	 ids=ids.substring(1);
	// console.info(ids);
	 if(ids==""){
		 bootbox.alert("请勾选配件！");
		 return;
	 }
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要绑定配件吗?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'GET',
							url : "${ctx}/waybill/waybillManage/batchBindCarAttachment/"+wabillId+"/"+ids,
							data :JSON.stringify({}),
							contentType : "application/json;charset=UTF-8",
							dataType : 'JSON',
							success : function(data) {
								if (data && data.code == 200) {
									bootbox.confirm_alert({ 
										  size: "small",
										  message: "绑定成功！", 
										  callback: function(result){
											  if(result){
												  flag="true";
												refresh_attachmentinfo();
												reload();
											  }else{
												refresh_attachmentinfo();
												reload(); 
											  }
										  }
									 });
									setTimeout(function(){
										if(flag=="false"){
											refresh_attachmentinfo();
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
//运单提交
function dosubmit(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该运单吗?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/waybill/waybillManage/submitWaybill/"+id,
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
}
 function doview(id){
	 cleardetil();
	$.ajax({
		type : 'GET',
		url : "${ctx}/waybill/waybillManage/checkWaybill/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				/* console.info(JSON.stringify(data.data)); */
				$('#id-hidden').val(id);
				$('#myModalLabel').html('运单信息');
				$("#waybillNo_view").html(data.data.waybillNo);
				if(data.data.type=='1'){
					$("#type_view").html('二手车'); 
					$('#hidden1').hide();
					$('#hidden3').hide();
					$('#hidden2').show();
				}else{
					$("#type_view").html('商品车'); 
					$('#hidden1').show();
					$('#hidden2').hide();
					$('#hidden3').show();
				}				
				$("#supplierId_view").html(data.data.supplierName); 
				$("#amount_view").html(data.data.amount); 
				$("#brand_view").html(data.data.brand); 
				$("#carShopId_view").html(data.data.carShopName);
				$("#sendTime_view").html(data.data.sendTime); 
				$("#receiveUser_view").html(data.data.receiveUser); 
				$("#receiveUserTelephone_view").html(data.data.receiveUserTelephone); 
				$("#receiveUserMobile_view").html(data.data.receiveUserMobile); 
				$("#startAddress_view").html(data.data.startAddress);
				$("#targetAddress_view").html(data.data.targetCity);
				$("#targetProvince_view").html(data.data.targetProvince);
				$("#distance_view").html(data.data.distance);	
				
				if(data.data.attachFileName!=''&&data.data.attachFileName!=null&&data.data.attachFilePath!=''&&data.data.attachFilePath!=null){
					var attachFilePathes="${ctx}"+data.data.attachFilePath;
					$("#file_view").html('<a  href='+attachFilePathes+' target="_blank">'+data.data.attachFileName+'</a>');
				}
				if(data.data.carStockList.length>0){
					for(var i=0;i<data.data.carStockList.length;i++){
						data.data.carStockList[i]["rownum"]=i+1;
					}
					$('#cardetable_view').dataTable({
						 dom: 'Bfrtip',	
						 destroy: true,
						 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
						 "bFilter": false,    //不使用过滤功能  
						 "bProcessing": true, //加载数据时显示正在加载信息	
						 "bPaginate" : false,
						 "bInfo" : false,
						  ordering: false,
							"oLanguage": {
								"sZeroRecords": "抱歉， 没有找到",
								"sInfoEmpty": "没有数据",
								"sInfoFiltered": "(从 _MAX_ 条数据中检索)",							
								"sZeroRecords": "没有检索到数据"
								},	
						data: data.data.carStockList,
				        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
				        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
				        columns: [	
				            { data: 'rownum' },
				            {data: "type"},
						    /* {data: "supplierName"}, */
						    {data: "brand"},
						    {data: "vin"},
						    {data: "model"},
						    {data: "color"},
						    {data: "engineNo"},
						    {data: "mark"},							   
						    /* {data: "status"} */],
						    columnDefs: [{
								 targets: 1,
								 render: function (data, type, row, meta) {
									 if(data=='0'){
										 return '商品车';
									 }else if(data=='1'){
										 return '二手车';
									 }else{
										 return '';
									 }						
							       }	       
							}
						      ]
					});
				}
				if(data.data.carAttachmentStockList.length>0){
					for(var i=0;i<data.data.carAttachmentStockList.length;i++){
						data.data.carAttachmentStockList[i]["rownum"]=i+1;
					}
					$('#attachmentdetable_view').dataTable({
						 dom: 'Bfrtip',
						 destroy: true,
						 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
						 "bFilter": false,    //不使用过滤功能  
						 "bProcessing": true, //加载数据时显示正在加载信息	
						 "bPaginate" : false,
						 "bInfo" : false,
						  ordering: false,
							"oLanguage": {
								"sZeroRecords": "抱歉， 没有找到",
								"sInfoEmpty": "没有数据",
								"sInfoFiltered": "(从 _MAX_ 条数据中检索)",							
								"sZeroRecords": "没有检索到数据"
								},	
						data: data.data.carAttachmentStockList,
				        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
				        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
				        columns: [	
				            { data: 'rownum' },
				            {data: "attachmentName"},
						    {data: "position"},
						    {data: "count"},
						    {data: "mark"},							   
						   /*  {data: "status"} */]
					});
				}
				$('#viewBtn').show();
				$('#modal-detilinfo').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
} 
 //明细页面管理
 function doclose(){	
	 $('#modal-detilinfo').modal('hide'); 
 }
 function cleardetil(){
	    $("#waybillNo_view").html('');					
		$("#supplierId_view").html(''); 
		$("#amount_view").html(''); 
		$("#brand_view").html(''); 
		$("#carShopId_view").html('');
		$("#sendTime_view").html(''); 
		$("#receiveUser_view").html(''); 
		$("#receiveUserTelephone_view").html(''); 
		$("#receiveUserMobile_view").html(''); 
		$("#startAddress_view").html('');
		$("#targetAddress_view").html('');
		$("#distance_view").html('');
		$("#cardetable_view tbody tr").remove();  
		$("#attachmentdetable_view tbody tr").remove();  
 }
</script>



</body>
</html>






