<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0 maximum-scale=1.0"/>

    <link href="../resources/css/semantic.min.css" rel="stylesheet" type="text/css"/>
    <link href="../resources/css/main.css" rel="stylesheet" type="text/css"/>
    <script src="../resources/js/jquery-3.2.1.js"></script>
    <script src="../resources/js/semantic.min.js"></script>

    <title>登陆界面</title>
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
                <form id="login" class="ui fluid form segment" action="loginUp.html">
                    <div class="field">
                        <label class="">用户名</label>
                        <div class="ui left icon input">
                            <input type="text" name="username" placeholder=""/>
                            <i class="user icon"></i>
                            <div class="ui corner label">
                                <i class="icon asterisk"></i>
                            </div>
                        </div>
                    </div>
                    <div class="field">
                        <label class="">密码</label>
                        <div class="ui left icon input">
                            <input type="password" name="password" placeholder=""/>
                            <i class="lock icon"></i>
                            <div class="ui corner label">
                                <i class="icon asterisk"></i>
                            </div>
                        </div>
                    </div>
                    <div class="inline field">
                        <div class="ui checkbox">
                            <input type="checkbox" name="terms"/>
                            <label>记住密码</label>
                        </div>
                    </div>
                    <div class="inline field center">
                        <button class="ui blue submit button">登录</button>
                    </div>
                </form>
            </div>
            <div class="column"></div>
        </div>
    </div>
</div>
<#--引入页面底部-->
<#include "/common/footer.ftl">
</body>
<script type="application/javascript" language="JavaScript">
    $(document).ready(function(){
        $('.ui.form').form({
            inline : true,
            on: 'blur',
            fields: {
                userName: {
                    identifier: 'username',
                    rules: [
                        {
                            type: 'empty',
                            prompt: 'Please enter a username'
                        }
                    ]
                },
                password: {
                    identifier: 'password',
                    rules: [
                        {
                            type: 'empty',
                            prompt: 'Please enter a password'
                        },
                        {
                            type: 'length[6]',
                            prompt: 'Your password must be at least 6 characters'
                        }
                    ]
                }
            },
            onValid:function(){
                //主要是进行后台验证
                var selector = $(this).attr("name");
                var value = $(this).val();
                $.ajax({
                    type:"post",
                    url:"loginValidation.html",
                    data:{
                        name:selector,
                        value:value
                    },
                    success:function(result){
                        if(result.type == "username"){
                            $(".ui.form").form('add prompt', "username", "用户名不存在");
                        }else if(result.type == "password"){
                            $(".ui.form").form('add prompt', "password", "密码不正确");
                        }
                    }
                })
            }
        });
    })

</script>
</html>