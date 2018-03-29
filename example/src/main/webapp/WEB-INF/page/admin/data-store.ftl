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

    <title>数据存储</title>
</head>
<body>
<#--引入页面头部-->
<#include "/common/header.ftl">
<#include "/common/user-info.ftl">
<#--页面内容-->
<div class="content_">
    <div class="ui bottom attached segment">
        <div class="ui header">数据存储</div>
        <div>管理GeoServer的数据存储</div>
        <div class="inline">
            <i class="plus icon"></i>
            <span><a href="newWorkspace.html">添加新的数据存储</a></span>
        </div>
        <div class="inline">
            <i class="minus icon"></i>
            <span><a>删除选定的数据存储</a></span>
        </div>
        <div class="ui divider"></div>
        <table id="datastore" width="100%" class="display cell-border" cellspacing="0">
            <thead>
            <tr class="nowrap">
                <th><input type="checkbox" class="ui checkbox all"></th>
                <#--<th>数据类型</th>-->
                <th>工作区</th>
                <th>数据存储名称</th>
                <#--<th>类型</th>-->
            </tr>
            </thead>
        </table>
    </div>

</div>
<#--引入页面底部-->
<#include "/common/footer.ftl">

<script language="javascript">
    $(document).ready(function(){
        var table = $("#datastore").DataTable({
            "pageLength":5,
            "serverSide":true,
            "searching":false,
            "ajax":"dataStore.json",
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
                    "data":"workspace"
                },
                {
                    "data":"dataStore"
                }
            ]
        })

    })
</script>
</body>
</html>