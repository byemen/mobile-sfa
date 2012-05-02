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
	String sDealerId = (String)request.getParameter("DEALER_ID");
	int chartMax = 0;
	int chartMin = 0;
	try {
		//Connection 정보 가져오기
		tmkr.common.ConnectionInfo connectioninfo = new tmkr.common.ConnectionInfo();
		con = connectioninfo.getConnection(sAction);   
//		con = getConnection(sAction);   
		SqlExecutor db = new DatasetSqlExecutor(con);
		SqlRequest sqlRequest1 = SqlMapManagerUtility.makeSqlRequest("mdms/mp/eis:S210005_W01_S01");		
		SqlRequest sqlRequest2 = SqlMapManagerUtility.makeSqlRequest("mdms/mp/eis:S210005_W01_S02");
		
		sqlRequest1.addParamObject("DEALER_ID", sDealerId);
		sqlRequest2.addParamObject("DEALER_ID", sDealerId);
		
		Dataset ds_ret1 = (Dataset)db.query(sqlRequest1).getResultObject();
		Dataset ds_ret2 = (Dataset)db.query(sqlRequest2).getResultObject();

		int nEntry = 0;
		int nServiceSales = 0;		
		int nCpus = 0;
		int nCpSales = 0;
		
			
		for(int i=0; i<ds_ret1.getRowCount(); i++) {
			sTitle = ds_ret1.getColumnAsString(i, "KPI_DT");
			nEntry = ds_ret1.getColumnAsInteger(i, "ENTRY") + ds_ret2.getColumnAsInteger(i, "ENTRY");
			nServiceSales = ds_ret1.getColumnAsInteger(i, "SERVICE_SALES") + ds_ret2.getColumnAsInteger(i, "SERVICE_SALES");
			nCpus = ds_ret1.getColumnAsInteger(i, "CPUS") + ds_ret2.getColumnAsInteger(i, "CPUS");
			nCpSales = ds_ret1.getColumnAsInteger(i, "CP_SALES") + ds_ret2.getColumnAsInteger(i, "CP_SALES");

			if(chartMax<nEntry){
				chartMax = nEntry;
			}

    		sMakeCategory = sMakeCategory + "<category label='"+sTitle+"' />";
    		sMakeDataSet1 = sMakeDataSet1 + "<set value='"+nEntry+"' />";
    		sMakeDataSet2 = sMakeDataSet2 + "<set value='"+nServiceSales+"' />";
    		sMakeDataSet3 = sMakeDataSet3 + "<set value='"+nCpus+"' />";
    		sMakeDataSet4 = sMakeDataSet4 + "<set value='"+nCpSales+"' />";

      	}

	} catch(Exception exception) {
		exception.printStackTrace();
	} finally {
    	if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
    }
%>

<chart showLegend='1' showvalues='1' showlabels='1' showyaxisvalues='1' showBorder='0' bgColor='2a2a2a,5d5d5d' bgalpha='100,100' canvasBgColor='FFFFFF' canvasbgalpha='0' canvasBorderalpha='0' alternateHGridAlpha='0' baseFontSize = '9' baseFontColor = 'FFFFFF' numVDivLines = '29' vDivLineColor = 'FFFFFF' legendBgColor = '000000' toolTipBgColor = '696969' captionPadding='0' xAxisNamePadding='0' yAxisNamePadding='0' yAxisValuesPadding='0' chartLeftMargin = '0' chartRightMargin = '10' chartBottomMargin='0' labelPadding='0' labelDisplay='0' numberScaleValue='1000000000,1000000000,1000000000' numberScaleUnit='K,M,B' formatNumber='0' formatNumberScale='0' pyAxisMaxValue='<%=chartMax*2%>'>
   <categories>
		<%=sMakeCategory%> 
   </categories>
   <dataset seriesName="Entry-Total(GR+BP)111" color="00CDFF" anchorBorderThickness="0" anchorBgColor="00CDFF" parentYAxis="P">
		<%=sMakeDataSet1%>
   </dataset>
   <dataset seriesName="Service Sales-Total(GR+BP)" color="60C200" anchorBorderThickness="0" anchorBgColor="60C200" parentYAxis="S">
		<%=sMakeDataSet2%>
   </dataset>
   <dataset seriesName="CPUS-Total(GR+BP)" color="FE0E86" anchorBorderThickness="0" anchorBgColor="FE0E86" parentYAxis="P">
		<%=sMakeDataSet3%>
   </dataset>
   <dataset seriesName="CP Sales-Total(GR+BP)" color="FF9600" anchorBorderThickness="0" anchorBgColor="FF9600" parentYAxis="S">
		<%=sMakeDataSet4%>
   </dataset>
</chart>