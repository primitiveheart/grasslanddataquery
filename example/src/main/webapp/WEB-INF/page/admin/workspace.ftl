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

    <title>工作区</title>
</head>
<body>
<#--引入页面头部-->
<#include "/common/header.ftl">
<#include "/common/user-info.ftl">
<#--页面内容-->
<div class="content_">
    <div class="ui bottom attached segment">
        <div class="ui header">工作区</div>
        <div>管理GeoServer的工作区</div>
        <div class="inline">
            <i class="plus icon"></i>
            <span><a href="newWorkspace.html">添加新的工作区</a></span>
        </div>
        <div class="inline">
            <i class="minus icon"></i>
            <span><a href="#" class="delete">删除选定的工作区</a></span>
        </div>
        <div class="ui divider"></div>
        <table id="workspace" width="100%" class="display cell-border" cellspacing="0">
            <thead>
                <tr class="nowrap">
                    <th>
                        <div class="ui checkbox">
                            <input type="checkbox" class="all">
                            <label>选中所有</label>
                        </div>
                    </th>
                    <th>工作区名称</th>
                </tr>
            </thead>
        </table>
    </div>

    <div class="ui modal">
        <div class="header">确定删除对象</div>
        <div class="content">你要删除下面的对象:</div>
        <div class="actions">
            <div class="ui primary approve button">确定</div>
            <div class="ui black deny button">取消</div>
        </div>
    </div>

</div>
<#--引入页面底部-->
<#include "/common/footer.ftl">
<script language="javascript">
    $(document).ready(function(){

        var table = $("#workspace").DataTable({
            "pageLength":5,
            "serverSide":true,
            "searching":false,
            "ajax":"workspaces.json",
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
                }
            ]
        })

       $(".workspace").on("click",".single", function(){
           console.log(this);
       })

        $(".delete").on("click", function () {
            $(".modal").show();
        })

       $(".all").on("click", function () {
//           if(this.checked){
//               $(".single").each(function(){
//                   this.checked = true;
//               });
//           }else{
//               $(".single").each(function(){
//                   this.checked = false;
//               });
//           }
       })
    })
</script>
</body>
</html>