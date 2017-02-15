
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
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			基础信息管理
			<small>
				<i class="icon-double-angle-right"></i>
				驾驶员设置管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">姓名：</label>
		   <input id="nameSearch" class="form-box" type="text" placeholder="请输入姓名"/>
		   <label class="title">手机号：</label>
		   <input id="mobileSearch" class="form-box" type="text" placeholder="请输入手机号"/>
		   <label class="titletwo">承运商：</label>
		    <select id="companySearch" class="form-box">
			</select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="addDriver()">新增</a>
		</div>
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>承运商</th>
					<th>姓名</th>
                    <th>手机号</th>
                    <th>身份证</th>
                    <th>从业资格证书</th>
                    <th>紧急联系人</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<!-- 驾驶员新增--modal begin-->
			<div class="modal fade" id="modal-add" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:1%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="refresh();">×</button>
						<h3 id="myModalLabel">新增驾驶员</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>姓名：</label>
								     <input class="form-control" id="name" type="text" placeholder="请输入姓名"/>
								 </div>
								  <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>身份证号码：</label>
								     <input class="form-control" id="userCard" type="text" placeholder="请输入身份证"/>
								    </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>手机号码：</label>
								     <input class="form-control" id="userTel" type="text" placeholder="请输入手机号码"/>
								    </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>承运商：</label>
								     <select class="form-control" id="companyInit">
									</select>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>紧急联络人：</label>
								     <input class="form-control" id="importLinkman" type="text" placeholder="请输入紧急联络人"/>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>从业资格证书：</label>
								     <input class="form-control" id="certificate" type="text" placeholder="请输入从业资格证书"/>
								   </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								      <label class="title"><span class="red">*</span>身份证附件：</label>
								      <div class="form-control" style="border:0;height:auto;">
								         <input type="file" id="idCardfile" />
                                         <label class="title" id="filename"></label>
                                         <input type="hidden" name="filename_hidden" id="idCardfilename_hidden" />
                                         <input type="hidden" name="filepath_hidden" id="idCardfilepath_hidden" />
								      </div>
                                    </div>
                                     <hr class="tree"></hr>
                                     <div class="add-item extra-itemSec">
								      <label class="title"><span class="red">*</span>从业资格证书：</label>
								      <div class="form-control" style="border:0;height:auto;">
								         <input type="file" id="certificateFile" />
                                         <label class="title" id="certificateFilefilename"></label>
                                         <input type="hidden" name="certificateFilename_hidden" id="certificateFilename_hidden" />
                                         <input type="hidden" name="certificateFilepath_hidden" id="certificateFilepath_hidden" />
								      </div>
                                    </div>
                                     <hr class="tree"></hr>
								   </div>
								 
							       <div class="add-item-btn" id="addBtn" style="display:block;">
								    <a class="add-itemBtn btnOk" onclick="save();">保存</a>
								    <a class="add-itemBtn btnCancle" onclick="refresh();">取消</a>
								   </div>
								</div>
						       </div>
					     </div>
					  </div>
				   </div>
				 </div>
				<!-- 驾驶员新增--modal end-->
				<!-- 驾驶员编辑--modal begin-->
			   <div class="modal fade" id="modal-edit" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-dialog" style="padding-top:1%;">
				  <div class="modal-content">
				     <div class="modal-header" style="padding:0 15px;">
				        <button class="close" type="button" onclick="erefresh();">×</button>
						<h3 id="myModalLabel">编辑驾驶员</h3>
				    </div>
					<div class="modal-body">
					    <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>姓名：</label>
								     <input class="form-control" id="ename" type="text" placeholder="请输入姓名"/>
								      <input class="form-control" id="id-hidden" type="hidden"/>
								 </div>
								  <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>身份证号码：</label>
								     <input class="form-control" id="euserCard" type="text" placeholder="请输入身份证"/>
								    </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>手机号码：</label>
								     <input class="form-control" id="euserTel" type="text" placeholder="请输入手机号码"/>
								    </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>承运商：</label>
								     <select class="form-control" id="ecompanyInit">
									</select>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>紧急联络人：</label>
								     <input class="form-control" id="eimportLinkman" type="text" placeholder="请输入紧急联络人"/>
								  </div>
								  <hr class="tree"></hr>
								  <div class="add-item extra-itemSec">
								     <label class="title"><span class="red">*</span>从业资格证书：</label>
								     <input class="form-control" id="ecertificate" type="text" placeholder="请输入从业资格证书"/>
								   </div>
								   <hr class="tree"></hr>
								   <div class="add-item extra-itemSec">
								      <label class="title"><span class="red">*</span>身份证附件：</label>
								      <div class="form-control" style="border:0;height:auto;">
								         <input type="file" id="eidCardfile" />
                                         <label class="title" id="efilename"></label>
                                         <input type="hidden" name="eidCardfilename_hidden" id="eidCardfilename_hidden" />
                                         <input type="hidden" name="eidCardfilepath_hidden" id="eidCardfilepath_hidden" />
								      </div>
                                    </div>
                                     <hr class="tree"></hr>
                                     <div class="add-item extra-itemSec">
								      <label class="title"><span class="red">*</span>从业资格证书：</label>
								      <div class="form-control" style="border:0;height:auto;">
								         <input type="file" id="ecertificateFile" />
                                         <label class="title" id="ecertificateFilefilename"></label>
                                         <input type="hidden" name="ecertificateFilename_hidden" id="ecertificateFilename_hidden" />
                                         <input type="hidden" name="ecertificateFilepath_hidden" id="ecertificateFilepath_hidden" />
								      </div>
                                    </div>
                                     <hr class="tree"></hr>
								   </div>
								 
							       <div class="add-item-btn" id="addBtn" style="display:block;">
								    <a class="add-itemBtn btnOk" onclick="update();">保存</a>
								    <a class="add-itemBtn btnCancle" onclick="erefresh();">取消</a>
								   </div>
								</div>
						       </div>
					     </div>
					  </div>
				   </div>
				 </div>
				 <!-- 驾驶员编辑--modal end-->
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
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/basicSetting/driverMng/getListData" , //获取数据的ajax方法的URL							 
		 "ordering": false,	
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
				columns: [{ data: "rownum","width":"5%"},
						    {data: "outSourcingName","width":"20%"},
						    {data: "name","width":"10%"},
						    {data: "mobile","width":"15%"},
						    {data: "idCard","width":"10%"},
						    {data: "certificate","width":"10%"},
						    {data: "importLinkman","width":"10%"},
						    {data: null,"width":"20%"}],
						    columnDefs: [
						      	{
							    	 //操作栏
							    	 targets: 7,
							    	 render: function (data, type, row, meta) {
						                    return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
										           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
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
		 "sAjaxSource": "${ctx}/basicSetting/driverMng/getListData", //获取数据的ajax方法的URL	
		 "ordering": false,	
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
				columns: [{ data: "rownum","width":"5%"},
						    {data: "outSourcingName","width":"20%"},
						    {data: "name","width":"10%"},
						    {data: "mobile","width":"15%"},
						    {data: "idCard","width":"10%"},
						    {data: "certificate","width":"10%"},
						    {data: "importLinkman","width":"10%"},
						    {data: null,"width":"20%"}],
						    columnDefs: [
						      	{
							    	 //操作栏
							    	 targets: 7,
							    	 render: function (data, type, row, meta) {
						                    return '<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
										           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
/* 身份证附件上传 */
function upload(){
	$("#idCardfile").uploadify({
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
        'uploader':'${ctx}/upload/saveFile?type=idcard',
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
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#filename').html(html);
        	$('#idCardfilename_hidden').val(orginFileName);
        	$('#idCardfilepath_hidden').val(attachFilePath);
        }
 });
}
function eupload(){
	$("#eidCardfile").uploadify({
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
        'uploader':'${ctx}/upload/saveFile?type=idcard',
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
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#efilename').html(html);
        	$('#eidCardfilename_hidden').val(orginFileName);
        	$('#eidCardfilepath_hidden').val(attachFilePath);
        }
 });
}
/* 从业资格证书附件上传 */
function certificateFileupload(){
	$("#certificateFile").uploadify({
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
        'uploader':'${ctx}/upload/saveFile?type=certificate',
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
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#certificateFilefilename').html(html);
        	$('#certificateFilename_hidden').val(orginFileName);
        	$('#certificateFilepath_hidden').val(attachFilePath);
        }
 });
}
function ecertificateFileupload(){
	$("#ecertificateFile").uploadify({
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
        'uploader':'${ctx}/upload/saveFile?type=certificate',
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
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#ecertificateFilefilename').html(html);
        	$('#ecertificateFilename_hidden').val(orginFileName);
        	$('#ecertificateFilepath_hidden').val(attachFilePath);
        }
 });
}
$(function(){
	init();
	getCompany();
	upload();
	certificateFileupload();
	eupload();
	ecertificateFileupload();
})

/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var companySearch=$("#companySearch").find("option:selected").html(); 
	   if($("#companySearch").find("option:selected").val()=='-1'){
		   companySearch="";
	   }
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				name : $.trim($('#nameSearch').val()),
				mobile : $.trim($('#mobileSearch').val()),
				outSourcingName : companySearch
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
	reload();
}
/* 承运商绑定 */
	function getCompany(){
		$.ajax({  
            url: '${ctx}/basicSetting/outSourcingMng/getAll',  
            type: "post",  
            contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
            data: '',
            success: function (data) {
            	var html ='<option value="-1">请选择承运商</option>'; 
                if(data.code == 200){  
                	if(data.data!=null && data.data!=''){
                		if(data.data.length>0){
                			for(var i=0;i<data.data.length;i++){
                    			html +='<option value='+data.data[i]['id']+'>'+data.data[i]['name']+'</option>';
                    		}
                		}
                	}
                	$('#companySearch').html(html);
                	$('#companyInit').html(html);
                	$('#ecompanyInit').html(html);
                	
                   }else{  
                	   bootbox.alert('加载失败！');
                   }  
            }  
          }); 
	}
	
/* 删除人员 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除人员信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/basicSetting/driverMng/delete/"+id,
						data :{},
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "删除成功！", 
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
	})
}

/* 新增驾驶员信息  --------------begin*/

function addDriver(){
	clear();
	$('#modal-add').modal('show');
}
/* 关闭窗体 */
function refresh(){
	$('#modal-add').modal('hide');
	
}
/* 数据重置 */
function clear(){
	$('#name').val('');
	$('#userCard').val('');
	$('#userTel').val('');
	$('#companyInit').val('-1');
	$('#certificate').val('');
	$('#importLinkman').val('');
	$('#filename').html('');
	$('#idCardfilename_hidden').val('');
	$('#idCardfilepath_hidden').val('');
	$('#certificateFilefilename').html('');
	$('#certificateFilename_hidden').val('');
	$('#certificateFilepath_hidden').val('');
}
/* 保存新增人员信息 */
function save(){
	var importLinkman=$('#importLinkman').val();
	var name=$('#name').val();
	var idCard=$("#userCard").val(); 
	var mobile=$('#userTel').val();
	var certificate=$('#certificate').val();
	var outSourcingId=$('#companyInit').val();
	var idCardFilePath=$('#idCardfilepath_hidden').val();
	var certificateFilePath=$('#certificateFilepath_hidden').val();
	if(name==''|| name==null){
		bootbox.alert('姓名不能为空！');
		return;
	}
	if(idCard==''|| idCard==null){
		bootbox.alert('身份证不能为空！');
		return;
	}
	if(mobile==''|| mobile==null){
		bootbox.alert('手机号不能为空！');
		return;
	}
	if(outSourcingId==''|| outSourcingId==null || outSourcingId=='-1'){
		bootbox.alert('承运商不能为空！');
		return;
	}
	if(importLinkman==''|| importLinkman==null){
		bootbox.alert('紧急联络人不能为空！');
		return;
	}
	if(certificate==''|| certificate==null){
		bootbox.alert('从业资格证书编号不能为空！');
		return;
	}
	if(idCardFilePath==''|| idCardFilePath==null){
		bootbox.alert('请先上传身份证附件！');
		return;
	}
	if(certificateFilePath==''|| certificateFilePath==null){
		bootbox.alert('请先上传资格证书附件！');
		return;
	}
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增驾驶员信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/driverMng/save',
						data : JSON.stringify({
							id : '',
							name : name,				
							idCard : idCard,
							mobile : mobile,
							certificate : certificate,
							outSourcingId : outSourcingId,
							idCardFilePath : idCardFilePath,
							certificateFilePath : certificateFilePath,
							importLinkman :importLinkman
							
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
											  reload();
											  $('#modal-add').modal('hide');
										  }else{
											  reload();
											  $('#modal-add').modal('hide');
										  }
									  }
								});
								setTimeout(function(){
									if(flag=="false"){
										reload();
										$('#modal-add').modal('hide');
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
/* 新增驾驶员信息  --------------end*/

/* 编辑驾驶员信息  --------------begin*/
function doedit(id){
	$.ajax({
		type : 'GET',
		url : "${ctx}/basicSetting/driverMng/getDetailData/"+id,
		data :{},
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				var cardOrginName='查看图片',certificateOrginName='查看图片';
				$('#id-hidden').val(id);
				$('#ename').val(data.data.name);
				$('#euserCard').val(data.data.idCard);
				$('#euserTel').val(data.data.mobile);
				var cardAttachFilePaths="${ctx}"+data.data.idCardFilePath;
				var certificateAttachFilePaths="${ctx}"+data.data.certificateFilePath;
				/* if(cardAttachFilePaths.split('/').length>5){
					cardOrginName=cardAttachFilePaths.split('/')[5];
				}
				if(certificateAttachFilePaths.split('/').length>5){
					certificateOrginName=certificateAttachFilePaths.split('/')[5];
				} */
				var cardhtml='<a  href='+cardAttachFilePaths+' target="_blank">'+cardOrginName+'</a>';
				var certificatehtml='<a  href='+certificateAttachFilePaths+' target="_blank">'+certificateOrginName+'</a>';
				if(data.data.outSourcingId==''|| data.data.outSourcingId==null || data.data.outSourcingId=='-1'){
					$('#ecompanyInit').val('-1');
				}else{
					$('#ecompanyInit').val(data.data.outSourcingId);
				}
				$('#eimportLinkman').val(data.data.importLinkman);
				$('#ecertificate').val(data.data.certificate);
				$('#efilename').html(cardhtml);
				$('#ecertificateFilefilename').html(certificatehtml);
				$('#eidCardfilepath_hidden').val(data.data.idCardFilePath);
				$('#ecertificateFilepath_hidden').val(data.data.certificateFilePath);
				$('#modal-edit').modal('show');
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}

/* 关闭窗体 */
function erefresh(){
	$('#modal-edit').modal('hide');
	
}
/* 更新 */
function update(){
	var id=$('#id-hidden').val();
	var importLinkman=$('#eimportLinkman').val();
	var name=$('#ename').val();
	var idCard=$("#euserCard").val(); 
	var mobile=$('#euserTel').val();
	var certificate=$('#ecertificate').val();
	var outSourcingId=$('#ecompanyInit').val();
	var idCardFilePath=$('#eidCardfilepath_hidden').val();
	var certificateFilePath=$('#ecertificateFilepath_hidden').val();
	if(id==''|| id==null){
		bootbox.alert('更新失败，请刷新页面重新操作，如若在有问题，请联系管理员！');
		return;
	}
	if(name==''|| name==null){
		bootbox.alert('姓名不能为空！');
		return;
	}
	if(idCard==''|| idCard==null){
		bootbox.alert('身份证不能为空！');
		return;
	}
	if(mobile==''|| mobile==null){
		bootbox.alert('手机号不能为空！');
		return;
	}
	if(outSourcingId==''|| outSourcingId==null || outSourcingId=='-1'){
		bootbox.alert('承运商不能为空！');
		return;
	}
	if(importLinkman==''|| importLinkman==null){
		bootbox.alert('紧急联络人不能为空！');
		return;
	}
	if(certificate==''|| certificate==null){
		bootbox.alert('从业资格证书编号不能为空！');
		return;
	}
	if(idCardFilePath==''|| idCardFilePath==null){
		bootbox.alert('请先上传身份证附件！');
		return;
	}
	if(certificateFilePath==''|| certificateFilePath==null){
		bootbox.alert('请先上传资格证书附件！');
		return;
	}
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要修改驾驶员信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/basicSetting/driverMng/save',
						data : JSON.stringify({
							id : id,
							name : name,				
							idCard : idCard,
							mobile : mobile,
							certificate : certificate,
							outSourcingId : outSourcingId,
							idCardFilePath : idCardFilePath,
							certificateFilePath : certificateFilePath,
							importLinkman :importLinkman
							
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
											  reload();
											  $('#modal-edit').modal('hide');
										  }else{
											  reload();
											  $('#modal-edit').modal('hide');
										  }
									  }
								});
								setTimeout(function(){
									if(flag=="false"){
										reload();
										$('#modal-edit').modal('hide');
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
/* 编辑驾驶员信息  --------------end*/
</script>



</body>
</html>






