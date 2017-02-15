
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
#mynewDataTable.another{
border: 0px;
}
 .middletitle{
 font-size:13px;
 } 
 .prepayList{
 margin-top:20px;
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
				调度管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content" style="padding-left:12px;">
		<div class="mng">
		<input type="hidden" id="types" />
		   <div class="table-tit">查看调度单<!-- <i class="icon-undo" style="display: inline-block;width: 20px;"></i> --></div>
		   <div class="table-item">
		       <div class="table-itemTit">
		        <div class="col-xs-2 pd-2">
			       <div class="row-tit">
			                         基本信息
			       </div>
		       </div>
		       <div class="col-xs-10" style=" text-align: right;margin-top:3px;"><a class="table-edit" onclick="doprint();" style=" width: 80px;">打印</a></div>    
		     </div>
		     <!-- 第一列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label class="middletitle">装运日期:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="sendTime" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label class="middletitle">交车日期:</label>
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
			          <label class="middletitle">台数:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			         <p id="all-amount" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label class="middletitle">装运车号:</label>
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
				          <label class="middletitle">驾驶员:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <p id="driver" class="form-control no-border"></p>
				       </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label class="middletitle">联系电话:</label>
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
			          <label class="middletitle">备注:</label>
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
		       <div class="col-xs-10" style=" text-align: right;margin-top:3px;"></div>
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
<!-- 打印 -->
<div class="printTable" id="printTable" style="display:none">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>调度单信息</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="mynewDataTable" style="border: 0px;">		  
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
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
  $(function(){
	  var scheduleBillNos="${scheduleBillNo}";
	 //console.info(scheduleBillNos);
	  var scheduleBillNo=scheduleBillNos.split('@')[0];
	  var types=scheduleBillNos.split('@')[1];
		$('#types').val(types);
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
						//console.info(JSON.stringify(data.data));
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
								prepayHtml+='<div class="border-b-ff9a00"><div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label class="middletitle">预付现金:</label></div></div>'
							          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayCash'+k+'" class="form-control no-border">'+prepayCash+'</p></div></div>'
							          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label class="middletitle">开户行:</label></div></div>'
							          +'<div class="col-xs-5"><div class="form-contr"><p id="bankName'+k+'" class="form-control no-border">'+bankName+'</p></div></div></div>'
							          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label class="middletitle">账号:</label></div></div>'
							          +'<div class="col-xs-5"><div class="form-contr"><p id="bankAccount'+k+'" class="form-control no-border">'+bankAccount+'</p></div></div>'
							          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label class="middletitle">预付油卡卡号:</label></div></div>'
							          +'<div class="col-xs-5"><div class="form-contr"><p id="oilCardNo'+k+'" class="form-control no-border">'+oilCardNo+'</p></div></div></div>'
							          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label class="middletitle">预付油费:</label></div></div>'
							          +'<div class="col-xs-5"><div class="form-contr"><p id="oilAmount'+k+'" class="form-control no-border">'+oilAmount+'</p></div></div>'
							          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label class="middletitle">预付状态:</label></div></div>'
							          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayStatus'+k+'" class="form-control no-border">'+status+'</p></div></div></div></div>';
							}
						}else{
							prepayHtml='<div class="border-b-ff9a00"><div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label class="middletitle">预付现金:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayCash" class="form-control no-border"></p></div></div>'
						          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label class="middletitle">开户行:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="bankName" class="form-control no-border"></p></div></div></div>'
						          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label class="middletitle">账号:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="bankAccount" class="form-control no-border"></p></div></div>'
						          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label class="middletitle">预付油卡卡号:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="oilCardNo" class="form-control no-border"></p></div></div></div>'
						          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label class="middletitle">预付油费:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="oilAmount" class="form-control no-border"></p></div></div>'
						          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label class="middletitle">预付状态:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayStatus" class="form-control no-border"></p></div></div></div></div>';
						}
						$('#prepayList').html(prepayHtml);
						$('#mobile').html(data.data['mobile']);
						if(data.data['detailList'].length>0){
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
				
			}); 
  });
  
  /* 返回*/
   function doback(){
	  var types=$("#types").val(); 
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要离开？", 
		  callback: function(result){
			  if(result){
				  /* if(types=='store'){
					  location.href="${ctx}/operationMng/scheduleMng/storeIndex";
				  }else{
					  location.href="${ctx}/operationMng/scheduleMng/driverIndex";  
				  } */
				  location.href="${ctx}/operationMng/scheduleMng/driverIndex";  
			  }
			 
		  }
	 })
 }
  
  function doprint(){
	  var scheduleBillNos="${scheduleBillNo}";
		 // console.info(scheduleBillNos);
	  var scheduleBillNo=scheduleBillNos.split('@')[0];
	  var html="";
	  var carHtml="";
	  var carAttachmentHtml="";
	  var detailListHtml="";
	  var _tr="";
	  var prepayHtml="";
	  $.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/scheduleMng/getDetailData/"+scheduleBillNo,
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.info(data.data['detailList'].length);
					if(data.data['sendTime']!=''&&data.data['sendTime']!=null){
						$('#sendTime').html(jsonForDateFormat(data.data['sendTime']));
						data.data['sendTime']=jsonForDateFormat(data.data['sendTime'])
					}else{
						$('#sendTime').html('');
						data.data['sendTime']="";
					}
					if(data.data['receiveTime']!=''&&data.data['receiveTime']!=null){
						data.data['receiveTime']=jsonForDateFormat(data.data['receiveTime']);
					}else{
						data.data['receiveTime']="";
					}
					if(data.data['planReachTime']!=''&&data.data['planReachTime']!=null){
						data.data['planReachTime']=jsonForDateFormat(data.data['planReachTime']);
					}else{
						data.data['planReachTime']="";
					} 
					if(data.data['mobile']==''||data.data['mobile']==null){
						data.data['mobile']='';
					} 
					
					 prepayHtml='<div class="row"><div class="add-item col-xs-12"><label class="title col-xs-2 middletitle">装运日期：</label><label class="title col-xs-4 middletitle">'+data.data['sendTime']+'</label>'
					+'<label class="title col-xs-2 middletitle">交车日期：</label><label class="title col-xs-4 middletitle">'+data.data['receiveTime']+'</label></div>'
					+'<div class="add-item col-xs-12"><label class="title col-xs-2 middletitle">台数：</label><label class="title col-xs-4 middletitle">'+data.data['amount']+'</label>'
					+'<label class="title col-xs-2 middletitle">装运车号：</label><label class="title col-xs-4 middletitle">'+data.data['carNumber']+'</label></div>'					
					+'<div class="add-item col-xs-12"><label class="title col-xs-2 middletitle">驾驶员：</label><label class="title col-xs-4 middletitle">'+data.data['driver']+'</label>'
					+'<label class="title col-xs-2 middletitle">联系电话：</label><label class="title col-xs-4 middletitle">'+data.data['mobile']+'</label></div>'
					+'<div class="add-item col-xs-12"><label class="title col-xs-2 middletitle">备注：</label><label class="title col-xs-10 middletitle">'+data.data['mark']+'</label>'
					+'</div></div>'
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
							prepayHtml+='<div class="prepayList"><div class="row"><div class="col-xs-2 pd-2"><div class="lab-tit"><label class="title middletitle">预付现金:</label></div></div>'
						          +'<div class="col-xs-4"><div class="form-contr"><p id="prepayCash'+k+'" class="form-control no-border">'+prepayCash+'</p></div></div>'
						          +'<div class="col-xs-2 pd-2"><div class="lab-tit"><label class="title middletitle">开户行:</label></div></div>'
						          +'<div class="col-xs-4"><div class="form-contr"><p id="bankName'+k+'" class="form-control no-border">'+bankName+'</p></div></div></div>'
						          +'<div class="row "><div class="col-xs-2 pd-2"><div class="lab-tit"><label class="title middletitle">账号:</label></div></div>'
						          +'<div class="col-xs-4"><div class="form-contr"><p id="bankAccount'+k+'" class="form-control no-border">'+bankAccount+'</p></div></div>'
						          +'<div class="col-xs-2 pd-2"><div class="lab-tit"><label class="title middletitle">预付油卡卡号:</label></div></div>'
						          +'<div class="col-xs-4"><div class="form-contr"><p id="oilCardNo'+k+'" class="form-control no-border">'+oilCardNo+'</p></div></div></div>'
						          +'<div class="row "><div class="col-xs-2 pd-2"><div class="lab-tit"><label class="title middletitle">预付油费:</label></div></div>'
						          +'<div class="col-xs-4"><div class="form-contr"><p id="oilAmount'+k+'" class="form-control no-border">'+oilAmount+'</p></div></div>'
						          +'<div class="col-xs-2 pd-2"><div class="lab-tit"><label class="title middletitle">预付状态:</label></div></div>'
						          +'<div class="col-xs-4"><div class="form-contr"><p id="prepayStatus'+k+'" class="form-control no-border">'+status+'</p></div></div></div></div>';
						}
					}else{
						prepayHtml+='<div class="prepayList"><div class="row "><div class="col-xs-2 pd-2"><div class="lab-tit"><label class="title middletitle">预付现金:</label></div></div>'
					          +'<div class="col-xs-4"><div class="form-contr"><p id="prepayCash" class="form-control no-border"></p></div></div>'
					          +'<div class="col-xs-2 pd-2"><div class="lab-tit"><label class="title middletitle">开户行:</label></div></div>'
					          +'<div class="col-xs-4"><div class="form-contr"><p id="bankName" class="form-control no-border"></p></div></div></div>'
					          +'<div class="row "><div class="col-xs-2 pd-2"><div class="lab-tit"><label class="title middletitle">账号:</label></div></div>'
					          +'<div class="col-xs-4"><div class="form-contr"><p id="bankAccount" class="form-control no-border"></p></div></div>'
					          +'<div class="col-xs-2 pd-2"><div class="lab-tit"><label class="title middletitle">预付油卡卡号:</label></div></div>'
					          +'<div class="col-xs-4"><div class="form-contr"><p id="oilCardNo" class="form-control no-border"></p></div></div></div>'
					          +'<div class="row "><div class="col-xs-2 pd-2"><div class="lab-tit"><label class="title middletitle">预付油费:</label></div></div>'
					          +'<div class="col-xs-4"><div class="form-contr"><p id="oilAmount" class="form-control no-border"></p></div></div>'
					          +'<div class="col-xs-2 pd-2"><div class="lab-tit"><label class="title middletitle">预付状态:</label></div></div>'
					          +'<div class="col-xs-4"><div class="form-contr"><p id="prepayStatus" class="form-control no-border"></p></div></div></div></div>';
					}
					_tr += "<tr><td style='border: 0px;'>"+prepayHtml +"</td></tr>";	
					if(data.data['detailList'].length>0){
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
										carHtmlItem+='<div class="row" ><div class="col-xs-2" style="border: 1px solid #000; border-top:0px;text-align: left;"><label class="titleprints">'+carInfo[j]['vin']+'</label></div><div class="col-xs-1" style="border: 1px solid #000; border-top:0px; border-left:0px;text-align: left;"><label class="titleprints">'+carInfo[j]['model']+'</label></div>'
										   +'<div class="col-xs-1" style="border: 1px solid #000; border-top:0px; border-left:0px;text-align: left;"><label class="titleprints">'+carInfo[j]['color']+'</label></div><div class="col-xs-3" style="border: 1px solid #000; border-top:0px; border-left:0px;text-align: left;"><label class="titleprints">'+jsonDateFormat(carInfo[j]['insertTime'])+'</label></div>'
										   +'<div class="col-xs-2" style="border: 1px solid #000; border-top:0px; border-left:0px;text-align: left;"><label class="titleprints">'+carInfo[j]['waybillNo']+'</label></div><div class="col-xs-2" style="border: 1px solid #000; border-top:0px; border-left:0px;text-align: left;"><label class="titleprints">'+carShopName+'</label></div>'
										   +'<div class="col-xs-1" style="border: 1px solid #000; border-top:0px; border-left:0px;text-align: left;"><label class="titleprints">'+carInfo[j]['brand']+'</label></div></div>';
									}else{
										carHtmlItem+='<div class="row"><div class="col-xs-2" style="border: 1px solid #000; border-top:0px;text-align: left;"><label class="titleprints">'+carInfo[j]['vin']+'</label></div><div class="col-xs-1" style="border: 1px solid #000; border-top:0px; border-left:0px;text-align: left;"><label class="titleprints">'+carInfo[j]['model']+'</label></div>'
										   +'<div class="col-xs-1" style="border: 1px solid #000; border-top:0px; border-left:0px;text-align: left;"><label class="titleprints">'+carInfo[j]['color']+'</label></div><div class="col-xs-3" style="border: 1px solid #000; border-top:0px; border-left:0px;text-align: left;"><label class="titleprints">'+jsonDateFormat(carInfo[j]['insertTime'])+'</label></div>'
										   +'<div class="col-xs-2" style="border: 1px solid #000; border-top:0px; border-left:0px;text-align: left;"><label class="titleprints">'+carInfo[j]['waybillNo']+'</label></div><div class="col-xs-2" style="border: 1px solid #000; border-top:0px; border-left:0px;text-align: left;"><label class="titleprints">二手车</label></div>'
										   +'<div class="col-xs-1" style="border: 1px solid #000; border-top:0px; border-left:0px;text-align: left;"><label class="titleprints">'+carInfo[j]['brand']+'</label></div></div>';
									}
									
								}
								carHtml='<div class="carLists">'
							        +'<div class="row"><div class="col-xs-2" style="border: 1px solid #000;"><label class="title">车架号</label></div><div class="col-xs-1" style="border: 1px solid #000; border-left:0px"><label class="title">车型</label></div><div class="col-xs-1" style="border: 1px solid #000;border-left:0px"><label class="title">颜色</label></div><div class="col-xs-3" style="border: 1px solid #000;border-left:0px"><label class="title" >入库时间</label></div><div class="col-xs-2" style="border: 1px solid #000;border-left:0px"><label class="title" ><label class="title">运单编号</label></div><div class="col-xs-2" style="border: 1px solid #000;border-left:0px"><label class="title">经销单位</label></div><div class="col-xs-1" style="border: 1px solid #000;border-left:0px"><label class="title">品牌</label></div></div>'
							        +carHtmlItem+'</div>'; 
							}else{
								carHtmlItem='<div class="row" ><label class="title col-xs-2">暂无车辆信息</label></div>'
								carHtml='<div class="carLists">'
									 +'<div class="row"><div class="col-xs-2" style="border: 1px solid #000;"><label class="title">车架号</label></div><div class="col-xs-1" style="border: 1px solid #000; border-left:0px"><label class="title">车型</label></div><div class="col-xs-1" style="border: 1px solid #000;border-left:0px"><label class="title">颜色</label></div><div class="col-xs-3" style="border: 1px solid #000;border-left:0px"><label class="title" >入库时间</label></div><div class="col-xs-2" style="border: 1px solid #000;border-left:0px"><label class="title" ><label class="title">运单编号</label></div><div class="col-xs-2" style="border: 1px solid #000;border-left:0px"><label class="title">经销单位</label></div><div class="col-xs-1" style="border: 1px solid #000;border-left:0px"><label class="title">品牌</label></div></div>'
									 +carHtmlItem+'</div>';
							}
							/* 配件信息 */
							if(carAttachmentInfo!=null && carAttachmentInfo.length>0){
								for(var k=0;k<carAttachmentInfo.length>0;k++){
									carAttachmentHtmlItem+='<div class="row"><div class="col-xs-3" style="border: 1px solid #000; border-top:0px"><label class="titleprints">'+carAttachmentInfo[k]['attachmentName']+'</label></div>'
										   +'<div class="col-xs-3" style="border: 1px solid #000; border-top:0px; border-left:0px;"><label class="titleprints">'+carAttachmentInfo[k]['position']+'</label></div>'
										   +'<div class="col-xs-3" style="border: 1px solid #000; border-top:0px; border-left:0px;"><label class="titleprints">'+carAttachmentInfo[k]['count']+'</label></div>'
										   +'<div class="col-xs-3" style="border: 1px solid #000; border-top:0px; border-left:0px;"><label class="titleprints">'+carAttachmentInfo[k]['outCount']+'</label></div></div>';
									
								}
							}else{
								carAttachmentHtmlItem='<div class="row" ><div class="col-xs-2" ><label class="title">暂无配件信息</label></div></div>'
							}
							carAttachmentHtml='<div class="carLists">'
						        +'<div class="row"><div class="col-xs-3" style="border: 1px solid #000;"><label class="title">配件</label></div><div class="col-xs-3" style="border: 1px solid #000; border-left:0px"><label class="title">位置</label></div><div class="col-xs-3" style="border: 1px solid #000; border-left:0px"><label class="title">库存</label></div><div class="col-xs-3" style="border: 1px solid #000; border-left:0px"><label class="title">出库数</label></div></div>'
						       +carAttachmentHtmlItem+'</div>'; 
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
								detailListHtml='<div class="detailList" id="detailList'+i+'">'
									  +'<div class="add-item col-xs-12"><label class="title col-xs-2">经销单位:</label>'
						              +'<div class="col-xs-2"><p class="title">'+data.data['detailList'][i]['carShopName']+'</p></div>'
						              +'<div class="col-xs-2"><label class="title">数量:</label></div>'
						              +'<div class="col-xs-2"><p class="title">'+data.data['detailList'][i]['amount']+'</p></div>'
						              +'<div class="col-xs-2"><label class="title">详细指令:</label></div>'
						              +'<div class="col-xs-2"><p class="title">'+data.data['detailList'][i]['mark']+'</p></div></div>'
						              +'<div class="add-item col-xs-12"><label class="title col-xs-2">始发地:</label>'
						              +'<div class="col-xs-2"><p class="title">'+startAddress+'</p></div>'
						              +'<div class="col-xs-2"><label class="title">目的省:</label></div>'
						              +'<div class="col-xs-2"><p class="title">'+targetProvince+'</p></div>'
						              +'<div class="col-xs-2"><label class="title">目的地:</label></div>'
						              +'<div class="col-xs-2"><p class="title">'+targetCity+'</p></div></div>'
						              +'<div class="add-item col-xs-12"><div class="col-xs-2 pd-2"><div class="lab-tit"><label>车辆信息:</label></div></div></div>'
						              +'<div class="col-xs-12"><div class="newCarDetail-item">'+carHtml+'</div></div>'
						              +'<div class="add-item col-xs-12"><div class="col-xs-2 pd-2"><div class="lab-tit"><label>配件信息:</label></div></div></div>'
						              +'<div class="col-xs-12"><div class="newPartDetail-item">'+carAttachmentHtml+'</div></div></div>';
							}else{
								detailListHtml='<div class="detailList" id="detailList'+i+'">'
								 +'<div class="add-item col-xs-12"><label class="title col-xs-2">经销单位:</label>'
								 +'<div class="col-xs-2"><p class="title">二手车</p></div>'
					              +'<div class="col-xs-2"><label class="title">数量:</label></div>'
					              +'<div class="col-xs-2"><p class="title">'+data.data['detailList'][i]['amount']+'</p></div>'
					              +'<div class="col-xs-2"><label class="title">详细指令:</label></div>'
					              +'<div class="add-item col-xs-12"><label class="title col-xs-2">始发地:</label>'
					              +'<div class="col-xs-2"><p class="title">'+startAddress+'</p></div>'
					              +'<div class="col-xs-2"><label class="title">目的省:</label></div>'
					              +'<div class="col-xs-2"><p class="title">'+targetProvince+'</p></div>'
					              +'<div class="col-xs-2"><label class="title">目的地:</label></div>'
					              +'<div class="col-xs-2"><p class="title">'+targetCity+'</p></div></div>'
					              +'<div class="col-xs-2"><p class="title">'+data.data['detailList'][i]['mark']+'</p></div></div>'
					              +'<div class="add-item col-xs-12"><div class="col-xs-2 pd-2"><div class="lab-tit"><label>车辆信息:</label></div></div></div>'
					              +'<div class="col-xs-12"><div class="newCarDetail-item">'+carHtml+'</div></div>'
					              +'<div class="add-item col-xs-12"><div class="col-xs-2 pd-2"><div class="lab-tit"><label>配件信息:</label></div></div></div>'
					              +'<div class="col-xs-12"><div class="newPartDetail-item">'+carAttachmentHtml+'</div></div></div>';
							}
							_tr += "<tr><td style='border: 0px;'>"+detailListHtml +"</td></tr>";	
						}

					}else{
						_tr+='<tr><td style="border: 0px;"><div class="detailList" id="detailList0"><div class="row newrow"><div class="col-xs-12"><p class="form-control no-border t-c">没有详细信息！</p></div></div></td></tr>';
					}
					//console.info(JSON.stringify(_tr));
					//html=detailListHtml;
					$("#mynewDataTable tbody").html(_tr); 
					//$('#carDetail').after(html);
					  doprintForm();
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
  		$("#mynewDataTable").addClass("another");
  		 $("#mynewDataTable").printTable({
  		 header: "#headerInfo",
          footer: "#footerInfo", 
  		 mode: "rowNumber",
  		 pageSize: 1
  	}); 
  		
  	     javasricpt:window.print();
  		$('#breadcrumbs').show();
  		$('.page-content').show();
  		$('#printTable').hide();
  		$("#printTable").html(html);    
  	 }
</script>

</body>
</html>






