package finalTermProject.DTO;

public class ApplyDto {
    private int apply_num;
    private int apply_isbn;  // 국제 표준 도서 번호
    private String apply_title;  // 책 제목
    private String apply_author;  // 저자(지은이)
    private String apply_publisher; // 출판사
    private String apply_category;   // 카테고리
    private String apply_userId;  // 요청고객
    private String apply_image;  // 이미지
    private String apply_state;  // 상태
    private String apply_Date;  // 요청날짜
    private String accept_Date; // 수락날짜

    public int getApply_num() {
        return apply_num;
    }

    public void setApply_num(int apply_num) {
        this.apply_num = apply_num;
    }

    public int getApply_isbn() {
        return apply_isbn;
    }

    public void setApply_isbn(int apply_isbn) {
        this.apply_isbn = apply_isbn;
    }

    public String getApply_title() {
        return apply_title;
    }

    public void setApply_title(String apply_title) {
        this.apply_title = apply_title;
    }

    public String getApply_author() {
        return apply_author;
    }

    public void setApply_author(String apply_author) {
        this.apply_author = apply_author;
    }

    public String getApply_publisher() {
        return apply_publisher;
    }

    public void setApply_publisher(String apply_publisher) {
        this.apply_publisher = apply_publisher;
    }

    public String getApply_category() {
        return apply_category;
    }

    public void setApply_category(String apply_category) {
        this.apply_category = apply_category;
    }

    public String getApply_userId() {
        return apply_userId;
    }

    public void setApply_userId(String apply_userId) {
        this.apply_userId = apply_userId;
    }

    public String getApply_image() {
        return apply_image;
    }

    public void setApply_image(String apply_image) {
        this.apply_image = apply_image;
    }

    public String getApply_state() {
        return apply_state;
    }

    public void setApply_state(String apply_state) {
        this.apply_state = apply_state;
    }

    public String getApply_Date() {
        return apply_Date;
    }

    public void setApply_Date(String apply_Date) {
        this.apply_Date = apply_Date;
    }

    public String getAccept_Date() {
        return accept_Date;
    }

    public void setAccept_Date(String accept_Date) {
        this.accept_Date = accept_Date;
    }
}
