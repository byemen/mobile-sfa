<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%
	String sAction = (String)request.getParameter("ACTION");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script type="text/javascript" src="../Charts/FusionCharts.js"></script>
<script language="javascript">
	function fn_Chart(){
		var width = parent.FV_nWidth;
		var height = parent.FV_nHeight;
		var url = "";
		if("<%=sAction%>"==""){
			url += "?ACTION="+parent.FV_sSvcNm;
		}else{
			url += "?ACTION=<%=sAction%>";
		}
		url += "&GV_UP_GROUP_ID="+parent.FV_sUpGroupId;
		url += "&YYYY="+parent.FV_sYyyy;
		url += "&DEALER_ID="+parent.FV_sDealerId4;

		var pChart = new FusionCharts({'swfUrl': 'MSColumn3DLineDY.swf', 'id': 'myChartId', 'width': width, 'height': height, 'debugMode': '0', 'registerWithJS': '1', renderer: 'JavaScript'});
		pChart.setDataURL('S210007_C01Xml.jsp'+url);
	    
	    if (typeof pChart._overrideJSChartConfiguration == 'function') {
	        pChart._overrideJSChartConfiguration({        
	        	chart: {
		            margin:[10,35,26,30]
		        },
	        	credits: {
		            enabled: false
		        },
		        title: {
		            style: {
		                color: '#FFFFFF'
		            }
		        }
	        });
	    }
	    pChart.setTransparent('true');
	    pChart.render('chartContainer');   
	}
</script>
</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" onload="fn_Chart();">
	<div id="chartContainer">FusionCharts will load here</div>
</body>
</html>