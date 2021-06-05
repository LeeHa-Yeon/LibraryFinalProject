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
            String dbURL = "jdbc:mysql://localhost/library?characterEncoding=utf8&serverTimezone=UTC";
            String dbID = "library";
            String dbPwd = "library123";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPwd);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 현재 날짜,시간 추출
    public String getDate() {
        String SQL = "Select now()";
        try {
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

    // 페이징
    public int getNext() {
        String SQL = "Select num from book order by num desc";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
            // 첫번째 게시물인 경우
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 책 목록 보기
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

    public boolean nextPage(int pageNumber) {
        String SQL = "select * from book where num<?";
        ArrayList<BookDto> list = new ArrayList<BookDto>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 3);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
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

    // 내 예약 상태 보기
    public ArrayList<ReservatDto> getResiInfo(String userID) {
        String SQL = "select * from reservatList where book_user_id = ? order by book_date";
        ArrayList<ReservatDto> list = new ArrayList<ReservatDto>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ReservatDto reservatDto = new ReservatDto();
                reservatDto.setReservat_num(rs.getInt(1));
                reservatDto.setBook_book_id(rs.getInt(2));
                reservatDto.setBook_book_title(rs.getString(3));
                reservatDto.setBook_user_id(rs.getString(4));
                reservatDto.setBook_date(rs.getString(5));
                reservatDto.setState(rs.getString(6));
                list.add(reservatDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }



    // 내 대여 상태 보기
    public ArrayList<LendDto> getLendInfo(String userID) {
        String SQL = "select * from lendAllList where lend_user_id = ?";
        ArrayList<LendDto> list = new ArrayList<LendDto>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                LendDto lendDto = new LendDto();
                lendDto.setLend_book_id(rs.getInt(2));
                lendDto.setLend_book_title(rs.getString(3));
                lendDto.setLend_user_id(rs.getString(4));
                lendDto.setLend_date(rs.getString(5));
                lendDto.setReturn_date(rs.getString(6));
                list.add(lendDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 내 대여 상태 보기
    public ArrayList<LendDto> getLendSize(int bookID) {
        String SQL = "select * from lendAllList where lend_book_id = ?";
        ArrayList<LendDto> list = new ArrayList<LendDto>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bookID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                LendDto lendDto = new LendDto();
                lendDto.setLend_book_id(rs.getInt(2));
                lendDto.setLend_book_title(rs.getString(3));
                lendDto.setLend_user_id(rs.getString(4));
                lendDto.setLend_date(rs.getString(5));
                lendDto.setReturn_date(rs.getString(6));
                list.add(lendDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 모든 고객 대여 상태 보기
    public ArrayList<LendDto> allLendInfo(int pageNumber) {
        String SQL = "select * from lendAllList order by num desc limit " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
        ArrayList<LendDto> list = new ArrayList<LendDto>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                LendDto lendDto = new LendDto();
                lendDto.setLend_book_id(rs.getInt(2));
                lendDto.setLend_book_title(rs.getString(3));
                lendDto.setLend_user_id(rs.getString(4));
                lendDto.setLend_date(rs.getString(5));
                lendDto.setReturn_date(rs.getString(6));
                list.add(lendDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    public int insertLendInfo(int lend_bookID, String lend_bookTitle, String lend_userID) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar currentTime = Calendar.getInstance();
        Calendar week = Calendar.getInstance();
        week.add(Calendar.DATE, +7);
        String SQL = "insert into lendAllList (lend_book_id,lend_book_title,lend_user_id,lend_date,return_date) values (?,?,?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, lend_bookID);
            pstmt.setString(2, lend_bookTitle);
            pstmt.setString(3, lend_userID);
            pstmt.setString(4, format.format(currentTime.getTime()));
            pstmt.setString(5, format.format(week.getTime()));
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // 데이터베이스 오류
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


    //  대여 항목 제거하기
    public int deleteLendBook(int bookID) {
        String SQL = "delete from lendAllList where lend_book_id=?";
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 새 도서 등록하기
    public int addNewBook(int newIsbn, String newTitle, String newAuthor, String newPublisher, String newCategory, String newImage) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar currentTime = Calendar.getInstance();
        String SQL = "insert into book (isbn,book_title,book_author,book_publisher,book_category,book_is_borrowed,book_is_reservation,REGDATE,picture) values (?,?,?,?,?,?,?,?,?)";
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
            pstmt.setString(9, newImage);
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

    // 대여 연장하기
    public int extensionDate(int bookID, String addDate) {
        String SQL = "update lendAllList set return_date=? where lend_book_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, addDate);
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

    // 모든 고객 정보 보기
    public ArrayList<ApplyDto> allApplyList(int pageNumber) {
        String SQL = "select * from applyList order by num desc limit " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
        ArrayList<ApplyDto> list = new ArrayList<ApplyDto>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ApplyDto applyDto = new ApplyDto();
                applyDto.setApply_num(rs.getInt(1));
                applyDto.setApply_isbn(rs.getInt(2));
                applyDto.setApply_title(rs.getString(3));
                applyDto.setApply_author(rs.getString(4));
                applyDto.setApply_publisher(rs.getString(5));
                applyDto.setApply_category(rs.getString(6));
                applyDto.setApply_userId(rs.getString(7));
                applyDto.setApply_image(rs.getString(8));
                applyDto.setApply_state(rs.getString(9));
                applyDto.setApply_Date(rs.getString(10));
                applyDto.setAccept_Date(rs.getString(11));
                list.add(applyDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 도서 신청하기
    public int applyBook(int applyIsbn, String applyTitle, String applyAuthor, String applyPublisher, String applyCategory, String apply_user, String applyImage) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar currentTime = Calendar.getInstance();

        String SQL = "insert into applyList (isbn,book_title,book_author,book_publisher,book_category,apply_user,image,state,applyDate,acceptDate) values (?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, applyIsbn);
            pstmt.setString(2, applyTitle);
            pstmt.setString(3, applyAuthor);
            pstmt.setString(4, applyPublisher);
            pstmt.setString(5, applyCategory);
            pstmt.setString(6, apply_user);
            pstmt.setString(7, applyImage);
            pstmt.setString(8, "대기중");
            pstmt.setString(9, format.format(currentTime.getTime()));
            pstmt.setString(10, " ");
            System.out.println(pstmt);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // 데이터베이스 오류
    }

    // 책 정보 수정하기
    public int updateApplyInfo(int applyID) {
        String SQL = "update applyList set state=?,acceptDate=? where num=?";
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Calendar currentTime = Calendar.getInstance();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, "입고 완료");
            pstmt.setString(2, format.format(currentTime.getTime()));
            pstmt.setInt(3, applyID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    //  대여 항목 제거하기
    public int deleteApplyBook(int applyID) {
        String SQL = "delete from applyList where num=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, applyID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }

    // 신청도서 보기
    public ApplyDto getApplyInfo(int applyNum) {
        String SQL = "select * from applyList where num = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, applyNum);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ApplyDto applyDto = new ApplyDto();
                applyDto.setApply_num(rs.getInt(1));
                applyDto.setApply_isbn(rs.getInt(2));
                applyDto.setApply_title(rs.getString(3));
                applyDto.setApply_author(rs.getString(4));
                applyDto.setApply_publisher(rs.getString(5));
                applyDto.setApply_category(rs.getString(6));
                applyDto.setApply_userId(rs.getString(7));
                applyDto.setApply_image(rs.getString(8));
                return applyDto;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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

    // 대여카운트 증가하기
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

    // 추천카운트 증가하기
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

    // 인기 도서  top 5( 대여 횟수 )
    public ArrayList<BookDto> popularBookTop5() {
        String SQL = "select * from book order by lendCnt desc limit 5";
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

    // 사람들 추천 도서  top 3( 좋아요 횟수 )
    public ArrayList<BookDto> recommendedBookTop3() {
        String SQL = "select * from book order by likes desc limit 3";
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


    // 검색한 결과만 출력
    // 정렬한 검색도 같이 출력
    public ArrayList<BookDto> getSearchList(String SearchDivide, String searchType, String search, int pageNumber2) {
        // 전체, 제목, 저자, 기타
        ArrayList<BookDto> bookSearchList = new ArrayList<>();
        //최신순, 좋아요순, 추천순, 조회순
        String SQL = "";
        if (searchType.equals("최신순")) {
            if (SearchDivide.equals("전체")) {
                SQL = "select * from book where CONCAT (book_title,book_author) LIKE " +
                        "? order by num desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;
            } else if (SearchDivide.equals("제목")) {
                SQL = "select * from book where CONCAT (book_title) LIKE " +
                        "? order by num desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;
            } else if (SearchDivide.equals("저자")) {
                SQL = "select * from book where CONCAT (book_author) LIKE " +
                        "? order by num desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;
            } else if (SearchDivide.equals("기타")) {
                SQL = "select * from book where CONCAT (num,isbn,book_publisher,book_category,book_is_borrowed) LIKE " +
                        "? order by num desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;
            }
        } else if (searchType.equals("인기순")) {
            if (SearchDivide.equals("전체")) {
                SQL = "select * from book where CONCAT (book_title,book_author) LIKE " +
                        "? order by lendCnt desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;

            } else if (SearchDivide.equals("제목")) {
                SQL = "select * from book where CONCAT (book_title) LIKE " +
                        "? order by lendCnt desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;

            } else if (SearchDivide.equals("저자")) {
                SQL = "select * from book where CONCAT (book_author) LIKE " +
                        "? order by lendCnt desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;

            } else if (SearchDivide.equals("기타")) {
                SQL = "select * from book where CONCAT (num,isbn,book_publisher,book_category,book_is_borrowed) LIKE " +
                        "? order by lendCnt desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;
            }

        } else if (searchType.equals("추천순")) {
            if (SearchDivide.equals("전체")) {
                SQL = "select * from book where CONCAT (book_title,book_author) LIKE " +
                        "? order by likes desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;

            } else if (SearchDivide.equals("제목")) {
                SQL = "select * from book where CONCAT (book_title) LIKE " +
                        "? order by likes desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;

            } else if (SearchDivide.equals("저자")) {
                SQL = "select * from book where CONCAT (book_author) LIKE " +
                        "? order by likes desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;

            } else if (SearchDivide.equals("기타")) {
                SQL = "select * from book where CONCAT (num,isbn,book_publisher,book_category,book_is_borrowed) LIKE " +
                        "? order by likes desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;

            }

        } else if (searchType.equals("조회순")) {
            if (SearchDivide.equals("전체")) {
                SQL = "select * from book where CONCAT (book_title,book_author) LIKE " +
                        "? order by views desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;

            } else if (SearchDivide.equals("제목")) {
                SQL = "select * from book where CONCAT (book_title) LIKE " +
                        "? order by views desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;

            } else if (SearchDivide.equals("저자")) {
                SQL = "select * from book where CONCAT (book_author) LIKE " +
                        "? order by views desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;

            } else if (SearchDivide.equals("기타")) {
                SQL = "select * from book where CONCAT (num,isbn,book_publisher,book_category,book_is_borrowed) LIKE " +
                        "? order by views desc limit " + pageNumber2 * 5 + ", " + pageNumber2 * 5 + 6;

            }
        }
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, "%" + search + "%");
            rs = pstmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    BookDto bookSearchDto = new BookDto();
                    bookSearchDto.setBook_num(rs.getInt(1));
                    bookSearchDto.setBook_ISBN(rs.getInt(2));
                    bookSearchDto.setBook_title(rs.getString(3));
                    bookSearchDto.setBook_author(rs.getString(4));
                    bookSearchDto.setBook_publisher(rs.getString(5));
                    bookSearchDto.setBook_category(rs.getString(6));
                    bookSearchDto.setIs_book_borrowed(rs.getString(7));
                    bookSearchDto.setIs_book_reservation(rs.getString(8));
                    bookSearchDto.setRegisteDate(rs.getString(9));
                    bookSearchDto.setBook_image(rs.getString(10));
                    bookSearchDto.setViews(rs.getInt(11));
                    bookSearchDto.setLendCnt(rs.getInt(12));
                    bookSearchDto.setLikes(rs.getInt(13));
                    bookSearchList.add(bookSearchDto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookSearchList;
    }


    public int insertReservInfo(int bookID, String bookTitle, String userID,String book_date) {
        String SQL = "insert into reservatList (book_book_id,book_book_title,book_user_id,book_date,state) values (?,?,?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bookID);
            pstmt.setString(2, bookTitle);
            pstmt.setString(3, userID);
            pstmt.setString(4, book_date);
            pstmt.setString(5, "예약");
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // 데이터베이스 오류
    }

    //  대여 항목 제거하기
    public int cancleReservation(int reserID) {
        String SQL = "delete from reservatList where num=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, reserID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 데이터베이스 오류
        return -1;
    }


}