<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>My First chart using FusionCharts - Rendering HTML5 based chart</title>
<script type="text/javascript" src="../Charts/FusionCharts.js"></script>
</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">
	<div id="chartContainer">FusionCharts will load here</div>
	<script type="text/javascript"><!--
	var url = "";
	url += "?GV_UP_GROUP_ID="+parent.FV_sUpGroupId;
	url += "&DEALER_ID="+parent.FV_sDealerId;
	url += "&TOMONTH_DAY="+parent.FV_sToMonthDay;
	url += "&BEFORE_MONTH="+parent.FV_sBeMonth;

	var pChart = new FusionCharts({'swfUrl': 'MSLine.swf', 'id': 'javascript-chart', 'width': '486', 'height': '170', 'debugMode': '0', 'registerWithJS': '0', renderer: 'javascript'});
	pChart.setDataURL('chart3Xml.jsp'+url);
    
    if (typeof pChart._overrideJSChartConfiguration == 'function') {
        pChart._overrideJSChartConfiguration({
            chart: {
                defaultSeriesType: 'spline'
                ,margin:[10,10,65,30]
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
	// -->
  	</script>
</body>
</html>
