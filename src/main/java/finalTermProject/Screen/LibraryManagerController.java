package finalTermProject.Screen;

import finalTermProject.DAO.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LibraryManagerController {

    @Autowired
    UserDao userDao;

    @RequestMapping("/bookList")
    public ModelAndView bookList(ModelAndView mav){
        mav.setViewName("bookList");
        return mav;
    }

    @RequestMapping("/bbs")
    public ModelAndView bbs(ModelAndView mav){
        mav.setViewName("bbs");
        return mav;
    }
}
