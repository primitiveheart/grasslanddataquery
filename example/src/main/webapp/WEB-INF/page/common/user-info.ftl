<div class="ui menu userInfo">
    <div class="header item"><img src="../resources/image/logo.jpg"></div>
    <a href="home.html" class="item admin">主页</a>
    <a href="home.html" class="item user">主页</a>
    <div class="item lookupResult">
        <a href="lookupResult.html" class="user">我的订单</a>
    </div>
    <div class="ui pointing dropdown link item dataAdmin">
        <#--<a href="addService.html" class="admin">数据管理</a>-->
        <span class="text">数据管理</span>
        <i class="dropdown icon"></i>
        <div class="menu">
            <div class="item"><a href="bigDataType.html">大数据类型</a></div>
            <div class="item"><a href="smallDataType.html">小数据类型</a></div>
            <div class="item"><a href="addServiceData.html">添加服务数据</a></div>
            <div class="item"><a href="listServiceData.html">服务数据列表</a></div>
        </div>
    </div>
    <div class="ui pointing geoverserdata dropdown link item">
        <span class="text">geoserver数据</span>
        <i class="dropdown icon"></i>
        <div class="menu">
            <div class="item"><a href="workspace.html">工作区</a></div>
            <div class="item"><a href="dataStore.html">数据存储</a></div>
            <div class="item"><a href="layer.html">图层</a></div>
        </div>
    </div>
    <div class="right menu">
        <div class="item current_user"></div>
        <div class="item logout"></div>
        <div class="item userresoure">
            <a href="personInfo.html">个人资料</a>
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
            $(".lookupResult").show();
            $(".userresoure").show();
            $(".dataAdmin").hide();
            $(".geoverserdata").hide();
        }else{
            $(".geoverserdata").dropdown();
            $(".dataAdmin").dropdown();
            var username = "${admin.username}";
            if(username != ""){
                $(".current_user").html("<p>当前用户:" + username + "</p>");
                $(".logout").html("<a href='logout.html'>注销</a>")
            }
            $(".user").hide();
            $(".admin").show();
            $(".lookupResult").hide();
            $(".userresoure").hide();
            $(".dataAdmin").show();
            $(".geoverserdata").show();
        }
    })
</script>