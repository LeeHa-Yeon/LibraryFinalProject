
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="finalTermProject.DAO.UserDao" %>
<%@ page import="finalTermProject.DTO.UserDto" %>
<%@ page import="finalTermProject.DAO.BookDao" %>
<%@ page import="finalTermProject.DTO.BookDto" %>
<%@ page import="finalTermProject.DTO.LendDto" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<% request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> lend page </title>
</head>

<body>
<%
    BookDao bookDao =  new BookDao();
    UserDao userDao = new UserDao();
    String userID = null;
    if(session.getAttribute("userID")!=null){
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('Please log in.');");
        script.println("location.href='login'");
        script.println("</script>");
        script.close();
    }else {
        if (!userID.equals("manager")) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('접근 권한이 없습니다.');");
            script.println("history.back()");
            script.println("</script>");
            script.close();
        }else {
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
            }else{
                bookDao.deleteBook(bookID);
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('정상적으로 삭제되었습니다.')");
                script.println("location.href='managerMain'");
                script.println("</script>");
            }
        }
    }
%>


<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
