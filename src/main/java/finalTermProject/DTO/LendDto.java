package finalTermProject.DTO;

public class LendDto {
    private int lend_num; //고유키
    private int lend_book_id;  // 빌린책고유의key
    private String lend_book_title; // 빌린책 제목
    private String lend_user_id;  // 빌린사람이름
    private String lend_date;  // 대출일
    private String return_date; // 반납일

    public String getLend_book_title() {
        return lend_book_title;
    }

    public void setLend_book_title(String lend_book_title) {
        this.lend_book_title = lend_book_title;
    }

    public int getLend_num() {
        return lend_num;
    }

    public void setLend_num(int lend_num) {
        this.lend_num = lend_num;
    }

    public int getLend_book_id() {
        return lend_book_id;
    }

    public void setLend_book_id(int lend_book_id) {
        this.lend_book_id = lend_book_id;
    }

    public String getLend_user_id() {
        return lend_user_id;
    }

    public void setLend_user_id(String lend_user_id) {
        this.lend_user_id = lend_user_id;
    }

    public String getLend_date() {
        return lend_date;
    }

    public void setLend_date(String lend_date) {
        this.lend_date = lend_date;
    }

    public String getReturn_date() {
        return return_date;
    }

    public void setReturn_date(String return_date) {
        this.return_date = return_date;
    }
}
