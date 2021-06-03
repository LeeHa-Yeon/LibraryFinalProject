<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/06/02
  Time: 4:28 오후
  To change this template use File | Settings | File Templates.

반납화면구현
만약 반납날짜가 지났을 경우 -> 연체
    일주일간 책을 못빌립니다.
    member 연체상태 정상 -> 연체날짜로 변경

만약 반납날짜가 지나지 않을 경우 -> 정상적으로 반납하기
    정상적을 반납하셨습니다. 감사합니다.

항상 수행
    lendAllList 제거하기
    member 도서빌릴수있는 횟수 1증가
    book 대출상태 대출불가 -> 대여가능



--%>
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
