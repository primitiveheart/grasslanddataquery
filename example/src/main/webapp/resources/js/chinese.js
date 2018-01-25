/**
 * Created by admin on 2018/1/25.
 */
function weather(data){
    var result = "";
    if(data.indexOf("tempature_min") >= 0){
        result += "最低温度(月)";
    }
    if(data.indexOf("tempature_max") >= 0){
        result += " 最高温度(月)";
    }
    if(data.indexOf("tempature_average") >= 0){
        result += " 平均温度(月)"
    }
    if(data.indexOf("sumRainfall") >= 0){
        result += " 累积降雨量(月)";
    }
    if(data.indexOf("solarRadition") >= 0){
        result += " 太阳辐射(月)";
    }

    return result;
}

function vegetation(data) {
    var result = "";
    if(data.indexOf("grassLandVegetationType_*") >= 0){
        result += "*草地植被类型(亚类-型)";
    }
    if(data.indexOf("NDVI") >= 0){
        result += " NDVI(月最大合成)";
    }
    if(data.indexOf("LAI") >= 0){
        result += " 叶面积指数(LAI)";
    }

    return result;
}

function terrain(data) {
    var result = "";
    if(data.indexOf("altitude_*") >= 0){
        result += "*高程";
    }
    if(data.indexOf("gradient_*") >= 0){
        result += " *坡度(度)";
    }
    if(data.indexOf("exposure_*") >= 0){
        result += " *坡向";
    }

    return result;
}

function carbin(data) {
    var result = "";
    if(data.indexOf("vegetationPrimaryProductivity") >= 0){
        result += "植被净生产力";
    }
    if(data.indexOf("storageOfSoilOrganicCarbon") >= 0){
        result += " 土壤有机碳储量";
    }

    return result;
}
