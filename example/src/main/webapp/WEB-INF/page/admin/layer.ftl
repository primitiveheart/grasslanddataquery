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
        <table id="workspace" width="100%" class="display cell-border" cellspacing="0">
            <thead>
            <tr class="nowrap">
                <th><input type="radio"></th>
                <th>工作区</th>
                <th>存储</th>
                <th>图层名称</th>
            </tr>
            </thead>
        </table>
    </div>

</div>
<#--引入页面底部-->
<#include "/common/footer.ftl">
</body>
</html>