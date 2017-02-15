
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
				调度管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="mng">
		   <div class="table-tit">新建调度单</div>
		   <div class="table-item">
		     <div class="table-itemTit">基本信息</div>
		     <!-- 第一列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label><span class="red">*</span>装运日期:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <div class="input-group input-group-sm">
						<input class="form-control" id="sendTime" type="text" placeholder="请输入装运日期" />
						<span class="input-group-addon">
							<i class="icon-calendar"></i>
						</span>
					</div>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label><span class="red">*</span>交车日期:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <div class="input-group input-group-sm">
						<input class="form-control" id="receiveTime" type="text" placeholder="请输入交车日期" />
						<span class="input-group-addon">
							<i class="icon-calendar"></i>
						</span>
					</div>
			       </div>
		       </div>
		     </div>
		     <!-- 第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label><span class="red">*</span>台数:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			         <input class="form-control" id="all-amount" type="text" placeholder="请输入台数" disabled="disabled" value="0"/>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label><span class="red">*</span>装运车号:</label>
			       </div>
			     </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <select class="form-control" id="carNumber">
				            <option value="-1">请选择装运车号</option>
				          </select>
				       </div>
			       </div>
		     </div>
		     <!-- 第三列 -->
		     <div class="row newrow">
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label><span class="red">*</span>驾驶员:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <input class="form-control" id="driver" type="text" readonly="readonly" placeholder="请输入驾驶员" />
				          <input class="form-control" id="driver_id" type="hidden"  />
				       </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>联系号码:</label>
				       </div>
			       </div>
				   <div class="col-xs-5">
				     <div class="form-contr">
				      <input class="form-control" id="mobile" type="text" readonly="readonly" placeholder="请输入联系号码" />
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
				      <input class="form-control" id="mark" type="text" placeholder="请输入备注" />
				     </div>
				   </div>
			 </div>
			 <!-- 添加预付申请信息 -->
			 <div class="table-itemTit">预付申请信息</div>
			 <!-- 预付第一列 -->
			 <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>预付现金:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <input class="form-control" id="prepayCash" type="text" placeholder="请输入预付现金" onblur="revaildate(this,0);" />
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>开户行:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <input class="form-control" id="bankName" type="text" placeholder="请输入开户行" />
			       </div>
		       </div>
		     </div>
		     <!-- 预付第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>账号:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <input class="form-control" id="bankAccount" type="text" placeholder="请输入账号" onblur="cardNoConfirmBlur(this,0);"/>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>预付油卡号:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <input class="form-control" id="oilCardNo" type="text" placeholder="请输入预付油卡卡号" onblur="cardNoConfirmBlur(this,1);" />
			       </div>
		       </div>
			 </div>
			 <!-- 预付第三列 -->
		     <div class="row newrow">
		     	<div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>预付油费:</label>
			       </div>
		       </div>
			   <div class="col-xs-5">
			     <div class="form-contr">
			      <input class="form-control" id="oilAmount" type="text" placeholder="请输入金额" onblur="revaildate(this,1);" />
			     </div>
			    </div>
			    <div class="col-xs-6"></div>
			   </div>
		     <!--设置详细信息-->
		     <div class="row row-btn-tit">
		        <div class="col-xs-2 pd-2">
			       <div class="row-tit">
			                           设置详细信息
			       </div>
		       </div>
		       <div class="col-xs-7"></div>
		       <div class="col-xs-3">
				  <div class="form-contr-1">
				     <a class="form-btn-1 fr" onclick="addHandCar();"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>二手车</a>
				     <a class="form-btn-1 fr" onclick="addNewCar();" style="margin-right:15px;"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>商品车</a>
				     <input id="initLength" type="hidden"/>
				  </div>
			   </div>
		     </div>
		     <!-- 第一条详细信息 -->
		     <div id="detailList0" class="border-b-ff9a00 detailList">
		       <!-- 第五列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label><span class="red">*</span>经销单位:</label>
			       </div>
		       </div>
		       <div class="col-xs-3">
			       <div class="form-contr">
			          <select class="form-control carShopId" id="carShop0" onChange="change4S(this,0);">
			          </select>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label><span class="red">*</span>台数:</label>
			       </div>
		       </div>
		       <div class="col-xs-3">
			       <div class="form-contr">
			          <input class="form-control initAmount" id="amount0" type="text" placeholder="请输入台数" disabled="disabled" value="0"/>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>详细指令:</label>
			       </div>
		       </div>
		       <div class="col-xs-3">
			       <div class="form-contr">
			          <input class="form-control" id="detailMark0" type="text" placeholder="请输入详细指令" />
			       </div>
		       </div>
		     </div>
		     <div class="row newrow">
		     	<div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label><span class="red">*</span>始发省:</label>
			       </div>
		       </div>
		       <div class="col-xs-3">
			       <div class="form-contr">
			          <select class="form-control carShopId" id="startProvince0" onchange="createCities(this,'startAddress0')">
			          </select>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label><span class="red">*</span>始发地:</label>
			       </div>
		       </div>
		       <div class="col-xs-3">
			       <div class="form-contr">
			          <select class="form-control carShopId" id="startAddress0" >
			          	<option value="---请选择市县---">---请选择市县---</option>
			          </select>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label><span class="red">*</span>目的省:</label>
			       </div>
		       </div>
		       <div class="col-xs-3">
			       <div class="form-contr">
			          <select class="form-control carShopId" id="endProvince0" onchange="createCitiesEnd(this,'endAddress0')">
			          </select>
			       </div>
		       </div>
		     
		     </div>
		     <div class="row newrow">
		     	  <div class="col-xs-1 pd-2" >
			       <div class="lab-tit">
			          <label><span class="red">*</span>目的地:</label>
			       </div>
		       </div>
		       <div class="col-xs-3">
			       <div class="form-contr">
			          <select class="form-control carShopId" id="endAddress0" >
			          	<option value="---请选择市县---">---请选择市县---</option>
			          </select>
			       </div>
		       </div>
		     </div>
		     <!-- 第六列 -->
		     <div class="row newrow">
		        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>新增车辆:</label>
			       </div>
		       </div>
			  <div class="col-xs-11">
				  <div class="form-contr">
				     <a class="form-btn" id="addCarItem0" onclick="bindCar(0)"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>新增车辆信息</a>
				  </div>
				  <div id="newCarDetail0" class="newCarDetail" data-id="0"></div>
			   </div>
		     </div>
		     <!-- 第七列 -->
		     <div class="row newrow">
		        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>新增配件:</label>
			       </div>
		       </div>
			  <div class="col-xs-11">
				  <div class="form-contr">
				     <a class="form-btn" id="addPartItem0" onclick="bindPart(0)"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>新增配件信息</a>
				  </div>
				  <div id="newPartDetail0"></div>
			   </div>
		      </div>
		     </div>
		     
		     <!-- 操作按钮栏 -->
		     <div class="row newrow">
		     <div class="col-xs-3"></div>
		       <div class="col-xs-1">
			       <div class="form-contr">
			          <a class="savebtn" onclick="dosave();"><i class="icon-save" style="display: inline-block;width: 20px;"></i>保存</a>
			       </div>
		       </div>
		       <div class="col-xs-4"></div>
		       <div class="col-xs-1">
			       <div class="form-contr">
			          <a class="backbtn" onclick="doback();"><i class="icon-undo" style="display: inline-block;width: 20px;"></i>返回</a>
			       </div>
		       </div>
		       <div class="col-xs-3"></div>
		     </div>
		   </div>
		</div>
	</div>
	<!-- 经销商id -->
	<input id="carShop-Id" type="hidden" />
	<!-- 详细信息主键 -->
	<input id="detail-Id" type="hidden" />
	<!-- 新增商品车Id集合用逗号隔开 -->
	<input id="idList" type="hidden"/>
	
	<!-- 已选4S店Id集合用逗号隔开 -->
	<input id="shopList" type="hidden" />
	<!-- 新增车辆信息--Modal begin-->
	<div class="modal fade" id="modal-addCar" tabindex="-1" role="dialog">
		     <div class="modal-header" style="padding:0 15px;">
		        <button class="close" type="button" data-dismiss="modal">×</button>
				<h3 id="myModalLabel">新增车辆信息</h3>
		    </div>
			<div class="modal-body" style="height:498px;">
			  <div class="widget-box dia-widget-box">
					<div class="widget-body">
						<div class="widget-main">
						  <table id="carTable" class="table table-striped table-bordered table-hover">
			                      <thead>
				                    <tr>	
					                   <th class="center"><input type="checkbox" class="checkall" /></th>													
						               <th>序号</th>
						               <th>车架号</th>
	                                   <th>车型</th>
	                                   <th>颜色</th>
	                                   <th>运单编号</th> 
	                                   <th>品牌</th>
	                                   <th>发动机编号</th>
	                                   <th>入库时间</th>                                                                                                            
				                     </tr>
			                      </thead>
			                      <tbody>
			                       
			                      </tbody>
			                 </table>							   			  
							 <hr class="tree"></hr>
							 <div class="add-item-btn dis-block">
								  <a class="add-itemBtn btnOk" onclick="saveCar();">保存</a>
								  <a class="add-itemBtn btnCancle" onclick="cancleCar();">关闭</a>
							  </div>			
						</div>
					</div>
			  </div>
			</div>
	</div>
	<!-- 新增车辆信息--Modal end-->
	
	<!-- 新增二手车车辆信息--Modal begin-->
	<div class="modal fade" id="modal-addOldCar" tabindex="-1" role="dialog">
		     <div class="modal-header" style="padding:0 15px;">
		        <button class="close" type="button" data-dismiss="modal">×</button>
				<h3 id="myModalLabel">新增二手车车辆信息</h3>
		    </div>
			<div class="modal-body" style="height:498px;">
			  <div class="widget-box dia-widget-box">
					<div class="widget-body">
						<div class="widget-main">
						  <table id="oldcarTable" class="table table-striped table-bordered table-hover">
			                      <thead>
				                    <tr>	
					                   <th class="center"><input type="checkbox" class="checkall2" /></th>													
						               <th>序号</th>
						               <th>车架号</th>
	                                   <th>车型</th>
	                                   <th>颜色</th>
	                                   <th>运单编号</th> 
	                                   <th>品牌</th>
	                                   <th>发动机编号</th>
	                                   <th>入库时间</th>                                                                                                            
				                     </tr>
			                      </thead>
			                      <tbody>
			                       
			                      </tbody>
			                 </table>							   			  
							 <hr class="tree"></hr>
							 <div class="add-item-btn dis-block">
								  <a class="add-itemBtn btnOk" onclick="saveOldCar();">保存</a>
								  <a class="add-itemBtn btnCancle" onclick="cancleOldCar();">关闭</a>
							  </div>			
						</div>
					</div>
			  </div>
			</div>
	</div>
	<!-- 新增二手车车辆信息--Modal end-->
	
	<!-- 新增配件信息--Modal begin-->
	<div class="modal fade" id="modal-addPart" tabindex="-1" role="dialog" style="width: 600px;">
		<!-- <div class="modal-dialog" style="padding-top:5%;"> -->
		  <div class="modal-content" style="border: 0px solid rgba(0,0,0,0.2)">
		     <div class="modal-header" style="padding:0 15px;">
		        <button class="close" type="button" data-dismiss="modal">×</button>
				<h3 id="myModalLabel">新增配件信息</h3>
		    </div>
			<div class="modal-body">
			  <div class="widget-box dia-widget-box">
					<div class="widget-body" style="height:498px;">
						<div class="widget-main">
						  <table id="partTable" class="table table-striped table-bordered table-hover">
			                      <thead>
				                    <tr>	
					                   <th class="center"><input type="checkbox" class="checkall1" /></th>													
						               <th>序号</th>
						               <th>配件</th>
						               <th>存放位置</th>
	                                   <th>库存总量</th>
	                                   <th>出库数</th>                                                                                                   
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
		<!-- </div> -->
	</div>
	<!-- 新增车辆信息--Modal end-->
	
	<!-- 新增二手车配件信息--Modal begin-->
	<div class="modal fade" id="modal-addOldPart" tabindex="-1" role="dialog">
		<div class="modal-dialog" style="padding-top:5%;">
		  <div class="modal-content">
		     <div class="modal-header" style="padding:0 15px;">
		        <button class="close" type="button" data-dismiss="modal">×</button>
				<h3 id="myModalLabel">新增二手车配件信息</h3>
		    </div>
			<div class="modal-body">
			  <div class="widget-box dia-widget-box">
					<div class="widget-body" style="height:498px;">
						<div class="widget-main">
						  <table id="oldpartTable" class="table table-striped table-bordered table-hover">
			                      <thead>
				                    <tr>	
					                   <th class="center"><input type="checkbox" class="checkall3" /></th>													
						               <th>序号</th>
						               <th>配件</th>
						               <th>存放位置</th>
	                                   <th>库存总量</th>
	                                   <th>出库数</th>                                                                                                   
				                     </tr>
			                      </thead>
			                      <tbody>
			                        
			                      </tbody>
			                 </table>							   			  
							 <hr class="tree"></hr>
							 <div class="add-item-btn dis-block">
								  <a class="add-itemBtn btnOk" onclick="saveOldPart();">保存</a>
								  <a class="add-itemBtn btnCancle" onclick="cancleOldPart();">关闭</a>
							  </div>			
						</div>
					</div>
			  </div>
			</div>
		  </div>
		</div>
	</div>
	<!-- 新增车辆信息--Modal end-->
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
<script src="${ctx}/staticPublic/js/citySchedule.js"></script>
<script type="text/javascript">
  $(function(){
	  /* 时间控件初始化 */
	  $('#sendTime').datepicker({
			 language: 'cn',
	         autoclose: true,//选中之后自动隐藏日期选择框
	         format: "yyyy-mm-dd"//日期格式
	 });
	  $('#receiveTime').datepicker({
			 language: 'cn',
	         autoclose: true,//选中之后自动隐藏日期选择框
	         format: "yyyy-mm-dd"//日期格式
	 });
	  getStockList();
	  /* 根据货运车绑定驾驶员 */
	  $('#carNumber').on('change',function(e){
		  var mobile="";
		  if($(this).val()=='-1' || $(this).val()==null){
			  $('#driver').val('');
			  $('#driver_id').val('');
			  $('#mobile').val('');
			  var detailList=$('.detailList').length;
			  for(var i=0;i<detailList;i++){
				  $('#startAddress'+i+'').val('');
			  }
		  }else{
			  if(null == $(this).find('option:selected').attr('data-driverName') || "null" == $(this).find('option:selected').attr('data-driverName'))
			  {
				  $('#driver').val("");
			  }
			  else
			  {
				  $('#driver').val($(this).find('option:selected').attr('data-driverName'));
			  }
			  if(0 == $(this).find('option:selected').attr('data-driverId'))
			  {
				  $('#driver_id').val("");
			  }
			  else
			  {
				  $('#driver_id').val($(this).find('option:selected').attr('data-driverId'));
			  }
			  
			  if($(this).find('option:selected').attr('data-mobile')!="null" && $(this).find('option:selected').attr('data-mobile')!=''){
				  mobile=$(this).find('option:selected').attr('data-mobile');
			  }
			  $('#mobile').val(mobile);
			  var detailList=$('.detailList').length;
			  for(var i=0;i<detailList;i++){
				  getStartAddress($(this).find('option:selected').attr('data-no'),i);
			  }
			  
		  }
		  
	  });
	  getCarShopList(0);
	  getElemtnt(0);
	  //创建省份  
	    createProvinces();
	    createProvincesEnd();
  });
  
  /* 获取始发地 */
  function getStartAddress(carNumber,k){
	  $.ajax({
			type : 'POST',
			url : "${ctx}/operationMng/sendCarCommand/getNewOne",
			data : {
				carNumber :$.trim(carNumber)
			},
			dataType : 'JSON',
			success : function(data) {
				if(data.data!=null){
					if(data.data.endAddress!='' && data.data.endAddress!=null){
						$('#startAddress'+k+'').val(data.data.endAddress);
					}else{
						$('#startAddress'+k+'').val('');
					}
				}else{
					$('#startAddress'+k+'').val('');
				}
				
			}
	  });
  }
  
  /* 绑定货运车 */
  function getStockList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/scheduleMng/getStockList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: JSON.stringify({}),
	        success: function (data) {
	        	var html ='<option value="-1" data-id="-1" data-no="">请选择装运车号</option>';
	            if(data.code == 200){  
	            	//console.info(JSON.stringify(data.data));
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+' data-driverId='+data.data[i]['driverId']+' data-driverName='+data.data[i]['driverName']+' data-mobile='+data.data[i]['mobile']+' data-no='+data.data[i]['no']+'>'+data.data[i]['no']+'['+data.data[i]['status']+']</option>';
	                		}
	            		}
	            	}
	            	$('#carNumber').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
  }
  /* 绑定4s店 */
  function getCarShopList(index){
	  $.ajax({  
	        url: '${ctx}/operationMng/scheduleMng/getCarShopList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="-1">请选择经销单位</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+' data-province='+data.data[i]['province']+' data-city='+data.data[i]['city']+'>'+data.data[i]['name']+'</option>';
	                		}
	            		}
	            	}
	            	$('#carShop'+index+'').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
  }
  
 /* 新增商品车详细信息 */
 function addNewCar(){
	 var index=$('.detailList').length;
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要新增商品车详细信息?", 
		  callback: function(result){   
			  if(result){
			   var html='<div class="border-b-ff9a00 detailList" id="detailList'+index+'">'
			   		   +'<div class="row newrow"><div class="col-xs-10 pd-2"></div><div class="col-xs-2"><div class="form-contr-1"><a class="delete-detail fr" onclick="removeDetail(this,'+index+');"><i class="icon-minus-sign" style="display: inline-block;width: 20px;"></i>删除</a></div></div></div>'
				       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>经销单位:</label></div></div>'
				       +'<div class="col-xs-3"><div class="form-contr"><select class="form-control carShopId" id="carShop'+index+'" class="carShopId" onChange="change4S(this,'+index+');"></select></div></div>'
				       +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>台数:</label></div></div>'
				       +'<div class="col-xs-3"><div class="form-contr"><input class="form-control initAmount" id="amount'+index+'" type="text" placeholder="请输入台数" value="0" disabled="disabled"/></div></div>'
				       +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>详细指令:</label></div></div>'
				       +'<div class="col-xs-3"><div class="form-contr"><input class="form-control" id="detailMark'+index+'" type="text" placeholder="请输入详细指令" /></div></div></div>'
				       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>始发省:</label></div></div>'
				       +'<div class="col-xs-3"><div class="form-contr"><select class="form-control carShopId" id="startProvince'+index+'" onchange="createCities(this,\'startAddress'+index+'\')" ></select></div></div>'
				       +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>始发地:</label></div></div>'
				       +'<div class="col-xs-3"><div class="form-contr"><select class="form-control carShopId" id="startAddress'+index+'" ><option value="---请选择市县---">---请选择市县---</option></select></div></div>'
				       +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>目的省:</label></div></div>'
				       +'<div class="col-xs-3"><div class="form-contr"><select class="form-control carShopId" id="endProvince'+index+'" onchange="createCitiesEnd(this,\'endAddress'+index+'\')" ></select></div></div></div>'
				       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>目的地:</label></div></div>'
				       +'<div class="col-xs-3"><div class="form-contr"><select class="form-control carShopId" id="endAddress'+index+'" ><option value="---请选择市县---">---请选择市县---</option></select></div></div></div>'
				       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>新增车辆:</label></div></div><div class="col-xs-11"><div class="form-contr">'
				       +'<a class="form-btn" id="addCarItem'+index+'" onclick="bindCar('+index+')"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>新增车辆信息</a></div>'
				       +'<div id="newCarDetail'+index+'" class="newCarDetail" data-id="'+index+'"></div></div></div>'
				       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>新增配件:</label></div></div>'
				       +'<div class="col-xs-11"><div class="form-contr"><a class="form-btn" id="addPartItem'+index+'" onclick="bindPart('+index+')"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>新增配件信息</a>'
				       +'</div><div id="newPartDetail'+index+'"></div></div></div></div>'; 
				       $('#detailList'+(index-1)+'').after(html);
				       getCarShopList(index);
				       getStartAddress($('#carNumber').find('option:selected').attr('data-no'),index);
				       //获得实体
				       getElemtnt(index);
				       //创建省份  
				         createProvinces();
				         createProvincesEnd();
				         //默认显示请选择
				         /* for(var i=0;i<province.options.length;i++){ 
				     	    if ( province.options[i].value == "---请选择省份---")                
				     	    {          
				     	    	province.options[i].selected = true;   
				     	    	console.info(city);
				     	    	city.options.add(new Option('---请选择市县---','---请选择市县---')); 
				     	    	break;
				     	    }   
				         }
				         for(var i=0;i<endProvince.options.length;i++){ 
				      	    if ( endProvince.options[i].value == "---请选择省份---")                
				      	    {          
				      	    	endProvince.options[i].selected = true; 
				      	    	endCity.options.add(new Option('---请选择市县---','---请选择市县---')); 
				      	    	break;
				      	    }   
				          }  */
				          //选择省份后，切换对应城市列表  
				         //province.onchange=createCities;
				         //endProvince.onchange=createCitiesEnd;
			  }
		  }
	 });
 }

 /* 控制只能选择一次4s店 */
 function change4S(e,index){
	    var info="";
	    var shopList=$('#shopList').val();
	    var arr=[];
	    if (shopList.length > 0 ) {
			shopList = shopList.substring(0, shopList.length-1);
			arr = shopList.split(',');
		}
	    if(arr.length>0){
			 for(var i=0;i<arr.length;i++){
				 if($(e).val()==arr[i] && $(e).val()!='-1'){
					 bootbox.alert('请不要重复选择重复经销单位！');
					 $(e).val('-1');
					 return;
				 }
			 }
	    }
	    var province=$(e).find('option:selected').attr('data-province');
	    var city=$(e).find('option:selected').attr('data-city');
	    if(province!=null && province!=''){
	    	$('#endProvince'+index+'').val(province);
	    	loadcitysEnd(province,'endAddress'+index);
	    }
	    if(city!=null && city!=''){
	    	$('#endAddress'+index+'').val(city);
	    }
		$('.carShopId').each(function(){
			if($(this)!=null && $(this).val()!='' && $(this).val()!='-1'){
				info+=$(this).val()+',';
			}
			$('#shopList').val(info);
		});
		
 }

 /* 新增车辆信息 */
function bindCar(index){
	 var id=$('#carShop'+index+'').val();
	 var size=0,all=0;
	 if(id=="" || id== null || id=="-1"){
		 bootbox.alert('请先选择经销单位！');
	 }else{
		 $("#carShop-Id").val(id);
		 $("#detail-Id").val(index);
		 var html="",htmlItem="";
		 var partId="";
		 var arr=[];
		 $('#newCarDetail'+index+' table tbody').find('tr').each(function(){
			 var partItem=$(this).find('td').eq(0).attr('data-id');
			 if(partItem!=null && partItem!=''){
				 partId+=partItem+',';
			 }
			
		 });
			 partId = partId.substring(0, partId.length-1);
			 arr = partId.split(',');
			   var secho='1';   
			   var pageStartIndex='0';
			   var pageSize=1000;
			   $('#secho').val(secho);
			   var obj = {};
				 $.ajax({
					type : 'POST',
					url : "${ctx}/operationMng/scheduleMng/getCarList",
					data : JSON.stringify({
						sEcho : $.trim(secho),				
						pageStartIndex : $.trim(pageStartIndex),
						pageSize : $.trim(pageSize),
						carShopId :$.trim(id)
					}),
					contentType : "application/json;charset=UTF-8",
					dataType : 'JSON',
					success : function(data) {
						if (data && data.code == 200) {						
							obj.iTotalDisplayRecords=data.data.totalCounts;
							obj.iTotalRecords=data.data.totalCounts;
							obj.aaData=data.data.records;		
							obj.sEcho=data.data.frontParams;
							all=obj.aaData.length;
							if(obj.aaData.length>0){
								for(var i=0;i<obj.aaData.length;i++){
									obj.aaData[i]["rownum"]=i+1;
									obj.aaData[i]["insertTime"]=jsonDateFormat(obj.aaData[i]["insertTime"]);
									if(obj.aaData[i]["brand"]!=null && obj.aaData[i]["brand"]!=''){
										obj.aaData[i]["brand"]=obj.aaData[i]["brand"];
									}else{
										obj.aaData[i]["brand"]=""
									}
									if(obj.aaData[i]["color"]!=null && obj.aaData[i]["color"]!=''){
										obj.aaData[i]["color"]=obj.aaData[i]["color"];
									}else{
										obj.aaData[i]["color"]=""
									}
									if(obj.aaData[i]["vin"]!=null && obj.aaData[i]["vin"]!=''){
										obj.aaData[i]["vin"]=obj.aaData[i]["vin"];
									}else{
										obj.aaData[i]["vin"]=""
									}
									if(arr.length>0){
										for(var j=0;j<arr.length;j++){
											if(obj.aaData[i]["id"]==arr[j]){
												htmlItem='<tr class="selected"><td class="text-center"><input type="checkbox" checked="checked" class="checkchild"></td>'
												     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
												     +'<td>'+obj.aaData[i]["vin"]+'</td>'
												     +'<td>'+obj.aaData[i]["model"]+'</td>'
												     +'<td>'+obj.aaData[i]["color"]+'</td>'
												     +'<td>'+obj.aaData[i]["waybillNo"]+'</td>'
												     +'<td>'+obj.aaData[i]["brand"]+'</td>'
												     +'<td>'+obj.aaData[i]["engineNo"]+'</td>'
												     +'<td>'+obj.aaData[i]["insertTime"]+'</td></tr>';
												     size++;
												     break;
											}else{
												htmlItem='<tr><td class=" text-center"><input type="checkbox" class="checkchild"></td>'
												     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
												     +'<td>'+obj.aaData[i]["vin"]+'</td>'
												     +'<td>'+obj.aaData[i]["model"]+'</td>'
												     +'<td>'+obj.aaData[i]["color"]+'</td>'
												     +'<td>'+obj.aaData[i]["waybillNo"]+'</td>'
												     +'<td>'+obj.aaData[i]["brand"]+'</td>'
												     +'<td>'+obj.aaData[i]["engineNo"]+'</td>'
												     +'<td>'+obj.aaData[i]["insertTime"]+'</td></tr>';
											}
											
										}
										html+=htmlItem;
									}else{
										if(obj.aaData[i]["scheduleBillNo"]!=null && obj.aaData[i]["scheduleBillNo"]!=''){
											html+='<tr><td class="text-center"><input type="checkbox" class="checkchild" disabled="disabled"></td>'
											     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
											     +'<td>'+obj.aaData[i]["vin"]+'</td>'
											     +'<td>'+obj.aaData[i]["model"]+'</td>'
											     +'<td>'+obj.aaData[i]["color"]+'</td>'
											     +'<td>'+obj.aaData[i]["waybillNo"]+'</td>'
											     +'<td>'+obj.aaData[i]["brand"]+'</td>'
											     +'<td>'+obj.aaData[i]["engineNo"]+'</td>'
											     +'<td>'+obj.aaData[i]["insertTime"]+'</td></tr>';
										}else{
											html+='<tr><td class="text-center"><input type="checkbox" class="checkchild"></td>'
											     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
											     +'<td>'+obj.aaData[i]["vin"]+'</td>'
											     +'<td>'+obj.aaData[i]["model"]+'</td>'
											     +'<td>'+obj.aaData[i]["color"]+'</td>'
											     +'<td>'+obj.aaData[i]["waybillNo"]+'</td>'
											     +'<td>'+obj.aaData[i]["brand"]+'</td>'
											     +'<td>'+obj.aaData[i]["engineNo"]+'</td>'
											     +'<td>'+obj.aaData[i]["insertTime"]+'</td></tr>';
										}
										
										
									}
								}
								 if(size==all && size>0){
									 checkChooseCar(true);
								 }else{
									 checkChooseCar(false); 
								 }
							}else{
								html+="<tr><td colspan='9'>暂无商品车信息</td></tr>";
							}
							$('#carTable tbody').html(html);
						} 
						
					}
				 });
				 $('#modal-addCar').modal('show');
		 }
 } 
 

 /* 保存车辆信息 */
 function saveCar(){
	 var idList="";
	 var count=0;
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要新增该商品车详细信息?", 
		  callback: function(result){
			  if(result){
				    var index=$("#detail-Id").val()
					var table=$('#carTable tbody');
					var objs=[];
					var htmlItem='',html="";
					for(i=0;i<table.children('tr.selected').length;i++){
						var obj={};
						var tr=table.children('tr.selected').eq(i);
						obj.id=tr.find('td').eq(1).attr('data-id');
						obj.vin=tr.find('td').eq(2).html();
						obj.model=tr.find('td').eq(3).html();
						obj.color=tr.find('td').eq(4).html();
						obj.insertTime=tr.find('td').eq(8).html();
						obj.waybillNo=tr.find('td').eq(5).html();
						obj.carshop=$("#carShop"+index+"").find("option:selected").text();
						if(tr.find('td').eq(6).html()!='' && tr.find('td').eq(6).html()!=null){
							obj.brand=tr.find('td').eq(6).html();
						}else{
							obj.brand="";
						}
						objs.push(obj);
						htmlItem+='<tr><td data-id='+obj.id+'>'+obj.vin+'</td><td>'+obj.model+'</td>'
						    +'<td>'+obj.color+'</td><td>'+obj.insertTime+'</td>'
						    +'<td>'+obj.waybillNo+'</td><td>'+obj.carshop+'</td>'
						    +'<td>'+obj.brand+'</td>'
						    +'<td><a class="deleteBtn" onclick="deleteCar(this)">删除</a></td></tr>';
					}
					html='<table class="carList table table-striped table-bordered table-hover">'
				        +'<thead><tr><th>车架号</th><th>车型</th><th>颜色</th><th>入库时间</th><th>运单编号</th><th>经销单位</th><th>品牌</th><th>操作</th></tr></thead>'
				        +'<tbody>'+htmlItem+'</tbody>';
					$('#newCarDetail'+index+'').html(html);
					if(table.children('tr.selected')!=null){
						count=table.children('tr.selected').length;
					}
					$('#amount'+index+'').val(count);
					$('#modal-addCar').modal('hide');
					getAmountAll();
					
			  }
		  }
	 });
 }
 /* 删除车辆信息 */
 function deleteCar(e){
	 var count=0;
	 var table=$(e).parents('.carList').find('tbody');
	 var index=$(e).parents('.newCarDetail').attr('data-id');
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该商品车详细信息?", 
		  callback: function(result){
			  if(result){
				  $(e).parents('tr').remove();
				  if(table.children('tr')!=null){
						count=table.children('tr').length;
					}
					$('#amount'+index+'').val(count);
					getAmountAll();
			  }
		  }
	 })
 }
 /* 取消车辆信息 */
 function cancleCar(){
	 $('#modal-addCar').modal('hide');
 }
 
 /* 取消配件信息 */
 function canclePart(){
	 $('#modal-addPart').modal('hide');
 }
 
 
/* 新增配件信息 */
function bindPart(index){
	 var id=$('#carShop'+index+'').val();
	 var html="",htmlItem="";
	 var size=0,all=0;
	 $("#detail-Id").val(index);
	 var partId="";
	 if(id=="" || id== null || id=="-1"){
		 bootbox.alert('请先选择经销单位！');
	 }else{
		 var arr=[];
		 $('#newPartDetail'+index+' table tbody').find('tr').each(function(){
			 var partItem=$(this).find('td').eq(0).attr('data-id');
			 if(partItem!=null && partItem!=''){
				 partId+=partItem+',';
			 }
			
		 });
			 partId = partId.substring(0, partId.length-1);
			 arr = partId.split(',');
		   var secho='1';   
		   var pageStartIndex='0';
		   var pageSize=1000;
		   var outnum=1;
		   $('#secho').val(secho);
		   var obj = {};
			 $.ajax({
				type : 'POST',
				url : "${ctx}/operationMng/scheduleMng/getCarAttachmentList",
				data : JSON.stringify({
					sEcho : $.trim(secho),				
					pageStartIndex : $.trim(pageStartIndex),
					pageSize : $.trim(pageSize),
					carShopId :$.trim(id)
				}),
				contentType : "application/json;charset=UTF-8",
				dataType : 'JSON',
				success : function(data) {
					if (data && data.code == 200) {						
						obj.iTotalDisplayRecords=data.data.totalCounts;
						obj.iTotalRecords=data.data.totalCounts;
						obj.aaData=data.data.records;		
						obj.sEcho=data.data.frontParams;
						all=obj.aaData.length;
						if(obj.aaData.length>0){
							for(var i=0;i<obj.aaData.length;i++){
								obj.aaData[i]["rownum"]=i+1;
								if(null == obj.aaData[i]["position"] || "null" == obj.aaData[i]["position"])
								{
									obj.aaData[i]["position"] = "";
								}
								if(obj.aaData[i]["count"]>0){
									outnum=1;
								}else{
									outnum=0;
								}
								if(arr.length>0){
									for(var j=0;j<arr.length;j++){
										if(obj.aaData[i]["id"]==arr[j]){
											htmlItem='<tr class="selected"><td class="text-center"><input type="checkbox" checked="checked" class="checkchild1"></td>'
											     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
											     +'<td>'+obj.aaData[i]["attachmentName"]+'</td>'
											     +'<td>'+obj.aaData[i]["position"]+'</td>'
											     +'<td>'+obj.aaData[i]["count"]+'</td>'
											     +'<td><input type="text" value="'+outnum+'" onkeyup="blurSumCheck(this)"/></td></tr>';
											     size++;
											     break;
										}else{
											htmlItem='<tr><td class=" text-center"><input type="checkbox" class="checkchild1"></td>'
											     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
											     +'<td>'+obj.aaData[i]["attachmentName"]+'</td>'
											     +'<td>'+obj.aaData[i]["position"]+'</td>'
											     +'<td>'+obj.aaData[i]["count"]+'</td>'
											     +'<td><input type="text" value="'+outnum+'" onkeyup="blurSumCheck(this)"/></td></tr>';
										}
										
									}
									html+=htmlItem;
								}else{
									html+='<tr><td class=" text-center"><input type="checkbox"  class="checkchild1"></td>'
									     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
									     +'<td>'+obj.aaData[i]["attachmentName"]+'</td>'
									     +'<td>'+obj.aaData[i]["position"]+'</td>'
									     +'<td>'+obj.aaData[i]["count"]+'</td>'
									     +'<td><input type="text" value="'+outnum+'" onkeyup="blurSumCheck(this)"/></td></tr>';
								}
							}
							if(size==all && size>0){
								 checkChoose(true);
							 }else{
								 checkChoose(false); 
							 }
						}else{
							html+="<tr><td colspan='6'>暂无配件信息</td></tr>";
						}
						$('#partTable tbody').html(html);
					} 
					
				}
			 });
		 $('#modal-addPart').modal('show');
		 
	 }
 } 
 /* 配件多选框选择 */
function checkChoose(flag){
	    if(flag==true){//全选 
	        $(".checkall1").prop("checked",true); 
	    }else{//不全选 
	        $(".checkall1").prop("checked",false); 
	    } 
	 $(".checkall1").on('click',function () {
	      var check = $(this).prop("checked");
	      $(".checkchild1").prop("checked", check);
	      if(check==true){
	    	  $(".checkchild1").parents('tr').addClass('selected');
	      }else{
	    	  $(".checkchild1").parents('tr').removeClass('selected');
	      }
	});
	   
	$('#partTable tbody').on( 'click', 'tr', function () {
	  if($(this).find(".checkchild1").is(":checked") == true && $(this).hasClass('selected') != true){
			$(this).toggleClass('selected');
	   } 
	  if($(this).find(".checkchild1").is(":checked") != true && $(this).hasClass('selected') == true){
			$(this).toggleClass('selected');
	   }
	  if($(this).find(".checkchild1").is(":checked") != true && $(this).hasClass('selected') != true){
			$(".checkall1").prop("checked",false);
	  }
	  if($("input[class='checkchild1']:checked").size()==$("input[class='checkchild1']").size() && $("input[class='checkchild1']").size()>0 ){//全选 
	        $(".checkall1").prop("checked",true); 
	    }
   }); 
 }
/* 二手车配件多选框选择 */
function checkChooseOld(flag){
	   
	    if(flag==true){//全选 
	        $(".checkall3").prop("checked",true); 
	    }else{//不全选 
	        $(".checkall3").prop("checked",false); 
	    } 
	 $(".checkall3").on('click',function () {
	      var check = $(this).prop("checked");
	      $(".checkchild3").prop("checked", check);
	      if(check==true){
	    	  $(".checkchild3").parents('tr').addClass('selected');
	      }else{
	    	  $(".checkchild3").parents('tr').removeClass('selected');
	      }
	});
	   
	$('#oldpartTable tbody').on( 'click', 'tr', function () {
	  if($(this).find(".checkchild3").is(":checked") == true && $(this).hasClass('selected') != true){
			$(this).toggleClass('selected');
	   } 
	  if($(this).find(".checkchild3").is(":checked") != true && $(this).hasClass('selected') == true){
			$(this).toggleClass('selected');
	   }
	  if($(this).find(".checkchild3").is(":checked") != true && $(this).hasClass('selected') != true){
			$(".checkall3").prop("checked",false);
	  }
	  if($("input[class='checkchild3']:checked").size()==$("input[class='checkchild3']").size() && $("input[class='checkchild3']").size()>0 ){//全选 
	        $(".checkall3").prop("checked",true); 
	    }
   }); 
 }
/* 商品车多选框选择 */
function checkChooseCar(flag){
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
	   
	$('#carTable tbody').on( 'click', 'tr', function () {
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
/* 二手车多选框选择 */
function checkChooseOldCar(flag){ 
	    if(flag==true){//全选 
	        $(".checkall2").prop("checked",true); 
	    }else{//不全选 
	        $(".checkall2").prop("checked",false); 
	    } 
	 $(".checkall2").on('click',function () {
	      var check = $(this).prop("checked");
	      $(".checkchild2").prop("checked", check);
	      if(check==true){
	    	  $(".checkchild2").parents('tr').addClass('selected');
	      }else{
	    	  $(".checkchild2").parents('tr').removeClass('selected');
	      }
	});
	   
	$('#oldcarTable tbody').on( 'click', 'tr', function () {
	  if($(this).find(".checkchild2").is(":checked") == true && $(this).hasClass('selected') != true){
			$(this).toggleClass('selected');
	   } 
	  if($(this).find(".checkchild2").is(":checked") != true && $(this).hasClass('selected') == true){
			$(this).toggleClass('selected');
	   }
	  if($(this).find(".checkchild2").is(":checked") != true && $(this).hasClass('selected') != true){
			$(".checkall2").prop("checked",false);
	  }
	  if($("input[class='checkchild2']:checked").size()==$("input[class='checkchild2']").size() && $("input[class='checkchild2']").size()>0 ){//全选 
	        $(".checkall2").prop("checked",true); 
	    }
   }); 
 }
 
/* 金额验证 */
function revaildate(e,flag){
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
    var money = $(e).val();
    if(money!=null && money!=''){
    	if (!reg.test(money)) {
    		if(flag=='0'){//预付现金
    			$('#prepayCash').val('');
    		}else if(flag=='1'){//预付油费
    			$('#oilAmount').val('');
    		}
    		bootbox.alert('请输入正确的金额！');
       }
    }
}
/* 卡号验证 */
function cardNoConfirmBlur(e,flag){
	var reg = /[^\d]/g;
    var cardNo = $(e).val();
    if(cardNo!=null && cardNo!=''){
    	if (reg.test(cardNo)) {
    		if(flag=='0'){//账号
    			$('#bankAccount').val('');
    		}else if(flag=='1'){//预付油卡卡号
    			$('#oilCardNo').val('');
    		}
    		bootbox.alert('请输入正确的卡号！');
       }
    }

}
/* 保存配件信息 */
function savePart(){
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要新增该商品车配件详细信息?", 
		  callback: function(result){
			  if(result){
				    var index=$("#detail-Id").val()
					var table=$('#partTable tbody');
					var objs=[];
					var htmlItem='',html="";
					for(i=0;i<table.children('tr.selected').length;i++){
						var obj={};
						var tr=table.children('tr.selected').eq(i);
						var outnum=tr.find('td').eq(5);
						obj.id=tr.find('td').eq(1).attr('data-id');
						obj.attachmentName=tr.find('td').eq(2).html();
						obj.position=tr.find('td').eq(3).html();
						obj.count=tr.find('td').eq(4).html();
						if(outnum.find('input').val()==''){
							bootbox.alert('配件出库数量不能为空！');
							outnum.find('input').val('1');
							return;
						}
						obj.outnum=outnum.find('input').val();
						objs.push(obj);
						htmlItem+='<tr><td data-id='+obj.id+'>'+obj.attachmentName+'</td><td>'+obj.position+'</td>'
						    +'<td>'+obj.count+'</td><td>'+obj.outnum+'</td>'
						    +'<td><a class="deleteBtn" onclick="deletePart(this)">删除</a></td></tr>';
					}
					html='<table class="partList table table-striped table-bordered table-hover">'
				        +'<thead><tr><th>配件</th><th>位置</th><th>库存</th><th>出库数</th><th>操作</th></tr></thead>'
				        +'<tbody>'+htmlItem+'</tbody>'
					$('#newPartDetail'+index+'').html(html);
					$('#modal-addPart').modal('hide');
					
			  }
		  }
	 });
}
/* 判断配件出库量必须小于库存总量 */
function blurSumCheck(e){
	var outnum=$(e).val();
	var num=$(e).parents('tr').find('td').eq(4).html();
	if(parseInt(outnum)>parseInt(num)){
		bootbox.alert('配件出库量不能大于库存总量！');
		$(e).val('1');
	}else if(parseInt(outnum)<=0){
		bootbox.alert('配件出库量不小于0！');
		$(e).val('1');
	}
}

/* 删除配件信息 */

function deletePart(e){
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该配件详细信息?", 
		  callback: function(result){
			  if(result){
				  $(e).parents('tr').remove();
			  }
		  }
	 })
}

/* 新增二手车 */
function addHandCar(){
	 var index=$('.detailList').length;
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要新增二手车详细信息?", 
		  callback: function(result){
			  if(result){
			   var html='<div class="border-b-ff9a00 detailList" id="detailList'+index+'">'
			   		   +'<div class="row newrow"><div class="col-xs-10 pd-2"></div><div class="col-xs-2"><div class="form-contr-1"><a class="delete-detail fr" onclick="removeDetail(this,'+index+');"><i class="icon-minus-sign" style="display: inline-block;width: 20px;"></i>删除</a></div></div></div>'
				       +'<div class="row newrow">'
				       +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>台数:</label></div></div>'
				       +'<div class="col-xs-3"><div class="form-contr"><input class="form-control initAmount" id="amount'+index+'" type="text" placeholder="请输入台数" value="0" disabled="disabled"/></div></div>'
				       +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>详细指令:</label></div></div>'
				       +'<div class="col-xs-3"><div class="form-contr"><input class="form-control" id="detailMark'+index+'" type="text" placeholder="请输入详细指令" /></div></div><div class="col-xs-4"></div></div>'
				       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>始发省:</label></div></div>'
				       +'<div class="col-xs-3"><div class="form-contr"><select class="form-control carShopId" id="startProvince'+index+'" onchange="createCities(this,\'startAddress'+index+'\')" ></select></div></div>'
				       +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>始发地:</label></div></div>'
				       +'<div class="col-xs-3"><div class="form-contr"><select class="form-control carShopId" id="startAddress'+index+'" ><option value="---请选择市县---">---请选择市县---</option></select></div></div>'
				       +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>目的省:</label></div></div>'
				       +'<div class="col-xs-3"><div class="form-contr"><select class="form-control carShopId" id="endProvince'+index+'" onchange="createCitiesEnd(this,\'endAddress'+index+'\')" ></select></div></div></div>'
				       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>目的地:</label></div></div>'
				       +'<div class="col-xs-3"><div class="form-contr"><select class="form-control carShopId" id="endAddress'+index+'" ><option value="---请选择市县---">---请选择市县---</option></select></div></div></div>'
				       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>新增车辆:</label></div></div><div class="col-xs-11"><div class="form-contr">'
				       +'<a class="form-btn" id="addCarItem'+index+'" onclick="bindOldCar('+index+')"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>新增车辆信息</a></div>'
				       +'<div id="newCarDetail'+index+'" class="newCarDetail" data-id="'+index+'"></div></div></div>'
				       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>新增配件:</label></div></div>'
				       +'<div class="col-xs-11"><div class="form-contr"><a class="form-btn" id="addPartItem'+index+'" onclick="bindOldPart('+index+')"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>新增配件信息</a>'
				       +'</div><div id="newPartDetail'+index+'"></div></div></div></div>'; 
				       $('#detailList'+(index-1)+'').after(html);
				       getStartAddress($('#carNumber').find('option:selected').attr('data-no'),index);
				         getElemtnt(index);
				         //创建省份  
				         createProvinces();
				         createProvincesEnd();
			  }
		  }
	 });
}
/* 新增二手车车辆信息 */
function bindOldCar(index){
		 $("#detail-Id").val(index);
		 var html="",htmlItem="";
		 var size=0,all=0;
		 var partId="";
		 var arr=[];
		 $('#newCarDetail'+index+' table tbody').find('tr').each(function(){
			 var partItem=$(this).find('td').eq(0).attr('data-id');
			 if(partItem!=null && partItem!=''){
				 partId+=partItem+',';
			 }
			
		 });
			 partId = partId.substring(0, partId.length-1);
			 arr = partId.split(',');
			   var secho='1';   
			   var pageStartIndex='0';
			   var pageSize=1000;
			   $('#secho').val(secho);
			   var obj = {};
				 $.ajax({
					type : 'POST',
					url : "${ctx}/operationMng/scheduleMng/getSecCarList",
					data : JSON.stringify({
						sEcho : $.trim(secho),				
						pageStartIndex : $.trim(pageStartIndex),
						pageSize : $.trim(pageSize)
						
					}),
					contentType : "application/json;charset=UTF-8",
					dataType : 'JSON',
					success : function(data) {
						if (data && data.code == 200) {						
							obj.iTotalDisplayRecords=data.data.totalCounts;
							obj.iTotalRecords=data.data.totalCounts;
							obj.aaData=data.data.records;		
							obj.sEcho=data.data.frontParams;
							all=obj.aaData.length;
							if(obj.aaData.length>0){
								for(var i=0;i<obj.aaData.length;i++){
									obj.aaData[i]["rownum"]=i+1;
									obj.aaData[i]["insertTime"]=jsonDateFormat(obj.aaData[i]["insertTime"]);
									if(obj.aaData[i]["brand"]!=null && obj.aaData[i]["brand"]!=''){
										obj.aaData[i]["brand"]=obj.aaData[i]["brand"];
									}else{
										obj.aaData[i]["brand"]=""
									}
									if(obj.aaData[i]["color"]!=null && obj.aaData[i]["color"]!=''){
										obj.aaData[i]["color"]=obj.aaData[i]["color"];
									}else{
										obj.aaData[i]["color"]=""
									}
									if(obj.aaData[i]["vin"]!=null && obj.aaData[i]["vin"]!=''){
										obj.aaData[i]["vin"]=obj.aaData[i]["vin"];
									}else{
										obj.aaData[i]["vin"]=""
									}
									if(arr.length>0){
										for(var j=0;j<arr.length;j++){
											if(obj.aaData[i]["id"]==arr[j]){
												htmlItem='<tr class="selected"><td class="text-center"><input type="checkbox" checked="checked" class="checkchild2"></td>'
												     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
												     +'<td>'+obj.aaData[i]["vin"]+'</td>'
												     +'<td>'+obj.aaData[i]["model"]+'</td>'
												     +'<td>'+obj.aaData[i]["color"]+'</td>'
												     +'<td>'+obj.aaData[i]["waybillNo"]+'</td>'
												     +'<td>'+obj.aaData[i]["brand"]+'</td>'
												     +'<td>'+obj.aaData[i]["engineNo"]+'</td>'
												     +'<td>'+obj.aaData[i]["insertTime"]+'</td></tr>';
												     size++;
												     break;
											}else{
												htmlItem='<tr><td class="text-center"><input type="checkbox" class="checkchild2"></td>'
												     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
												     +'<td>'+obj.aaData[i]["vin"]+'</td>'
												     +'<td>'+obj.aaData[i]["model"]+'</td>'
												     +'<td>'+obj.aaData[i]["color"]+'</td>'
												     +'<td>'+obj.aaData[i]["waybillNo"]+'</td>'
												     +'<td>'+obj.aaData[i]["brand"]+'</td>'
												     +'<td>'+obj.aaData[i]["engineNo"]+'</td>'
												     +'<td>'+obj.aaData[i]["insertTime"]+'</td></tr>';
											}
											
										}
										html+=htmlItem;
									}else{
										if(obj.aaData[i]["scheduleBillNo"]!=null && obj.aaData[i]["scheduleBillNo"]!=''){
											html+='<tr><td class="text-center"><input type="checkbox" class="checkchild" disabled="disabled"></td>'
											     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
											     +'<td>'+obj.aaData[i]["vin"]+'</td>'
											     +'<td>'+obj.aaData[i]["model"]+'</td>'
											     +'<td>'+obj.aaData[i]["color"]+'</td>'
											     +'<td>'+obj.aaData[i]["waybillNo"]+'</td>'
											     +'<td>'+obj.aaData[i]["brand"]+'</td>'
											     +'<td>'+obj.aaData[i]["engineNo"]+'</td>'
											     +'<td>'+obj.aaData[i]["insertTime"]+'</td></tr>';
											
										}else{
											html+='<tr><td class="text-center"><input type="checkbox" class="checkchild"></td>'
											     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
											     +'<td>'+obj.aaData[i]["vin"]+'</td>'
											     +'<td>'+obj.aaData[i]["model"]+'</td>'
											     +'<td>'+obj.aaData[i]["color"]+'</td>'
											     +'<td>'+obj.aaData[i]["waybillNo"]+'</td>'
											     +'<td>'+obj.aaData[i]["brand"]+'</td>'
											     +'<td>'+obj.aaData[i]["engineNo"]+'</td>'
											     +'<td>'+obj.aaData[i]["insertTime"]+'</td></tr>';
										}
										
									}
								}
								 if(size==all && size>0){
							    	 checkChooseOldCar(true);
								 }else{
									 checkChooseOldCar(false); 
								 }
							}else{
								html+="<tr><td colspan='9'>暂无二手车车辆信息</td></tr>";
							}
							$('#oldcarTable tbody').html(html);
						} 
						
					}
				 });
				 $('#modal-addOldCar').modal('show');

			     
}

/* 保存二手车车辆信息 */
function saveOldCar(){
	 var idList="";
	 var count=0;
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要新增该二手车商品车详细信息?", 
		  callback: function(result){
			  if(result){
				    var index=$("#detail-Id").val()
					var table=$('#oldcarTable tbody');
					var objs=[];
					var htmlItem='',html="";
					for(i=0;i<table.children('tr.selected').length;i++){
						var obj={};
						var tr=table.children('tr.selected').eq(i);
						obj.id=tr.find('td').eq(1).attr('data-id');
						obj.vin=tr.find('td').eq(2).html();
						obj.model=tr.find('td').eq(3).html();
						obj.color=tr.find('td').eq(4).html();
						obj.insertTime=tr.find('td').eq(8).html();
						obj.waybillNo=tr.find('td').eq(5).html();
						obj.carshop='二手车';
						if(tr.find('td').eq(6).html()!='' && tr.find('td').eq(6).html()!=null){
							obj.brand=tr.find('td').eq(7).html();
						}else{
							obj.brand="";
						}
						objs.push(obj);
						htmlItem+='<tr><td data-id='+obj.id+'>'+obj.vin+'</td><td>'+obj.model+'</td>'
						    +'<td>'+obj.color+'</td><td>'+obj.insertTime+'</td>'
						    +'<td>'+obj.waybillNo+'</td><td>'+obj.carshop+'</td>'
						    +'<td>'+obj.brand+'</td>'
						    +'<td><a class="deleteBtn" onclick="deleteOldCar(this)">删除</a></td></tr>';
					}
					html='<table class="oldcarList table table-striped table-bordered table-hover">'
				        +'<thead><tr><th>车架号</th><th>车型</th><th>颜色</th><th>入库时间</th><th>运单编号</th><th>经销单位</th><th>品牌</th><th>操作</th></tr></thead>'
				        +'<tbody>'+htmlItem+'</tbody>';
					$('#newCarDetail'+index+'').html(html);
					if(table.children('tr.selected')!=null){
						count=table.children('tr.selected').length;
					}
					$('#amount'+index+'').val(count);
					$('#modal-addOldCar').modal('hide');
					getAmountAll();
					
			  }
		  }
	 });
}
/* 删除二手车车辆信息 */
function deleteOldCar(e){
	 var count=0;
	 var table=$(e).parents('.oldcarList').find('tbody');
	 var index=$(e).parents('.newCarDetail').attr('data-id');
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该二手车详细信息?", 
		  callback: function(result){
			  if(result){
				  $(e).parents('tr').remove();
				  if(table.children('tr')!=null){
						count=table.children('tr').length;
				}
				$('#amount'+index+'').val(count);
				getAmountAll();
			  }
		  }
	 })
}
/* 取消二手车车辆信息 */
function cancleOldCar(){
	 $('#modal-addOldCar').modal('hide');
}


/* 新增二手车配件信息 */
function bindOldPart(index){
	 var html="",htmlItem="";
	 $("#detail-Id").val(index);
	 var partId="";
	 var size=0,all=0;
	 var arr=[];
	 $('#newPartDetail'+index+' table tbody').find('tr').each(function(){
		 var partItem=$(this).find('td').eq(0).attr('data-id');
		 if(partItem!=null && partItem!=''){
			 partId+=partItem+',';
		 }
		
	 });
		 partId = partId.substring(0, partId.length-1);
		 arr = partId.split(',');
		   var secho='1';   
		   var pageStartIndex='0';
		   var pageSize=1000;
		   var outnum=1;
		   $('#secho').val(secho);
		   var obj = {};
			 $.ajax({
				type : 'POST',
				url : "${ctx}/operationMng/scheduleMng/getSecCarAttachmentList",
				data : JSON.stringify({
					sEcho : $.trim(secho),				
					pageStartIndex : $.trim(pageStartIndex),
					pageSize : $.trim(pageSize)
				}),
				contentType : "application/json;charset=UTF-8",
				dataType : 'JSON',
				success : function(data) {
					if (data && data.code == 200) {						
						obj.iTotalDisplayRecords=data.data.totalCounts;
						obj.iTotalRecords=data.data.totalCounts;
						obj.aaData=data.data.records;		
						obj.sEcho=data.data.frontParams;
						all=obj.aaData.length;
						if(obj.aaData.length>0){
							for(var i=0;i<obj.aaData.length;i++){
								obj.aaData[i]["rownum"]=i+1;
								if(obj.aaData[i]["count"]>0){
									outnum=1;
								}else{
									outnum=0;
								}
								if(arr.length>0){
									for(var j=0;j<arr.length;j++){
										if(obj.aaData[i]["id"]==arr[j]){
											htmlItem='<tr class="selected"><td class="text-center"><input type="checkbox" checked="checked" class="checkchild3"></td>'
											     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
											     +'<td>'+obj.aaData[i]["attachmentName"]+'</td>'
											     +'<td>'+obj.aaData[i]["position"]+'</td>'
											     +'<td>'+obj.aaData[i]["count"]+'</td>'
											     +'<td><input type="text" value="'+outnum+'" onkeyup="blurSumCheck(this)"/></td></tr>';
											     size++;
											     break;
										}else{
											htmlItem='<tr><td class=" text-center"><input type="checkbox" class="checkchild3"></td>'
											     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
											     +'<td>'+obj.aaData[i]["attachmentName"]+'</td>'
											     +'<td>'+obj.aaData[i]["position"]+'</td>'
											     +'<td>'+obj.aaData[i]["count"]+'</td>'
											     +'<td><input type="text" value="'+outnum+'" onkeyup="blurSumCheck(this)"/></td></tr>';
										}
										
									}
									html+=htmlItem;
								}else{
									html+='<tr><td class="text-center"><input type="checkbox"  class="checkchild3"></td>'
									     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
									     +'<td>'+obj.aaData[i]["attachmentName"]+'</td>'
									     +'<td>'+obj.aaData[i]["position"]+'</td>'
									     +'<td>'+obj.aaData[i]["count"]+'</td>'
									     +'<td><input type="text" value="'+outnum+'" onkeyup="blurSumCheck(this)"/></td></tr>';
								}
							}
							if(size==all && size>0){
								 checkChooseOld(true);
							 }else{
								 checkChooseOld(false); 
							 }
						}else{
							html+="<tr><td colspan='6'>暂无二手车配件信息</td></tr>";
						}
						$('#oldpartTable tbody').html(html);
					} 
					
				}
			 });
		 $('#modal-addOldPart').modal('show');
		 
 }
/* 金额验证 */
function revaildate(e,flag){
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
    var money = $(e).val();
    if(money!=null && money!=''){
    	if (!reg.test(money)) {
    		if(flag=='0'){//预付现金
    			$('#prepayCash').val('');
    		}else if(flag=='1'){//预付油费
    			$('#oilAmount').val('');
    		}
    		bootbox.alert('请输入正确的金额！');
       }
    }
}
/* 卡号验证 */
function cardNoConfirmBlur(e,flag){
	var reg = /[^\d]/g;
    var cardNo = $(e).val();
    if(cardNo!=null && cardNo!=''){
    	if (reg.test(cardNo)) {
    		if(flag=='0'){//账号
    			$('#bankAccount').val('');
    		}else if(flag=='1'){//预付油卡卡号
    			$('#oilCardNo').val('');
    		}
    		bootbox.alert('请输入正确的卡号！');
       }
    }

}
/* 保存二手车配件信息 */
function saveOldPart(){
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要新增该二手车配件详细信息?", 
		  callback: function(result){
			  if(result){
				    var index=$("#detail-Id").val()
					var table=$('#oldpartTable tbody');
					var objs=[];
					var htmlItem='',html="";
					for(i=0;i<table.children('tr.selected').length;i++){
						var obj={};
						var tr=table.children('tr.selected').eq(i);
						var outnum=tr.find('td').eq(5);
						obj.id=tr.find('td').eq(1).attr('data-id');
						obj.attachmentName=tr.find('td').eq(2).html();
						obj.position=tr.find('td').eq(3).html();
						obj.count=tr.find('td').eq(4).html();
						if(outnum.find('input').val()==''){
							bootbox.alert('配件出库数量不能为空！');
							outnum.find('input').val('1');
							return;
						}
						obj.outnum=outnum.find('input').val();
						objs.push(obj);
						htmlItem+='<tr><td data-id='+obj.id+'>'+obj.attachmentName+'</td><td>'+obj.position+'</td>'
						    +'<td>'+obj.count+'</td><td>'+obj.outnum+'</td>'
						    +'<td><a class="deleteBtn" onclick="deletePart(this)">删除</a></td></tr>';
					}
					html='<table class="partList table table-striped table-bordered table-hover">'
				        +'<thead><tr><th>配件</th><th>位置</th><th>库存</th><th>出库数</th><th>操作</th></tr></thead>'
				        +'<tbody>'+htmlItem+'</tbody>'
					$('#newPartDetail'+index+'').html(html);
					$('#modal-addOldPart').modal('hide');
					
			  }
		  }
	 });
}
/* 删除二手车配件信息 */

function deleteOldPart(e){
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该二手车配件详细信息?", 
		  callback: function(result){
			  if(result){
				  $(e).parents('tr').remove();
			  }
		  }
	 })
}
/* 取消配件信息 */
function cancleOldPart(){
	 $('#modal-addOldPart').modal('hide');
 } 
 
 /* 保存调度单信息 */
 function dosave(){
     var flag="false";
	 var objs=[];
	 var objList={};
	 var sendTime=$('#sendTime').val();
	 var receiveTime=$('#receiveTime').val();
	 var carNumber=$('#carNumber').find('option:selected').attr('data-no');
	 var driver=$.trim($('#driver_id').val());
	 var amount=$('#all-amount').val();
	 var mark=$('#mark').val();
	 var scheduleBillNo="";
	 var mobile=$('#mobile').val();
	 var prepayCash=$('#prepayCash').val();
	 var bankName=$('#bankName').val();
	 var bankAccount=$('#bankAccount').val();
	 var oilCardNo=$('#oilCardNo').val();
	 var oilAmount=$('#oilAmount').val();
	 if(sendTime=='' || sendTime==null){
		 bootbox.alert('请选择出发时间！');
		 return;
	 }
	 if(receiveTime=='' || receiveTime==null){
		 bootbox.alert('请选择到达时间！');
		 return;
	 }
	 if($('#carNumber').val()=='-1' || $('#carNumber').val()==null){
		 bootbox.alert('请选择装运车号！');
		 return;
	 }
	 if(amount=='' || amount==null){
		 bootbox.alert('请输入台数！');
		 return;
	 }
	 if(driver=='' || driver==null){
		 bootbox.alert('驾驶员为空！');
		 return;
	 }
	 var detailList=$('.detailList').length;
	 for(var i=0;i<detailList;i++){
		 var objItem={};
		 if($('#amount'+i+'').val()==null || $('#amount'+i+'').val()==''){
			 bootbox.alert('请输入第'+(i+1)+'条信息台数！');
			 return;
		 }else{
			 objItem.amount=$('#amount'+i+'').val();
		 }
		 /* if($('#detailMark'+i+'').val()==null || $('#detailMark'+i+'').val()==''){
			 bootbox.alert('请输入第'+(i+1)+'条信息指令！');
			 return;
		 }else{
			 objItem.mark=$('#detailMark'+i+'').val();
		 } */
		 objItem.mark=$('#detailMark'+i+'').val();
		 if($('#carShop'+i+'').val()!=undefined && $('#carShop'+i+'').val()!='-1' && $('#carShop'+i+'').val()!=null){
			 
			 if($('#carShop'+i+'').val()==null || $('#carShop'+i+'').val()=='' || $('#carShop'+i+'').val()=='-1'){
				 bootbox.alert('请选择第'+(i+1)+'条经销单位！');
				 return;
			 }else{
				 objItem.carShopId=$('#carShop'+i+'').val();
			 }
			 
		 }else{
			 objItem.carShopId='';
		 }
		 if($('#startProvince'+i+'').val()==null || $('#startProvince'+i+'').val()=='' || $('#startProvince'+i+'').val()== '---请选择省份---'){
			 bootbox.alert('请输入第'+(i+1)+'条信息始发省！');
			 return;
		 }else{
			 objItem.startProvince=$('#startProvince'+i+'').val();
		 }
		 if($('#startAddress'+i+'').val()==null || $('#startAddress'+i+'').val()=='' || $('#startAddress'+i+'').val()=='---请选择市县---'){
			 bootbox.alert('请输入第'+(i+1)+'条信息始发地！');
			 return;
		 }else{
			 objItem.startAddress=$('#startAddress'+i+'').val();
		 }
		 if($('#endProvince'+i+'').val()==null || $('#endProvince'+i+'').val()=='' || $('#endProvince'+i+'').val()=='---请选择省份---'){
			 bootbox.alert('请输入第'+(i+1)+'条信息目的省！');
			 return;
		 }else{
			 objItem.targetProvince=$('#endProvince'+i+'').val();
		 }
		 if($('#endAddress'+i+'').val()==null || $('#endAddress'+i+'').val()=='' || $('#endAddress'+i+'').val()=='---请选择市县---'){
			 bootbox.alert('请输入第'+(i+1)+'条信息目的地！');
			 return;
		 }else{
			 objItem.targetCity=$('#endAddress'+i+'').val();
		 }
		 var carStockIds="";
		 var attachmentIds="";
		 var attachmentCounts="";
		 var carList=$('#newCarDetail'+i+' tbody').children('tr');
		 var partList=$('#newPartDetail'+i+' tbody').children('tr');
		 /* 商品车集合 */
		 if(carList.length>0){
			 for(var j=0;j<carList.length;j++){
				 var carTr=carList.eq(j);
				 carStockIds+=carTr.find('td').eq(0).attr('data-id')+',';
			 } 
		 }else{
			 carStockIds='';
		 }
		 /* 配件集合 */
		 if(partList.length>0){
			 for(var k=0;k<partList.length;k++){
				 var partTr=partList.eq(k);
				 attachmentIds+=partTr.find('td').eq(0).attr('data-id')+',';
				 attachmentCounts+=partTr.find('td').eq(3).html()+',';
			 } 
		 }else{
			 attachmentIds='';
		 }
		 objItem.carStockIds=carStockIds.substring(0, carStockIds.length-1);
		 objItem.attachmentIds=attachmentIds.substring(0, attachmentIds.length-1);
		 objItem.attachmentCounts=attachmentCounts.substring(0, attachmentCounts.length-1);
		 objs.push(objItem);
	 }
	   objList.detailList=objs;
	   objList.sendTime=sendTime;
	   objList.receiveTime=receiveTime;
	   objList.carNumber=carNumber;
	   objList.amount=amount;
	   objList.mark=mark;
	   objList.driverId=driver;
	   objList.mobile=mobile;
	   objList.prepayCash=prepayCash;
	   objList.bankName=bankName;
	   objList.bankAccount=bankAccount;
	   objList.oilCardNo=oilCardNo;
	   objList.oilAmount=oilAmount;
	   console.info(JSON.stringify(objList));
	   bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该调度单信息?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : '${ctx}/operationMng/scheduleMng/save',
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
												  location.href="${ctx}/operationMng/scheduleMng/index";
											  }else{
												  location.href="${ctx}/operationMng/scheduleMng/index";
											  }
										  }
									 });
									setTimeout(function(){
										if(flag=="false"){
											 location.href="${ctx}/operationMng/scheduleMng/index";
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
			});
 }
 

 /* 返回调度单信息 */

 function doback(){
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要离开？", 
		  callback: function(result){
			  if(result){
				  location.href="${ctx}/operationMng/scheduleMng/index";
			  }
			 
		  }
	 })
 }
 
 /* 删除多余新增的信息 */
function removeDetail(e,index){
	var info='';
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除？", 
		  callback: function(result){
			  if(result){
				  $(e).parents('#detailList'+index+'').remove();
				  $('.carShopId').each(function(){
						if($(this)!=null && $(this).val()!='' && $(this).val()!='-1'){
							info+=$(this).val()+',';
						}
						$('#shopList').val(info);
					});
				  getAmountAll();
			  }
			 
		  }
	 });
	 
 }
 
 /* 统计总台数 */
 function getAmountAll(){
	 var sumAmount=0;
	 var index=$('.initAmount').length;
	 for(var i=0;i<index;i++){
		 sumAmount+=parseInt($('.initAmount').eq(i).val());
	 }
	 $('#all-amount').val(sumAmount);
 }
 
 </script>

</body>
</html>






