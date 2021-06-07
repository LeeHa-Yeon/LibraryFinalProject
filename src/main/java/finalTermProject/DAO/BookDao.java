package finalTermProject.DAO;

import finalTermProject.DTO.*;

import java.awt.print.Book;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class BookDao {

    private Connection conn;
    private ResultSet rs;

    // 디비 접속
    public BookDao() {
        try {
            // 데이터베이스를 접근하도록 설정
            String dbURL = "jdbc:mysql://localhost/library?characterEncoding=utf8&serverTimezone=UTC";
            String dbID = "library";
            String dbPwd = "library123";
            Class.forName("com.mysql.jdbc.Driver");
            // 위의 정보를 토대로 데이터베이스에 연결할 수 있도록 함
            conn = DriverManager.getConnection(dbURL, dbID, dbPwd);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 현재 날짜,시간 추출
    public String getDate() {
        String SQL = "Select now()";
        try {
            // PreparedStatement는 SQL 문장을 데이터베이스에 넣을 수 있도록 하는 역할
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    // 모든 책 목록 보기
    public ArrayList<BookDto> getList(int pageNumber) {
        String SQL = "select * from book order by num desc limit " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
        ArrayList<BookDto> list = new ArrayList<BookDto>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                BookDto bookDto = new BookDto();
                bookDto.setBook_num(rs.getInt(1));
                bookDto.setBook_ISBN(rs.getInt(2));
                bookDto.setBook_title(rs.getString(3));
                bookDto.setBook_author(rs.getString(4));
                bookDto.setBook_publisher(rs.getString(5));
                bookDto.setBook_category(rs.getString(6));
                bookDto.setIs_book_borrowed(rs.getString(7));
                bookDto.setIs_book_reservation(rs.getString(8));
                bookDto.setRegisteDate(rs.getString(9));
                bookDto.setBook_image(rs.getString(10));
                bookDto.setViews(rs.getInt(11));
                bookDto.setLendCnt(rs.getInt(12));
                bookDto.setLikes(rs.getInt(13));
                list.add(bookDto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    // 해당 책 정보 가져오기
    public BookDto getBookInfo(int bookNum) {
        String SQL = "select * from book where num = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bookNum);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                BookDto bookDto = new BookDto();
                bookDto.setBook_num(rs.getInt(1));
                bookDto.setBook_ISBN(rs.getInt(2));
                bookDto.setBook_title(rs.getString(3));
                bookDto.setBook_author(rs.getString(4));
                bookDto.setBook_publisher(rs.getString(5));
                bookDto.setBook_category(rs.getString(6));
                bookDto.setIs_book_borrowed(rs.getString(7));
                bookDto.setIs_book_reservation(rs.getString(8));
                bookDto.setBook_image(rs.getString(10));
                bookDto.setViews(rs.getInt(11));
                bookDto.setLendCnt(rs.getInt(12));
                bookDto.setLikes(rs.getInt(13));

                return bookDto;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    // 새 도서 등록하기
    public int addNewBook(int newIsbn, String newTitle, String newAuthor, String newPublisher, String newCategory, String newImage) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar currentTime = Calendar.getInstance();
        String SQL = "insert into book (isbn,book_title,book_author,book_publisher,book_category,book_is_borrowed,book_is_reservation,REGDATE,picture,views,lendCnt,likes) values (?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, newIsbn);
            pstmt.setString(2, newTitle);
            pstmt.setString(3, newAuthor);
            pstmt.setString(4, newPublisher);
            pstmt.setString(5, newCategory);
            pstmt.setString(6, "대출가능");
            pstmt.setString(7, "예약가능");
            pstmt.setString(8, format.format(currentTime.getTime()));
            pstmt.setString(9, newTitle);
            pstmt.setInt(10, 0);
            pstmt.setInt(11, 0);
            pstmt.setInt(12, 0);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // 데이터베이스 오류
    }


    //  도서 삭제하기
    public int deleteBook(int bookID) {
        String SQL = "delete from book where num=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bookID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }


    // 책 정보 수정하기
    public int modifyBook(int bookID, int m_isbn, String m_bookTitle, String m_bookAuthor, String m_bookPublisher, String m_bookCategory, String m_borrowedState, String m_reservationState, String m_image) {
        String SQL = "update book set isbn=?,book_title=?,book_author=?,book_publisher=?,book_category=?,book_is_borrowed=?,book_is_reservation=?,picture=? where num=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, m_isbn);
            pstmt.setString(2, m_bookTitle);
            pstmt.setString(3, m_bookAuthor);
            pstmt.setString(4, m_bookPublisher);
            pstmt.setString(5, m_bookCategory);
            pstmt.setString(6, m_borrowedState);
            pstmt.setString(7, m_reservationState);
            pstmt.setString(8, m_image);
            pstmt.setInt(9, bookID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    // 대출상태 변경
    public int updateLendState(int bookID, String changeState) {
        String SQL = "update book set book_is_borrowed=? where num=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, changeState);
            pstmt.setInt(2, bookID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    // 예약상태 변경
    public int updateReservateState(int bookID, String changeState) {
        String SQL = "update book set book_is_reservation=? where num=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, changeState);
            pstmt.setInt(2, bookID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    // 조회수 증가하기
    public int plusViews(int bookID, int originViews) {
        String SQL = "update book set views=? where num=?";
        try {
            BookDto bookDto = new BookDto();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, originViews + 1);
            pstmt.setInt(2, bookID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    // 대여수 증가하기
    public int plusLendCnt(int bookID, int originLendCnt) {
        String SQL = "update book set lendCnt=? where num=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, originLendCnt + 1);
            pstmt.setInt(2, bookID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    // 추천수 증가하기
    public int plusLikesCnt(int bookID, int originLikes) {
        String SQL = "update book set likes=? where num=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, originLikes + 1);
            pstmt.setInt(2, bookID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    public String get7DayAfterDate(int year, int month, int day) {
        Calendar cal = Calendar.getInstance();
        cal.set(year, month - 1, day);
        cal.add(Calendar.DATE, +7);
        java.util.Date weekAfter = cal.getTime();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());
        return formatter.format(weekAfter);

    }

    public String possibleBook(int year, int month, int day) {
        Calendar cal = Calendar.getInstance();
        cal.set(year, month - 1, day);
        cal.add(Calendar.DATE, +1);
        java.util.Date possibleStart = cal.getTime();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());
        return formatter.format(possibleStart);

    }

    public int dateCompareTo(String currentDate, String returnDate) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date today = null;
        try {
            today = format.parse(currentDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Date end = null;
        try {
            end = format.parse(returnDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        int result = today.compareTo(end);
        return result;
    }


}