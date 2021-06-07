<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/05/29
  Time: 6:36 오후
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="finalTermProject.DAO.BookDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="finalTermProject.DTO.ApplyDto" %>
<%@ page import="finalTermProject.DAO.LibraryDao" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/custom.min.css">
    <title> 희망 도서 목록 화면 </title>
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
        <div>
            <h3> 도서 신청 화면</h3>
            <a class="btn btn-dark pull-right" data-toggle="modal" href="#modifyModal"
               style="margin: 30px auto">도서신청</a>
        </div>
        <table class="table table-striped" style="text-align: center; padding-top: 40px; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="background-color: #ced4da; text-align: center;">번호</th>
                <th style="background-color: #ced4da; text-align: center;">책 제목</th>
                <th style="background-color: #ced4da; text-align: center;">저자</th>
                <th style="background-color: #ced4da; text-align: center;">출판사</th>
                <th style="background-color: #ced4da; text-align: center;">카테고리</th>
                <th style="background-color: #ced4da; text-align: center;">신청날짜</th>
                <th style="background-color: #ced4da; text-align: center;">완료날짜</th>
                <th style="background-color: #ced4da; text-align: center;">상태</th>
                <th style="background-color: #ced4da; text-align: center;">신청자</th>
            </tr>
            </thead>
            <tbody>
            <%
                BookDao bookDao = new BookDao();
                LibraryDao libraryDao = new LibraryDao();
                ArrayList<ApplyDto> list = libraryDao.allApplyList(pageNumber);
                for (int i = 0; i < list.size(); i++) {
            %>
            <tr>
                <td><%=i + 1%>
                </td>
                <%
                    if (bookDao.getDate().substring(0, 10).equals(list.get(i).getApply_Date().substring(0, 10))) {
                %>
                <td><%= list.get(i).getApply_title()%><img src="./image/new.png" width="25" height="25" alt=""></td>
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
                <td><%= list.get(i).getApply_publisher()%>
                </td>
                <td><%= list.get(i).getApply_category()%>
                </td>
                <td><%= list.get(i).getApply_Date().substring(0, 10)%>
                </td>
                <td><%= list.get(i).getAccept_Date()%>
                </td>
                <td><%= list.get(i).getApply_state()%>
                </td>
                <td><%= list.get(i).getApply_userId()%>
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
                       href="./applyList?pageNumber=<%=pageNumber-1%>">이전</a>
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
                       href="./applyList?pageNumber=<%=pageNumber+1%>">다음</a>
                    <%
                        }
                    %>
                </li>
            </ul>

        </div>
    </center>

    <div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="modal">도서 신청하기</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="applyNewBook" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title">신청자: <%=userID%>
                            </h5>
                        </div>
                        <div class="form-group">
                            <p></p>
                        </div>

                        <div class="form-group">
                            <label>isbn</label>
                            <input type="text" name="applyIsbn" class="form-control" maxlength="40">
                        </div>
                        <div class="form-group">
                            <label>책 제목</label>
                            <input type="text" name="applyTitle" class="form-control" maxlength="40">
                        </div>
                        <div class="form-group">
                            <label>저자</label>
                            <input type="text" name="applyAuthor" class="form-control" maxlength="40">
                        </div>
                        <div class="form-group">
                            <label>출판사</label>
                            <input type="text" name="applyPublisher" class="form-control" maxlength="40">
                        </div>
                        <div class="form-group">
                            <label>카테고리</label>
                            <input type="text" name="applyCategory" class="form-control" maxlength="40">
                        </div>
                        <div class="form-group">
                            <label>파일</label>
                            <input type="file" name="newfile" class="form-control" ><br>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                            <button type="submit" class="btn btn-primary">신청</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
