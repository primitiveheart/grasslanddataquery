<div class="ui grid userInfo">
    <div class="ui five column row">
        <div class="column">
            <a href="home.hml" class="admin">主页</a>
            <a href="query.html" class="user">主页</a>
        </div>
        <div class="column">
            <a href="home.html" class="admin">用户数据管理</a>
            <a href="lookupResult.html" class="user">查看结果</a>
        </div>
        <div class="column"><a href="addService.html" class="admin">数据管理</a></div>
        <div class="column">
            <#if user != null && user.username != null>
                当前用户:${user.username}
            </#if>
        </div>
        <div class="column">
            <#if user != null && user.username != null>
                <a href="logout.html">注销</a>
            </#if>
        </div>
    </div>
</div>

<script>
    $(document).ready(function(){
        var url = $(location).attr("href");
        if(!(url.indexOf("admin") >= 0)){
            $(".admin").hide();
            $(".user").show();
        }else{
            $(".user").hide();
            $(".admin").show();
        }
    })
</script>