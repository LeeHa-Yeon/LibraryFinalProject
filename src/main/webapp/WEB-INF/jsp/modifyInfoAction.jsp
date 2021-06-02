<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/05/31
  Time: 8:58 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="finalTermProject.DAO.UserDao" %>
<%@ page import="finalTermProject.DTO.UserDto" %>
<% request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> myInfo modify page </title>
</head>

<body>
<%
    String userID = null;
    UserDto myInfo = null;
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
        UserDao userDao = new UserDao();
        myInfo = userDao.getUserInfo(userID);

        if(request.getParameter("modifyName")==null||request.getParameter("modifyEmail")==null||request.getParameter("modifyPhone")==null|| request.getParameter("modifySSN")==null||request.getParameter("modifyAddress")==null ||
        request.getParameter("modifyName").equals("")||request.getParameter("modifyEmail").equals("")||request.getParameter("modifyPhone").equals("")|| request.getParameter("modifySSN").equals("")||request.getParameter("modifyAddress").equals("")){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        }else{
            int result = userDao.modifyInfo(userID,request.getParameter("modifyName"),request.getParameter("modifyEmail"),request.getParameter("modifyPhone"),request.getParameter("modifySSN"),request.getParameter("modifyAddress"));
            if(result == -1){
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('수정이 실패하였습니다..')");
                script.println("history.back()");
                script.println("</script>");
            }else{
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href='myInfo'");
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







