package finalTermProject.Screen;

import finalTermProject.DAO.BookDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LibraryUserController {

    @Autowired
    BookDao bookDao;

    // 메인페이지이자 도서목록
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

    // 예약하기
    @RequestMapping("/bookAction")
    public ModelAndView bookAction(ModelAndView mav){
        mav.setViewName("bookAction");
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

    // 신청 액션
    @RequestMapping("/applyNewBook")
    public ModelAndView applyNewBook(ModelAndView mav){
        mav.setViewName("applyNewBook");
        return mav;
    }

    // 신청 액션
    @RequestMapping("/likeAction")
    public ModelAndView likeAction(ModelAndView mav){
        mav.setViewName("likeAction");
        return mav;
    }



}
