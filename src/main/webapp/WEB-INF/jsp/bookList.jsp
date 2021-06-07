<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/05/29
  Time: 6:36 오후
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="finalTermProject.DAO.BookDao" %>
<%@ page import="finalTermProject.DTO.BookDto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="finalTermProject.DAO.LibraryDao" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/custom.min.css">
    <title> 도서 목록 화면 </title>
    <style type="text/css">
        a, a:hover {
            color: #004085;
            text-decoration: none;
        }
    </style>
</head>

<body>
<%
    request.setCharacterEncoding("UTF-8");
    String userID = null;
    BookDao bookDao = new BookDao();
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }

    String SearchDivide = "전체";
    String searchType = "최신순";
    String search = "";

    if (request.getParameter("SearchDivide") != null) {
        SearchDivide = request.getParameter("SearchDivide");
    }
    if (request.getParameter("searchType") != null) {
        searchType = request.getParameter("searchType");
    }
    if (request.getParameter("search") != null) {
        search = request.getParameter("search");
    }
    int pageNumber2 = 0;
    if (request.getParameter("pageNumber2") != null) {
        try {
            pageNumber2 = Integer.parseInt(request.getParameter("pageNumber2"));

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
        <div>
            <h3> 도서 목록 화면</h3>

            <section class="container">
                <form style="margin:20px auto; " method="get" action="./bookList"
                      class="form-inline mt-3">
                    <select name="SearchDivide" class="form-control mx-1 mt-2">
                        <option value="전체"> 전체</option>
                        <option value="제목"<% if (SearchDivide.equals("제목")) out.println("selected"); %>> 제목</option>
                        <option value="저자"<% if (SearchDivide.equals("저자")) out.println("selected"); %>> 저자</option>
                        <option value="기타"<% if (SearchDivide.equals("기타")) out.println("selected"); %>> 기타</option>
                    </select>
                    <select name="searchType" class="form-control mx-1 mt-2">
                        <option value="최신순"> 최신순</option>
                        <option value="인기순"<% if (SearchDivide.equals("인기순")) out.println("selected"); %>>인기순
                        </option>
                        <option value="추천순"<% if (SearchDivide.equals("추천순")) out.println("selected"); %>> 추천순</option>
                        <option value="조회순"<% if (SearchDivide.equals("조회순")) out.println("selected"); %> >조회순</option>
                    </select>
                    <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요">
                    <button type="submit" class="btn btn-outline-success mx-1 mt-2">검색</button>
                </form>
            </section>
            <%--            <form style="margin-top:20px; margin-left: 850px" action="./bookList" class="form-inline my-2 my-lg-0">--%>
            <%--                <input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을입력하세요."--%>
            <%--                       aria-label="search">--%>
            <%--                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>--%>
            <%--            </form>--%>

        </div>
        <table class="table table-striped"
               style="margin-top: 30px; text-align: center; padding-top: 40px; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="background-color: #ced4da; text-align: center;">번호</th>
                <th style="background-color: #ced4da; text-align: center;">제목</th>
                <th style="background-color: #ced4da; text-align: center;">isbn</th>
                <th style="background-color: #ced4da; text-align: center;">저자</th>
                <th style="background-color: #ced4da; text-align: center;">출판사</th>
                <th style="background-color: #ced4da; text-align: center;">카테고리</th>
                <th style="background-color: #ced4da; text-align: center;">상태</th>
                <th style="background-color: #ced4da; text-align: center;">조회수</th>
            </tr>
            </thead>
            <tbody>
            <%
                LibraryDao libraryDao = new LibraryDao();
                ArrayList<BookDto> list = libraryDao.getSearchList(SearchDivide, searchType, search, pageNumber2);
                if (list != null) {
                    for (int i = 0; i < list.size(); i++) {
                        if (i == 5) break;
                        BookDto bookInfo = list.get(i);
            %>
            <tr>
                <td><%= bookInfo.getBook_num()%>
                </td>
                <%
                    if (bookDao.getDate().substring(0, 10).equals(bookInfo.getRegisteDate().substring(0, 10))) {
                %>
                <td><a href="bookShow?num=<%=bookInfo.getBook_num()%>"><%= bookInfo.getBook_title()%>
                    <img src="./image/new.png" width="25" height="25" alt="">
                </a></td>
                <%
                } else {
                %>
                <td><a href="bookShow?num=<%=bookInfo.getBook_num()%>"><%= bookInfo.getBook_title()%>
                </a>

                </td>

                <%
                    }
                %>
                <td><%= bookInfo.getBook_ISBN()%>
                </td>
                <td><%= bookInfo.getBook_author()%>
                </td>
                <td><%= bookInfo.getBook_publisher()%>
                </td>
                <td><%= bookInfo.getBook_category()%>
                </td>
                <td><%= bookInfo.getIs_book_borrowed()%>
                </td>
                <td><%= bookInfo.getViews()%>
                </td>
            </tr>
            <%
                    }
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
                        if (pageNumber2 <= 0) {
                    %>
                    <a class="page-link disabled">이전</a>
                    <%
                    } else {
                    %>
                    <a class="page-link"
                       href="./bookList?SearchDivide=<%=URLEncoder.encode(SearchDivide,"UTF-8")%>&searchType=<%=URLEncoder.encode(searchType,"UTF-8")%>&search=<%=URLEncoder.encode(search,"UTF-8")%>&pageNumber2=<%=pageNumber2-1%>">이전</a>
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
                       href="./bookList?SearchDivide=<%=URLEncoder.encode(SearchDivide,"UTF-8")%>&searchType=<%=URLEncoder.encode(searchType,"UTF-8")%>&search=<%=URLEncoder.encode(search,"UTF-8")%>&pageNumber2=<%=pageNumber2+1%>">다음</a>
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
