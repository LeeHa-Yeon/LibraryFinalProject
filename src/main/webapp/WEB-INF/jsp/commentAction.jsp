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
<%@ page import="finalTermProject.DAO.CommentDao" %>
<% request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> 댓글 달기 </title>
</head>

<body>
<%
    UserDao userDao = new UserDao();
    CommentDao commentDao = new CommentDao();

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
        commentDao.insertComment(Integer.parseInt(request.getParameter("num")),userID,request.getParameter("content"));
        userDao.changePoint(userID, userDao.getUserInfo(userID).getPoint() + 5);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('리뷰를 작성했습니다. 포인트 5점 적립되었습니다.')");
        script.println("</script>");
    }
%>

<script>location.href='bookShow?num=<%=request.getParameter("num")%>'</script>


<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
