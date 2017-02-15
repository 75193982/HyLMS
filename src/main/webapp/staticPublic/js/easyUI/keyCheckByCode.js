
/**
 * add by matingting
 * on 2016/6/20
 * update by matingting on 2016/6/21
 *
 */

function keyCheckByCode(evt){
	evt = (evt) ? evt : ((window.event) ? window.event : ""); //兼容IE和Firefox获得keyBoardEvent对象
	var key = evt.keyCode?evt.keyCode:evt.which;//兼容IE和Firefox获得keyBoardEvent对象的键值 
	var d=document.getElementById("selectItem");
	var sumLength = document.getElementById("table1").rows.length;
    //事件的标识代码   向上
	if (key == 38)
    {
		evt.returnValue = false;//阻止事件的默认行为
		var tr_top = document.getElementById("table1").rows[rowNo].offsetTop;
    	var tr_height = document.getElementById("table1").rows[rowNo].offsetHeight;//行高
        for(var k=0;k<sumLength;k++)
        {
            document.getElementById("table1").rows[k].className = "";
        }
        if(rowNo != 0)
        {
        	if(rowNo == 1)
    		{
    			$("#selectItem").animate({scrollTop:0},1);
    			document.getElementById("table1").rows[1].className = "on";
    			return false;
    		}
    		else
    		{
    			$("#selectItem").animate({scrollTop:tr_top-tr_height},1);
    			document.getElementById("table1").rows[--rowNo].className = "on";
    		}
        }
    }
	//事件的标识代码   向下
    if (key== 40)
    {
    	evt.returnValue = false;//阻止事件的默认行为
    	var tr_top = document.getElementById("table1").rows[rowNo].offsetTop;
    	var tr_height = document.getElementById("table1").rows[rowNo].offsetHeight;//行高
    	for(var k=0;k<sumLength;k++)
        {
            document.getElementById("table1").rows[k].className="";
        }
    	if(rowNo == sumLength-1)
    	{
    		document.getElementById("table1").rows[sumLength-1].className = "on";
    		return false;
    	}
    	else
    	{
    		$("#selectItem").animate({scrollTop:tr_top-200+2*tr_height},1);
    		document.getElementById("table1").rows[++rowNo].className = "on";
    	}
    }
}