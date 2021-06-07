package finalTermProject.Screen;

import finalTermProject.DAO.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LibraryManagerController {

    // 메인페이지이자 도서목록
    @RequestMapping("/managerMain")
    public ModelAndView managerMain(ModelAndView mav){
        mav.setViewName("managerMain");
        return mav;
    }

    // 도서 정보 보기
    @RequestMapping("/managerShowBook")
    public ModelAndView managerShowBook(ModelAndView mav){
        mav.setViewName("managerShowBook");
        return mav;
    }

    // 새 도서 등록
    @RequestMapping("/managerAddBook")
    public ModelAndView managerAddBook(ModelAndView mav){
        mav.setViewName("managerAddBook");
        return mav;
    }

    // 도서 삭제
    @RequestMapping("/managerDeleteBook")
    public ModelAndView managerDeleteBook(ModelAndView mav){
        mav.setViewName("managerDeleteBook");
        return mav;
    }

    // 도서 수정
    @RequestMapping("/managerModifyBook")
    public ModelAndView managerModifyBook(ModelAndView mav){
        mav.setViewName("managerModifyBook");
        return mav;
    }

    @RequestMapping("/managerModifyBookAction")
    public ModelAndView managerModifyBookAction(ModelAndView mav){
        mav.setViewName("managerModifyBookAction");
        return mav;
    }

    // 모든 고객 대여 리스트
    @RequestMapping("/managerUserApplyList")
    public ModelAndView managerUserApplyList(ModelAndView mav){
        mav.setViewName("managerUserApplyList");
        return mav;
    }

    // 고객 희망 신청 리스트
    @RequestMapping("/managerUserLendList")
    public ModelAndView managerUserLendList(ModelAndView mav){
        mav.setViewName("managerUserLendList");
        return mav;
    }

    // 도서 신청 추가
    @RequestMapping("/managerApplyAdd")
    public ModelAndView managerApplyAdd(ModelAndView mav){
        mav.setViewName("managerApplyAdd");
        return mav;
    }

    // 도서 신청 삭제
    @RequestMapping("/managerApplyDelete")
    public ModelAndView managerApplyDelete(ModelAndView mav){
        mav.setViewName("managerApplyDelete");
        return mav;
    }

    // 모든 고객 관리 리스트
    @RequestMapping("/managerUserList")
    public ModelAndView managerUserList(ModelAndView mav){
        mav.setViewName("managerUserList");
        return mav;
    }

    // 회원 삭제
    @RequestMapping("/deleteUser")
    public ModelAndView deleteUser(ModelAndView mav){
        mav.setViewName("deleteUser");
        return mav;
    }


    // 댓글 삭제
    @RequestMapping("/managerCommentDelete")
    public ModelAndView managerCommentDelete(ModelAndView mav){
        mav.setViewName("managerCommentDelete");
        return mav;
    }


}
