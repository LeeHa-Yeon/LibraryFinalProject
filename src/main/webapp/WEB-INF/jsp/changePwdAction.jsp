<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/06/01
  Time: 9:27 오후
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

        if(request.getParameter("oldPwd")==null||request.getParameter("newPwd")==null||request.getParameter("newPwdCheck")==null||request.getParameter("oldPwd").equals("")|| request.getParameter("newPwd").equals("")||request.getParameter("newPwdCheck").equals("")){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        }else{
            if (!myInfo.getPwd().equals(request.getParameter("oldPwd"))){
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('현재 비밀번호가 틀렸습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }else {
                if(!request.getParameter("newPwd").equals(request.getParameter("newPwdCheck"))){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('새 비밀번호 입력을 다시 확인해주세요.')");
                    script.println("history.back()");
                    script.println("</script>");
                }else{
                    int result = userDao.changePwd(userID,request.getParameter("oldPwd"),request.getParameter("newPwd"));
                    if(result == -1){
                        PrintWriter script = response.getWriter();
                        script.println("<script>");
                        script.println("alert('수정이 실패하였습니다..')");
                        script.println("history.back()");
                        script.println("</script>");
                    }else{
                        PrintWriter script = response.getWriter();
                        script.println("<script>");
                        script.println("alert('비밀번호가 성공적으로 변경되었습니다.')");
                        script.println("location.href='main'");
                        script.println("</script>");
                    }
                }

            }


        }

    }

%>