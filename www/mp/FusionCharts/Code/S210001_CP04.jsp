<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script type="text/javascript" src="../Charts/FusionCharts.js"></script>
<script language="javascript">
	function fn_Chart(){
		var url = "";
		url += "?ACTION="+parent.FV_sSvcNm;
		url += "&GV_UP_GROUP_ID="+parent.FV_sUpGroupId;
		url += "&DEALER_ID="+parent.FV_sDealerId;
		url += "&YEAR="+parent.FV_sYear;
		url += "&BEFORE_YEAR="+parent.FV_sBeYear;
		var pChart = new FusionCharts({'swfUrl': 'MSCombi2D.swf', 'id': 'myChartId', 'width': '802', 'height': '408', 'debugMode': '0', 'registerWithJS': '1', renderer: 'JavaScript'});
		pChart.setDataURL('S210001_CP04Xml.jsp'+url);

	    if (typeof pChart._overrideJSChartConfiguration == 'function') {
	        pChart._overrideJSChartConfiguration({        
	        	chart: {
		            margin:[10,10,26,30]
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
