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
	String sDealerId = (String)request.getParameter("DEALER_ID");
	String sYear = (String)request.getParameter("YEAR");
	String sBeforeYear = (String)request.getParameter("BEFORE_YEAR");
	String sTitle2 = "";
	try {
		//Connection 정보 가져오기
		tmkr.common.ConnectionInfo connectioninfo = new tmkr.common.ConnectionInfo();
		con = connectioninfo.getConnection(sAction);
		SqlExecutor db = new DatasetSqlExecutor(con);
		SqlRequest sqlRequest = SqlMapManagerUtility.makeSqlRequest("mdms/mp/eis:S210001_P03_S01");		

		sqlRequest.addParamObject("GV_UP_GROUP_ID", sUpGroupId);
		sqlRequest.addParamObject("DEALER_ID", sDealerId);
		sqlRequest.addParamObject("YEAR", sYear);

		Dataset ds_ret = (Dataset)db.query(sqlRequest).getResultObject();

		String[] arrMonth = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
		String sMonNm = "";	

		for(int i=0; i<ds_ret.getRowCount(); i++) {			
			sTitle = ds_ret.getColumnAsString(i, "YEARS");

			for(int j=0; j<arrMonth.length; j++){
				sMonNm = "M" + (j+1);

				int nCnt = ds_ret.getColumnAsInteger(i, sMonNm);

	      		if(sTitle.equals(sYear)){
	      			sMakeCategory = sMakeCategory + "<category label='"+arrMonth[j]+"' />";
	      			sMakeDataSet1 = sMakeDataSet1 + "<set value='"+nCnt+"' />";
	      		}else{
					sTitle2 = ds_ret.getColumnAsString(i, "YEARS");
	      			
					sMakeDataSet2 = sMakeDataSet2 + "<set value='"+nCnt+"' />";
				}
			}
      	}
	} catch(Exception exception) {
		exception.printStackTrace();
	} finally {
    	if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
	}
%>

<chart showLegend='1' showvalues='1' showlabels='1' showyaxisvalues='1' showBorder='0' bgColor='2a2a2a,5d5d5d' bgalpha='100,100' canvasBgColor='FFFFFF' canvasbgalpha='0' canvasBorderalpha='0' alternateHGridAlpha='0' baseFontSize = '9' baseFontColor = 'FFFFFF' numVDivLines = '29' vDivLineColor = 'FFFFFF' legendBgColor = '000000' toolTipBgColor = '696969' captionPadding='0' xAxisNamePadding='0' yAxisNamePadding='0' yAxisValuesPadding='0' chartLeftMargin = '0' chartRightMargin = '10' chartBottomMargin='0' labelPadding='0' labelDisplay='0'>
   <categories>
		<%=sMakeCategory%> 
   </categories>
   <dataset seriesName="<%=sYear%>" color="FE0E86" anchorBorderThickness="0" anchorBgColor="FE0E86" renderAs="Line">
		<%=sMakeDataSet1%>
   </dataset>
   <dataset seriesName="<%=sBeforeYear%>" color="00CDFF" anchorBorderThickness="0" anchorBgColor="00CDFF" renderAs="Line">
		<%=sMakeDataSet2%>
   </dataset>
</chart>