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
    <meta name="viewport" content="width=device-width",initial-scale="1">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <title> hayeon final Project </title>
</head>

<body>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<center>
    <h1> 스프링 기말 텀 프로젝트</h1>
    하연이의 도서관 홈페이지<br><br>
    <input type=button value=입장하기 id=loginBtn>
    <script type="text/javascript">
        document.getElementById("loginBtn").onclick = function() {
            location.href = 'login'; //페이지 이동문법
        }
    </script>
</center>
</body>
</html>