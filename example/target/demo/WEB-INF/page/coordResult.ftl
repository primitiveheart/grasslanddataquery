<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <link href="resources/css/semantic.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/main.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/user-info.css" rel="stylesheet" type="text/css"/>
        <script src="resources/js/jquery-3.2.1.js"></script>
        <script src="resources/js/semantic.min.js"></script>
    </head>
    <body>
        <#--引入页面头部-->
        <#include "/commons/header.ftl"/>
        <#--页面内容-->
        <div class="content_">
            <div>
                <div id="result">
                    <h2>查询结果如下...</h2>
                    <h3>
                        查询点位置 经度:<label class="ui label huge">${select.latitude}</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        纬度:<label class="ui label huge">${select.longitude}</label>
                    </h3>
                </div>
                <div class="ui divider"></div>
                <div>
                    <div id="minTempature">
                        <h2>月最低温度(摄氏度)</h2>
                        <table class="ui celled table">
                            <tr>
                                <td>年分</td>
                                <#list "1,2,3,4,5,6,7,8,9,10,11,12"?split(",") as m>
                                    <td>${m}月</td>
                                </#list>
                            </tr>
                            <#if resultJson.weather ?? && resultJson.weather.tempature_min ??>
                                <#list resultJson.weather.tempature_min as result>
                                    <tr>
                                        <td>${select.startYear + result_index}</td>
                                        <#list result?split(",") as t>
                                            <#if t != "">
                                                <td>${t}</td>
                                            </#if>
                                        </#list>
                                    </tr>
                                </#list>
                            </#if>
                        </table>
                    </div>

                    <div id="maxTempature">
                        <h2>月最高温度(摄氏度)</h2>
                        <table>
                        </table>
                    </div>

                    <div id="averageTempature">
                        <h2>月平均温度(摄氏度)</h2>
                        <table>
                        </table>
                    </div>

                    <div id="sumRainfall">
                        <h2>月累积降雨量</h2>
                        <table>
                        </table>
                    </div>

                    <div id="solarRadition">
                        <h2>月太阳辐射</h2>
                        <table>
                        </table>
                    </div>

                    <div id="soil">
                        <h2>土壤类型</h2>
                        <table>
                        </table>
                    </div>

                    <div id="grassLandVegetationType">
                        <h2>草地植被类型</h2>
                        <table>
                        </table>
                    </div>

                    <div id="ndvi">
                        <h2>月最大合成(NDVI)</h2>
                        <table>
                        </table>
                    </div>

                    <div id="lai">
                        <h2>叶面积指数(LAI)</h2>
                        <table>
                        </table>
                    </div>

                    <div id="altitude">
                        <h2>高程</h2>
                        <table>
                        </table>
                    </div>

                    <div id="gradient">
                        <h2>坡度</h2>
                        <table>
                        </table>
                    </div>

                    <div id="exposure">
                        <h2>坡向</h2>
                        <table>
                        </table>
                    </div>

                    <div id="vegetationPrimaryProductivity">
                        <h2>植被净生产力</h2>
                        <table>
                        </table>
                    </div>

                    <div id="storageOfSoilOrganicCarbon">
                        <h2>土壤有机碳储量</h2>
                        <table>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <#--引入页面底部-->
        <#include "/commons/footer.ftl" />
    </body>
    <script type="application/javascript" language="JavaScript">
        $(document).ready(function(){
            <#--var resultJson = ${resultJson.weather.tempature_min[0]};-->
            var startY = ${select.startYear};
            var endY = ${select.endYear};
            var longitude = ${select.longitude};
            var latitude = ${select.latitude};
            var tempature_minL = ${select.tempature_min};
            <#--var tempature_maxL = ${select.tempature_max};-->
            <#--var tempature_averageL = ${select.tempature_average};-->
            <#--var sumRainfallL = ${select.sumRainfall};-->
            <#--var solarRaditionL = ${select.solarRadition};-->
            <#--var vegetationPrimaryProductivityL = ${select.vegetationPrimaryProductivity};-->
            <#--var storageOfSoilOrganicCarbonL = ${select.storageOfSoilOrganicCarbon};-->

            var minTempatureSelector = $("#minTempature");
            var minTempatureSelectorT = $("#minTempature table");
            var maxTempatureSelector = $("#maxTempature");
            var maxTempatureSelectorT = $("#maxTempature table");
            var averageTempatureSelector = $("#averageTempature");
            var averageTempatureSelectorT = $("#averageTempature table");
            var sumRainfallSelector = $("#sumRainfall");
            var sumRainfallSelectorT = $("#sumRainfall table");
            var solarRaditionSelector = $("#solarRadition");
            var solarRaditionSelectorT = $("#solarRadition table");
            var soilSelector = $("#soil");
            var soilSelectorT = $("#soil table");
            var grassLandVegetationTypeSelector = $("#grassLandVegetationType");
            var grassLandVegetationTypeSelectorT = $("#grassLandVegetationType table");
            var ndviSelector = $("#ndvi");
            var ndviSelectorT = $("#ndvi table");
            var laiSelector = $("#lai");
            var laiSelectort = $("#lai table");
            var altitudeSelector = $("#altitude");
            var altitudeSelectorT = $("#altitude table");
            var gradientSelector = $("#gradient");
            var gradientSelectorT = $("#gradient table");
            var exposureSelector = $("#exposure");
            var exposureSelectorT = $("#exposure table");
            var vegetationPrimaryProductivitySelector = $("#vegetationPrimaryProductivity");
            var vegetationPrimaryProductivitySelectorT = $("#vegetationPrimaryProductivity table");
            var storageOfSoilOrganicCarbonSelector = $("#storageOfSoilOrganicCarbon");
            var storageOfSoilOrganicCarbonSelectorT = $("#storageOfSoilOrganicCarbon table");

            minTempatureSelector.hide();
            maxTempatureSelector.hide();
            averageTempatureSelector.hide();
            sumRainfallSelector.hide();
            solarRaditionSelector.hide();
            soilSelector.hide();
            grassLandVegetationTypeSelector.hide();
            ndviSelector.hide();
            laiSelector.hide();
            altitudeSelector.hide();
            gradientSelector.hide();
            exposureSelector.hide();
            vegetationPrimaryProductivitySelector.hide();
            storageOfSoilOrganicCarbonSelector.hide();

            //最低温度
            if(tempature_minL != undefined && tempature_minL == 1){
                minTempatureSelector.show();
            }

        })

        function addYearTable(year_selector, startY, endY, type){
            year_selector.append("<tr>");
            year_selector.append("<td>年份</td>");
            for(var i = 1; i<= 12; i++){
                year_selector.append("<td>" + i + "月</td>");
            }
            year_selector.append("</tr>");

            for( var i = startY ; i <= endY; i++){
                year_selector.append("<tr>")
                year_selector.append("<td>"+ i + "</td>");
                var middle = type[i-startY];
                var middle_band = middle.split(",");
                for(var j = 0; j < middle_band.length - 1; j++){
                    year_selector.append("<td>" + middle_band[j] +"</td>");
                }
                year_selector.append("</tr>");
            }
        }
        function formatArray(array, type) {
            var dataArray = {};
            $.each(array, function () {
                if(dataArray[this.name]){
                    if(!dataArray[this.name].push){
                        dataArray[this.name] = [dataArray[this.name]];
                    }
                    dataArray[this.name].push(this.value || '');
                }else{
                    dataArray[this.name] = this.value || '';
                }
            });
            return ((type == "json") ? JSON.stringify(dataArray) : dataArray);
        }
    </script>
</html>