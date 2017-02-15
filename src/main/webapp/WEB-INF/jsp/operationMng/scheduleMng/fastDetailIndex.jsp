 
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
	    <link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
		<!-- page specific plugin styles -->
		<!-- ace styles -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" />
		<!-- inline styles related to this page -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/staticPublic/themes/default/easyui.css"></link>
		<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
	</head>
<body class="white-bg">
	<div class="page-content">
		<div class="page-header">
			<h1>
				<small>
					查看快速调度详细信息
				</small>
			</h1>
		</div><!-- /.page-header -->
	  <div class="detailInfo p5">
	     <div class="rowInfo">
		        <label class="title"><span class="red">*</span>调度单号:</label>
		        <p class="form-control no-border" id="wayBillInfo" style="margin-right:0px;width:180px;"></p>
		        <label class="title"><span class="red">*</span>装运日期:</label>
		        <p class="form-control no-border" id="shipDate" style="margin-right:0px;width:147px;"></p>
			    <div class="clear"></div>
		   </div>
		   <div class="rowInfo">
		        <label class="title"><span class="red">*</span>装运车号:</label>
		        <p class="form-control no-border" id="shipCarNo" style="width:180px;margin-right:0px;"></p>
		        <label class="title"><span class="red">*</span>驾驶员:</label>
		        <p class="form-control no-border" id="shipDriver" style="width:100px;"></p>
		        <label class="title"><span class="red">*</span>联系电话:</label>
		        <p class="form-control no-border" id="shipMobile" style="width:120px;"></p>
			    <div class="clear"></div>
		   </div>
		   <div class="table-itemTit">调度明细</div>
		   <!-- 调度明细Grid------begin-->
	      <table class="easyui-datagrid" style="width:100%;height:auto;min-height:300px;" id="mytable"
			data-options="singleSelect:true">
			<thead>
				<tr>
					<th data-options="field:'type',width:80,align:'center',formatter:formatType">类型</th>
					<th data-options="field:'waybillNo',width:200,align:'center'">运单编号</th>
					<th data-options="field:'supplierName',width:200,align:'center'">供应商</th>
					<th data-options="field:'sendTime',width:100,align:'center'">托运日期</th>
					<th data-options="field:'arrivalTime',width:100,align:'center'">交车日期</th>
					<th data-options="field:'brandName',width:200,align:'center'">品牌—车型</th>
					<th data-options="field:'count',width:80,align:'center'">数量</th>
					<th data-options="field:'startProvince',width:100,align:'center'">始发省</th>
					<th data-options="field:'startAddress',width:100,align:'center'">始发地</th>
					<th data-options="field:'carShopName',width:200,align:'center'">收车单位</th>
					<th data-options="field:'money',width:100,align:'center'">金额</th>
					<th data-options="field:'mark',width:100,align:'center'">备注</th>
					<th data-options="field:'carShopId',width:100,hidden:'true'"></th>
					<th data-options="field:'vinList',width:100,hidden:'true'"></th>
				</tr>
			</thead>
			<tbody id="tbody">
				
			  </tbody>
	    </table>
	     <table class="tableSum" cellspacing="0" cellpadding="0" border="0">
	       <tbody>
	          <tr class="datagrid-row"><td style="text-indent: 32px;width:880px;">合计</td><td id="td2" style="text-align:center;width:80px;"><span id="numRed">0</span></td><td id="td2"></td></tr>
	       </tbody>
	      </table>
	     <!-- 调度明细Grid------end-->
	     <!-- 预付信息------begin-->
	     <div class="table-itemTit">预付信息</div>
	     <div class="rowInfo">
		        <label class="title2">预付日期:</label>
		        <p class="form-control no-border" id="preDate"></p>
		        <label class="title2">开户行:</label>
		        <p class="form-control no-border" id="prebank"></p>
		        <label class="title2">账号:</label>
		        <p class="form-control no-border" id="preAmount"></p>
		        <div class="clear"></div>
		   </div>
		   <div class="rowInfo">
		        <label class="title2">预付油卡号:</label>
		        <p class="form-control no-border" id="preOil"></p>
		        <label class="title2">预付油费:</label>
		        <p class="form-control no-border" id="preOilMoney"></p>
		        <label class="title2">预付现金:</label>
		        <p class="form-control no-border" id="preMoney"></p>
			    <div class="clear"></div>
		   </div>
		   <div class="row newrow butthide" style="border-bottom:0;border-top: 1px dotted #ddd;">
		       <div class="col-xs-5"></div>
		       <div class="col-xs-2">
			       <div class="form-contr">
			          <a class="backbtn" onclick="doback();"><i class="icon-undo" style="display: inline-block;width: 20px;"></i>返回</a>
			       </div>
		       </div>
		       <div class="col-xs-5"></div>
		     </div>
	     <!-- 预付信息------end-->
	     </div>
  </div>
<script src="${ctx}/staticPublic/js/jquery-2.0.3.min.js"></script>
<script src="${ctx}/staticPublic/js/easyUI/jquery.easyui.min.js"></script>
<script src="${ctx}/staticPublic/js/easyUI/easyui-lang-zh_CN.js"></script> 
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script> 
<script src="${ctx}/staticPublic/js/easyUI/keyCheckByCode.js"></script>
<script src="${ctx}/staticPublic/js/easyUI/rownumber-util.js"></script> 
<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
<script src="${ctx}/staticPublic/js/bootbox.min.js"></script>
<script src="${ctx}/staticPublic/js/jsonDataFormat.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="${ctx}/staticPublic/js/easyUI/setnumcolor.js"></script>
<script type="text/javascript">
  
	$(function(){
		$('.tableSum').css({'width': $('.datagrid-view').width()});
		$('#td1').css({'width': $('.datagrid-view').width()-660});
		openInfo();
		 var type='${type}'; /* type:0-快速调度审核；1-运营管理-调度管理；2-查询管理-调度管理 ;3-运营管理-已办调度;4-运营管理-快速调度修改申请;5-首页待办\在途管理-快速调度流程*/
		 if(type=='5'){					 
				$('.butthide').hide();
		  }else{
			  $('.butthide').show(); 
		  }
	});
	
	
	/* grid end */
	/* 添加类型 */
	function formatType(val,row,index){
		if(val=='-1'){
			return '';
		}if(val=='0'){
			return '商品车';
		}else if(val=='1'){
			return '配件';
		}else if(val=='2'){
			return '二手车';
		}else{
			return '';
		}
	}
	/*新增信息输入  end*/
	/* 打开操作 */
	function openInfo(){
		var scheduleBillNo='${scheduleBillNo}';
		var obj=[];
		var allAmount=0;
		$.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/scheduleMng/getScheduleDetailForFast/"+scheduleBillNo,
			data : '',
			dataType : 'JSON',
			success: function(data){
				if (data && data.code == 200){
					if(data.data!=null && data.data!=''){
						if(data.data.sendTime!=null&&data.data.sendTime!=''){
							$('#shipDate').html(jsonForDateFormat(data.data.sendTime));
						}else{
							$('#shipDate').html('');
						}
						
						$('#shipCarNo').html(data.data.carNumber);
						$('#shipDriver').html(data.data.driverName);
						$('#shipDriver').attr('data-id',data.data.driverId);
						$('#shipMobile').html(data.data.mobile);
						if(data.data.prepayTime!=null && data.data.prepayTime!=''){
							$('#preDate').html(jsonForDateFormat(data.data.prepayTime));
						}else{
							$('#preDate').html('');
						}
						$('#wayBillInfo').attr('data-id',data.data.id);
						$('#wayBillInfo').html(data.data.scheduleBillNo);
						$('#prebank').html(data.data.bankName);
						$('#preAmount').html(data.data.bankAccount);
						$('#preOil').html(data.data.oilCardNo);
						$('#preOilMoney').html(data.data.oilAmount);
						$('#preMoney').html(data.data.prepayCash);
						for(var i=0;i<data.data.detailList.length;i++){
							var objs=data.data.detailList[i];
							var objItem={};
							var vinListInfo='';
							var arrList=objs.vinList;
							if(arrList!=null && arrList!=''){
							  for(var k=0;k<arrList.length;k++){
								  if(arrList[k]==''){
									  vinListInfo+='N,'; 
								  }else{
									  vinListInfo+=arrList[k]+',';
								  }
							   }
							   vinListInfo=vinListInfo.substring(0,vinListInfo.length-1);
							}
							objItem.type=objs.type;
							objItem.supplierName=objs.supplierName;
							objItem.money=objs.money;
							objItem.startProvince=objs.startProvince;
							objItem.waybillNo=objs.waybillNo;
							if(objs.type == 2)//二手车
							{
								if(null != objs.waybillNo || "" != objs.waybillNo)
								{
									objItem.waybillNo = "";
								}
							}
							if(objs.sendTime!=''&&objs.sendTime!=null){
								objItem.sendTime=jsonForDateFormat(objs.sendTime);
							}else{
								objItem.sendTime='';
							}
							
							objItem.brandName=objs.brandName;
							/* if(objs.type=='2'){
								objItem.brandName=objs.brandName;
							}else{
								objItem.brandName=objs.brandName+'—'+objs.carStyle;
							} */
							
							objItem.count=objs.count;
							allAmount+=objs.count;
							if(objs.arrivalTime!=''&&objs.sendTime!=null){
								objItem.arrivalTime=jsonForDateFormat(objs.arrivalTime);
							}else{
								objItem.arrivalTime='';
							}
							
							objItem.startAddress=objs.startAddress;
							objItem.carShopName=objs.carShopName;
							objItem.carShopId=objs.carShopId;
							objItem.mark=objs.mark;
							objItem.id=objs.id;
							objItem.vinList=vinListInfo;
							obj.push(objItem);
						}
					}
					$('#numRed').html(allAmount);
					$('#mytable').datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
					$('#mytable').datagrid('loadData',{"total" : obj.length,"rows" :obj});
					for(var k=0;k<10-data.data.detailList.length;k++){
						$('#mytable').datagrid('appendRow',{
							type:'',
							waybillNo:'',
							arrivalTime:'',
							brandName: '',
							count: '',
							sendTime: '',
							startAddress: '',
							carShopName:'',
							mark:'',
							carShopId:'',
							vinList:''
	     					});
					}
					
					getrow('mytable');

				}else{
					$('#mytable').datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
					bootbox.alert(data.msg);
				}
			}
		});
	}
	 /* 返回*/
	   function doback(){
		 bootbox.confirm({ 
			  size: "small",
			  message: "确定要离开？", 
			  callback: function(result){
				  if(result){
					  var type='${type}'; /* type:0-快速调度审核；1-运营管理-调度管理；2-查询管理-调度管理 ;3-运营管理-已办调度;4-运营管理-快速调度修改申请;5-首页待办-快速调度流程*/
					  if(type=='0'){
						  location.href="${ctx}/operationMng/scheduleMng/changeApplyAuditIndex"; 
					  }else if(type=='1'){
						  location.href="${ctx}/operationMng/scheduleMng/index";
					  }else if(type=='2'){
						  location.href="${ctx}/operationMng/scheduleMng/adminiIndex";
					  }else if(type=='3'){
						  location.href="${ctx}/operationMng/scheduleMng/driverIndex";  
					  }else if(type=='4'){						 
						  location.href="${ctx}/operationMng/scheduleMng/changeApplyIndex";  
					  }
					  
				  }
				 
			  }
		 })
	 }
   </script> 
 </body>
</html>


