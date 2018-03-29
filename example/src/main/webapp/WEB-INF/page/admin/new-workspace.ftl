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

    <title>新建工作区</title>
</head>
<body>
<#--引入页面头部-->
<#include "/common/header.ftl">
<#include "/common/user-info.ftl">
<#--页面内容-->
<div class="content_">
    <div class=" ui header">新建工作区</div>
    <div>配置一个新的工作区</div>
    <form class="ui form">
        <div class="field">
            <label>名称</label>
            <input type="text" name="name" class="name">
        </div>
        <div class="field">
            <label>命名空间URI</label>
            <input type="text" name="namespace" class="namespace">
        </div>

        <div class="ui submit button">提交</div>
        <div class="ui cancel button">取消</div>
    </form>

</div>

<#--引入模态框-->
<#include "/common/modal.ftl">
<#--引入页面底部-->
<#include "/common/footer.ftl">
<script language="javascript">
    $(document).ready(function () {

        //取消
        $(".cancel").on("click", function(){
            $(location).attr("href", "workspace.html");
        })


        //提交
        $(".submit").on("click", function(){
            var name = $(".name").val();
            var uri = $(".namespace").val();
            $.ajax({
                url:"namespaces.json",
                type:"POST",
                data:{
                    name:name,
                    uri:uri
                },
                success: function (data) {
                    if(data.msg == "success"){
                        $(".success .content").html("工作区创建成功");
                        $(".ui.success.modal").modal("show");
                    }else if(data.msg == "failure"){
                        $(".failure .content").html("工作区创建失败");
                        $(".ui.failure.modal").modal("show");
                    }
                }
            })
        })

        //模态框
        $(".success").modal({
            onApprove:function(){
                //刷新一下
                $(location).attr("href","workspace.html");
            }
        })
    })
</script>
</body>
</html>