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
	String sAction = (String)request.getParameter("ACTION");
	String sUpGroupId = (String)request.getParameter("GV_UP_GROUP_ID");
	String sYyyy = (String)request.getParameter("YYYY");
	String sDealerId = (String)request.getParameter("DEALER_ID");
	try {
		//Connection 정보 가져오기
		tmkr.common.ConnectionInfo connectioninfo = new tmkr.common.ConnectionInfo();
		con = connectioninfo.getConnection(sAction);   
//		con = getConnection(sAction);   
		SqlExecutor db = new DatasetSqlExecutor(con);
		SqlRequest sqlRequest = SqlMapManagerUtility.makeSqlRequest("mdms/mp/eis:S210007_W01_S01");
		
		sqlRequest.addParamObject("GV_UP_GROUP_ID", sUpGroupId);
		sqlRequest.addParamObject("YYYYMM", sYyyy);
		sqlRequest.addParamObject("DEALER_ID", sDealerId);
		
		Dataset ds_ret = (Dataset)db.query(sqlRequest).getResultObject();
		
		String sOrderPtn = "";
		String[] arrMonth = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
		float[] arrOPre = new float[12];
		float[] arrSRev = new float[12];
		int nOCnt = 0;
		int nSCnt = 0;
		float nRate = 0;
		
		for(int i=0; i<ds_ret.getRowCount(); i++) {
			sOrderPtn = ds_ret.getColumnAsString(i, "ORDERPTN");
			
			if(sOrderPtn.equals("1")){
				arrSRev[nSCnt] = ds_ret.getColumnAsInteger(i, "AMT");
				
				nSCnt++;
			} else if(sOrderPtn.equals("44")){
				arrOPre[nOCnt] = ds_ret.getColumnAsInteger(i, "AMT");
				nOCnt++;
			}
      	}
		
		for(int j=0; j<arrOPre.length; j++) {
			if(arrSRev[j] == 0)
				nRate = 0;
			else
				nRate = arrOPre[j]/arrSRev[j]*100;
			
			String sMonth = "";

			if(ds_ret.getColumnAsString(j, "MONTH").equals("01"))
				sMonth = "Jan";
			else if(ds_ret.getColumnAsString(j, "MONTH").equals("02"))
				sMonth = "Feb";
			else if(ds_ret.getColumnAsString(j, "MONTH").equals("03"))
				sMonth = "Mar";
			else if(ds_ret.getColumnAsString(j, "MONTH").equals("04"))
				sMonth = "Apr";
			else if(ds_ret.getColumnAsString(j, "MONTH").equals("05"))
				sMonth = "May";
			else if(ds_ret.getColumnAsString(j, "MONTH").equals("06"))
				sMonth = "Jun";
			else if(ds_ret.getColumnAsString(j, "MONTH").equals("07"))
				sMonth = "Jul";
			else if(ds_ret.getColumnAsString(j, "MONTH").equals("08"))
				sMonth = "Aug";
			else if(ds_ret.getColumnAsString(j, "MONTH").equals("09"))
				sMonth = "Sep";
			else if(ds_ret.getColumnAsString(j, "MONTH").equals("10"))
				sMonth = "Oct";
			else if(ds_ret.getColumnAsString(j, "MONTH").equals("11"))
				sMonth = "Nov";
			else if(ds_ret.getColumnAsString(j, "MONTH").equals("12"))
				sMonth = "Dec";

    		sMakeCategory = sMakeCategory + "<category label='"+sMonth+"' />";
    		sMakeDataSet1 = sMakeDataSet1 + "<set value='"+arrOPre[j]+"' />";
    		sMakeDataSet2 = sMakeDataSet2 + "<set value='"+String.format("%.1f", nRate)+"' />";
      		
      	}
		
	} catch(Exception exception) {
		exception.printStackTrace();
	} finally {
    	if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
    }
%>

<chart showLegend='0' showvalues='0' showlabels='1' showyaxisvalues='1' showBorder='0' bgColor='2a2a2a,5d5d5d' bgalpha='100,100' canvasBgColor='FFFFFF' canvasbgalpha='0' canvasBorderalpha='0' alternateHGridAlpha='0' baseFontSize = '9' baseFontColor = 'FFFFFF' numVDivLines = '29' vDivLineColor = 'FFFFFF' legendBgColor = '000000' toolTipBgColor = '696969' captionPadding='0' xAxisNamePadding='0' yAxisNamePadding='0' yAxisValuesPadding='0' chartLeftMargin = '0' chartRightMargin = '10' chartBottomMargin='0' labelPadding='0' labelDisplay='0' sNumberSuffix='%' syAxisMaxValue='25' syAxisMinValue='-25' formatNumber='0' formatNumberScale='0'>
   <categories>
		<%=sMakeCategory%> 
   </categories>
   <dataset seriesName="Operating Profit" color="00CDFF" anchorBorderThickness="0" anchorBgColor="00CDFF" parentYAxis="P">
		<%=sMakeDataSet1%>
   </dataset>
   <dataset seriesName="Rate" color="FE0E86" anchorBorderThickness="0" anchorBgColor="FE0E86" parentYAxis="S">
		<%=sMakeDataSet2%>
   </dataset>
</chart>