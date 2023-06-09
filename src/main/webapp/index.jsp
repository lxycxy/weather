<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Import style -->
    <link rel="stylesheet" href="//unpkg.com/element-plus/dist/index.css" />
    <!-- Import Vue 3 -->
    <script src="//unpkg.com/vue@3"></script>
    <!-- Import component library -->
    <script src="//unpkg.com/element-plus"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>

    <script type="text/javascript" src="https://cdn.jsdelivr.net/gh/Ukenn2112/UkennWeb@3.0/index/web.js"></script>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no;"/>
    <link rel="icon" href="res/favicon.ico">
    <title>天气实时查询系统</title>

</head>
<body>
<!-- 网页鼠标点击特效（爱心） -->
<script type="text/javascript">
    ! function (e, t, a) {
        function r() {
            for (var e = 0; e < s.length; e++) s[e].alpha <= 0 ? (t.body.removeChild(s[e].el), s.splice(e, 1)) : (s[
                e].y--, s[e].scale += .004, s[e].alpha -= .013, s[e].el.style.cssText = "left:" + s[e].x +
                "px;top:" + s[e].y + "px;opacity:" + s[e].alpha + ";transform:scale(" + s[e].scale + "," + s[e]
                    .scale + ") rotate(45deg);background:" + s[e].color + ";z-index:99999");
            requestAnimationFrame(r)
        }

        function n() {
            var t = "function" == typeof e.onclick && e.onclick;
            e.onclick = function (e) {
                t && t(), o(e)
            }
        }

        function o(e) {
            var a = t.createElement("div");
            a.className = "heart", s.push({
                el: a,
                x: e.clientX - 5,
                y: e.clientY - 5,
                scale: 1,
                alpha: 1,
                color: c()
            }), t.body.appendChild(a)
        }

        function i(e) {
            var a = t.createElement("style");
            a.type = "text/css";
            try {
                a.appendChild(t.createTextNode(e))
            } catch (t) {
                a.styleSheet.cssText = e
            }
            t.getElementsByTagName("head")[0].appendChild(a)
        }

        function c() {
            return "rgb(" + ~~(255 * Math.random()) + "," + ~~(255 * Math.random()) + "," + ~~(255 * Math
                .random()) + ")"
        }
        var s = [];
        e.requestAnimationFrame = e.requestAnimationFrame || e.webkitRequestAnimationFrame || e
            .mozRequestAnimationFrame || e.oRequestAnimationFrame || e.msRequestAnimationFrame || function (e) {
            setTimeout(e, 1e3 / 60)
        }, i(
            ".heart{width: 10px;height: 10px;position: fixed;background: #f00;transform: rotate(45deg);-webkit-transform: rotate(45deg);-moz-transform: rotate(45deg);}.heart:after,.heart:before{content: '';width: inherit;height: inherit;background: inherit;border-radius: 50%;-webkit-border-radius: 50%;-moz-border-radius: 50%;position: fixed;}.heart:after{top: -5px;}.heart:before{left: -5px;}"
        ), n(), r()
    }(window, document);
</script>


<div id="app">

    <div class="left-card">

    </div>
    <el-row :gutter="20">
        <el-col :span="8">
            <el-card class="box-card" shadow="always">
                <div class="city-info">
                    <span style="font-size: 15px;">目前城市</span>
                    <span style="font-size: 20px;font-weight:bold;margin-left: 15px">{{ value }}</span>
                    <el-popover :visible="visible" placement="bottom" :width="400" style="text-align: center">
                        <template #reference>
                            <el-button @click="visible = true" style="margin-left: 20px" text>切换城市</el-button>
                        </template>
                        <p style="font-size: 15px">请选择您的城市</p>
                        <div style="margin-top: 20px">
                            <el-cascader v-model="city" :options="options" :width="300" ></el-cascader>
                            <el-button @click="handleClose" style="margin-left: 10px">取消</el-button>
                            <el-button type="primary" @click="handleEnter" style="margin-left: 10px">确认</el-button>
                        </div>
                    </el-popover>
                </div>

                <div class="weather-info">
                    <el-row :gutter="20">
                        <el-col :span="8">
                            <span style="font-size: 35px; margin-left: 10px">{{ weatherInfo.temp }} °</span>
                        </el-col>
                        <el-col :span="16" style="text-align: center">
                            <img :src="weatherInfo.icon" alt="QWeather" width="32" height="32">
                            <br/>
                            <span> {{ weatherInfo.text }}</span>
                        </el-col>
                    </el-row>
                    <el-row :gutter="20" style="margin-top: 20px;">
                        <el-col :span="8"> 湿度 {{weatherInfo.humidity}} % </el-col>
                        <el-col :span="8"> 风向 {{weatherInfo.windDir}} </el-col>
                        <el-col :span="8"> 更新时间 {{weatherInfo.updateTime}}</el-col>
                    </el-row>
                    <el-divider>
                    </el-divider>
                    <h3>{{value}}生活指数</h3>
                    <el-divider>
                    </el-divider>
                    <el-row :gutter="20" style="margin-top: 50px">
                        <el-col :span="8">
                            <div class="img-box">
                                <img src="res/clothes.png" width="64" height="64"><br>
                                <span>穿衣指数</span><br>
                                <span>{{daily.clothes}}</span>
                            </div>
                        </el-col>
                        <el-col :span="8">
                            <div class="img-box">
                                <img src="res/icons/air.png" width="64" height="64"><br>

                                <span>空气指数</span><br>
                                <span>{{daily.air}}</span>
                            </div>
                        </el-col>
                        <el-col :span="8">
                            <div class="img-box">
                                <img src="res/cold.png" width="64" height="64"><br>
                                <span>感冒指数</span><br>
                                <span>{{daily.cold}}</span>
                            </div>
                        </el-col>
                    </el-row>
                    <el-row :gutter="20" style="margin-top: 30px">
                        <el-col :span="8">
                            <div class="img-box">
                                <img src="res/car.png" width="64" height="64"><br>
                                <span>洗车指数</span><br>
                                <span>{{daily.car}}</span>
                            </div>
                        </el-col>
                        <el-col :span="8">
                            <div class="img-box">
                                <img src="res/run.png" width="64" height="64"> <br>
                                <span>运动指数</span> <br>
                                <span>{{daily.run}}</span>
                            </div>
                        </el-col>
                        <el-col :span="8">
                            <div class="img-box">
                                <img src="res/sun.png" width="64" height="64"><br>
                                <span>紫外线长度</span> <br>
                                <span>{{daily.sun}}</span>
                            </div>
                        </el-col>
                    </el-row>
                </div>
            </el-card>
        </el-col>
        <el-col :span="16">
            <el-card class="box-card-weather" shadow="always">
                <template #header>
                    <span style="font-size: 30px;font-weight: bold">七日天气预报</span>
                </template>
                <div class="weather-content">
                    <ul style="list-style-type: none">
                        <li class="day-list" v-for="(day, index) in weatherdays" :key="index">
                            <img :src=" 'res/icons/' + day.iconDay + '.svg' " style="width: 45px;height: 45px;">
                            <p>{{day.fxDate.substr(5, 2) + "月" + day.fxDate.substr(8, 10) + "日"}} </p>
                            <p> {{ day.textDay}}</p>

                            <img :src=" 'res/icons/' + day.iconNight + '.svg' " style="width: 45px;height: 45px; margin-top: 200px">
                            <p> {{ day.textNight}}</p>
                            <p style="font-size: smaller"> {{day.windDirDay}} {{day.windScaleDay}}级</p>
                        </li>
                    </ul>
                    <canvas id="charts" width="1400" height="400"
                            style="position: absolute;left: 500px;right: 0px;top: 200px;overflow: visible">
                    </canvas>
                </div>
            </el-card>
        </el-col>
    </el-row>
</div>
<style>
    #app{
        margin-left: 10%;
        margin-right: 10%;
        margin-top: 5%;
        width: 1350px;
        height: 1000px;
    }
    .box-card{
        height: 600px;
        border-radius: 20px;
    }

    .box-card-weather {
        height: 600px;
        border-radius:20px;
    }

    body {
        background-color: #F6F6F6;
        background-image: url("res/background.jpg");
        background-size: 100%;
    }
    .weather-info {
        margin-top: 20px;
    }
    .img-box {
        text-align: center;
    }
    .day-list{
        display: inline;
        float: left;
        margin-right: 15px;
        padding-left: 0px;
        width:100px;
        height: 500px;
        text-align: center;
        align-items: center;
    }

</style>

<script>
    const { createApp,reactive,ref} = Vue;
    const vue3Composition = {
        setup() {
            let weatherInfo = reactive({
                temp:'',
                icon:'',
                humidity:'',
                text:'',
                updateTime:'',
                windDir:'',

            });
            let weatherdays = ref(null);
            let daily = reactive({
                car:'',
                run:'',
                sun:'',
                cold:'',
                air:'',
                clothes:'',
            });
            let visible = ref(false);
            let city = ref([]);
            let value = ref("江津区");
            const options = ref([]);
            const cities = ref([]);

            const handleClose = () => {
                visible.value = false;
            };
            const handleEnter = () => {
                visible.value = false;
                value.value = city.value[city.value.length - 1];
                refreshWeatherInfo();
            };

            // 城市选择器
            const getCity = () => {
                axios({
                    url:"/weather-1.0-SNAPSHOT/getcity",
                    method: "GET"
                }).then((resp) => {
                    cities.value = resp.data;
                    for(let province of cities.value) {
                        let myprovince = {'value':province.province_name, 'label':province.province_name, 'children':[]};
                        for(let city of province.city) {
                            let mycity = {'value':city.district_name,'label':city.city_name, 'children':[]};
                            for(let district of city.district) {
                                mycity.children.push({'value':district.district_name,'label':district.district_name});
                            }
                            myprovince.children.push(mycity);
                        }
                        options.value.push(myprovince);
                    }
                    refreshWeatherInfo();
                })
            };
            getCity();

            const refreshCharts = () => {
                let canvas = document.getElementById("charts");
                let ctx = canvas.getContext('2d');

                // 清空画布内容
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                // 找取最大、最小值
                let max = parseInt("-1"), min = parseInt("100");
                for(let i = 0; i < weatherdays.value.length; i ++) {
                    let day = weatherdays.value[i];
                    if(parseInt(day.tempMin) < min) min = parseInt(day.tempMin);
                    if(parseInt(day.tempMax) > max) max = parseInt(day.tempMax);
                }

                // 计算每一度的间隔
                let interval = 120 / (max - min);


                // 绘点
                for(let i = 0; i < weatherdays.value.length; i ++) {

                    let day = weatherdays.value[i];
                    ctx.beginPath();
                    ctx.font = "normal 15px Verdana";
                    ctx.fillStyle = '#FCC370';
                    ctx.fillText(day.tempMax + "°", 80 + 115 * i, 180 - interval * parseInt(day.tempMax - min));
                    ctx.arc(80 + 115 * i, 200 - interval * parseInt(day.tempMax - min), 5,0, Math.PI * 2);
                    ctx.fill();

                    ctx.beginPath();
                    ctx.fillStyle = '#94CCF9';
                    ctx.font = "normal 15px Verdana";
                    ctx.fillText(day.tempMin + "°", 80 + 115 * i, 220 - interval * parseInt(day.tempMin - min));
                    ctx.arc(80 + 115 * i, 200 - interval * parseInt(day.tempMin - min), 5,0, Math.PI * 2);
                    ctx.fill();
                }


                // 绘制气温走势线
                ctx.beginPath()
                ctx.lineWidth = 3;
                ctx.strokeStyle = '#FCC370';
                for(let i = 0; i < weatherdays.value.length - 1; i ++) {
                    let day = weatherdays.value[i]; let nextday = weatherdays.value[i + 1];

                    ctx.moveTo(80 + 115 * i, 200 - interval * parseInt(day.tempMax - min));
                    ctx.lineTo(80 + 115 * (i + 1), 200 - interval * parseInt(nextday.tempMax - min))
                }
                ctx.stroke();

                ctx.beginPath()
                ctx.lineWidth = 3;
                ctx.strokeStyle = '#94CCF9';
                for(let i = 0; i < weatherdays.value.length - 1; i ++) {
                    let day = weatherdays.value[i]; let nextday = weatherdays.value[i + 1];
                    ctx.moveTo(80 + 115 * i, 200 - interval * parseInt(day.tempMin - min));
                    ctx.lineTo(80 + 115 * (i + 1), 200 - interval * parseInt(nextday.tempMin - min))
                }
                ctx.stroke();
            }

            const refreshWeatherInfo = () => {
                axios({
                    url:"https://geoapi.qweather.com/v2/city/lookup?&key=cecc28e842414680900682174892209c"
                        + "&location=" + value.value,
                    method: "GET",
                }).then((res) => {
                    // 请求实时天气
                    axios({
                        url: "https://devapi.qweather.com/v7/weather/now?location="
                            + res.data.location[0].id + "&key=cecc28e842414680900682174892209c",
                        method: "GET",
                    }).then((resp) => {
                        weatherInfo.temp = resp.data.now.temp;
                        weatherInfo.icon = "res/icons/" + resp.data.now.icon + ".svg";
                        weatherInfo.text = resp.data.now.text;
                        weatherInfo.humidity = resp.data.now.humidity;
                        weatherInfo.updateTime = resp.data.updateTime.substring(11, 16);
                        weatherInfo.windDir = resp.data.now.windDir;
                    });
                    // 请求生活指数
                    axios({
                        url: "https://devapi.qweather.com/v7/indices/1d?type=1,2,3,5,9,10&location="
                            + res.data.location[0].id + "&key=cecc28e842414680900682174892209c",
                        method: "GET",
                    }).then((resp) => {
                        daily.run = resp.data.daily[0].category;
                        daily.car = resp.data.daily[1].category;
                        daily.clothes = resp.data.daily[2].category;
                        daily.sun = resp.data.daily[3].category;
                        daily.cold = resp.data.daily[4].category;
                        daily.air = resp.data.daily[5].category;
                    })

                    // 请求七日天气

                    axios({
                        url:"https://devapi.qweather.com/v7/weather/7d?location="
                            + res.data.location[0].id + "&key=cecc28e842414680900682174892209c",
                        method:"GET",
                    }).then((resp) => {
                        weatherdays.value = resp.data.daily;
                        refreshCharts();
                    })


                })

            };

            return {
                visible,
                weatherInfo,
                value,
                options,
                city,
                daily,
                weatherdays,
                handleEnter,
                handleClose,
            }
        }
    }

    const app = createApp(vue3Composition).use(ElementPlus).mount('#app');
</script>
</body>
</html>

