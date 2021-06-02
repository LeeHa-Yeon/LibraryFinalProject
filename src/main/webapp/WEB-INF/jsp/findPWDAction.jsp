<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/05/31
  Time: 3:43 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="finalTermProject.DAO.UserDao" %>
<%@ page import="finalTermProject.DTO.UserDto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/custom.min.css">
    <title> login page </title>
</head>

<body>
<%
    UserDao userDao = new UserDao();
    String findPWD = userDao.findPWD(request.getParameter("inputID"),request.getParameter("inputPhone"),request.getParameter("inputSSN"));
    System.out.println(findPWD);

%>
<nav class="navbar navbar-expand-lg navbar-light bg-dark">
    <a class="navbar-brand" href="./login"> <img src="./logo.png" width="120" height="50" alt=""><span
            style="color:#FFFFFF;"></span></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar"></button>

    <div id="navbar" class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="./login"> <span style="color:#FFFFFF;">HAYON LIBRARY</span></a><%--Anchor(닻)문서내 이동 혹은 링크를 통해 다른 홈페이지로 이동--%>
            </li>
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown"><%--dropdown 버튼인데 아래쪽에 목록이 보이는 버튼--%>
                <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown"><%--토글(누르면 사리지고 생기는 것)--%>
                    <span style="color:#FFFFFF;">LOGIN</span>
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdown">
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
        <div class="col-lg-10">
            <div class="jumbotron" style="padding-top: 40px; height: 550px">
                <h3 style="text-align: center; ">회원 계정 찾기</h3>
                <div class="jumbotron float-left col-md-4" style="padding-top: 40px; margin-top: 30px; margin-left: 60px; background-color: #ced4da">
                    <form method="post" action="findIDAction">
                        <h4 style="text-align: center; ">아이디 찾기</h4>
                        <div>
                            <div class="form-group" style="padding-top: 35px">
                                <input type="text" class="form-control" placeholder="이름" name="inputName"
                                       maxlength="20">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="전화번호" name="inputPhone"
                                       maxlength="20">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="주민등록번호" name="inputSSN"
                                       maxlength="20">
                            </div>
                            <div class="row">
                                <div class="col-sm-12 text-center">
                                    <input type="submit" class="btn btn-dark form-control" value="찾기"
                                           Style="width: 100px;">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <%--                비밀번호 찾기--%>
                <div class="jumbotron float-left col-md-4" style="padding-top: 40px; margin-top: 30px; margin-left: 60px; background-color: #ced4da">
                    <form method="post" action="login">
                        <h4 style="text-align: center; ">비밀번호 찾기</h4>
                        <div>
                            <div class="form-group" style="padding-top: 35px">
                                <h6><%=request.getParameter("inputID")+"의 비밀번호"%></h6>
                                <br>
                                <h4 style="color:#ba8b00"><%=findPWD%></h4>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 text-center" style="padding-top: 25px;">
                                    <input type="submit" class="btn btn-dark form-control" value="로그인"
                                           Style="width: 100px;">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</center>
<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>

