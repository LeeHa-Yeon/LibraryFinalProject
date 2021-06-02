<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/05/31
  Time: 8:59 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="finalTermProject.DAO.UserDao" %>
<%@ page import="finalTermProject.DTO.UserDto" %>
<%@ page import="java.util.ArrayList" %>
<%
    String userID = null;
    if(session.getAttribute("userID")!=null){
        userID = (String) session.getAttribute("userID");
    }
    if (userID !=null){
    UserDao userDao = new UserDao();
    int result = userDao.signout(userID);
        if(result == -1){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert(' 실패했습니다. 다시 시도해주세요.')");
            script.println("history.back()");
            script.println("</script>");
        }else{
            session.invalidate();
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('회원 탈퇴 성공하였습니다.')");
            script.println("location.href='login'");
            script.println("</script>");
        }
    }

%>