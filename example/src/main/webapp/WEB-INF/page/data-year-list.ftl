<!DOCTYPE html>
<html>
    <head>
        <title>最低温度列表</title>
        <link href="resources/css/semantic.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/main.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/user-info.css" rel="stylesheet" type="text/css"/>
        <script src="resources/js/jquery-3.2.1.js"></script>
        <script src="resources/js/semantic.min.js"></script>
        <script src="resources/js/openlayer/lib/OpenLayers.js"></script>
    </head>
    <body>
        <#--引入头部页面-->
        <#include "/commons/header.ftl">
        <#include "/commons/user-info.ftl"/>
        <#--页面内容-->
         <div class="content_">
             <div class="ui grid">
                <div class="row centered">
                    <h2 class="title_year">${name}</h2>
                </div>
             </div>
             <div class="ui divider"></div>
             <table class="ui celled table">
                <thead>
                    <tr>
                        <th class="center aligned">年份</th>
                        <th class="center aligned">url地址</th>
                    </tr>
                </thead>
                <tbody>
                    <#if allYear??>
                        <#list allYear as year>
                        <tr>
                            <td class="center aligned">${year}</td>
                            <td class="center aligned"><a href="#" class="look" data-layer="${tempature_min}_${year}" data-year="${year}">查看</a></td>
                        </tr>
                        </#list>
                    </#if>
                </tbody>
             </table>

             <#--地图显示结果-->
             <div id='map_element' style='width:100%;height:100%;'></div>
         </div>
        <#--引入底部页面-->
        <#include "/commons/footer.ftl" />
    </body>
    <script type="application/javascript" language="JavaScript">
        $(document).ready(function () {
            $(".look").on("click", function () {
                $(".table").hide();
                var middleLayer = $(this).attr("data-layer");
                var year = $(this).attr("data-year");
                $(".title_year").append("-"+year);
                init(middleLayer);
            })
        })
        var map;
        function init(middleLayer) {
            //定义地图边界
            var bounds = new OpenLayers.Bounds("73.47709197998049,18.133351135253918,134.8770919799805,53.63335113525392");
            var options = {
                projection:"EPSG:4326",
                format:"application/openlayers"
//                center:new OpenLayers.LonLat(116.5, 39.5)
            };
            map = new OpenLayers.Map("map_element", options);
            var wms = new OpenLayers.Layer.WMS("OpenLayers WMS", "http://localhost:8080/geoserver/grassLandCoverage/wms",
                    {
                        layers:"grassLandCoverage:" + middleLayer
                    });
            //添加wms图层
            map.addLayer(wms);
            //添加control空间
            map.addControl(new OpenLayers.Control.LayerSwitcher());
            map.addControl(new OpenLayers.Control.MousePosition());
            map.addControl(new OpenLayers.Control.ScaleLine());
            map.addControl(new OpenLayers.Control.Scale);

            map.zoomToMaxExtent(bounds);
        }
    </script>
</html>