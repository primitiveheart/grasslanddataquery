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

    <title>小数据类型</title>
</head>
<body>
<#--引入页面头部-->
<#include "/common/header.ftl">
<#include "/common/user-info.ftl">
<#--页面内容-->
<div class="content_">

    <div class="ui header">小类别类型</div>
    <div class="ui divider"></div>
    <label>大类别类型</label>
    <div class="ui selection dropdown bigDataType">
        <input type="hidden" name="bigDataType">
        <i class="dropdown icon"></i>
        <div class="default text">----请选择----</div>
        <div class="menu">
        <#if bigDataTypes?? && bigDataTypes?size gt 0>
            <#list bigDataTypes as bdt>
                <div class="item" data-value="${bdt.dataTypeEnglish}">${bdt.dataType}</div>
            </#list>
        </#if>
        </div>
    </div>
    <label>类别类型(中文)</label>
    <div class="ui input">
        <input type="text" class="smallData">
    </div>
    <label>类别类型(英文)</label>
    <div class="ui input">
        <input type="text" class="smallDataEnglish">
    </div>

    <div class="ui primary button addSmallData">
        <i class="plus icon"></i>
        <label>添加</label>
    </div>

</div>
<#--引入模态框-->
<#include "/common/modal.ftl">
<#--引入页面底部-->
<#include "/common/footer.ftl">
</body>
<script language="javascript">
    $(document).ready(function () {
        //小数据类型中大数据类型的下拉框数据
        $(".ui.selection.dropdown.bigDataType").dropdown();

        //小数据类型添加到数据库中
        $(".addSmallData").on("click", function () {
            var smallData = $(".smallData").val();
            var smallDataEnglish = $(".smallDataEnglish").val();
            var bigDataTypeEnglish = $(".ui.selection.dropdown.bigDataType").dropdown('get value');
            $.ajax({
                url:"saveSmallDataType.html",
                type:"POST",
                data:{
                    dataType:smallData,
                    dataTypeEnglish:smallDataEnglish,
                    bigDataTypeEnglish:bigDataTypeEnglish
                },
                success: function(result){
                    if(result.msg == "success"){
                        $(".success .content").html("小数据类型添加成功");
                        $(".ui.success.modal").modal("show");
                    }else if(result.msg == "failure"){
                        $(".failure .content").html("小数据类型添加失败");
                        $(".ui.failure.modal").modal("show");
                    }

                }

            })
        })

        //模态框
        $(".success").modal({
            onApprove:function(){
                //刷新一下
                $(location).attr("href","smallDataType.html");
            }
        })
    })
</script>
</html>