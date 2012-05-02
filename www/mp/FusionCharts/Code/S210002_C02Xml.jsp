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
	String sUpGroupId = (String)request.getParameter("GV_UP_GROUP_ID");
	String sYyyyMm = (String)request.getParameter("YYYYMM");
	
	try {
		//Connection 정보 가져오기
		tmkr.common.ConnectionInfo connectioninfo = new tmkr.common.ConnectionInfo();
		con = connectioninfo.getConnection(sAction);   
//		con = getConnection(sAction);   
		SqlExecutor db = new DatasetSqlExecutor(con);
		SqlRequest sqlRequest1 = SqlMapManagerUtility.makeSqlRequest("mdms/mp/eis:S210002_W01_S03");		
		SqlRequest sqlRequest2 = SqlMapManagerUtility.makeSqlRequest("mdms/mp/eis:S210002_W01_S04");
		
		sqlRequest1.addParamObject("GV_UP_GROUP_ID", sUpGroupId);
		sqlRequest1.addParamObject("YYYYMM", sYyyyMm);
		sqlRequest2.addParamObject("GV_UP_GROUP_ID", sUpGroupId);
		sqlRequest2.addParamObject("YYYYMM", sYyyyMm);
		
		Dataset ds_ret1 = (Dataset)db.query(sqlRequest1).getResultObject();
		Dataset ds_ret2 = (Dataset)db.query(sqlRequest2).getResultObject();
		
		for(int i=0; i<ds_ret1.getRowCount(); i++) {
			sTitle = ds_ret1.getColumnAsString(i, "DEALER_ID");
	      		
    		sMakeCategory = sMakeCategory + "<category label='"+sTitle+"' />";
    		sMakeDataSet1 = sMakeDataSet1 + "<set value='"+ds_ret1.getColumnAsInteger(i, "CNT")+"' />";
    		sMakeDataSet2 = sMakeDataSet2 + "<set value='"+ds_ret2.getColumnAsInteger(i, "CNT")+"' />";
      		
      	}
		
	} catch(Exception exception) {
		exception.printStackTrace();
	} finally {
    	if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
    }
%>

<chart showLegend='1' showvalues='0' showlabels='1' showyaxisvalues='1' showBorder='0' bgColor='2a2a2a,5d5d5d' bgalpha='100,100' canvasBgColor='FFFFFF' canvasbgalpha='0' canvasBorderalpha='0' alternateHGridAlpha='0' baseFontSize = '9' baseFontColor = 'FFFFFF' numVDivLines = '29' vDivLineColor = 'FFFFFF' legendBgColor = '000000' toolTipBgColor = '696969' captionPadding='0' xAxisNamePadding='0' yAxisNamePadding='0' yAxisValuesPadding='0' chartLeftMargin = '0' chartRightMargin = '10' chartBottomMargin='0' labelPadding='0' labelDisplay='0' formatNumber='0' formatNumberScale='0'>
   <categories>
		<%=sMakeCategory%> 
   </categories>
   <dataset seriesName="Target" color="00CDFF" anchorBorderThickness="0" anchorBgColor="00CDFF">
		<%=sMakeDataSet1%>
   </dataset>
   <dataset seriesName="Actual" color="FE0E86" anchorBorderThickness="0" anchorBgColor="FE0E86" renderAs="Line" showValues="1">
		<%=sMakeDataSet2%>
   </dataset>
</chart>