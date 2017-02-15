
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
			日常办公
			<small>
				<i class="icon-double-angle-right"></i>
				驾驶员报销申请管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="mng">
		   <div class="table-tit">查看驾驶员报销申请单</div>
		   <div class="table-item">
		     <div class="table-itemTit">基本信息</div>
		     <!-- 第一列 -->
		     <div class="row newrow">
			    <div class="col-xs-1 pd-2">
			         <div class="lab-tit">
			             <label>调度单号:</label>
			         </div>
		          </div>
		          <div class="col-xs-5">
				       <div class="form-contr">
				         <p class="form-control no-border" id="scheduleBillNo"></p>
				       </div>
			      </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>报账时间:</label>
				       </div>
			       </div>
				   <div class="col-xs-5">
				     <div class="form-contr">
				      <p class="form-control no-border" id="applyTime"></p>
				     </div>
				   </div>
		     </div>
		     <div class="row newrow">
			    <div class="col-xs-1 pd-2">
			         <div class="lab-tit">
			             <label>装运车号:</label>
			         </div>
		          </div>
		          <div class="col-xs-5">
				       <div class="form-contr">
				          <p class="form-control no-border" id="carNumber"></p>
				       </div>
			      </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>主驾驶员:</label>
				       </div>
			       </div>
				   <div class="col-xs-5">
				     <div class="form-contr">
				       <p class="form-control no-border" id="driver"></p>
				     </div>
				   </div>
		     </div>
		     <div class="row newrow">
			    <div class="col-xs-1 pd-2">
			         <div class="lab-tit">
			             <label>副驾驶员:</label>
			         </div>
		          </div>
		          <div class="col-xs-5">
				       <div class="form-contr">
				          <p class="form-control no-border" id="codriver"></p>
				       </div>
			      </div>
			       
		     </div>
		     <!--设置详细信息-->
		     <div class="table-itemTit">明细信息</div>
		     <!-- 第一条详细信息 -->
		    <div id="expandDetail">
		    <!-- 第三列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>品牌:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p class="form-control no-border" id="brandName"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>发车时间:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p class="form-control no-border" id="sendTime"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第四列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>交车时间:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			         <p class="form-control no-border" id="receiveTime"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>台数:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p class="form-control no-border" id="amount"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第五列 -->
		     <div class="row newrow bor-b-ff9a00-1">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>起运地:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			         <p class="form-control no-border" id="startAddress"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>目的地:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p class="form-control no-border" id="endAddress"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 油费 -->
		      <div class="row bor-b-ff9a00">
			        <label class="f-s14">里程油费核算</label>
		      </div>
		      <div class="row newrow bor-b-ff9a00-1">
		           <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>公里数:</label>
				       </div>
			        </div>
			       <div class="col-xs-2">
			           <div class="form-contr">
			              <p class="form-control no-border" id="distance"></p>
			           </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>指定油耗:</label>
				       </div>
			        </div>
			       <div class="col-xs-2">
			           <div class="form-contr">
			              <p class="form-control no-border" id="standardOilWear"></p>
			            </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>指定油价:</label>
				       </div>
			        </div>
			       <div class="col-xs-2">
			           <div class="form-contr">
			              <p class="form-control no-border" id="oilPrice"></p>
			            </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>油费:</label>
				       </div>
			        </div>
			       <div class="col-xs-2">
			       		<div class="form-contr">
			       		    <p class="form-control no-border" id="oilAmount"></p>
			           	</div>
			       </div>
		       </div>
		      </div>
		      <!-- 费用明细 -->
		      <div class="table-itemTit bor-t-ff9a00">费用明细</div>
		      <div class="catoList">
		          <div id="cataListItem">
		            
		          </div>
		          
			      
		       </div>
		       <!-- 是否折现 -->
		      <div class="row newrow bor-b-ff9a00-1">
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>是否折现:</label>
				       </div>
			        </div>
			       <div class="col-xs-2">
			           <div class="form-contr">
			              <p id="discountFlag" class="form-control no-border"></p>
			            </div>
			       </div>
			       <div class="col-xs-9"></div>
		      </div>
		      
		      
		      <!--预付信息-->
		     <div class="table-itemTit bor-t-ff9a00">预付信息</div>
		     <div id="prepayList">
		       
		     </div>
		      <!--费用小计信息-->
		     <div class="table-itemTit bor-b-ff9a00">费用小计</div> 
		     <div class="row newrow">
		           <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>报账现金(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="sumMoney"></p>
			           </div>
			       </div>
			       <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>报账油费(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="oilMoney"></p>
			           </div>
			       </div>
		      </div>
		      <div class="row newrow">
		           <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>预付现金(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="sumMoneyPre"></p>
			           </div>
			       </div>
			       <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>预付油费(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="oilMoneyPre"></p>
			           </div>
			       </div>
		      </div>
		      <div class="row newrow">
		           <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>应付现金(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="sumMoneyActual"></p>
			           </div>
			       </div>
			       <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>应付油费(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="oilMoneyActual"></p>
			           </div>
			       </div>
		      </div>
		      <div class="row newrow" id="discountMoneyInfo">
		           <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>折现后应付现金(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="sumMoneyDiscount"></p>
			           </div>
			       </div>
			       <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>折现后应付油费(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="oilMoneyDiscount"></p>
			           </div>
			       </div>
		      </div>
			  <div class="row newrow">
		           <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>实付现金(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="sumMoneyNew"></p>
			           </div>
			       </div>
			       <div class="col-xs-2 pd-2">
				       <div class="lab-tit">
				          <label>实付油费(元):</label>
				       </div>
			        </div>
			       <div class="col-xs-4">
			           <div class="form-contr">
			              <p class="form-control no-border" id="oilMoneyNew"></p>
			           </div>
			       </div>
		      </div>
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
  $(function(){
	 init();
  }); 
  function init(){
	  var id="${id}";
	  var html="";
	  var prepayHtml="";
	  $.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/transportCostMng/getDetail/"+id,
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					var preIds=data.data['prepayApplyIds'];
					$('#carNumber').html(data.data['carNumber']);
					$('#driver').html(data.data['driverName']);
					$('#codriver').html(data.data['codriverName']);
					$('#scheduleBillNo').html(data.data['scheduleBillNo']);
					$('#brandName').html(data.data['costList'][0]['brandName']);
					if(data.data['costList'][0]['sendTime']!=null&&data.data['costList'][0]['sendTime']!=''){
						$('#sendTime').html(jsonForDateFormat(data.data['costList'][0]['sendTime']));
					}else{
						$('#sendTime').html('');
					}
					if(data.data['costList'][0]['receiveTime']!=null&&data.data['costList'][0]['receiveTime']!=''){
						$('#receiveTime').html(jsonForDateFormat(data.data['costList'][0]['receiveTime']));
					}else{
						$('#receiveTime').html('');
					}
					$('#amount').html(data.data['costList'][0]['count']);
					$('#startAddress').html(data.data['costList'][0]['startAddress']);
					$('#endAddress').html(data.data['costList'][0]['endAddress']);
					if(data.data['applyTime']!=null&&data.data['applyTime']!=''){
						$('#applyTime').html(jsonForDateFormat(data.data['applyTime']));
					}else{
						$('#applyTime').html('');
					}
					$('#distance').html(data.data['distance']);
					$('#standardOilWear').html(data.data['standardOilWear']);
					$('#oilPrice').html(data.data['oilPrice']);
					$('#oilAmount').html(data.data['oilAmount']);
					var discountFlag=data.data['discountFlag'];
					if(discountFlag=='Y'){
						$('#discountFlag').html('是');
					}else{
						$('#discountFlag').html('否');
					}
					var sumMoneyActual=0,oilMoneyActual=0,localMonthMoney=0;
					var preMoneySum=0,preOilSum=0;
					if(data.data['prepayList']!=null && data.data['prepayList'].length>0){
						for(var k=0;k<data.data['prepayList'].length;k++){
							var oilAmount=data.data['prepayList'][k]['oilAmount'];
							if(oilAmount!=null && oilAmount!=''){
								preOilSum+=parseFloat(oilAmount);
							}else{
								oilAmount=0;
							}
							var prepayCash=data.data['prepayList'][k]['prepayCash'];
							if(prepayCash!=null && prepayCash!=''){
								preMoneySum+=parseFloat(prepayCash);
							}else{
								prepayCash=0;
							}
							prepayHtml+='<div class="row newrow bor-b-ff9a00-1"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付现金:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayCash'+k+'" class="form-control no-border">'+prepayCash+'</p></div></div>'
						          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付油费:</label></div></div>'
						          +'<div class="col-xs-5"><div class="form-contr"><p id="oilAmount'+k+'" class="form-control no-border">'+oilAmount+'</p></div></div>'
						          +'</div>';

						}
					}else{
						prepayHtml+='<div class="row newrow bor-b-ff9a00-1"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付现金:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="prepayCash'+k+'" class="form-control no-border"></p></div></div>'
					          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>预付油费:</label></div></div>'
					          +'<div class="col-xs-5"><div class="form-contr"><p id="oilAmount'+k+'" class="form-control no-border"></p></div></div>'
					          +'</div>';
					}
					$('#prepayList').html(prepayHtml);
					if(data.data['costList'][0]['cashList'].length>0){
						for(var i=0;i<data.data['costList'][0]['cashList'].length;i++){
							var obj=data.data['costList'][0]['cashList'];
							var attachFilePaths="";
							var partHtml="";
							if(obj[i].filePath!=null && obj[i].filePath!=''){
								attachFilePaths="${ctx}"+obj[i].filePath;
								partHtml='<a href='+attachFilePaths+' target="_blank">附件</a>';
							}
							if(obj[i].mark==null || obj[i].mark==''){
								obj[i].mark='';
							}
								html+='<div id="detailList'+i+'" class="detailList bor-b-ff9a00-1">'
			       			      +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>费用名称:</label></div></div>'
			       			      +'<div class="col-xs-2"><div class="form-contr"><p class="form-control no-border" id="titleName'+i+'">'+obj[i].name+'</p></div></div>'
			       			      +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>金额:</label></div></div>'
			       			      +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border" id="amount'+i+'">'+obj[i].amount+'</p></div></div>'
			       			      +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>备注:</label></div></div>'
			       			      +'<div class="col-xs-3"><div class="form-contr"><p class="form-control no-border" id="name'+i+'">'+obj[i].mark+'</p></div></div>'
			       			      +'<div class="col-xs-1"></div></div>'
			       			      +'<div class="row newrow bor-no"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>上传凭证:</label></div></div>'
			       			      +'<div class="col-xs-5"><div class="form-contr">'
			       			      +'<label class="title" id="filename'+i+'">'+partHtml+'</label>'
			       			      +'</div></div><div class="col-xs-6"></div></div></div>';
						}
					}
					$('#cataListItem').html(html);
					if(data.data['amount']!=''){
						sumMoneyActual=(parseFloat(data.data['amount'])-parseFloat(preMoneySum)).toFixed(2);
					}else{
						sumMoneyActual=(0-parseFloat(preMoneySum)).toFixed(2);
					}
					
					if(data.data['oilAmount']!=''){
						oilMoneyActual=(parseFloat(data.data['oilAmount'])-parseFloat(preOilSum)).toFixed(2);
					}else{
						oilMoneyActual=(0-parseFloat(preOilSum)).toFixed(2);
					}
					/* 费用小计 */
					$('#sumMoney').html(data.data['amount']);/* 报账现金 */
					$('#oilMoney').html(data.data['oilAmount']);/* 报账油费 */
					$('#sumMoneyPre').html(preMoneySum);/* 预付现金 */
					$('#oilMoneyPre').html(preOilSum);/* 预付油费 */
					$('#sumMoneyActual').html(sumMoneyActual);/* 应付现金 */
					$('#oilMoneyActual').html(oilMoneyActual);/* 应付油费 */
					if(data.data['discountFlag']=='Y'){
						$('#discountMoneyInfo').show();
						$('#sumMoneyDiscount').html(data.data['discountTotalAmount']);/* 折现应付现金 */
						$('#oilMoneyDiscount').html(data.data['discountTotalOilAmount']);/* 折现应付油费 */
					}else{
						$('#discountMoneyInfo').hide();
						$('#sumMoneyDiscount').html('');/* 折现应付现金 */
						$('#oilMoneyDiscount').html('');/* 折现应付油费 */
					}
					if(data.data['balanceCash']!='' && data.data['balanceCashNextMonth']!=''){
						localMonthMoney=(parseFloat(data.data['balanceCash'])-parseFloat(data.data['balanceCashNextMonth'])).toFixed(2);
					}else if(data.data['balanceCash']=='' && data.data['balanceCashNextMonth']!=''){
						localMonthMoney=(0-parseFloat(data.data['balanceCashNextMonth'])).toFixed(2);
					}else if(data.data['balanceCash']!='' && data.data['balanceCashNextMonth']==''){
						localMonthMoney=(parseFloat(data.data['balanceCash'])-0).toFixed(2);
					}
					$('#sumMoneyNew').html('当月实付：'+localMonthMoney+'+下月实付：'+data.data['balanceCashNextMonth']+'='+data.data['balanceCash']);/* 实付现金 */
					$('#oilMoneyNew').html(data.data['balanceOil']);/* 实付油费 */
					
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		}); 
  }
 /* 返回驾驶员报销申请列表 */
 function doback(){
	 var flag='${type}';/* flag-0  运营管理-驾驶员报销；flag-1  查询管理-驾驶员报销查询 */
	 if(flag=='0'){
		 bootbox.confirm({ 
			  size: "small",
			  message: "确定要离开？", 
			  callback: function(result){
				  if(result){
					  location.href="${ctx}/operationMng/transportCostMng/officeIndex";
				  }
			  }
		 }); 
	 }else if(flag=='1'){
		 bootbox.confirm({ 
			  size: "small",
			  message: "确定要离开？", 
			  callback: function(result){
				  if(result){
					  location.href="${ctx}/operationMng/transportCostMng/financeIndex";
				  }
			  }
		 }); 
	 }
	
 }
</script>

</body>
</html>






