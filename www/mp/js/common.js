/**
 * @target
 */
var common_js= {}; //This is WebSquare JavaScript Marker. Do not remove this line.

var urlAddress = location.href;
var arrUrl = urlAddress.split("?");

// websquare path
var path = arrUrl[0]+"?w2xPath=";

var GV_USER_ID = WebSquare.session.getAttribute("USER_ID");
var GV_USER_NM = WebSquare.session.getAttribute("NAME");
var GV_GROUP_ID = WebSquare.session.getAttribute("GROUP_ID");
var GV_UP_GROUP_ID = WebSquare.session.getAttribute("UP_GROUP_ID");
var GV_UP_GROUP_NM = WebSquare.session.getAttribute("UP_GROUP_NAME");
var GV_USER_GROUP = WebSquare.session.getAttribute("USER_GROUP");
var GV_USER_TYPE = WebSquare.session.getAttribute("USER_TYPE");
var GV_DEPT_CD = WebSquare.session.getAttribute("DEPT_CD");
var GV_DEPT_NM = WebSquare.session.getAttribute("DEPT_NM");
var GV_USER_TEL_NO = WebSquare.session.getAttribute("TEL_NO"); 
var GV_BRAND_CD = WebSquare.session.getAttribute("BRAND_CD"); 
var GV_SPM_USE_YN = WebSquare.session.getAttribute("SPM_USE_YN");

/****************************************************************
 * 문자열 null 값 체크
 * @param	str		원본 문자열
 * @return	boolean	null이면 true, null이 아니면 false
******************************************************************/
function gfn_IsNullVal(str){
	
	var nZero = 0;
	if (str == null || trim(str).length == 0 || (str + nZero) == 0){
		return true;
	}else{
		return false;
	}
}
/****************************************************************
 * 문자열 처음의 whitespace 문자들을 제거
 * @param	str		원본 문자열
 * @return	String	왼쪽 whitespace 문자들이 제거된 문자열
******************************************************************/
function leftTrim(str) {
	var	regExp		= /^\s+/;

	return (regExp.exec(str) != null) ? RegExp.rightContext : str;
}
/****************************************************************
 * 문자열 마지막의 whitespace 문자들을 제거
 * @param	str		원본 문자열
 * @return	String	오른쪽 whitespace 문자들이 제거된 문자열
******************************************************************/
function rightTrim(str) {
	var	regExp		= /\s+$/;

	return (regExp.exec(str) != null) ? RegExp.leftContext : str;
}
/****************************************************************
 * 문자열 양쪽 끝의 whitespace 문자들을 제거
 * @param	str		원본 문자열
 * @return	String	양쪽 끝의 whitespace 문자들이 제거된 문자열
******************************************************************/
function trim(str) {
	return rightTrim(leftTrim(str));
}
var nIdx = 0;
var objGb = "day";
/****************************************************************
 * 달력 기간 버튼 클릭 시 해당 기간 구함(Day, Week, Month, Year)
 * @param	id 기간구분		objFrom	시작날짜Id	objTo 종료날짜Id
 * @return	
******************************************************************/
function gfn_ProcessDate(id,objFrom,objTo){
	switch(id){
		case "prev" :
			nIdx--;
			gfn_ChangeRange(objFrom,objTo);			
			break;
		case "next" :
			nIdx++;
			gfn_ChangeRange(objFrom,objTo);			
			break;
		case "day" :
			objGb = id;
			nIdx = 0;
			gfn_ChangeRange(objFrom,objTo);	
			break;
		case "week" :
			objFrom.setValue(gfn_GetDate(0,0,0,"FW"));
			objTo.setValue(gfn_GetDate(0,0,0));
			objGb = id;
			nIdx = 0;
			break;
		case "month" :
			objFrom.setValue(gfn_GetDate(0,0,0,"FM"));
			objTo.setValue(gfn_GetDate(0,0,0));
			objGb = id;
			nIdx = 0;
			break;
		case "year" :
			objFrom.setValue(gfn_GetDate(0,0,0,"FY"));
			objTo.setValue(gfn_GetDate(0,0,0));
			objGb = id;
			nIdx = 0;
			break;
	}
}
/****************************************************************
 * 달력 기간 이전/다음 날짜 처리
 * @param	objFrom	시작날짜Id	objTo 종료날짜Id
 * @return	
******************************************************************/
function gfn_ChangeRange(objFrom,objTo){		
	switch(objGb){
		case "day" :
			objFrom.setValue(gfn_GetDate(0,0,nIdx));
			objTo.setValue(gfn_GetDate(0,0,nIdx));
			break;
		case "week" :
			objFrom.setValue(gfn_GetDate(0,0,(nIdx*7),"FW"));
			objTo.setValue(gfn_GetDate(0,0,(nIdx*7)+6,"FW"));
			break;
		case "month" :
			objFrom.setValue(gfn_GetDate(0,nIdx,0,"FM"));
			objTo.setValue(gfn_GetDate(0,nIdx,0,"TM"));
			break;
		case "year" :
			objFrom.setValue(gfn_GetDate(nIdx,0,0,"FY"));
			objTo.setValue(gfn_GetDate(nIdx,0,0,"TY"));
			break;
	}
}
/****************************************************************
 * 날짜 계산
 * @param	year 년	month 월	 day 일	gb 시작/끝 구분
 * @return	
******************************************************************/
function gfn_GetDate(year, month, day, gb){
	 var curDate = new Date();

	 if(gb == "FW")	day = day - curDate.getDay();// + 1;

	 //현재 날짜에 날짜 게산.
	 curDate.setYear(curDate.getFullYear() + year );
	 curDate.setMonth(curDate.getMonth() + month );
	 curDate.setDate(curDate.getDate() + day );

	 //실제 사용할 연, 월, 일
	 var dYear = curDate.getFullYear();
	 var dMonth = curDate.getMonth()+1;
	 var dDay = curDate.getDate();
	 var date = "";

	 dMonth = "0" + dMonth;
	 dMonth = dMonth.substring(dMonth.length-2,dMonth.length);
	 dDay   = "0" + dDay;
	 dDay   = dDay.substring(dDay.length-2,dDay.length);

	 if(gb == "FM")
	 	date = dYear + "-" + dMonth + "-01";
	 else if(gb == "TM")
	 	date = dYear + "-" + dMonth + "-" + gfn_LastDay(dYear,dMonth);
	 else if(gb == "FY")
	 	date = dYear + "-01-01";
	 else if(gb == "TY")
	 	date = dYear + "-12-31";
	 else 
	 	date = dYear + "-" + dMonth + "-" +  dDay;

	 return date;
}
/****************************************************************
 * 월말 계산
 * @param	year 년	month 월
 * @return	
******************************************************************/
function gfn_LastDay(year,month){
	 //각 달의 마지막 날짜
	var lastdate = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

	//윤년인 경우 2월의 마지막 날짜를 29로 입력
	if((0 == year%4 && 0 != year%100) || 0 == year%400){
	 	lastdate[1]=29; 
	}

	day = lastdate[month-1];

 	return day;
}
/****************************************************************
 * 날짜 일수 계산
 * @param	id	기간구분	obj 기준날짜id
 * @return	
******************************************************************/
function gfn_GetDateCount(id, obj){
	var baseDt = gfn_GetDate(0,0,0).replaceAll("-","");
	var targetDt = obj.getValue().replaceAll("-","");
	var nBaseDt = new Date(eval(baseDt.substring(0, 4)), eval(baseDt.substring(4, 6)) - 1, eval(baseDt.substring(6, 8)));
	var nTargetDt   = new Date(eval(targetDt.substring(0, 4)), eval(targetDt.substring(4, 6) - 1), eval(targetDt.substring(6, 8)));
	
	var nDateCount = ((nTargetDt - nBaseDt) / 86400000);
	
	if(id == "prev")
		nDateCount = nDateCount - 1;
	else if(id == "next")
		nDateCount = nDateCount + 1;

	obj.setValue(gfn_GetDate(0,0,nDateCount));
}
/****************************************************************
 * 날짜 체크
 * @param	str 체크할 날짜
 * @return	
******************************************************************/
function gfn_IsValidDate(str){
    if(str.length == 10){
        vDate = new Date();
        vDate.setFullYear(str.substring(0, 4));
        vDate.setMonth(str.substring(5, 7)-1);
        vDate.setDate(str.substring(8));

        if(vDate.getFullYear() != str.substring(0, 4) ||
            vDate.getMonth() != (str.substring(5, 7) - 1) ||
             vDate.getDate() != str.substring(8)){

            return false;
        }

        return true;
    } 
    return false;
}
/****************************************************************
 * 시간 체크
 * @param	str 체크할 시간
 * @return	
******************************************************************/
function gfn_IsValidHour(str){
    var sHour = str;
    
	if(sHour.length == 1)
		sHour = "0" + sHour;
	
    return sHour;
}
/**************************************************************************************
* 팝업 화면 띄우기
* @param  url  팝업으로 띄울 .xml을 포함한 전체 경로
* @param  title - 팝업화면타이틀
* @param  w - width
* @param  h - height
* @param  l - left
* @param  t - top
* @return 	Popup에서 close()로 전달한 값
**************************************************************************************/
imports("uiplugin.popup");	// << 프린트 팝업 생성시 필요
function gfn_OpenPopup(url,title,w,h,l,t,popId){
	if(gfn_IsNullVal(popId))
		popId = "popup";
	
	WebSquare.uiplugin.popup.openPopup(url, { //get방식으로 파업의 아이디를 넘김니다.
		id : popId,
		type : "window", 
		/* type popup 객체의 type으로  window, browser 중 하나  browser type의 경우 useIFrame 속성과 상관없이 window.open으로 열립니다.*/
		width: w,
		height: h,
		left: l,
		top: t,
		popupName : title, //popupName popup 객체의 이름으로 popup 프레임의 표시줄에 나타납니다.
		modal : true, //modal을 이용해서 뒤 쪽 배경을 동작하지 않도록 만들기 위한 인자 입니다. false이면 뒤쪽의 컴퍼넌트가 사용 가능합니다.		
		/*
			type속성이 window인 경우 useIFrame속성에 따라서 다음과 같이 동작합니다.
			true : IFrame 을 사용하는 WebSquare popup
			false: window.open 을 사용하는 popup
		*/
		useIFrame : true,			
		style : "", //popup의 스타일을 지정합니다. 값이 있으면 left top width height는 적용되지 않습니다.		
		// popup option window.open을 사용하는 경우(useIfrmae false인 경우) popup에 넘어가는 parameter
		resizable : false,
		status : false,
		menubar : false,
		scrollbars : false,
		title : false,
		
		xml: WebSquare.ModelUtil.findInstanceNode("params"), // popup에 넘길 xmlDocument의 string popup창에서 WebSquare.uiplugin.popup.getPopupParam() api를 사용하여 가져올수 있습니다.	
		srcData: "", //popup 객체의 type 이 window 일 때 Parent 에서 넘길 xpath
		destData: "" //popup 객체의 type 이 window 일 때 popup 에 설정할 xpath (popup에 path가 있어야함.)
	
	});
}
/**************************************************************************************
* 팝업 닫기
* @param  없음
**************************************************************************************/
function gfn_PopupClose(popId){
	if(gfn_IsNullVal(popId))
		popId = "popup";
	WebSquare.uiplugin.popup.callClose(popId);	
}

/* ----------------------------------------------------------------------------
 * 특정 날짜에 대해 지정한 값만큼 가감(+-)한 날짜를 반환
 * 
 * 입력 파라미터 -----
 * pInterval : "yyyy" 는 연도 가감, "m" 은 월 가감, "d" 는 일 가감
 * pAddVal  : 가감 하고자 하는 값 (정수형)
 * pYyyymmdd : 가감의 기준이 되는 날짜
 * pDelimiter : pYyyymmdd 값에 사용된 구분자를 설정 (없으면 "" 입력)
 * 
 * 반환값 ----
 * yyyymmdd 또는 함수 입력시 지정된 구분자를 가지는 yyyy?mm?dd 값
 *
 * 사용예 ---
 * 2008-01-01 에 3 일 더하기 ==> addDate("d", 3, "2008-08-01", "-");
 * 20080301 에 8 개월 더하기 ==> addDate("m", 8, "20080301", "");
 --------------------------------------------------------------------------- */
function gfn_addDate(pInterval, pAddVal, pYyyymmdd, pDelimiter){
	var yyyy;
	var mm;
	var dd;
	var cDate;
	var oDate;
	var cYear, cMonth, cDay;

	if (pDelimiter != "") {
		pYyyymmdd = pYyyymmdd.replace(eval("/\\" + pDelimiter + "/g"), "");
	}

	yyyy = pYyyymmdd.substr(0, 4);
	mm  = pYyyymmdd.substr(4, 2);
	dd  = pYyyymmdd.substr(6, 2);

	if (pInterval == "yyyy") {
		yyyy = (yyyy * 1) + (pAddVal * 1); 
	} else if (pInterval == "m") {
		mm  = (mm * 1) + (pAddVal * 1);
	} else if (pInterval == "d") {
		dd  = (dd * 1) + (pAddVal * 1);
	}

	cDate = new Date(yyyy, mm - 1, dd) // 12월, 31일을 초과하는 입력값에 대해 자동으로 계산된 날짜가 만들어짐.
	cYear = cDate.getFullYear();
	cMonth = cDate.getMonth() + 1;
	cDay = cDate.getDate();

	cMonth = cMonth < 10 ? "0" + cMonth : cMonth;
	cDay = cDay < 10 ? "0" + cDay : cDay;

	if (pDelimiter != "") {
		return cYear + pDelimiter + cMonth + pDelimiter + cDay;
	} else {
		return cYear + cMonth + cDay;
	}
}
