<div class="footer_">
</div>

<script>
    $(document).ready(function(){
        var url = $(location).attr("href");
        if(!(url.indexOf("admin") >= 0)){
            var username = "${user.username}";
            if(username != ""){
                $(".footer_").html("<p>基于云平台的全国草地覆盖及生态环境因子查询系统 版权所有 2017 </p>");
            }
        }else{
            var username = "${admin.username}";
            if(username != ""){
                $(".footer_").html("<p>基于云平台的全国草地覆盖及生态环境因子后台管理系统 版权所有 2017 </p>");
            }
        }
    })
</script>