<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/05/29
  Time: 6:36 오후
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
    <title> 회원가입 page </title>
</head>

<body>
<nav class="navbar navbar-expand-lg navbar-light bg-dark">
    <a class="navbar-brand" href="./login"> <img src = "./image/logo.png" width="120" height="50" alt=""><span style="color:#FFFFFF;"></span></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar"></button>

    <div id="navbar" class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="./login"> <span style="color:#FFFFFF;">HAYON LIBRARY</span></a><%--Anchor(닻)문서내 이동 혹은 링크를 통해 다른 홈페이지로 이동--%>
            </li>
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown" ><%--dropdown 버튼인데 아래쪽에 목록이 보이는 버튼--%>
                <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown"><%--토글(누르면 사리지고 생기는 것)--%>
                    <span style="color:#FFFFFF;">LOGIN</span>
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdown" >
                    <a class="dropdown-item" href="login">로그인</a>
                    <a class="dropdown-item" href="find_info">아이디/비번찾기</a>
                    <a class="dropdown-item" href="join">회원가입</a>
                </div>
            </li>
        </ul>
    </div>
</nav>
<center>
    <div class="container" style="padding-top: 80px">
        <div class="col-lg-8">
            <div class="jumbotron" style="padding-top: 40px">
                <form method="post" action="joinAction">
                    <h3 style="text-align: center; ">회원가입 화면</h3>
                    <div style="padding-right: 30px; padding-left: 30px;">
                        <div class="form-group" style="padding-top: 35px">
                            <input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" placeholder="비밀번호" name="userPWD" maxlength="20">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" placeholder="비밀번호 확인" name="userPwdCheck" maxlength="20">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
                        </div>
                        <div class="form-group">
                            <input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="전화번호" name="userPhone" maxlength="20">
                        </div>
                        <div class="form-group" >
                            <input type="text" class="form-control" placeholder="주민등록번호" name="userSSN" maxlength="20">
                        </div>
                        <div class="form-group" style="padding-bottom: 35px">
                            <input type="text" class="form-control" placeholder="주소" name="userAddress" maxlength="20">
                        </div>
                    </div>
                    <div class = "row">
                        <div class="col-sm-12 text-center">
                            <input type="submit" class="btn btn-dark form-control" value="가입" Style="width: 100px;">
                            <input type="reset" class="btn btn-dark form-control" value="취소"  Style="width: 100px;">
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</center>
<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
