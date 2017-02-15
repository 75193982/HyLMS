
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
 ul li { 
list-style:none; 
} 
.dropdown-menu{
min-width:120px;
}
 a:hover {
    text-decoration: none;
    cursor:pointer;
    background:#2ca9e1;
    color:#fff;
    }
</style>
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			查询管理
			<small>
				<i class="icon-double-angle-right"></i>
				运输车辆查询
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
		    <!-- <select id="fom_driverId" class="form-box" style="width: 150px;">		      
			</select> -->	
			 <input class="form-box" id="fom_driver" type="text" style="width: 170px;" placeholder="请输入驾驶员（模糊查询）"/> 	 	  		   
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
			<a class="itemBtn" onclick="searchInfo()">查询</a>
		<!-- 	<a class="itemBtn" onclick="doadd()">新增</a> -->
			<a class="itemBtn" id="showPrtol" target="_blank" style="width:95px;" href="http://pageapi.gpsoo.net/third?method=jump&page=report&locale=zh-cn&account=G13851050718&target=G13851050718&appkey=3c71e755a316b7130e90c9aeedc182c7">GPS-统计报表</a>
			 <a class="itemBtn" id="showListen" target="_blank" style="width:90px;" href="http://pageapi.gpsoo.net/third?method=jump&page=monitor&locale=zh-cn&account=G13851050718&target=G13851050718&appkey=3c71e755a316b7130e90c9aeedc182c7">GPS-监控</a> 
			</div>	
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
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
					<h3 id="myModalLabel">运输车辆信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item col-xs-12">
							     <label class="title col-xs-4">承运商：</label>
							     <label class="title col-xs-8" id="outSourcing_view"></label>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							    <label class="title col-xs-4">车头牌号：</label>
							   <label class="title col-xs-8" id="no_view"></label>							    
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4">车厢牌号：</label>
							     <label class="title col-xs-8" id="xno_view"></label>								     
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4">驾驶员：</label>
							     <label class="title col-xs-8" id="driver_view"></label>							    
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4">所有人：</label>
							       <label class="title col-xs-8" id="ower_view"></label>	
							     
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4">所有人地址：</label>
							     <label class="title col-xs-8" id="owerAddress_view"></label>	
							     
							 </div>
							<hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4">车辆识别代号：</label>
							     <label class="title col-xs-8" id="vin_view"></label>	
							     
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4">发动机号：</label>
							     <label class="title col-xs-8" id="engineNo_view"></label>								     
							 </div>
							  <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4">注册时间：</label>
							     <label class="title col-xs-8" id="registerTime_view"></label>									    						   					    
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4">外部尺寸：</label>
							      <label class="title col-xs-8" id="size_view"></label>										  
							 </div>		
							     <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">上次年审日期：</label>
							      <label class="title col-xs-8" id="annualReviewTime_view"></label>		
							    </div>										     
							     <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">核定油耗：</label>
							     <label class="title col-xs-8" id="standardOilWear_view"></label>									    
							  </div>
							   <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4">油的折现上限（元）：</label>
							     <label class="title col-xs-8" id="oilDiscountLimit_view"></label>
							  </div>
							    <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4">油的折现扣点（%）：</label>
							      <label class="title col-xs-8" id="oilDiscountPoint_view"></label>							   			   					    
							  </div>
							   <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4">车头行驶证：</label>
							      <label class="title col-xs-8" id="driving_view"></label>							   			   					    
							  </div>	
							   <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4">车头营运证 ：</label>
							      <label class="title col-xs-8" id="toperating_view"></label>							   			   					    
							  </div>	
							   <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4">车厢营运证 ：</label>
							      <label class="title col-xs-8" id="xoperating_view"></label>							   			   					    
							  </div>							  			  				  
							    <hr class="tree"></hr>							  
								 <div class="add-item-btn" id="viewBtn">								   
								    <a class="add-itemBtn btnCancle" onclick="refresh()">关闭</a>
								  </div> 
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
						<h3 id="myModalLabelshow">查看记录信息</h3>
					</div>
					<div class="modal-body">
					   <div>
						  <div class="widget-box dia-widget-box">
								<div class="widget-body">
									<div class="widget-main">	
									<!-- 保险记录 -->
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
					                      <!-- 出险记录 -->						   			  
									    	<table id="outsuranceDetail" class="table table-striped table-bordered table-hover">
					                      <thead>
						                   <tr>	
								               <th>序号</th>
								               <th>出险时间</th>
			                                   <th>驾驶员</th>
			                                   <th>金额</th>
			                                   <th>备注</th>
						                   </tr>
					                      </thead>
					                      <tbody>
					                      </tbody>
					                      </table>
					                      <!-- 维修保养TrackMaintTranslate -->
					                      <table id="trackMaintTranslateDetail" class="table table-striped table-bordered table-hover" >
					                      <thead>
						                   <tr>	
								               <th>序号</th>
								               <th>公里数</th>
			                                   <th>保养时间</th>
			                                   <th>保养费用</th>
			                                   <th>详情</th>
						                   </tr>
					                      </thead>
					                      <tbody>
					                      </tbody>
					                      </table>
					                      <!-- 轮胎更换tyreTranslateDetail -->
					                      <table id="tyreTranslateDetail" class="table table-striped table-bordered table-hover" >
					                      <thead>
						                   <tr>	
								               <th>序号</th>
								               <th>更换时间</th>
			                                   <th>原轮胎编号</th>
			                                   <th>新轮胎编号</th>
			                                   <th>备注</th>
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
						    {data: "outSourcingName","width":"10%"},
						    {data: "no","width":"6%"},
						    {data: "xno","width":"6%"},
						    {data: "driverName","width":"5%"},
						    {data: "codriverName","width":"5%"},
						    {data: "ower","width":"5%"},
						    {data: "owerAddress","width":"8%"},
						    {data: "vin","width":"8%"},	
						    {data: "engineNo","width":"5%"},	
						    {data: "registerTime","width":"8%"},	
						    {data: "size","width":"5%"},		
						  /*   {data: "insuranceCompany","width":"5%"},	 */
						    {data: "annualReviewTime","width":"7%"},	
						    {data: "standardOilWear","width":"5%"},	
						   /*  {data: "oilDiscountLimit"},	
						    {data: "oilDiscountPoint"},	 */
						    {data: null,"width":"10%"}],
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
			    			   return '<a class="table-edit" data-no="'+row.no+'" onclick="doshowdetl('+ row.id+',this)">查看</a>'
			    			    + '<div class="btn-group"><a class="table-edit" style="width:80px;"  data-toggle="dropdown" >记录<i class="icon-caret-down"></i></a>'
			    			    +'<ul class="dropdown-menu dropdown-info dropdown-menu-right">'
								+'<li><a data-no="'+row.no+'" onclick="getInsurance(this,0)">保险记录</a></li>'
								+'<li class="divider"></li><li><a data-no="'+row.no+'" onclick="getInsurance(this,1)">出险记录</a></li>'
								+'<li class="divider"></li><li><a data-no="'+row.no+'" onclick="getTrackMaintTranslate(this)">维修保养记录</a></li>'
			    			    +'<li class="divider"></li><li><a data-no="'+row.no+'" onclick="getTyreTranslate(this)">轮胎更换记录</a></li></ul></div>' ;
			    			  
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
						    {data: "outSourcingName","width":"10%"},
						    {data: "no","width":"6%"},
						    {data: "xno","width":"6%"},
						    {data: "driverName","width":"5%"},
						    {data: "codriverName","width":"5%"},
						    {data: "ower","width":"5%"},
						    {data: "owerAddress","width":"8%"},
						    {data: "vin","width":"8%"},	
						    {data: "engineNo","width":"5%"},	
						    {data: "registerTime","width":"8%"},	
						    {data: "size","width":"5%"},		
						  /*   {data: "insuranceCompany","width":"5%"},	 */
						    {data: "annualReviewTime","width":"7%"},	
						    {data: "standardOilWear","width":"5%"},	
						   /*  {data: "oilDiscountLimit"},	
						    {data: "oilDiscountPoint"},	 */
						    {data: null,"width":"10%"}],
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
			    			   return '<a class="table-edit" data-no="'+row.no+'" onclick="doshowdetl('+ row.id+',this)">查看</a>'
			    			   + '<div class="btn-group"><a class="table-edit" style="width:80px;"  data-toggle="dropdown" href="#" >记录<i class="icon-caret-down"></i></a>'
			    			    +'<ul class="dropdown-menu dropdown-info dropdown-menu-right">'
								+'<li><a data-no="'+row.no+'" onclick="getInsurance(this,0)">保险记录</a></li>'
								+'<li class="divider"></li><li><a data-no="'+row.no+'" onclick="getInsurance(this,1)">出险记录</a></li>'
								+'<li class="divider"></li><li><a data-no="'+row.no+'" onclick="getTrackMaintTranslate(this)">维修保养记录</a></li>'
			    			    +'<li class="divider"></li><li><a data-no="'+row.no+'" onclick="getTyreTranslate(this)">轮胎更换记录</a></li></ul></div>' ;
			    			  
		                }	       
		    	} 
		      ],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	getOutSourcing();//获取承运商
	//getCarShop();
	 /* checkeURL(); */
	 checkeURL();
	// binddirver();//绑定驾驶员
});

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
            				if(data.data[i]['name']==driver){
            					html +='<option value='+data.data[i]['name']+' selected="selected">'+data.data[i]['name']+'</option>';
            				}else{
            					html +='<option value='+data.data[i]['name']+'>'+data.data[i]['name']+'</option>';
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
/* 新增查看地址  add by matingting on 2016/11/07*/
function doshow(id){
	$('#modal-show').modal('show');
}
/**明细查看**/
function doshowdetl(id){
	$('#modal-info').modal('show');
	//console.info(id);
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
				//console.info(JSON.stringify(data.data));
				$('#id-hidden').val(id);				
				$("#outSourcing_view").html(data.data.outSourcingName); 
				//$("#type").val(data.data.type); 
				$("#no_view").html(data.data.no); 
				$("#xno_view").html(data.data.xno); 
				$('#driver_view').html(data.data.driverName); 
				$("#ower_view").html(data.data.ower); 
				$("#owerAddress_view").html(data.data.owerAddress);
				$("#vin_view").html(data.data.vin); 
				$("#engineNo_view").html(data.data.engineNo); 
				$("#size_view").html(data.data.size); 
				if(data.data.registerTime!=''&&data.data.registerTime!=null){
					$("#registerTime_view").html(jsonForDateFormat(data.data.registerTime)); 
				}else{
					$("#registerTime_view").html(''); 
				}
				/* if(data.data.insuranceStartTime!=''){
					$("#insuranceStartTime").val(jsonForDateFormat(data.data.insuranceStartTime)); 
				}
				if(data.data.insuranceEndTime!=''){
					$("#insuranceEndTime").val(jsonForDateFormat(data.data.insuranceEndTime)); 
				} */
				if(data.data.annualReviewTime!=''&&data.data.annualReviewTime!=null){
					$("#annualReviewTime_view").html(jsonForDateFormat(data.data.annualReviewTime)); 
				}else{
					$("#annualReviewTime_view").html(''); 
				}	
				/* $("#insuranceCompany").val(data.data.insuranceCompany); */
				$("#standardOilWear_view").html(data.data.standardOilWear);
				$("#oilDiscountLimit_view").html(data.data.oilDiscountLimit);
				$("#oilDiscountPoint_view").html(data.data.oilDiscountPoint);								
				if(data.data.drivingFilePath!=''&&data.data.drivingFilePath!='null'&&data.data.drivingFilePath!='undefined'&&data.data.drivingFilePath!=null){
					var drivingFilePath="${ctx}"+data.data.drivingFilePath;
					var htmls='<a  href='+drivingFilePath+' target="_blank">照片</a>';
					$('#driving_view').html(htmls);
				}else{
					$('#driving_view').html('');
				}
				if(data.data.toperatingFilePath!=''&&data.data.toperatingFilePath!='null'&&data.data.toperatingFilePath!='undefined'&&data.data.toperatingFilePath!=null){
					var toperatingFilePath="${ctx}"+data.data.toperatingFilePath;
					var htmls='<a  href='+toperatingFilePath+' target="_blank">照片</a>';
					$('#toperating_view').html(htmls);
				}else{
					$('#toperating_view').html('');
				}
				if(data.data.xoperatingFilePath!=''&&data.data.xoperatingFilePath!='null'&&data.data.xoperatingFilePath!='undefined'&&data.data.xoperatingFilePath!=null){
					var xoperatingFilePath="${ctx}"+data.data.xoperatingFilePath;
					var htmls='<a  href='+xoperatingFilePath+' target="_blank">照片</a>';
					$('#xoperating_view').html(htmls);
				}else{
					$('#xoperating_view').html('');
				}
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	});
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
/**保险/出险记录**/
function getInsurance(e,type){
	//console.info('eee');
	var carNumber=$(e).attr('data-no');
	var html="";
	 $.ajax({
			type : 'POST',
			url : "${ctx}/basicSetting/trackMng/getInsuranceList",
			data :{carNumber:carNumber,type:type},
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.info(JSON.stringify(data.data));
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
							var insertTime='';
							if(data.data[i]['insertTime']!=null && data.data[i]['insertTime']!=''){
								insertTime=jsonDateFormat(data.data[i]['insertTime']);
							}
							if(data.data[i]['driverName']==null){
								data.data[i]['driverName']='';
							}
							if(data.data[i]['amount']==null){
								data.data[i]['amount']='';
							}
							if(data.data[i]['mark']==null){
								data.data[i]['mark']='';
							}
							if(type==0){
								html+='<tr>'
									+'<td>'+(i+1)+'</td>'
								    +'<td>'+insuranceType+'</td>'
								    +'<td>'+insuranceBillNo+'</td>'
								    +'<td>'+startTime+'</td>'
								    +'<td>'+endTime+'</td>'
								    +'</tr>';
							}else{
								html+='<tr>'
									+'<td>'+(i+1)+'</td>'									
								    +'<td>'+insertTime+'</td>'
								    +'<td>'+data.data[i]['driverName']+'</td>'
								    +'<td>'+data.data[i]['amount']+'</td>'
								    +'<td>'+data.data[i]['mark']+'</td>'
								    +'</tr>';
							}
							
						}
					}else{
						html='<tr><td colspan="5">暂无记录</td></tr>';
					}
					$('#tyreTranslateDetail').hide();
					$('#trackMaintTranslateDetail').hide();
					if(type==0){
						$('#outsuranceDetail').hide();
						$('#insuranceDetail').show();	
						$('#myModalLabelshow').html('保险信息');	
						$('#insuranceDetail tbody').html(html);	
					}else{
						$('#outsuranceDetail').show();
						$('#insuranceDetail').hide();
						$('#myModalLabelshow').html('出险信息');	
						$('#outsuranceDetail tbody').html(html);
					}
					
					$('#modal-edit').modal('show');
				}else{
					bootbox.alert('获取失败！');
				}
			}
	 });
}
function getTrackMaintTranslate(e){
	var carNumber=$(e).attr('data-no');
	var html="";
	$('#myModalLabelshow').html('维修保养信息');	
	 $.ajax({
			type : 'POST',
			url : "${ctx}/basicSetting/trackMng/getTrackMaintTranslate",
			data :{carNumber:carNumber},
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.info(JSON.stringify(data.data));
					if(data.data.length>0 && data.data!=null){
						for(var i=0;i<data.data.length;i++){
							var insertTime='';
							if(data.data[i]['insertTime']!=null && data.data[i]['insertTime']!=''){
								insertTime=jsonDateFormat(data.data[i]['insertTime']);
							}
							if(data.data[i]['currentMileage']==null){
								data.data[i]['currentMileage']='';
							}
							if(data.data[i]['amount']==null){
								data.data[i]['amount']='';
							}
							if(data.data[i]['detailInfo']==null){
								data.data[i]['detailInfo']='';
							}
							html+='<tr>'
								+'<td>'+(i+1)+'</td>'
							    +'<td>'+data.data[i]['currentMileage']+'</td>'
							    +'<td>'+insertTime+'</td>'
							    +'<td>'+data.data[i]['amount']+'</td>'
							    +'<td>'+data.data[i]['detailInfo']+'</td>'
							    +'</tr>';
							
						}
					}else{
						html='<tr><td colspan="5">暂无记录</td></tr>';
					}
					$('#outsuranceDetail').hide();
					$('#insuranceDetail').hide();
					$('#tyreTranslateDetail').hide();
					$('#trackMaintTranslateDetail').show();
					$('#trackMaintTranslateDetail tbody').html(html);	
					
					$('#modal-edit').modal('show');
				}else{
					bootbox.alert('获取失败！');
				}
			}
	 });
}
function getTyreTranslate(e){
	var carNumber=$(e).attr('data-no');
	var html="";	
	$('#myModalLabelshow').html('轮胎更换信息');	
	 $.ajax({
			type : 'POST',
			url : "${ctx}/basicSetting/trackMng/getTyreTranslate",
			data :{carNumber:carNumber},
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.info(JSON.stringify(data.data));
					if(data.data.length>0 && data.data!=null){
						for(var i=0;i<data.data.length;i++){
							var applyTime='';
							if(data.data[i]['applyTime']!=null && data.data[i]['applyTime']!=''){
								applyTime=jsonDateFormat(data.data[i]['applyTime']);
							}
							if(data.data[i]['oldTyreNo']==null){
								data.data[i]['oldTyreNo']='';
							}
							if(data.data[i]['newTyreNo']==null){
								data.data[i]['newTyreNo']='';
							}
							if(data.data[i]['mark']==null){
								data.data[i]['mark']='';
							}
							html+='<tr>'
								+'<td>'+(i+1)+'</td>'
							    +'<td>'+applyTime+'</td>'
							    +'<td>'+data.data[i]['oldTyreNo']+'</td>'
							    +'<td>'+data.data[i]['newTyreNo']+'</td>'
							    +'<td>'+data.data[i]['mark']+'</td>'
							    +'</tr>';
							
						}
					}else{
						html='<tr><td colspan="5">暂无记录</td></tr>';
					}
					$('#outsuranceDetail').hide();
					$('#insuranceDetail').hide();
					$('#tyreTranslateDetail').show();
					$('#trackMaintTranslateDetail').hide();
					$('#tyreTranslateDetail tbody').html(html);	
					
					$('#modal-edit').modal('show');
				}else{
					bootbox.alert('获取失败！');
				}
			}
	 });
}
</script>



</body>
</html>






