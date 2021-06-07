
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="finalTermProject.DAO.LibraryDao" %>
<% request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> 희망 도서 삭제 </title>
</head>

<body>
<%
    LibraryDao libraryDao = new LibraryDao();
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
            int applyID = 0;
            if (request.getParameter("num") != null) {
                applyID = Integer.parseInt(request.getParameter("num"));
            }
            if (applyID == 0) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('유효하지 않는 페이지입니다.')");
                script.println("history.back()");
                script.println("</script>");
            }else{
                libraryDao.deleteApplyBook(applyID);
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('정상적으로 삭제되었습니다.')");
                script.println("location.href='managerUserApplyList'");
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
