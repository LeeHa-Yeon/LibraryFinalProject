<%--
  Created by IntelliJ IDEA.
  User: hayeon
  Date: 2021/06/02
  Time: 4:28 오후
  To change this template use File | Settings | File Templates.

--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("UTF-8");%>


<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset='utf-8' />
  <link href='./fullcalendar-5.7.2/lib/main.css' rel='stylesheet' />
  <script src='./fullcalendar-5.7.2/lib/main.js'></script>
  <script src='./fullcalendar-5.7.2/lib/locales/ko.js'></script>
  <script>

    document.addEventListener('DOMContentLoaded', function() {
      var calendarEl = document.getElementById('calendar');
      var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth'
      });
      calendar.render();
    });
  </script>
  <style type="text/css">
    #container {
      width: 900px;
      position : relative;
    }
    #calendar{
      width: 750px;
      position : absolute;
      left: 50%;
      margin-left:100px;
      margin-top:100px;
    }
  </style>

</head>
<body>
<script>
  var calendar = $('#calendar');
  calendar.fullCalendar({
    dayClick: function(date, allDay, jsEvent, view) {
      calendar.fullCalendar('renderEvent', { title: 'YOUR TITLE', start: date, allDay: true }, true );
    }
  });
</script>
<div id='container'>
  <div id='calendar'></div>
</div>

<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
