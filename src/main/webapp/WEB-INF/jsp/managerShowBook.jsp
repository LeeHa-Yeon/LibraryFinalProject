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
<%@ page import="finalTermProject.DAO.CommentDao" %>
<%@ page import="finalTermProject.DTO.CommentDto" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>

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
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('Please log in.');");
        script.println("location.href='login'");
        script.println("</script>");
        script.close();
    } else {
        if (!userID.equals("manager")) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('접근 권한이 없습니다.');");
            script.println("history.back()");
            script.println("</script>");
            script.close();
        }
    }
    int bookID = 0;
    if (request.getParameter("num") != null) {
        bookID = Integer.parseInt(request.getParameter("num"));
    }
    if (bookID == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않는 페이지입니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    BookDto bookDto = new BookDao().getBookInfo(bookID);
%>

<nav class="navbar navbar-expand-lg navbar-light bg-dark">
    <a class="navbar-brand" href=""> <img src="./image/logo.png" width="120" height="50" alt=""><span
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
    <div class="card bg-light mt-3">
        <div class="card-header">
            <h4><%=bookDto.getBook_title()%> 도서 상세 정보 </h4>
        </div>
        <div class="card-body">
            <div class="row">
                <div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel"
                     style=" padding-left: 40px; margin-top: 40px; float: left; width: 30%;">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img class="d-block w-100" src="./image/<%=bookDto.getBook_image()%>.png" width="300" height="350"
                                 alt="First slide">
                        </div>
                        <div class="carousel-item">
                            <img class="d-block w-100" src="./image/<%=bookDto.getBook_image()%>.png" width="300" height="350"
                                 alt="Second slide">
                        </div>
                        <div class="carousel-item">
                            <img class="d-block w-100" src="./image/<%=bookDto.getBook_image()%>.png" width="300" height="350"
                                 alt="Third slide">
                        </div>
                    </div>

                    <a class="left carousel-control" href="#carouselExampleSlidesOnly" data-slid="prev">
                        <span class="glyphicon-chevron-left"></span>
                    </a>
                    <a class="right carousel-control" href="#carouselExampleSlidesOnly" data-slid="next">
                        <span class="glyphicon-chevron-right"></span>
                    </a>
                    <a onclick="return confirm('수정하시겠습니까 ?')" href="managerModifyBook?num=<%=bookDto.getBook_num()%>"
                       class="btn btn-outline-warning pull-right mx-lg-5" style="margin:30px auto">수정</a>
                    <a onclick="return confirm('삭제하시겠습니까 ?')" href="managerDeleteBook?num=<%=bookDto.getBook_num()%>"
                       class="btn btn-outline-danger pull-right" style="margin: 10px auto">삭제</a>

                </div>
                <div style="float: left; margin-top: 40px; margin-left:50px; width: 50%;">
                    <table class="table table-striped"
                           style="text-align: center; padding-top: 40px; border: 1px solid #dddddd">

                        <tbody>
                        <tr>
                            <td style="background-color: #ced4da; text-align: center;">번호</td>
                            <td style=" padding-left:25px;text-align: left;"><%= bookDto.getBook_num()%>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: #ced4da; text-align: center;">제목</td>
                            <td style=" padding-left:25px;text-align: left;"><%= bookDto.getBook_title()%>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: #ced4da; text-align: center;">isbn</td>
                            <td style=" padding-left:25px;text-align: left;"><%= bookDto.getBook_ISBN()%>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: #ced4da; text-align: center;">저자</td>
                            <td style=" padding-left:25px;text-align: left;"><%= bookDto.getBook_author()%>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: #ced4da; text-align: center;">출판사</td>
                            <td style=" padding-left:25px;text-align: left;"><%= bookDto.getBook_publisher()%>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: #ced4da; text-align: center;">카테고리</td>
                            <td style=" padding-left:25px;text-align: left;"><%= bookDto.getBook_category()%>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: #ced4da; text-align: center;">상태</td>
                            <td style="padding-left:25px;text-align: left; "><%= bookDto.getIs_book_borrowed()%>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="card bg-light mt-3">
        <div class="card-header">
            <h5>리뷰<small></small></h5>
        </div>
        <div class="card-body">

            <%
                CommentDao commentDao = new CommentDao();
                ArrayList<CommentDto> list = commentDao.getcommentList(Integer.parseInt(request.getParameter("num")));
                if (list != null) {
                    for (int i = 0; i < list.size(); i++) {
                        CommentDto commentInfo = list.get(i);

            %>
            <b><label style="color: #0c5460 "><%=commentInfo.getUser_id()%>&nbsp;
            </label></b>

            <b style>&nbsp; <%=commentInfo.getContent()%>&nbsp;
            </b>
            <%
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Calendar currentTime = Calendar.getInstance();
                String now = format.format(currentTime.getTime());
                if (now.substring(0, 10).equals(commentInfo.getRegister_date().substring(0, 10))) {
            %>
            <small>(<%=commentInfo.getRegister_date().substring(11, 19)%>)&nbsp;&nbsp;</small>
            <%--            <small>&nbsp; </small>--%>
            <%
            } else {
            %>
            <small>(<%=commentInfo.getRegister_date().substring(0, 10)%>)&nbsp;</small>
            <%
                }
            %>

            <a onclick = "return confirm('삭제하시겠습니까 ?')" href = "managerCommentDelete?num=<%=bookDto.getBook_num()%>&commentID=<%=commentInfo.getComment_num()%>"
               style="color: #a71d2a">삭제</a>
            <hr>
            <%
                    }
                }
            %>
        </div>
    </div>

    <center><a href="managerMain" class="btn btn-dark pull-right" style="margin: 30px auto">뒤로가기</a></center>
</div>

<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
