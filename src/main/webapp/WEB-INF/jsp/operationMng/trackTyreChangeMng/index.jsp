<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>轮胎更换管理</title>
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
 #modal-viewinfo{
    width: 600px;
    height: 750px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }  
    #selectItem9{background: #FFF;position: absolute;top: 0px;border: 1px solid #F59942;width: 180px;z-index: 1000;overflow:auto;height:200px;}
#selectSchedule p,#selectCarNo p{cursor: pointer;font-size: 14px;height:25px;line-height:25px;width:100%;font-family:"Microsoft YaHei";padding:0 5px;width:100%;}
#selectSchedule p.overb,#selectCarNo p.overb,#selectSchedule p:hover,#selectCarNo p:hover{background: #F59942;color:#fff;}
</style>
</head>
<body class="white-bg">
<!-- <div class="breadcrumbs" id="breadcrumbs">
	<script type="text/javascript">
		try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
	</script>

	<ul class="breadcrumb">
		<li>
			<i class="icon-home home-icon"></i>
			<a href="#">运营管理</a>
		</li>
		<li class="active">轮胎更换管理</li>
	</ul>.breadcrumb
</div> -->

<div class="page-content">
	<div class="page-header">
		<h1>
			运营管理
			<small>
				<i class="icon-double-angle-right"></i>
				轮胎更换管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		  <label class="title" style="float: left;height: 34px;line-height: 34px;width:75px;">时&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 175px;margin-right:15px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width:38px;margin-left: 15px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 175px;margin-right:15px;height: 34px;line-height: 34px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>		
		</div>
		<div class="searchbox col-xs-12">					
			<label class="title" style="float: left;width:75px;">装运车号：</label>
		    <!-- <select id="carNumberSearch" class="form-box" style="width:170px;">
		   	</select> -->
		    <input id="carNumberSearch" class="form-box" style="float: left;width: 175px;"  type="text" placeholder="请填写装运车号(模糊查询)" onkeyup="searchSchedule(this)"/>
		    <label class="title" style="width:53px;float: left;">状态：</label>
		   <select id="status" class="form-box" style="float: left;width:175px;">
		   <option value="">请选择状态</option>
		   <option value="0">新建</option>
		   <option value="1">待复核</option>
		   <option value="2">已完成</option>
		   	</select>
		    
			<a class="itemBtn m-lr5" onclick="searchInfo()">查询</a>
			<a class="itemBtn m-lr5" onclick="doadd()">新增</a>
			<!-- <a class="itemBtn m-lr5" onclick="doprint()">打印</a>
			<a class="itemBtn m-lr5" onclick="doexport()">导出</a> -->
			
		</div>
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>装运车号</th>
                    <th>原轮胎编号</th>
                    <th>新轮胎编号</th>
                    <th>申请时间</th>
                    <th>备注</th>
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
					<h3 id="myModalLabel">新增/编辑轮胎更换</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>装运车号：</label>
							   <!--  <select id="carNumber" class="form-control" >
		                        </select> -->
		                         <input id="carNumber" class="form-control" style="float: left;"  type="text" placeholder="请填写装运车号(模糊查询)" onkeyup="searchCarNo(this)"/>
							     <input class="form-control" id="id-hidden" type="hidden"/>
							     <input class="form-control" id="carNumber-hidden" type="hidden"/>
							     <div id="selectItem9" class="selectItemhidden form-control" style="height: 150px;width:433px;">
										<div id="selectItemCount" class="selectItemcont">
											<div id="selectCarNo2" style="height: 150px;">
											
											</div>
										</div>
									</div>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>原轮胎编号：</label>
							     <input id="oldNo" class="form-control" type="text" placeholder="请填写原轮胎编号"/>
							 </div>
							 <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>新轮胎编号：</label>
							     <!-- <select id="newNo" class="form-control" >
		                        </select> -->
		                        <a class="form-btn col-xs-9" id="addtyreItem" onclick="bindTyre()" style="margin-bottom:10px;"><i class="icon-plus-sign" style="display: inline-block;width: 20px;"></i>选择轮胎</a>
							     <input type="hidden" name="newNo" id="newNo">
							     <div id="newTyreDetail"></div>
							  </div>
							 <hr class="tree" style="margin-top:15px;"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">备注 ：</label>
							     <textarea class="form-control" rows="3" id="mark" name="mark" placeholder="请填写备注  " ></textarea> 
							  </div>													  					  
							    <hr class="tree"></hr>
							    <div class="add-item-btn" id="addBtn">
								    <a class="add-itemBtn btnOk" onclick="save();" style="margin-left: 130px;">保存</a>
								    <a class="add-itemBtn btnOk" onclick="refresh();">关闭</a>
								 </div>
								 <div class="add-item-btn" id="editBtn">
								    <a class="add-itemBtn btnOk" onclick="update()" style="margin-left: 130px;">更新</a>
								    <a class="add-itemBtn btnOk" onclick="refresh()">关闭</a>
								  </div> 
								  <!-- <div class="add-item-btn" id="viewBtn">
								    <a class="add-itemBtn btnOk" onclick="refresh()" style="margin-left: 130px;">关闭</a>
								  </div> -->
								</div>
						  </div>
					</div>
				</div>
				</div>
			</div>
				<!-- 新轮胎信息--Modal begin-->
	<div class="modal fade" id="modal-addCar" tabindex="-1" role="dialog" style="width:1000px;">
		     <div class="modal-header" style="padding:0 15px;">
		        <button class="close" type="button" data-dismiss="modal">×</button>
				<h3 id="myModalLabel">选择轮胎</h3>
		    </div>
			<div class="modal-body" style="height:498px;">
			  <div class="widget-box dia-widget-box">
					<div class="widget-body">
						<div class="widget-main">
							
						<div class="add-item extra-item">
							   <label class="title" style="float: left;width: 50px;">类型：</label>
						<select id="typeSearch" class="form-box" style="width: 234px;float: left">
		   					<option value="">请选择状态</option>
		   					<option value="0">轮胎</option>
		   					<option value="1">钢圈</option>
		   				</select>
						<label class="title" style="float: left;width: 50px;margin-left: 20px;">品牌：</label>	    
						<input id="brandSearch" class="form-box" type="text" placeholder="请输入品牌" style="width:170px;float: left;" />
						<label class="title" style="float: left;width: 50px;margin-left: 20px;">尺寸：</label>
						<input id="sizeSearch" class="form-box" type="text" placeholder="请输入尺寸" style="width:170px;float: left;" /> 
						<a class="add-itemBtntr" onclick="searchChoose()">查询</a>
						 </div>	
					    <hr class="tree"  ></hr>
						  <table id="tyreTable" class="table table-striped table-bordered table-hover">
			                      <thead>
				                    <tr>	
					                   <th class="center"><!-- <input type="checkbox" class="checkall" /> --></th>													
						               <th>序号</th>
						               <th>类型</th>
						               <th>轮胎编号</th>
						               <th>品牌</th>
	                                   <th>尺寸</th>	                                                                                                                                           
				                     </tr>
			                      </thead>
			                      <tbody>
			                       
			                      </tbody>
			                 </table>							   			  
							 <hr class="tree"></hr>
							 <div class="add-item-btn dis-block">
								  <a class="add-itemBtn btnOk" onclick="savetyre();">保存</a>
								  <a class="add-itemBtn btnCancle" onclick="cancleTyre();">关闭</a>
							  </div>			
						</div>
					</div>
			  </div>
			</div>
	</div>
	<!-- 新轮胎信息--Modal end-->
			<div class="modal fade" id="modal-viewinfo" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel-view">查看轮胎更换信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item extra-itemSec">
							     <label class="title">装运车号：</label>
		                        <input type="text" id="carNumber-view" class="form-control"/>
							     <input class="form-control" id="id-hidden-view" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title">原轮胎编号：</label>
							     <input id="oldNo-view" class="form-control" type="text" placeholder="请填写原轮胎编号" style="width:290px;"/>
							     <label class="title" id="oldfilename-view"></label>
							 </div>
							 <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">新轮胎编号：</label>
		                        <input type="text" id="newNo-view" class="form-control"placeholder="请填写新轮胎编号"  style="width:290px;"/>
		                        <label class="title" id="newfilename-view"></label>
							  </div>
							   <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">申请时间：</label>
							    <input type="text" id="applyTime-view" class="form-control"/>
							  </div>
							 <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">备注 ：</label>
							     <textarea class="form-control" rows="3" id="mark-view" name="mark" placeholder="请填写备注  " ></textarea> 
							  </div>													  					  
							    <hr class="tree"></hr>
								  <div class="add-item-btn" id="viewBtn">
								    <a class="add-itemBtn btnOk" onclick="refreshView()" style="margin-left: 130px;">关闭</a>
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
					<h3 id="myModalLabel">上传照片</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
														  
							 <div class="add-item col-xs-12" style="margin-bottom: 10px;margin-top: 20px;">
							   
							    <label class="title col-xs-2" style="width: 120px;">原轮胎照片 ：</label>	
							    <div class="col-xs-10"> 
							     <input type="file" id="oldinputfile" /> <label class="title" id="oldfilename"></label>
							    <input type="hidden" name="oldfilename_hidden" id="oldfilename_hidden"/>
							    <input type="hidden" name="oldfilepath_hidden" id="oldfilepath_hidden"/>
							    <input class="form-control" id="detilid-hidden" type="hidden"/>
							    </div>	
							     <label class="title col-xs-2" style="width: 120px;">新轮胎照片 ：</label>	
							    <div class="col-xs-10"> 
							     <input type="file" id="newinputfile" /> <label class="title" id="newfilename"></label>
							    <input type="hidden" name="newfilename_hidden" id="newfilename_hidden"/>
							    <input type="hidden" name="newfilepath_hidden" id="newfilepath_hidden"/>
							    </div>								    
							   </div>	
							  						  
							    <hr class="tree" style="margin-top: 120px;"></hr>
							    <div class="add-item-btn" id="uploadBtn">
								    <a class="add-itemBtn btnOk" onclick="uploadsave();" style="margin-left: 130px;">确认</a>
								    <a class="add-itemBtn btnOk" onclick="uploadrefresh();">关闭</a>
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
<div id="selectItem8" class="selectItemhidden" style="height: 150px;">
	<div id="selectItemCount" class="selectItemcont">
		<div id="selectCarNo" style="height: 150px;">
											
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
	var myTable = loadTable();
	bindCarNumber(0);//查询条件车号加载
	bindCarNumber(1);//新增，编辑车号加载
	bindNewNo();//绑定新轮胎编号
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
});
/**查询车牌号**/
function searchSchedule(e){
	var $val=$(e).val();
	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/trackTyreMng/getStockList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		data: JSON.stringify({
			no : $val
		}),
		success : function(data) {
			if (data && data.code == 200) {
				var html = "";
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<p id='+data.data[i]['id']+' onclick=\'clickp(this)\'>'+data.data[i]['no']+'</p>';
	            		}
	        		}
	        	}
	        	$('#selectCarNo').html(html);
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
	var A_top = $(e).offset().top + $(e).outerHeight(true); //  1
	var A_left = $(e).offset().left;
	$('#selectItem8').show().css({
		"position" : "absolute",
		"top" : A_top + "px",
		"left" : A_left + "px"
	});
	
}
function clickp(e){
	$('#carNumberSearch').val($(e).html());
	//$('#brandSearch-hidden').val($(e).attr('id'));
	$('#selectItem8').hide();
};
/**查询车牌号**/
function searchCarNo(e){
	var $val=$(e).val();
	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/trackTyreMng/getStockList",
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		data: JSON.stringify({
			no : $val
		}),
		success : function(data) {
			if (data && data.code == 200) {
				var html = "";
				if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	        				html +='<p id='+data.data[i]['no']+' onclick=\'clickpp(this)\'>'+data.data[i]['no']+'</p>';
	            		}
	        		}
	        	}
	        	$('#selectCarNo2').html(html);
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
	var A_top = $(e).offset().top + $(e).outerHeight(true); //  1
	var A_left = $(e).offset().left;
	$('#selectItem9').show().css({
		"position" : "absolute",
		"top" : "40px",
		"left" : "132px"
	});
	if( null == $val || '' == $val)
	{
		$('#carNumber-hidden').val('');
	}
}
/**新增编辑的货运车选择**/
function clickpp(e){
	$('#carNumber').val($(e).html());
	var carNumber = $(e).html();
	$.ajax({  
	    url: '${ctx}/operationMng/trackTyreChangeMng/getOldTyreNo',  
	    type: "post",  
	    contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
	    data: JSON.stringify({
	    	carNumber: carNumber
	    }),
	    success: function (data) {
	        if(data.code == 200){  
	        	if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	        				//console.info(JSON.stringify(data.data));
	        				$('#oldNo').val(data.data[i]["tyreNo"]);
	            		}
	        		}
	        	}else{
	        		$('#oldNo').val('');
	        	}
	           }else{  
	        	   bootbox.alert('加载失败！');
	           }  
	    }  
	  });
	$('#carNumber-hidden').val($(e).attr("id"));
	$('#selectItem9').hide();
};
function loadTable(){
	$('#detailtable').DataTable( {
		"destroy": true,//如果需要重新加载的时候请加上这个
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/trackTyreChangeMng/getListData" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum",'width':'4%' },
		    {data: "carNumber",'width':'10%'},
		    {data: "oldTyreNo",'width':'10%'},
		    {data: "newTyreNo",'width':'10%'},
		    {data: "applyTime",'width':'10%'},
		    {data: "mark",'width':'10%'},
		    {data: "status",'width':'10%'},
		    { data: null,'width':'15%'}],
		    columnDefs: [
			{
				 //指定第4列
				 targets: 4,
			       render: function(data, type, row, meta) {
			    	   if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
			       }	       
			},
		    {
		    	 //指定第6列
		    	 targets: 6,
			        render: function(data, type, row, meta) {
			        	if(data==0){return '新建'}else if(data==1){return '待复核'}else if(data==2){return '已完成'};
			        }	       
		    },
		    {
		        //指定第最后一列
		        targets: 7,
		        render: function(data, type, row, meta) {
		             if(row.status==0){return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
		    			   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
				           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
				           +'<a class="table-upload" onclick="doupload(\''+ row.id +'\',\''+ row.oldTyrePic +'\',\''+ row.newTyrePic +'\')">上传照片</a>';	 
		    		 }else{
		    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';	  
		    		 }
		        }
		    }
		    ],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
  } );
}

//datatables与后台交互获取数据的处理函数
function retrieveData( sSource, aoData, fnCallback ) {   
   var secho=aoData[0]["value"];   
   var pageStartIndex=aoData[3]["value"];
   var pageSize=aoData[4]["value"];
   //console.info($.trim($('#carNumberSearch').val()));
   $('#secho').val(secho);
   var obj = {};
	 $.ajax({
		type : 'POST',
		url : sSource,
		data : JSON.stringify({
			sEcho : $.trim(secho),				
			pageStartIndex : $.trim(pageStartIndex),
			pageSize : $.trim(pageSize),
			carNumber : $.trim($('#carNumberSearch').val()),
			status : $.trim($('#status').val()),
			startTime:$.trim($('#startTime').val()),
			endTime:$.trim($('#endTime').val())
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.log(JSON.stringify(data.data));								
				obj.iTotalDisplayRecords=data.data.totalCounts;
				obj.iTotalRecords=data.data.totalCounts;
				obj.aaData=data.data.records;		
				obj.sEcho=data.data.frontParams;
			//	console.log(JSON.stringify(obj));
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
				//jQuery.messager.alert('提示:',data.msg,'info');selected="selected" 
			}
			
		}
	}); 
}
//绑定车号
function bindCarNumber(sign)
{
	$.ajax({  
	    url: '${ctx}/operationMng/trackTyreChangeMng/getTrackList',  
	    type: "post",  
	    contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
	    data: '',
	    success: function (data) {
	    	var html ='<option value="">请选择装运车号</option>';
	        if(data.code == 200){  
	        	if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<option value='+data.data[i]['no']+'>'+data.data[i]['no']+'</option>';
	            		}
	        		}
	        	}
	        	if(sign == 0)
	        	{
	        		$('#carNumberSearch').html(html);
	        	}
	        	if(sign == 1)
	        	{
	        		$('#carNumber').html(html);
	        	}
	        	
	           }else{  
	        	   bootbox.alert('加载失败！');
	           }  
	    }  
	  }); 
}

function searchInfo()
{
	loadTable();
}


/* 选择轮胎信息 */
function bindTyre(){
	     var size=0,all=0;
		 var html="",htmlItem="";
		 var partId="";
		 var arr=[];
		 $('#newTyreDetail table tbody').find('tr').each(function(){
			 var partItem=$(this).find('td').eq(0).attr('data-id');
			 if(partItem!=null && partItem!=''){
				 partId+=partItem+',';
			 }
			
		 });
		 var type=$('#type').val();
			 partId = partId.substring(0, partId.length-1);
			 arr = partId.split(',');
			 var obj = {};
				 $.ajax({
					type : 'POST',
					url : "${ctx}/operationMng/trackTyreChangeMng/queryTrackTyre",
					contentType : "application/json;charset=UTF-8",
					dataType : 'JSON',
					data : JSON.stringify({
						type : $.trim($('#typeSearch').val()),
						brand : $.trim($('#brandSearch').val()),
						ssize : $.trim($('#sizeSearch').val())
					}),
					success : function(data) {
						if (data && data.code == 200) {	
							if(data.data.length>0){
								for(var i=0;i<data.data.length;i++){
									data.data[i]["rownum"]=i+1;
									if("0" == data.data[i]["type"])
									{
										data.data[i]["type"] = '轮胎';
									}else if("1" == data.data[i]["type"])
									{
										data.data[i]["type"] = '钢圈';
									}else{
										data.data[i]["type"] = '';
									}
									
									if(null == data.data[i]["brand"] || "" == data.data[i]["brand"])
									{
										data.data[i]["brand"] = '';
									}
									if(arr.length>0){
										for(var j=0;j<arr.length;j++){
											if(data.data[i]["id"]==arr[j]){
												htmlItem='<tr class="selected"><td class="text-center"><input type="radio" checked="checked" name="radiotype" class="checkchild"></td>'
												     +'<td data-id="'+data.data[i]["id"]+'">'+data.data[i]["rownum"]+'</td>'
												     +'<td>'+data.data[i]["type"]+'</td>'
												     +'<td>'+data.data[i]["tyreNo"]+'</td>'	
												     +'<td>'+data.data[i]["brand"]+'</td>'
												     +'<td>'+data.data[i]["size"]+'</td></tr>';
												     size++;
												     break;
											}else{
												htmlItem='<tr><td class=" text-center"><input type="radio" name="radiotype" class="checkchild"></td>'
													 +'<td data-id="'+data.data[i]["id"]+'">'+data.data[i]["rownum"]+'</td>'
												     +'<td>'+data.data[i]["type"]+'</td>'
												     +'<td>'+data.data[i]["tyreNo"]+'</td>'	
												     +'<td>'+data.data[i]["brand"]+'</td>'
												     +'<td>'+data.data[i]["size"]+'</td></tr>';
											}
											
										}
										html+=htmlItem;
									}else{
										html+='<tr><td class="text-center"><input type="radio"  name="radiotype" class="checkchild"></td>'
											 +'<td data-id="'+data.data[i]["id"]+'">'+data.data[i]["rownum"]+'</td>'
											 +'<td>'+data.data[i]["type"]+'</td>'
										     +'<td>'+data.data[i]["tyreNo"]+'</td>'	
										     +'<td>'+data.data[i]["brand"]+'</td>'
										     +'<td>'+data.data[i]["size"]+'</td></tr>';
									}
								}
								if(size==all && size>0){
									 checkChooseCar(true);
								 }else{
									 checkChooseCar(false); 
								 }
							}else{
								html+="<tr><td colspan='9'>暂无轮胎信息</td></tr>";
							}
							$('#tyreTable tbody').html(html);
							
						} 
						
					}
				 });
				 $('#modal-addCar').modal('show');
		 
 }

/* 轮胎多选框选择 */
function checkChooseCar(flag){	   
	$('#tyreTable tbody').on( 'click', 'tr', function () {
	  if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true){
			$(this).toggleClass('selected');
	   } 
	   /* if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true){
			$(this).toggleClass('selected');
	   } */ 
	  $('#tyreTable').find('tbody > tr').each(function(){
			var row = this;
			//console.info($(this).find(".checkchild").is(":checked"));
			if($(this).find(".checkchild").is(":checked")!= true)//勾选全部，但是下面每个都去掉勾选，再去掉勾选全部，是不执行任何操作，不然又全部选择了。
			{
				//$(this).find(".radiocheck").removeAttr("checked");//alert('aa'); 
				$(this).removeClass('selected') ;
			} 															
		});
   }); 
	

 }
/* 保存轮胎信息 */
function savetyre(){
	 var idList="";
	    var index=$("#detail-Id").val()
		var table=$('#tyreTable tbody');
		var objs=[];
		var htmlItem='',html="";
		//$('#newTyreDetail').html('');
		if(table.children('tr.selected').length==0){
			 bootbox.alert('请选择新轮胎！');
		}else{
			var obj={};
			var tr=table.children('tr.selected').eq(0);
			obj.id=tr.find('td').eq(1).attr('data-id');
			obj.type=tr.find('td').eq(2).html();
			obj.tyreNo=tr.find('td').eq(3).html();
			obj.brand=tr.find('td').eq(4).html();
			obj.size=tr.find('td').eq(5).html();
			objs.push(obj);
			htmlItem+='<tr><td data-id='+obj.id+'>'+obj.type+'</td><td>'+obj.tyreNo+'</td><td>'+obj.brand+'</td><td>'+obj.size+'</td>'						    
			    +'</tr>';
			 bootbox.confirm({ 
				  size: "small",
				  message: "确定要选择该轮胎吗?", 
				  callback: function(result){
					  if(result){
						
							html='<table class="carList table table-striped table-bordered table-hover">'
						        +'<thead><tr><th>类型</th><th>轮胎编号</th><th>品牌</th><th>尺寸</th></tr></thead>'
						        +'<tbody>'+htmlItem+'</tbody>';
							$('#newTyreDetail').html(html);
							$('#newNo').val(obj.tyreNo);
							$('#modal-addCar').modal('hide');

							
					  }
				  }
			 });
		}
		
	
}
/* 关闭轮胎信息 */
function cancleTyre(){
	 $('#modal-addCar').modal('hide');
}
//绑定新轮胎编号
function bindNewNo()
{
	/* $.ajax({  
	    url: '${ctx}/operationMng/trackTyreChangeMng/queryTrackTyre',  
	    type: "post",  
	    contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
	    data: '',
	    success: function (data) {
	    	var html ='<option value="">请选择新轮胎编号</option>';
	        if(data.code == 200){  
	        	if(data.data!=null && data.data!=''){
	        		if(data.data.length>0){
	        			for(var i=0;i<data.data.length;i++){
	            			html +='<option value='+data.data[i]['tyreNo']+'>'+data.data[i]['tyreNo']+'</option>';
	            		}
	        		}
	        	}
	        	
	        		$('#newNo').html(html);
	        	
	           }else{  
	        	   bootbox.alert('加载失败！');
	           }  
	    }  
	  }); 	 */
}
//新增
function doadd()
{
	clear();
	//bindCarNumber(1);
	//bindNewNo();//绑定新轮胎编号
	//车号选择，更新原轮胎编号

	$('#addBtn').show();
	$('#editBtn').hide();
	//$('#viewBtn').hide();
	$("#carNumber").attr("disabled",false);
	$("#oldNo").attr("disabled",false);
	$("#newNo").attr("disabled",false);
	$("#mark").attr("disabled",false);
	$('#myModalLabel').html('新增轮胎更换信息');	
	$('#modal-info').modal('show');	
}

/* 数据重置 */
function clear(){
	$('#id-hidden').val('');
	$('#carNumber').val('');
	$('#oldNo').val('');	
	$('#newNo').val('');
	$('#mark').val('');
	$('#newTyreDetail').html('');
}

//关闭窗口
function refresh()
{
	clear();
	$('#modal-info').modal('hide');	
}
//关闭窗口--查看
function refreshView()
{
	$('#modal-viewinfo').modal('hide');	
}
//保存
function save()
{
	var flag="false";
	var carNumber = $('#carNumber').val();
	var oldNo = $('#oldNo').val();
	var newNo = $('#newNo').val();
	var mark = $('#mark').val();
	if(carNumber==''|| carNumber==null){
		bootbox.alert('装运车号不能为空！');
		return;
	}
	if(oldNo==''|| oldNo==null){
		bootbox.alert('原轮胎不能为空！');
		return;
	}
	if(newNo==''|| newNo==null){
		bootbox.alert('新轮胎不能为空！');
		return;
	}
	//console.info("carNumber"+carNumber);
	//console.info("oldNo"+oldNo);
	//console.info("newNo"+newNo);
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该轮胎更换信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackTyreChangeMng/save',
						data : JSON.stringify({
							carNumber : carNumber,				
							oldTyreNo : oldNo,
							newTyreNo : newNo,
							mark : mark
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
											  loadTable();
												refresh();
										  }else{
											  loadTable();
												refresh(); 
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										loadTable();
										refresh();
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
//查看
function doview(id){
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackTyreChangeMng/getDetail/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.info(JSON.stringify(data.data));
				$('#id-hidden-view').val(id);
				$('#myModalLabel-view').html('查看轮胎更换信息');			
				$('#carNumber-view').val(data.data.carNumber);
				$('#oldNo-view').val(data.data.oldTyreNo);
				$('#newNo-view').val(data.data.newTyreNo);
				$('#mark-view').val(data.data.mark);
				if(data.data.applyTime!=''&&data.data.applyTime!=null){
					$('#applyTime-view').val(jsonForDateFormat(data.data.applyTime));
				}else{
					$('#applyTime-view').val('');
				}
				if(data.data.oldTyrePic!=''&&data.data.oldTyrePic!=null&&data.data.oldTyrePic!='undefined')
				{
					var oldTyrePics="${ctx}"+data.data.oldTyrePic;
					var htmls='<a  href='+oldTyrePics+' target="_blank">原轮胎图片</a>';
					$('#oldfilename-view').html(htmls);
				}
				if(data.data.newTyrePic!=''&&data.data.newTyrePic!=null&&data.data.newTyrePic!='undefined')
				{
					var newTyrePics="${ctx}"+data.data.newTyrePic;
					var html2='<a href='+newTyrePics+' target="_blank">新轮胎图片</a>';
					$('#newfilename-view').html(html2);
				}				
				$("#carNumber-view").attr("disabled",true);
				$("#oldNo-view").attr("disabled",true);
				$("#newNo-view").attr("disabled",true);
				$("#mark-view").attr("disabled",true);
				$("#applyTime-view").attr("disabled",true);
				/* $('#addBtn').hide();
				$('#editBtn').hide(); */
				$('#viewBtn').show();
				$('#modal-viewinfo').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
//编辑
function doedit(id){
	clear();
	
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/trackTyreChangeMng/getDetail/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑轮胎更换信息');
				$('#carNumber').val(data.data.carNumber);
				$('#oldNo').val(data.data.oldTyreNo);
				//console.info(data.data.newTyreNo);
				$('#newNo').val(data.data.newTyreNo);
				$('#mark').val(data.data.mark);	
				
				$('#addBtn').hide();
				$('#editBtn').show();
				var newNo=data.data.newTyreNo;
				var size=0;
				var htmlItem='',html="";
				var hl = "";
				 $.ajax({
						type : 'POST',
						url : "${ctx}/operationMng/trackTyreChangeMng/queryTrackTyre",
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						data : JSON.stringify({	}),
						success : function(data) {
							if (data && data.code == 200) {	
								if(data.data.length>0){
									if(newNo!=''&&newNo!=null){
										
										for(var i=0;i<data.data.length;i++){
											if("0" == data.data[i]["type"])
											{
												data.data[i]["type"] = '轮胎';
											}else if("1" == data.data[i]["type"]){
												data.data[i]["type"] = '钢圈';
											}else{
												data.data[i]["type"] = '';
											}
											if("null" == data.data[i]["brand"] || null == data.data[i]["brand"])
											{
												data.data[i]["brand"] = '';
											}
												if(data.data[i]["tyreNo"]==newNo){
													htmlItem='<tr><td data-id='+data.data[i]["id"]+'>'+data.data[i]["type"]+'</td>'
														 +'<td>'+data.data[i]["tyreNo"]+'</td>'
														 +'<td>'+data.data[i]["brand"]+'</td>'
														 +'<td>'+data.data[i]["size"]+'</td>'
													     +'</tr>';
													     size++;
													     break;
												}
											}
											//console.info(htmlItem);
											hl += htmlItem
											//console.info(hl);
											//html+=htmlItem;
										
									}
									
								}else{
									html+="<tr><td colspan='9'>暂无轮胎信息</td></tr>";
								}
								html='<table class="carList table table-striped table-bordered table-hover">'
							        +'<thead><tr><th>类型</th><th>轮胎编号</th><th>品牌</th><th>尺寸</th></tr></thead>'
							        +'<tbody>'+hl+'</tbody>';
								$('#newTyreDetail').html(html);
								
							} 
							
						}
					 });
				//$('#viewBtn').hide();
				$('#modal-info').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
//更新
function update()
{
	var flag="false";
	var id = $('#id-hidden').val();
	var carNumber = $('#carNumber').val();
	var oldNo = $('#oldNo').val();
	var newNo = $('#newNo').val();
	var mark = $('#mark').val();
	if(carNumber==''|| carNumber==null){
		bootbox.alert('装运车号不能为空！');
		return;
	}
	if(oldNo==''|| oldNo==null){
		bootbox.alert('原轮胎不能为空！');
		return;
	}
	if(newNo==''|| newNo==null){
		bootbox.alert('新轮胎不能为空！');
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要修改该轮胎更换信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackTyreChangeMng/update',
						data : JSON.stringify({
							id: id,
							carNumber : carNumber,				
							oldTyreNo : oldNo,
							newTyreNo : newNo,
							mark : mark
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
											  loadTable();
												refresh();
										  }else{
											  loadTable();
												refresh(); 
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										loadTable();
										refresh();
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
//删除
function dodelete(id)
{
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除该轮胎更换信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/trackTyreChangeMng/delete/"+id,
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
											  loadTable();
										  }else{
											  loadTable();
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										loadTable();
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
//提交
function dosubmit(id)
{
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交该轮胎更换信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/operationMng/trackTyreChangeMng/submit/"+id,
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
											  loadTable();
										  }else{
											  loadTable();
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										loadTable();
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

function clearupload()
{
	$('#detilid-hidden').val('');
	$('#filepath_hidden').val('');
	$('#filename').html('');	
}
//上传照片
function doupload(id,oldTyrePic,newTyrePic){
	console.info("oldTyrePic"+oldTyrePic);
	clearupload();
	$('#uploadBtn').show();
	$('#detilid-hidden').val(id);
	$('#oldfilepath_hidden').val(oldTyrePic);
	$('#newfilepath_hidden').val(newTyrePic);
	if(oldTyrePic!=''&&oldTyrePic!='null'&&oldTyrePic!=undefined)
	{
		var oldTyrePics="${ctx}"+oldTyrePic;
		var htmls='<a  href='+oldTyrePics+' target="_blank">原轮胎图片</a>';
		$('#oldfilename').html(htmls);
	}
	if(newTyrePic!=''&&newTyrePic!='null'&&newTyrePic!=undefined)
	{
		var newTyrePics="${ctx}"+newTyrePic;
		var htmls='<a href='+newTyrePics+' target="_blank">新轮胎图片</a>';
		$('#newfilename').html(htmls);
	}
	$('#modal-upload').modal('show');
	$("#oldinputfile").uploadify({
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
        'uploader':'${ctx}/upload/saveFile?type=tyreChange',
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
        	//attachFilePath="${ctx}"+attachFilePath;
        	//console.info(attachFilePath);
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#oldfilename').html(html);
        	$('#oldfilename_hidden').val(orginFileName);
        	$('#oldfilepath_hidden').val(attachFilePath);
        }
    });
	$("#newinputfile").uploadify({
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
        'uploader':'${ctx}/upload/saveFile?type=tyreChange',
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
        	//attachFilePath="${ctx}"+attachFilePath;
        	//console.info(attachFilePath);
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#newfilename').html(html);
        	$('#newfilename_hidden').val(orginFileName);
        	$('#newfilepath_hidden').val(attachFilePath);
        }
    });
}
//上传保存
function uploadsave(){
	var flag="false";
	var id=$('#detilid-hidden').val();
	var oldTyrePic=$('#oldfilepath_hidden').val();
	var newTyrePic=$('#newfilepath_hidden').val();
	
	if(oldTyrePic=='' || oldTyrePic== 'null'){
		bootbox.alert('请上传原轮胎照片！');	
		return;
	}
	if(newTyrePic=='' || newTyrePic== 'null'){
		bootbox.alert('请上传新轮胎照片！');	
		return;
	}
		bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存照片信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/trackTyreChangeMng/updateTyrePic',
						data : JSON.stringify({
							id : id,
							oldTyrePic : oldTyrePic,
							newTyrePic : newTyrePic,
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								location.reload();
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
		});
}

function uploadrefresh(){
	$('#modal-upload').modal('hide');	
	
}
</script>
</body>
</html>