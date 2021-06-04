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
<%@ page import="java.util.ArrayList" %>
<%@ page import="finalTermProject.DTO.ApplyDto" %>
<%@ page import="java.util.ArrayList" %>

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
    int pageNumber = 0;
    if (request.getParameter("pageNumber") != null) {
        try {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));

        } catch (Exception e) {
            System.out.println("검색페이지 번호 오류");
        }
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


<div class="container" style="padding-top: 50px">
    <div class="row">
        <div>
            <h3> 고객 도서 신청 리스트</h3>
        </div>
        <table class="table table-striped" style="text-align: center; padding-top: 40px; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="background-color: #ced4da; text-align: center;">번호</th>
                <th style="background-color: #ced4da; text-align: center;">책 제목</th>
                <th style="background-color: #ced4da; text-align: center;">저자</th>
                <th style="background-color: #ced4da; text-align: center;">신청자</th>
                <th style="background-color: #ced4da; text-align: center;">신청날짜</th>
                <th style="background-color: #ced4da; text-align: center;">완료날짜</th>
                <th style="background-color: #ced4da; text-align: center;">상태</th>
                <th style="background-color: #ced4da; text-align: center;">추가</th>
                <th style="background-color: #ced4da; text-align: center;">삭제</th>
            </tr>
            </thead>
            <tbody>
            <%
                BookDao bookDao = new BookDao();
                ArrayList<ApplyDto> list = bookDao.allApplyList(pageNumber);
                for (int i = 0; i < list.size(); i++) {
            %>
            <tr>
                <td><%=i + 1%>
                </td>
                <%
                    if (bookDao.getDate().substring(0, 10).equals(list.get(i).getApply_Date().substring(0, 10))) {
                %>
                <td><%= list.get(i).getApply_title()%><img src="./new.png" width="25" height="25" alt=""></td>
                <%
                } else {
                %>
                <td><%= list.get(i).getApply_title()%>
                </td>
                <%
                    }
                %>
                <td><%= list.get(i).getApply_author()%>
                </td>
                <td><%= list.get(i).getApply_userId()%>
                </td>
                <td><%= list.get(i).getApply_Date().substring(0, 10)%>
                </td>
                <td><%= list.get(i).getAccept_Date()%>
                </td>
                <td><%= list.get(i).getApply_state()%>
                </td>
                <td><a onclick="return confirm('등록하시겠습니까 ?')" href="managerApplyAdd?num=<%=list.get(i).getApply_num()%>"
                       class="btn btn-outline-danger pull-right mx-lg-5" style="margin:0px auto"></a>
                </td>
                <td><a onclick="return confirm('삭제하시겠습니까 ?')"
                       href="managerApplyDelete?num=<%=list.get(i).getApply_num()%>"
                       class="btn btn-outline-primary pull-right mx-lg-5" style="margin:0px auto"></a>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <center>
        <div>
            <ul class="pagination justify-content-center mt-3">
                <li class="page-item">
                    <%
                        if (pageNumber <= 0) {
                    %>
                    <a class="page-link disabled">이전</a>
                    <%
                    } else {
                    %>
                    <a class="page-link"
                       href="./managerUserApplyList?pageNumber=<%=pageNumber-1%>">이전</a>
                    <%
                        }
                    %>
                </li>
                <li class="page-item">
                    <%
                        if (list.size() < 6) {
                    %>
                    <a class="page-link disabled">다음</a>
                    <%
                    } else {
                    %>
                    <a class="page-link"
                       href="./managerUserApplyList?pageNumber=<%=pageNumber+1%>">다음</a>
                    <%
                        }
                    %>
                </li>
            </ul>

        </div>
    </center>

</div>

<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
