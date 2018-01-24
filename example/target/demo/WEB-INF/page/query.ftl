<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
    <head>
        <title>查询</title>
        <link href="resources/My97DatePicker/skin/WdatePicker.css"/>
        <link href="resources/css/semantic.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/main.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/user-info.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/plugins/calendar.min.css" rel="stylesheet">
        <script src="resources/js/jquery-3.2.1.js"></script>
        <script src="resources/js/semantic.min.js"></script>
        <script src="resources/js/plugins/calendar.min.js"></script>
    </head>
    <body>
        <#--引入页面头部-->
        <#include "/commons/header.ftl">
        <#--引入页面的用户登录信息-->
        <#include "/commons/user-info.ftl">
        <#--页面内容-->
        <div class="content_">
            <div class="ui grid">
                <div id="titleDisplay" class="row centered">
                   <h3>本数据集是依据地面样本(采样)点数据、空间分析模型及估算模型获得，具体生成过程及精度分析结果[待补充]</h3><br/>
                </div>
            </div>
            <div class="ui secondary pointing menu">
                <a class="active item" data-tab="coordinate">
                    <i class="map outline icon"></i>坐标</a>
                <a class="item" data-tab="map">
                    <i class="map icon"></i>地图</a>
            </div>
            <div class="ui tab active segment" data-tab="coordinate">
                <form action="saveApplyData.html" method="post" id="form">

                    <div class="ui big header">所在位置(请输入经纬度坐标，如41.25,103.45)</div>
                    <div class="inline field">
                        <label>纬度</label>
                        <input type="text" name="latitude" placeholder="请您输入纬度"/>
                    </div>

                    <div class="inline field">
                        <label>经度</label>
                        <input type="text" name="longitude" placeholder="请您输入经度">
                    </div>

                    <div>
                        所在行政区域:<label id="area"></label>
                    </div>


                    <div class="ui big header">数据选择(请选择需要查询的数据)</div>

                    <div class="ui small header">气象数据</div>
                    <div class="field">
                        <select multiple="" name="weather" class="ui weather search fluid normal dropdown">
                            <option  value="tempature_min">最低温度(月)</option>
                            <option  value="tempature_max">最高温度(月)</option>
                            <option  value="tempature_average">平均温度(月</option>
                            <option  value="sumRainfall">累积降雨量(月)</option>
                            <option  value="solarRadition">太阳辐射(月)</option>
                        </select>
                    </div>

                    <div class="ui small header">土壤数据</div>
                    <div class="field">
                        <div class="ui checkbox"><input type="checkbox"  name="soil" value="solarType_*"/>*土壤类型（亚类）</div>
                    </div>

                    <div class="ui small header">植被数据</div>
                    <div class="field">
                        <select multiple="" name="vegetation" class="ui vegetation search fluid normal dropdown">
                            <option value="grassLandVegetationType_*">*草地植被类型(亚类-型)</option>
                            <option value="NDVI">NDVI(月最大合成)</option>
                            <option value="LAI">叶面积指数(LAI)</option>
                        </select>
                    </div>

                    <div class="ui small header">地形数据</div>
                   <div class="field">
                       <select multiple="" name="terrain" class="ui terrain search fluid normal dropdown">
                           <option value="altitude_*">*高程</option>
                           <option value="gradient_*">*坡度(度)</option>
                           <option value="exposure_*">*坡向</option>
                       </select>
                   </div>

                    <div class="ui small header">固碳现状</div>
                    <div class="field">
                        <select multiple="" name="carbon" class="ui carbon search fluid normal dropdown">
                            <option value="vegetationPrimaryProductivity">植被净生产力</option>
                            <option value="storageOfSoilOrganicCarbon">土壤有机碳储量</option>
                        </select>
                    </div>


                    <div class="ui big header">查询年份(带*的数据为静态数据，不受年份控制)</div>
                    <div class="inline field">
                        <label>开始日期</label>
                        <div class="ui calendar" id="startDate" >
                            <div class="ui input left icon">
                                <i class="calendar icon"></i>
                                <input type="text" placeholder="请您选择时间的起始" name="startYear">
                            </div>
                        </div>
                    </div>
                    <div class="inline field">
                        <label>结束日期</label>
                        <div class="ui calendar" id="endDate" >
                            <div class="ui input left icon">
                                <i class="calendar icon"></i>
                                <input type="text" placeholder="请您选择时间的结束" name="endYear"/>
                            </div>
                        </div>
                    </div>


                    <button class="ui button" type="submit">提交</button>
                </form>
            </div>
            <div class="ui tab segment" data-tab="map">
                <h3>气象数据</h3>
                <ul>
                    <li><a href="dataYear.html?type=tempature_min">最低温度(月)</a></li>
                    <li><a href="dataYear.html?type=tempature_max">最高温度(月)</a></li>
                    <li><a href="dataYear.html?type=tempature_average">平均温度(月)</a></li>
                    <li><a href="dataYear.html?type=sumRainfall">累积降雨量(月)</a></li>
                    <li><a href="dataYear.html?type=solarRadition">太阳辐射(月)</a></li>
                </ul>
                <h3>土壤数据</h3>
                <ul>
                    <li><a>土壤类型(亚类)</a></li>
                </ul>
                <h3>植被数据</h3>
                <ul>
                    <li><a>草地植被类型(亚类-型)</a></li>
                    <li><a>NDVI(月最大合成)</a></li>
                    <li><a>叶面积指数(LAI)</a></li>
                </ul>
                <h3>地形数据</h3>
                <ul>
                    <li><a>高程</a></li>
                    <li><a>坡度(度)</a></li>
                    <li><a>坡向</a></li>
                </ul>
                <h3>固碳现状</h3>
                <ul>
                    <li><a>植被净生产力</a></li>
                    <li><a>土壤有机碳储量</a></li>
                </ul>
            </div>
        </div>
        <#--引入页面底部-->
        <#include "/commons/footer.ftl"/>
    </body>
    <script type="application/javascript" language="JavaScript">
        $(document).ready(function(){
            $(".menu .item").on("click", function () {
                $(".menu .item").removeClass("active");
                $(this).addClass("active");
            });
            $(".menu .item").tab();

            $(".ui.weather.search.fluid.normal.dropdown").dropdown({
                maxSelections:0
            });
            $(".ui.vegetation.search.fluid.normal.dropdown").dropdown({
                maxSelections:0
            });
            $(".ui.terrain.search.fluid.normal.dropdown").dropdown({
                maxSelections:0
            });
            $(".ui.carbon.search.fluid.normal.dropdown").dropdown({
                maxSelections:0
            });



            //开始日期
            $("#startDate").calendar({
                type:"year",
                endCalendar:$("#endDate"),
                minDate: new Date(1981,1,1),
                maxDate: new Date(2013, 1, 1)
            })
            var today = new Date();
            //结束日期
            $("#endDate").calendar({
                type: "year",
                startCalendar:$("#startDate"),
                maxDate: new Date(2013, 1, 1)
            })

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