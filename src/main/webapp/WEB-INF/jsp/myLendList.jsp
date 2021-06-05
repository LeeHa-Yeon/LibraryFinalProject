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
<%@ page import="finalTermProject.DTO.ApplyDto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="finalTermProject.DTO.LendDto" %>
<%@ page import="finalTermProject.DTO.ReservatDto" %>

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
    BookDao bookDao = new BookDao();
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
        <h3> 빌린 도서 목록 </h3>
        <table class="table table-striped" style="text-align: center; padding-top: 40px; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="background-color: #ced4da; text-align: center;">도서번호</th>
                <th style="background-color: #ced4da; text-align: center;">도서제목</th>
                <th style="background-color: #ced4da; text-align: center;">빌린사람</th>
                <th style="background-color: #ced4da; text-align: center;">빌린날짜</th>
                <th style="background-color: #ced4da; text-align: center;">반납날짜</th>
                <th style="background-color: #ced4da; text-align: center;">반납</th>
                <th style="background-color: #ced4da; text-align: center;">연장</th>
            </tr>
            </thead>
            <tbody>
            <%
                BookDao myLendInfo = new BookDao();
                ArrayList<LendDto> list = myLendInfo.getLendInfo(userID);
                for (int i = 0; i < list.size(); i++) {
            %>
            <tr>
                <td><%= list.get(i).getLend_book_id()%>
                </td>
                <td><%= list.get(i).getLend_book_title()%>
                </td>
                <td><%= list.get(i).getLend_user_id()%>
                </td>
                <td><%= list.get(i).getLend_date().substring(0, 11)%>
                </td>
                <td><%= list.get(i).getReturn_date().substring(0, 11)%>
                </td>
                <td><a onclick="return confirm('반납하시겠습니까 ?')" href="returnAction?num=<%=list.get(i).getLend_book_id()%>"
                       class="btn btn-outline-danger pull-right mx-lg-5" style="margin:0px auto"></a>
                </td>
                <td><a onclick="return confirm('일주일 연장하시겠습니까 ?')"
                       href="extendAction?num=<%=list.get(i).getLend_book_id()%>"
                       class="btn btn-outline-primary pull-right mx-lg-5" style="margin:0px auto"></a>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <br>
        <br>
        <br>


        <h3> 나의 신청 도서 </h3>
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
            </tr>
            </thead>
            <tbody>
            <%
                ArrayList<ApplyDto> list2 = bookDao.allApplyList(pageNumber);
                for (int i = 0; i < list2.size(); i++) {

                    if (list2.get(i).getApply_userId().equals(userID)) {
            %>
            <tr>
                <td><%=i + 1%>
                </td>
                <%
                    if (bookDao.getDate().substring(0, 10).equals(list2.get(i).getApply_Date().substring(0, 10))) {
                %>
                <td><%= list2.get(i).getApply_title()%><img src="./new.png" width="25" height="25" alt=""></td>
                <%
                } else {
                %>
                <td><%= list2.get(i).getApply_title()%>
                </td>
                <%
                    }
                %>
                <td><%= list2.get(i).getApply_author()%>
                </td>
                <td><%= list2.get(i).getApply_publisher()%>
                </td>
                <td><%= list2.get(i).getApply_category()%>
                </td>
                <td><%= list2.get(i).getApply_Date().substring(0, 10)%>
                </td>
                <td><%= list2.get(i).getAccept_Date()%>
                </td>
                <td><%= list2.get(i).getApply_state()%>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>

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
        <br>
        <div>
            <h3> 예약 도서 목록 </h3>
            <table class="table table-striped" style="text-align: center; padding-top: 40px; border: 1px solid #dddddd">
                <thead>
                <tr>
                    <th style="background-color: #ced4da; text-align: center;">번호</th>
                    <th style="background-color: #ced4da; text-align: center;">도서제목</th>
                    <th style="background-color: #ced4da; text-align: center;">예약자</th>
                    <th style="background-color: #ced4da; text-align: center;">빌린날짜</th>
                    <th style="background-color: #ced4da; text-align: center;">상태</th>
                </tr>
                </thead>
                <tbody>
                <%
                    BookDao myResiInfo = new BookDao();
                    ArrayList<ReservatDto> list3 = myResiInfo.getResiInfo(userID);
                    for (int i = 0; i < list3.size(); i++) {
                %>
                <tr>
                    <td>
                        <%=i + 1%>
                    </td>
                    <td><%= list3.get(i).getBook_book_title()%>
                    </td>
                    <td><%= list3.get(i).getBook_user_id()%>
                    </td>
                    <td><%= list3.get(i).getBook_date().substring(0, 10)%>
                    </td>
                    <td>
                        <%
                            int deadlineDate = bookDao.dateCompareTo(bookDao.getDate().substring(0, 10), list3.get(i).getBook_date().substring(0, 10));
                            if (deadlineDate == -1) {
                                // 이전이면 예약취소 버튼
                        %>
                        <a onclick="return confirm('예약취소하시겠습니까 ?')"
                           href="cancleReservate?res_num=<%=list3.get(i).getReservat_num()%>&num=<%=list3.get(i).getBook_book_id()%>"
                           class="btn btn-outline-danger pull-right mx-lg-5" style="margin:0px auto">예약취소</a>
                        <%
                        } else if (deadlineDate == 0) {
                            // 당일이 되면 대여중으로 나타남
                        %>
                        <a onclick="return confirm('대여하시겠습니까 ?')"
                           href="lendAction?num=<%=list3.get(i).getBook_book_id()%>&res_num=<%=list3.get(i).getReservat_num()%>"
                           class="btn btn-outline-info pull-right mx-lg-5" style="margin:0px auto">대여하기</a>
                        <%
                        } else { // 시간이 지나면 자동 삭제되
                        %>
                        <script>location.href = 'cancleReservate?res_num=<%=list3.get(i).getReservat_num()%>&num=<%=list3.get(i).getBook_book_id()%>'</script>
                        <%

                            }
                        %>

                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>


    </div>
    <center><a href="main" class="btn btn-dark pull-right">HOME</a></center>

</div>

<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
