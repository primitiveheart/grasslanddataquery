<!DOCTYPE html><html>
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
    <script src="../resources/js/date.js"></script>

    <title>添加服务数据</title>
</head>
<body>
<#--引入页面头部-->
<#include "/common/header.ftl">
<#include "/common/user-info.ftl">
<#--页面内容-->
<div class="content_">

    <div class="ui header">添加服务</div>
    <div class="ui divider"></div>

    <div class="ui form">
        <div class="field inline">
            <label>大数据类型</label>
            <div class="ui addServiceBigDataType selection dropdown">
                <input type="hidden" name="bigDataType">
                <i class="dropdown icon"></i>
                <div class="default text">大数据类型</div>
                <div class="menu">
                <#if bigDataTypes?? && bigDataTypes?size gt 0>
                    <#list bigDataTypes as bdt>
                        <div class="item" data-value="${bdt.dataType}">${bdt.dataType}</div>
                    </#list>
                </#if>
                </div>
            </div>
        </div>

        <div class="field inline">
            <label>小数据类型</label>
            <div class="ui addServiceSmallDataType selection dropdown">
                <input type="hidden" name="smallDataType">
                <i class="dropdown icon"></i>
                <div class="default text">小数据类型</div>
                <div class="menu"></div>
            </div>
        </div>

        <div class="field inline">
            <label>年份</label>
            <input type="text" name="year" class="year">
        </div>

        <div class="field inline">
            <label>工作区</label>
            <div class="ui workspaceSelect search selection dropdown">
                <input type="hidden" name="workspace">
                <i class="dropdown icon"></i>
                <div class="default text">工作区</div>
                <div class="menu"></div>
            </div>
        </div>

        <div class="field inline">
            <label>图层</label>
            <div class="ui search layerSelect selection dropdown">
                <input type="hidden" name="layer">
                <i class="dropdown icon"></i>
                <div class="default text">图层</div>
                <div class="menu"></div>
            </div>
        </div>


        <div class="ui green submit button addService">
            <i class="plus icon"></i>
            <label>添加服务</label>
        </div>

    </div>

</div>
<#--引入页面底部-->
<#include "/common/footer.ftl">
</body>
<script language="javascript">
    $(document).ready(function () {
        //工作区
        $(".workspaceSelect").dropdown();

        //图层的列表
        $(".layerSelect").dropdown();

        //工作区
        $.ajax({
            url:"http://localhost:8080/rest/workspaces.json",
            dataType:"json",
            success:function(data){
                for(var i=0; i < data.workspaces.workspace.length; i++){
                    $div = $("<div class='item' data-value='"+data.workspaces.workspace[i].name+"'>"+data.workspaces.workspace[i].name+"</div>");
                    $div.appendTo($(".workspaceSelect .menu"));
                }
            },
            headers:{
                authorization: "Basic YWRtaW46Z2Vvc2VydmVy"
            }
        })

        //工作区改变时
        $(".workspaceSelect").dropdown({
            onChange: function(value, text, $choice){
                //清除图层中已有的数据
                $(".ui.layerSelect").dropdown("clear");
                $.ajax({
                    url:"http://localhost:8080/rest/workspaces/" + value + "/layers",
                    dataType:"json",
                    success:function(data){
                        //图层
                        if(data.layers != ""){
                            for(var i=0; i < data.layers.layer.length; i++){
                                $div = $("<div class='item' data-value='"+data.layers.layer[i].name+"'>"+data.layers.layer[i].name+"</div>");
                                $div.appendTo($(".layerSelect .menu"));
                            }
                        }
                    },
                    headers:{
                        authorization: "Basic YWRtaW46Z2Vvc2VydmVy"
                    }
                });
            }
        })


        //添加服务中的大数据类型
        $(".ui.addServiceBigDataType.dropdown").dropdown({
            onChange: function(value, text, $selectedItem){
                // 先清除
                $(".ui.addServiceSmallDataType.dropdown").dropdown('clear');
                //小数据类型
                $.ajax({
                    url:"acquireAllSmallDataType.html",
                    data:{
                        name:value
                    },
                    success: function (result) {
                        //清除元素
                        $(".ui.addServiceSmallDataType .menu").children().remove().end();
                        //遍历从后台返回的列表
                        $.each(result.smallDataTypes, function (index, value) {
                            var $div = $("<div class='item' data-value='"+value.dataType + "'>"+value.dataType+"</div>")
                            $div.appendTo($(".ui.addServiceSmallDataType .menu"));
                        })
                    }
                })
            }
        })

        //小数据类型
        $(".ui.addServiceSmallDataType").dropdown();

        //提交服务数据
        $(".addService").on("click", function () {
            var data = $(".ui.form input").serialize();
            var today = new Date().Format("yyyy-MM-dd hh:mm:ss");
            var createTime = today.toString();
            var updateTime = today.toString();
            data += "&createTime=" + createTime + "&updateTime=" + updateTime;
            $.ajax({
                url:"saveServiceData.html",
                type:"post",
                dataType:"json",
                data:data,
                success: function (result) {
                    //TODO
                    //数据添加完之后刷新一下
                    $(location).attr("href","addServiceData.html");
                }
            })
        })


    })
</script>
</html>