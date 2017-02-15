<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>折损出库管理</title>
<link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
		<!-- page specific plugin styles -->
		<!-- ace styles -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" /><!--字体icon-->
		<!-- inline styles related to this page -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
		<!-- ace settings handler -->
		<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
		<style type="text/css">
			#modal-info{
   				width: 1000px;
    			height: 600px;
    			margin: auto;
    			background: rgb(255, 255, 255);
    			overflow: auto;
    			}
    			.col-xs-12{
    margin-bottom:10px;
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
					折损出库管理
				</small>
			</h1>
		</div><!-- /.page-header -->
		<div class="page-content">
			<div class="searchbox col-xs-12">
			   <label class="title">出库原因：</label>
			   <input class="form-box" id="mark" type="text" placeholder="请输入出库原因"/>
			   <label class="title">操作人：</label>			 
			   <input class="form-box" id="userName" type="text" placeholder="请输入操作人"/>
			   <a  id="searchBtn" class="itemBtn" onclick="dosearch()">查询</a>
			   <a  id="saveBtn" class="itemBtn" onclick="add()">新增</a>
				<input type="hidden" id="secho" name="secho">
			</div>
			<div class="detailInfo">
			<table id="dynamic-table" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>	
						<th>序号</th>	
						<th>出库原因</th>												
	                    <th>操作人</th>
	                    <th>操作时间</th>
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
						<h3 id="myModalLabel">折损车出库登记</h3>
					</div>
					<div class="modal-body">
					   <div>
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								  <div class="searchbox col-xs-12 ">
								   
								     <label class="title"><span class="red">*</span>出库原因：</label>
			   						 <input id="markText" type="text" style="width: 450px;"/><span class="red">(必填)</span>
			   						 <input id="id-hidden" type="hidden" style="width: 450px;"/>
								  </div>
								   <div class="col-xs-12 ">								   
								     <label class="title"><span class="red">*</span>选择出库车辆</label>			   						 
								  </div>
								   <div class="col-xs-12"> 
								    <div class="col-xs-1"></div><label class="title">品牌：</label><input id="searchText" type="text" />
								    <a  class="table-edit" onclick="doCarSearch()" style="width: 60px;margin-left:5px;">查询</a>
								    </div>
								    <div class="col-xs-12"> 
								    <div class="col-xs-1"></div>
								    <div class="col-xs-11">
								    <table id="car-table" class="table table-striped table-bordered table-hover">
										<thead>
											<tr>	
												<th class="center">
													<input type="checkbox" class="checkall" />
												</th>
												<th>序号</th>	
												<!-- <th>运单编号</th> -->
												<th>车架号</th>
												<th>车型</th>
												<th>颜色</th>
	                    						<th>入库时间</th>
	                    						<th>品牌</th>
	                    						<th>存放位置</th>
	                    						<th>价格</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								    </div>
								    
								    </div>
									
									
								   <hr class="tree"></hr>
								    <div class="add-item-btn" id="addBtn">
									    <a class="add-itemBtn btnOk" onclick="save();" style="margin-left:300px;">保存</a>
									    <a class="add-itemBtn btnCancle" onclick="cancel();" style="margin-right:300px;">取消</a>
									 </div>
									 <div class="add-item-btn" id="editBtn">
									    <a class="add-itemBtn btnOk" onclick="update()" style="margin-left:300px;">更新</a>
									    <a class="add-itemBtn btnCancle" onclick="cancel()" style="margin-right:300px;">取消</a>
									  </div> 
								
							 </div> 
						</div>
					</div>
					</div>
				</div>
			</div>
			<div class="modal fade" id="modal-einfo" tabindex="-1" role="dialog" data-backdrop="static">
					<div class="modal-header">
						<button class="close" type="button" data-dismiss="modal">×</button>
						<h3 id="myModalLabel">折损车出库信息</h3>
					</div>
					<div class="modal-body">
					   <div>
						  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
								  <div class="searchbox col-xs-12 ">								   
								     <label class="title">出库原因：</label>
								     <label id="mark_view" class="title"></label>
			   						 <!-- <input id="markText" type="text" style="width: 450px;"/><span class="red">(必填)</span>
			   						 <input id="id-hidden" type="hidden" style="width: 450px;"/> -->
								  </div>
								   <div class="col-xs-12 ">								   
								     <label class="title">出库车辆</label>			   						 
								  </div>								   
								    <div class="col-xs-12"> 

								     <table id="cardagout_dagout" class="table table-striped table-bordered table-hover">
                                          <thead>
                                            <tr>
                                                <th>序号</th>	
												<th>车架号</th>
												<th>车型</th>
												<th>颜色</th>
	                    						<th>入库时间</th>
	                    						<th>品牌</th>
	                    						<th>存放位置</th>
	                    						<th>价格</th></tr>
                                          </thead>
                                          <tbody></tbody>
                                        </table>        
								  
								    
								    </div>
									
									
								   <hr class="tree"></hr>
								    <div class="add-item-btn" id="viewBtn">
									    <!-- <a class="add-itemBtn btnOk" onclick="save();" style="margin-left:300px;">保存</a> -->
									    <a class="add-itemBtn btnCancle" onclick="docancel();" >取消</a>
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

<script src="${ctx}/staticPublic/js/jquery-2.0.3.min.js"></script>
		<!-- <![endif]-->
		<!--[if IE]>
		<script src="${ctx}/staticPublic/js/jquery-1.10.2.min.js"></script>
		<![endif]-->
		<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
		<!-- page specific plugin scripts -->
		<script src="${ctx}/staticPublic/js/jquery.dataTables.js"></script>
		<script src="${ctx}/staticPublic/js/jquery.dataTables.bootstrap.js"></script>
		<script src="${ctx}/staticPublic/js/dataTables.select.js"></script>
		<!-- ace scripts -->
		<script src="${ctx}/staticPublic/js/ace-elements.min.js"></script>
		<script src="${ctx}/staticPublic/js/ace.min.js"></script>	
		<script src="${ctx}/staticPublic/js/jsonDataFormat.js"></script>	
		<!-- inline scripts related to this page -->
		<script type="text/javascript" src="${ctx}/staticPublic/js/popbox/Confirm.js"></script>
        <script src="${ctx}/staticPublic/js/bootbox.min.js"></script>
<script type="text/javascript">
$(function() {
	var myTable = loadTable();
	
});

function loadTable(){
	$('#dynamic-table').DataTable( {
		"destroy": true,//如果需要重新加载的时候请加上这个
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/carDamageOutStock/getCarDamData" , //获取数据的ajax方法的URL							 
		 ordering: false,	
			"oLanguage": {
				"sLengthMenu": "每页显示 _MENU_ 条记录",
				"sZeroRecords": "抱歉， 没有找到",
				"sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
				"sInfoEmpty": "",
				"sInfoFiltered": "(从 _MAX_ 条数据中检索)",
				"oPaginate": {
				"sFirst": "首页",
				"sPrevious": "上一页",
				"sNext": "下一页",
				"sLast": "尾页"
				},
				"sZeroRecords": "没有检索到数据"
				},		
		 columns: [
		    { data: "rownum","width":"6%" },
		    {data: "mark","width":"24%"},
		    {data: "userName","width":"10%"},
		    {data: "insertTime","width":"14%"},
		    {data: "status","width":"14%"},
		    {data: null,"width":"16%"}],
		    columnDefs: [
			{
	 			//指定第3列
	 			targets: 3,
       			render: function(data, type, row, meta) 
       			{
       				return format(data,'yyyy-MM-dd HH:mm:ss');
       			}	       
			},
			{
		    	 //指定第4列
		    	 targets: 4,
			        render: function(data, type, row, meta) {
			        	if(data==0){return '新建'}else if(data==1){return '待复核'}else if(data==2){return '已完成'};
			        }	       
		    },
			{
				   //   指定第最后一列
				        targets: 5,
				        render: function(data, type, row, meta) {
				        	if(row.status=='0'){return '<a class="table-edit" onclick="doedit('+ row.id +',\''+row.mark+'\',\''+row.status+'\')" >编辑</a>'+
				            	 '<a class="table-delete" onclick="del('+ row.id +')" >删除</a>'+
				            	 '<a class="table-edit" onclick="submit('+ row.id +')" style="margin-left:5px;" >提交</a>'}
				             else {return '<a class="table-edit" onclick="doview('+ row.id +',\''+row.mark+'\',\''+row.status+'\')">查看</a>'};
				        }
				    }],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
  } );
}

//datatables与后台交互获取数据的处理函数
function retrieveData( sSource, aoData, fnCallback ) {   
   var secho=aoData[0]["value"];   
   var pageStartIndex=aoData[3]["value"];
   var pageSize=aoData[4]["value"];
   //console.info('aaa:'+$('#attName').val());
   $('#secho').val(secho);
   var obj = {};
	 $.ajax({
		type : 'POST',
		url : sSource,
		data : JSON.stringify({
			sEcho : $.trim(secho),				
			pageStartIndex : $.trim(pageStartIndex),
			pageSize : $.trim(pageSize),
			mark : $.trim($('#mark').val()),
			userName : $.trim($('#userName').val()),
			type : 1
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

//日期格式化
var format = function(time, format){
    var t = new Date(time);
    var tf = function(i){return (i < 10 ? '0' : '') + i};
    return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a){
        switch(a){
            case 'yyyy':
                return tf(t.getFullYear());
                break;
            case 'MM':
                return tf(t.getMonth() + 1);
                break;
            case 'mm':
                return tf(t.getMinutes());
                break;
            case 'dd':
                return tf(t.getDate());
                break;
            case 'HH':
                return tf(t.getHours());
                break;
            case 'ss':
                return tf(t.getSeconds());
                break;
        }
    })
}
 
function dosearch()
{
	loadTable();
}

 
//加载选择数据
function showSelect()
{
	$('#car-table').DataTable( {
		"destroy": true,//如果需要重新加载的时候请加上这个
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/carDamageOutStock/getCarDamDataByCarDamInOutId" , //获取数据的ajax方法的URL							 
		 ordering: false,	
			"oLanguage": {
				"sLengthMenu": "每页显示 _MENU_ 条记录",
				"sZeroRecords": "抱歉， 没有找到",
				"sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
				"sInfoEmpty": "",
				"sInfoFiltered": "(从 _MAX_ 条数据中检索)",
				"oPaginate": {
				"sFirst": "首页",
				"sPrevious": "上一页",
				"sNext": "下一页",
				"sLast": "尾页"
				},
				"sZeroRecords": "没有检索到数据"
				},		
		 columns: [{
             "sClass": "text-center",
             "data": "id",
             "width":"4%" ,             
             "render": function (data, type, full, meta) {
            	 //console.info(JSON.stringify(full.id));
            	 //console.info(JSON.stringify(full));
                 //return '<input type="checkbox"  class="checkchild"  value="' + full.id + '" />';
                 if(full.carDamInOutId!=''&&full.carDamInOutId!=null){
            		 return '<input type="checkbox"  class="checkchild" checked="checked" value="' + data + '" />';
            	 }else{
            		 return '<input type="checkbox"  class="checkchild"  value="' + data + '" />'; 
            	 }
             },
             "bSortable": false
         	},
		    { data: "rownum" ,"width":"6%" },
		    //{data: "waybillId"},
		    {data: "vin","width":"10%" },
		    {data: "model","width":"10%" },
		    {data: "color","width":"10%" },
		    {data: "insertTime","width":"15%" },
		    {data: "brand","width":"10%" },
		    {data: "position","width":"10%" },
		    {
	             "sClass": "text-center",
	             "data": "amount",
	             "width":"10%",
	             "render": function (data, type, full, meta) {
	            	 //console.info(JSON.stringify(full.id));
	            	//console.info(JSON.stringify(full));
	            	//console.info(full.amount==null);
	            	 if(data==null){data=''}
            		 return '<span class="red">*</span><input type="text"  class="text" id="amount'+full.rownum+'"  value="' + data + '" />'; 
	             },
	             "bSortable": false
	         	},],
		    columnDefs: [
			{
	 			//指定第5列
	 			targets: 5,
       			render: function(data, type, row, meta) 
       			{ if(data!=''&&data!=null){
       				return format(data,'yyyy-MM-dd');
       			}
       				
       			}	       
			}],
	        "fnServerData":retrieveDataCarTable //与后台交互获取数据的处理函数
  });
	
}

//datatables与后台交互获取数据的处理函数
function retrieveDataCarTable( sSource, aoData, fnCallback ) {   
   var secho=aoData[0]["value"];   
   var pageStartIndex=aoData[3]["value"];
   var pageSize=aoData[4]["value"];
   //console.info('aaa:'+$('#attName').val());
   $('#secho').val(secho);
   var obj = {};
	 $.ajax({
		type : 'POST',
		url : sSource,
		data : JSON.stringify({
			sEcho : $.trim(secho),				
			pageStartIndex : $.trim(pageStartIndex),
			pageSize : $.trim(pageSize),
			brand : $.trim($('#searchText').val()),
			carDamInOutId : $.trim($('#id-hidden').val())
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
				$('#car-table tbody tr').each(function(){
					//console.log($(this).find(".checkchild").is(":checked"));
					 if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true)
						{
							$(this).toggleClass('selected');
						} 
						 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true)
						{
							$(this).toggleClass('selected');
						}
				});
			} else {
				 bootbox.alert(data.msg);
				//jQuery.messager.alert('提示:',data.msg,'info');selected="selected" 
			}
			
		}
	}); 
}

//品牌快速查询
function doCarSearch()
{
	showSelect()	
}

//新增
function add(){
	clear();
	$('#addBtn').show();
	$('#editBtn').hide();
	$('#myModalLabel').html('折损车出库登记');
	showSelect();
	checkChooseCar();
	$('#modal-info').modal('show');
}
//清除
function clear()
{
	$('#markText').val('');
	$('#searchText').val('');
	$('#id-hidden').val('');
	$(".checkall").attr("checked",false);
}
/* 关闭窗体 */
function cancel(){
	clear();
	$('#modal-info').modal('hide');
}

//勾选控制
function checkChooseCar(){
	 $(".checkall").click(function () {
	      var check = $(this).prop("checked");
	      $(".checkchild").prop("checked", check);
	      
	      $('#car-table').find('tbody > tr').each(function(){
				var row = this;
				//alert($(".checkall").is(":checked"));
				//alert($(this).hasClass('selected'));
				if($(".checkall").is(":checked") != true && $(this).hasClass('selected') != true)//勾选全部，但是下面每个都去掉勾选，再去掉勾选全部，是不执行任何操作，不然又全部选择了。
				{
					//alert('aa');
				} 
				else
				{
					$(this).toggleClass('selected');
				}
				
			});
	});
	
	var table = $('#car-table').DataTable();
	$('#car-table tbody').on( 'click', 'tr', function () {
		//$(this).toggleClass('selected');
		//alert($(this).hasClass('selected'));
		 if($(this).find(".checkchild").is(":checked") == true && $(this).hasClass('selected') != true)
		{
			$(this).toggleClass('selected');
		} 
		 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') == true)
		{
			$(this).toggleClass('selected');
		}
		 if($(this).find(".checkchild").is(":checked") != true && $(this).hasClass('selected') != true)
			{
			 $(".checkall").attr("checked",false);
			}
		 if($("input[type='checkbox']:checked").size()==$("input[type='checkbox']").size()-1)
			{
			 $(".checkall").attr("checked",true);
			}
       
   }); 
 }
 
//保存
function save()
{
	var flag="false";
		 var table = $('#car-table').DataTable();
		 var obj = {};
		 if($.trim($('#markText').val()) != null && $.trim($('#markText').val()) != "")
		 {
			 obj.mark = $.trim($('#markText').val());
		 }
		 else
		 {
			 bootbox.alert("请填写出库原因");
			 return false;
		 }
		 var newArray = [];
		 for(var i = 0;i<table.rows('.selected').data().length;i++)
		 {
			 var j=i+1;
			 var objdes = {};
			// console.info( $('#amount'+j).val());
			 objdes.id = table.rows('.selected').data()[i]["id"];
			 //objdes.waybillId = table.rows('.selected').data()[i]["waybillId"];
			 objdes.brand = table.rows('.selected').data()[i]["brand"];
			 objdes.vin = table.rows('.selected').data()[i]["vin"];
			 objdes.model = table.rows('.selected').data()[i]["model"];
			 objdes.color = table.rows('.selected').data()[i]["color"];
			 objdes.engineNo = table.rows('.selected').data()[i]["engineNo"];
			 objdes.position = table.rows('.selected').data()[i]["position"];
			 objdes.amount = $('#amount'+j).val();
			 if($('#amount'+j).val()==''&&$('#amount'+j).val()==null){
				 bootbox.alert("请填写第"+j+"行价格！");
				 return false; 
			 }
			 newArray.push(objdes);
			 
		 }
        //console.info( JSON.stringify(table.rows('.selected').data()) );
        //alert( table.rows('.selected').data().length +' row(s) selected' );
        if(newArray.length ==0)
		 {
        	bootbox.alert("请勾选要出库的数据");
			 return false;
		 }
		 obj.detailList = newArray;
		 //alert(JSON.stringify(obj)); 	
		  bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该数据?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type:'post',
						url : "${ctx}/operationMng/carDamageOutStock/save",
			     		data : JSON.stringify(obj),
			     		contentType : "application/json;charset=UTF-8",
			     		dataType : 'JSON',
			     		success : function(data){
			     			if(data && data.code == 200)
			     			{
			     				bootbox.confirm_alert({ 
									  size: "small",
									  message: "保存成功！", 
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
								 cancel(); 
			     			}else
			     			{
			     				bootbox.alert(data.msg);
			     			}
			     		}
						});	  
			  }}})
		  
		
}

function doedit(id,mark,status)
{
	clear();
	var bidArray = [];
	if(status == 0)
	{
		$('#addBtn').hide();
		$('#editBtn').show();
	}
	else
	{
		$('#addBtn').hide();
		$('#editBtn').hide();
	}
	$('#myModalLabel').html('折损车出库登记');
	$('#markText').val(mark);
	$('#id-hidden').val(id);
	
/* 	$.ajax({
		type:'post',
		url : "${ctx}/operationMng/carDamageOutStock/getOutListById",
 		data : {id:id},
 		dataType : 'JSON',
 		success : function(data){
 			if(data && data.code == 200)
 			{
 				//console.info( JSON.stringify(data));
 				if(data.data.length > 0)
 				{
 					for(var i = 0;i<data.data.length;i++)
 					{
 						 var bid = data.data[i]["businessId"];
 						console.info(bid);
 						$('#car-table').find('tbody > tr ').each(function(){
 							debugger;
 							$(this).attr("checked","checked");
 							console.info($(this));
 							console.info('aa');
 						}); 
 						bidArray.push(data.data[i]["businessId"]);
 					}
 				}
 				//console.info(JSON.stringify(bidArray));
 			}else
 			{
 				bootbox.alert(data.msg);
 			}
 		}
		}); */
	
	//showSelect();
	//alert(id);
	/* var html="",htmlItem="";
   var secho='1';   
   var pageStartIndex='0';
   var pageSize=1000;
   $('#secho').val(secho);
   var obj = {};
	 $.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/carDamageMng/getListData",
		data : JSON.stringify({
			sEcho : $.trim(secho),				
			pageStartIndex : $.trim(pageStartIndex),
			pageSize : $.trim(pageSize),
			brand : $.trim($('#searchText').val()),
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
				if(obj.aaData.length>0)
				{
					for(var i=0;i<obj.aaData.length;i++)
					{
						obj.aaData[i]["rownum"]=i+1;
						if(obj.aaData[i]["insertTime"] != null && obj.aaData[i]["insertTime"] != "")
						{
							obj.aaData[i]["insertTime"] = format(obj.aaData[i]["insertTime"],'yyyy-MM-dd');
						}
						if(obj.aaData[i]["position"] == null )
						{
							obj.aaData[i]["position"] = "";
						}
						if(bidArray.length > 0)
						{
							for(var j = 0;j<bidArray.length;j++)
							{
								if(obj.aaData[i]["id"] == bidArray[j])
								{
									//console.info(obj.aaData[i]["id"]);
									htmlItem ='<tr class="selected"><td class=" text-center"><input type="checkbox" checked="checked" class="checkchild"></td>'
									     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
									     //+'<td>'+obj.aaData[i]["waybillId"]+'</td>'
									     +'<td>'+obj.aaData[i]["vin"]+'</td>'
									     +'<td>'+obj.aaData[i]["model"]+'</td>'
									     +'<td>'+obj.aaData[i]["color"]+'</td>'
									     +'<td>'+obj.aaData[i]["insertTime"]+'</td>'
									     +'<td>'+obj.aaData[i]["brand"]+'</td>'
									     +'<td>'+obj.aaData[i]["position"]+'</td></tr>';
									     break;//相等就停止循环
									     
								}
								else
								{
									htmlItem ='<tr><td class=" text-center"><input type="checkbox" class="checkchild"></td>'
									     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
									     //+'<td>'+obj.aaData[i]["waybillId"]+'</td>'
									     +'<td>'+obj.aaData[i]["vin"]+'</td>'
									     +'<td>'+obj.aaData[i]["model"]+'</td>'
									     +'<td>'+obj.aaData[i]["color"]+'</td>'
									     +'<td>'+obj.aaData[i]["insertTime"]+'</td>'
									     +'<td>'+obj.aaData[i]["brand"]+'</td>'
									     +'<td>'+obj.aaData[i]["position"]+'</td></tr>';
								}
							}
							//console.info(htmlItem);
							html+=htmlItem;
							
						}
						else
						{
							html='<tr ><td class=" text-center"><input type="checkbox" class="checkchild"></td>'
							     +'<td data-id="'+obj.aaData[i]["id"]+'">'+obj.aaData[i]["rownum"]+'</td>'
							     //+'<td>'+obj.aaData[i]["waybillId"]+'</td>'
							     +'<td>'+obj.aaData[i]["vin"]+'</td>'
							     +'<td>'+obj.aaData[i]["model"]+'</td>'
							     +'<td>'+obj.aaData[i]["color"]+'</td>'
							     +'<td>'+obj.aaData[i]["insertTime"]+'</td>'
							     +'<td>'+obj.aaData[i]["brand"]+'</td>'
							     +'<td>'+obj.aaData[i]["position"]+'</td></tr>';
						}
					}
				}else{
					html+="<tr><td colspan='9'>暂无商品车信息</td></tr>";
				}
				$('#car-table tbody').html(html);
			} else {
				 bootbox.alert(data.msg);
			}
			
		}
	}); */
	showSelect();
	$('#modal-info').modal('show');	
	
	checkChooseCar();
}



function update()
{
	var flag="false";
	  var table = $('#car-table').DataTable();
	 var obj = {};
	 if($.trim($('#markText').val()) != null && $.trim($('#markText').val()) != "")
	 {
		 obj.mark = $.trim($('#markText').val());
	 }
	 else
	 {
		 bootbox.alert("请填写出库原因");
		 return false;
	 }
	 var newArray = [];
	 console.info(table.rows('.selected').data().length);
	 for(var i = 0;i<table.rows('.selected').data().length;i++)
	 {
		 var objdes = {};
		 var j=i+1;
		 objdes.id = table.rows('.selected').data()[i]["id"];
		 objdes.waybillId = table.rows('.selected').data()[i]["waybillId"];
		 objdes.brand = table.rows('.selected').data()[i]["brand"];
		 objdes.vin = table.rows('.selected').data()[i]["vin"];
		 objdes.model = table.rows('.selected').data()[i]["model"];
		 objdes.color = table.rows('.selected').data()[i]["color"];
		 objdes.engineNo = table.rows('.selected').data()[i]["engineNo"];
		 objdes.position = table.rows('.selected').data()[i]["position"];
		 objdes.amount = $('#amount'+j).val();
		 if($('#amount'+j).val()==''&&$('#amount'+j).val()==null){
			 bootbox.alert("请填写第"+j+"行价格！");
			 return false; 
		 }
		 //console.info(JSON.stringify(objdes));
		 newArray.push(objdes);
		 //console.info(JSON.stringify(table.rows('.selected').data()[i]));
	 }
    //console.info( JSON.stringify(table.rows('.selected').data()) );
    //alert( table.rows('.selected').data().length +' row(s) selected' );
    if(newArray.length ==0)
	 {
    	bootbox.alert("请勾选要出库的数据");
		 return false;
	 } 
    obj.id = $.trim($('#id-hidden').val());
    obj.detailList = newArray;
	//alert(JSON.stringify(obj));
	 
    bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该数据?", 
		  callback: function(result){
			  if(result){
					/* var table=$('#car-table tbody');
					var obj = {};
					var detailList=[];
					var htmlItem='',html="";
					for(i=0;i<table.children('tr.selected').length;i++)
					{
						var objdes={};
						var tr=table.children('tr.selected').eq(i);
						objdes.id=tr.find('td').eq(1).attr('data-id');
			 			objdes.waybillId = tr.find('td').eq(2).html();
			 			objdes.vin = tr.find('td').eq(3).html();
			 			objdes.model = tr.find('td').eq(4).html();
			 			objdes.color =tr.find('td').eq(5).html();
			 			objdes.brand = tr.find('td').eq(7).html();
			 			objdes.position = tr.find('td').eq(8).html();
			 			detailList.push(objdes);
					}
					obj.id = $.trim($('#id-hidden').val());
					obj.mark = $.trim($('#markText').val());
					obj.detailList = detailList; */
					//alert(JSON.stringify(obj)); 
					$.ajax({
						type:'post',
						url : "${ctx}/operationMng/carDamageOutStock/update",
			     		data : JSON.stringify(obj),
			     		contentType : "application/json;charset=UTF-8",
			     		dataType : 'JSON',
			     		success : function(data){
			     			if(data && data.code == 200)
			     			{
			     				/* loadTable();
			     				bootbox.alert("修改成功"); */
			     				bootbox.confirm_alert({ 
									  size: "small",
									  message: "保存成功！", 
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
			     			}else
			     			{
			     				bootbox.alert(data.msg);
			     			}
			     		}
						});
					 cancel(); 
					
			  }
		  }
    });
	
}
//删除
function del(id)
{
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该数据?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type:'post',
						url : "${ctx}/operationMng/carDamageOutStock/delete",
			     		data : {id:id},
			     		dataType : 'JSON',
			     		success : function(data){
			     			if(data && data.code == 200)
			     			{
			     				/* loadTable();
			     				bootbox.alert("删除成功"); */
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
			     			}else
			     			{
			     				bootbox.alert(data.msg);
			     			}
			     		}
						});
			  }
		}
	});
}

//提交
function submit(id)
{
	var flag="false";
	bootbox.confirm({
		size:"small",
		message:"确定提交该数据？",
		callback:function(result){
			if(result)
			{
				$.ajax({
					type:'post',
					url : "${ctx}/operationMng/carDamageOutStock/submit",
            		data :{id:id},
            		dataType : 'JSON',
            		success : function(data){
            			if(data && data.code == 200)
            			{
            				/*  loadTable();
            				 bootbox.alert("提交成功"); */
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
            			}else
            			{
            				bootbox.alert(data.msg);
            			}
            		}
				});
			}
		}
	});
}
function doview(id,mark,status){
	$('#modal-einfo').modal('show');
	$('#viewBtn').show();
	$.ajax({
		type : 'POST',
		url : "${ctx}/operationMng/carDamageOutStock/getById",
		dataType : 'JSON',
		data :{id:id},
		success : function(data) {
			if (data && data.code == 200) {
				//console.log(JSON.stringify(data.data));
				$('#mark_view').html(data.data.mark);
				if(data.data.detailList.length>0){
					for(var i=0;i<data.data.detailList.length;i++){
						data.data.detailList[i]["rownum"]=i+1;
					}
					$('#cardagout_dagout').dataTable({
						 "destroy": true,//如果需要重新加载需销毁
						 dom: 'Bfrtip',
						 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
						 "bFilter": false,    //不使用过滤功能  
						 "bProcessing": true, //加载数据时显示正在加载信息	
						 "bPaginate" : false,
						 "bInfo" : false,
						  ordering: false,
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
				            { data: 'rownum' ,"width":"6%" },
				            {data: "vin","width":"16%" },
						    {data: "model","width":"12%" },
						    {data: "color","width":"10%" },
						    {data: "insertTime","width":"16%" },
						    {data: "brand","width":"10%" },
						    {data: "position","width":"10%" },
						    {data: "amount","width":"10%" }],
						    columnDefs: [{
								 //入职时间
								 targets: 4,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }			
							       }	       
							}]
					});	
				}
			} else {
				bootbox.alert(data.msg);
			}
		}
		
	});
}

/* 关闭窗体 */
function docancel(){
	$('#modal-einfo').modal('hide');
}
</script>
</body>
</html>