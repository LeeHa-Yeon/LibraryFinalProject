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
<%@ page import="finalTermProject.DTO.LendDto" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/custom.min.css">
    <title> login page </title>
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
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    int pageNumber = 1;
    if (request.getParameter("pageNumber") != null) {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    }
%>

<nav class="navbar navbar-expand-lg navbar-light bg-dark">
    <a class="navbar-brand" href=""> <img src="./logo.png" width="120" height="50" alt=""><span
            style="color:#FFFFFF;"></span></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar"></button>

    <div id="navbar" class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li>
                <a class="nav-link" href="./managerMain"> <span style="color:#FFFFFF;">HAYON LIBRARY</span></a><%--Anchor(닻)문서내 이동 혹은 링크를 통해 다른 홈페이지로 이동--%>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="./managerMain"> <span style="color:#FFFFFF;">전체도서목록</span></a>
            </li>
            <li>
                <a class="nav-link" href="./managerUserApplyList"> <span style="color:#FFFFFF;">고객신청목록</span></a><%--Anchor(닻)문서내 이동 혹은 링크를 통해 다른 홈페이지로 이동--%>
            </li>
            <li>
                <a class="nav-link" href="./managerUserLendList"> <span style="color:#FFFFFF;">고객대여목록</span></a><%--Anchor(닻)문서내 이동 혹은 링크를 통해 다른 홈페이지로 이동--%>
            </li>
            <li>
                <a class="nav-link" href="./managerUserList"> <span style="color:#FFFFFF;">모든고객관리</span></a><%--Anchor(닻)문서내 이동 혹은 링크를 통해 다른 홈페이지로 이동--%>
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
                    <span style="color:#FFFFFF;">관리자</span>
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdown">
                    <a class="dropdown-item" href="managerInfo">내 정보 보기</a>
                    <a class="dropdown-item" href="changePwd">비밀번호 변경</a>
                    <a class="dropdown-item" href="logout">로그아웃</a>

                </div>
            </li>
        </ul>
        <%
            }
        %>
    </div>
</nav>

<div class = "container" style="padding-top: 50px">
    <div class="row">
        <h3> 고객 빌린 도서 목록 </h3>
        <table class = "table table-striped" style="text-align: center; padding-top: 40px; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="background-color: #ced4da; text-align: center;">도서번호</th>
                <th style="background-color: #ced4da; text-align: center;">도서제목</th>
                <th style="background-color: #ced4da; text-align: center;">빌린사람</th>
                <th style="background-color: #ced4da; text-align: center;">빌린날짜</th>
                <th style="background-color: #ced4da; text-align: center;">반납날짜</th>
            </tr>
            </thead>
            <tbody>
            <%
                BookDao bookDao = new BookDao();
                ArrayList<LendDto> list = bookDao.allLendInfo(pageNumber);
                for (int i = 0; i < list.size(); i++) {
            %>
            <tr>
                <td><%= list.get(i).getLend_book_id()%></td>
                <td><%= list.get(i).getLend_book_title()%></td>
                <td><%= list.get(i).getLend_user_id()%></td>
                <td><%= list.get(i).getLend_date().substring(0,11)%></td>
                <td><%= list.get(i).getReturn_date().substring(0,11)%></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <div style="margin: 10px auto">
            <%
                if (pageNumber != 1) {
            %>
            <a href="managerUserLendList?pageNumber=<%=pageNumber-1%>" class="btn btn-success btn-arraw-left"><</a>
            <%
                }
                if (bookDao.nextPage(pageNumber + 1)) {
            %>
            <a href="managerUserLendList?pageNumber=<%=pageNumber+1%>" class="btn btn-success btn-arraw-left">></a>
            <%
                }
            %>
        </div>
    </div>

</div>

<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>


