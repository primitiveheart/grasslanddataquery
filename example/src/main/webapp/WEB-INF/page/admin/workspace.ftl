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
        <table id="workspace" width="100%" class="display cell-border" cellspacing="0">
            <thead>
                <tr class="nowrap">
                    <th><input type="radio"></th>
                    <th>工作区名称</th>
                </tr>
            </thead>
        </table>
    </div>

</div>
<#--引入页面底部-->
<#include "/common/footer.ftl">
<script language="javascript">
    $(document).ready(function(){
        var table = $("#workspace").DataTable({
            "pageLength":5,
            "serverSide":true,
            "ajax":{
                "url":"http://localhost:8080/rest/workspaces.json",
                "type":"get",
                "dataType":"json",
                "dataSrc":function(data){
                    var workspaces = [];
                    var len = data.workspaces.workspace.length;
                    for(var i = 0; i < len; i++){
                        var middle = "<a href='"+data.workspaces.workspace[i].href+"'>"+data.workspaces.workspace[i].name+"</a>"
                        var workspace = {workspace: middle};
                        workspaces.push(workspace);
                    }
//                    data = workspaces;
                    data = {recordsFiltered:len, recordsTotal:len, data: workspaces};
                    return data.data;
                },
                "headers":{
                    "authorization": "Basic YWRtaW46Z2Vvc2VydmVy"
                }
            },
            "language":{
                "url":"../common/chinese.json"
            },
            "columns":[
                {
                    "data":function(obj){
                        return "<input type='radio'>";
                    }
                },
                {
                    "data":"workspace"
//                    "render":function(data, type, row){
//                        console.log(obj);
//                    }
                }
            ]
        })
    })
</script>
</body>
</html>