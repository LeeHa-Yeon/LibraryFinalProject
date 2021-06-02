package finalTermProject.DAO;

import finalTermProject.DTO.BookDto;
import finalTermProject.DTO.UserDto;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

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

    public UserDto getUserInfo(String myID) {
        String SQL = "select * from member where ID = ?";
        try {

            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, myID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                UserDto userDto = new UserDto();
                userDto.setNum(rs.getInt(1));
                userDto.setID(rs.getString(2));
                userDto.setPwd(rs.getString(3));
                userDto.setName(rs.getString(4));
                userDto.setEmail(rs.getString(5));
                userDto.setPhone(rs.getString(6));
                userDto.setSSN(rs.getString(7));
                userDto.setAddress(rs.getString(8));
                userDto.setPoint(rs.getInt(9));
                userDto.setIsOverdue(rs.getString(10));
                userDto.setBorrowedLimit(rs.getInt(11));
                return userDto;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public int modifyInfo(String userID, String modifyName, String modifyEmail, String modifyPhone, String modifySSN, String modifyAddress){
        String SQL = "update member set name=?,email=?,phone=?,SSN=?,address=? where ID=?";
        try{
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,modifyName);
            pstmt.setString(2,modifyEmail);
            pstmt.setString(3,modifyPhone);
            pstmt.setString(4,modifySSN);
            pstmt.setString(5,modifyAddress);
            pstmt.setString(6,userID);
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    public String findID(String inputName, String inputPhone, String inputSSN){
        String SQL = "select ID from member where name =? and phone =? and SSN = ? ";
        try{
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,inputName);
            pstmt.setString(2,inputPhone);
            pstmt.setString(3,inputSSN);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getString(1);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return "";
    }

    public String findPWD(String inputID, String inputPhone, String inputSSN){
        String SQL = "select pwd from member where ID =? and phone =? and SSN = ? ";
        try{
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,inputID);
            pstmt.setString(2,inputPhone);
            pstmt.setString(3,inputSSN);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getString(1);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return "";
    }

    public int signout(String userID){
        String SQL = "delete from member where ID = ?";
        try{
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,userID);
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    public int changePwd(String userID, String oldPwd, String newPwd){
        String SQL = "update member set pwd=? where ID=? and pwd=?";
        try{
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,newPwd);
            pstmt.setString(2,userID);
            pstmt.setString(3,oldPwd);
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    //    member의 대여가능횟수 차감
    public int lendCntChange(String userID,int changeCnt){
        String SQL = "update member set borrowedLimit=? where ID=?";
        try{
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1,changeCnt);
            pstmt.setString(2,userID);
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    // 멤버 연체 상태 변경하기
    public int changeOverdueState(String userID){
        String SQL = "update member set isOverdue=? where ID=?";
        try{
            Calendar cal = Calendar.getInstance();
            SimpleDateFormat format1 = new SimpleDateFormat("yyy-MM-dd");
            cal.add(cal.DATE,+7);
            String overdueDate = format1.format(cal.getTime());

            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,overdueDate);
            pstmt.setString(2,userID);
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    // 멤버 정상 상태 변경하기
    public int changeNormalState(String userID){
        String SQL = "update member set isOverdue=? where ID=?";
        try{
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,"정상");
            pstmt.setString(2,userID);
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }






}
