<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>折损车出库登记</title>
	<link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
		<!-- page specific plugin styles -->
		<!-- ace styles -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" /><!--字体icon-->
		<!-- inline styles related to this page -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
		<!-- ace settings handler -->
		<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
</head>
<body class="white-bg">
	<div class="page-content">
	<div class="page-header">
		<h1>
			运营管理
			<small>
				<i class="icon-double-angle-right"></i>
				折损车出库登记
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title"><span class="red">*</span>出库原因：</label>
		   <input id="mark" type="text" /><span>必填</span>
		   <a href="#" id="saveBtn" class="itemBtn" >保存</a>
			<input type="hidden" id="secho" name="secho">
		</div>
		<div class="detailInfo">
		<label class="title">快速查询：</label><input id="searchText" type="text" />
		<table id="dynamic-table" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>	
					<th class="center">
						<input type="checkbox" class="checkall" />
					</th>
					<th>序号</th>													
					<th>运单编号</th>
					<th>车架号</th>
					<th>车型</th>
					<th>颜色</th>
                    <th>入库时间</th>
                    <th>品牌</th>
                    <th>存放位置</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
		
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
		<!-- inline scripts related to this page -->
		<script type="text/javascript" src="${ctx}/staticPublic/js/popbox/Confirm.js"></script>
        <script src="${ctx}/staticPublic/js/bootbox.min.js"></script>
<script type="text/javascript">
jQuery(function($) {
	var myTable = loadTable();
	 $(".checkall").click(function () {
	      var check = $(this).prop("checked");
	      $(".checkchild").prop("checked", check);
	      
	      $('#dynamic-table').find('tbody > tr').each(function(){
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
	
	var table = $('#dynamic-table').DataTable();
	$('#dynamic-table tbody').on( 'click', 'tr', function () {
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
        
    }); 
	
	 $('#saveBtn').click( function () {
		 var obj = {};
		 if($.trim($('#mark').val()) != null && $.trim($('#mark').val()) != "")
		 {
			 obj.mark = $.trim($('#mark').val());
		 }
		 else
		 {
			 bootbox.alert("请填写出库原因");
		 }
		 var newArray = [];
		 for(var i = 0;i<table.rows('.selected').data().length;i++)
		 {
			 var objdes = {};
			 objdes.waybillId = table.rows('.selected').data()[i]["waybillId"];
			 objdes.brand = table.rows('.selected').data()[i]["brand"];
			 objdes.vin = table.rows('.selected').data()[i]["vin"];
			 objdes.model = table.rows('.selected').data()[i]["model"];
			 objdes.color = table.rows('.selected').data()[i]["color"];
			 objdes.engineNo = table.rows('.selected').data()[i]["engineNo"];
			 objdes.position = table.rows('.selected').data()[i]["position"];
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
			 obj.detailList = newArray;
			 alert(JSON.stringify(obj)); 
			 
				bootbox.confirm({
					size:"small",
					message:"确定要保存？",
					callback:function(result){
						if(result)
						{
							$.ajax({
								type:'post',
								url : "${ctx}/operationMng/carDamageOutStock/save",
			            		data : JSON.stringify(obj),
			            		contentType : "application/json;charset=UTF-8",
			            		dataType : 'JSON',
			            		success : function(data){
			            			if(data && data.code == 200)
			            			{
			            				 //loadTable();
			            				bootbox.alert("保存成功");
			            			}else
			            			{
			            				bootbox.alert(data.msg);
			            			}
			            		}
							});
						}
					}
				});
	    }); 
	
	 $('#searchText').keydown(function(event){
		 if(event.keyCode==13)
		 {  
			 //console.info($(this).val());
			 dosearch();
		 }  
		 
	 });

});  
function loadTable(){
	$('#dynamic-table').DataTable( {
		"destroy": true,//如果需要重新加载的时候请加上这个
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/carDamageOutStock/getPageData" , //获取数据的ajax方法的URL							 
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
             "data": "ID",
             "render": function (data, type, full, meta) {
                 return '<input type="checkbox"  class="checkchild"  value="' + data + '" />';
             },
             "bSortable": false
         	},
		    { data: "rownum" },
		    {data: "waybillId"},
		    {data: "vin"},
		    {data: "model"},
		    {data: "color"},
		    {data: "insertTime"},
		    {data: "brand"},
		    {data: "position"}],
		    columnDefs: [
			{
	 			//指定第6列
	 			targets: 6,
       			render: function(data, type, row, meta) 
       			{
       				return format(data,'yyyy-MM-dd');
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
</script>
</body>
</html>