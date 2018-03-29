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

    <title>图层</title>
</head>
<body>
<#--引入页面头部-->
<#include "/common/header.ftl">
<#include "/common/user-info.ftl">
<#--页面内容-->
<div class="content_">

    <div class="ui bottom attached segment">
        <div class="ui header">图层</div>
        <div>管理GeoServer的图层</div>
        <div class="inline">
            <i class="plus icon"></i>
            <span><a href="newLayer.html">添加新的资源</a></span>
        </div>
        <div class="inline">
            <i class="minus icon"></i>
            <span><a>删除选定的资源</a></span>
        </div>
        <div class="ui divider"></div>

        <table id="layer" width="100%" class="display cell-border" cellspacing="0">
            <thead>
            <tr class="nowrap">
                <th><input type="checkbox" class="ui checkbox all"></th>
                <th>类型</th>
                <th>标题</th>
                <th>工作区</th>
                <th>存储</th>
                <th>图层名称</th>
                <th>native SRS</th>
            </tr>
            </thead>
        </table>
    </div>

</div>
<#--引入页面底部-->
<#include "/common/footer.ftl">
<script language="javascript">
    $(document).ready(function(){
        var table = $("#layer").DataTable({
            "pageLength":5,
            "serverSide":true,
            "searching":false,
            "ajax":{
                "url":"layer.json",
                "type":"get"
            },
            "language":{
                "url":"../common/chinese.json"
            },
            "columns":[
                {
                    "data":function(obj){
                        return "<input type='checkbox' class='ui checkbox single'>";
                    }
                },
                {
                    "data":"type"
                },
                {
                    "data":"title"
                },
                {
                    "data":"workspace"
                },
                {
                    "data":"dataStore"
                },
                {
                    "data":"layer"
                },
                {
                    "data":"srs"
                }
            ]
        })
    })
</script>
</body>
</html>