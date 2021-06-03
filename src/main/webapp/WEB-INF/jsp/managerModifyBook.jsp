<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/05/31
  Time: 8:58 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="finalTermProject.DAO.BookDao" %>
<%@ page import="finalTermProject.DTO.BookDto" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/custom.min.css">
    <title> book modify page </title>
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
    BookDto bookInfo = new BookDao().getBookInfo(bookID);
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
        <form method="post" action="managerModifyBookAction?num=<%=bookID%>">
            <table class = "table table-striped" style=" table-layout: fixed; padding-top: 40px; border: 1px solid #dddddd">
                <thead>
                <tr>
                    <th colspan="5" style="background-color: #ced4da; text-align: center;">도서 정보 수정</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                </tr>
                <tr >
                    <td style="width: 35%; text-align: center;" >번호</td>
                    <td style="text-align: left;" colspan="4"><%=bookInfo.getBook_num()%></td>
                </tr>
                <tr>
                    <td style="width: 35%; text-align: center;" >isbn</td>
                    <td style="text-align: left;" colspan="4">
                        <input type="text" class="form-control" name="modifyIsbn" maxlength="100" value="<%=bookInfo.getBook_ISBN()%>">
                    </td>
                </tr>
                <tr>
                    <td style="width: 35%; text-align: center;" >제목</td>
                    <td style="text-align: left;" colspan="4">
                        <input type="text" class="form-control" name="modifyTitle" maxlength="100" value="<%=bookInfo.getBook_title()%>">
                    </td>
                </tr>
                <tr>
                    <td style="width: 35%; text-align: center;" >저자</td>
                    <td style="text-align: left;" colspan="4">
                        <input type="text" class="form-control"  name="modifyAuthor" maxlength="100" value="<%=bookInfo.getBook_author()%>">
                    </td>
                </tr>
                <tr>
                    <td style="width: 35%; text-align: center;" >출판사</td>
                    <td style="text-align: left;" colspan="4">
                        <input type="text" class="form-control" name="modifyPublisher" maxlength="100" value="<%=bookInfo.getBook_publisher()%>">
                    </td>
                </tr>
                <tr>
                    <td style="width: 35%; text-align: center;" >카테고리</td>
                    <td style="text-align: left;" colspan="4">
                        <input type="text" class="form-control"  name="modifyCate" maxlength="100" value="<%=bookInfo.getBook_category()%>">
                    </td>
                </tr>
                <tr>
                    <td style="width: 35%; text-align: center;" >대출상태</td>
                    <td style="text-align: left;" colspan="4">
                        <input type="text" class="form-control"  name="modifyLendState" maxlength="100" value="<%=bookInfo.getIs_book_borrowed()%>">
                    </td>
                </tr>
                <tr>
                    <td style="width: 35%; text-align: center;" >예약상태</td>
                    <td style="text-align: left;" colspan="4">
                        <input type="text" class="form-control"  name="modifyReservState" maxlength="100" value="<%=bookInfo.getIs_book_reservation()%>">
                    </td>
                </tr>
                <tr>
                    <td style="width: 35%; text-align: center;" >사진</td>
                    <td style="text-align: left;" colspan="4">
                        <input type="text" class="form-control"  name="modifyImage" maxlength="100" value="<%=bookInfo.getBook_image()%>">
                    </td>
                </tr>
                </tbody>
            </table>
            <input type="submit" class="btn btn-dark" style="float: none; margin:0 auto" value="저장하기">
        </form>
    </div>

</div>

<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>





