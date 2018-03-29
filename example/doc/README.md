geoserver war 的部署方式，直接放在tomcat下的webapp下，
intellij idea 中geoserver的根路径是/
geoserver的访问路径是"http://localhost:8080/"

在代码中访问时: 如下，GeoServerRESTReader reader = new GeoServerRESTReader("http://localhost:8080", "admin", "geoserver");