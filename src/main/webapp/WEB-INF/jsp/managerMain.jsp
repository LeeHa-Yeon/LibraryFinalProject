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
        <h3> 도서 목록 화면</h3>
            <a class="btn btn-dark pull-right" data-toggle="modal" href="#modifyModal"  style="margin: 30px auto">도서등록</a>
        </div>
        <table class="table table-striped" style="text-align: center; padding-top: 40px; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="background-color: #ced4da; text-align: center;">번호</th>
                <th style="background-color: #ced4da; text-align: center;">제목</th>
                <th style="background-color: #ced4da; text-align: center;">isbn</th>
                <th style="background-color: #ced4da; text-align: center;">저자</th>
                <th style="background-color: #ced4da; text-align: center;">출판사</th>
                <th style="background-color: #ced4da; text-align: center;">카테고리</th>
                <th style="background-color: #ced4da; text-align: center;">상태</th>
            </tr>
            </thead>
            <tbody>
            <%
                BookDao bookDao = new BookDao();
                ArrayList<BookDto> list = bookDao.getList(pageNumber);
                for (int i = 0; i < list.size(); i++) {
            %>
            <tr>
                <td><%= list.get(i).getBook_num()%>
                </td>
                <td><a href="managerShowBook?num=<%=list.get(i).getBook_num()%>"><%= list.get(i).getBook_title()%>
                </a></td>
                <td><%= list.get(i).getBook_ISBN()%>
                </td>
                <td><%= list.get(i).getBook_author()%>
                </td>
                <td><%= list.get(i).getBook_publisher()%>
                </td>
                <td><%= list.get(i).getBook_category()%>
                </td>
                <td><%= list.get(i).getIs_book_borrowed()%>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
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
                           href="./managerMain?pageNumber=<%=pageNumber-1%>">이전</a>
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
                           href="./managerMain?pageNumber=<%=pageNumber+1%>">다음</a>
                        <%
                            }
                        %>
                    </li>
                </ul>

            </div>
        </center>
    </div>

    <div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modal">새 도서 추가</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="managerAddBook" method="post">
                        <div class="form-group">
                            <label>isbn</label>
                            <input type="text" name="newIsbn" class="form-control" maxlength="40">
                        </div>
                        <div class="form-group">
                            <label>책 제목</label>
                            <input type="text" name="newTitle" class="form-control" maxlength="40">
                        </div>
                        <div class="form-group">
                            <label>저자</label>
                            <input type="text" name="newAuthor" class="form-control" maxlength="40">
                        </div>
                        <div class="form-group">
                            <label>출판사</label>
                            <input type="text" name="newPublisher" class="form-control" maxlength="40">
                        </div>
                        <div class="form-group">
                            <label>카테고리</label>
                            <input type="text" name="newCategory" class="form-control" maxlength="40">
                        </div>
                        <div class="form-group">
                            <label>사진</label>
                            <input type="text" name="newImage" class="form-control" maxlength="40">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                            <button type="submit" class="btn btn-primary">등록하기</button>
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


