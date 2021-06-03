package finalTermProject.DTO;

public class BookDto {
    private int book_num;
    private int book_ISBN;  // 국제 표준 도서 번호
    private String book_title;  // 책 제목
    private String book_author;  // 저자(지은이)
    private String book_publisher; // 출판사
    private String book_category;   // 카테고리
    private String is_book_borrowed;  // 대여가능여부
    private String is_book_reservation;  // 예약중인지 아닌지
    private String registeDate;
    private String book_image;  // 책 이미지
    private int views;
    private int lendCnt;
    private int likes;


    public int getBook_num() {
        return book_num;
    }

    public void setBook_num(int book_num) {
        this.book_num = book_num;
    }

    public int getBook_ISBN() {
        return book_ISBN;
    }

    public void setBook_ISBN(int book_ISBN) {
        this.book_ISBN = book_ISBN;
    }

    public String getBook_title() {
        return book_title;
    }

    public void setBook_title(String book_title) {
        this.book_title = book_title;
    }

    public String getBook_author() {
        return book_author;
    }

    public void setBook_author(String book_author) {
        this.book_author = book_author;
    }

    public String getBook_publisher() {
        return book_publisher;
    }

    public void setBook_publisher(String book_publisher) {
        this.book_publisher = book_publisher;
    }

    public String getBook_category() {
        return book_category;
    }

    public void setBook_category(String book_category) {
        this.book_category = book_category;
    }

    public String getIs_book_borrowed() {
        return is_book_borrowed;
    }

    public void setIs_book_borrowed(String is_book_borrowed) {
        this.is_book_borrowed = is_book_borrowed;
    }

    public String getIs_book_reservation() {
        return is_book_reservation;
    }

    public void setIs_book_reservation(String is_book_reservation) {
        this.is_book_reservation = is_book_reservation;
    }

    public String getBook_image() {
        return book_image;
    }

    public void setBook_image(String book_image) {
        this.book_image = book_image;
    }

    public String getRegisteDate() {
        return registeDate;
    }

    public void setRegisteDate(String registeDate) {
        this.registeDate = registeDate;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public int getLendCnt() {
        return lendCnt;
    }

    public void setLendCnt(int lendCnt) {
        this.lendCnt = lendCnt;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }
}
