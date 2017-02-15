
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
				装运预付申请
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="mng">
		   <div class="table-tit">查看装车预付申请单</div>
		   <div class="table-item">
		     <div class="table-itemTit">基本信息</div>
		     <!-- 第一列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>装运车号:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="carNumber" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>申请时间:</label>
				       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="applyTime" class="form-control no-border"></p>
			       </div>
		       </div>
		       
		     </div>
		     <!-- 第二列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>驾驶员:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="driver" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>联系电话:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="mobile" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第三列 -->
		     <div class="row newrow">
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>预付现金:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="prepayCash" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>开户行:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			         <p id="bankName" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第四列 -->
		     <div class="row newrow">
		         <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>账号:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="bankAccount" class="form-control no-border"></p>
			       </div>
		       </div>
		       <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>预付油卡卡号:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <p id="oilCardNo" class="form-control no-border"></p>
			       </div>
		       </div>
		     </div>
		     <!-- 第五列 -->
		     <div class="row newrow">
		         <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>预付油费:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <p id="oilAmount" class="form-control no-border"></p>
				       </div>
			       </div>
		        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>备注:</label>
			       </div>
		       </div>
			   <div class="col-xs-5">
			     <div class="form-contr">
			       <p id="mark" class="form-control no-border"></p>
			     </div>
			   </div>
			 </div>
		     <!--设置详细信息-->
		     <div class="row row-btn-tit" id="carDetail">
		        <div class="col-xs-2 pd-2">
			       <div class="row-tit">
			                            设置装运明细
			       </div>
		       </div>
		       <div class="col-xs-10"></div>
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
	  var id="${id}";
	  var html="";
	  var detailListHtml="";
	  var detailItem="";
	  $.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/transportPrepayMng/getDetail/"+id,
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					$('#carNumber').html(data.data['carNumber']);
					$('#driver').html(data.data['driverName']);
					$('#mobile').html(data.data['mobile']);
					$('#prepayCash').html(data.data['prepayCash']);
					$('#bankName').html(data.data['bankName']);
					$('#bankAccount').html(data.data['bankAccount']);
					$('#oilCardNo').html(data.data['oilCardNo']);
					$('#oilAmount').html(data.data['oilAmount']);
					$('#oilCardNo').html(data.data['oilCardNo']);
					if(data.data['applyTime']!=null&&data.data['applyTime']!=''){
						$('#applyTime').html(jsonForDateFormat(data.data['applyTime']));
					}else{
						$('#applyTime').html('');
					}
					
					$('#mark').html(data.data['mark']);
					if(data.data['detailList'].length>0){
						for(var i=0;i<data.data['detailList'].length;i++){
							if(data.data['detailList'][i]['mark']==null || data.data['detailList'][i]['mark']==''){
								data.data['detailList'][i]['mark']='';
							}
							detailListHtml+='<div id="detailList'+i+'" class="border-b-ff9a00 detailList">'
							          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>品牌:</label></div></div>'
							          +'<div class="col-xs-5"><div class="form-contr"><p class="form-control form-control-item" id="brandName'+i+'">'+data.data['detailList'][i]['brandName']+'</p></div></div>'
							          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>台数:</label></div></div>'
							          +'<div class="col-xs-5"><div class="form-contr"><p class="form-control form-control-item" id="count'+i+'">'+data.data['detailList'][i]['count']+'</p></div></div></div>'
							          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>起运地:</label></div></div>'
							          +'<div class="col-xs-5"><div class="form-contr"><p class="form-control form-control-item" id="startAddress'+i+'">'+data.data['detailList'][i]['startAddress']+'</p></div></div>'
							          +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>目的地:</label></div></div>'
							          +'<div class="col-xs-5"><div class="form-contr"><p class="form-control form-control-item" id="endAddress'+i+'">'+data.data['detailList'][i]['endAddress']+'</p></div></div></div>'
							          +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>备注:</label></div></div>'
							          +'<div class="col-xs-11"><div class="form-contr"><p class="form-control form-control-item" id="remark'+i+'">'+data.data['detailList'][i]['mark']+'</p></div></div></div></div>';
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
  /* 初始加载时绑定品牌信息 */
  function bindBrandList(index,brandId){
	  $.ajax({  
	        url: '${ctx}/operationMng/transportPrepayMng/getBrandList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['brandName']+'</option>';
	                		}
	            		}
	            	}
	            	$('#brandName'+index+'').html(html);
	            	$('#brandName'+index+'').val(brandId);
	               }else{  
	            	   bootbox.alert('加载失败！');
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
				  location.href="${ctx}/operationMng/transportPrepayMng/officeIndex";
			  }
			 
		  }
	 })
 }
</script>

</body>
</html>






