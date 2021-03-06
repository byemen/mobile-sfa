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
	String sUpGroupId = (String)request.getParameter("GV_UP_GROUP_ID");
	String sDealerId = (String)request.getParameter("DEALER_ID");
	String sToMonthDay = (String)request.getParameter("TOMONTH_DAY");
	String sTargetDay = (String)request.getParameter("TARGET_DAY");
	String sBeMonth = (String)request.getParameter("BEFORE_MONTH");
	
	try {
		//Connection 정보 가져오기
		tmkr.common.ConnectionInfo connectioninfo = new tmkr.common.ConnectionInfo();
		con = connectioninfo.getConnection("L");   
//		con = getConnection();   

		SqlExecutor db = new DatasetSqlExecutor(con);
		SqlRequest sqlRequest = SqlMapManagerUtility.makeSqlRequest("mdms/mp/main:S310002_W01_S01");		
		
		sqlRequest.addParamObject("GV_UP_GROUP_ID", sUpGroupId);
		sqlRequest.addParamObject("DEALER_ID", sDealerId);
		sqlRequest.addParamObject("TOMONTH_DAY", sToMonthDay);
		sqlRequest.addParamObject("TARGET_DAY", sTargetDay);
		sqlRequest.addParamObject("BEFORE_MONTH", sBeMonth);
		
		Dataset ds_ret = (Dataset)db.query(sqlRequest).getResultObject();
		
		String sDayNm = "";
		for(int i=0; i<ds_ret.getRowCount(); i++) {
			sTitle = ds_ret.getColumnAsString(i, "TITLE");

      		for(int j=1; j<32; j++){	
	      		String sIdx= ""+j;
	      		if(sIdx.length()==1) sDayNm = "D0"+j;
	      		else sDayNm = "D"+j;
		      		
	      		if(sTitle.equals("S.Target"))sMakeCategory = sMakeCategory + "<category label='"+sIdx+"' />";
		      	if(sTitle.equals("S.Target"))sMakeDataSet1 = sMakeDataSet1 + "<set value='"+ds_ret.getColumnAsString(i, sDayNm)+"' />";
		      	if(sTitle.equals("Sales"))sMakeDataSet2 = sMakeDataSet2 + "<set value='"+ds_ret.getColumnAsString(i, sDayNm)+"' />";
		      	if(sTitle.equals("C.Target"))sMakeDataSet3 = sMakeDataSet3 + "<set value='"+ds_ret.getColumnAsString(i, sDayNm)+"' />";
		      	if(sTitle.equals("Contract"))sMakeDataSet4 = sMakeDataSet4 + "<set value='"+ds_ret.getColumnAsString(i, sDayNm)+"' />";
	   		}
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
   <dataset seriesName="S.Target" color="00CDFF" anchorBorderThickness="0" anchorBgColor="00CDFF">
		<%=sMakeDataSet1%>
   </dataset>
   <dataset seriesName="Sales" color="60C200" anchorBorderThickness="0" anchorBgColor="60C200">
		<%=sMakeDataSet2%>
   </dataset>
   <dataset seriesName="C.Target" color="FE0E86" anchorBorderThickness="0" anchorBgColor="FE0E86">
		<%=sMakeDataSet3%>
   </dataset>
   <dataset seriesName="Contract" color="FF9600" anchorBorderThickness="0" anchorBgColor="FF9600">
		<%=sMakeDataSet4%>
   </dataset>
</chart>