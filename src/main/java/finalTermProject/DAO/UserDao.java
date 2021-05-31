package finalTermProject.DAO;

import finalTermProject.DTO.UserDto;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class UserDao {
    // dao : 데이터베이스 접근 객체 약자
    // 실질적으로 디비에서 회원정보를 불러오거나, 넣고자할때 사용
    // 데이터베이스에 접근하기 위한 객체
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public UserDao(){
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

    public int join(String userID,String userPwd,String userName, String userEmail, String userPhone, String userSSN, String userAddress){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar currentTime = Calendar.getInstance();
        String SQL = "insert into member (ID,pwd,name,email,phone,SSN,address,point,isOverdue,borrowedLimit,REGDATE) values (?,?,?,?,?,?,?,?,?,?,?)";
        try{
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            pstmt.setString(2, userPwd);
            pstmt.setString(3, userName);
            pstmt.setString(4, userEmail);
            pstmt.setString(5, userPhone);
            pstmt.setString(6, userSSN);
            pstmt.setString(7, userAddress);
            pstmt.setString(8, String.valueOf(0));
            pstmt.setString(9, "정상");
            pstmt.setString(10, String.valueOf(3));
            pstmt.setString(11, format.format(currentTime.getTime()));
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        return -2; // 데이터베이스 오류
    }

    public int login(String userID,String userPwd){
        String SQL = "select pwd from member where id = ?";
        try{
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,userID);
            rs = pstmt.executeQuery();
            // 아이디가 있음
            if(rs.next()){
                if(rs.getString(1).equals(userPwd))
                    return 1;  // 로그인 성공
                else
                    return 0;  // 비밀번호 불일치
            }
            return -1; // 아이디가 없음
        }catch (Exception e){
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -2;
    }

}
