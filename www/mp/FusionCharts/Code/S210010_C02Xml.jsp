<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%@page import="java.sql.*"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.*"%>
<%@page import="java.util.Vector"%>
<%@page import="tit.service.sqlmap.*"%>
<%@page import="tit.service.sqlmap.dataset.DatasetSqlExecutor"%>
<%@page import="com.tobesoft.platform.data.Dataset"%>
<%
	Connection con = null;


	String sMakeCategory = "";
	String sMakeDataSet1 = "";
	String sMakeDataSet2 = "";
	String sMakeDataSet3 = "";
	String sMakeDataSet4 = "";
	String sTitle = "";
	String sAction = (String)request.getParameter("ACTION");
	String sUpGroupId = (String)request.getParameter("GV_UP_GROUP_ID");
	String sDealerId = (String)request.getParameter("DEALER_ID");
	String sToMonthDay = (String)request.getParameter("TOMONTH_DAY");
	String sTargetDay = (String)request.getParameter("TARGET_DAY");
	String sBeMonth = (String)request.getParameter("BEFORE_MONTH");

	try {
		//Connection 정보 가져오기
		tmkr.common.ConnectionInfo connectioninfo = new tmkr.common.ConnectionInfo();
		con = connectioninfo.getConnection(sAction);   
//		con = getConnection(sAction);   
		SqlExecutor db = new DatasetSqlExecutor(con);
		SqlRequest sqlRequest = SqlMapManagerUtility.makeSqlRequest("mdms/mp/eis:S210001_W01_S02");		
		
		sqlRequest.addParamObject("GV_UP_GROUP_ID", sUpGroupId);
		sqlRequest.addParamObject("DEALER_ID", sDealerId);
		sqlRequest.addParamObject("TOMONTH_DAY", sToMonthDay);
		sqlRequest.addParamObject("TARGET_DAY", sTargetDay);
		sqlRequest.addParamObject("BEFORE_MONTH", sBeMonth);
		
		Dataset ds_ret = (Dataset)db.query(sqlRequest).getResultObject();
		
		int sSCurrData = 0;
		int sSPrevData = 0;
		int sBCurrData = 0;
		int sBPrevData = 0;
		String sDayNm = "";		
		for(int i=0; i<ds_ret.getRowCount(); i++) {
			sTitle = ds_ret.getColumnAsString(i, "TITLE");
			
      		for(int j=1; j<32; j++){	
      			if(j < 10)	sDayNm = "0"+j;
      			else		sDayNm = ""+j;
	      		
	      		if(sTitle.equals("S.Target")){
	      			sMakeCategory = sMakeCategory + "<category label='"+sDayNm+"' />";
	      			sMakeDataSet1 = sMakeDataSet1 + "<set value='"+ds_ret.getColumnAsInteger(i, "D" + sDayNm)+"' />";
	      		}
		      	if(sTitle.equals("Sales")){		      			
		      		sSCurrData = ds_ret.getColumnAsInteger(i, "D" + sDayNm);	
		      		if(sSCurrData != 0){
		      			sSPrevData = sSCurrData;
		      			sMakeDataSet2 = sMakeDataSet2 + "<set value='"+sSCurrData+"' />";
		      		} else{
		      			sMakeDataSet2 = sMakeDataSet2 + "<set value='"+sSPrevData+"' />";
		      		}
		      	}
      			if(sTitle.equals("C.Target")){
	      			sMakeDataSet3 = sMakeDataSet3 + "<set value='"+ds_ret.getColumnAsInteger(i, "D" + sDayNm)+"' />";
	      		}
		      	if(sTitle.equals("Contract")){
		      		sBCurrData = ds_ret.getColumnAsInteger(i, "D" + sDayNm);
		      		if(sBCurrData != 0){
		      			sBPrevData = sBCurrData;
		      			sMakeDataSet4 = sMakeDataSet4 + "<set value='"+sBCurrData+"' />";
		      		} else{
		      			sMakeDataSet4 = sMakeDataSet4 + "<set value='"+sBPrevData+"' />";
		      		}
		      	}
			}
      	}
	} catch(Exception exception) {
		exception.printStackTrace();
	} finally {
    	if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
    }
%>
<chart showLegend='1' 
	showlabels='1' 
	lineThickness='5'
	anchorRadius='4'
	showyaxisvalues='1' 
	showBorder='0' 
	bgColor='2a2a2a,5d5d5d' 
	bgalpha='100,100' 
	canvasBgColor='FFFFFF' 
	canvasbgalpha='0' 
	canvasBorderalpha='0' 
	alternateHGridAlpha='0' 
	baseFontSize = '9' 
	baseFontColor = 'FFFFFF' 
	numVDivLines = '29' 
	vDivLineColor = 'FFFFFF' 
	legendBgColor = '000000' 
	toolTipBgColor = '696969' 
	captionPadding='0' 
	xAxisNamePadding='0' 
	yAxisNamePadding='0' 
	yAxisValuesPadding='0' 
	chartLeftMargin = '0' 
	chartRightMargin = '10' 
	chartBottomMargin='0' 
	labelPadding='0' 
	labelDisplay='0'
	formatNumber='0' formatNumberScale='0'>
   <categories>
		<%=sMakeCategory%> 
   </categories>
   <dataset seriesName="C.Target" color="C0C0C0" anchorBorderThickness="0" anchorBgColor="C0C0C0" renderAs="Line" showvalues='0' >
		<%=sMakeDataSet3%>
   </dataset>
   <dataset seriesName="Contracts" color="66CCFF" anchorBorderThickness="0" anchorBgColor="66CCFF" renderAs="Line" showvalues='0' >
		<%=sMakeDataSet4%>
   </dataset>
</chart>