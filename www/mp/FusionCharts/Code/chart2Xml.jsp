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
	String sUpGroupId = (String)request.getParameter("GV_UP_GROUP_ID");
	String sDealerId = (String)request.getParameter("DEALER_ID");
	String sYyyyMm = (String)request.getParameter("YYYYMM");
	String sToDay = (String)request.getParameter("TODAY");
	
	try {
		//Connection 정보 가져오기
		tmkr.common.ConnectionInfo connectioninfo = new tmkr.common.ConnectionInfo();
		con = connectioninfo.getConnection("L");   
//		con = getConnection();   
		SqlExecutor db = new DatasetSqlExecutor(con);
		SqlRequest sqlRequest = SqlMapManagerUtility.makeSqlRequest("mdms/mp/main:S310002_W01_S02");
		
		sqlRequest.addParamObject("GV_UP_GROUP_ID", sUpGroupId);
		sqlRequest.addParamObject("DEALER_ID", sYyyyMm);
		sqlRequest.addParamObject("YYYYMM", sYyyyMm);
		sqlRequest.addParamObject("TODAY", sToDay);		
		
		Dataset ds_ret = (Dataset)db.query(sqlRequest).getResultObject();
		
		for(int i=0; i<ds_ret.getRowCount(); i++) {
			String sVariNm = ds_ret.getColumnAsString(i, "VARIANT_NM");
			String sBocCnt = ds_ret.getColumnAsString(i, "BOC_CNT");
			String sAvailCnt = ds_ret.getColumnAsString(i, "AVAILABLE_CNT");
			
     		sMakeCategory = sMakeCategory + "<category label='"+sVariNm+"' />";
	      	sMakeDataSet1 = sMakeDataSet1 + "<set value='"+sBocCnt+"' />";
	      	sMakeDataSet2 = sMakeDataSet2 + "<set value='"+sAvailCnt+"' />";
      	}
		
	} catch(Exception exception) {
		exception.printStackTrace();
	} finally {
    	if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
    }
%>

<chart showLegend='1' showvalues='0' showlabels='1' showyaxisvalues='1' showBorder='0' bgColor='2a2a2a,5d5d5d' bgalpha='100,100' canvasBgColor='FFFFFF' canvasbgalpha='0' canvasBorderalpha='0' alternateHGridAlpha='0' baseFontSize = '9' baseFontColor = 'FFFFFF' numVDivLines = '29' vDivLineColor = 'FFFFFF' legendBgColor = '000000' toolTipBgColor = '696969' captionPadding='0' xAxisNamePadding='0' yAxisNamePadding='0' yAxisValuesPadding='0' chartLeftMargin = '0' chartRightMargin = '10' chartBottomMargin='0' labelPadding='0' labelDisplay='0'>
   <categories>
		<%=sMakeCategory%> 
   </categories>
   <dataset seriesName="BOC Stock" color="00CDFF" anchorBorderThickness="0" anchorBgColor="00CDFF">
		<%=sMakeDataSet1%>
   </dataset>
   <dataset seriesName="Available Stock" color="60C200" anchorBorderThickness="0" anchorBgColor="60C200">
		<%=sMakeDataSet2%>
   </dataset>
</chart>