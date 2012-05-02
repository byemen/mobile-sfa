<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script type="text/javascript" src="../Charts/FusionCharts.js"></script><script language="javascript">
	function fn_Chart(){
		var url = "";
		url += "?GV_UP_GROUP_ID="+parent.FV_sUpGroupId;
		url += "&YYYYMM="+parent.FV_sYyyyMm;

		var pChart = new FusionCharts({'swfUrl': 'MSColumn3DLineDY.swf', 'id': 'myChartId', 'width': '486', 'height': '556', 'debugMode': '0', 'registerWithJS': '1', renderer: 'JavaScript'});
		pChart.setDataURL('S210006_C01Xml.jsp'+url);
		
	    if (typeof pChart._overrideJSChartConfiguration == 'function') {
	        pChart._overrideJSChartConfiguration({        
	        	chart: {
		            margin:[10,50,65,60]
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
			            bottom: '5px', 
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