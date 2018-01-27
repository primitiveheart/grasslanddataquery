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

    <title>数据管理界面</title>
</head>
<body>
<#--引入页面头部-->
<#include "/commons/header.ftl">
<#include "/commons/user-info.ftl">
<#--页面内容-->
<div class="content_">

        <h4 class="ui top centered attached block header">数据管理</h4>
        <div class="ui bottom attached segment">
            <div class="ui header">大数据类型</div>
            <div class="ui input">
                <input type="text" class="bigData">
            </div>
            <div class="ui primary button addBigData">
                <i class="plus icon"></i>
                <label>添加</label>
            </div>

            <div class="ui divider"></div>
            <div class="ui header">添加服务</div>
            <div class="ui green button addRow">
                <i class="plus icon"></i>
                <label>添加服务</label>
            </div>
            <div class="ui divider"></div>
            <table id="addService" width="100%" class="display cell-border" cellspacing="0">
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

        <div class="ui tiny modal">
            <i class="close icon"></i>
            <div class="header">
                修改
            </div>
            <div class="content">
                <p>
                    <div class="ui input">
                        <h4><label>大数据类型:</label></h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" name="mBigDataType" class="mBigDataType">
                    </div>
                </p>
               <p>
                   <div class="ui input">
                       <h4><label>小数据类型:</label></h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       <input type="text" name="mSmallDataType" class="mSmallDataType">
                   </div>
               </p>
               <p>
                   <div class="ui input">
                       <h4><label>年份:</label></h4>
                       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       <input type="text" name="mYear" class="mYear">
                   </div>
               </p>
                <p>
                    <div class="ui input">
                        <h4><label>图层:</label></h4>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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

        <div class="ui failure model">
            <div class="header"></div>
            <div class="actions">
                <div class="ui positive button">确定</div>
            </div>
        </div>

</div>
<#--引入页面底部-->
<#include "/commons/footer.ftl">
</body>
<script src="../resources/js/date.js"></script>
<script>
    $(document).ready(function(){

        $(".addBigData").on("click", function () {
            var temp = $(".bigData").val();
            $.ajax({
                url:"saveBigDataType.html",
                type:"post",
                data:{
                    dataType: temp
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

        var table =  $("#addService").DataTable({
            "searching": false,
            "bInfo": false,
            "lengthChange":false,
            "paging": false,
            "pageLength": 5,
            "language": {
                "url": "../chinese.json"
            }
        });

        $(".addRow").on("click" , function () {
            var today = new Date().Format("yyyy-MM-dd hh:mm:ss");
            var select = "";
            $.ajax({
                url:"acquiredAllBigDataType.html",
                async:false,
                success: function (result) {
                    var len = result.types.length;
                    select = '<select class="ui bigDataType selection dropdown" name="bigDataType" style="width: 100px;">';
                    for(var i = 0; i < len; i++){
                        select += '<option value="' + result.types[i] +'"> '+ result.types[i] + '</option>';
                    }
                    select += '</select>';
                }
            })
            var smallDataType = '<div class="ui input"><input type="text" class="smallDataType" name="smallDataType" value=""/></div>';
            var year = '<div class="ui input"><input type="text" class="year" name="year" value=""/></div>';
            var layer = '<div class="ui input"><input type="text" class="layer" name="layer" value=""/></div>';
            var createTime = '<div class="ui input"><input type="text" class="createTime" name="createTime" value="'+ today.toString() +'" readonly="readonly"/></div>';
            var updateTime = '<div class="ui input"><input type="text" class="updateTime" name="updateTime" value="'+ today.toString() +'" readonly="readonly"/></div>';
            var op = '<div class="ui blue button addData">添加</div>';
            table.row.add([select, smallDataType, year, layer, createTime, updateTime, op]).draw();
        })
        
        $("#addService tbody").on("click", ".addData", function () {
            var data = table.row($(this).parents("tr")).$('input, label, select').serialize();
            $.ajax({
                url:"saveServiceData.html",
                type:"post",
                data:data,
                success: function (result) {
                    if(result.msg == "success"){
                        $(location).attr("href","addService.html");
                    }else if(result.msg == "failure"){
                        $(".ui.failure.modal .header").val("添加服务失败");
                        $(".ui.failure.modal").modal("show");
                    }
                }
            })
        })
        
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
            $(".mBigDataType").val(bdt);
            $(".mSmallDataType").val(sdt);
            $(".mYear").val(y);
            $(".mLayer").val(l)

            $(".ui.modal").modal({
                onDeny: function () {

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
                                    $(".ui.failure.modal .header").val("修改数据失败");
                                    $(".ui.failure.modal").modal("show");
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