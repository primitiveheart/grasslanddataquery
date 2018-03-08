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

    <title>数据管理界面</title>
</head>
<body>
<#--引入页面头部-->
<#include "/common/header.ftl">
<#include "/common/user-info.ftl">
<#--页面内容-->
<div class="content_">

        <h4 class="ui top centered attached block header">数据管理</h4>
        <div class="ui bottom attached segment">
            <div class="ui header">大数据类型</div>
            <label>数据类型(中文)</label>
            <div class="ui input">
                <input type="text" class="bigData">
            </div>
            <label>数据类型(英文)</label>
            <div class="ui input">
                <input type="text" class="bigDataEnglish">
            </div>
            <div class="ui primary button addBigData">
                <i class="plus icon"></i>
                <label>添加</label>
            </div>

            <div class="ui header">小数据类型</div>
            <label>大数据类型</label>
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
            <label>数据类型(中文)</label>
            <div class="ui input">
                <input type="text" class="smallData">
            </div>
            <label>数据类型(英文)</label>
            <div class="ui input">
                <input type="text" class="smallDataEnglish">
            </div>
            <div class="ui primary button addSmallData">
                <i class="plus icon"></i>
                <label>添加</label>
            </div>

            <div class="ui divider"></div>
            <div class="ui header">添加服务</div>
            <div class="ui divider"></div>

            <div class="ui form">
                <div class="fields">
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
                </div>

                <div class="fields">
                    <div class="field inline">
                        <label>年份</label>
                        <input type="text" name="year" class="year">
                    </div>

                    <div class="field inline">
                        <label>图层</label>
                        <input type="text" name="layer" class="layer">
                    </div>
                </div>


                <div class="ui green submit button addService">
                    <i class="plus icon"></i>
                    <label>添加服务</label>
                </div>

            </div>


            <div class="ui divider"></div>

            <div class="ui header">服务列表</div>
            <div class="ui divider"></div>
            <table id="listService" width="100%" class="display cell-border" cellspacing="0">
                <thead>
                <tr class="nowrap">
                    <th>大数据类型</th>
                    <th>小数据类</th>
                    <th>年份</th>
                    <th>图层</th>
                    <th>创建的时间</th>
                    <th>更新的时间</th>
                    <th>操作</th>
                </tr>
                </thead>
            </table>
        </div>

        <div class="ui tiny  modal">
            <i class="close icon"></i>
            <div class="header">
                修改
            </div>
            <div class="content">
                <p>
                    <div class="inline">
                        <label>大数据类型:</label>
                        <#--<input type="text" name="mBigDataType" class="mBigDataType">-->
                        <div class="ui mBigDataType selection dropdown">
                            <input type="hidden" name="mBigDataType">
                            <i class="dropdown icon"></i>
                            <div class="default text">大数据类型</div>
                            <div class="menu"></div>
                        </div>
                    </div>
                </p>
               <p>
                   <div class="inline">
                       <label>小数据类型:</label>
                       <#--<input type="text" name="mSmallDataType" class="mSmallDataType">-->
                        <div class="ui mSmallDataType selection dropdown">
                            <input type="hidden" name="mSmallDataType">
                            <i class="dropdown icon"></i>
                            <div class="default text">小数据类型</div>
                            <div class="menu"></div>
                        </div>
                   </div>
               </p>
               <p>
                   <div class="ui input inline">
                       <label>年份:</label>
                       <input type="text" name="mYear" class="mYear">
                   </div>
               </p>
                <p>
                    <div class="ui input inline">
                        <label>图层:</label>
                        <input type="text" name="mLayer" class="mLayer">
                    </div>
                </p>
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

        <div class="ui success modal">
            <div class="header">添加成功</div>
            <div class="actions">
                <div class="ui positive button">确定</div>
            </div>
        </div>

        <div class="ui failure modal">
            <div class="header"></div>
            <div class="actions">
                <div class="ui positive button">确定</div>
            </div>
        </div>

</div>
<#--引入页面底部-->
<#include "/common/footer.ftl">
</body>
<script src="../resources/js/date.js"></script>
<script>
    $(document).ready(function(){

        //大数据类型添加到数据库中
        $(".addBigData").on("click", function () {
            var bigData = $(".bigData").val();
            var bigDataEnglish = $(".bigDataEnglish").val();
            $.ajax({
                url:"saveBigDataType.html",
                type:"post",
                data:{
                    dataType: bigData,
                    dataTypeEnglish: bigDataEnglish
                },
                success:function (result) {
                    if(result.msg == "success"){
                        $(".ui.success.modal").modal("show");
                    }else if(result.msg == "failure"){
                        $(".ui.failure.modal .header").val("添加失败");
                        $(".ui.failure.modal").modal("show");
                    }
                }
            })
        })

        //小数据类型中大数据类型的下拉框数据
        $(".ui.selection.dropdown.bigDataType").dropdown()
        
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
                success: function(){
                    //TODO
                    //数据添加完之后刷新一下
                    $(location).attr("href","addService.html");
                }

            })
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
                    $(location).attr("href","addService.html");
                }
            })
        })

        //服务列表的显示
        var listTable = $("#listService").DataTable({
            "serverSide":true,
            "pageLength":5,
            "language":{
                "url":"../chinese.json"
            },
            "ajax":{
                "url":"listService.html",
                "type": "post"
            },
            "columns":[
                {"data" : "bigDataType"},
                {"data" : "smallDataType"},
                {"data" : "year"},
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

        //修改
        $("#listService tbody").on("click", ".modify" ,function () {
            var id = $(this).attr("data-id");
            var data = listTable.row($(this).parents("tr")).data();
            var bdt = data.bigDataType;
            var sdt = data.smallDataType;
            var y = data.year;
            var l = data.layer;

            //大数据类型
            $.ajax({
                url:"acquiredAllBigDataType.html",
                success: function (result) {
                    $.each(result.bigDataTypes, function (index, value) {
                        var $div = $("<div class='item' data-value='"+value.dataType+"'>"+value.dataType+"</div>");
                        $div.appendTo($(".ui.mBigDataType.dropdown .menu"));
                    })
                }
            })

            //小数据类型
            $.ajax({
                url:"acquireAllSmallDataType.html",
                data:{
                    name:bdt
                },
                success: function (result) {
                    //设置大数据类型的选中值
                    $(".ui.mBigDataType.dropdown").dropdown('set selected',bdt);
                    $.each(result.smallDataTypes, function (index, value) {
                        var $div = $("<div class='item' data-value='"+value.dataType+"'>"+value.dataType+"</div>");
                        $div.appendTo($(".ui.mSmallDataType.dropdown .menu"));
                    })
                    $(".ui.mSmallDataType.dropdown").dropdown('set selected',sdt);
                }
            })

            //大数据类型与小数据类型联动
            $(".ui.mBigDataType.dropdown").dropdown({
                onChange: function (value, text, $selectedItem) {
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

            $(".mBigDataType").val(bdt);
            $(".mSmallDataType").val(sdt);
            $(".mYear").val(y);
            $(".mLayer").val(l)

            $(".ui.tiny.modal").modal({
                onDeny: function () {
                    //刷新一下
                    $(location).attr("href","addService.html");
                    return false;
                },
                onApprove : function () {
                    var createTime = new Date(data.createTime).Format("yyyy-MM-dd hh:mm:ss").toString();
                    var mbdt = $(".mBigDataType").val();
                    var msdt =  $(".mSmallDataType").val();
                    var my =  $(".mYear").val();
                    var ml =  $(".mLayer").val();

                    var updateTime = new Date().Format("yyyy-MM-dd hh:mm:ss").toString();

                    if(bdt != mbdt || sdt != msdt || y != my || l != ml){
                        var param = {"id":id, "bigDataType": mbdt , "smallDataType": msdt,"year": my, "layer": ml, "createTime": createTime, "updateTime": updateTime};
                        param = $.param(param);
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