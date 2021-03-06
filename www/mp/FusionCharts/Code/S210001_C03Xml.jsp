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
	String sTitle = "";
	String sAction = (String)request.getParameter("ACTION");
	String sUpGroupId = (String)request.getParameter("GV_UP_GROUP_ID");
	String sDealerId = (String)request.getParameter("DEALER_ID");
	String sToMonthDay = (String)request.getParameter("TOMONTH_DAY");
	String sBeMonth = (String)request.getParameter("BEFORE_MONTH");

	try {
		//Connection 정보 가져오기
		tmkr.common.ConnectionInfo connectioninfo = new tmkr.common.ConnectionInfo();
		con = connectioninfo.getConnection(sAction);   
//		con = getConnection(sAction);   
		SqlExecutor db = new DatasetSqlExecutor(con);
		SqlRequest sqlRequest = SqlMapManagerUtility.makeSqlRequest("mdms/mp/eis:S210001_W01_S03");		
		
		sqlRequest.addParamObject("GV_UP_GROUP_ID", sUpGroupId);
		sqlRequest.addParamObject("DEALER_ID", sDealerId);
		sqlRequest.addParamObject("TOMONTH_DAY", sToMonthDay);
		sqlRequest.addParamObject("BEFORE_MONTH", sBeMonth);
		
		Dataset ds_ret = (Dataset)db.query(sqlRequest).getResultObject();
		
		for(int i=0; i<ds_ret.getRowCount(); i++) {
			sTitle = ds_ret.getColumnAsString(i, "ACTIVE_KND");
			String sDays = ds_ret.getColumnAsString(i, "DAYS");
			int nCnt = ds_ret.getColumnAsInteger(i, "CNT");
	      		
      		if(sTitle.equals("Visit")){
      			sMakeCategory = sMakeCategory + "<category label='"+sDays+"' />";
      			sMakeDataSet1 = sMakeDataSet1 + "<set value='"+nCnt+"' />";
      		}
      		if(sTitle.equals("Last Month")){
      			sMakeDataSet2 = sMakeDataSet2 + "<set value='"+nCnt+"' />";
      		}
      		if(sTitle.equals("Same Month of L.Year")){
      			sMakeDataSet3 = sMakeDataSet3 + "<set value='"+nCnt+"' />";
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
   <dataset seriesName="Last Month" color="C0C0C0" anchorBorderThickness="0" anchorBgColor="C0C0C0">
		<%=sMakeDataSet2%>
   </dataset>
	<dataset seriesName="This Month" color="FE0E86" anchorBorderThickness="0" anchorBgColor="FE0E86">
		<%=sMakeDataSet1%>
   </dataset>
	<dataset seriesName="Same Month of L.Year" color="00CDFF" anchorBorderThickness="0" anchorBgColor="00CDFF">
		<%=sMakeDataSet3%>
   </dataset>
</chart>