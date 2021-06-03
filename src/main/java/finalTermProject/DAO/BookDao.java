package finalTermProject.DAO;

import finalTermProject.DTO.BookDto;
import finalTermProject.DTO.LendDto;

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

public class BookDao {

    private Connection conn;
    private ResultSet rs;

    // 디비 접속
    public BookDao(){
        try{
            String dbURL = "jdbc:mysql://localhost/library?characterEncoding=utf8&serverTimezone=UTC";
            String dbID = "library";
            String dbPwd = "library123";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL,dbID,dbPwd);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 현재 날짜,시간 추출
    public String getDate(){
        String SQL = "Select now()";
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getString(1);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

    // 페이징
    public int getNext(){
        String SQL = "Select num from book order by num desc";
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getInt(1)+1;
            }
            // 첫번째 게시물인 경우
            return 1;
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }

    // 책 목록 보기
    public ArrayList<BookDto> getList(int pageNumber){
        String SQL = "select * from book where num < ? order by num desc limit 3";
        ArrayList<BookDto> list = new ArrayList<BookDto>();
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext()-(pageNumber-1)*3);
            rs = pstmt.executeQuery();
            while (rs.next()){
                BookDto bookDto = new BookDto();
                bookDto.setBook_num(rs.getInt(1));
                bookDto.setBook_ISBN(rs.getInt(2));
                bookDto.setBook_title(rs.getString(3));
                bookDto.setBook_author(rs.getString(4));
                bookDto.setBook_publisher(rs.getString(5));
                bookDto.setBook_category(rs.getString(6));
                bookDto.setIs_book_borrowed(rs.getString(7));
                bookDto.setIs_book_reservation(rs.getString(8));
                list.add(bookDto);
            }

        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }

    public boolean nextPage(int pageNumber){
        String SQL = "select * from book where num<?";
        ArrayList<BookDto> list = new ArrayList<BookDto>();
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext()-(pageNumber-1)*3);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }

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
                return bookDto;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    // 내 대여 상태 보기
    public ArrayList<LendDto> getLendInfo(String userID) {
        String SQL = "select * from lendAllList where lend_user_id = ?";
        ArrayList<LendDto> list = new ArrayList<LendDto>();
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            while (rs.next()){
                LendDto lendDto = new LendDto();
                lendDto.setLend_book_id(rs.getInt(2));
                lendDto.setLend_book_title(rs.getString(3));
                lendDto.setLend_user_id(rs.getString(4));
                lendDto.setLend_date(rs.getString(5));
                lendDto.setReturn_date(rs.getString(6));
                list.add(lendDto);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }

    public int insertLendInfo(int lend_bookID ,String lend_bookTitle,String lend_userID){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar currentTime = Calendar.getInstance();
        Calendar week = Calendar.getInstance();
        week.add(Calendar.DATE , +7);
        String SQL = "insert into lendAllList (lend_book_id,lend_book_title,lend_user_id,lend_date,return_date) values (?,?,?,?,?)";
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, lend_bookID);
            pstmt.setString(2, lend_bookTitle);
            pstmt.setString(3, lend_userID);
            pstmt.setString(4, format.format(currentTime.getTime()));
            pstmt.setString(5, format.format(week.getTime()));
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        return -2; // 데이터베이스 오류
    }

    // 대출상태 변경
    public int updateLendState(int bookID,String changeState){
        String SQL = "update book set book_is_borrowed=? where num=?";
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,changeState);
            pstmt.setInt(2,bookID);
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    //  대여 항목 제거하기
    public int deleteLendBook(int bookID){
        String SQL = "delete from lendAllList where lend_book_id=?";
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1,bookID);
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
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


    public LendDto selectLendInfo(int bookNum) {
        String SQL = "select * from lendAllList where lend_book_id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bookNum);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                LendDto lendDto = new LendDto();
                lendDto.setLend_book_id(rs.getInt(2));
                lendDto.setLend_book_title(rs.getString(3));
                lendDto.setLend_user_id(rs.getString(4));
                lendDto.setLend_date(rs.getString(5));
                lendDto.setReturn_date(rs.getString(6));
                return lendDto;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    // 새 도서 등록하기
    public int addNewBook(int newIsbn, String newTitle, String newAuthor, String newPublisher, String newCategory,String newImage){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar currentTime = Calendar.getInstance();

        String SQL = "insert into book (isbn,book_title,book_author,book_publisher,book_category,book_is_borrowed,book_is_reservation,REGDATE,picture) values (?,?,?,?,?,?,?,?,?)";
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, newIsbn);
            pstmt.setString(2, newTitle);
            pstmt.setString(3, newAuthor);
            pstmt.setString(4, newPublisher);
            pstmt.setString(5, newCategory);
            pstmt.setString(6, "대출가능");
            pstmt.setString(7, "예약가능");
            pstmt.setString(8, format.format(currentTime.getTime()));
            pstmt.setString(9, newImage);
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        return -2; // 데이터베이스 오류
    }

    //  도서 삭제하기
    public int deleteBook(int bookID){
        String SQL = "delete from book where num=?";
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1,bookID);
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    // 책 정보 수정하기
    public int modifyBook(int bookID,int m_isbn, String m_bookTitle, String m_bookAuthor, String m_bookPublisher, String m_bookCategory, String m_borrowedState,String m_reservationState,String m_image){
        String SQL = "update book set isbn=?,book_title=?,book_author=?,book_publisher=?,book_category=?,book_is_borrowed=?,book_is_reservation=?,picture=? where num=?";
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1,m_isbn);
            pstmt.setString(2,m_bookTitle);
            pstmt.setString(3,m_bookAuthor);
            pstmt.setString(4,m_bookPublisher);
            pstmt.setString(5,m_bookCategory);
            pstmt.setString(6,m_borrowedState);
            pstmt.setString(7,m_reservationState);
            pstmt.setString(8,m_image);
            pstmt.setInt(9,bookID);
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

}