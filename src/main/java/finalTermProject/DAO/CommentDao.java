package finalTermProject.DAO;

import finalTermProject.DTO.BookDto;
import finalTermProject.DTO.CommentDto;
import finalTermProject.DTO.LendDto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

public class CommentDao {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    // 디비 접속
    public CommentDao() {
        try {
            String dbURL = "jdbc:mysql://localhost/library?characterEncoding=utf8&serverTimezone=UTC";
            String dbID = "library";
            String dbPwd = "library123";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPwd);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public CommentDto getCommentlist(int bookID) {
        String SQL = "select * from comment where book_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bookID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CommentDto commentDto = new CommentDto();
                commentDto.setComment_num(rs.getInt(1));
                commentDto.setBook_id(rs.getInt(2));
                commentDto.setUser_id(rs.getString(3));
                commentDto.setContent(rs.getString(4));
                commentDto.setRegister_date(rs.getString(5));
                return commentDto;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int insertComment(int book_id, String user_id,String content){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar currentTime = Calendar.getInstance();

        String SQL = "insert into comment (book_id,user_id,content,registerDate) values (?,?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, book_id);
            pstmt.setString(2, user_id);
            pstmt.setString(3, content);
            pstmt.setString(4, format.format(currentTime.getTime()));
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // 데이터베이스 오류
    }

    public ArrayList<CommentDto> getcommentList(int book_id) {
        String SQL = "SELECT * FROM comment WHERE book_id=?";
        ArrayList<CommentDto> list = new ArrayList<CommentDto>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, book_id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CommentDto commentDto = new CommentDto();
                commentDto.setComment_num(rs.getInt(1));
                commentDto.setBook_id(rs.getInt(2));
                commentDto.setUser_id(rs.getString(3));
                commentDto.setContent(rs.getString(4));
                commentDto.setRegister_date(rs.getString(5));
                list.add(commentDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //  코멘트 삭제하기
    public int deleteComment(int commentID) {
        String SQL = "delete from comment where num=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, commentID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    // 코멘트 수정하기
    public int modifyComment(int commentNum, String content){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar currentTime = Calendar.getInstance();

        String SQL = "update comment set content=?,registerDate=? where num=?";
        try{
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,content);
            pstmt.setString(2,format.format(currentTime.getTime()));
            pstmt.setInt(3,commentNum);
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

}
