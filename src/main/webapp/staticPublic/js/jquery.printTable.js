/**
 * jquery 表格打印插件
 *
 * updateby matingting 
 * 日期：2016-6-2
 * 分页样式(需要自定义)：
 * @media print {
 *	.pageBreak { page-break-after:always; }
 * } 
 * 使用例子：
 *  $(function(){
 *		$("#tabContent").printTable({
 *		 mode          : "rowNumber",
 *		 header        : "#headerInfo",
 *		 footer        : "#footerInfo",
 *		 pageNumStyle  : "第#p页/共#P页",
 *		 pageNumClass  : ".pageNum",
 *		 pageSize      : 10
 *		});
 *   });
 *  注意事项：
 *      使用时注意表格中要使用 thead 和 tbody区分出标题头与表格内容，否则可能出现错误
 * 
 * 参数说明：
 *  options are passed as json (json example: { rowHeight : "rowHeight", header : ".tableHeader",})
 *
 *  {OPTIONS}        | [type]    | (default), values            | Explanation
 *  ---------------- | --------- | -----------------------------| -----------
 *  @mode            | [string]  | ("rowHeight"),rowNumber      | 分页模式，按行高分页或按行数分页
 *  @header          | [string]  | (".tableHeader")             | 页面开始处要添加的内同
 *  @footer          | [string]  | (".tableFooter")             | 页面结束要添加的内容
 *  @pageSize        | [number]  | (30)                         | 自动分页行数，按行高分页时改参数无效
 *  @breakClass      | [string]  | ("pageBreak")                  | 分页插入符class,需要定义分页样式
 *  @pageNumStyle    | [string]  | "#p/#P"                      | 页码显示样式，#p当前页，#P总页数
 *  @pageNumClass    | [string]  | ".pageNumClass"              | 页码class样式，用于设值(使用text方法设置) 
 *  @startPage       | [number]  | (1)                          | 第一页起始页码
 *  @pageHeight      | [number]  | (297)                        | 页面高度,单位像素
 *  @topMargin       | [number]  | (15)                         | 上边距高度，单位像素
 *  @bottomMargin    | [number]  | (15)                         | 低边距高度，单位像素
 */
(function($) {
	var modes = { rowHeight : "rowHeight", rowNumber : "rowNumber" };
	//默认参数
	 var defaults = { 
			 mode          : modes.rowHeight,
			 header        : ".tableHeader",
			 footer        : ".tableFooter",
			 pageSize      : 30,
			 breakClass    : "pageBreak",
			 pageNumStyle  : "#p/#P",
			 pageNumClass  : ".pageNumClass",
			 startPage     : 1,
			 pageHeight    : 1230,
			 topMargin     : 50,
			 bottomMargin  : 50
         };
	 var settings = {};//global settings
	 var rowCount = 0;//行总数
	 var pageCount = 0;//页总数
	 var currentPage = 0;//当前页
	 var $header = null;//表格头
	 var $content = null;//表格内容
	 var $footer = null;//表格尾
	 var $table = null;
	 var $tbodyTr = null;
	$.fn.printTable = function( options ) {
		$.extend( settings, defaults, options );
		$table = $(this);
		$tbodyTr = $table.find("tbody tr");
		switch ( settings.mode ){
            case modes.rowHeight :
            	rowHeightPage();//行高分页
                break;
            case modes.rowNumber :
            	rowNumberPage();//行数分页
        }
	};
	//获取页总数
	$.fn.printTable.getStartPage = function(startPage) {
		return getPageStyle(startPage , pageCount);
	};
	//行高分页
	function rowHeightPage(){
		var contentHeight =	 initHeightPage();
		getContentColne();
	    beginPageByHeight(contentHeight);
	    hidenContent();
	}
	
	
	//行数分页
	function rowNumberPage(){
		initNumberPage();
		getContentColne();
		beginPageByNumber();
		hidenContent();
	}
	
	//按行高分页
	function beginPageByHeight(contentHeight){
		var totalHeight = 0;
		var startLine = 0;
		$tbodyTr.each(function(i){
			var cHeight = $(this).outerHeight(true);
			$(this).height(cHeight);
			if((totalHeight + cHeight ) < contentHeight){
				totalHeight += cHeight;
				if(i == $tbodyTr.length -1){
					newPage(i + 1);
				}
			}else{
				newPage(i);
			}
		});
		function newPage(index){
			createPage(startLine,index);
			currentPage ++;
			startLine = index;
			totalHeight = 0;
		}
	}
	
	//初始化高度分页信息
	function initHeightPage(contentHeight){
		var contentHeight =	initContentHeight();
		currentPage = 0 + settings.startPage;
		pageCount = Math.ceil($table.find("tbody").outerHeight(true)/contentHeight) + settings.startPage - 1;//初始化总页数
		rowCount = $tbodyTr.length;//初始化总记录数
		return contentHeight;
	}
	
	
	//初始化内容高度
	function initContentHeight(){
		var headerHeight = $(settings.header).outerHeight(true);
		var footerHeight = $(settings.footer).outerHeight(true);
		var theadHeight = $table.find("thead").outerHeight(true);
		var tableHeight =  settings.pageHeight - settings.topMargin - settings.bottomMargin ;
		var tbodyHeight =  tableHeight - theadHeight- headerHeight - footerHeight;
		return tbodyHeight;
	}
	//初始化分页基本信息
	function initNumberPage(){
		rowCount = $tbodyTr.length;//初始化总记录数
		pageCount =  Math.ceil(rowCount/settings.pageSize) + settings.startPage - 1;//初始化总页数
		currentPage = 0 + settings.startPage;
	}
	
	//开始分页
	function beginPageByNumber(){
		var startLine = 1;//开始行号
		var offsetLine = 0;//偏移行号
		for(var i = settings.startPage; i <= pageCount  ;i++ ){
			currentPage = i;
			startLine = settings.pageSize* (currentPage - settings.startPage);
			offsetLine = (startLine + settings.pageSize) > rowCount ? rowCount : startLine + settings.pageSize;
			createPage(startLine,offsetLine);
		};
	}
	 //创建新的一页
	function createPage(startLine,offsetLine){
		var $pageHeader = $header.clone();
		var $pageContent = $content.clone().append(getTrRecord(startLine,offsetLine));
		var $pageFooter = $footer.clone();
		$pageFooter.find(settings.pageNumClass).text(getPageStyle(currentPage , pageCount));//页码显示格式
		if(offsetLine == rowCount){
			$table.before($pageHeader).before($pageContent).before($pageFooter);
		}else{
			$table.before($pageHeader).before($pageContent).before($pageFooter).before(addPageBreak());
		}
	}
	
	//添加分页符
	function addPageBreak(){
		return "<div class='"+settings.breakClass+"'></div>";
	}
	
	//获取分页样式
	function getPageStyle(currentPage , pageCount){
		var numStr = settings.pageNumStyle;
		 numStr = numStr.replace(/#p/g,currentPage);
		 numStr = numStr.replace(/#P/g,pageCount);
		 return numStr;
	}
	
	//获取记录
	function getTrRecord(startLine,offsetLine){
		return $tbodyTr.clone().slice(startLine,offsetLine);
	}
	//获取内容
	function getContentColne(){
		$header = $(settings.header).clone().removeAttr("id");
		$content = $table.clone().find("tbody").remove().end().removeAttr("id");
		$footer = $(settings.footer).clone().removeAttr("id");
	}
	//隐藏原来的数据
	function hidenContent(){
		$(settings.header).hide();
		$table.hide();
		$(settings.footer).hide();
	}
})(jQuery);    