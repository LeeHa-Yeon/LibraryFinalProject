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
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <style>
        /*datepicer 버튼 롤오버 시 손가락 모양 표시*/
        .ui-datepicker-trigger {
            cursor: pointer;
        }

        /*datepicer input 롤오버 시 손가락 모양 표시*/
        .hasDatepicker {
            cursor: pointer;
        }
    </style>
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

        if (bookInfo.getIs_book_borrowed().equals("대출가능")) {
            if (bookInfo.getIs_book_reservation().equals("예약가능")) {
%>
<form method="get" action="reservation" style="margin: 0 auto">
    예약 날짜 설정 : <input type="text" name="bookDate" id="datepicker">

    <script>
        $(function () {
            //모든 datepicker에 대한 공통 옵션 설정
            $.datepicker.setDefaults({
                dateFormat: 'yy-mm-dd' //Input Display Format 변경
                , showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                , showMonthAfterYear: true //년도 먼저 나오고, 뒤에 월 표시
                , changeYear: true //콤보박스에서 년 선택 가능
                , changeMonth: true //콤보박스에서 월 선택 가능
                , showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
                , buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
                , buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
                , buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트
                , yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
                , monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'] //달력의 월 부분 텍스트
                , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 Tooltip 텍스트
                , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'] //달력의 요일 부분 텍스트
                , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'] //달력의 요일 부분 Tooltip 텍스트
                // ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                , minDate: "+1D"
                , maxDate: "+8D" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
            });

            //input을 datepicker로 선언
            $("#datepicker").datepicker();

            //From의 초기값을 오늘 날짜로 설정
            $('#datepicker').datepicker('setDate', '+1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

        });
    </script>
    <input type="hidden" name="num" value="<%=bookID%>">
    <input type="submit" class="btn btn-dark form-control" value="예약" Style="width: 100px;">
    <button href="bookShow?num=<%=request.getParameter("num")%>>">예약취소</button>
</form>
<%


    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 이 책은 예약이 걸려 있습니다. 책 한권당 예약은 한번만 가능합니다. ')");
        script.println("history.back()");
        script.println("</script>");
    }

} else {
    if (bookInfo.getIs_book_reservation().equals("예약가능")) {
        String originReturnDate = bookDao.selectLendInfo(Integer.parseInt(request.getParameter("num"))).getReturn_date().substring(0, 11);
        String possibleDate = bookDao.possibleBook(Integer.parseInt(originReturnDate.substring(0, 4)), Integer.parseInt(originReturnDate.substring(5, 7)), Integer.parseInt(originReturnDate.substring(8, 10)));
%>
<form method="post" action="reservation" style="margin: 0 auto">
    예약 날짜 설정 : <input type="text" name="bookDate" id="datepicker2">

    <script>
        $(function () {
            //모든 datepicker에 대한 공통 옵션 설정
            $.datepicker.setDefaults({
                dateFormat: 'yy-mm-dd' //Input Display Format 변경
                , showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                , showMonthAfterYear: true //년도 먼저 나오고, 뒤에 월 표시
                , changeYear: true //콤보박스에서 년 선택 가능
                , changeMonth: true //콤보박스에서 월 선택 가능
                , showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
                , buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
                , buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
                , buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트
                , yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
                , monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'] //달력의 월 부분 텍스트
                , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 Tooltip 텍스트
                , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'] //달력의 요일 부분 텍스트
                , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'] //달력의 요일 부분 Tooltip 텍스트
                // ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                , minDate: "+7D"
                , maxDate: "+14D" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
            });

            //input을 datepicker로 선언
            $("#datepicker2").datepicker();

            //From의 초기값을 오늘 날짜로 설정
            $('#datepicker2').datepicker('setDate', '+7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

        });
    </script>
    <input type="hidden" name="num" value="<%=bookID%>">

    <input type="submit" class="btn btn-dark form-control" value="예약" Style="width: 100px;">
    <button href="bookShow?num=<%=request.getParameter("num")%>>">예약취소</button>
</form>
<%

            } else {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('이미 이 책은 예약이 걸려 있습니다. 책 한권당 예약은 한번만 가능합니다. ')");
                script.println("history.back()");
                script.println("</script>");

            }

        }
    }
%>

<%--    // 내 상태에 예약 취소 가능--%>


</body>
</html>
