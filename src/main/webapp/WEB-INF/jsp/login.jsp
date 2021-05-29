<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/05/29
  Time: 5:37 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width",initial-scale="1">
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <title> login page </title>
</head>

<body>
    <nav class = "navbar navbar-default">
        <div class = "navbar-header">
            <button type = "button" class ="navbar-toggle collapsed"
                    data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main">jsp 게시판 웹 사이트</a>
        </div>
        <div class="collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main">메인</a></li>
                <li><a href="bbs">게시판</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class = "dropdown-toggle"
                       data-toggle="dropdown" role="button" aria-haspopup="true"
                       aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li class="active"><a href="login">로그인</a> </li>
                        <li><a href="join">회원가입</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/popper.js>"</script>
    <script src="./js/bootstrop.min.js"></script>
</body>
</html>
