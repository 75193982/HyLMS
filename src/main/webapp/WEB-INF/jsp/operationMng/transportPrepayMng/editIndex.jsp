
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
		   <div class="table-tit">编辑装车预付申请单</div>
		   <div class="table-item">
		     <div class="table-itemTit">基本信息</div>
		     <!-- 第一列 -->
		     <div class="row newrow">
			     <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label><span class="red">*</span>装运车号:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <select class="form-control" id="carNumber">
				          </select>
				       </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label><span class="red">*</span>申请时间:</label>
				       </div>
			       </div>
				   <div class="col-xs-5">
				     <div class="form-contr">
				      <input class="form-control" id="applyTime" type="text" placeholder="请输入申请时间" />
				     </div>
				   </div>
		     </div>
		     <!-- 第二列 -->
		     <div class="row newrow">
		          <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label><span class="red">*</span>驾驶员:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <input class="form-control" id="driver" type="text" readonly="readonly" placeholder="请输入驾驶员" />
				          <input type="hidden" id="driverid" name="driverid"/>
				       </div>
			       </div>
			       <div class="col-xs-1 pd-2">
				       <div class="lab-tit">
				          <label>联系电话:</label>
				       </div>
			       </div>
			       <div class="col-xs-5">
				       <div class="form-contr">
				          <input class="form-control" id="mobile" readonly="readonly" type="text"  placeholder="请输入联系电话" />
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
		     <!-- 第四列 -->
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
			          <label>预付油卡卡号:</label>
			       </div>
		       </div>
		       <div class="col-xs-5">
			       <div class="form-contr">
			          <input class="form-control" id="oilCardNo" type="text" placeholder="请输入预付油卡卡号" onblur="cardNoConfirmBlur(this,1);" />
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
			      <input class="form-control" id="oilAmount" type="text" placeholder="请输入金额" onblur="revaildate(this,1);" />
			     </div>
			    </div>
		        <div class="col-xs-1 pd-2">
			       <div class="lab-tit">
			          <label>备注:</label>
			       </div>
		        </div>
			    <div class="col-xs-5">
			     <div class="form-contr">
			      <input class="form-control" id="mark" type="text" placeholder="请输入备注" />
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
		       <div class="col-xs-8"></div>
		       <div class="col-xs-2">
				  <div class="form-contr-1">
				     <a class="form-btn-1 fr" onclick="addNewDetail();"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>添加</a>
				  </div>
			   </div>
		     </div>
		     <!-- 第一条详细信息 -->
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
<script type="text/javascript">
  $(function(){
	  /* 时间控件初始化 */
	  $('#applyTime').datepicker({
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
			  $('#driverid').val('');
			  $('#mobile').val('');
		  }else{
			  $('#driver').val($(this).find('option:selected').attr('data-driver'));
			  if($(this).find('option:selected').attr('data-mobile')!="null" && $(this).find('option:selected').attr('data-mobile')!=''){
				  mobile=$(this).find('option:selected').attr('data-mobile');
			  }
			  $('#driverid').val($(this).val());
			  $('#mobile').val(mobile); 
		  }
	  });
	  getBrandList(0);
	  init();
  });
  
  /* 初始加载 */
  function init(){
	  var id="${id}";
	  var html="";
	  var detailListHtml="";
	  $.ajax({
			type : 'GET',
			url : "${ctx}/operationMng/transportPrepayMng/getDetail/"+id,
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					$("#carNumber option:contains('"+data.data['carNumber']+"')").attr("selected",true);
					$('#driver').val(data.data['driverName']);
					$('#driverid').val(data.data['driverId']);
					$('#mobile').val(data.data['mobile']);
					$('#prepayCash').val(data.data['prepayCash']);
					$('#bankName').val(data.data['bankName']);
					$('#bankAccount').val(data.data['bankAccount']);
					$('#oilCardNo').val(data.data['oilCardNo']);
					$('#oilAmount').val(data.data['oilAmount']);
					$('#oilCardNo').val(data.data['oilCardNo']);
					if(data.data['applyTime']!=''&&data.data['applyTime']!=null){
						$('#applyTime').val(jsonForDateFormat(data.data['applyTime']));
					}else{
						$('#applyTime').val('');
					}					
					$('#mark').val(data.data['mark']);
					if(data.data['detailList'].length>0){
						for(var i=0;i<data.data['detailList'].length;i++){
							if(data.data['detailList'][i]['mark']==null || data.data['detailList'][i]['mark']==''){
								data.data['detailList'][i]['mark']='';
							}
							if(i==0){
								 detailListHtml+='<div class="border-b-ff9a00 detailList" id="detailList'+i+'">'
							       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>品牌:</label></div></div>'
							       +'<div class="col-xs-5"><div class="form-contr"><select class="form-control carShopId" id="brandName'+i+'"></select></div></div>'
							       +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>台数:</label></div></div>'
							       +'<div class="col-xs-5"><div class="form-contr"><input class="form-control" id="count'+i+'" type="text" value="'+data.data['detailList'][i]['count']+'" placeholder="请输入台数" /></div></div></div>'
							       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>起运地:</label></div></div>'
							       +'<div class="col-xs-5"><div class="form-contr"><input class="form-control" id="startAddress'+i+'" type="text" value="'+data.data['detailList'][i]['startAddress']+'" placeholder="请输入起运地" /></div></div>'
							       +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>目的地:</label></div></div>'
							       +'<div class="col-xs-5"><div class="form-contr"><input class="form-control" id="endAddress'+i+'" type="text" value="'+data.data['detailList'][i]['endAddress']+'" placeholder="请输入目的地" /></div></div></div>'
							       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>备注:</label></div></div>'
							       +'<div class="col-xs-11"><div class="form-contr"><input class="form-control" id="remark'+i+'" type="text" value="'+data.data['detailList'][i]['mark']+'" placeholder="请输入备注" /></div></div></div>'
							       +'</div>'; 
							}else{
								 detailListHtml+='<div class="border-b-ff9a00 detailList" id="detailList'+i+'">'
						           +'<div class="row newrow"><div class="col-xs-10 pd-2"></div><div class="col-xs-2"><div class="form-contr-1"><a class="delete-detail fr" onclick="removeDetail(this,'+i+');"><i class="icon-minus-sign" style="display: inline-block;width: 20px;"></i>删除</a></div></div></div>'
							       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>品牌:</label></div></div>'
							       +'<div class="col-xs-5"><div class="form-contr"><select class="form-control carShopId" id="brandName'+i+'"></select></div></div>'
							       +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>台数:</label></div></div>'
							       +'<div class="col-xs-5"><div class="form-contr"><input class="form-control" id="count'+i+'" type="text" value="'+data.data['detailList'][i]['count']+'" placeholder="请输入台数" /></div></div></div>'
							       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>起运地:</label></div></div>'
							       +'<div class="col-xs-5"><div class="form-contr"><input class="form-control" id="startAddress'+i+'" type="text" value="'+data.data['detailList'][i]['startAddress']+'" placeholder="请输入起运地" /></div></div>'
							       +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>目的地:</label></div></div>'
							       +'<div class="col-xs-5"><div class="form-contr"><input class="form-control" id="endAddress'+i+'" type="text" value="'+data.data['detailList'][i]['endAddress']+'" placeholder="请输入目的地" /></div></div></div>'
							       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>备注:</label></div></div>'
							       +'<div class="col-xs-11"><div class="form-contr"><input class="form-control" id="remark'+i+'" type="text" value="'+data.data['detailList'][i]['mark']+'" placeholder="请输入备注" /></div></div></div>'
							       +'</div>'; 
							}
							bindBrandList(i,data.data['detailList'][i]['brandName']);
							 
						}
						
					}/* else{
						detailListHtml='<div class="border-b-ff9a00 detailList" id="detailList0"><div class="row newrow"><div class="col-xs-12"><p class="form-control no-border t-c">没有详细信息！</p></div></div>';
					} */
					html=detailListHtml;
					$('#carDetail').after(html);
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		}); 
  }
  
  /* 绑定货运车 */
  function getStockList(){
	  $.ajax({  
	        url: '${ctx}/operationMng/transportPrepayMng/getStockList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="-1" data-id="-1">请选择装运车号</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['driverId']+' data-driver='+data.data[i]['driverName']+' data-mobile='+data.data[i]['mobile']+'>'+data.data[i]['no']+'</option>';
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
  
  /* 品牌列表 */
  function getBrandList(index){
	  $.ajax({  
	        url: '${ctx}/operationMng/transportPrepayMng/getBrandList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="-1">请选择品牌</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['brandName']+'</option>';
	                		}
	            		}
	            	}
	            	$('#brandName'+index+'').html(html);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
	        }  
	      }); 
  }
  
  /* 初始加载时绑定品牌信息 */
   function bindBrandList(index,brandId){
	  $.ajax({  
	        url: '${ctx}/operationMng/transportPrepayMng/getBrandList',  
	        type: "post",  
	        contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
	        data: '',
	        success: function (data) {
	        	var html ='<option value="-1">请选择品牌</option>';
	            if(data.code == 200){  
	            	if(data.data!=null && data.data!=''){
	            		if(data.data.length>0){
	            			for(var i=0;i<data.data.length;i++){
	                			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['brandName']+'</option>';
	                		}
	            		}
	            	}
	            	$('#brandName'+index+'').html(html);
	            	$('#brandName'+index+' option:contains("'+brandId+'")').attr("selected",true);
	               }else{  
	            	   bootbox.alert('加载失败！');
	               }  
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
 
 /* 新增详细信息 */
 function addNewDetail(){
	 var index=$('.detailList').length;
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要新增装运明细信息?", 
		  callback: function(result){
			  if(result){
			   var html='<div class="border-b-ff9a00 detailList" id="detailList'+index+'">'
			           +'<div class="row newrow"><div class="col-xs-10 pd-2"></div><div class="col-xs-2"><div class="form-contr-1"><a class="delete-detail fr" onclick="removeDetail(this,'+index+');"><i class="icon-minus-sign" style="display: inline-block;width: 20px;"></i>删除</a></div></div></div>'
				       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>品牌:</label></div></div>'
				       +'<div class="col-xs-5"><div class="form-contr"><select class="form-control carShopId" id="brandName'+index+'"></select></div></div>'
				       +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>台数:</label></div></div>'
				       +'<div class="col-xs-5"><div class="form-contr"><input class="form-control" id="count'+index+'" type="text" placeholder="请输入台数" /></div></div></div>'
				       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>起运地:</label></div></div>'
				       +'<div class="col-xs-5"><div class="form-contr"><input class="form-control" id="startAddress'+index+'" type="text" placeholder="请输入起运地" /></div></div>'
				       +'<div class="col-xs-1 pd-2"><div class="lab-tit"><label><span class="red">*</span>目的地:</label></div></div>'
				       +'<div class="col-xs-5"><div class="form-contr"><input class="form-control" id="endAddress'+index+'" type="text" placeholder="请输入目的地" /></div></div></div>'
				       +'<div class="row newrow"><div class="col-xs-1 pd-2"><div class="lab-tit"><label>备注:</label></div></div>'
				       +'<div class="col-xs-11"><div class="form-contr"><input class="form-control" id="remark'+index+'" type="text" placeholder="请输入备注" /></div></div></div>'
				       +'</div>';
				       if(index>0){
				    	   $('#detailList'+(index-1)+'').after(html);
				       }else{
				    	   $('#carDetail').after(html); 
				       }
				      
				       getBrandList(index);
			  }
		  }
	    
	 });
 }
 
/* 删除信息 */
function removeDetail(e,index){
	 bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该装运预付申请单信息?", 
		  callback: function(result){
			  if(result){
				 $(e).parents('#detailList'+index+'').remove(); 
			  }
		  }
	 });
	
}


 /* 保存申请信息 */
 function dosave(){
	
	 var id="${id}";
	 var objs=[];
	 var objList={};
	 var carNumber=$('#carNumber').find('option:selected').html();
	 var driver=$('#driverid').val();
	 var mobile=$('#mobile').val();
	 var prepayCash=$('#prepayCash').val();
	 var bankName=$('#bankName').val();
	 var bankAccount=$('#bankAccount').val();
	 var oilCardNo=$('#oilCardNo').val();
	 var oilAmount=$('#oilAmount').val();
	 var applyTime=$('#applyTime').val();
	 var mark=$('#mark').val();
	
	 if(carNumber=='' || carNumber==null || carNumber=='-1'){
		 bootbox.alert('请选择装运车号！');
		 return;
	 }
	 if(applyTime=='' || applyTime==null){
		 bootbox.alert('请输入申请时间！');
		 return;
	 }
	 var detailList=$('.detailList').length;
	 for(var i=0;i<detailList;i++){
		 var objItem={};
		 if($('#brandName'+i+'').val()==null || $('#brandName'+i+'').val()=='' || $('#brandName'+i+'').val()=='-1'){
			 bootbox.alert('请选择第'+(i+1)+'条信息品牌！');
			 return;
		 }else{
			 objItem.brandName=$('#brandName'+i+'').find('option:selected').html();
		 }
		 if($('#count'+i+'').val()==null || $('#count'+i+'').val()==''){
			 bootbox.alert('请输入第'+(i+1)+'条信息台数！');
			 return;
		 }else{
			 objItem.count=$('#count'+i+'').val();
		 }
		 if($('#startAddress'+i+'').val()==null || $('#startAddress'+i+'').val()==''){
			 bootbox.alert('请输入第'+(i+1)+'条信息起运地！');
			 return;
		 }else{
			 objItem.startAddress=$('#startAddress'+i+'').val();
		 }
		 if($('#endAddress'+i+'').val()==null || $('#endAddress'+i+'').val()==''){
			 bootbox.alert('请输入第'+(i+1)+'条信息目的地！');
			 return;
		 }else{
			 objItem.endAddress=$('#endAddress'+i+'').val();
		 }
		 objItem.mark=$('#remark'+i+'').val();
		 objs.push(objItem);
	 }
	   objList.detailList=objs;
	   objList.id=id;
	   objList.carNumber=carNumber;
	   objList.driverId=driver;
	   objList.mobile=mobile;
	   objList.prepayCash=prepayCash;
	   objList.bankName=bankName;
	   objList.bankAccount=bankAccount;
	   objList.oilCardNo=oilCardNo;
	   objList.oilAmount=oilAmount;
	   objList.applyTime=applyTime;
	   objList.mark=mark;
	   bootbox.confirm({ 
			  size: "small",
			  message: "确定要修改该装运预付申请单信息?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : '${ctx}/operationMng/transportPrepayMng/update',
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
												  location.href="${ctx}/operationMng/transportPrepayMng/officeIndex";
											  }else{
												  location.href="${ctx}/operationMng/transportPrepayMng/officeIndex";
											  }
										  }
									 });
									setTimeout(function(){
										if(flag=="false"){
											location.href="${ctx}/operationMng/transportPrepayMng/officeIndex";
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
 

 /* 返回装运预付申请列表 */
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






