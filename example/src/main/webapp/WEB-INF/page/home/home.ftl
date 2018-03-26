<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
    <head>
        <title>查询</title>
        <link href="../resources/css/semantic.min.css" rel="stylesheet" type="text/css"/>
        <link href="../resources/css/main.css" rel="stylesheet" type="text/css"/>
        <link href="../resources/css/user-info.css" rel="stylesheet" type="text/css"/>
        <link href="../resources/css/plugins/calendar.min.css" rel="stylesheet">
        <link href="../resources/css/plugins/ol.css" rel="stylesheet" type="text/css">
        <script src="../resources/js/jquery-3.2.1.js"></script>
        <script src="../resources/js/semantic.min.js"></script>
        <script src="../resources/js/plugins/calendar.min.js"></script>

        <script src="../resources/js/plugins/ol.js"></script>
        <script src="../resources/js/getBaiduMap.js"></script>
    </head>
    <body>
        <#--引入页面头部-->
        <#include "/common/header.ftl">
        <#--引入页面的用户登录信息-->
        <#include "/common/user-info.ftl">
        <#--页面内容-->
        <div class="content_">
            <div class="ui grid">
                <div id="titleDisplay" class="row centered">
                   <h3>本数据集是依据地面样本(采样)点数据、空间分析模型及估算模型获得，具体生成过程及精度分析结果[待补充]</h3><br/>
                </div>
            </div>

            <div class="ui secondary pointing menu">
                <a class="active item" data-tab="map">
                    <i class="map outline icon"></i>地图</a>
                <a class="item" data-tab="coordinate">
                    <i class="map icon"></i>坐标</a>
            </div>


            <div class="ui active tab segment" data-tab="map">
                <form action="saveApplyData.html" method="post" id="map_form">
                    <div class="ui big header">请您选择位置</div>
                    <div class="ui input inline field">
                        <label>纬度</label>
                        <input type="text" name="latitude" placeholder="请您输入纬度" readonly="readonly"/>
                        <input type="hidden" name="pixelY">
                    </div>

                    <div class="ui input inline field">
                        <label>经度</label>
                        <input type="text" name="longitude" placeholder="请您输入经度" readonly="readonly">
                        <input type="hidden" name="pixelX">
                    </div>
                    <div id="baidu_map" style="width: 768px;height: 444px;">

                    </div>



                    <div class="ui big header">数据选择(请选择需要查询的数据)</div>

                    <#if bigSmallDataTypeVos?? && bigSmallDataTypeVos?size gt 0>
                        <#list bigSmallDataTypeVos?keys as key>
                            <div class="ui small header">${key}</div>
                            <div class="field">

                                <select multiple=""name="${bigSmallDataTypeVos[key][0].bDataTypeEnglish}" class="ui search fluid normal dropdown">
                                    <#list bigSmallDataTypeVos[key] as bigSmallDataTypeVo>
                                        <option  value="${bigSmallDataTypeVo.sDataTypeEnglish}">${bigSmallDataTypeVo.sDataType}</option>
                                    </#list>
                                </select>
                            </div>
                        </#list>
                    </#if>

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
            <#--<#if bigSmallDataTypeVos?? && bigSmallDataTypeVos?size gt 0>-->
            <#--<#list bigSmallDataTypeVos?keys as key>-->
            <#--<div class="ui small header">${key}</div>-->
            <#--<ul>-->
            <#--<#list bigSmallDataTypeVos[key] as bigSmallDataTypeVo>-->
            <#--<li><a href="mapMethod.html?type=${bigSmallDataTypeVo.sDataTypeEnglish}">${bigSmallDataTypeVo.sDataType}</a></li>-->
            <#--</#list>-->
            <#--</ul>-->
            <#--</#list>-->
            <#--</#if>-->
            </div>

            <div class="ui tab segment" data-tab="coordinate">
                <form action="saveApplyData.html" method="post" id="form">
                    <div class="ui big header">所在位置(请输入经纬度坐标，如41.25,103.45)</div>
                    <div class="ui input inline field">
                        <label>纬度</label>
                        <input type="text" name="latitude" placeholder="请您输入纬度"/>
                        <input type="hidden" name="pixelY">
                    </div>

                    <div class="ui input inline field">
                        <label>经度</label>
                        <input type="text" name="longitude" placeholder="请您输入经度">
                        <input type="hidden" name="pixelX">
                    </div>

                    <div>
                        所在行政区域:<label id="area"></label>
                    </div>


                    <div class="ui big header">数据选择(请选择需要查询的数据)</div>

                    <#if bigSmallDataTypeVos?? && bigSmallDataTypeVos?size gt 0>
                        <#list bigSmallDataTypeVos?keys as key>
                            <div class="ui small header">${key}</div>
                            <div class="field">

                                <select multiple=""name="${bigSmallDataTypeVos[key][0].bDataTypeEnglish}" class="ui search fluid normal dropdown">
                                     <#list bigSmallDataTypeVos[key] as bigSmallDataTypeVo>
                                         <option  value="${bigSmallDataTypeVo.sDataTypeEnglish}">${bigSmallDataTypeVo.sDataType}</option>
                                     </#list>
                                </select>
                            </div>
                        </#list>
                    </#if>

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

        </div>
        <#--引入页面底部-->
        <#include "/common/footer.ftl"/>
    </body>
    <script type="application/javascript" language="JavaScript">

        $(document).ready(function(){

            //得到百度地图
            var map = getBaiduMap();

            map.addEventListener("click", function (evt) {
                var coord = evt.coordinate;
                var pixel = evt.pixel;
                var coordTransform = ol.proj.transform(coord, "EPSG:3857", "EPSG:4326");
                $("#map_form input[name=latitude]").val(new Number(coordTransform[1]).toFixed(2));
                $("#map_form input[name=longitude]").val(new Number(coordTransform[0]).toFixed(2));
                $("#map_form input[name=pixelY]").val(Math.floor(pixel[1]));
                $("#map_form input[name=pixelX]").val(Math.floor(pixel[0]));
            })

            //转换坐标

            $("#form input[name*=itude]").on("mouseleave", function () {
                var latitude =  $("#form input[name=latitude]").val();
                var longitude = $("#form input[name=longitude]").val();
                if(latitude != "" && longitude != ""){
                    var coord = ol.proj.transform([parseFloat(longitude), parseFloat(latitude)], "EPSG:4326", "EPSG:3857")
                    var pixel = map.getPixelFromCoordinate(coord);
                    $("#form input[name=pixelX]").val(Math.floor(pixel[0]));
                    $("#form input[name=pixelY]").val(Math.floor(pixel[1]));
                }
            })

            $(".menu .item").on("click", function () {
                $(".menu .item").removeClass("active");
                $(this).addClass("active");
            });
            $(".menu .item").tab();

            $(".ui.search.fluid.normal.dropdown").dropdown({
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

    </script>
</html>