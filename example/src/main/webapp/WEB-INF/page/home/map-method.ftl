<!DOCTYPE html>
<html>
    <head>
        <title>最低温度列表</title>
        <link href="../resources/css/semantic.min.css" rel="stylesheet" type="text/css"/>
        <link href="../resources/css/main.css" rel="stylesheet" type="text/css"/>
        <link href="../resources/css/user-info.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="../resources/css/plugins/ol.css"/>
        <script src="../resources/js/jquery-3.2.1.js"></script>
        <script src="../resources/js/semantic.min.js"></script>
        <script src="../resources/js/plugins/ol.js"></script>

    </head>
    <body>
        <#--引入头部页面-->
        <#include "/common/header.ftl">
        <#include "/common/user-info.ftl"/>
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
                                <td class="center aligned"><a href="#" class="look" data-layer="${type}_${year}" data-year="${year}">查看</a></td>
                            </tr>
                        </#list>
                    </#if>
                </tbody>
             </table>

             <#--地图显示结果-->
             <div id='map_element' style='width:100%;height:100%;'></div>
         </div>
        <#--引入底部页面-->
        <#include "/common/footer.ftl" />
    </body>
    <script type="application/javascript" language="JavaScript">
        var map;
        function init(middleLayer) {
            //投影坐标系
            var projection = ol.proj.get("EPSG:4326");

            //图层
            var layer =  new ol.layer.Tile({
                source: new ol.source.TileWMS({
                    url: "http://localhost:8080/grassLandCoverage/wms",
                    params: {
                        'LAYERS': 'grassLandCoverage:' + middleLayer,
                        'TILED': true,
//                        'format':"application/openlayers",
                        'projection':projection,
                        'displayProjection':projection
                    },
                    serverType: 'geoserver'
                })
            });

            var osm =  new ol.layer.Tile({
                source: new ol.source.OSM()
            })


            map = new ol.Map({
                layers: [osm,layer],
                target: 'map_element',
                view: new ol.View({
//                    center: ol.extent.getCenter(layer.getExtent()),
                    center:[110,30],
                    projection:projection,
                    zoom:6,
                    minZoom:4
                })
            });
        }

        $(document).ready(function () {
            $(".look").on("click", function () {
                $(".table").hide();
                var middleLayer = $(this).attr("data-layer");
                var year = $(this).attr("data-year");
                $(".title_year").append("-"+year);
                init(middleLayer);
            })
        })


    </script>
</html>