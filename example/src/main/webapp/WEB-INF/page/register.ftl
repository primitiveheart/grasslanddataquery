<!DOCTYPE html>
<html>
    <head>
        <title>用户注册页面</title>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0 maximum-scale=1.0"/>
        <link href="resources/css/semantic.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/main.css" rel="stylesheet" type="text/css"/>
        <script src="resources/js/jquery-3.2.1.js"></script>
        <script src="resources/js/semantic.min.js"></script>
    </head>
    <body>
    <#--引入页面头部-->
    <#include "/common/header.ftl">
    <#--页面内容-->
    <div class="content_">
        <div class="login">
            <div class="ui three column stackable grid">
                <div class="column"></div>
                <div class="column">
                    <form id="login" class="ui fluid form segment">
                        <div class="field">
                            <label class="">用户名</label>
                            <input type="text" name="username" placeholder=""/>
                        </div>${errorMsg}
                        <div class="field">
                            <label class="">昵称</label>
                            <input type="text" name="nickname" placeholder=""/>
                        </div>
                        <div class="field">
                            <label class="">密码</label>
                            <input type="password" name="password" placeholder=""/>
                        </div>
                        <div class="field">
                            <label class="">电话号码</label>
                            <input type="text" name="mobilephone" placeholder=""/>
                        </div>
                        <div class="inline field center">
                            <a class="ui green register button">提交</a>
                        </div>
                    </form>
                </div>
                <div class="column"></div>
            </div>
        </div>
    </div>
    <#--引入页面底部-->
    <#include "/common/footer.ftl"/>
    </body>
</html>