<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/05/29
  Time: 6:36 오후
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="finalTermProject.DTO.UserDto" %>
<%@ page import="finalTermProject.DAO.UserDao" %>
<%@ page import="finalTermProject.DAO.BookDao" %>

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
        <h3> 모든 고객 정보 리스트  </h3>
        <br>
        <table colspan="18" class = "table table-striped" style="text-align: center; padding-top: 40px; border: 1px solid #dddddd">
            <thead>
            <tr>

                <th style="background-color: #ced4da; text-align: center;">번호</th>
                <th style="background-color: #ced4da; text-align: center;">회원 ID</th>
                <th style="background-color: #ced4da; text-align: center;">회원 PWD</th>
                <th style="background-color: #ced4da; text-align: center;">회원 이름</th>
                <th style="background-color: #ced4da; text-align: center;">회원 이메일</th>
                <th style="background-color: #ced4da; text-align: center;">회원 번호</th>
                <th style="background-color: #ced4da; text-align: center;">회원 주소</th>
                <th style="background-color: #ced4da; text-align: center;">회원 상태</th>
                <th style="background-color: #ced4da; text-align: center;">회원 가입날짜</th>
                <th style="background-color: #ced4da; text-align: center;">회원 등급</th>
                <th style="background-color: #ced4da; text-align: center;">삭제</th>
            </tr>
            </thead>
            <tbody>
            <%
                UserDao userDao = new UserDao();
                ArrayList<UserDto> list = userDao.allUserInfo(pageNumber);
                for (int i = 0; i < list.size(); i++) {
            %>
            <tr>
                <td><%=i+1%></td>
                <td><%= list.get(i).getID()%></td>
                <td><%= list.get(i).getPwd()%></td>
                <td><%= list.get(i).getName()%></td>
                <td><%= list.get(i).getEmail()%></td>
                <td><%= list.get(i).getPhone()%></td>
                <td><%= list.get(i).getAddress()%></td>
                <td><%= list.get(i).getIsOverdue()%></td>
                <td><%= list.get(i).getREGDATE().substring(0,10)%></td>
                <td><%= list.get(i).getGrade()%></td>
                <td><a onclick="return confirm('삭제하시겠습니까 ?')" href="deleteUser?id=<%=list.get(i).getID()%>" class="btn btn-outline-danger pull-right " style="margin:0px auto">삭제</a>
                </td>
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
            <a href="managerUserList?pageNumber=<%=pageNumber-1%>" class="btn btn-success btn-arraw-left"><</a>
            <%
                }
                BookDao bookDao = new BookDao();
                if (bookDao.nextPage(pageNumber + 1)) {
            %>
            <a href="managerUserList?pageNumber=<%=pageNumber+1%>" class="btn btn-success btn-arraw-left">></a>
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


