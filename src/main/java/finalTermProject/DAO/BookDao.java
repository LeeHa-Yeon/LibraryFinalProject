package finalTermProject.DAO;

import finalTermProject.DTO.BookDto;

import java.awt.print.Book;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
                return bookDto;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

}
