<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="finalTermProject.DAO.UserDao" %>
<%@ page import="finalTermProject.DTO.UserDto" %>
<%@ page import="finalTermProject.DAO.BookDao" %>
<%@ page import="finalTermProject.DTO.BookDto" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<% request.setCharacterEncoding("UTF-8");%>

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
    } else {
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
        } else {
            BookDto bookInfo = bookDao.getBookInfo(bookID);
            System.out.println("음" + bookID);
            bookDao.insertReservInfo(Integer.parseInt(request.getParameter("num")), bookInfo.getBook_title(), userID, request.getParameter("bookDate"));
            bookDao.updateLendState(bookID, "대출불가(예약중)");
            bookDao.updateReservateState(bookID, "예약불가");

        }
    }
%>

<script>
    alert('예약이 완료되었습니다. 예약일날(<%=request.getParameter("bookDate")%>)에 대여를 안하면 자동으로 취소됩니다.')
    location.href='bookShow?num=<%=request.getParameter("num")%>'
</script>
