<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <link href="../resources/css/semantic.min.css" rel="stylesheet" type="text/css"/>
        <link href="../resources/css/main.css" rel="stylesheet" type="text/css"/>
        <link href="../resources/css/user-info.css" rel="stylesheet" type="text/css"/>
        <script src="../resources/js/jquery-3.2.1.js"></script>
        <script src="../resources/js/semantic.min.js"></script>
    </head>
    <body>
        <#--引入页面头部-->
        <#include "/common/header.ftl"/>
        <#--页面内容-->
        <div class="content_">
            <div>
                <div class="ui back button">
                    返回
                </div>
                <div id="result">
                    <h2>查询结果如下...</h2>
                    <h3>
                        查询点位置 经度:<label class="ui label huge">${latitude}</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        纬度:<label class="ui label huge">${longitude}</label>
                    </h3>
                </div>
                <div class="ui divider"></div>
                <div>
                    <#if bigSmallDataTypeVoMap?? && bigSmallDataTypeVoMap?size gt 0>
                        <#list bigSmallDataTypeVoMap?keys as key >
                            <h3>${key}<h3>
                            <#list bigSmallDataTypeVoMap[key] as bigSmallDataTypeVo>
                                <h4>${bigSmallDataTypeVo.sDataType}</h4>
                                <#if bigSmallDataTypeVo.sDataType?contains("*")>

                                </#if>
                                <#if !bigSmallDataTypeVo.sDataType?contains("*")>
                                    <table class="ui celled table" data-bigDataType="${bigSmallDataTypeVo.bDataTypeEnglish}"
                                           data-smallDataType="${bigSmallDataTypeVo.sDataTypeEnglish}">
                                        <thead>
                                            <tr>
                                                <th>年分</th>
                                                <#list "1,2,3,4,5,6,7,8,9,10,11,12"?split(",") as m>
                                                    <th>${m}月</th>
                                                </#list>
                                            </tr>
                                        </thead>
                                    </table>
                                </#if>
                            </#list>
                        </#list>
                    </#if>

                </div>
            </div>
        </div>
        <#--引入页面底部-->
        <#include "/common/footer.ftl" />
    </body>
    <script language="JavaScript">
        $(document).ready(function () {
            var temp = "${request.requestURI}";
            console.log(temp);
            //返回
            $(".ui.back.button").on("click", function(){


                $(location).attr("href",);
            })

            var tables = $("table");
            var latitude = ${latitude};
            var longitude = ${longitude};
            var startYear = ${startYear};
            var endYear = ${endYear};

            for(var k = 0; k < tables.length; k++){
                var bigDataTypeEnglish = $(tables[k]).attr("data-bigDataType");
                var smallDataTypeEnglish = $(tables[k]).attr("data-smallDataType");
                $.ajax({
                    url:"acquireSmallDataTypeResult.html",
                    async:false,
                    data:{
                        latitude:latitude,
                        longitude: longitude,
                        startYear: startYear,
                        endYear: endYear,
                        bigDataTypeEnglish:bigDataTypeEnglish,
                        smallDataTypeEnglish:smallDataTypeEnglish
                    },
                    success:function (result) {
                        for(var i=0; i < result.data.length; i++){
                            var middle = result.data[i].split(",");
                            var tr = "<tr>";
                            var td = "<td>"+(startYear + i)+"</td>";
                            for(var j=0; j < middle.length-1; j++){
                                 td += "<td>"+middle[j]+"</td>";
                            }
                            tr = tr + td + "</tr>";
                            $(tr).appendTo($(tables[k]));
                        }
                    }
                })
            }
        })
    </script>
</html>