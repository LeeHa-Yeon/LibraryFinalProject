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
        if(userID.equals("manager")){
            ApplyDto applyDto = bookDao.getApplyInfo(Integer.parseInt(request.getParameter("num")));
            bookDao.addNewBook(applyDto.getApply_isbn(),applyDto.getApply_title(),applyDto.getApply_author(),applyDto.getApply_publisher(),applyDto.getApply_category(),applyDto.getApply_image());
            bookDao.updateApplyInfo(Integer.parseInt(request.getParameter("num")));

            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('신청 도서 입고 완료')");
            script.println("location.href='managerMain'");
            script.println("</script>");

        }else{
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('접근 권한이 없습니다.');");
            script.println("history.back()");
            script.println("</script>");
            script.close();
        }

    }

%>


<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
