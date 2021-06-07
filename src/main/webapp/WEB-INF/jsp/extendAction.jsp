
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="finalTermProject.DAO.UserDao" %>
<%@ page import="finalTermProject.DAO.BookDao" %>
<%@ page import="finalTermProject.DAO.LibraryDao" %>
<% request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> 연장하기 </title>
</head>

<body>
<%
    BookDao bookDao =  new BookDao();
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
        }
        String originReturnDate = libraryDao.selectLendInfo(Integer.parseInt(request.getParameter("num"))).getReturn_date().substring(0,11);
        String extendDate = bookDao.get7DayAfterDate(Integer.parseInt(originReturnDate.substring(0,4)),Integer.parseInt(originReturnDate.substring(5,7)),Integer.parseInt(originReturnDate.substring(8,10)));
        libraryDao.extensionDate(bookID,extendDate);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('일주일 연장되었습니다.')");
        script.println("location.href='myLendList'");
        script.println("</script>");


    }

%>


<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
