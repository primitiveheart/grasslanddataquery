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

    <title>服务数据列表</title>
</head>
<body>
<#--引入页面头部-->
<#include "/common/header.ftl">
<#include "/common/user-info.ftl">
<#--页面内容-->
<div class="content_">

    <div class="ui header">服务列表</div>
    <div class="ui divider"></div>
    <table id="listService" width="100%" class="display cell-border" cellspacing="0">
        <thead>
        <tr class="nowrap">
            <th>大数据类型</th>
            <th>小数据类</th>
            <th>年份</th>
            <th>工作区</th>
            <th>图层</th>
            <th>创建的时间</th>
            <th>更新的时间</th>
            <th>操作</th>
        </tr>
        </thead>
    </table>


    <div class="ui tiny  modal">
        <i class="close icon"></i>
        <div class="header">
            修改
        </div>
        <div class="content">
            <form class="ui form">
                <div class="field inline">
                    <label>大数据类型:</label>
                    <div class="ui mBigDataType selection dropdown">
                        <input type="hidden" name="bigDataType" class="bigDataType">
                        <i class="dropdown icon"></i>
                        <div class="default text">大数据类型</div>
                        <div class="menu"></div>
                    </div>
                </div>

                <div class="field inline">
                    <label>小数据类型:</label>
                    <span class="smallDataTypeDisplay"></span>
                    <div class="ui mSmallDataType selection dropdown">
                        <input type="hidden" name="smallDataType" class="smallDataType">
                        <i class="dropdown icon"></i>
                        <div class="default text">小数据类型</div>
                        <div class="menu"></div>
                    </div>
                </div>

                <div class="field inline">
                    <label>年份:</label>
                    <input type="text" name="year" class="year">
                </div>

                <div class="field inline">
                    <label>工作区</label>
                    <div class="ui search mWorkspaceSelect selection dropdown">
                        <input type="hidden" name="workspace" class="workspace">
                        <i class="dropdown icon"></i>
                        <div class="default text">工作区</div>
                        <div class="menu"></div>
                    </div>
                </div>

                <div class="field inline">
                    <label>图层</label>
                    <span class="layerDisplay"></span>
                    <div class="ui search mLayerSelect selection dropdown">
                        <input type="hidden" name="layer" class="layer">
                        <i class="dropdown icon"></i>
                        <div class="default text">图层</div>
                        <div class="menu"></div>
                    </div>
                </div>

          </form>
        </div>

        <div class="actions">
            <div class="ui black deny button">
                取消
            </div>
            <div class="ui positive right labeled icon button">
                确定
                <i class="checkmark icon"></i>
            </div>
        </div>
    </div>

</div>
<#--引入页面底部-->
<#include "/common/footer.ftl">
</body>
<script language="javascript">
    $(document).ready(function () {
        //服务列表的显示
        var listTable = $("#listService").DataTable({
            "serverSide":true,
            "pageLength":5,
            "language":{
                "url":"../common/chinese.json"
            },
            "ajax":{
                "url":"listService.html",
                "type": "post"
            },
            "columns":[
                {"data" : "bigDataType"},
                {"data" : "smallDataType"},
                {"data" : "year"},
                {"data" : "workspace"},
                {"data" : "layer"},
                {
                    "data" : "createTime",
                    "render":function(data, type, row){
                        return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
                    }
                },
                {
                    "data" : "updateTime",
                    "render":function(data, type, row){
                        return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
                    }
                },
                {
                    "data":function(obj){
                        return '<div class="ui primary button modify" data-id="'+ obj.id +'">修改</div>' +
                                '<div class="ui green button delete" data-id="'+ obj.id+'">删除</div>';
                    }
                }
            ]
        })

        //大数据类型下拉框
        $(".ui.mBigDataType").dropdown();
        $.ajax({
            url:"acquiredAllBigDataType.html",
            success: function (result) {
                $.each(result.bigDataTypes, function (index, value) {
                    var $div = $("<div class='item' data-value='"+value.dataType+"'>"+value.dataType+"</div>");
                    $div.appendTo($(".ui.mBigDataType.dropdown .menu"));
                })
            }
        });

        //小数据类型的下拉框
        $(".ui.mSmallDataType").dropdown();
        $(".mBigDataType").dropdown({
            onChange:function(value, text, $choice){
                //清除元素内容
                $(".ui.mSmallDataType.dropdown .menu").dropdown('clear');
                $(".ui.mSmallDataType.dropdown .menu").children().remove().end();
                //小数据类型随着变化
                $.ajax({
                    url:"acquireAllSmallDataType.html",
                    data:{
                        name:value
                    },
                    success: function (result) {
                        $.each(result.smallDataTypes, function (index, value) {
                            var $div = $("<div class='item' data-value='"+value.dataType+"'>"+value.dataType+"</div>");
                            $div.appendTo($(".ui.mSmallDataType.dropdown .menu"));
                        })
                    }
                })
            }
        })

        //工作区
        $(".mWorkspaceSelect").dropdown();
        $.ajax({
            url:"http://localhost:8080/rest/workspaces.json",
            dataType:"json",
            success:function(data){
                for(var i=0; i < data.workspaces.workspace.length; i++){
                    $div = $("<div class='item' data-value='"+data.workspaces.workspace[i].name+"'>"+data.workspaces.workspace[i].name+"</div>");
                    $div.appendTo($(".mWorkspaceSelect .menu"));
                }
            },
            headers:{
                authorization: "Basic YWRtaW46Z2Vvc2VydmVy"
            }
        })

        //图层的下拉框
        $(".mLayerSelect").dropdown();

        $(".mWorkspaceSelect").dropdown({
            onChange:function (value, text, $choice) {
                $.ajax({
                    url:"http://localhost:8080/rest/workspaces/" + value + "/layers.json",
                    dataType:"json",
                    success:function(data){
                        if(data.layers != ""){
                            for(var i=0; i < data.layers.layer.length; i++){
                                $div = $("<div class='item' data-value='"+data.layers.layer[i].name+"'>"+data.layers.layer[i].name+"</div>");
                                $div.appendTo($(".mLayerSelect .menu"));
                            }
                        }
                    },
                    headers:{
                        authorization: "Basic YWRtaW46Z2Vvc2VydmVy"
                    }
                });
            }
        })


        //修改
        $("#listService tbody").on("click", ".modify" ,function () {
            var id = $(this).attr("data-id");
            var data = listTable.row($(this).parents("tr")).data();
            var bdt = data.bigDataType;
            var sdt = data.smallDataType;
            var y = data.year;
            var workspace = data.workspace;
            var l = data.layer;

            //大数据类型
            $(".mBigDataType").dropdown("set selected", bdt);

            //小数据类型
            $(".mSmallDataType").dropdown('set selected',sdt);

            //工作区
            $(".mWorkspaceSelect").dropdown("set selected", workspace);

            //图层
            $(".mLayerSelect").dropdown("set selected", l);

            //回显数据
            $(".smallDataTypeDisplay").html(sdt);
            $(".layerDisplay").html(l);
            $(".year").val(y);
            $(".workspace").val(sdt);
            $(".layer").val(l);

            $(".ui.tiny.modal").modal({
                onDeny: function () {
                    //刷新一下
                    $(location).attr("href","listServiceData.html");
                    return false;
                },
                onApprove : function () {
                    var createTime = new Date(data.createTime).Format("yyyy-MM-dd hh:mm:ss").toString();
                    var updateTime = new Date().Format("yyyy-MM-dd hh:mm:ss").toString();
                    var param = $(".ui.form").serialize();
                    param = param +  "&createTime=" + createTime + "&updateTime=" + updateTime;

                    $.ajax({
                        url:"updateServiceData.html",
                        type:"post",
                        dataType:"json",
                        data: param,
                        success: function(result){
                            if(result.msg == "success"){
                                listTable.ajax.reload();
                            }else if(result.msg == "failure"){

                            }
                        }
                    })
                }
            }).modal("show");
        })

        //删除
        $("#listService tbody").on("click", ".delete", function () {
            var id = $(this).attr("data-id");
            $.ajax({
                url:"deleteServiceData.html",
                data:{
                    id:id
                }
            }).done(function(result){
                if(result.msg == "success"){
                    listTable.ajax.reload();
                }
            }).fail(function(){
                alert("删除失败");
            })
        })
    })
</script>
</html>