/**
 * @target
 */
var WebSquare_js= {}; //This is WebSquare JavaScript Marker. Do not remove this line.
//var GV_SERVER_URL = "http://127.0.0.1:8080/TOYOTA_WEB/WebsquareMain"; // local
var GV_SERVER_URL = "http://192.168.2.22/WebsquareMain"; // server

function setTitSendInfo(rootXPath, actionName, cmd, sqlid ){

	/*	2010-11-09 박종근 작성
	XFW을 호출하기 위해 기본 파라미터들을 셋팅하는 함수 : 해당 노드가 있으면 업데이트 없으면 생성
	Xpath 는 다음과 같이 고정되어 있음
	request/root/params/param....
	
	
	주의 : 이함수를 호출하면 기존에 있던 request/root/params/ 의 노드는 모두 삭제후 다시 만듬 (초기화 목적)
	*/
	

	//1. request/root/params 의 xpath가 있으면 삭제후 다시 생성
	
	var tempNode = WebSquare.ModelUtil.findInstanceNode( "request/root" );
	
	if(tempNode != null){
	//	alert("공통 있음 삭제 해야함.");
		WebSquare.ModelUtil.removeInstanceNode( "request/root" );
	}
	
	var tmpString = "<root><params></params></root>";
		tmpDoc = WebSquare.xml.parse( tmpString );
	WebSquare.ModelUtil.setInstanceNode( tmpDoc, "request","", "append");
	
	
	//2. 입력 받은 아귀먼트 기준으로 노드 생성 또는 삭제
	
	setInputParamData("actionName", actionName);
	
	if(cmd.length >0){
		setInputParamData("cmd", cmd);
	}else{
		setInputParamData("cmd", "execute");
	}
	setInputParamData("sqlid", sqlid);
	setInputParamData("GV_GROUP_ID", GV_GROUP_ID);
	setInputParamData("GV_UP_GROUP_ID", GV_UP_GROUP_ID);
	setInputParamData("GV_USER_GROUP", GV_USER_GROUP);
	setInputParamData("GV_USER_ID", GV_USER_ID);
	setInputParamData("GV_BRAND_CD", GV_BRAND_CD);
}
/****************************************************************
 * 서브미션 action
 * @param submissionId
 * @return
******************************************************************/
function setSubmissison(submisstionId){
	var tmpSubObj = WebSquare.ModelUtil.getSubmission( submisstionId );
	tmpSubObj.action = GV_SERVER_URL;
	WebSquare.ModelUtil.executeSubmission( submisstionId );
}
function setInputParamData(attributeName, TextValue){

	var tmpActionName = WebSquare.ModelUtil.findInstanceNode( "request/root/params/param[@id='" + attributeName+ "']" );
	
	if (tmpActionName == null){
		//기존에 없던 노드일 경우
		var tmpString = "<param id='" + attributeName+ "' type='STRING'>" + TextValue + "</param>";
 		tmpDoc = WebSquare.xml.parse( tmpString );
		WebSquare.ModelUtil.setInstanceNode( tmpDoc, "request/root/params","", "append");
	}else{
		//해당 노드가 있을 경우
		WebSquare.ModelUtil.setInstanceValue( "request/root/params/param[@id='" + attributeName + "']", TextValue );
	}
}
function deleteInputParamData(attributeName){
	var tmpActionName = WebSquare.ModelUtil.findInstanceNode( "request/root/params/param[@id='" + attributeName+ "']" );
	if (tmpActionName != null){
		//해당 노드가 있을 경우
		WebSquare.ModelUtil.removeChildNodes( "request/root/params/param[@id='" + attributeName + "']");
	}
}

function setInstanceNodeDataSetforTIT(datasetName, xmlObject, targetXpath ){
	WebSquare.xml.setValue( xmlObject, "dataset", "id", datasetName );
	
	var tmpActionName = WebSquare.ModelUtil.findInstanceNode(targetXpath+ "/dataset[@id='" + datasetName + "']" );
	if(tmpActionName == null){
		WebSquare.ModelUtil.setInstanceNode( xmlObject, targetXpath, "", "append" );
	}else{
//		alert("@@@@@@@@@@@@@@" + targetXpath+ "/dataset[@id='" + datasetName + "']" + "있음");
		WebSquare.ModelUtil.setInstanceNode( xmlObject, targetXpath, "", "replace" );
	}
}