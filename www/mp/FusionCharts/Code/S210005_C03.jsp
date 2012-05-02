<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script type="text/javascript" src="../Charts/FusionCharts.js"></script>
<script language="javascript">
	function fn_Chart(){
		var url = "";
		if(parent.FV_sDealerId == "TM00000"){
			url += "?ACTION="+parent.FV_sSvcNm;
			url += "&BRAND_CD="+parent.FV_sBrandCd;
		}else{
			url += "?ACTION="+parent.FV_sSvcNm;
			url += "&DEALER_ID="+parent.FV_sDealerId;
			url += "&BRAND_CD="+parent.FV_sBrandCd;
		}

		var pChart = new FusionCharts({'swfUrl': 'MSColumn3DLineDY.swf', 'id': 'myChartId', 'width': '484', 'height': '260', 'debugMode': '0', 'registerWithJS': '1', renderer: 'JavaScript'});
		pChart.setDataURL('S210005_C03Xml.jsp'+url);
		
	    if (typeof pChart._overrideJSChartConfiguration == 'function') {
	        pChart._overrideJSChartConfiguration({        
	        	chart: {
		            margin:[10,35,65,30]
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