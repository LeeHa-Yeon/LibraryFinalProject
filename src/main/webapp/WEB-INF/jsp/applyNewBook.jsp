<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/05/29
  Time: 6:36 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="finalTermProject.DAO.UserDao" %>
<%@ page import="finalTermProject.DAO.BookDao" %>
<% request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> new Book Add page </title>
</head>

<body>
<%
    BookDao bookDao = new BookDao();
    UserDao userDao = new UserDao();
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
            PrintWriter script = response.getWriter();
            bookDao.applyBook(Integer.parseInt(request.getParameter("applyIsbn")),request.getParameter("applyTitle"),request.getParameter("applyAuthor"),request.getParameter("applyPublisher"),request.getParameter("applyCategory"),userID,request.getParameter("newImage"));
            script.println("<script>");
            script.println("alert('도서가 신청되었습니다.')");
            script.println("location.href='applyList'");
            script.println("</script>");
    }

%>


<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
