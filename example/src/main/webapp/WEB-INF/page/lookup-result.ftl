<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0 maximum-scale=1.0"/>

    <link href="resources/css/plugins/jquery.dataTables.min.css" type="text/css" rel="stylesheet">
    <link href="resources/css/semantic.min.css" rel="stylesheet" type="text/css"/>
    <link href="resources/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="resources/css/user-info.css" rel="stylesheet" type="text/css"/>

    <script src="resources/js/jquery-3.2.1.js"></script>
    <script src="resources/js/plugins/jquery.dataTables.min.js"></script>
    <script src="resources/js/semantic.min.js"></script>
    <script src="resources/js/chinese.js"></script>

    <title>用户查看结果界面</title>
</head>
<body>
<#--引入页面头部-->
<#include "/commons/header.ftl">
<#include "/commons/user-info.ftl">
<#--页面内容-->
<div class="content_">
    <h4 class="ui top centered attached block header">查看申请的结果</h4>
    <div class="ui bottom attached segment">
        <table id="applyDataDisplay" width="100%" class="display cell-border" cellspacing="0">
            <thead>
                <tr class="nowrap">
                    <th>开始的年份</th>
                    <th>结束的年份</th>
                    <th>数据的类型</th>
                    <th>坐标</th>
                    <th>状态</th>
                    <th>创建的时间</th>
                    <th>更新的时间</th>
                    <th>操作</th>
                </tr>
            </thead>
        </table>
    </div>
</div>
<#--引入页面底部-->
<#include "/commons/footer.ftl">
</body>
<script src="resources/js/date.js"></script>
<script>
    $(document).ready(function(){
       var table =  $("#applyDataDisplay").DataTable({
//           "sDom": '<"top"fli>rt<"bottom"p><"clear">',
           "pageLength": 5,
            "serverSide":true,
            "ajax": "acquireApplyData.html",
//            "ajax":{
//                "url":"acquireApplyData.html",
//                "type":"post",
//                "dataSrc":function(json){
//                    console.log(json);
//                    return json
//                }
//            },
            "language":{
                "url":"chinese.json"
            },
            "columns":[
                {"data": "startYear"},
                {"data": "endYear"},
                {
                    "data": "dataType",
                    "render": function(data, type, row){
                        var json = eval('(' + data + ')');
                        var result;
                        if(json.hasOwnProperty("weather")){
                            result = "气象数据: " + weather(json.weather.join(" ")) + "<br>";
                        }
                        if(json.hasOwnProperty("vegetation")){
                            result += "植被数据: " + vegetation(json.vegetation.join(" "))+ "<br>";
                        }
                        if(json.hasOwnProperty("terrain")){
                            result += "地形数据: " + terrain(json.terrain.join(" ")) + "<br>";
                        }
                        if(json.hasOwnProperty("soil")){
                            result += "土壤数据: " +" \*土壤类型（亚类）" + "<br>";
                        }
                        if(json.hasOwnProperty("carbin")){
                            result += "固碳现状: " + carbin(json.carbin.join(" "))+ "<br>";
                        }
                        return result;
                    }
                },
                {"data": "coordinate"},
                {
                    "data": "status",
                    "render" : function (data, type, row) {
                        if(data == "审核通过"){
                            return '<p style="color: #1aa62a">审核通过</p>';
                        }else if(data == "审核中"){
                            return '<p style="color: #ef404a">审核中</p>';
                        }
                    }
                },
                {
                    "data": "createTime",
                    "render":function (data, type, row) {
                        return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
                    }
                },
                {
                    "data": "updateTime",
                    "render":function (data, type, row) {
                        return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
                    }
                },
                {"data": function(obj){
                    return '<button class="ui green button">查看</button>';

                }}
            ]
        });

    })


</script>
</html>