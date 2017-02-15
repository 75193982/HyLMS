
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
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
    #modal-info{
    width: 650px;
    height: 600px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }
     #modal-payInsurance{
    width: 650px;
    height: 400px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }
     .table-upload{
	width: 70px;
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
	margin-left:5px;
}
.table-upload:hover{color:#fff;} 
#modal-upload{
    width: 600px;
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
				保费管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
	<div class="searchbox col-xs-12">
		<label class="title" style="float: left;height: 34px;line-height: 34px; width:80px;">创建时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 234px;margin-right:45px;">
				<input class="form-control" id="form_startTime" type="text" placeholder="请输入时间" style="height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 234px;margin-right:23px;margin-left: 40px;">
				<input class="form-control" id="form_endTime" type="text" placeholder="请输入时间" style="height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			 </div>	
			 <label class="title">保单号：</label>
		     <input id="fom_insuranceBillNo" class="form-box" type="text" placeholder="请输入保单号" style="width:195px;"/>				
		</div>
		
		<div class="searchbox col-xs-12">
			<label class="title" style="width:76px;text-align:left;">类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：</label>
			<select id="form_insuranceType" class="form-box" style="width:234px;">	
		    	 <option value="">请选择类型</option>
		    	 <option value="0">交强险</option>
			     <option value="1">商业险</option>
			     <option value="2">货运险</option>		    	    
			</select>		   				
		    <label class="title" style="height: 34px;line-height: 34px;width:80px;">装运车号：</label>
		    <select id="fom_carNumber" class="form-box" style="width:234px;">
		    </select>
		     
		    
			 <a class="itemBtn" onclick="searchInfo()" style="width:55px;margin-left:5px;margin-right:5px;">查询</a>
			 <a class="itemBtn" onclick="doadd()" style="width:55px;margin-left:5px;">新增</a>
			
			  
		</div>
		<div class="searchbox col-xs-12">
		<label class="title" style="float: left;height: 34px;line-height: 34px;width:80px;">总&nbsp;&nbsp;费&nbsp;用：</label>
		  <input id="fom_amount" class="form-box" type="text" placeholder="请输入总费用"  disabled="disabled" style="width:234px;"/>  
		    <label class="title">未&nbsp;&nbsp;支&nbsp;&nbsp;付：</label>		   		
		   <input id="fom_balance" class="form-box" type="text" placeholder="请输入未支付费用" disabled="disabled" style="width:234px;"/>  
		   <a class="itemBtn m-lr5" onclick="doprint()">打印</a>
		   <a class="itemBtn m-lr5" onclick="doexport()">导出</a>
		   <a class="itemBtn m-lr5" onclick="dopayLog()"  style="width:90px;">保费支付查询</a>   
		  </div>		
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>类型</th>
					<th>装运车号</th>
                    <th>保险公司</th>
                    <th>保单号</th>
                    <th>保险开始时间</th>
                    <th>保险结束时间</th>
                    <th>总金额</th>                   
                   <!--  <th>提醒时间</th> -->
                    <th>备注</th>    
                    <th>创建时间</th> 
                    <th>更新时间 </th>  
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
					<h3 id="myModalLabel">保费新增</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							 <!-- <div class="add-item">
							     <label class="title"><span class="red">*</span>类型：</label>
							     <div class="form-new">
							     <select id="type" class="form-control">
								     <option value="0">参加保险</option>
								     <option value="1">报保险</option>	      
			                     </select>	
			                     </div>			                     							     
							     <input class="form-control" id="id-hidden" type="hidden"/>
							  </div> -->
							  <div class="add-item">
							     <label class="title"><span class="red">*</span>类型：</label>
							     <div class="form-new">
							     <select id="insuranceType" class="form-control">
							         <option value="">请选择保险类型</option>
								     <option value="0">交强险</option>
								     <option value="1">商业险</option>
								     <option value="2">货运险</option>	      
			                     </select>	
			                     </div>			                     							     
							     <input class="form-control" id="id-hidden" type="hidden"/>
							      <input class="form-control" id="driver" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title"><span class="red">*</span>装运车号：</label>
							     <div class="form-new">
							     <select id="carNumber" class="form-control">							       
			                     </select>	
							     </div>						     
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title"><span class="red">*</span>保险公司：</label>
							     <div class="form-new">
							    <input class="form-control" id="insuranceCom" type="text" placeholder="请输入保险公司"/>
							    </div>
							 </div>
							  <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title"><span class="red">*</span>保单号：</label>
							     <div class="form-new">
							    <input class="form-control" id="insuranceBillNo" type="text" placeholder="请输入保单号"/>
							    </div>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title"><span class="red">*</span>保险开始时间：</label>							    
							      <div class="input-group input-group-sm form-new">
									<input class="form-control" id="startTime" type="text" placeholder="请输入保险开始时间"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>							   
							    </div>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title"><span class="red">*</span>保险结束时间：</label>							    
							      <div class="input-group input-group-sm form-new">
									<input class="form-control" id="endTime" type="text" placeholder="请输入保险结束时间"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>							   
							    </div>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title"><span class="red">*</span>总金额：</label>
							     <div class="form-new">
							    <input class="form-control" id="amount" type="text" placeholder="请输入总金额"/>
							    </div>
							 </div>
							  <!-- <hr class="tree"></hr>
							 <div class="add-item">
							     <label class="title">提醒时间：</label>							    
							      <div class="input-group input-group-sm form-new">
									<input class="form-control" id="noticeTime" type="text" placeholder="请输入提醒时间"/>
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>							   
							    </div>
							 </div> -->
							 <hr class="tree"></hr>
							 <div class="add-item" style="height: 80px;">
							     <label class="title">备注：</label>
							     <div class="form-new">
							     <textarea rows="4" cols="4" class="form-control" id="mark" placeholder="请输入备注" style="height: 80px;"></textarea>
							    </div>
							 </div>													 				  
							    <hr class="tree"></hr>
							 <div class="row row-btn-tit" id="detailListbtn">
		                     <div class="col-xs-3 pd-2">
			                 <div class="row-tit">
			                                                            设置险种信息
			                 </div>
		                     </div>
		                     <div class="col-xs-7"></div>
		                     <div class="col-xs-2">
				             <div class="form-contr-1">
				             <a class="form-btn-1" onclick="addNewInsurance();"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>险种</a>				             
				             </div>
			                 </div>
		                     </div>	
		                       <!-- 第一条详细信息 -->
		        <div id="insurancecenter">            
		     <div id="detailList0" class="border-b-ff9a00 detailList">
		       <!-- 第五列 -->
		     <div class="row newrow">
		       <div class="col-xs-3 pd-2">
			       <div class="lab-tit">
			          <label class="title" style="margin-top: 10px;"><span class="red">*</span>险种名称:</label>
			       </div>
		       </div>
		       <div class="col-xs-8">
			       <div class="form-contr">
			          <input class="form-control" id="insuranceName0" type="text" placeholder="请输入险种名称" />
			       </div>
		       </div>		       		       		       		     
		     </div>
		     <div class="row newrow">		       		      
		       <div class="col-xs-3 pd-2">
			       <div class="lab-tit" >
			          <label class="title" style="margin-top: 10px;"><span class="red">*</span>金额:</label>
			       </div>
		       </div>
		       <div class="col-xs-8">
			       <div class="form-contr">
			          <input class="form-control" id="amount0" type="text" placeholder="请输入金额" />
			       </div>
		       </div>		       
		     </div>		
		     <div class="row newrow">		     		      
		       <div class="col-xs-3 pd-2">
			       <div class="lab-tit">
			          <label class="title" style="margin-top: 10px;">备注:</label>
			       </div>
		       </div>
		       <div class="col-xs-8">
			       <div class="form-contr">
			        <textarea rows="4" cols="4" class="form-control" id="mark0" placeholder="请输入备注"></textarea>			        
			       </div>
		       </div>
		     </div>				    		     
		     </div>
			</div>	
			<div id="insurancelist">
			<table id="insurancedetailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>险种名称</th>
					<th>金额</th>
                    <th>备注</th>                   
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			</div>			   
		 <div class="add-item-btn" id="addBtn">
		 <a class="add-itemBtn btnOk" onclick="save();">保存</a>
		 <a class="add-itemBtn btnCancle" onclick="refresh();">关闭</a>
		 </div>
		<div class="add-item-btn" id="editBtn">
		<a class="add-itemBtn btnOk" onclick="update()">更新</a>
		<a class="add-itemBtn btnCancle" onclick="refresh()">关闭</a>
		</div> 
		<div class="add-item-btn" id="viewBtn">								   
		<a class="add-itemBtn btnCancle" onclick="refresh()">关闭</a>
	    </div> 
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
			<div class="modal fade" id="modal-payInsurance" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="mypayModalLabel">支付参保费用</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								<input type="hidden" name="insuranceId_hiden" id="insuranceId_hiden" />
								<input type="hidden" name="insuranceNo_hiden" id="insuranceNo_hiden" />
							<div class="add-item">
							 <label class="title"><span class="red">*</span>支付金额：</label>
							     <div class="form-new">
							    <input class="form-control" id="payamount" type="text" />
							    </div>
							</div>
							 <hr class="tree"></hr>
							<div class="add-item">
							 <label class="title">备注：</label>
							     <div class="form-new">
							   <textarea rows="4" cols="4" class="form-control" id="paymark" placeholder="请输入备注"></textarea>
							    </div>
							</div>
							<hr class="tree" style="margin-top: 80px;"></hr>
							 <div class="add-item-btn" id="payaddBtn">
		                     <a class="add-itemBtn btnOk" onclick="savepay();">保存</a>
		                     <a class="add-itemBtn btnCancle" onclick="payclose();">关闭</a>
		                     </div>
		                     <div class="add-item-btn" id="claimPayBtn">
		                     <a class="add-itemBtn btnOk" onclick="saveclaimPay();">保存</a>
		                     <a class="add-itemBtn btnCancle" onclick="payclose();">关闭</a>
		                     </div>
							</div>
							</div>
							</div>
							</div>
			 </div>			
           </div>
           <div class="modal fade" id="modal-upload" tabindex="-1" role="dialog">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">附件上传</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
														  
							 <div class="add-item col-xs-12" style="margin-bottom: 10px;margin-top: 20px;">
							    <label class="title col-xs-3" >发票 ：</label>	
							    <div class="col-xs-9"> <input type="file" id="invoiceAttachfile" /> <label class="title" id="invoiceAttachname"></label>
							    <input type="hidden" name="invoiceAttachname_hidden" id="invoiceAttachname_hidden"/>
							    <input type="hidden" name="invoiceAttachPath_hidden" id="invoiceAttachPath_hidden"/>
							    <input  id="detilid-hidden" type="hidden"/>
							    </div>							    
							   </div>	
							  	<div class="add-item col-xs-12" style="margin-bottom: 10px;margin-top: 20px;">
							    <label class="title col-xs-3" >保单 ：</label>	
							    <div class="col-xs-9"> <input type="file" id="insuranceBillfile" /> <label class="title" id="insuranceBillname"></label>
							    <input type="hidden" name="insuranceBillname_hidden" id="insuranceBillname_hidden"/>
							    <input type="hidden" name="insuranceBillPath_hidden" id="insuranceBillPath_hidden"/>							  
							    </div>							    
							   </div>
							   <div class="add-item col-xs-12" style="margin-bottom: 10px;margin-top: 20px;">
							    <label class="title col-xs-3" >付款记录 ：</label>	
							    <div class="col-xs-9"> <input type="file" id="payLogfile" /> <label class="title" id="payLogname"></label>
							    <input type="hidden" name="payLogname_hidden" id="payLogname_hidden"/>
							    <input type="hidden" name="payLogPath_hidden" id="payLogPath_hidden"/>							  
							    </div>							    
							   </div>		  
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
			<!-- 查看保费信息 modal Begin -->
			<div class="modal fade" id="modal-einfo" tabindex="-1" role="dialog" data-backdrop="static" style="width:700px;">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal" onclick="showRefresh()">×</button>
					<h3 id="myModalLabel" style="margin: 5px;">查看保费信息</h3>
				</div>
				<div class="modal-body" style="height:510px;overflow:auto;">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								  <div class="add-item">
								     <label class="title"><span class="red">*</span>类型：</label>
								      <div class="form-new">
								         <p id="sinsuranceType" class="form-control no-border"></p>	
				                     </div>			                     							     
								  </div>
							  		<hr class="tree"></hr>
									 <div class="add-item">
									     <label class="title"><span class="red">*</span>装运车号：</label>
									     <div class="form-new">
									       <p id="scarNumber" class="form-control no-border"></p>							       	
									     </div>						     
									 </div>
									  <hr class="tree"></hr>
									 <div class="add-item">
									     <label class="title"><span class="red">*</span>保险公司：</label>
									     <div class="form-new">
									       <p id="sinsuranceCom" class="form-control no-border"></p>
									    </div>
									 </div>
									  <hr class="tree"></hr>
									 <div class="add-item">
									     <label class="title"><span class="red">*</span>保单号：</label>
									     <div class="form-new">
									       <p id="sinsuranceBillNo" class="form-control no-border"></p>
									    </div>
									 </div>
							 		<hr class="tree"></hr>
									 <div class="add-item">
									     <label class="title"><span class="red">*</span>保险开始时间：</label>
									     <div class="form-new">
									       <p id="sstartTime" class="form-control no-border"></p>
									     </div>							    
									 </div>
							        <hr class="tree"></hr>
									 <div class="add-item">
									     <label class="title"><span class="red">*</span>保险结束时间：</label>							    
									      <div class="form-new">
									       <p id="sendTime" class="form-control no-border"></p>
									     </div>		
									 </div>
							 		<hr class="tree"></hr>
									 <div class="add-item">
									     <label class="title"><span class="red">*</span>总金额：</label>
									     <div class="form-new">
									      <p id="samount" class="form-control no-border"></p>
									    </div>
									 </div>
							 		<hr class="tree"></hr>
							 		<div class="add-item">
									     <label class="title">发票凭证：</label>
									     <div class="form-new">
									      <p id="sinvoiceAttachPath" class="form-control no-border"></p>
									    </div>
									 </div>
							 		<hr class="tree"></hr>
							 		<div class="add-item">
									     <label class="title">保单凭证：</label>
									     <div class="form-new">
									      <p id="sinsuranceBillPath" class="form-control no-border"></p>
									    </div>
									 </div>
							 		<hr class="tree"></hr>
							 		<div class="add-item">
									     <label class="title">付款凭证：</label>
									     <div class="form-new">
									      <p id="spayLogPath" class="form-control no-border"></p>
									    </div>
									 </div>
							 		<hr class="tree"></hr>
									 <div class="add-item" style="height: 80px;">
									     <label class="title">备注：</label>
									     <div class="form-new">
									        <textarea rows="4" cols="4" class="form-control" id="smark" placeholder="请输入备注" style="height: 80px;" disabled="disabled"></textarea>
									    </div>
									 </div>													 				  
							     <hr class="tree"></hr>
								<div id="insurancelist">
									<table id="sinsurancedetailtable" class="table table-striped table-bordered table-hover">
										<thead>
											<tr>														
												<th>序号</th>
												<th>险种名称</th>
												<th>金额</th>
							                    <th>备注</th>                   
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								 </div>			   
							<div class="add-item-btn" id="viewBtn">								   
							   <a class="add-itemBtn btnCancle" onclick="showRefresh()">关闭</a>
						    </div> 
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
			<!-- 查看保费信息 modal end -->	
		</div>
	</div>

</div>
	<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>保费信息记录表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>
		        <th>序号</th>
				<th>类型</th>
				<th>装运车号</th>
		        <th>保险公司</th>
		        <th>保单号</th>
		        <th>保险开始时间</th>
				<th>保险结束时间</th>
		        <th>总金额</th>
		        <th>备注</th>
		        <th>创建时间</th>
		        <th>更新时间</th>
		        <th>状态</th>
		      </tr>
		    </thead>
		    <tbody>
		    </tbody>
		  </table>
		  <div id="footerInfo"><h3>盐城辉宇物流有限公司  制</h3></div>
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
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script>
<script src="${ctx}/staticPublic/js/bootstrap-tab.js"></script>
<script type="text/javascript">
function init(){	
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/trackInsuranceMng/getListData" , //获取数据的ajax方法的URL							 
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
				          {data: "insuranceType","width":"5%"},
						    {data: "carNumber","width":"6%"},
						    {data: "insuranceCompany","width":"8%"},
						    {data: "insuranceBillNo","width":"7%"},
						    {data: "startTime","width":"8%"},
						    {data: "endTime","width":"8%"},
						    {data: "amount","width":"6%"},	
						   /*  {data: "noticeTime","width":"7%"}, */
						    {data: "mark","width":"6%"},	
						    {data: "insertTime","width":"10%"},
						    {data: "updateTime","width":"10%"},
						    {data: "payStatus","width":"6%"},			    	
						    {data: null,"width":"18%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 1,
				 render: function (data, type, row, meta) {
					 if(data=='0'){
						 return '交强险';
					 }else if(data=='1'){
						 return '商业险';
					 }else if(data=='2'){
						 return '货运险';
					 }else{
						 return data;
					 }						
			       }	       
			},{
				 //入职时间
				 targets: 5,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonForDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 6,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonForDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 9,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 10,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 11,
				 render: function (data, type, row, meta) {
					  if(data=='0'){
						 return '未支付';
					 }else if(data=='1'){
						 return '已支付';
					 }else {
						 return '';
					 }					
			       }	       
			},{//操作栏
		    	 targets: 12,
		    	 render: function (data, type, row, meta) {		
		    		 if(row.payStatus=='0'){
		    			 return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
			               +'<a class="table-upload" style="width:65px;margin-top:1px;" onclick="doupload(\''+ row.id +'\',\''+ row.invoiceAttachPath +'\',\''+ row.insuranceBillPath +'\',\''+ row.payLogPath +'\')">附件上传</a>'
			               +'<a class="table-edit" onclick="payAmount('+ row.id +')">支付</a>'
			               +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
		    		 }else {
		    				 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';
		    				 /* return '<a class="table-audit" onclick="doclaimPay(\''+ row.id +'\',\''+ row.insuranceBillNo +'\')">索赔费用</a>'
		    				      +'<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'; */ 
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
		 "sAjaxSource": "${ctx}/operationMng/trackInsuranceMng/getListData", //获取数据的ajax方法的URL	
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
				          {data: "insuranceType","width":"5%"},
						    {data: "carNumber","width":"6%"},
						    {data: "insuranceCompany","width":"8%"},
						    {data: "insuranceBillNo","width":"7%"},
						    {data: "startTime","width":"8%"},
						    {data: "endTime","width":"8%"},
						    {data: "amount","width":"6%"},	
						   /*  {data: "noticeTime","width":"7%"}, */
						    {data: "mark","width":"6%"},	
						    {data: "insertTime","width":"10%"},
						    {data: "updateTime","width":"10%"},
						    {data: "payStatus","width":"6%"},			    	
						    {data: null,"width":"18%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 1,
				 render: function (data, type, row, meta) {
					 if(data=='0'){
						 return '交强险';
					 }else if(data=='1'){
						 return '商业险';
					 }else if(data=='2'){
						 return '货运险';
					 }else{
						 return data;
					 }						
			       }	       
			},{
				 //入职时间
				 targets: 5,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonForDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 6,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonForDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 9,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 10,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonDateFormat(data);
					 }else{
						 return '';
					 }					
			       }	       
			},{
				 //入职时间
				 targets: 11,
				 render: function (data, type, row, meta) {
					  if(data=='0'){
						 return '未支付';
					 }else if(data=='1'){
						 return '已支付';
					 }else {
						 return '';
					 }					
			       }	       
			},{//操作栏
		    	 targets: 12,
		    	 render: function (data, type, row, meta) {		
		    		 if(row.payStatus=='0'){
		    			 return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
			               +'<a class="table-upload" style="width:65px;margin-top:1px;" onclick="doupload(\''+ row.id +'\',\''+ row.invoiceAttachPath +'\',\''+ row.insuranceBillPath +'\',\''+ row.payLogPath +'\')">附件上传</a>'
			               +'<a class="table-edit" onclick="payAmount('+ row.id +')">支付</a>'
			               +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>';
		    		 }else {
		    				 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';
		    				 /* return '<a class="table-audit" onclick="doclaimPay(\''+ row.id +'\',\''+ row.insuranceBillNo +'\')">索赔费用</a>'
		    				      +'<a class="table-edit" onclick="doview('+ row.id +')">查看</a>'; */ 
		    		 }    				                 
	                }	       
	    		}  
		      ],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	$("#form_startTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#form_endTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	//getOutSourcing();//获取承运商
	//getCarShop();
	 getStockListInit();
})

/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var startTime=$("#form_startTime").val(); 
	   var endTime=$("#form_endTime").val(); 
	   var carNumber=$("#fom_carNumber").val();
	   var type='0';
	   var insuranceBillNo=$("#fom_insuranceBillNo").val();
	   var insuranceType=$("#form_insuranceType").val();
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
				type :$.trim(type) ,
				carNumber :$.trim(carNumber) ,
				insuranceBillNo :$.trim(insuranceBillNo) ,
				startInTime :$.trim(startTime) ,
				endInTime : $.trim(endTime),
				insuranceType : insuranceType
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
					var allamount=0;
					var allbalance=0;
					if(obj.aaData.length>0){
						for(var i=0;i<obj.aaData.length;i++){
							obj.aaData[i]["rownum"]=i+1;
							if(obj.aaData[i]["type"]=='0'){
								allamount+=obj.aaData[i]["amount"];
								allbalance+=obj.aaData[i]["balance"];
							}
						}
						$('#fom_amount').val(allamount);
						$('#fom_balance').val(allbalance);
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
            			html +='<option value='+data.data[i]['scheduleBillNo']+' data-carNumber='+data.data[i]['carNumber']+' data-driver='+data.data[i]['driver']+'>'+data.data[i]['scheduleBillNo']+'</option>';
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
	$('#viewBtn').hide();
	$('#insurancelist').hide();
	$('#insurancecenter').show();
	$('#myModalLabel').html('新增保单');	
	$('#modal-info').modal('show');
	$('#apply_add').show();
	$("#carNumber").attr("disabled",false);						
	$("#insuranceBillNo").attr("disabled",false);
	$("#startTime").attr("disabled",false);
	$("#endTime").attr("disabled",false);
	$("#type").attr("disabled",false);
	$("#amount").attr("disabled",false);
	$("#mark").attr("disabled",false);
	$("#startTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#endTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	getStockList();//绑定货运车
	//bindscheduleBillNo();//绑定调度单
	$('#type').change(function(){
		var type=$(this).children('option:selected').val();		
		 if($(this).val()=='0'){
			 $("#insurancecenter").show();
			 $("#detailListbtn").show();
			 $("#insuranceBillNo").attr("disabled",false);
     		  $("#startTime").attr("disabled",false);
     		  $("#endTime").attr("disabled",false);
		  }else{			  
			  $("#insurancecenter").hide(); 
			  $("#detailListbtn").hide();
			  //$("#driver").attr("disabled",true);
      		  $("#insuranceBillNo").attr("disabled",true);
      		  $("#startTime").attr("disabled",true);
      		  $("#endTime").attr("disabled",true);
		  }
	});
	  /* 根据货运车绑定驾驶员 */
	  $('#carNumber').on('change',function(e){
		  var type=$('#type').val();
		  if(type=='0'){
			  if($(this).val()=='' || $(this).val()==null){
				  $('#driver').val('');
			  }else{
				  $('#driver').val($(this).find('option:selected').attr('data-driver'));
			  }
		  }else{
			 var  carNumber=$(this).val();
			 $.ajax({  
			        url: '${ctx}/operationMng/trackInsuranceMng/getInsuranceBean',  
			        type: "POST",  
			        contentType : "application/json;charset=UTF-8",
			        data : JSON.stringify({
			        	carNumber : $.trim(carNumber)	
					}),
					dataType : 'JSON',
			        success: function (data) {
			        	//var html ='<option value="" data-id="">请选择货运车</option>';
			            if(data.code == 200){  
			            	if(data.data!=null && data.data!=''){
			            		$('#driver').val(data.data.driver);
			            		$('#insuranceBillNo').val(data.data.insuranceBillNo);
			            		if(data.data.startTime!=''){
			            			$('#startTime').val(jsonForDateFormat(data.data.startTime));
			            		}else{
			            			$('#startTime').val('');
			            		} 			            			
			            			if(data.data.endTime!=''){
			            			$('#endTime').val(jsonForDateFormat(data.data.endTime));
			            		}else{
			            			$('#endTime').val('');
			            		}
			            		
			            	}else{
			            		$('#driver').val('');
			            		$('#insuranceBillNo').val('');
			            		$('#startTime').val('');
			            		$('#endTime').val('');
			            	}
			            	
			               }else{  
			            	   bootbox.alert('加载失败！');
			               }  
			        }  
			      });
		  }
		  
	  });
}
/* 绑定货运车 */
function getStockList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/trackInsuranceMng/getStockList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="" data-driver="">请选择装运车号</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['no']+' data-driver='+data.data[i]['driver']+'>'+data.data[i]['no']+'</option>';
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
/* 初始绑定货运车信息 */
function getStockListInit(){
	  $.ajax({  
	        url: '${ctx}/operationMng/trackInsuranceMng/getStockList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="" data-driver="">请选择货运车</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['no']+' data-driver='+data.data[i]['driver']+'>'+data.data[i]['no']+'</option>';
	                		}
	            		}
	            	}
	            	$('#fom_carNumber').html(html);
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
	$('#insuranceType').val('');
	$('#carNumber').val('');		
	$('#driver').val('');
	$('#insuranceCom').val('');
	$('#insuranceBillNo').val('');
	$('#startTime').val('');
	$('#endTime').val('');
	$('#amount').val('');
	/* $('#noticeTime').val(''); */
	$('#mark').val('');	
	$('#insuranceName0').val('');	
	$('#amount0').val('');	
	$('#mark0').val('');	
	 var index=$('.detailList').length;
	 if(index>1){
		 $("#insurancecenter div.addclass").remove();	 		 
	 }	
}
/* 保存保费管理信息 */
function save(){
	var flag="false";
	var type='0'; 
	var insuranceType=$('#insuranceType').val();
	var carNumber=$("#carNumber").val(); 
	var insuranceCompany=$("#insuranceCom").val(); 
	var insuranceBillNo=$("#insuranceBillNo").val(); 
	var startTime=$("#startTime").val(); 
	var endTime=$("#endTime").val(); 
	var amount=$("#amount").val(); 
	var noticeTime="";
	var mark=$("#mark").val(); 
	var driver=$('#driver').val();
	if(insuranceType==null || insuranceType==''){
		bootbox.alert('类型不能为空！');
		return;
	}
	if(insuranceCompany==''){
		bootbox.alert('保险公司不能为空！');
		return;
	}
	if(carNumber==''){
		bootbox.alert('装运车号不能为空！');
		return;
	}
	if(insuranceBillNo==''){
		bootbox.alert('保单号不能为空！');
		return;
	}
	if(startTime==''){
		bootbox.alert('保险开始时间不能为空！');
		return;
	}
	if(endTime==''){
		bootbox.alert('保险结束时间不能为空！');
		return;
	}
	if(amount==''){
		bootbox.alert('总金额不能为空！');
		return;
	}
	if(amount!=''&& isNaN(amount)){
		bootbox.alert('总金额请填写数字！');
		return;
	}
	 var objs=[];
	 var objList={};
	 var j=0;
	 if(type=='0'){
		 var detailList=$('.detailList').length;
		 for(var i=0;i<detailList;i++){
			 var objItem={};
			 var html=$('#detailList'+(i)+'').html();	
			 if(html!=''){
			 if($('#insuranceName'+i+'').val()==null || $('#insuranceName'+i+'').val()==''){
				 bootbox.alert('请输入第'+(j+1)+'个险种名称！');
				 return;
			 }else{
				 objItem.insuranceName=$('#insuranceName'+i+'').val();
			 }
			 if($('#amount'+i+'').val()==null || $('#amount'+i+'').val()==''){
				 bootbox.alert('请输入第'+(j+1)+'个险种金额！');
				 return;
			 }else if($('#amount'+i+'').val()!=''&&isNaN($('#amount'+i+'').val())){
					bootbox.alert('第'+(j+1)+'个险种金额请填写数字！');
					return;
			}else{
				 objItem.amount=$('#amount'+i+'').val();
			 }
			 objItem.mark=$('#mark'+i+'').val();
			j=j+1;
			 objs.push(objItem);
		 }
		 }
		  objList.detailList=objs;
	 }else{
		 objList.detailList=null;
	 }		 
	   objList.startTime=startTime;
	   objList.endTime=endTime;
	   objList.carNumber=carNumber;
	   objList.driver=driver;
	   objList.insuranceBillNo=insuranceBillNo;
	   objList.amount=amount;
	   objList.mark=mark;
	   objList.noticeTime=noticeTime; 
	   objList.type=type;
	   objList.insuranceCompany=insuranceCompany; 
	   objList.insuranceType=insuranceType;
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该保费信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackInsuranceMng/save',
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
//申请支付
function payAmount(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要支付保费?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'GET',
						url : '${ctx}/operationMng/trackInsuranceMng/zhiFu/'+id,
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "支付成功！", 
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
		});
}

//申请提交
function dosubmit(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该保费信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'GET',
						url : '${ctx}/operationMng/trackInsuranceMng/submit/'+id,
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
	$("#startTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#endTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	getStockList();//绑定货运车
	$('#type').change(function(){
		var type=$(this).children('option:selected').val();		
		 if($(this).val()=='0'){
			 $("#insurancecenter").show();
			 $("#detailListbtn").show();
			 $("#insuranceBillNo").attr("disabled",false);
     		  $("#startTime").attr("disabled",false);
     		  $("#endTime").attr("disabled",false);
		  }else{			  
			  $("#insurancecenter").hide(); 
			  $("#detailListbtn").hide();
			  //$("#driver").attr("disabled",true);
      		  $("#insuranceBillNo").attr("disabled",true);
      		  $("#startTime").attr("disabled",true);
      		  $("#endTime").attr("disabled",true);
		  }
	});
	  /* 根据货运车绑定驾驶员 */
	  $('#carNumber').on('change',function(e){
		  var type='0';
		  if(type=='0'){
			  if($(this).val()=='' || $(this).val()==null){
				  $('#driver').val('');
			  }else{
				  $('#driver').val($(this).find('option:selected').attr('data-driver'));
			  }
		  }else{
			 var  carNumber=$(this).val();
			 $.ajax({  
			        url: '${ctx}/operationMng/trackInsuranceMng/getInsuranceBean',  
			        type: "POST",  
			        contentType : "application/json;charset=UTF-8",
			        data : JSON.stringify({
			        	carNumber : $.trim(carNumber)	
					}),
					dataType : 'JSON',
			        success: function (data) {
			        	//var html ='<option value="" data-id="">请选择货运车</option>';
			            if(data.code == 200){  
			            	if(data.data!=null && data.data!=''){
			            		$('#driver').val(data.data.driver);
			            		$('#insuranceBillNo').val(data.data.insuranceBillNo);
			            		if(data.data.startTime!=''){
			            			$('#startTime').val(jsonForDateFormat(data.data.startTime));
			            		}else{
			            			$('#startTime').val('');
			            		} 			            			
			            			if(data.data.endTime!=''){
			            			$('#endTime').val(jsonForDateFormat(data.data.endTime));
			            		}else{
			            			$('#endTime').val('');
			            		}
			            		
			            	}else{
			            		$('#driver').val('');
			            		$('#insuranceBillNo').val('');
			            		$('#startTime').val('');
			            		$('#endTime').val('');
			            	}
			            	
			               }else{  
			            	   bootbox.alert('加载失败！');
			               }  
			        }  
			      });
		  }
		  
	  });
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackInsuranceMng/getDetail/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				$('#id-hidden').val(id);				
				$("#insuranceType").val(data.data.insuranceType);
				$("#carNumber").val(data.data.carNumber); 
				$("#driver").val(data.data.driver); 
				$("#insuranceBillNo").val(data.data.insuranceBillNo); 
				$("#insuranceCom").val(data.data.insuranceCompany); 
				/* if(data.data.noticeTime!=''&&data.data.noticeTime!=null){
					$("#noticeTime").val(jsonForDateFormat(data.data.noticeTime));
				}else{
					$("#noticeTime").val('');	
				} */if(data.data.startTime!=''&&data.data.startTime!=null){
					$("#startTime").val(jsonForDateFormat(data.data.startTime));
				}else{
					$("#startTime").val('');	
				}if(data.data.endTime!=''&&data.data.endTime!=null){
					$("#endTime").val(jsonForDateFormat(data.data.endTime));
				}else{
					$("#endTime").val('');	
				}				
				$("#amount").val(data.data.amount);
				$("#mark").val(data.data.mark);
				/* $("#type").attr("disabled",false); */
				$("#amount").attr("disabled",false);
				$("#mark").attr("disabled",false);
				$('#myModalLabel').html('编辑保单信息');	
				$('#modal-info').modal('show');
				$('#apply_add').show();
				$('#addBtn').hide();
				$('#editBtn').show();
				$('#viewBtn').hide();
				$('#insurancelist').hide();
				$('#insurancecenter').show();
				if(data.data.type=="1"){
					$("#insurancecenter").hide(); 
				}else if(data.data['detailList'].length>0){
					//$("#insurancecenter").remove();
					 $("#insurancecenter div.detailList").remove();	 
					var html="";
					for(var i=0;i<data.data['detailList'].length;i++){
						if(i==0){
							 html+='<div class="border-b-ff9a00 detailList" id="detailList'+i+'">'
						       +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title"><span class="red">*</span>险种名称:</label></div></div>'       
						       +'<div class="col-xs-8"><div class="form-contr"><input class="form-control" id="insuranceName'+i+'" value="'+data.data['detailList'][i]['insuranceName']+'" type="text" placeholder="请输入险种名称" /></div></div></div>'     
						       +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title"><span class="red">*</span>金额:</label></div></div>'
						       +'<div class="col-xs-8"><div class="form-contr"><input class="form-control" id="amount'+i+'" value="'+data.data['detailList'][i]['amount']+'" type="text" placeholder="请输入金额" /></div></div></div>'
						       +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title">备注:</label></div></div>'
						       +'<div class="col-xs-8"><div class="form-contr"><textarea rows="4" cols="4" class="form-control" id="mark'+i+'" value="'+data.data['detailList'][i]['mark']+'" placeholder="请输入备注"></textarea>'
						       +'</div></div></div></div>'; 
						}else{
							 html+='<div class="addclass border-b-ff9a00 detailList" id="detailList'+i+'">'
						       +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title"><span class="red">*</span>险种名称:</label></div></div>'       
						       +'<div class="col-xs-8"><div class="form-contr"><input class="form-control" id="insuranceName'+i+'" value="'+data.data['detailList'][i]['insuranceName']+'" type="text" placeholder="请输入险种名称" /></div></div></div>'     
						       +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title"><span class="red">*</span>金额:</label></div></div>'
						       +'<div class="col-xs-8"><div class="form-contr"><input class="form-control" id="amount'+i+'" value="'+data.data['detailList'][i]['amount']+'" type="text" placeholder="请输入金额" /></div></div></div>'
						       +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title">备注:</label></div></div>'
						       +'<div class="col-xs-8"><div class="form-contr"><textarea rows="4" cols="4" class="form-control" id="mark'+i+'" value="'+data.data['detailList'][i]['mark']+'" placeholder="请输入备注"></textarea>'
						       +'</div></div></div></div>';	
						}											      
					}
					 $('#insurancecenter').html(html);
				}
				
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
	var type='0'; 
	var insuranceType=$('#insuranceType').val();
	var carNumber=$("#carNumber").val(); 
	var insuranceCompany=$("#insuranceCom").val(); 
	var insuranceBillNo=$("#insuranceBillNo").val(); 
	var startTime=$("#startTime").val(); 
	var endTime=$("#endTime").val(); 
	var amount=$("#amount").val(); 
	var noticeTime="";
	var mark=$("#mark").val(); 
	var driver=$('#driver').val(); 	
	if(insuranceType==null || insuranceType==''){
		bootbox.alert('类型不能为空！');
		return;
	}
	if(insuranceCompany==''){
		bootbox.alert('保险公司不能为空！');
		return;
	}
	if(carNumber==''){
		bootbox.alert('装运车号不能为空！');
		return;
	}
	if(insuranceBillNo==''){
		bootbox.alert('保单号不能为空！');
		return;
	}
	if(startTime==''){
		bootbox.alert('保险开始时间不能为空！');
		return;
	}
	if(endTime==''){
		bootbox.alert('保险结束时间不能为空！');
		return;
	}
	if(amount==''){
		bootbox.alert('总金额不能为空！');
		return;
	}
	if(amount!=''&&isNaN(amount)){
		bootbox.alert('总金额请填写数字！');
		return;
	}
	 var objs=[];
	 var objList={};
	 if(type=='0'){
		 var detailList=$('.detailList').length;
		 for(var i=0;i<detailList;i++){
			 var objItem={};
			 if($('#insuranceName'+i+'').val()==null || $('#insuranceName'+i+'').val()==''){
				 bootbox.alert('请输入第'+(i+1)+'个险种名称！');
				 return;
			 }else{
				 objItem.insuranceName=$('#insuranceName'+i+'').val();
			 }
			 if($('#amount'+i+'').val()==null || $('#amount'+i+'').val()==''){
				 bootbox.alert('请输入第'+(i+1)+'个险种金额！');
				 return;
			 }else{
				 objItem.amount=$('#amount'+i+'').val();
			 }
			 objItem.mark=$('#mark'+i+'').val();
			
			 objs.push(objItem);
		 }
		  objList.detailList=objs;
	 }else{
		 objList.detailList=null;
	 }		 
	   objList.startTime=startTime;
	   objList.endTime=endTime;
	   objList.carNumber=carNumber;
	   objList.driver=driver;
	   objList.insuranceBillNo=insuranceBillNo;
	   objList.amount=amount;
	   objList.mark=mark;
	   objList.noticeTime=noticeTime; 
	   objList.type=type;
	   objList.id=id;
	   objList.insuranceCompany=insuranceCompany; 
	   objList.insuranceType=insuranceType;
	   bootbox.confirm({ 
			  size: "small",
			  message: "确定要更新该保费信息?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : '${ctx}/operationMng/trackInsuranceMng/update',
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
		  message: "确定要删除该保费信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/trackInsuranceMng/delete/"+id,
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
							}else{
								bootbox.alert(data.msg);
							}
						}
						
					}); 
			  }
		  }
	})
}
/* 查看 */
 function doview(id){
		$.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/trackInsuranceMng/getDetail/"+id,
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {	
					var insuranceType='';
					if(data.data.insuranceType=='0'){
						insuranceType='交强险';
					}else if(data.data.insuranceType=='1'){
						insuranceType='商业险';
					}else if(data.data.insuranceType=='2'){
						insuranceType='货运险';
					}else{
						insuranceType='';
					}
					$("#sinsuranceType").html(insuranceType);
					$("#sinsuranceCom").html(data.data.insuranceCompany); 
					$("#scarNumber").html(data.data.carNumber); 
					$("#sinsuranceBillNo").html(data.data.insuranceBillNo); 
					if(data.data.startTime!=''&& data.data.startTime!=null){
						$("#sstartTime").html(jsonForDateFormat(data.data.startTime));
					}else{
						$("#sstartTime").html('');	
					}if(data.data.endTime!=''&& data.data.endTime!=null){
						$("#sendTime").html(jsonForDateFormat(data.data.endTime));
					}else{
						$("#sendTime").html('');	
					}				
					$("#samount").html(data.data.amount);
					$("#smark").html(data.data.mark);
					if(data.data.invoiceAttachPath!=null && data.data.invoiceAttachPath!=''){
						$('#sinvoiceAttachPath').html('<a href="${ctx}/'+data.data.invoiceAttachPath+'" target="_blank">发票凭证</a>')
					}else{
						$('#sinvoiceAttachPath').html('')
					}
					if(data.data.insuranceBillPath!=null && data.data.insuranceBillPath!=''){
						$('#sinsuranceBillPath').html('<a href="${ctx}/'+data.data.insuranceBillPath+'" target="_blank">保单凭证</a>')
					}else{
						$('#sinsuranceBillPath').html('')
					}
					if(data.data.payLogPath!=null && data.data.payLogPath!=''){
						$('#spayLogPath').html('<a href="${ctx}/'+data.data.payLogPath+'" target="_blank">付款凭证</a>')
					}else{
						$('#spayLogPath').html('')
					}
					if(data.data['detailList'].length>0){
						for(var i=0;i<data.data.detailList.length;i++){
							data.data.detailList[i]["rownum"]=i+1;
						}
						$('#sinsurancedetailtable').dataTable({
							 dom: 'Bfrtip',
							 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
							 "bFilter": false,    //不使用过滤功能  
							 "bProcessing": true, //加载数据时显示正在加载信息	
							 "bPaginate" : false,
							 "bInfo" : false,
							 "ordering": false,
								"oLanguage": {
									"sZeroRecords": "抱歉， 没有找到",
									"sInfoEmpty": "没有数据",
									"sInfoFiltered": "(从 _MAX_ 条数据中检索)",							
									"sZeroRecords": "没有检索到数据"
									},	
							data: data.data.detailList,
					        //使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
					        //data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
					        columns: [	
					            { data: 'rownum' },
					            {data: "insuranceName"},
							    {data: "amount"},
							    {data: "mark"}]
						});
											 
					}
					$('#modal-einfo').modal('show');
					
				} else {
					bootbox.alert(data.msg);				
				}
			}
			
		}); 
} 
/* 查看关闭 */
 function showRefresh(){
	 $('#modal-einfo').modal('hide');
}
 /* 新增险种详细信息 */
 function addNewInsurance(){
	 var index=$('.detailList').length;
	   var html='<div class="addclass border-b-ff9a00 detailList" id="detailList'+index+'">'
       +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title"><span class="red">*</span>险种名称:</label></div></div>'       
       +'<div class="col-xs-8"><div class="form-contr"><input class="form-control" id="insuranceName'+index+'" type="text" placeholder="请输入险种名称" /></div></div></div>'     
       +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title"><span class="red">*</span>金额:</label></div></div>'
       +'<div class="col-xs-8"><div class="form-contr"><input class="form-control" id="amount'+index+'" type="text" placeholder="请输入金额" /></div></div></div>'
       +'<div class="row newrow"><div class="col-xs-3 pd-2"><div class="lab-tit"><label class="title">备注:</label></div></div>'
       +'<div class="col-xs-8"><div class="form-contr"><textarea rows="4" cols="4" class="form-control" id="mark'+index+'" placeholder="请输入备注"></textarea></div></div></div>'
       +'<div class="row newrow"><div class="col-xs-10"></div><div class="col-xs-2 pd-2"><div class="form-contr-1"> <a class="delete-detail fr" onclick="deletindex(this,'+index+');"><i class="icon-minus-sign" style="display: inline-block;width: 20px;"></i>删除</a></div></div></div>'
       +'</div>'; 
       $('#detailList'+(index-1)+'').after(html);
   
 }

 function dopayInsurance(){
	 clearpay();
	 //$('#mypayModalLabel').html('保单信息');	
		$('#modal-payInsurance').modal('show');
		$('#payaddBtn').show();
		$('#claimPayBtn').hide();
 }
 function clearpay(){	
		$('#payamount').val('');		
		$('#paymark').val('');		
 }
 
 function deletindex(e,index){
		//console.info(JSON.stringify(e));
		var html=$('#detailList'+(index)+'').html();
		//console.info(JSON.stringify(html));	
		$('#detailList'+(index)+'').removeClass("border-b-ff9a00");
		$('#detailList'+(index)+'').html('');
	}
 function savepay(){
	 var flag="false";
	 var payamount=$('#payamount').val();
	 var paymark=$('#paymark').val();
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该保费信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackInsuranceMng/payInsurance',
						data : JSON.stringify({
							amount: payamount,
							mark : paymark
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
											payclose();
											reload();
										  }else{
											payclose();
											reload();
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										payclose();
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
 /* 关闭窗体 */
 function payclose(){
 	$('#modal-payInsurance').modal('hide'); 	
 }
 function doclaimPay(id,insuranceNo){
	 clearpay();
	 $('#mypayModalLabel').html('索赔费用信息');	
		$('#modal-payInsurance').modal('show');
		$('#payaddBtn').hide();
		$('#claimPayBtn').show();
		$('#insuranceId_hiden').val(id);		
		$('#insuranceNo_hiden').val(insuranceNo);		
 }
 function saveclaimPay(){
	 var flag="false";
	 var payamount=$('#payamount').val();
	 var paymark=$('#paymark').val();
	 var insuranceId=$('#insuranceId_hiden').val();
	 var insuranceNo=$('#insuranceNo_hiden').val();
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该索赔费用信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackInsuranceMng/claimPay',
						data : JSON.stringify({
							insuranceNo :insuranceNo,
							insuranceId : insuranceId,
							amount: payamount,
							mark : paymark
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
											payclose();
											reload();
										  }else{
											payclose();
											reload();
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										payclose();
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
 function clearupload(){
		$('#detilid-hidden').val('');
		$('#invoiceAttachname').html('');
		$('#invoiceAttachPath_hidden').val('');
		$('#insuranceBillname').html('');
		$('#insuranceBillPath_hidden').val('');
		$('#payLogname').html('');
		$('#payLogPath_hidden').val('');
		/* $('#accidentReportname').html('');
		$('#accidentReportPath_hidden').val(''); */
	}
	/**附件上传**/
	function doupload(id,invoiceAttachPath,insuranceBillPath,payLogPath){
		clearupload();
		if(invoiceAttachPath==null || invoiceAttachPath=="null"){
			invoiceAttachPath="";
		}
		if(insuranceBillPath==null || insuranceBillPath=="null"){
			insuranceBillPath="";
		}
		if(payLogPath==null || payLogPath=="null"){
			payLogPath="";
		}
		$('#uploadBtn').show();
		$('#detilid-hidden').val(id);
		$('#invoiceAttachPath_hidden').val(invoiceAttachPath);
		$('#insuranceBillPath_hidden').val(insuranceBillPath);
		$('#payLogPath_hidden').val(payLogPath);
		/* $('#accidentReportPath_hidden').val(accidentReportPath); */		
		if(invoiceAttachPath!=''&&invoiceAttachPath!='null'){
			var invoiceAttachPaths="${ctx}"+invoiceAttachPath;
			var htmls='<a href='+invoiceAttachPaths+' target="_blank">发票附件</a>';
			$('#invoiceAttachname').html(htmls);
		}if(insuranceBillPath!=''&&insuranceBillPath!='null'){
			var insuranceBillPaths="${ctx}"+insuranceBillPath;
			var htmls='<a  href='+insuranceBillPaths+' target="_blank">保单附件</a>';
			$('#insuranceBillname').html(htmls);
		}if(payLogPath!=''&&payLogPath!='null'){
			var payLogPaths="${ctx}"+payLogPath;
			var htmls='<a  href='+payLogPaths+' target="_blank">付款记录附件</a>';
			$('#payLogname').html(htmls);
		}/* if(accidentReportPath!=''&&accidentReportPath!='null'){
			var accidentReportPaths="${ctx}"+accidentReportPath;
			var htmls='<a  href='+accidentReportPaths+' target="_blank">'+accidentReportPath+'</a>';
			$('#accidentReportname').html(htmls);
		} */
		$('#modal-upload').modal('show');
		$("#invoiceAttachfile").uploadify({
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
	        'uploader':'${ctx}/upload/saveFile?type=insurance',
	        /* //上传文件个数限制
	        'uploadLimit': 1, */
	        //上传按钮内容显示文本
	        'buttonText':'上传',
	        //单个文件上传成功触发
	        'onUploadSuccess':function(file, data, response){        	
	        	//刷新目录
	        	var orginFileName = JSON.parse(data).orginFileName;        		
	        	var attachFilePath = JSON.parse(data).attachFilePath;
	        	var attachFilePaths="${ctx}"+attachFilePath;
	        	//attachFilePath="${ctx}"+attachFilePath;
	        	//console.info(attachFilePath);
	        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
	        	$('#invoiceAttachname').html(html);
	        	$('#invoiceAttachname_hidden').val(orginFileName);
	        	$('#invoiceAttachPath_hidden').val(attachFilePath);
	        }
	    });
		$("#insuranceBillfile").uploadify({
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
	        'uploader':'${ctx}/upload/saveFile?type=insurance',
	        /* //上传文件个数限制
	        'uploadLimit': 1, */
	        //上传按钮内容显示文本
	        'buttonText':'上传',
	        //单个文件上传成功触发
	        'onUploadSuccess':function(file, data, response){        	
	        	//刷新目录
	        	var orginFileName = JSON.parse(data).orginFileName;        		
	        	var attachFilePath = JSON.parse(data).attachFilePath;
	        	var attachFilePaths="${ctx}"+attachFilePath;
	        	//attachFilePath="${ctx}"+attachFilePath;
	        	//console.info(attachFilePath);
	        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
	        	$('#insuranceBillname').html(html);
	        	$('#insuranceBillname_hidden').val(orginFileName);
	        	$('#insuranceBillPath_hidden').val(attachFilePath);
	        }
	    });
		$("#payLogfile").uploadify({
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
	        'uploader':'${ctx}/upload/saveFile?type=insurance',
	        /* //上传文件个数限制
	        'uploadLimit': 1, */
	        //上传按钮内容显示文本
	        'buttonText':'上传',
	        //单个文件上传成功触发
	        'onUploadSuccess':function(file, data, response){        	
	        	//刷新目录
	        	var orginFileName = JSON.parse(data).orginFileName;        		
	        	var attachFilePath = JSON.parse(data).attachFilePath;
	        	var attachFilePaths="${ctx}"+attachFilePath;
	        	//attachFilePath="${ctx}"+attachFilePath;
	        	//console.info(attachFilePath);
	        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
	        	$('#payLogname').html(html);
	        	$('#payLogname_hidden').val(orginFileName);
	        	$('#payLogPath_hidden').val(attachFilePath);
	        }
	    });
		
	}
	function uploadsave(){
		var flag="false";
		var id=$('#detilid-hidden').val();
		var invoiceAttachPath=$('#invoiceAttachPath_hidden').val();
		var insuranceBillPath=$('#insuranceBillPath_hidden').val();
		var payLogPath=$('#payLogPath_hidden').val();
		/* var accidentReportPath=$('#accidentReportPath_hidden').val(); */	
		if(invoiceAttachPath==null || invoiceAttachPath=="null"){
			invoiceAttachPath="";
		}
		if(insuranceBillPath==null || invoiceAttachPath=="null"){
			insuranceBillPath="";
		}
		if(payLogPath==null || invoiceAttachPath=="null"){
			payLogPath="";
		}
		if(invoiceAttachPath=='' && insuranceBillPath=='' && payLogPath==''){
			bootbox.alert('请上传附件！');	
			return;
		}else{
			bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存附件信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : '${ctx}/operationMng/trackInsuranceMng/updateFilePath',
							data : JSON.stringify({
								id : id,
								invoiceAttachPath : invoiceAttachPath,
								insuranceBillPath : insuranceBillPath,
								payLogPath : payLogPath
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
			
		}
	}
	function uploadrefresh(){
		$('#modal-upload').modal('hide');	
		
	}
	function dopayLog(){
		parent.addTabs({id:'999',title: '保费支付查询',close: true,url: '${ctx}/operationMng/trackInsuranceMng/payLog'});
		//{id:'18',title: '其他往来',close: true,url: '/HyLMS/operationMng/otherContactsMng/index'}
	}
	
	/* 打印功能 */
	function doprint(){
		   var date = new Date();
	       var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
	       var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
	       var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
	       var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
	       var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
	       var localTime= date.getFullYear() + "-" + month + "-" + day+ " " + hours + ":" + minutes + ":" + seconds;
		   var html="";
		   var startTime=$("#form_startTime").val(); 
		   var endTime=$("#form_endTime").val();  
		   var carNumber=$("#fom_carNumber").val();
		   var type='0';
		   var insuranceBillNo=$("#fom_insuranceBillNo").val();
		   var insuranceType=$("#form_insuranceType").val();
		   if(insuranceType=='' || insuranceType==null || insuranceType=='-1'){
			   insuranceType='';
		   }		   
		   $.ajax({
			    type : 'POST',
				url : "${ctx}/operationMng/trackInsuranceMng/getPrintData",
				data : JSON.stringify({
					carNumber : carNumber,
					insuranceBillNo : insuranceBillNo,
					startInTime : startTime,
					endInTime : endTime,
					insuranceType :insuranceType
				}),
				contentType : "application/json;charset=UTF-8",
				dataType : 'JSON',
				success : function(data) {
					if (data && data.code == 200) {					
						if(data.data.length>0){
							for(var i=0;i<data.data.length;i++){
								data.data[i]["rownum"]=i+1;
								if(data.data[i]["insuranceType"]=='0'){
									data.data[i]["insuranceType"]='交强险';
								}else if(data.data[i]["insuranceType"]=='1'){
									data.data[i]["insuranceType"]='商业险';
								}
								else if(data.data[i]["insuranceType"]=='2'){
									data.data[i]["insuranceType"]='货运险';
								}
								if(data.data[i]["status"]=='0'){
									data.data[i]["status"]='新建';
								}else if(data.data[i]["status"]=='1'){
									data.data[i]["status"]='已提交';
								}else{
									data.data[i]["status"]='已失效';
								}
								if(data.data[i]["startTime"]==null || data.data[i]["startTime"]=='' || parseInt(data.data[i]["startTime"])<0){
									data.data[i]["startTime"]=''; 
								 }else{
									 data.data[i]["startTime"]=jsonForDateFormat(data.data[i]["startTime"]);
								 }
								if(data.data[i]["endTime"]==null || data.data[i]["endTime"]=='' || parseInt(data.data[i]["endTime"])<0){
									data.data[i]["endTime"]=''; 
								 }else{
									 data.data[i]["endTime"]=jsonForDateFormat(data.data[i]["endTime"]);
								 }
								if(data.data[i]["noticeTime"]==null || data.data[i]["noticeTime"]=='' || parseInt(data.data[i]["noticeTime"])<0){
									data.data[i]["noticeTime"]=''; 
								 }else{
									 data.data[i]["noticeTime"]=jsonForDateFormat(data.data[i]["noticeTime"]);
								 }
								if(data.data[i]["insertTime"]==null || data.data[i]["insertTime"]=='' || parseInt(data.data[i]["insertTime"])<0){
									data.data[i]["insertTime"]=''; 
								 }else{
									 data.data[i]["insertTime"]=jsonDateFormat(data.data[i]["insertTime"]);
								 }
								if(data.data[i]["updateTime"]==null || data.data[i]["updateTime"]=='' || parseInt(data.data[i]["updateTime"])<0){
									data.data[i]["updateTime"]=''; 
								 }else{
									 data.data[i]["updateTime"]=jsonDateFormat(data.data[i]["updateTime"]);
								 }
								if(data.data[i]["insertUser"]=='' || data.data[i]["insertUser"]==null){
									data.data[i]["insertUser"]='';
								}if(data.data[i]["updateUser"]=='' || data.data[i]["updateUser"]==null){
									data.data[i]["updateUser"]='';
								}
									html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
								    +'<td>'+data.data[i]["insuranceType"]+'</td>'
								    +'<td>'+data.data[i]["carNumber"]+'</td>'
								    +'<td>'+data.data[i]["insuranceCompany"]+'</td>'
								    +'<td>'+data.data[i]["insuranceBillNo"]+'</td>'
								    +'<td>'+data.data[i]["startTime"]+'</td>'
								    +'<td>'+data.data[i]["endTime"]+'</td>'
								    +'<td>'+data.data[i]["amount"]+'</td>'								  
								    +'<td>'+data.data[i]["mark"]+'</td>'
								    +'<td>'+data.data[i]["insertTime"]+'</td>'
								    +'<td>'+data.data[i]["updateTime"]+'</td>'
								    +'<td>'+data.data[i]["status"]+'</td>'
								    +'</tr>';	
							      
							}
							$('#localTime').html(localTime);
							$('#myDataTable tbody').html(html);
						      doprintForm();
						}else{
							bootbox.alert('暂无可打印的数据！');
							return;
						}
						 
					} else {
						 bootbox.alert(data.msg);
					}
					
				}
			}); 
		  
		   
	}

	function doprintForm(){
			var html=$("#printTable").html();
			$('#breadcrumbs').hide();
			$('.page-content').hide();
			$('#printTable').show();
			$("#myDataTable").printTable({
			 header: "#headerInfo",
	         footer: "#footerInfo",
			 mode: "rowNumber",
			 pageSize: 23
		});
			 javasricpt:window.print();
			$('#breadcrumbs').show();
			$('.page-content').show();
			$('#printTable').hide();
			$("#printTable").html(html); 
		 }

	/* 导出 */
	function doexport()
	{
		   var startTime=$("#form_startTime").val(); 
		   var endTime=$("#form_endTime").val(); 
		   var carNumber=$("#fom_carNumber").val();
		   var type='0';
		   var insuranceType=$("#form_insuranceType").val();
		   var insuranceBillNo=$("#fom_insuranceBillNo").val();		   
		   var form = $('<form action="${ctx}/operationMng/trackInsuranceMng/export" method="post"></form>');
		   var carNumberInput = $('<input id="carNumber" name="carNumber" value="'+carNumber+'" type="hidden" />');
		   var insuranceBillNoInput = $('<input id="insuranceBillNo" name="insuranceBillNo" value="'+insuranceBillNo+'" type="hidden" />');		  
		   var insuranceTypeInput = $('<input id="insuranceType" name="insuranceType" value="'+insuranceType+'" type="hidden"  />');
		   var startTimeInput = $('<input id="startInTime" name="startInTime" value="'+startTime+'" type="hidden" />');
		   var endTimeInput = $('<input id="endInTime" name="endInTime" value="'+endTime+'" type="hidden" />');
		   form.append(carNumberInput);
		   form.append(insuranceBillNoInput);
		   form.append(insuranceTypeInput);
		   form.append(startTimeInput);
		   form.append(endTimeInput);
		   $('body').append(form);
		   form.submit();
	}
</script>



</body>
</html>






