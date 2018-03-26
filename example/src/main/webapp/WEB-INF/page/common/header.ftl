<div class="header_">
    <div class="ui grid">
        <div class="ui row centered">
            <h1></h1>
        </div>
    </div>
</div>

<script>
    $(document).ready(function(){
        var url = $(location).attr("href");
        if(!(url.indexOf("admin") >= 0)){
            $("h1").html("<p>基于云平台的全国草地覆盖及生态环境因子查询系统 </p>");
        }else{
            $("h1").html("<p>基于云平台的全国草地覆盖及生态环境因子后台管理系统</p>");
        }
    })
</script>
