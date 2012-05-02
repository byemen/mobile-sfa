<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%
	String sSvc = (String)request.getParameter("SVC");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script type="text/javascript" src="../Charts/FusionCharts.js"></script>
<script language="javascript">
	function fn_Chart(){
		var url = "";
		url += "?ACTION="+parent.FV_sSvcNm;
		url += "&TODAY_DT="+parent.FV_sToday;
		url += "&SHOP_CD="+parent.FV_sShopCd;
		url += "&SVC=<%=sSvc%>";

		var pChart = new FusionCharts({'swfUrl': 'MSColumnLine3D.swf', 'id': 'myChartId', 'width': '160', 'height': '466', 'debugMode': '0', 'registerWithJS': '1', renderer: 'JavaScript'});
		pChart.setDataURL('S210013_C01Xml.jsp'+url);
	    
	    if (typeof pChart._overrideJSChartConfiguration == 'function') {
	    	pChart._overrideJSChartConfiguration({        
	        	chart: {
		            margin:[10,10,65,30]
		        },
	        	credits: {
		            enabled: false
		        },
		        title: {
		            style: {
		                color: '#FFFFFF'
		            }
		        },
		        legend: { 
	                lineHeight: 12,
		            style: { 
			            left: 'auto', 
			            bottom: '20px', 
			            right: 'auto', 
			            top: 'auto'
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