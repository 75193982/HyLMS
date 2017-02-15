 
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
		<link rel="stylesheet" type="text/css" href="${ctx}/staticPublic/themes/icon.css"></link>
		<link rel="stylesheet" href="${ctx}/staticPublic/css/datetimepicker.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
	</head>
<body class="white-bg">
	<div class="page-content">
		<div class="page-header">
			<h1>
				财务管理
				<small>
					<i class="icon-double-angle-right"></i>
					工资发放管理
				</small>
			</h1>
		</div><!-- /.page-header -->
	  <div class="detailInfo p5">
	     <div class="searchbox col-xs-12">
              <label class="title" style="float: left;height: 34px;line-height: 34px;">工资归属时间：</label>
			    <div class="input-group input-group-sm" style="float: left;width: 150px;height:34px;margin-right:30px; margin-left: 5px;">
					<input class="form-control" id="startTime" readonly="readonly" type="text" placeholder="工资归属时间" style="height: 34px;font-size: 14px;" onchange="changeSalary(this)" />
						<span class="input-group-addon">
							<i class="icon-calendar"></i>
						</span>
				</div>
				<!-- <label class="title" style="float: left;height: 34px;line-height: 34px;">人数：</label>
				<input class="form-control" id="sumPeople" disabled="disabled" style="width:150px;"/>
				<label class="title" style="float: left;height: 34px;line-height: 34px;">总金额：</label>
				<input class="form-control" id="sumMoney" disabled="disabled" style="width:150px;"/> -->
		        <a class="itemBtn" id="openSchedule" onclick="save()">保存</a>
				<a class="itemBtn" id="saveSchedule" onclick="check()">发放</a> 
		       <div class="clear"></div>
		   </div>
		   <!-- 明细Grid------begin-->
	      <table class="easyui-datagrid" id="mytable" style="width:100%;height:600px" data-options="fitColumns:true,singleSelect:true,onLoadSuccess:onLoadSuccess,rownumbers:true">   
			    <thead>   
			        <tr>    
			            <th data-options="field:'userName',width:'11%',align:'center'">用户名</th>   
			            <th data-options="field:'departmentName',width:'12%',align:'center'">部门</th> 
			            <th data-options="field:'dutyName',width:'12%',align:'center'">岗位</th>  
			            <th data-options="field:'basicSalary',width:'11%',align:'center',editor:{type:'numberbox',options:{precision:2}},formatter:setnumcolor">基本工资</th>
			            <th data-options="field:'allowanceDistance',width:'11%',align:'center',editor:{type:'numberbox',options:{precision:2}},formatter:setnumcolor">里程数(公里)</th>
			            <th data-options="field:'allowanceAmount',width:'11%',align:'center',editor:{type:'numberbox',options:{precision:2}},formatter:setnumcolor">补助合计</th>
			            <th data-options="field:'fineAmount',width:'11%',align:'center',editor:{type:'numberbox',options:{precision:2}},formatter:setnumcolor">罚扣合计</th>
			            <th data-options="field:'amount',width:'11%',align:'center'">应发合计  </th>  
			            <th data-options="field:'id',width:'8%',formatter:formatOper">操作</th>
			            <th data-options="field:'userId',width:1,hidden:'true'"></th>
			            <th data-options="field:'departmentId',width:1,hidden:'true'"></th>    
			        </tr>   
			    </thead>  
			</table>
	     <!-- 明细Grid------end-->
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
<script src="${ctx}/staticPublic/js/easyUI/setnumcolor.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
   /* easyUI全局  begin*/
      var ai = "";
			var fieldName = "";//点击的列field
			var maincurRow = "";//主页面表格行索引
			//var selectRow = "";//选择行
			var saveclick  = 0;
			var rowNo= 0;
			var clickIndex = [];//单击行的索引数组
			var selectedData = [];//选中的数据集合
			var carType ='';
			$.extend($.fn.datagrid.methods, {
				editCell: function(jq,param){
					return jq.each(function(){
						var opts = $(this).datagrid('options');
						var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
						for(var i=0; i<fields.length; i++){
							var col = $(this).datagrid('getColumnOption', fields[i]);//每列的field 
							col.editor1 = col.editor;//每列的editor
							if (fields[i] != param.field){
								col.editor = null;
							}
						}
						$(this).datagrid('beginEdit', param.index);
		                var ed = $(this).datagrid('getEditor', param);
		                if (ed){
		                    if ($(ed.target).hasClass('textbox-f')){
		                    	$(ed.target).textbox('textbox').focus();//获得焦点
		                        $(ed.target).next("span").children().first().one('blur', function (e) {
		                        	var eds = $('#mytable').datagrid('getRows'); 
		                        });
		                        /* 数量   basicSalary，allowanceAmount，fineAmount*/
		                        if(param.field == "basicSalary"){
		                        	   var amount="0";
			                    	   $(ed.target).textbox('textbox').on('blur',function(){
			                    		   var rowSelected = $('#mytable').datagrid('getSelected');
			                    		   amount=parseFloat($(this).val().trim())+parseFloat(rowSelected.allowanceAmount)-parseFloat(rowSelected.fineAmount);
			                    		   $('#mytable').datagrid('updateRow',{
            	    							index: param.index,
            	    							row: {
            	    								basicSalary:$(this).val(),
            	    								amount: amount.toFixed(2)
            	    								}
            	    						});
			                    		   //合计更新
			                    		   $('#mytable').datagrid('updateRow',{
           	    							index: $('#mytable').datagrid('getRows').length-1,
           	    							row: {
           	    								basicSalary:editCompute("basicSalary"),
           	    								amount: editCompute("amount")
           	    								}
           	    						});
			                    	   });
			                     }
		                        //ww 2017.2.7 公里数
		                        if(param.field == "allowanceDistance"){
		                        	   var allowanceAmount="0";
		                        	   var amount="0";
			                    	   $(ed.target).textbox('textbox').on('blur',function(){
			                    		   var rowSelected = $('#mytable').datagrid('getSelected');
			                    		   if(($(this).val()-'${distance}') > 0)
			                    		   {
			                    			   var cha = $(this).val()-'${distance}';
			                    			   var val = (cha * '${price}').toFixed(2);
			                    			   allowanceAmount=val;
			                    			   amount=(parseFloat(rowSelected.basicSalary)+parseFloat(allowanceAmount)-parseFloat(rowSelected.fineAmount)).toFixed(2);
			                    		   }
			                    		$('#mytable').datagrid('updateRow',{
      	    							index: param.index,
      	    							row: {
      	    								allowanceDistance:$(this).val(),
      	    								allowanceAmount: allowanceAmount,
      	    								amount: amount
      	    								}
      	    						});
			                    		$('#mytable').datagrid('updateRow',{
           	    							index: $('#mytable').datagrid('getRows').length-1,
           	    							row: {
           	    								allowanceAmount:editCompute("allowanceAmount"),
           	    								amount: editCompute("amount")
           	    								}
           	    						});
			                      });
			                     }
		                        
		                        if(param.field == "allowanceAmount"){
		                        	   var amount="0";
			                    	   $(ed.target).textbox('textbox').on('blur',function(){
			                    		   var rowSelected = $('#mytable').datagrid('getSelected');
			                    		   amount=parseFloat(rowSelected.basicSalary)+parseFloat($(this).val().trim())-parseFloat(rowSelected.fineAmount);
			                    		   $('#mytable').datagrid('updateRow',{
         	    							index: param.index,
         	    							row: {
         	    								allowanceAmount:$(this).val(),
        	    								amount: amount.toFixed(2)
         	    								}
         	    						});
			                    		   $('#mytable').datagrid('updateRow',{
	           	    							index: $('#mytable').datagrid('getRows').length-1,
	           	    							row: {
	           	    								allowanceAmount:editCompute("allowanceAmount"),
	           	    								amount: editCompute("amount")
	           	    								}
	           	    						});
			                    	   });
			                     }
		                        if(param.field == "fineAmount"){
		                        	   var amount="0";
			                    	   $(ed.target).textbox('textbox').on('blur',function(){
			                    		   var rowSelected = $('#mytable').datagrid('getSelected');
			                    		   amount=parseFloat(rowSelected.basicSalary)+parseFloat(rowSelected.allowanceAmount)-parseFloat($(this).val().trim());
			                    		   $('#mytable').datagrid('updateRow',{
         	    							index: param.index,
         	    							row: {
         	    								fineAmount:$(this).val(),
        	    								amount: amount.toFixed(2)
         	    								}
         	    						});
			                    		   $('#mytable').datagrid('updateRow',{
	           	    							index: $('#mytable').datagrid('getRows').length-1,
	           	    							row: {
	           	    								fineAmount:editCompute("fineAmount"),
	           	    								amount: editCompute("amount")
	           	    								}
	           	    						});
			                    	   });
			                     }
		                    	 
		                    }else{
		                       $(ed.target).focus();
		                      

		                    }
		                    
		                }
						for(var i=0; i<fields.length; i++){
							var col = $(this).datagrid('getColumnOption', fields[i]);
							col.editor = col.editor1;
						}
					});
				},
		        enableCellEditing: function(jq){
		            return jq.each(function(){
		                var dg = $(this);
		                var opts = dg.datagrid('options');
		                opts.oldOnClickCell = opts.onClickCell;
		                opts.onClickCell = function(index, field){
		                	fieldName = field;
		                	maincurRow = index;//点击加入当前行索引
		                    if (opts.editIndex != undefined){//editIndex为编辑的索引值,这里仅为引用
		                        if (dg.datagrid('validateRow', opts.editIndex)){
		                            dg.datagrid('endEdit', opts.editIndex);
		                            opts.editIndex = undefined;
		                        } else {
		                            return;
		                        }
		                    }
		                    dg.datagrid('selectRow', index).datagrid('editCell', {
		                        index: index,
		                        field: field
		                    });
		                    
		                    opts.editIndex = index;
		                    opts.oldOnClickCell.call(this, index, field);
		                }
		                
		                $(document).click(function(event) {
		        			
		        				if(event.target.getAttribute('class') != "" && event.target.getAttribute('class') != null)
		            			{
		            				if(event.target.getAttribute('class').indexOf('datagrid-cell') == -1)//是否点击表格cell 不包含
		            				{
		            					dg.datagrid('endEdit', opts.editIndex);
		            				}
		            			}
		            			else
		            			{
		            				if($(event.target).text().trim() != "")
		                			{
		            					dg.datagrid('endEdit', opts.editIndex);
		                			}
		            			}
		        			
		        			
		        		});
		            });
		            
		        }
				
			});
			
			
			
   /* easyUI全局 end */
	$(function(){
		$("#startTime").datetimepicker({
			language: 'cn',
	        format: 'yyyy-mm',
	        weekStart: 1,  
            autoclose: true,  
            startView: 3,  
            minView: 3,  
            forceParse: false
		});
		$('#mytable').datagrid().datagrid('enableCellEditing');
		if('${id}'=="" || '${id}'==null || '${id}'=="0" ){
			$("#startTime").val('${salaryTime}');
			init();
		}else{
			searchInfo();
		}
		
	});
	function formatOper(val,row,index){
		if(row.userName!='合计'){
			return '<a href="#" id="editSarlar" style="width:66px;margin:5px;" onclick="deleteDetail('+index+')">删除</a>'; 
		}else{
			return '';
		}
		
		 
	} 
	/* 添加合计 */
	function onLoadSuccess() {
	    var rows = $('#mytable').datagrid('getRows');
	    if(rows.length>0){
	    	  $('#mytable').datagrid('appendRow', {
	    		  userName: '合计',
	    		  basicSalary: compute("basicSalary"),
	    		  allowanceAmount: compute("allowanceAmount"),
	    		  fineAmount: compute("fineAmount"),
	    		  amount: compute("amount")
	    	    });
	    	  $('#mytable').datagrid('mergeCells',{
	    	        index:rows.length-1,
	    	        field:'userName',
	    	        colspan:3

	    	    });
	    	  
	    }
	  
	}
	//指定列求和
	function compute(colName) {
	    var rows = $('#mytable').datagrid('getRows');
	    var total = 0;
	    for (var i = 0; i < rows.length; i++) {
	        total += parseFloat(rows[i][colName]);
	        console.info(total);
	    }
	    return total.toFixed(2);
	    
	}
	//编辑后求和
	function editCompute(colName) {
	    var rows = $('#mytable').datagrid('getRows');
	    var total = 0;
	    for (var i = 0; i < rows.length-1; i++) {
	        total += parseFloat(rows[i][colName]);
	    }
	    return total.toFixed(2);
	    
	}
  /* 变更初始时间 */
  function changeSalary(e){
	  var driverFlag="${driverFlag}";
	  var salaryTime=$(e).val();
	  $.ajax({
			type : 'GET',
			url : "${ctx}/financeManage/salaryPay/getTemplateData/"+driverFlag+"/"+salaryTime,
			data : '',
			dataType : 'JSON',
			success: function(data){
				if (data && data.code == 200){
					if(data.data!=null && data.data!=''){
						for(var i=0;i<data.data.length;i++){
							if(data.data[i]["salaryTime"]!=null && data.data[i]["salaryTime"]!=''){
								data.data[i]["salaryTime"]=jsonForDateMonthFormat(data.data[i]["salaryTime"]);
							}
						}
						$('#mytable').datagrid('loadData',{"total" : data.data.length,"rows" : data.data});
					}else{
						 $('#mytable').datagrid('loadData', { total: 0, rows: [] }); 
					}
				}else{
					bootbox.alert(data.msg);
				}
			}
	  });
  }
  /* 初始加载 */
  function init(){
	  var driverFlag="${driverFlag}";
	  var salaryTime=$('#startTime').val();
	  $.ajax({
			type : 'GET',
			url : "${ctx}/financeManage/salaryPay/getTemplateData/"+driverFlag+"/"+salaryTime,
			data : '',
			dataType : 'JSON',
			success: function(data){
				if (data && data.code == 200){
					if(data.data!=null && data.data!=''){
						for(var i = 0;i<data.data.length;i++)
						{
							data.data[i].basicSalary = parseFloat(data.data[i].basicSalary).toFixed(2);
							data.data[i].allowanceDistance = parseFloat(data.data[i].allowanceDistance).toFixed(2);
							data.data[i].allowanceAmount = parseFloat(data.data[i].allowanceAmount).toFixed(2);
							data.data[i].fineAmount = parseFloat(data.data[i].fineAmount).toFixed(2);
							data.data[i].amount = parseFloat(data.data[i].basicSalary).toFixed(2);
						}
						$('#mytable').datagrid('loadData',{"total" : data.data.length,"rows" : data.data});
					}else{
						 $('#mytable').datagrid('loadData', { total: 0, rows: [] }); 
					}
				}else{
					bootbox.alert(data.msg);
				}
			}
	  });
  }
  /* 编辑加载 */
  function searchInfo(){
	  var id="${id}";
	  $.ajax({
			type : 'GET',
			url : "${ctx}/financeManage/salaryPay/getDetailData/"+id,
			data : '',
			dataType : 'JSON',
			success: function(data){
				if (data && data.code == 200){
					$("#startTime").val(data.data.salaryTime);
					if(data.data.detailList!=null && data.data.detailList!=''){
						$('#mytable').datagrid('loadData',{"total" : data.data.detailList.length,"rows" : data.data.detailList});
					}
					
				}else{
					$('#mytable').datagrid('loadData', { total: 0, rows: [] }); 
				}
			}
	  });
  }
  /* 删除 */
	function deleteDetail(index){
		var flag="false";
		bootbox.confirm({ 
			  size: "small",
			  message: "确定要删除该用户工资信息?", 
			  callback: function(result){
				  if(result){
					  bootbox.confirm_alert({ 
						  size: "small",
						  message: "删除成功！", 
						  callback: function(result){
							  if(result){
								  flag="true";
								  $('#mytable').datagrid('deleteRow', index);
								  var lastIndex=$('#mytable').datagrid('getRows').length-1;
								  $('#mytable').datagrid('deleteRow', lastIndex);
								  var rows = $('#mytable').datagrid("getRows");
								  $('#mytable').datagrid("loadData", rows);
							  }
						  }
					 });
					 setTimeout(function(){
							if(flag=="false"){
								  $('#mytable').datagrid('deleteRow', index); 
								  var lastIndex=$('#mytable').datagrid('getRows').length-1;
								  $('#mytable').datagrid('deleteRow', lastIndex);
								  $('.bootbox').modal('hide');
								  var rows = $('#mytable').datagrid("getRows");
								  $('#mytable').datagrid("loadData", rows);
							}
						},3000);
					 
				  }
			  }
		})
   }
	
  
   /* 保存 工资信息*/
   function save(){
		  var flag="false";
		  var objs=[];
		  var objList={};
		  var id="${id}";
		  var driverFlag="${driverFlag}";
		  var salaryTime=$('#startTime').val();
		  var rows = $('#mytable').datagrid('getRows');
		  //console.info(JSON.stringify(rows));
		  if(rows){
			  for(i = 0;i < rows.length-1;i++){ 
				  var objItem={};
				  var vinObj=[];
				  var userName=rows[i].userName;
				  if(userName!= "" && userName!= null){
				     if(rows[i].id!=null && rows[i].id!=""){
						  objItem.id=rows[i].id;
					  }
					  objItem.userId=rows[i].userId;
					  objItem.departmentId=rows[i].departmentId;
					  objItem.userName=rows[i].userName;
					  objItem.dutyName=rows[i].dutyName;
					  objItem.salaryTime=rows[i].salaryTime;
					  objItem.workDays=rows[i].workDays;
					  objItem.leaveDays=rows[i].leaveDays;
					  objItem.basicSalary=rows[i].basicSalary;
					  objItem.allowanceDistance=rows[i].allowanceDistance;
					  objItem.allowanceAmount=rows[i].allowanceAmount;
					  objItem.fineAmount=rows[i].fineAmount;
					  objs.push(objItem);
				  }
				 
				 }
				}
		 
		 objList.salaryTime=salaryTime;
		 objList.saveFlag="Y";
		 objList.driverFlag=driverFlag;
		 objList.detailList=objs;
		 //console.info(JSON.stringify(objList));
		 if(id!='0' && id!=""){
			 objList.id=id;
		 }
		 bootbox.confirm({ 
			  size: "small",
			  message: "确定要保存该工资管理信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : '${ctx}/financeManage/salaryPay/save',
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
												  if("${driverFlag}"=='Y'){
													  location.href="${ctx}/financeManage/salaryPay/indexForDriver"; 
												  }else{
													  location.href="${ctx}/financeManage/salaryPay/index"; 
												  }
												  
											  }else{
												  if("${driverFlag}"=='Y'){
													  location.href="${ctx}/financeManage/salaryPay/indexForDriver"; 
												  }else{
													  location.href="${ctx}/financeManage/salaryPay/index"; 
												  }
											  }
										  }
									 });
									setTimeout(function(){
										if(flag=="false"){
											 $('.bootbox').modal('hide');
											 if("${driverFlag}"=='Y'){
												  location.href="${ctx}/financeManage/salaryPay/indexForDriver"; 
											  }else{
												  location.href="${ctx}/financeManage/salaryPay/index"; 
											  }
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
  /* 发放 */
    function check(){
    	  var flag="false";
		  var objs=[];
		  var objList={};
		  var driverFlag="${driverFlag}";
		  var id="${id}";
		  var salaryTime=$('#startTime').val();
		  var rows = $('#mytable').datagrid('getRows');
		  if(rows){
			  for(i = 0;i < rows.length-1;i++){ 
				  var objItem={};
				  var vinObj=[];
				  var userName=rows[i].userName;
				  if(userName!= "" && userName!= null){
					  if(rows[i].id!=null && rows[i].id!=""){
						  objItem.id=rows[i].id;
					  }
					  objItem.userId=rows[i].userId;
					  objItem.departmentId=rows[i].departmentId;
					  objItem.userName=rows[i].userName;
					  objItem.dutyName=rows[i].dutyName;
					  objItem.salaryTime=rows[i].salaryTime;
					  objItem.workDays=rows[i].workDays;
					  objItem.leaveDays=rows[i].leaveDays;
					  objItem.basicSalary=rows[i].basicSalary;
					  objItem.allowanceDistance=rows[i].allowanceDistance;
					  objItem.allowanceAmount=rows[i].allowanceAmount;
					  objItem.fineAmount=rows[i].fineAmount;
					  objs.push(objItem);
				  }
				 
				 }
				}
		 objList.salaryTime=salaryTime;
		 objList.saveFlag="N";
		 objList.detailList=objs;
		 objList.driverFlag=driverFlag;
		 if(id!='0' && id!=""){
			 objList.id=id;
		 }
		 bootbox.confirm({ 
			  size: "small",
			  message: "确定要发放该工资管理信息?", 
			  callback: function(result){
				  if(result){
					  $.ajax({
							type : 'POST',
							url : '${ctx}/financeManage/salaryPay/save',
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
												  if("${driverFlag}"=='Y'){
													  location.href="${ctx}/financeManage/salaryPay/indexForDriver"; 
												  }else{
													  location.href="${ctx}/financeManage/salaryPay/index"; 
												  }
											  }else{
												  if("${driverFlag}"=='Y'){
													  location.href="${ctx}/financeManage/salaryPay/indexForDriver"; 
												  }else{
													  location.href="${ctx}/financeManage/salaryPay/index"; 
												  }
											  }
										  }
									 });
									setTimeout(function(){
										if(flag=="false"){
											 $('.bootbox').modal('hide');
											 if("${driverFlag}"=='Y'){
												  location.href="${ctx}/financeManage/salaryPay/indexForDriver"; 
											  }else{
												  location.href="${ctx}/financeManage/salaryPay/index"; 
											  }
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
    </script> 
 </body>
</html>


