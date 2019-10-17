<%--

    5班荣誉榜单 - 简单版，其中通过扫描webapp下的榜单文件夹名字实现的

    一个榜最好八个图片

    将其部署到tomcat的ROOT下即可运行

    !author magiclu550

--%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.FileInputStream" %>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="zh">
<%
    Properties properties = new Properties();
    properties.load(new InputStreamReader(new FileInputStream(application.getRealPath("top.properties")),"UTF-8"));
%>
<head>
    <meta charset="UTF-8">

    <title><%=properties.getProperty("html.head.title")%></title>
    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="bootstrap.min.js"></script>
    <script type="text/javascript">
        // 如果想要使一个元素运动起来，一般情况下这个元素须要具有position属性absolute/relative
        $(function(){
            var oul = $('.wrap ul');
            var oulHtml = oul.html();
            oul.html(oulHtml+oulHtml);
            var timeId = null;

            var ali = $('.wrap ul li');
            var ulWidth = 0;

            for(var index = 0;index<ali.size();index++){

                ulWidth+=ali.eq(index).width();
            }
            var wrap = $(".wrap");
            oul.width(ulWidth);	//1600px

            var speed = 2;

            function slider(){

                if(speed<0){
                    if(oul.css('left')==-ulWidth/2+'px'){
                        oul.css('left',0);
                    }
                    oul.css('left','+=-2px');
                }


                if(speed>0){
                    if(oul.css('left')=='0px'){
                        oul.css('left',-ulWidth/2+'px');
                    }
                    oul.css('left','+='+speed+'px');
                }

            }

            // setInterval()函数的作用是：每隔一段时间，执行该函数里的代码
            timeId = setInterval(slider,30);

            wrap.mouseover(function(){
                // clearInterval()函数的作用是用来清除定时器
                clearInterval(timeId);
            });

            wrap.mouseout(function(){
                timeId = setInterval(slider,30);
            });

            $('.goLeft').click(function(){
                speed=-2;
            });

            $('.goRight').click(function(){
                speed=2;
            });

        });
    </script>
    <style type="text/css">
        @import "index.css";
        header #title{
            text-align: center;
            font-size: 100px;
        }
        #control{
            text-align: center;
            color: brown;
            border: blanchedalmond 1px;
        }
    </style>

</head>
<body>
    <!-- 头部的部分 -->
    <header>
        <p id="title"><%=properties.getProperty("html.body.header.div")%></p>
    </header>
    <!-- 正文部分 -->
    <article>

        <div class="warps">
            <div id="control">
                <a href="javascript:" class="goLeft">向左走</a>
                <a href="javascript:" class="goRight">向右走</a>
            </div>
            <%
                String classFilePath = application.getRealPath("images");
                File file = new File(classFilePath);
                File[] files = file.listFiles();
                if(files!=null) {
                    for (File f : files) {
            %>
                        <p style="text-align: center;font-size: 20px"><%=f.getName()%></p>
                        <br>
                        <br>
                        <div class="wrap">

                            <ul>
                                <%
                                    File[] images = f.listFiles();
                                    if(images!=null) {
                                        for (File img : images) {
                                %>
                                            <li>
                                                <p><%=img.getName().split("\\.")[0]%></p>
                                                <img src="images/<%=f.getName()+"/"+img.getName()%>" alt="<%=img.getName().split("\\.")[0]%>">
                                            </li>
                                <%
                                        }
                                    }
                                %>
                            </ul>
                        </div>
            <%
                    }
                }
            %>
            <!-- 此时这里要循环写图片和内容 -->
        </div>

    </article>
    <!-- 脚步的部分 -->
        @CopyRight noyark-system java server page<br>
        @author magiclu550<br>
        @created 30'<br>
        源代码: https://github.com/MagicLu550/05_top_list_simple
    <footer>

    </footer>
</body>
</html>