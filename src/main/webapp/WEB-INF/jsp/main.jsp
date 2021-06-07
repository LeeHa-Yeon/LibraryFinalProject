<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/05/29
  Time: 6:36 오후
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="finalTermProject.DAO.BookDao" %>
<%@ page import="finalTermProject.DTO.BookDto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="finalTermProject.DTO.UserDto" %>
<%@ page import="finalTermProject.DAO.LibraryDao" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/custom.min.css">
    <title> 메인 page </title>
    <style type="text/css">
        a, a:hover {
            color: #004085;
            text-decoration: none;
        }
    </style>
</head>

<body>
<%
    String userID = null;
    BookDao bookDao = new BookDao();
    LibraryDao libraryDao = new LibraryDao();

    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
%>

<nav class="navbar navbar-expand-lg navbar-light bg-dark">
    <a class="navbar-brand" href=""> <img src="./image/logo.png" width="120" height="50" alt=""><span
            style="color:#FFFFFF;"></span></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar"></button>

    <div id="navbar" class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li>
                <a class="nav-link" href="./main"> <span style="color:#FFFFFF;">HAYON LIBRARY</span></a><%--Anchor(닻)문서내 이동 혹은 링크를 통해 다른 홈페이지로 이동--%>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="./bookList"> <span style="color:#FFFFFF;">도서목록</span></a>
            </li>
            <li>
                <a class="nav-link" href="./applyList"> <span style="color:#FFFFFF;">신청목록</span></a><%--Anchor(닻)문서내 이동 혹은 링크를 통해 다른 홈페이지로 이동--%>
            </li>
        </ul>


        <%
            if (userID == null) {
        %>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown"><%--dropdown 버튼인데 아래쪽에 목록이 보이는 버튼--%>
                <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown"><%--토글(누르면 사리지고 생기는 것)--%>
                    <span style="color:#FFFFFF;">LOGIN</span>
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdown">
                    <a class="dropdown-item" href="login">로그인</a>
                    <a class="dropdown-item" href="join">회원가입</a>
                </div>
            </li>
        </ul>
        <%
        } else {
        %>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown"><%--dropdown 버튼인데 아래쪽에 목록이 보이는 버튼--%>
                <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown"><%--토글(누르면 사리지고 생기는 것)--%>
                    <span style="color:#FFFFFF;">마이페이지</span>
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdown">
                    <a class="dropdown-item" href="myInfo">내 정보 보기</a>
                    <a class="dropdown-item" href="changePwd">비밀번호 변경</a>
                    <a class="dropdown-item" href="myLendList">나의 서재</a>
                    <a class="dropdown-item" href="logout">로그아웃</a>
                    <a class="dropdown-item" href="signout">회원 탈퇴</a>

                </div>
            </li>
        </ul>
        <%
            }
        %>
    </div>
</nav>

<div class="container" style="padding-top: 50px">

    <div class="row">
        <div class="col" >
            <h3 align="center"> 인기 도서 Top5 </h3>
            <p style="margin-bottom: 10px" align="right"> 대여를 많이 한 순서 </p>
        </div>

        <table class="table table-striped" style="text-align: center; padding-top: 40px; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="background-color: #ced4da; text-align: center;">순위</th>
                <th style="background-color: #ced4da; text-align: center;">제목</th>
                <th style="background-color: #ced4da; text-align: center;">저자</th>
                <th style="background-color: #ced4da; text-align: center;">상태</th>
                <th style="background-color: #ced4da; text-align: center;">대여수</th>
            </tr>
            </thead>
            <tbody>
            <%
                ArrayList<BookDto> popularList = libraryDao.popularBookTop5();
                for (int i = 0; i < popularList.size(); i++) {
            %>
            <tr>
                <td><%= i + 1 %>위
                </td>
                <%
                    if (bookDao.getDate().substring(0, 10).equals(popularList.get(i).getRegisteDate().substring(0, 10))) {
                %>
                <td>
                    <a href="bookShow?num=<%=popularList.get(i).getBook_num()%>"><%= popularList.get(i).getBook_title()%>
                        <img
                                src="./image/new.png" width="25" height="25" alt="">

                    </a></td>
                <%
                } else {
                %>
                <td class="clickTitle"><a
                        href="bookShow?num=<%=popularList.get(i).getBook_num()%>"><%= popularList.get(i).getBook_title()%>
                </a>

                </td>

                <%
                    }
                %>

                <td><%= popularList.get(i).getBook_author()%>
                </td>
                <td><%= popularList.get(i).getIs_book_borrowed()%>
                </td>
                <td><%= popularList.get(i).getLendCnt()%>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

    </div>
    <hr>

    <div class="row">
        <div class="col" style="margin-top: 10px">
            <h3 align="center"> 추천 도서 Top3 </h3>
            <p style="margin-bottom: 10px" align="right"> 추천을 많이 받은 순서 </p>
        </div>
        <table class="table table-striped" style="text-align: center; padding-top: 40px; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="background-color: #ced4da; text-align: center;">순위</th>
                <th style="background-color: #ced4da; text-align: center;">제목</th>
                <th style="background-color: #ced4da; text-align: center;">저자</th>
                <th style="background-color: #ced4da; text-align: center;">상태</th>
                <th style="background-color: #ced4da; text-align: center;">추천수</th>
            </tr>
            </thead>
            <tbody>
            <%
                ArrayList<BookDto> recommendList = libraryDao.recommendedBookTop3();
                for (int i = 0; i < recommendList.size(); i++) {
            %>
            <tr>
                <td><%= i + 1 %>위
                </td>
                <%
                    if (bookDao.getDate().substring(0, 10).equals(popularList.get(i).getRegisteDate().substring(0, 10))) {
                %>
                <td>
                    <a href="bookShow?num=<%=recommendList.get(i).getBook_num()%>"><%= recommendList.get(i).getBook_title()%>
                        <img src="./image/new.png" width="25" height="25" alt="">

                    </a></td>
                <%
                } else {
                %>
                <td class="clickTitle"><a
                        href="bookShow?num=<%=recommendList.get(i).getBook_num()%>"><%= recommendList.get(i).getBook_title()%>
                </a>

                </td>

                <%
                    }
                %>

                <td><%= recommendList.get(i).getBook_author()%>
                </td>
                <td><%= recommendList.get(i).getIs_book_borrowed()%>
                </td>
                <td><%= recommendList.get(i).getLikes()%>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

    </div>
    <hr>
    <div class="row" style="margin-bottom: 100px">
        <div class="col" style="margin-top: 10px">
            <h3 align="center"> 우수 회원 Top3 </h3>
            <p style="margin-bottom: 10px" align="right"> 도서를 가장 많이한 회원 </p>
        </div>
        <table class="table table-striped" style="text-align: center; padding-top: 40px; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="background-color: #ced4da; text-align: center;">순위</th>
                <th style="background-color: #ced4da; text-align: center;">아이디</th>
                <th style="background-color: #ced4da; text-align: center;">이름</th>
                <th style="background-color: #ced4da; text-align: center;">회원등급</th>
                <th style="background-color: #ced4da; text-align: center;">포인트</th>
            </tr>
            </thead>
            <tbody>
            <%
                ArrayList<UserDto> excellentUserInfo = libraryDao.ExcellentUserTop3();
                for (int i = 0; i < excellentUserInfo.size(); i++) {
            %>
            <tr>
                <td><%= i + 1 %>위
                </td>
                <td><%= excellentUserInfo.get(i).getID()%> 님
                </td>
                <td><%= excellentUserInfo.get(i).getName()%>
                </td>
                <td><%= excellentUserInfo.get(i).getGrade()%>
                </td>
                <td><%= excellentUserInfo.get(i).getPoint()%>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

    </div>

</div>

<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
