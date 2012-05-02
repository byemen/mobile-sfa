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
	String sTitle = "";
	String sAction = (String)request.getParameter("ACTION");
	String sDealerId = (String)request.getParameter("DEALER_ID");
	String sBrandCd = (String)request.getParameter("BRAND_CD");
	
	try {
		//Connection 정보 가져오기
		tmkr.common.ConnectionInfo connectioninfo = new tmkr.common.ConnectionInfo();
		con = connectioninfo.getConnection(sAction);   
//		con = getConnection(sAction);   
		SqlExecutor db = new DatasetSqlExecutor(con);
		SqlRequest sqlRequest1 = SqlMapManagerUtility.makeSqlRequest("mdms/mp/eis:S210005_W01_S02");		
		SqlRequest sqlRequest2 = SqlMapManagerUtility.makeSqlRequest("mdms/mp/eis:S210005_W01_S04");
		
		sqlRequest1.addParamObject("DEALER_ID", sDealerId);
		sqlRequest2.addParamObject("DEALER_ID", sDealerId);
		sqlRequest2.addParamObject("BRAND_CD", sBrandCd);
		
		Dataset ds_ret1 = (Dataset)db.query(sqlRequest1).getResultObject();
		Dataset ds_ret2 = (Dataset)db.query(sqlRequest2).getResultObject();

		float nEntry = 0;
		float nServiceSales = 0;
		int nSKpiQty = 0;
			
		for(int i=0; i<ds_ret1.getRowCount(); i++) {
			sTitle = ds_ret1.getColumnAsString(i, "KPI_DT");
			nSKpiQty = ds_ret2.getColumnAsInteger(i, "SERVICE_KPI_QTY");
			
			if(nSKpiQty == 0)
				nEntry = 0;
			else 
				nEntry = (float)ds_ret1.getColumnAsInteger(i, "ENTRY")/ds_ret2.getColumnAsInteger(0, "SERVICE_KPI_QTY")*100;
			
			if(ds_ret1.getColumnAsInteger(i, "ENTRY") == 0)
				nServiceSales = 0;
			else 
				nServiceSales = ds_ret1.getColumnAsInteger(i, "SERVICE_SALES")/ds_ret1.getColumnAsInteger(i, "ENTRY");

			
    		sMakeCategory = sMakeCategory + "<category label='"+sTitle+"' />";
    		sMakeDataSet1 = sMakeDataSet1 + "<set value='"+String.format("%.1f", nEntry)+"' />";
    		sMakeDataSet2 = sMakeDataSet2 + "<set value='"+String.format("%.1f", nServiceSales)+"' />";
      		
      	}
		
	} catch(Exception exception) {
		exception.printStackTrace();
	} finally {
    	if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
    }
%>

<chart showLegend='1' showvalues='1' showlabels='1' showyaxisvalues='1' showBorder='0' bgColor='2a2a2a,5d5d5d' bgalpha='100,100' canvasBgColor='FFFFFF' canvasbgalpha='0' canvasBorderalpha='0' alternateHGridAlpha='0' baseFontSize = '9' baseFontColor = 'FFFFFF' numVDivLines = '29' vDivLineColor = 'FFFFFF' legendBgColor = '000000' toolTipBgColor = '696969' captionPadding='0' xAxisNamePadding='0' yAxisNamePadding='0' yAxisValuesPadding='0' chartLeftMargin = '0' chartRightMargin = '10' chartBottomMargin='0' labelPadding='0' labelDisplay='0' sNumberSuffix='%' syAxisMaxValue='5' syAxisMinValue='-5' numberScaleValue='1000000000,1000000000,1000000000' numberScaleUnit='K,M,B' formatNumber='0' formatNumberScale='0'>
   <categories>
		<%=sMakeCategory%> 
   </categories>
   <dataset seriesName="BP Entry Rate" color="FE0E86" anchorBorderThickness="0" anchorBgColor="FE0E86" parentYAxis="S">
		<%=sMakeDataSet1%>
   </dataset>
   <dataset seriesName="BP Sales/Entry" color="00CDFF" anchorBorderThickness="0" anchorBgColor="00CDFF" parentYAxis="P">
		<%=sMakeDataSet2%>
   </dataset>
</chart>