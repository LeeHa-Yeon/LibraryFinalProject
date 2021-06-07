package finalTermProject.DTO;

import java.util.ArrayList;

public class UserDto {
    private int num; //
    private String ID;  // 아이디
    private String pwd;  // 비밀번호
    private String name;  // 이름
    private String email; // 이메일
    private String phone; // 핸드폰번호
    private String SSN;  // 주민등번
    private String address;  // 주소
    private int point;  // 포인트
    private String isOverdue;  // 연체여부
    private int borrowedLimit;  // 대출 제한 수
    private String REGDATE;  // 회원가입날짜
    private String grade;  // 등급

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getSSN() {
        return SSN;
    }

    public void setSSN(String SSN) {
        this.SSN = SSN;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public String getIsOverdue() {
        return isOverdue;
    }

    public void setIsOverdue(String isOverdue) {
        this.isOverdue = isOverdue;
    }

    public int getBorrowedLimit() {
        return borrowedLimit;
    }

    public void setBorrowedLimit(int borrowedLimit) {
        this.borrowedLimit = borrowedLimit;
    }

    public String getREGDATE() {
        return REGDATE;
    }

    public void setREGDATE(String REGDATE) {
        this.REGDATE = REGDATE;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }
}
