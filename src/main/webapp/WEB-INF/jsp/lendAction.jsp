<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/06/02
  Time: 4:28 오후
  To change this template use File | Settings | File Templates.

//    일단 member 대여가능개수가 존재한다면
//    book에 해당 대출상태를 확인
//    만약 대출불가라면 대출이 불가능하다고 알림창 띄우기
//
//    만약 대출가능이면
//    member의 대여가능횟수 차감
//    lendAllList에 추가하기
//    book의 대출상태를 대출불가(대여중)로 변경
//    알림창 대여 완료 앞으로 대여가능한 횟수 띄우기
//
//    만약 member유저 대여가능개수가 존재하지 않는다면
//    lendAllList에 해당 유저의 정보가 존재한다면
//    대여가능 횟수 초과 / 책을 반납하세요 라는 알림창을 띄우기

--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="finalTermProject.DAO.UserDao" %>
<%@ page import="finalTermProject.DTO.UserDto" %>
<%@ page import="finalTermProject.DAO.BookDao" %>
<%@ page import="finalTermProject.DTO.BookDto" %>
<%@ page import="finalTermProject.DTO.LendDto" %>
<%@ page import="java.awt.print.Book" %>
<%@ page import="java.util.ArrayList" %>
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
        }

        BookDto bookInfo = bookDao.getBookInfo(bookID);
        UserDto myInfo = userDao.getUserInfo(userID);

//    일단 member 대여가능개수가 존재한다면

        if (myInfo.getBorrowedLimit() != 0) {

            Calendar cal = Calendar.getInstance();
            SimpleDateFormat format1 = new SimpleDateFormat("yyy-MM-dd");
            Date time = new Date();
            String currentDate = format1.format(time);
            int Overdueing;
            if (myInfo.getIsOverdue().equals("정상")) {
                Overdueing = 1;
            } else {
                Overdueing = bookDao.dateCompareTo(currentDate, myInfo.getIsOverdue().substring(0, 11));
            }


            if (Overdueing < 1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('연체 기록이 있어 책을 빌릴수가 없습니다.')");
                script.println("location.href='bookList'");
                script.println("</script>");
            } else {
                userDao.changeNormalState(userID);

                if (bookInfo.getIs_book_borrowed().equals("대출가능")) {
                    userDao.lendCntChange(userID, myInfo.getBorrowedLimit() - 1);
                    bookDao.insertLendInfo(bookID, bookInfo.getBook_title(), userID);
                    bookDao.updateLendState(bookID, "대출불가(대여중)");
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('대여 성공했습니다. 반납일을 꼭 지켜주세요')");
                    script.println("location.href='bookList'");
                    script.println("</script>");

                } else {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('이미 대여중인 도서입니다.')");
                    script.println("history.back()");
                    script.println("</script>");
                }
            }

            } else{
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('대여 가능 횟수를 초과했습니다. 책을 반납 후 이용해주세요')");
                script.println("history.back()");
                script.println("</script>");
            }
        }

%>


<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
