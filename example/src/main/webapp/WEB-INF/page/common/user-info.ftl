<div class="ui grid userInfo">
    <div class="ui five column row">
        <div class="column">
            <a href="home.html" class="admin">主页</a>
            <a href="home.html" class="user">主页</a>
        </div>
        <div class="column">
            <a href="lookupResult.html" class="user">查看结果</a>
        </div>
        <div class="column"><a href="addService.html" class="admin">数据管理</a></div>
        <div class="column current_user">
            <#if location.href?contains("admin")>
                <#if admin != null && admin.username != null>
                    当前用户:${admin.username}
                </#if>
            </#if>
            <#if location.href?contains("admin")>
                <#if user != null && user.username != null>
                    当前用户:${user.username}
                </#if>
            </#if>
        </div>
        <div class="column logout">
            <#if user != null && user.username != null>
                <a href="logout.html">注销</a>
            </#if>
            <#if admin != null && admin.username != null>

            </#if>
        </div>
    </div>
</div>

<script>
    $(document).ready(function(){
        var url = $(location).attr("href");
        if(!(url.indexOf("admin") >= 0)){
            var username = "${user.username}";
            if(username != ""){
                $(".current_user").html("<p>当前用户:" + username + "</p>");
                $(".logout").html("<a href='logout.html'>注销</a>")
            }
            $(".admin").hide();
            $(".user").show();
        }else{
            var username = "${admin.username}";
            if(username != ""){
                $(".current_user").html("<p>当前用户:" + username + "</p>");
                $(".logout").html("<a href='logout.html'>注销</a>")
            }
            $(".user").hide();
            $(".admin").show();
        }
    })
</script>