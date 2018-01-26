<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0 maximum-scale=1.0"/>

    <link href="../resources/css/plugins/jquery.dataTables.min.css" type="text/css" rel="stylesheet">
    <link href="../resources/css/semantic.min.css" rel="stylesheet" type="text/css"/>
    <link href="../resources/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="../resources/css/user-info.css" rel="stylesheet" type="text/css"/>

    <script src="../resources/js/jquery-3.2.1.js"></script>
    <script src="../resources/js/plugins/jquery.dataTables.min.js"></script>
    <script src="../resources/js/semantic.min.js"></script>
    <script src="../resources/js/chinese.js"></script>

    <title>管理员登陆界面</title>
</head>
<body>
<#--引入页面头部-->
<#include "/commons/header.ftl">
<#include "/commons/user-info.ftl">
<#--页面内容-->
<div class="content_">


        <h4 class="ui top centered attached block header">管理员给用户授权</h4>
        <div class="ui bottom attached segment">
            <table id="applyDataDisplay" width="100%" class="display cell-border" cellspacing="0">
                <thead>
                <tr class="nowrap">
                    <th>用户名</th>
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
                "url":"../chinese.json"
            },
            "columns":[
                {"data": "username"},
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
                    return '<div><button class="ui primary button checkPass" data-id="' + obj.id  + '" data-status="'+ obj.status +'">审核通过</button> ' +
                            '<button class="ui green button">查看</button>' +
                            '<button class="ui red button withdraw" data-id="' + obj.id  + '" data-status="'+ obj.status +'">撤回</button></div>';
                }}
            ]
        });

        //审核通过的按钮
        $("#applyDataDisplay tbody").on("click", ".checkPass", function(){
            var id = $(this).attr("data-id");
            var status = $(this).attr("data-status");
            if(status == "审核通过"){
                $(this).attr("disabled",true);
            }else{
//                var start = table.page.info().start;
//                var length = table.page.info().length;
                $.ajax({
                    url:"updateApplyData.html",
                    data:{
                        id:id
                    },
                    type:"post",
                    success: function (result) {
                        //刷新本页面
                       table.draw(false);
                    }
                })
            }
        })

        //撤回的按钮
        $("#applyDataDisplay tbody").on("click", ".withdraw", function () {
            var id = $(this).attr("data-id");
            var status = $(this).attr("data-status");
            if(status == "审核中"){
                $(this).attr("disabled",true);
            }else{
                $.ajax({
                    url:"updateApplyData.html",
                    data:{
                        id:id
                    },
                    type:"post",
                    success: function (result) {
                        //刷新本页面
                        table.draw(false);
                    }
                })
            }
        })
    })

    Date.prototype.Format = function(fmt) {
        var o = {
            "M+": this.getMonth() + 1,
            //月份
            "d+": this.getDate(),
            //日
            "h+": this.getHours(),
            //小时
            "m+": this.getMinutes(),
            //分
            "s+": this.getSeconds(),
            //秒
            "q+": Math.floor((this.getMonth() + 3) / 3),
            //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        }
        for (var k in o) {
            if (new RegExp("(" + k + ")").test(fmt)) {
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            }
        }
        return fmt;
    }
</script>
</html>