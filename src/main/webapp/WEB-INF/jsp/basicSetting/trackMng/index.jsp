
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
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
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
</style>
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			基础信息管理
			<small>
				<i class="icon-double-angle-right"></i>
				运输车辆管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">			
			<label class="title" style="float: left;height: 34px;line-height: 34px;">上次年审时间：</label>
			<div class="input-group input-group-sm" style="float: left;width: 170px;margin-right:15px; height: 34px;line-height: 34px;">
				<input class="form-control" id="fom_annualStartTime" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width:80px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 170px;margin-right:20px;height: 34px;line-height: 34px;">
				<input class="form-control" id="fom_annualEndTime" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>	
			<label class="title" style="width:80px;">驾&nbsp;驶&nbsp;&nbsp;员：</label>
			  <input class="form-box" id="fom_driver" type="text" style="width: 170px;" placeholder="请输入驾驶员（模糊查询）"/> 
		    <!-- <select id="fom_driverId" class="form-box" style="width: 150px;">		      
			</select>		 --> 	  		   
		</div>		
		<div class="searchbox col-xs-12">			
			<label class="title"  style="float: left;height: 34px;line-height: 34px;width:105px;">承&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;运&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;商：</label>
		    <select id="fom_outSourcing" class="form-box" style="width: 170px;float: left;">		      
			</select>
			<label class="title" style="float: left;height: 34px;line-height: 34px;width:80px;">所有人：</label>
		     <input class="form-box" id="fom_ower" type="text" style="width: 170px;" placeholder="请输入所有人"/> 
		     <label class="title" style="width:80px;">发动机号：</label>
		     <input class="form-box" id="fom_engineNo" type="text" style="width: 170px;" placeholder="请输入发动机号"/> 			
			</div>	
			<div class="searchbox col-xs-12">
			
			<label class="title"  style="float: left;height: 34px;line-height: 34px;width:105px;">车辆识别代号：</label>
			 <input class="form-box" id="fom_vin" type="text" style="width: 170px;float: left;" placeholder="请输入车辆识别代号"/> 
			<label class="title" style="float: left;height: 34px;line-height: 34px;width:80px;">车头牌号：</label>
		     <input class="form-box" id="fom_no" type="text" style="width: 170px;" placeholder="请输入车头牌号"/> 
		     <label class="title" style="width:80px;">车厢号码：</label>
		     <input class="form-box" id="fom_xno" type="text" style="width: 170px;" placeholder="请输入车厢号码"/> 
			<a class="itemBtn" onclick="searchInfo()" style="width: 60px;">查询</a>
			<a class="itemBtn" onclick="doadd()" style="width: 60px; ">新增</a>
			
			</div>	
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover" style="width:1600px;">
			<thead>
				<tr>														
					<th>序号</th>
					<th>承运商名称</th>
                    <th>车头牌号</th>
                    <th>车厢牌号</th>
                    <th>主驾驶员</th>
                    <th>副驾驶员</th>
                    <th>所有人</th>
                    <th>所有人地址</th>
                    <th>车辆识别代号</th> 
                    <th>发动机号</th> 
                    <th>注册时间</th>
                    <th>外部尺寸</th>
                    <!-- <th>保险公司</th> -->
                    <th>上次年审日期</th>
                    <th>核定油耗</th>                     
                   <!--  <th>油的折扣上限</th>  
                    <th>油的折扣点</th>    -->                      
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">新增/编辑运输车辆信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>承运商：</label>
							     <div class="col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
							     <select id="outSourcingId" class="form-control">		      
			                     </select>								     
							     <input class="form-control" id="id-hidden" type="hidden"/>
							     </div>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>车头牌号：</label>
							     <div class="col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
							    <input class="form-control" id="no" type="text" placeholder="请输入车头牌号"/>
							    </div>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>车厢牌号：</label>
							     <div class="col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
			                     <input class="form-control" id="xno" type="text" placeholder="请输入车厢牌号"/>
			                     </div>						     
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>主驾驶员：</label>
							     <div class="col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
							      <select id="driver" class="form-control">	      
			                     </select>
							    <!-- <input class="form-control" id="driver" type="text" placeholder="请输入驾驶员"/> -->
							    </div>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4">副驾驶员：</label>
							     <div class="col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
							      <select id="codriver" class="form-control">	      
			                     </select>
							    <!-- <input class="form-control" id="driver" type="text" placeholder="请输入驾驶员"/> -->
							    </div>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>所有人：</label>
							     <div class="col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
							    <input class="form-control" id="ower" type="text" placeholder="请输入所有人"/>
							    </div>
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4">所有人地址：</label>
							     <div class="col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
							    <input class="form-control" id="owerAddress" type="text" placeholder="请输入所有人地址"/>
							    </div>
							 </div>
							<hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>车辆识别代号：</label>
							     <div class="col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
							    <input class="form-control" id="vin" type="text" placeholder="请输入车辆识别代号"/>
							    </div>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>发动机号：</label>
							     <div class="col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
							    <input class="form-control" id="engineNo" type="text" placeholder="请输入发动机号"/>
							    </div>
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4">注册时间：</label>
							     <div class="input-group input-group-sm col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
									<input class="form-control" id="registerTime" type="text" placeholder="请输入联系人生日"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>							   					    
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4">外部尺寸：</label>
							     <div class="col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
							    <input class="form-control" id="size" type="text" placeholder="请输入外部尺寸"/>
							    </div>
							 </div>	
							  <!--  <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">保险开始时间：</label>
							     <div class="input-group input-group-sm col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
									<input class="form-control" id="insuranceStartTime" type="text" placeholder="请输入保险开始时间"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>
							    </div> -->	
							    <!--  <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">保险到期时间：</label>
							     <div class="input-group input-group-sm col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
									<input class="form-control" id="insuranceEndTime" type="text" placeholder="请输入保险到期时间"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>
							    </div>			 -->	
							  <!-- <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">保险公司：</label>
							     <div class="col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
							     <input class="form-control" id="insuranceCompany" type="text" placeholder="请输入保险公司"/>
							     </div>
							    </div>	 -->	
							     <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">上次年审日期：</label>
							     <div class="input-group input-group-sm col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
									<input class="form-control" id="annualReviewTime" type="text" placeholder="请输入上次年审日期"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>
							    </div>										     
							     <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">核定油耗：</label>
							     <div class="col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
							      <input class="form-control" id="standardOilWear" type="text" placeholder="请输入核定油耗"/>
							      </div>
							  </div>
							   <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">油的折现上限（元）：</label>
							     <div class="col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
							     <input class="form-control" id="oilDiscountLimit" type="text" placeholder="请输入油的折现上限"/>
							     </div>
							  </div>
							    <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4">油的折现扣点（%）：</label>
							     <div class="col-xs-8" style="margin-top: -1px;margin-bottom: 10px;">
							     <input class="form-control" id="oilDiscountPoint" type="text" placeholder="请输入油的折现扣点"/>
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
			<!-- 查看地址iframe modal begin-->
		   <div class="modal fade" id="modal-show" tabindex="-1" role="dialog" data-backdrop="static">
		     <div class="modal-dialog">
				  <div class="modal-content">
						<div class="modal-header" style="padding: 0 15px;">
							<button class="close" type="button" data-dismiss="modal">×</button>
							<h3>查看信息</h3>
						</div>
						<div class="modal-body">
						   <div>
							  <div class="widget-box dia-widget-box">
									<div class="widget-body">
										<div class="widget-main">
											<iframe src="" frameborder="0" style="width:100%;height:500px;border:0;overflow:hidden;"></iframe>
										</div>
								   </div>
							 </div>
						  </div>
						</div>
			       </div>
			    </div>
			   </div>
			<!-- 查看地址iframe modal end-->
			
				<div class="modal fade" id="modal-upload" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" onclick="uploadrefresh()">×</button>
					<h3 id="myModalLabel">上传信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
														  
							 <div class="add-item col-xs-12" style="margin-bottom: 10px;margin-top: 20px;">
							    <label class="title col-xs-2" style="width: 120px;">车头行驶证 ：</label>	
							    <div class="col-xs-10" style="width: 200px;"> <input type="file" id="inputfileDriving" /> <label class="title" id="filenameDriving"></label>
							    <input type="hidden" name="filenameDriving_hidden" id="filenameDriving_hidden"/>
							    <input type="hidden" name="filepathDriving_hidden" id="filepathDriving_hidden"/>
							    <input class="form-control" id="detilid-hidden" type="hidden"/>
							    </div>							    
							   </div>	
							    <hr class="tree" style="margin-top: 120px;"></hr>
							    <div class="add-item col-xs-12" style="margin-bottom: 10px;margin-top: 20px;">
							    <label class="title col-xs-2" style="width: 120px;">车头营运证 ：</label>	
							    <div class="col-xs-10" style="width: 200px;"> <input type="file" id="inputfileToperating" /> <label class="title" id="filenameToperating"></label>
							    <input type="hidden" name="filenameToperating_hidden" id="filenameToperating_hidden"/>
							    <input type="hidden" name="filepathToperating_hidden" id="filepathToperating_hidden"/>
							    </div>							    
							   </div>	
							    <hr class="tree" style="margin-top: 120px;"></hr>
							    <div class="add-item col-xs-12" style="margin-bottom: 10px;margin-top: 20px;">
							    <label class="title col-xs-2" style="width: 120px;">车厢营运证 ：</label>	
							    <div class="col-xs-10" style="width: 200px;"> <input type="file" id="inputfileXoperating" /> <label class="title" id="filenameXoperating"></label>
							    <input type="hidden" name="filenameXoperating_hidden" id="filenameXoperating_hidden"/>
							    <input type="hidden" name="filepathXoperating_hidden" id="filepathXoperating_hidden"/>
							    </div>							    
							   </div>	
							    <hr class="tree" style="margin-top: 120px;"></hr>
							    
							    <div class="add-item-btn" id="uploadBtn">
								    <a class="add-itemBtn btnOk" onclick="uploadsave();" style="margin-left: 130px;">保存</a>
								    <a class="add-itemBtn btnOk" onclick="uploadrefresh();">关闭</a>
								 </div>
								
								</div>
						  </div>
					</div>
				</div>
				</div>
			</div>
			<!-- 查看保险时间 -->
			<div class="modal fade" id="modal-edit" tabindex="-1" role="dialog" aria-hidden="false" data-backdrop="static">
			   <div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
					<div class="modal-header" style="padding:3px 10px;">
						<button class="close" type="button" data-dismiss="modal" onclick="resInsurance(this)">×</button>
						<h3 id="myModalLabel">查看保险时间</h3>
					</div>
					<div class="modal-body">
					   <div>
						  <div class="widget-box dia-widget-box">
								<div class="widget-body">
									<div class="widget-main">	
									 	<table id="insuranceDetail" class="table table-striped table-bordered table-hover">
					                      <thead>
						                   <tr>	
								               <th>序号</th>
								               <th>类型</th>
			                                   <th>保单号</th>
			                                   <th>开始时间</th>
			                                   <th>结束时间</th>
						                   </tr>
					                      </thead>
					                      <tbody>
					                      </tbody>
					                      </table>							   			  
									    							 
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
<script src="${ctx}/staticPublic/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
function init(){   
	$("#fom_insuranceStartTime").datepicker({
		 language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#fom_insuranceEndTime").datepicker({
		 language: 'cn',
       autoclose: true,//选中之后自动隐藏日期选择框
       format: "yyyy-mm-dd"//日期格式
	});
	$("#fom_annualStartTime").datepicker({
		 language: 'cn',
       autoclose: true,//选中之后自动隐藏日期选择框
       format: "yyyy-mm-dd"//日期格式
	});
	$("#fom_annualEndTime").datepicker({
		 language: 'cn',
       autoclose: true,//选中之后自动隐藏日期选择框
       format: "yyyy-mm-dd"//日期格式
	});
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/basicSetting/trackMng/getListData" , //获取数据的ajax方法的URL							 
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
				columns: [{ data: "rownum" ,"width":"5%"},
						    {data: "outSourcingName","width":"8%"},
						    {data: "no","width":"6%"},
						    {data: "xno","width":"6%"},
						    {data: "driverName","width":"6%"},
						    {data: "codriverName","width":"6%"},
						    {data: "ower","width":"6%"},
						    {data: "owerAddress","width":"7%"},
						    {data: "vin","width":"6%"},	
						    {data: "engineNo","width":"6%"},	
						    {data: "registerTime","width":"8%"},	
						    {data: "size","width":"6%"},		
						  /*   {data: "insuranceCompany","width":"5%"},	 */
						    {data: "annualReviewTime","width":"8%"},	
						    {data: "standardOilWear","width":"6%"},	
						   /*  {data: "oilDiscountLimit"},	
						    {data: "oilDiscountPoint"},	 */
						    {data: null,"width":"16%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 10,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonForDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 12,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonForDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},
				{
			    	 //操作栏
			    	 targets: 14,
			    	 render: function (data, type, row, meta) {			    		
			    			   return '<a class="table-edit" onclick="doedit('+ row.id +')" style="margin-top:1px;">编辑</a>'
			    			   +'<a class="table-edit" onclick="doupload(\''+ row.id +'\',\''+ row.drivingFilePath +'\',\''+ row.toperatingFilePath +'\',\''+ row.xoperatingFilePath +'\')">上传</a>'
			    			   +'<a class="table-delete" style="margin-right:5px;" onclick="dodelete('+ row.id +')">删除</a>'
					          /*  +'<a class="table-edit" style="width:65px;" data-no="'+row.no+'" onclick="showInsurance('+ row.id+',this)">查看保险</a>' */;
			    			  
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
		 "sAjaxSource": "${ctx}/basicSetting/trackMng/getListData", //获取数据的ajax方法的URL	
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
				columns: [{ data: "rownum" ,"width":"5%"},
						    {data: "outSourcingName","width":"8%"},
						    {data: "no","width":"6%"},
						    {data: "xno","width":"6%"},
						    {data: "driverName","width":"6%"},
						    {data: "codriverName","width":"6%"},
						    {data: "ower","width":"6%"},
						    {data: "owerAddress","width":"7%"},
						    {data: "vin","width":"6%"},	
						    {data: "engineNo","width":"6%"},	
						    {data: "registerTime","width":"8%"},	
						    {data: "size","width":"6%"},		
						  /*   {data: "insuranceCompany","width":"5%"},	 */
						    {data: "annualReviewTime","width":"8%"},	
						    {data: "standardOilWear","width":"6%"},	
						   /*  {data: "oilDiscountLimit"},	
						    {data: "oilDiscountPoint"},	 */
						    {data: null,"width":"16%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 10,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonForDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 12,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonForDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},
		      	{
			    	 //操作栏
			    	 targets: 14,
			    	 render: function (data, type, row, meta) {			    		
			    			   return '<a class="table-edit" onclick="doedit('+ row.id +')" style="margin-top:1px;">编辑</a>'
			    			   +'<a class="table-edit" onclick="doupload(\''+ row.id +'\',\''+ row.drivingFilePath +'\',\''+ row.toperatingFilePath +'\',\''+ row.xoperatingFilePath +'\')">上传</a>'
			    			   +'<a class="table-delete" style="margin-right:5px;" onclick="dodelete('+ row.id +')">删除</a>'
					          /*  +'<a class="table-edit" style="width:65px;" data-no="'+row.no+'" onclick="showInsurance('+ row.id+',this)">查看保险</a>' */;
			    			  
		                }	       
		    	} 
		      ],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	getOutSourcing();//获取承运商
	binddirver();//绑定驾驶员
	//getCarShop();
	 /* checkeURL(); */
});
/* 判断是否为合法的域名方式 */
function checkeURL(){ 
        var str=window.location.hostname; 
        var reSpaceCheck = /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/;  
        if(str=="localhost"){ 
            str = str.replace("localhost","127.0.0.1"); 
        } 
        if (reSpaceCheck.test(str))  
        {  
        	 $('#showPrtol').hide();
        	 $('#showListen').hide();
        	 return false;
        }else{  
        	 $('#showPrtol').show();
        	 $('#showListen').show();
        	return true;
        } 

    }
 
/* 承运商绑定 */
function getOutSourcing(){
	$.ajax({  
        url: '${ctx}/basicSetting/trackMng/getOutSourcingList',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        data: '',
        success: function (data) {
        	var html ='<option value="">请选择承运商</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		/* console.log(JSON.stringify(data.data)); */
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                		}
            		}
            	}
            	$('#fom_outSourcing').html(html);
            	$('#outSourcingId').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}
/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var annualStartTime=$("#fom_annualStartTime").val(); 
	   var annualEndTime=$("#fom_annualEndTime").val();
	   var outSourcing=$("#fom_outSourcing").find("option:selected").val();
	   var ower=$("#fom_ower").val();
	   var driverId=$("#fom_driver").val();
	   var engineNo=$("#fom_engineNo").val();
	   var vin=$("#fom_vin").val();
	   var no=$("#fom_no").val();
	   var xno=$("#fom_xno").val();
	  // console.log(JSON.stringify(insuranceStartTime));
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				annualStartTime:$.trim(annualStartTime),
				annualEndTime:$.trim(annualEndTime),
				outSourcingId:$.trim(outSourcing),
				ower:$.trim(ower),
				no:$.trim(no),
				xno:$.trim(xno),
				driverName:$.trim(driverId),
				vin:$.trim(vin),
				engineNo:$.trim(engineNo)							
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
	var insuranceStartTime=$("#fom_insuranceStartTime").val(); 
	   var insuranceEndTime=$("#fom_insuranceEndTime").val(); 
	   var annualStartTime=$("#fom_annualStartTime").val(); 
	   var annualEndTime=$("#fom_annualEndTime").val(); 
	if(insuranceStartTime!=''&&insuranceEndTime!=''&&insuranceEndTime<insuranceStartTime){
		bootbox.alert('保险开始时间不得大于保险到期时间！');
		return;
	}
	if(annualStartTime!=''&&annualEndTime!=''&&annualStartTime<annualEndTime){
		bootbox.alert('上次年审开始时间不得大于结束时间！');
		return;
	}
	reload();
}
/* 查看保险 */
function showInsurance(data,e){
	var carNumber=$(e).attr('data-no');
	var html="";
	 $.ajax({
			type : 'POST',
			url : "${ctx}/basicSetting/trackMng/getInsuranceList",
			data :{
				carNumber :carNumber
			},
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					if(data.data.length>0 && data.data!=null){
						for(var i=0;i<data.data.length;i++){
							var insuranceBillNo=data.data[i]['insuranceBillNo'];
							if(insuranceBillNo==null){
								insuranceBillNo='';
							}
							var insuranceType='';
							if(data.data[i]['insuranceType']==null){
								insuranceType='';
							}else if(data.data[i]['insuranceType']=='0'){
								insuranceType='交强险';
							}else if(data.data[i]['insuranceType']=='1'){
								insuranceType='商业险';
							}else if(data.data[i]['insuranceType']=='2'){
								insuranceType='货运险';
							}else{
								insuranceType=data.data[i]['insuranceType'];
							}
							var startTime='';
							if(data.data[i]['startTime']!=null && data.data[i]['startTime']!=''){
								startTime=jsonForDateFormat(data.data[i]['startTime']);
							}
							var endTime='';
							if(data.data[i]['endTime']!=null && data.data[i]['endTime']!=''){
								endTime=jsonForDateFormat(data.data[i]['endTime']);
							}
							html+='<tr>'
								+'<td>'+(i+1)+'</td>'
							    +'<td>'+insuranceType+'</td>'
							    +'<td>'+insuranceBillNo+'</td>'
							    +'<td>'+startTime+'</td>'
							    +'<td>'+endTime+'</td>'
							    +'</tr>';
						}
					}else{
						html='<tr><td colspan="5">暂无保险时间</td></tr>';
					}
					$('#insuranceDetail tbody').html(html);
					$('#modal-edit').modal('show');
				}else{
					bootbox.alert('获取失败！');
				}
			}
	 });
}
/* 查看保险关闭 */
function resInsurance(e){
	$('#modal-edit').modal('hide');
}
/* 删除运输车辆信息*/
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除运输车辆信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/basicSetting/trackMng/delete/"+id,
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
											  flag="true"
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
	$('#addBtn').show();
	$('#editBtn').hide();
	$('#myModalLabel').html('新增运输车辆信息');	
	$('#modal-info').modal('show');
	$("#registerTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#insuranceStartTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#insuranceEndTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#annualReviewTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	//binddirver();
}
function binddirver(){
	$.ajax({  
        url: '${ctx}/basicSetting/trackMng/geDriverData',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        success: function (data) {
        	var html ='<option value="">请选择驾驶员</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		/* console.log(JSON.stringify(data.data)); */
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                		}
            		}
            	}
            	$('#driver').html(html);
            	$('#codriver').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}
function binddirvers(driver){
	$.ajax({  
        url: '${ctx}/basicSetting/trackMng/geDriverData',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        success: function (data) {
        	var html ='<option value="">请选择驾驶员</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		/* console.log(JSON.stringify(data.data)); */
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
            				if(data.data[i]['id']==driver){
            					html +='<option value='+data.data[i]['id']+' selected="selected">'+data.data[i]['name']+'</option>';
            				}else{
            					html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
            				}
                			
                		}
            		}
            	}
            	$('#driver').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
      }); 
}

function binddirverst(driver){
	$.ajax({  
        url: '${ctx}/basicSetting/trackMng/geDriverData',  
        type: "post",  
        contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
        success: function (data) {
        	var html ='<option value="">请选择驾驶员</option>';
            if(data.code == 200){  
            	if(data.data!=null && data.data!=''){
            		/* console.log(JSON.stringify(data.data)); */
            		if(data.data.length>0){
            			for(var i=0;i<data.data.length;i++){
            				if(data.data[i]['id']==driver){
            					html +='<option value='+data.data[i]['id']+' selected="selected">'+data.data[i]['name']+'</option>';
            				}else{
            					html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
            				}
                			
                		}
            		}
            	}
            	$('#codriver').html(html);
               }else{  
            	   bootbox.alert('加载失败！');
               }  
        }  
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
	$('#outSourcingId').val('');
	//$('#type').val('0');
	$('#no').val('');
	$('#xno').val('');	
	$('#driver').val('');
	$('#codriver').val('');
	$('#ower').val('');	
	$('#owerAddress').val('');
	$('#vin').val('');
	$('#engineNo').val('');
	$('#registerTime').val('');
	$('#size').val('');
	$('#insuranceStartTime').val('');
	$('#insuranceEndTime').val('');
	$('#insuranceCompany').val('');
	$('#annualReviewTime').val('');
	$('#standardOilWear').val('');
	$('#oilDiscountLimit').val('');
	$('#oilDiscountPoint').val('');
}
/* 保存新增承运商信息 */
function save(){
	var flag="false";
	var outSourcingId=$("#outSourcingId").find("option:selected").val(); 
	//var type=$("#type").find("option:selected").val(); 
	var no=$("#no").val();
	var xno=$("#xno").val();
	var driver=$("#driver").val();
	var codriver=$("#codriver").val();
	var ower=$("#ower").val(); 
	var owerAddress=$("#owerAddress").val();
	var vin=$("#vin").val(); 
	var engineNo=$("#engineNo").val(); 
	var registerTime=$("#registerTime").val(); 
	var size=$("#size").val(); 
	/* var insuranceStartTime=$("#insuranceStartTime").val(); 
	var insuranceEndTime=$("#insuranceEndTime").val(); 
	var insuranceCompany=$("#insuranceCompany").val(); */
	var annualReviewTime=$("#annualReviewTime").val();
	var standardOilWear=$("#standardOilWear").val();
	var oilDiscountLimit=$("#oilDiscountLimit").val();
	var oilDiscountPoint=$("#oilDiscountPoint").val();
	if(outSourcingId==''){
		bootbox.alert('承运商不能为空！');
		return;
	}
	if(no==''){
		bootbox.alert('车头牌号不能为空！');
		return;
	}
	if(xno==''){
		bootbox.alert('车厢牌号不能为空！');
		return;
	}
	if(driver==''){
		bootbox.alert('主驾驶员不能为空！');
		return;
	}	
	if(ower==''){
		bootbox.alert('所有人不能为空！');
		return;
	}
	if(vin==''){
		bootbox.alert('车辆识别代号不能为空！');
		return;
	}
	if(engineNo==''){
		bootbox.alert('发动机号不能为空！');
		return;
	}if(standardOilWear!=''&&isNaN(standardOilWear)){
		bootbox.alert('核定油耗请填写数字！');
		return;
	}if(oilDiscountLimit!=''&&isNaN(oilDiscountLimit)){
		bootbox.alert('油的折现上限请填写数字！');
		return;
	}if(oilDiscountPoint!=''&&isNaN(oilDiscountPoint)){
		bootbox.alert('油的折现扣点请填写数字！');
		return;
	}
	
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增运输车辆信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/trackMng/save',
						data : JSON.stringify({
							outSourcingId : outSourcingId,				
							no : no,
							xno : xno,
							driverId : driver,
							codriverId : codriver,
							ower : ower,
							owerAddress : owerAddress,
							vin : vin,
							engineNo : engineNo,
							registerTime : registerTime,
							size : size,
							/* insuranceStartTime : insuranceStartTime,
							insuranceEndTime : insuranceEndTime,
							insuranceCompany : insuranceCompany, */
							annualReviewTime : annualReviewTime,
							standardOilWear : standardOilWear,
							oilDiscountLimit : oilDiscountLimit,
							oilDiscountPoint : oilDiscountPoint
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
	
	$("#registerTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#insuranceStartTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#insuranceEndTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#annualReviewTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/trackMng/getDetailData/"+id,
		data :JSON.stringify({
			id :id
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑运输车辆信息');
				$("#outSourcingId").val(data.data.outSourcingId); 
				//$("#type").val(data.data.type); 
				$("#no").val(data.data.no); 
				$("#xno").val(data.data.xno); 
				binddirvers(data.data.driverId);
				binddirverst(data.data.codriverId);
				//$('#driver').find("option[value='"+data.data.driver+"']").attr("selected",true);
				$("#ower").val(data.data.ower); 
				$("#owerAddress").val(data.data.owerAddress);
				$("#vin").val(data.data.vin); 
				$("#engineNo").val(data.data.engineNo); 
				$("#size").val(data.data.size); 
				if(data.data.registerTime!=''&&data.data.registerTime!=null){
					$("#registerTime").val(jsonForDateFormat(data.data.registerTime)); 
				}else{
					$("#registerTime").val(''); 
				}
				/* if(data.data.insuranceStartTime!=''){
					$("#insuranceStartTime").val(jsonForDateFormat(data.data.insuranceStartTime)); 
				}
				if(data.data.insuranceEndTime!=''){
					$("#insuranceEndTime").val(jsonForDateFormat(data.data.insuranceEndTime)); 
				} */
				if(data.data.annualReviewTime!=''&&data.data.annualReviewTime!=null){
					$("#annualReviewTime").val(jsonForDateFormat(data.data.annualReviewTime)); 
				}else{
					$("#annualReviewTime").val(''); 
				}	
				/* $("#insuranceCompany").val(data.data.insuranceCompany); */
				$("#standardOilWear").val(data.data.standardOilWear);
				$("#oilDiscountLimit").val(data.data.oilDiscountLimit);
				$("#oilDiscountPoint").val(data.data.oilDiscountPoint);				
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
	var outSourcingId=$("#outSourcingId").find("option:selected").val(); 
	//var type=$("#type").find("option:selected").val(); 
	var no=$("#no").val(); 
	var xno=$("#xno").val();
	var driver=$("#driver").val(); 
	var codriver=$("#codriver").val(); 
	var ower=$("#ower").val(); 
	var owerAddress=$("#owerAddress").val();
	var vin=$("#vin").val(); 
	var engineNo=$("#engineNo").val(); 
	var registerTime=$("#registerTime").val(); 
	var size=$("#size").val(); 
	/* var insuranceStartTime=$("#insuranceStartTime").val(); 
	var insuranceEndTime=$("#insuranceEndTime").val(); 
	var insuranceCompany=$("#insuranceCompany").val(); */
	var annualReviewTime=$("#annualReviewTime").val();
	var standardOilWear=$("#standardOilWear").val();
	var oilDiscountLimit=$("#oilDiscountLimit").val();
	var oilDiscountPoint=$("#oilDiscountPoint").val();
	if(outSourcingId==''){
		bootbox.alert('承运商不能为空！');
		return;
	}
	if(no==''){
		bootbox.alert('车头牌号不能为空！');
		return;
	}
	if(xno==''){
		bootbox.alert('车厢牌号不能为空！');
		return;
	}
	if(driver==''){
		bootbox.alert('主驾驶员不能为空！');
		return;
	}	
	if(ower==''){
		bootbox.alert('所有人不能为空！');
		return;
	}
	if(vin==''){
		bootbox.alert('车辆识别代号不能为空！');
		return;
	}
	if(engineNo==''){
		bootbox.alert('发动机号不能为空！');
		return;
	}if(standardOilWear!=''&&isNaN(standardOilWear)){
		bootbox.alert('核定油耗请填写数字！');
		return;
	}if(oilDiscountLimit!=''&&isNaN(oilDiscountLimit)){
		bootbox.alert('油的折现上限请填写数字！');
		return;
	}if(oilDiscountPoint!=''&&isNaN(oilDiscountPoint)){
		bootbox.alert('油的折现扣点请填写数字！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该运输车辆信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/trackMng/update',
						data : JSON.stringify({
							id : id,
							outSourcingId : outSourcingId,				
							no : no,
							xno : xno,
							driverId : driver,
							codriverId : codriver,
							ower : ower,
							owerAddress : owerAddress,
							vin : vin,
							engineNo : engineNo,
							registerTime : registerTime,
							size : size,
							/* insuranceStartTime : insuranceStartTime,
							insuranceEndTime : insuranceEndTime,
							insuranceCompany : insuranceCompany, */
							annualReviewTime : annualReviewTime,
							standardOilWear : standardOilWear,
							oilDiscountLimit : oilDiscountLimit,
							oilDiscountPoint : oilDiscountPoint
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
											 flag="true"
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

/* 新增查看地址  add by matingting on 2016/11/07*/
function doshow(id){
	$('#modal-show').modal('show');
}

function doupload(id,filePath,filePathToperating,filePathXoperating){
	clearupload();
	$('#uploadBtn').show();
	$('#detilid-hidden').val(id);
	$('#filepathDriving_hidden').val(filePath);
	var filePaths="${ctx}"+filePath;
	var htmls='<a  href='+filePaths+' target="_blank">照片</a>';
	if(filePath!=''&&filePath!='null'&&filePath!='undefined'){
		$('#filenameDriving').html(htmls);
	}
	
	var filePathToperatings = "${ctx}"+filePathToperating;
	var htmlst='<a  href='+filePathToperatings+' target="_blank">照片</a>';
	if(filePathToperating!=''&&filePathToperating!='null'&&filePathToperating!='undefined'){
		$('#filenameToperating').html(htmlst);
	}
	
	var filePathXoperatings = "${ctx}"+filePathXoperating;
	var htmlsx='<a  href='+filePathXoperatings+' target="_blank">照片</a>';
	if(filePathXoperating!=''&&filePathXoperating!='null'&&filePathXoperating!='undefined'){
		$('#filenameXoperating').html(htmlsx);
	}
	
	$('#modal-upload').modal('show');
	$("#inputfileDriving").uploadify({
		//按钮额外自己添加点的样式类.upload
        'buttonClass':'upload',
        //限制文件上传大小
        'fileSizeLimit':'200MB',
        //文件选择框显示
        'fileTypeDesc':'选择',
        //文件类型过滤
       /*  'fileTypeExts':'*.zip;*.rar', */
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
        'uploader':'${ctx}/upload/saveFile?type=driving',
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
        	//attachFilePath="${ctx}"+attachFilePath;
        	//console.info(attachFilePath);
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#filenameDriving').html(html);
        	$('#filenameDriving_hidden').val(orginFileName);
        	$('#filepathDriving_hidden').val(attachFilePath);
        }
    });
	
	$("#inputfileToperating").uploadify({
		//按钮额外自己添加点的样式类.upload
        'buttonClass':'upload',
        //限制文件上传大小
        'fileSizeLimit':'200MB',
        //文件选择框显示
        'fileTypeDesc':'选择',
        //文件类型过滤
       /*  'fileTypeExts':'*.zip;*.rar', */
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
        'uploader':'${ctx}/upload/saveFile?type=toperating',
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
        	//attachFilePath="${ctx}"+attachFilePath;
        	//console.info(attachFilePath);
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#filenameToperating').html(html);
        	$('#filenameToperating_hidden').val(orginFileName);
        	$('#filepathToperating_hidden').val(attachFilePath);
        }
    });
	
	$("#inputfileXoperating").uploadify({
		//按钮额外自己添加点的样式类.upload
        'buttonClass':'upload',
        //限制文件上传大小
        'fileSizeLimit':'200MB',
        //文件选择框显示
        'fileTypeDesc':'选择',
        //文件类型过滤
       /*  'fileTypeExts':'*.zip;*.rar', */
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
        'uploader':'${ctx}/upload/saveFile?type=xoperating',
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
        	//attachFilePath="${ctx}"+attachFilePath;
        	//console.info(attachFilePath);
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#filenameXoperating').html(html);
        	$('#filenameXoperating_hidden').val(orginFileName);
        	$('#filepathXoperating_hidden').val(attachFilePath);
        }
    });
}

function uploadrefresh(){
	$('#modal-upload').modal('hide');	
	
}

function clearupload(){
	$('#detilid-hidden').val('');
	$('#filepathDriving_hidden').val('');
	$('#filenameDriving').html('');
	$('#filepathToperating_hidden').val('');
	$('#filenameToperating').html('');
	$('#filepathXoperating_hidden').val('');
	$('#filenameXoperating').html('');
}

function uploadsave(){
	var flag="false";
	var id=$('#detilid-hidden').val();
	var filepath =$.trim($('#filepathDriving_hidden').val());
	var toperPath = $.trim($('#filepathToperating_hidden').val());
	var xoperPath = $.trim($('#filepathXoperating_hidden').val());
	console.info(filepath);
	console.info(toperPath);
	console.info(xoperPath);
	if((filepath != '' && filepath != 'null') || (toperPath != '' && toperPath != 'null') || (xoperPath != '' && xoperPath != 'null')){
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该上传信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : '${ctx}/basicSetting/trackMng/updateFilePath',
							data : JSON.stringify({
								id : id,
								drivingFilePath : filepath,
								toperatingFilePath : toperPath,
								xoperatingFilePath : xoperPath
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
								}
								
							}
							
						});
				  }
			  }
			})
	}else{
		bootbox.alert('请先上传！');	
		return;
	}
}

/* function doview(id){
	clear();
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/outSourcingMng/getDetailData/"+id,
		data :JSON.stringify({
			id :id
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('储位信息');
				$("#stockId").val(data.data.stockId);				
				$("#carShopId").val(data.data.carShopId); 
				$("#province").val(data.data.province); 
				$("#position").val(data.data.position); 
				$("#stockId").attr("disabled",true);
				$("#carShopId").attr("disabled",true);
				$("#province").attr("disabled",true);
				$("#position").attr("disabled",true);
				$('#addBtn').hide();
				$('#editBtn').hide();
				$('#viewBtn').show();
				$('#modal-info').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
} */
</script>



</body>
</html>






