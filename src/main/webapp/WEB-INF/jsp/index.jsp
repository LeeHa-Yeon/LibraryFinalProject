<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/05/29
  Time: 4:16 오후
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/custom.min.css">
    <title> hayeon final Project </title>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href=""> <img src = "./image/logo.png" width="120" height="50" alt=""><span style="color:#FFFFFF;"></span></a>

    <div id="navbar" class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="./"> <span style="color:#FFFFFF;">WELCOME</span></a><%--Anchor(닻)문서내 이동 혹은 링크를 통해 다른 홈페이지로 이동--%>
            </li>
        </ul>
    </div>
</nav>

<center>
    <div class="container" style="padding-top: 180px">
        <h1> HAYEON Library</h1><br>
        2017301063 이하연 스프링 기말 텀 프로젝트<br><br>
        <img src = "./image/hi.png" alt="">
    </div>

    <div class="navbar-nav align-top= col-3" style="padding-top: 40px">
        <input type=button value=이용하기 id=loginBtn>
        <script type="text/javascript">
            document.getElementById("loginBtn").onclick = function() {
                location.href = 'login'; //페이지 이동문법
            }
        </script>
    </div>
</center>

<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>

</body>
</html>

