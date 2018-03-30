geoserver war 的部署方式，直接放在tomcat下的webapp下，
intellij idea 中geoserver的根路径是/
geoserver的访问路径是"http://localhost:8080/"

在代码中访问时: 如下，GeoServerRESTReader reader = new GeoServerRESTReader("http://localhost:8080", "admin", "geoserver");


数据类型
1、气象数据(weather)
    最低温度 - tempature_min
    最高温度 - tempature_max
    平均温度 - tempature_average
    累积降雨量 - cumulative_rainfall
    太阳辐射 - raditation
2、土壤数据(soil)
    *土壤类型(亚类) - agrotype_*
3、植被数据(vegetation)
    *草地植被类型(亚类-型) - grassland_vegetation_type_*
    NVDI(月最大合成) - nvdi
    叶面积指数 - LAI
4、地形数据(terrain)
    *高程 - altitude_*
    *坡度(度) - slope_*
    *坡向 - aspect_*
5、固碳数据(carbon)
    植被净生产力 - NPP
    土壤有机碳储量 -SOC