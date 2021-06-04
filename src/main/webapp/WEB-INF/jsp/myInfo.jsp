<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/05/31
  Time: 8:58 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="finalTermProject.DAO.UserDao" %>
<%@ page import="finalTermProject.DTO.UserDto" %>
<%@ page import="org.apache.catalina.User" %>

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
    UserDao userDao = new UserDao();
    String userID = null;
    UserDto myInfo = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('Please log in.');");
        script.println("location.href='login'");
        script.println("</script>");
        script.close();
    } else {
        myInfo = userDao.getUserInfo(userID);
    }

    if (myInfo.getPoint()>=100){
        userDao.changeGrade(userID,"우수회원");
    }
    else if(myInfo.getPoint()<100 && myInfo.getPoint()>=0){
        userDao.changeGrade(userID,"일반회원");
    }else{
        userDao.changeGrade(userID,"블랙회원");
    }
%>

<nav class="navbar navbar-expand-lg navbar-light bg-dark">
    <a class="navbar-brand" href=""> <img src="./logo.png" width="120" height="50" alt=""><span
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
                    <a class="dropdown-item" href="myInfo?myID=">내 정보 보기</a>
                    <a class="dropdown-item" href="changePwd">비밀번호 변경</a>
                    <a class="dropdown-item" href="myLendList">내 대여 상태</a>
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
        <table class="table table-striped" style="padding-top: 40px; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th colspan="3" style="background-color: #ced4da; text-align: center;">내 정보 보기</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td style="width: 35%; text-align: center;">회원등급</td>
                <td style="text-align: left;" colspan="2"><%=myInfo.getGrade()%>
                </td>
            </tr>
            <tr>
                <td style="width: 35%; text-align: center;">아이디</td>
                <td style="text-align: left;" colspan="2"><%=myInfo.getID()%>
                </td>
            </tr>
            <tr>
                <td style="width: 35%; text-align: center;">이름</td>
                <td style="text-align: left;" colspan="2"><%=myInfo.getName()%>
                </td>
            </tr>
            <tr>
                <td style="width: 35%; text-align: center;">이메일</td>
                <td style="text-align: left;" colspan="2"><%=myInfo.getEmail()%>
                </td>
            </tr>
            <tr>
                <td style="width: 35%; text-align: center;">번호</td>
                <td style="text-align: left;" colspan="2"><%=myInfo.getPhone()%>
                </td>
            </tr>
            <tr>
                <td style="width: 35%; text-align: center;">SSN</td>
                <td style="text-align: left;" colspan="2"><%=myInfo.getSSN()%>
                </td>
            </tr>
            <tr>
                <td style="width: 35%; text-align: center;">주소</td>
                <td style="text-align: left;" colspan="2"><%=myInfo.getAddress()%>
                </td>
            </tr>
            <tr>
                <td style="width: 35%; text-align: center;">포인트</td>
                <td style="text-align: left;" colspan="2"><%=myInfo.getPoint()%>
                </td>
            </tr>
            <tr>
                <td style="width: 35%; text-align: center;">상태</td>
                <%
                    if (myInfo.getIsOverdue().equals("정상")) {
                %>
                <td style="text-align: left;" colspan="2"><%=myInfo.getIsOverdue()%></td>
                <%
                } else {
                %>
                <td style="text-align: left;" colspan="2">연체 : <%=myInfo.getIsOverdue()%>까지 빌릴 수 없습니다.</td>
                <%
                    }
                %>
            </tr>
            <tr>
                <td style="width: 35%; text-align: center;">빌릴 수 있는 횟수</td>
                <td style="text-align: left;" colspan="2"><%=myInfo.getBorrowedLimit()%>
                </td>
            </tr>
            </tbody>
        </table>
        <%
            if (userID != null && userID.equals(myInfo.getID())) {
        %>
        <a href="modifyInfo?userID=<%=userID%>" class="btn btn-dark float-none mr-auto">정보 수정</a>

        <%
            }
        %>
    </div>

</div>

<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>







