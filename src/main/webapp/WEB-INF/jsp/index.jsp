<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>辉宇物流</title>
		<meta name="keywords" content="" />
		<meta name="description" content="" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!-- basic styles -->
		<link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" /><!--字体icon-->
		<!-- page specific plugin styles -->
		<!-- ace styles -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
		<!--<link rel="stylesheet" href="${ctx}/staticPublic/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/ace-skins.min.css" />-->
		<!-- inline styles related to this page -->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/Confirm.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/jquery.gritter.css" />
		<!-- ace settings handler -->
		<script src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="${ctx}/staticPublic/js/html5shiv.js"></script>
		<script src="${ctx}/staticPublic/js/respond.min.js"></script>
		<![endif]-->
		<style type="text/css">
    a:hover {
    text-decoration: none;
    cursor:pointer;
    }
    .editlink{
    width:200px;
    white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
    }
.gritterindex-center {
	position: fixed;
	left: 75%;
	right: 3%;
	top: 83%
}
</style>
	</head>
	<body >
		<div class="navbar navbar-default" id="navbar">
			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<a href="#" class="navbar-brand">
						<img src="${ctx}/staticPublic/images/gallery/hylogo.png" />
					</a><!-- /.brand -->
				</div><!-- /.navbar-header -->
				<div class="navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<li class="light-blue3">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-bell-alt icon-animated-bell"></i>
								<span class="badge badge-important"></span>								
							</a>

							<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								
							</ul>
						</li>
						<li class="light-blue3">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<img class="nav-user-photo" src="${ctx}/staticPublic/images/gallery/user.jpg" alt="Jason's Photo" />
								<span class="user-info">
									<small>欢迎,</small>
									${sessionScope.LMS_USER.name}
								</span>

								<i class="icon-caret-down"></i>
							</a>

							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li>
									<a onclick="editPwd(this)">
										<i class="icon-cog"></i>
										密码修改
									</a>
								</li>
								<li class="divider"></li>

								<li>
									<a href="#" onclick="logout()">
										<i class="icon-off"></i>
										退出
									</a>
								</li>
							</ul>
						</li>
					</ul><!-- /.ace-nav -->
				</div><!-- /.navbar-header -->
			</div><!-- /.container -->
		</div>

		<div class="main-container" id="main-container">
			<div class="main-container-inner">
			  <div class="modal fade" id="modal-message" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal" onclick="doclosemesage()">×</button>
					<h3 id="myMesgModalLabel">消息信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<input type="hidden" id="messageid" name="messageid"/>	
									<div class="add-item"> 
								    	 <p id="mesagetype" class="form-control no-border" style="height: 150px;"></p>     								     							     
								    </div>													  	                     
								   <div class="add-item-btn" id="messageviewBtn" style="margin-left: 250px;">									  						   
									    <a class="add-itemBtn btnOk" onclick="doclosemesage()">关闭</a>
								   </div> 							    
								</div>
							</div>
						</div>
					</div>
				</div>
			   </div>
				   <!-- tab切换测试  begin-->
					<div class="sidebar" id="sidebar">
				       <ul class="nav nav-list" id="menu"></ul>
				       <div class="sidebar-collapse" id="sidebar-collapse">
						 <i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
					   </div>
				     </div>
				     
				     <!-- tab切换  end-->
				<div class="main-content" id="main-content">
					<!-- tab切换  begin-->
				     <div class="page-content">
				         <div class="row">
				           <div class="col-xs-12" style="padding-left:5px;">
				             <ul class="nav nav-tabs" role="tablist">
				               <li role="presentation" id="tab_tab_1" class="active">
				                 <a href="#tab_1" aria-controls="tab_1" role="tab" data-toggle="tab">首页 </a>
				               </li>
				             </ul>
				             <div class="tab-content" style="border:0;padding:5px 0px;">
				               <div role="tabpanel" class="tab-pane active" id="tab_1">
				                  <iframe src="${ctx}/content" id="ifContent" frameborder="0" style="width:100%;height:700px;border:0;overflow:hidden;"></iframe>
				               </div>
				             </div>
				           </div>
				         </div>
				       </div>
				      <!-- tab切换  end-->
					 
               </div>
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->
		<!-- basic scripts -->
		<!--[if !IE]> -->
		<script src="${ctx}/staticPublic/js/jquery-2.0.3.min.js"></script>
		<!-- <![endif]-->
		<!--[if IE]>
		<script src="${ctx}/staticPublic/js/jquery-1.10.2.min.js"></script>
		<![endif]-->
		<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
		<!-- page specific plugin scripts -->
		<script src="${ctx}/staticPublic/js/jquery.dataTables.min.js"></script>
		<script src="${ctx}/staticPublic/js/jquery.dataTables.bootstrap.js"></script>
		<!-- ace scripts -->
		<script src="${ctx}/staticPublic/js/ace-elements.min.js"></script>
		<script src="${ctx}/staticPublic/js/ace.min.js"></script>
		<!-- inline scripts related to this page -->
		<script type="text/javascript" src="${ctx}/staticPublic/js/popbox/Confirm.js"></script>
		<script type="text/javascript" src="${ctx}/staticPublic/js/bootbox.min.js"></script>
		<script src="${ctx}/staticPublic/js/sidebar-menu.js"></script>
		 <script src="${ctx}/staticPublic/js/bootstrap-tab.js"></script>
		 <script src="${ctx}/staticPublic/js/jquery.gritter.min.js"></script>
		<script type="text/javascript">
		$(function () {
			
		      
		    });
		/*重启后跳转登陆  */
		$(function(){
			if('${sessionScope.LMS_USER.name}'==null || '${sessionScope.LMS_USER.name}'==""){
				location.href="${ctx}/login";
			}else{
				var id='${sessionScope.LMS_USER.id}';
				getmenue(id);
			}
			getMesge();
		});

		/*获取菜单列表*/
		function getmenue(id){
			var html='';
			var htmlitem='';
			$.ajax({
				type : 'GET',
				url : "${ctx}/getMenuListData/"+id,
				contentType : "application/json;charset=UTF-8",
				dataType : 'JSON',
				success : function(data) {
					if (data && data.code == 200) {
						var objs=[];
						 var objes={};
						 objes.id="1";
						 objes.text="首页";
						 objes.icon="icon-home";
						 objes.url="${ctx}/content";
						 objs.push(objes);
						if(data.data.length>0){
							var j=0;
							var parentId="";
							var objAll={};
							var objFirst=[];
							for(var i=0;i<data.data.length;i++){	
								 var objItem={};
								if(data.data[i]['parentId']=='1'){
									objItem.id=data.data[i]['id'];
									objItem.text=data.data[i]['name'];																	
									 parentId=data.data[i]['id'];
									 j=j+1;//nav nav-list
									 if(data.data[i]['name']=='基础信息管理'){
										 objItem.icon="icon-windows";
									 }else if(data.data[i]['name']=='日常办公'){
										 objItem.icon="icon-edit";
									 }else if(data.data[i]['name']=='运营管理'){
										 objItem.icon="icon-truck";
									 }else if(data.data[i]['name']=='折损管理'){
										 objItem.icon="icon-beaker";
									 }else if(data.data[i]['name']=='轮胎管理'){
										 objItem.icon="icon-dribbble";
									 }else if(data.data[i]['name']=='财务管理'){
										 objItem.icon="icon-lock";
									 }else if(data.data[i]['name']=='查询管理'){
										 objItem.icon="icon-search";
									 }else if(data.data[i]['name']=='系统设置'){
										 objItem.icon="icon-gear";
									 }else{
										 objItem.icon="icon-th-large"; 
									 }	
									 objItem.url="";
									 var menu=[];
									 var parentIdItem='';
									 for(var m=0;m<data.data.length;m++){
										 if(data.data[m]['parentId']==parentId){
											 var menuSec=[];
											 var menuItem={};
											 menuItem.id=data.data[m]['id'];
											 parentIdItem=data.data[m]['id'];
											 menuItem.text=data.data[m]['name'];																			
											 menuItem.icon="right-line";
											 if($.trim(data.data[m]['url'])==''){
												 menuItem.url='';
											 }else{
												 menuItem.url="${ctx}"+data.data[m]['url']; 
											 }
											 for(var k=0;k<data.data.length;k++){
												 if(data.data[k]['parentId']==parentIdItem){
													 var menuItemSec={};
													 menuItemSec.id=data.data[k]['id'];
													 menuItemSec.text=data.data[k]['name'];																			
													 menuItemSec.icon="right-lineSec";
													 menuItemSec.url="${ctx}"+data.data[k]['url'];
													 menuSec.push(menuItemSec);
												 }
											 }
											 if(menuSec.length>0){
												 menuItem.menus=menuSec;
											 }
											 
											 menu.push(menuItem);
										 } 
									 }
									 if(menu.length>0){
										 objItem.menus=menu;
									 }
									 objs.push(objItem);	
								}
								
							}
							$('#menu').sidebarMenu({
						        data: objs
						      });
						}
					} else {
						bootbox.alert(data.msg);				
					}
				}
				
			}); 
		}
		/*菜单切换*/
		function addTab(url,e) {
			if(url!=null && url!=''){
				$('#ifContent').attr('src',url);
				$('.submenu li').removeClass('active');
				if($(e).parents('.main').attr('class')=='main open'){
					$(e).parents('.main').siblings().removeClass('open active').find('.submenu').slideUp(200);
					$(e).parents('.main').addClass('active');
				}else if($(e).parents('.main').attr('class')=='main'){
						$(e).parents('.main').siblings().removeClass('open active').find('.submenu').slideUp(200);
					    $(e).parents('.main').addClass('open active');
					}
				else if($(e).parent().attr('class')=='first-main'){
					$('.main').removeClass('open active').find('.submenu').slideUp(200);
				}
				$(e).parent().addClass('active');
			}	
		 }
		  /*  退出系统 */
			function logout(){
				var txt=  "你确认要退出吗?";
				var option = {
					title: "提示:",
					btn: parseInt("0011",2),
					onOk: function(){
						location.href="${ctx}/logout";
					}
				}
				$.Confirm(txt, "custom", option);
			}
		  
		  function getMesge(){
			  var obj = {};
				 $.ajax({
					type : 'POST',
					url : '${ctx}/dailyOffice/message/getListData',
					data : JSON.stringify({
						sEcho : 0,				
						pageStartIndex : 0,
						pageSize : 99,
						name :'',
						status :'N'
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
								var html="";
								if(obj.aaData.length>8){
									for(var i=0;i<8;i++){
										obj.aaData[i]["rownum"]=i+1;
										if(i==7){
											 html+='<li><a onclick="locationMore(this);"><p class="editlink" >查看更多</p></a></li>';
										}else{
											html+='<li><a onclick="doviewneredmesg('+obj.aaData[i]["id"]+')"><p class="editlink" style="color: #4f99c6;">'+obj.aaData[i]["mark"]+'</p></a></li>';
										}
										 
									}
								}else{
									for(var i=0;i<obj.aaData.length;i++){
										obj.aaData[i]["rownum"]=i+1;
										html+='<li><a onclick="doviewneredmesg('+obj.aaData[i]["id"]+')"><p class="editlink" style="color: #4f99c6;">'+obj.aaData[i]["mark"]+'</p></a></li>';
									}
								}
								
								var totalCounts=data.data.totalCounts;
								$('.badge-important').html(totalCounts);
								$(".dropdown-navbar").html(html); 
							}else{
								obj.aaData=[];
								$(".dropdown-navbar").append('<li><a onclick="locationMore(this);"><p class="editlink" >暂无消息</p></a></li>'); 
							}
						} else {
							 bootbox.alert(data.msg);
						}
						
					}
				}); 
		  }
		  function doviewneredmesg(id){
				$('#modal-message').modal('show');
				$('#messageviewBtn').show();
				
				$.ajax({
					type : 'GET',
					url : "${ctx}/dailyOffice/message/getDetailData/"+id,
					contentType : "application/json;charset=UTF-8",
					dataType : 'JSON',
					success : function(data) {
						if (data && data.code == 200) {
							$.ajax({
								type : 'GET',
								url : "${ctx}/dailyOffice/message/updateRead/"+id,
								contentType : "application/json;charset=UTF-8",
								dataType : 'JSON',
								success : function(data) {
									if (data && data.code == 200) {
														
									} else {
										bootbox.alert(data.msg);				
									}
								}
								
							});				
							//$('#reminder_mark').val(data.data.mark);
							$('#messageid').val(id);
							$('#mesagetype').html(data.data.mark);
							$('#myMesgModalLabel').html(data.data.name);
						} else {
							bootbox.alert(data.msg);				
						}
					}
					
				});
			}
		  function doclosemesage(){
				$('#modal-message').modal('hide');
				location.reload();
			}
		  /* 查看更多未阅消息 */
	        function locationMore(e){
	        	var id='90';
	        	var text='未阅消息';
	        	var url='${ctx}/dailyOffice/message/index';
	        	addTabs({id:id,title:text,close: true,url:url});
	        }
		  /* 密码修改 */
		  function editPwd(e){
			    var id='26';
	        	var text='密码修改';
	        	var url='${ctx}/common/passwordSetting/edit';
	        	addTabs({id:id,title:text,close: true,url:url});
		  }
		</script>
	 
	 	<script type="text/javascript" src="${ctx}/staticPublic/js/websocket/sockjs-0.3.4.min.js"></script>
	 	<script type="text/javascript" src="${ctx}/staticPublic/js/websocket/reconnecting-websocket.min.js"></script>
        <script>
	        var host = window.location.host;
	        var websocket;
	        if ('WebSocket' in window) {
	            websocket = new ReconnectingWebSocket("ws://" + host + "${ctx}/webSocketServer", null, {debug:true, maxReconnectAttempts:4});
	        } else if ('MozWebSocket' in window) {
	            websocket = new MozWebSocket("ws://" + host + "${ctx}/webSocketServer");
	        } else {
	            websocket = new SockJS("http://" + host + "${ctx}/sockjs/webSocketServer");
	        }
	        websocket.onopen = function(evnt) {
	            console.log("websocket连接上");
	        };
	        websocket.onmessage = function(evnt) {
	            messageHandler(evnt.data);
	        };
	        websocket.onerror = function(evnt) {
	            console.log("websocket错误");
	        };
	        websocket.onclose = function(evnt) {
	            console.log("websocket关闭");
	        }

	        function messageHandler(data){
		        if( data == 'FORCE_LOGIN_OUT' ){
			        alert("该账户已经在其他地方登录。")
					location.href="${ctx}/login";
			    }else{
			    	//console.info(data);			    	
		        	if(data!=0){
		        		$.gritter.add({
							// (string | mandatory) the heading of the notification
							title: '您有新消息!',
							// (string | mandatory) the text inside the notification
							text: data,
							class_name: 'gritter-info gritterindex-center' 
						});
		        		getMesge();
		        		if($("#tab_1").hasClass("active")){
		        			//console.info(data);	
		        			$('#ifContent').attr('src',"${ctx}/content");
		        			}
		        	}
		        	
				}
		    }
	        
	       
        </script>
</body>
	
</html>
