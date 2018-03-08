<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0 maximum-scale=1.0"/>

        <link href="resources/css/semantic.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/main.css" rel="stylesheet" type="text/css"/>
        <script src="resources/js/jquery-3.2.1.js"></script>
        <script src="resources/js/semantic.min.js"></script>

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
                       <form id="login" class="ui fluid form segment" action="loginValidation.html" method="post">
                           <div class="field">
                               <label class="">用户名</label>
                               <div class="ui left icon input">
                                   <input type="text" name="username" placeholder=""/>
                                   <i class="user icon"></i>
                                   <div class="ui corner label">
                                       <i class="icon asterisk"></i>
                                   </div>
                               </div>
                           ${userErrorMsg}
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
                           ${psdErrorMsg}
                           </div>
                           <div class="inline field">
                               <div class="ui checkbox">
                                   <input type="checkbox" name="terms"/>
                                   <label>记住密码</label>
                               </div>
                           </div>
                           <div class="inline field center">
                               <button class="ui blue submit button">登录</button>
                               <button class="ui green register button">注册</button>
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
                        userName: {
                            identifier : 'username',
                            rules: [
                                {
                                    type   : 'empty',
                                    prompt : 'Please enter a username'
                                }
                            ]
                        },
                        password: {
                            identifier : 'password',
                            rules: [
                                {
                                    type   : 'empty',
                                    prompt : 'Please enter a password'
                                },
                                {
                                    type   : 'length[6]',
                                    prompt : 'Your password must be at least 6 characters'
                                }
                            ]
                        }
                    },
                    {
                        inline : true,
                        on     : 'blur',
                        onSuccess: submitForm
                    }
            );

            $(".ui.form").submit(function (e) {
                return false;
            });
            $(".ui.checkbox").checkbox();

            $(".ui.register").on("click", function () {
                window.location.href ="register.html";
            })
        })
        function submitForm() {
            var formData = $(".ui.form input").serializeArray();
            formData = $.param(formData);
            window.location.href = "loginValidation.html?"+formData;
        }
    </script>
</html>