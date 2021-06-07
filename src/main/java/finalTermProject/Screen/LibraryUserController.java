package finalTermProject.Screen;

import finalTermProject.DAO.BookDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LibraryUserController {

    // 메인 페이지
    @RequestMapping("/main")
    public ModelAndView main(ModelAndView mav){
        mav.setViewName("main");
        return mav;
    }

    //도서목록
    @RequestMapping("/bookList")
    public ModelAndView bookList(ModelAndView mav){
        mav.setViewName("bookList");
        return mav;
    }

    // 도서 상세페이지
    @RequestMapping("/bookShow")
    public ModelAndView bookShow(ModelAndView mav){
        mav.setViewName("bookShow");
        return mav;
    }

    // 대여하기
    @RequestMapping("/lendAction")
    public ModelAndView lendAction(ModelAndView mav){
        mav.setViewName("lendAction");
        return mav;
    }

    // 반납하기
    @RequestMapping("/returnAction")
    public ModelAndView returnAction(ModelAndView mav){
        mav.setViewName("returnAction");
        return mav;
    }

    // 연장하기
    @RequestMapping("/extendAction")
    public ModelAndView extendAction(ModelAndView mav){
        mav.setViewName("extendAction");
        return mav;
    }

    // 신청 리스트 보기
    @RequestMapping("/applyList")
    public ModelAndView applyList(ModelAndView mav){
        mav.setViewName("applyList");
        return mav;
    }

    // 희망 도서 신청하기
    @RequestMapping("/applyNewBook")
    public ModelAndView applyNewBook(ModelAndView mav){
        mav.setViewName("applyNewBook");
        return mav;
    }

    // 좋아요
    @RequestMapping("/likeAction")
    public ModelAndView likeAction(ModelAndView mav){
        mav.setViewName("likeAction");
        return mav;
    }

    // 리뷰달기
    @RequestMapping("/commentAction")
    public ModelAndView commentAction(ModelAndView mav){
        mav.setViewName("commentAction");
        return mav;
    }

    // 리뷰수정
    @RequestMapping("/commentModify")
    public ModelAndView commentModify(ModelAndView mav){
        mav.setViewName("commentModify");
        return mav;
    }

    // 리뷰삭제
    @RequestMapping("/commentDelete")
    public ModelAndView commentDelete(ModelAndView mav){
        mav.setViewName("commentDelete");
        return mav;
    }

    // 예약하기
    @RequestMapping("/reservationAction")
    public ModelAndView reservationAction(ModelAndView mav){
        mav.setViewName("reservationAction");
        return mav;
    }

    // 예약하게 될 경우 행동
    @RequestMapping("/reservation")
    public ModelAndView reservation(ModelAndView mav){
        mav.setViewName("reservation");
        return mav;
    }
    // 예약 취소
    @RequestMapping("/cancleReservate")
    public ModelAndView cancleReservate(ModelAndView mav){
        mav.setViewName("cancleReservate");
        return mav;
    }

}
