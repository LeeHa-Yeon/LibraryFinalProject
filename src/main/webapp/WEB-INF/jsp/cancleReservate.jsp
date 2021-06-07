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
<%@ page import="finalTermProject.DTO.LendDto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="finalTermProject.DAO.LibraryDao" %>
<% request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> 예약 취소 페이지 </title>
</head>

<body>
<%
    BookDao bookDao = new BookDao();
    LibraryDao libraryDao = new LibraryDao();

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
    } else{
        ArrayList<LendDto> lendInfo = libraryDao.getLendSize(Integer.parseInt(request.getParameter("num")));
        libraryDao.cancleReservation(Integer.parseInt(request.getParameter("res_num")));
        if(lendInfo.size()==0){
            bookDao.updateLendState(Integer.parseInt(request.getParameter("num")), "대출가능");
        }else {
            bookDao.updateLendState(Integer.parseInt(request.getParameter("num")), "대출불가(대여중)");
        }
        bookDao.updateReservateState(Integer.parseInt(request.getParameter("num")), "예약가능");
    }
%>

<script>location.href='myLendList'</script>


<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
