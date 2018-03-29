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

    <title>新建图层</title>
</head>
<body>
<#--引入页面头部-->
<#include "/common/header.ftl">
<#include "/common/user-info.ftl">
<#--页面内容-->
<div class="content_">
    <div class=" ui header">新建图层</div>
    <div>添加一个新图层</div>

    <div class="inline">
        <label>添加图层</label>
        <div class="ui dropdown">
            <input type="hidden" class="layer" name="layer">
            <i class="dropdown icon"></i>
            <div class="default text">请选择</div>
            <div class="menu">
                <#if layerNames??>
                    <#list layerNames as layerName>
                        <div class="item" data-value="${layerName}">${layerName}</div>
                    </#list>
                </#if>
            </div>
        </div>
    </div>

</div>

<#--引入模态框-->
<#include "/common/modal.ftl">
<#--引入页面底部-->
<#include "/common/footer.ftl">
<script language="javascript">
    $(document).ready(function () {
        $(".dropdown").dropdown();
    })
</script>
</body>
</html>