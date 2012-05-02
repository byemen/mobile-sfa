<%@ page language="java" contentType="text/html;charset=UTF-8" %>
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
	String sDealerId = (String)request.getParameter("DEALER_ID");
	String sYear = (String)request.getParameter("YEAR");
	String sMonth = (String)request.getParameter("MONTH");
	try {
		//Connection 정보 가져오기
		tmkr.common.ConnectionInfo connectioninfo = new tmkr.common.ConnectionInfo();
		con = connectioninfo.getConnection(sAction);   
		SqlExecutor db = new DatasetSqlExecutor(con);
		SqlRequest sqlRequest1 = SqlMapManagerUtility.makeSqlRequest("mdms/mp/eis:S210008_W01_S01");		
		
		sqlRequest1.addParamObject("DEALER_ID", sDealerId);
		sqlRequest1.addParamObject("YYYY", sYear);
		
		Dataset ds_ret1 = (Dataset)db.query(sqlRequest1).getResultObject();

		int nTargetCnt = 0;
		int nSalesCnt = 0;		
		int nPercentage = 0;

		String nThisMonthTarget = "T_"+sMonth;
		String nThisMonthSaels = "S_"+sMonth;
		String nThisMonthPercent = "P_"+sMonth;
			
		for(int i=0; i<ds_ret1.getRowCount(); i++) {
			sTitle = ds_ret1.getColumnAsString(i, "NAME");
			nTargetCnt = ds_ret1.getColumnAsInteger(i, nThisMonthTarget);
			nSalesCnt = ds_ret1.getColumnAsInteger(i, nThisMonthSaels);
			nPercentage = ds_ret1.getColumnAsInteger(i, nThisMonthPercent);
		
    		sMakeCategory = sMakeCategory + "<category label='"+sTitle+"' />";
    		sMakeDataSet1 = sMakeDataSet1 + "<set value='"+nTargetCnt+"' />";
    		sMakeDataSet2 = sMakeDataSet2 + "<set value='"+nSalesCnt+"' />";
    		sMakeDataSet3 = sMakeDataSet3 + "<set value='"+nPercentage+"' />";
      	}
	} catch(Exception exception) {
		exception.printStackTrace();
	} finally {
    	if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
    }
//showpyaxisvalues='0' 
%>

<chart showLegend='1' showvalues='0' showlabels='1' showBorder='0' showyaxisvalues='1' bgColor='2a2a2a,5d5d5d' bgalpha='100,100' canvasBgColor='FFFFFF' canvasbgalpha='0' canvasBorderalpha='0' alternateHGridAlpha='0' baseFontSize = '12' baseFontColor = 'FFFFFF' numVDivLines = '100' vDivLineColor = 'FFFFFF' legendBgColor = '000000' toolTipBgColor = '696969' captionPadding='0' xAxisNamePadding='0' yAxisNamePadding='0' yAxisValuesPadding='0' chartLeftMargin = '0' chartRightMargin = '5' chartBottomMargin='0' labelPadding='0' labelDisplay='0'  numberScaleValue='10000,10000,10000' numberScaleUnit='K,M,B' SNumberSuffix="%" syAxisMaxValue='200' syAxisMinValue='-90'  formatNumber='0' formatNumberScale='0'>
   <categories>
		<%=sMakeCategory%> 
   </categories>
   <dataset seriesName="Sales Target" color="60C200" anchorBorderThickness="0" anchorBgColor="60C200" parentYAxis="P">
		<%=sMakeDataSet1%>
   </dataset>
   <dataset seriesName="Sales Total" color="00CDFF" anchorBorderThickness="0" anchorBgColor="00CDFF" parentYAxis="P">
		<%=sMakeDataSet2%>
   </dataset>
   <dataset seriesName="Archive Rate" color="FE0E86" anchorBorderThickness="0" anchorBgColor="FE0E86" parentYAxis="S" showvalues='1'>
		<%=sMakeDataSet3%>
   </dataset>
</chart>