<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0 maximum-scale=1.0"/>

    <link href="../resources/css/semantic.min.css" rel="stylesheet" type="text/css"/>
    <script src="../resources/js/jquery-3.2.1.js"></script>
    <script src="../resources/js/semantic.min.js"></script>

    <title>个人资料</title>
</head>
<body>
    <div class="ui modal">
        <i class="close icon"></i>
        <div class="header">
            个人资料
        </div>
        <div class="content">
            <div>
                <label>昵称</label>
                <span>${userInfo.nickname}</span>
            </div>
            <div>
                <label>姓名</label>
                <span>${userInfo.name}</span>
            </div>
            <div>
                <label>电话号码</label>
                <span>${userInfo.mobilephone}</span>
            </div>
            <div>
                <label>邮箱</label>
                <span>${userInfo.email}</span>
            </div>
        </div>
        <div class="actions">
            <div class="ui approve button">确定</div>
        </div>
    </div>
<script language="JavaScript">
    $(document).ready(function () {
        $(".ui.modal").modal({
            onApprove: function(){
                $(location).attr("href", "home.html");
            }
        }).modal("show");
    })
</script>
</body>
</html>