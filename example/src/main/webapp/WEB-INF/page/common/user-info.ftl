<div class="ui menu userInfo">
    <div class="header item"><img src="../resources/image/logo.jpg"></div>
    <a href="home.html" class="item admin">主页</a>
    <a href="home.html" class="item user">主页</a>
    <div class="item lookupResult">
        <a href="lookupResult.html" class="user">查看结果</a>
    </div>
    <div class="item dataAdmin">
        <a href="addService.html" class="admin">数据管理</a>
    </div>
    <div class="right menu">
        <div class="item current_user"></div>
        <div class="item logout"></div>
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
            $(".lookupResult").show();
            $(".dataAdmin").hide();
        }else{
            var username = "${admin.username}";
            if(username != ""){
                $(".current_user").html("<p>当前用户:" + username + "</p>");
                $(".logout").html("<a href='logout.html'>注销</a>")
            }
            $(".user").hide();
            $(".admin").show();
            $(".lookupResult").hide();
            $(".dataAdmin").show();
        }
    })
</script>