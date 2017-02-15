
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
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
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
		   <div class="table-tit">编辑驾驶员报销申请单</div>
		   <div class="table-item">
		     <div class="table-itemTit">基本信息</div>
		     <!-- 第一列 -->
		     <div class="row newrow">
			    <div class="col-xs-1 pd-2">
			         <div class="lab-tit">
			             <label><span class="red">*</span>调度单号:</label>
			         </div>
		          </div>
		          <div class="col-xs-5">
				       <div class="form-contr">
				          <input class="form-control" id="scheduleBillNo" disabled="disabled" type="text" placeholder="请输入调度单" />
				          <!-- <select class="form-control" id="scheduleBillNo" onchange="chooseSch(this);">
				          </select> -->
				       </div>
			      </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label><span class="red">*</span>报账时间:</label>
				       </div>
			       </div>
				   <div class="col-xs-5">
				     <div class="form-contr">
				      <input class="form-control" id="applyTime" disabled="disabled" type="text" placeholder="请输入报账日期" />
				     </div>
				   </div>
		     </div>
		     <div class="row newrow">
			    <div class="col-xs-1 pd-2">
			         <div class="lab-tit">
			             <label><span class="red">*</span>装运车号:</label>
			         </div>
		          </div>
		          <div class="col-xs-5">
				       <div class="form-contr">
				         <input class="form-control" id="carNumber" disabled="disabled" type="text" placeholder="装运车号" />
				       </div>
			      </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label><span class="red">*</span>驾驶员:</label>
				       </div>
			       </div>
				   <div class="col-xs-5">
				     <div class="form-contr">
				      <input class="form-control" id="driver" disabled="disabled" type="text" placeholder="驾驶员" />
				      <input class="form-control" id="driver_id" disabled="disabled" type="hidden" />
				     </div>
				   </div>
		     </div>
		     <!--设置详细信息-->
		     <div class="row row-btn-tit bor-dcd9d9">
		        <div class="col-xs-2 pd-2">
			       <div class="row-tit">
			                           明细信息
			       </div>
		       </div>
		       <div class="col-xs-7"></div>
		       <div class="col-xs-3">
				  <div class="form-contr-1">
				     <a class="form-btn-1 fr" data-flag="N" onclick="expandinfo(this);">展开</a>
				  </div>
			   </div>
		     </div>
		     <!-- 第一条详细信息 -->
		    <!-- 第三列 -->
		    <div id="expandDetail" style="display:none;">
		         <div class="row newrow">
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>品牌:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <input class="form-control" id="brandName" disabled="disabled" type="text" placeholder="品牌" />
				       </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label><span class="red">*</span>发车时间:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <input class="form-control" id="sendTime" disabled="disabled" type="text" placeholder="发车时间" />
				       </div>
			       </div>
			     </div>
			     <!-- 第四列 -->
			     <div class="row newrow">
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label><span class="red">*</span>交车时间:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <input class="form-control" id="receiveTime" disabled="disabled" type="text" placeholder="交车时间" />
				       </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label><span class="red">*</span>台数:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <input class="form-control" id="amount" disabled="disabled" type="text" placeholder="台数" />
				       </div>
			       </div>
			     </div>
			     <!-- 第五列 -->
			     <div class="row newrow">
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label><span class="red">*</span>起运地:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				         <input class="form-control" id="startAddress" disabled="disabled" type="text" placeholder="起运地" />
				       </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label><span class="red">*</span>目的地:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <input class="form-control" id="endAddress" disabled="disabled" type="text" placeholder="目的地" />
				       </div>
			       </div>
			     </div>
		    </div>
		      <!--设置费用明细信息-->
		     <div class="row row-btn-tit">
		        <div class="col-xs-2 pd-2">
			       <div class="row-tit">
			                           费用明细
			       </div>
		       </div>
		       <div class="col-xs-7"></div>
		       <div class="col-xs-3">
				  <div class="form-contr-1">
				     <a class="form-btn-1 fr" onclick="addNewDetail();" style="width:115px;"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>添加其它支出</a>
				  	 <div class="clear"></div>
				  </div>
			   </div>
		     </div>
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
			              <select id="discountFlag" class="form-control">
			                <option value="N">否</option>
			                <option value="Y">是</option>
			              </select>
			            </div>
			       </div>
			       <div class="col-xs-9"></div>
		      </div>
		      <!--预付信息-->
		     <div class="table-itemTit bor-t-ff9a00">预付信息</div>
		     <div class="row newrow">
		           <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>预付时间:</label>
				       </div>
			        </div>
			       <div class="col-xs-5">
			           <div class="form-contr">
			              <input class="form-control" id="prePay" data-id="" disabled="disabled" type="text" placeholder="预付" />
			           </div>
			       </div>
			       <div class="col-xs-6"></div>
		      </div>
		      <!-- 现金 -->
		      <div class="row newrow bor-b-ff9a00-1">
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>现金金额:</label>
				       </div>
			        </div>
			       <div class="col-xs-5">
			           <div class="form-contr">
			              <input class="form-control" id="preAmount0" type="text" disabled="disabled" placeholder="金额" />
			            </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>油卡金额:</label>
				       </div>
			        </div>
			       <div class="col-xs-5">
			           <div class="form-contr">
			              <input class="form-control" id="preAmount1" type="text" disabled="disabled" placeholder="金额" />
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
  $(function(){
	  bindTime();
	  init();
  });
  /* 明细信息收缩展开 */
 function expandinfo(e){
	  var flag=$(e).attr('data-flag');
	  if(flag=='N'){
		  $(e).html('收起');
		  $(e).attr('data-flag','Y');
		  $('#expandDetail').show();
	  }else{
		  $(e).html('展开');
		  $(e).attr('data-flag','N');
		  $('#expandDetail').hide();
	  }
  }
 /* 初始信息加载 */
 function init(){
	  var id="${id}";
	  var html="";
	  var count="";
	  $.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/transportCostMng/getDetail/"+id,
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					var preIds=data.data['prepayApplyIds'];
					$('#carNumber').val(data.data['carNumber']);
					$('#driver').val(data.data['driverName']);
					$('#driver_id').val(data.data.driverId);
					if(data.data['costList'][0]['brandName']==null || data.data['costList'][0]['brandName']==''){
						$('#brandName').val('');
					}else{
						$("#brandName").val(data.data['costList'][0]['brandName']);
					}
					if(data.data['scheduleBillNo']==null || data.data['scheduleBillNo']==''){
						$('#scheduleBillNo').val('');
					}else{
						$("#scheduleBillNo").val(data.data['scheduleBillNo']);
					}
					if(data.data['discountFlag']==null || data.data['discountFlag']==''){
						$('#discountFlag').val('N');
					}else{
						$('#discountFlag').val(data.data['discountFlag']);
					}
					if(data.data['prepayList'][0]['applyTime']==null || data.data['prepayList'][0]['applyTime']==''){
						$('#prePay').val('');
					}else{
						$("#prePay").val(jsonForDateFormat(data.data['prepayList'][0]['applyTime']));
					}
					if(data.data['prepayList'][0]['prepayCash']==null || data.data['prepayList'][0]['prepayCash']==''){
						$('#preAmount0').val('');
					}else{
						$("#preAmount0").val(data.data['prepayList'][0]['prepayCash']);
					}
					if(data.data['prepayList'][0]['oilAmount']==null || data.data['prepayList'][0]['oilAmount']==''){
						$('#preAmount1').val('');
					}else{
						$("#preAmount1").val(data.data['prepayList'][0]['oilAmount']);
					}
					if(data.data['costList'][0]['sendTime']!=''&&data.data['costList'][0]['sendTime']!=null){
						$('#sendTime').val(jsonForDateFormat(data.data['costList'][0]['sendTime']));	
					}else{
						$('#sendTime').val('');	
					}
					if(data.data['costList'][0]['receiveTime']!=''&&data.data['costList'][0]['receiveTime']!=null){
						$('#receiveTime').val(jsonForDateFormat(data.data['costList'][0]['receiveTime']));	
					}else{
						$('#receiveTime').val('');	
					}
					$('#amount').val(data.data['costList'][0]['count']);
					$('#startAddress').val(data.data['costList'][0]['startAddress']);
					$('#endAddress').val(data.data['costList'][0]['endAddress']);
					if(data.data['applyTime']!=''&&data.data['applyTime']!=null){
						$('#applyTime').val(jsonForDateFormat(data.data['applyTime']));	
					}else{
						$('#applyTime').val('');	
					}
					var ertra=[];
					if(data.data['costList'][0]['cashList'].length>0){
						var obj=data.data['costList'][0]['cashList'];
						var count=data.data['costList'][0]['cashList'].length;
						for(var i=0;i<data.data['costList'][0]['cashList'].length;i++){
							var attachFilePaths="";
							var partHtml="";
							if(obj[i].filePath!=null && obj[i].filePath!=''){
								attachFilePaths="${ctx}"+obj[i].filePath;
								partHtml='<a href='+attachFilePaths+' target="_blank">附件</a>';
							}
								html+='<div id="detailList'+i+'" class="detailList bor-b-ff9a00-1">'
			       			      +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>费用名称:</label></div></div>'
			       			      +'<div class="col-xs-2"><div class="form-contr"><p class="form-control no-border" id="titleName'+i+'" >'+obj[i].name+'</p></div></div>'
			       			      +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>金额:</label></div></div>'
			       			      +'<div class="col-xs-3"><div class="form-contr"><input class="form-control" id="amount'+i+'" type="text" placeholder="请输入金额" value="'+obj[i].amount+'" /></div></div>'
			       			      +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>备注:</label></div></div>'
			       			      +'<div class="col-xs-3"><div class="form-contr"><input class="form-control" id="name'+i+'" type="text" placeholder="请输入备注" value="'+obj[i].mark+'"/></div></div>'
			       			      +'<div class="col-xs-1"><div class="form-contr-1">'
			       			      +'<a class="delete-detail fr" onclick="removeDetail(this,'+i+');"><i class="icon-minus-sign" style="display: inline-block;width: 20px;"></i>删除</a>'
			       			      +'</div></div></div>'
			       			      +'<div class="row newrow bor-no"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>上传凭证:</label></div></div>'
			       			      +'<div class="col-xs-5"><div class="form-contr"><input type="file" id="file'+i+'" />'
			       			      +'<label class="title" id="filename'+i+'">'+partHtml+'</label>'
			       			      +'<input type="hidden" name="filename_hidden'+i+'" id="filename_hidden'+i+'" />'
			       			      +'<input type="hidden" name="filepath_hidden'+i+'" id="filepath_hidden'+i+'" value="'+obj[i].filePath+'"/>'
			       			      +'</div></div><div class="col-xs-6"></div></div></div>';
							}
						}
					$('#cataListItem').html(html);
					if(count!='' && count!=null){
						 for(var j=0;j<count;j++){
							 uploadInfo(j);
						 }
					}
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		}); 
 }
 
/* 绑定上传插件 */
 function uploadInfo(j){
		  $('#file'+j+'').uploadify({
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
		           'uploader':'${ctx}/upload/saveFile?type=transportcost',
		           //上传文件个数限制
		           'uploadLimit': 1,
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
		           	var html='<a  href='+attachFilePaths+' target="_blank">附件</a>';
		           	$('#filename'+j+'').html(html);
		           	$('#filename_hidden'+j+'').val(orginFileName);
		           	$('#filepath_hidden'+j+'').val(attachFilePath);
		           }
		    });
	  
  }
  
  
  
  /* 初始强制赋值当前时间 */
  function bindTime(){
	  var date = new Date();
      var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
      var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
      var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
      var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
      var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
      var localTime= date.getFullYear() + "-" + month + "-" + day;
	  $('#applyTime').val(localTime);
  }
  
 
 
 /* 新增详细信息 */
 function addNewDetail(){
	 var i=$('.detailList').length;
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要新增其它支出?", 
		  callback: function(result){
			  if(result){
			   var html='<div id="detailList'+i+'" class="detailList bor-b-ff9a00-1">'
			      +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>费用名称:</label></div></div>'
   			      +'<div class="col-xs-2"><div class="form-contr"><input class="form-control" id="titleName'+i+'" placeholder="请输入费用名称" data-type="extra"/></div></div>'
   			      +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>金额:</label></div></div>'
   			      +'<div class="col-xs-3"><div class="form-contr"><input class="form-control" id="amount'+i+'" type="text" placeholder="请输入金额" /></div></div>'
   			      +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label>备注:</label></div></div>'
   			      +'<div class="col-xs-3"><div class="form-contr"><input class="form-control" id="name'+i+'" type="text" placeholder="请输入备注" /></div></div>'
   			      +'<div class="col-xs-1"><div class="form-contr-1">'
   			      +'<a class="delete-detail fr" onclick="removeDetail(this,'+i+');"><i class="icon-minus-sign" style="display: inline-block;width: 20px;"></i>删除</a>'
   			      +'</div></div></div>'
   			      +'<div class="row newrow bor-no"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>上传凭证:</label></div></div>'
   			      +'<div class="col-xs-5"><div class="form-contr"><input type="file" id="file'+i+'" />'
   			      +'<label class="title" id="filename'+i+'"></label>'
   			      +'<input type="hidden" name="filename_hidden'+i+'" id="filename_hidden'+i+'" />'
   			      +'<input type="hidden" name="filepath_hidden'+i+'" id="filepath_hidden'+i+'" />'
   			      +'</div></div><div class="col-xs-6"></div></div></div>';
			     $('#detailList'+(i-1)+'').after(html); 
			     uploadInfo(i)
			  }
		  }
	 });
 }
        
 
/* 删除信息 */
function removeDetail(e,index){
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该条信息?", 
		  callback: function(result){
			  if(result){
				  $(e).parents('#detailList'+index+'').html('').removeClass('bor-b-ff9a00-1'); 
			  }
		  }
	 });
	
}


 /* 保存申请信息 */
 function dosave(){
	 var flag="false";
	 var id="${id}";
	 var objs=[];
	 var objList={};
	 var discountFlag=$('#discountFlag').val();
	 var scheduleBillNo=$('#scheduleBillNo').val();
	 var applyTime=$('#applyTime').val();
	 var carNumber=$('#carNumber').val();
	 var driver=$('#driver_id').val();
	 var brandName=$('#brandName').val();
	 var sendTime=$('#sendTime').val();
	 var receiveTime=$('#receiveTime').val();
	 var count=parseInt($('#amount').val());
	 var startAddress=$('#startAddress').val();
	 var endAddress=$('#endAddress').val();
	 var prepayApplyIds=$('#prePay').attr('data-id');
	 if(scheduleBillNo=='' || scheduleBillNo==null){
		 bootbox.alert('调度单不能为空！');
		 return;
	 }
	 if(driver=='' || driver==null){
		 bootbox.alert('驾驶员不能为空！');
		 return;
	 }
	 if(prepayApplyIds=='' || prepayApplyIds==null || prepayApplyIds=='-1'){
		 prepayApplyIds="";
	 }
	 
	 var detailList=$('.detailList').length;
	 var objItem={};
	 var types=[];
	   objItem.brandName=brandName;
	   objItem.sendTime=sendTime;
	   objItem.receiveTime=receiveTime;
	   objItem.count=count;
	   objItem.startAddress=startAddress;
	   objItem.endAddress=endAddress;
	   for(var i=0;i<detailList;i++){
		   var typeItem={};
		   if($('#titleName'+i+'').attr('data-type')!=null && $('#titleName'+i+'').attr('data-type')=='extra'){
			   if($('#titleName'+i+'').val()!=null && $('#titleName'+i+'').val()!=''){
				   typeItem.name=$('#titleName'+i+'').val();
			   }else{
				   bootbox.alert('新增其它支出费用名称不能为空！');
				   return;  
			   }
		   }else{
			   typeItem.name=$('#titleName'+i+'').html();
		   }
		   if($('#amount'+i+'').val()==''){
			   bootbox.alert(typeItem.name+'金额不能为空！');
			   return;
		   }else if($('#amount'+i+'').val()!='' &&  $('#amount'+i+'').val()!=null){
			   typeItem.amount=$('#amount'+i+'').val();
			   typeItem.mark=$('#name'+i+'').val();
			   typeItem.filePath=$('#filepath_hidden'+i+'').val();
			   types.push(typeItem);
		   }
	   }
	   objItem.cashList=types;
	   objs.push(objItem);
	   objList.costList=objs;
	   objList.id=id;
	   objList.discountFlag=discountFlag;
	   objList.applyTime=applyTime;
	   objList.carNumber=carNumber;
	   objList.driverId=driver;
	   objList.scheduleBillNo=scheduleBillNo;
	   objList.prepayApplyIds=prepayApplyIds;
	   objList.mark='';
	   bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该报销申请单信息?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : '${ctx}/operationMng/transportCostMng/update',
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
												  location.href="${ctx}/operationMng/transportCostMng/officeIndex";
											  }else{
												  location.href="${ctx}/operationMng/transportCostMng/officeIndex";
											  }
										  }
									 });
									setTimeout(function(){
										if(flag=="false"){
											 location.href="${ctx}/operationMng/transportCostMng/officeIndex";
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
 

 /* 返回驾驶员报销申请列表 */
 function doback(){
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要离开？", 
		  callback: function(result){
			  if(result){
				  location.href="${ctx}/operationMng/transportCostMng/officeIndex";
			  }
		  }
	 })
 }
</script>

</body>
</html>






