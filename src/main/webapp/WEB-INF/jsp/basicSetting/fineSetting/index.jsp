
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
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
.item1 {
    float: left;
    height: 35px;
    line-height: 35px;
    width: 205px;
    margin-right: 10px;
    color: #4f4f4f;
    text-align: right;
    font-size: 14px;
}
 .item2 {
    float: left;
    height: 50px;
    width: 255px;
}

 .item3 {
    float: left;
    height: 50px;
    color: green;
    padding-left: 20px;
}
 .item4,.item6 {
    float: left;
    height: 50px;
    color: #da051e;
    padding-left: 25px;
    display: none;
}
 .item5{
	width:320px;margin:35px 138px 20px;height:50px;
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
				罚款比例设置
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
	    <input type="hidden" id="oldFlag" value="false" />
	    <input type="hidden" id="newFlag" value="false"  />
	    <input type="hidden" id="confirmFlag" value="false" />
	    <input type="hidden" id="idhidden"/>
		<div class="pwd-reset">
		   <div class="finesetting">
		        <div class="item1">罚款比例（%）：</div>
		        <div class="item2"><input type="text" id="proportion" placeholder="请输入罚款比例" style="height:36px;line-height:36px;"/></div>
		        <div class="item3" style="display: none;"></div>
		        <div class="item4" style="display: block;">请输入罚款比例</div> 
		        <div class="item6" style="display: none;">罚款比例输入错误</div> 
		        <div class="clear"></div>
		    </div>		   		   
		   <div class="regLine">
		      <div class="item5">
		         <a href="javascript:;" class="form-btn" onclick="updatePropor();">保存</a>
		        <!--  <a href="javascript:;" class="form-btn cancle form-btn-pwd" onclick="reset();">清空</a> -->
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
<script type="text/javascript">

 $(function(){	
	 getdata();
	 //console.info($('#proportion').val());
	 $('#proportion').blur(function(){
		 checkOld();
	 });
	 $('#proportion').focus(function(){
		 $(this).parents('.finesetting').find('.item3').hide(); 
		 $(this).parents('.finesetting').find('.item4').hide();
		 $(this).parents('.finesetting').find('.item6').hide();
	 });
	
	
 });
 /* 罚款比例*/
  function checkOld(){
	  if($('#proportion').val()!='' && $('#proportion').val()!=null){
			 var proportion=$.trim($('#proportion').val());
			 //判断罚款比例是否位数字
			 revaildate(proportion);
		 }else{
			 $('#proportion').parents('.finesetting').find('.item4').show(); 
			 $('#proportion').parents('.finesetting').find('.item3').hide();
			 $('#proportion').parents('.finesetting').find('.item6').hide();
			 $('#oldFlag').val('false');
		 }
  }
 
  /* 百分比数字验证 */
  function revaildate(proportion){
  	var reg = /^(100|[1-9]?\d(\.\d\d?)?)$/ ;
      if(!reg.test(proportion)){
    	    $('#proportion').parents('.finesetting').find('.item6').show(); 
			$('#proportion').parents('.finesetting').find('.item3').hide();
			$('#proportion').parents('.finesetting').find('.item4').hide();
			$('#oldFlag').val('false');
      }else{
    	     $('#proportion').parents('.finesetting').find('.item3').show(); 
			 $('#proportion').parents('.finesetting').find('.item4').hide();
			 $('#proportion').parents('.finesetting').find('.item6').hide();
			 $('#oldFlag').val('true');
      }
    
  }


  /* 罚款比例保存/修改 */
  function updatePropor(){
	  var id=$('#idhidden').val();
	  var proportion=$('#proportion').val();
	  var flag="false";
	  if($('#oldFlag').val()=="true"){
		  bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存?", 
			  callback: function(result){
				  if(result){
						$.ajax({
							type : 'POST',
							url : '${ctx}/basicSetting/fineSetting/save',
							data : JSON.stringify({
								id : id,
								proportion : proportion
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
									//reset();
								} else {
									bootbox.alert(data.msg);
								}
								
							}
							
						});
				  }
			  }
			});
	  }
	  else{
		  checkOld();		 
	  }
	  
  }

  /* 重置文本框 */
  
  function reset(){
	  $('#idhidden').val('');	 
	  $('#proportion').val('');	  
	  $('#proportion').parents('.finesetting').find('.item4').show();
	  $('#proportion').parents('.finesetting').find('.item3').hide();
	  $('#proportion').parents('.finesetting').find('.item6').hide();	  
  }
  
  function getdata(){
		$.ajax({
			type : 'POST',
			url : "${ctx}/basicSetting/fineSetting/getBean",
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.info(JSON.stringify(data.data));
					if(data.data!=null){
						 $('#idhidden').val(data.data.id);	 
						  $('#proportion').val(data.data.proportion);	
						  $('#proportion').parents('.finesetting').find('.item3').hide(); 
						  $('#proportion').parents('.finesetting').find('.item4').hide();
						  $('#proportion').parents('.finesetting').find('.item6').hide();
					}
				} else {
					bootbox.alert(data.msg);
				}
			}
			
		});
  }
</script>



</body>
</html>






