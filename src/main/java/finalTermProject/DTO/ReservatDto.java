package finalTermProject.DTO;

public class ReservatDto {
    private int reservat_num; // 예약 고유키
    private int book_book_id;  // 예약된 책 고유의 키
    private String book_book_title; // 예약된 책이름
    private String book_user_id;  // 예약자
    private String book_date;  // 예약일
    private String state; // 상태

    public int getReservat_num() {
        return reservat_num;
    }

    public void setReservat_num(int reservat_num) {
        this.reservat_num = reservat_num;
    }

    public int getBook_book_id() {
        return book_book_id;
    }

    public void setBook_book_id(int book_book_id) {
        this.book_book_id = book_book_id;
    }

    public String getBook_book_title() {
        return book_book_title;
    }

    public void setBook_book_title(String book_book_title) {
        this.book_book_title = book_book_title;
    }

    public String getBook_user_id() {
        return book_user_id;
    }

    public void setBook_user_id(String book_user_id) {
        this.book_user_id = book_user_id;
    }

    public String getBook_date() {
        return book_date;
    }

    public void setBook_date(String book_date) {
        this.book_date = book_date;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
