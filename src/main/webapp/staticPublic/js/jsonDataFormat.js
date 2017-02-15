
/**
 * add by gll
 * on 2016/9/29
 * update by mtt on 2016/9/30
 *
 */

function jsonDateFormat(jsonDate) {//json日期格式转换为正常格式
	
    try {
       
        var dateObj = JSON.parse(jsonDate);
        var date = new Date(dateObj);
       /*  alert(date.getFullYear()); */
        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
        var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
        var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
        var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
        var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
       /*  
        var milliseconds = date.getMilliseconds(); */
        return date.getFullYear() + "-" + month + "-" + day+ " " + hours + ":" + minutes + ":" + seconds; /*  + "." + milliseconds */
    } catch (ex) {//出自http://www.cnblogs.com/ahjesus 尊重作者辛苦劳动成果,转载请注明出处,谢谢!
        return "";
    }
}

function jsonForDateFormat(jsonDate) {//json日期格式转换为正常格式
	
    try {
       
        var dateObj = JSON.parse(jsonDate);
        var date = new Date(dateObj);
       /*  alert(date.getFullYear()); */
        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
        var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
       /*  
        var milliseconds = date.getMilliseconds(); */
        return date.getFullYear() + "-" + month + "-" + day; /*  + "." + milliseconds */
    } catch (ex) {//出自http://www.cnblogs.com/ahjesus 尊重作者辛苦劳动成果,转载请注明出处,谢谢!
        return "";
    }
}

function jsonForDateMinutFormat(jsonDate) {//json日期格式转换为正常格式
	
    try {
       
        var dateObj = JSON.parse(jsonDate);
        var date = new Date(dateObj);
       /*  alert(date.getFullYear()); */
        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
        var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
        var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
        var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
        /*  
        var milliseconds = date.getMilliseconds(); */
        return date.getFullYear() + "-" + month + "-" + day+ " " + hours + ":" + minutes; /*  + "." + milliseconds */
    } catch (ex) {//出自http://www.cnblogs.com/ahjesus 尊重作者辛苦劳动成果,转载请注明出处,谢谢!
        return "";
    }
}

function jsonForDateMonthFormat(jsonDate) {//json日期格式转换为正常格式
	
    try {
       
        var dateObj = JSON.parse(jsonDate);
        var date = new Date(dateObj);
       /*  alert(date.getFullYear()); */
        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
        var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
        var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
        var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
        /*  
        var milliseconds = date.getMilliseconds(); */
        return date.getFullYear() + "-" + month; /*  + "." + milliseconds */
    } catch (ex) {//出自http://www.cnblogs.com/ahjesus 尊重作者辛苦劳动成果,转载请注明出处,谢谢!
        return "";
    }
}


//两个日期的差值(d1 - d2).
function DateDiff(d1,d2){
    var day = 24 * 60 * 60 *1000;
try{    
        var dateArr = d1.split("-");
   var checkDate = new Date();
        checkDate.setFullYear(dateArr[0], dateArr[1]-1, dateArr[2]);
   var checkTime = checkDate.getTime();
  
   var dateArr2 = d2.split("-");
   var checkDate2 = new Date();
        checkDate2.setFullYear(dateArr2[0], dateArr2[1]-1, dateArr2[2]);
   var checkTime2 = checkDate2.getTime();
    
   var cha = (checkTime - checkTime2)/day;  
        return cha;
    }catch(e){
   return false;
}
}