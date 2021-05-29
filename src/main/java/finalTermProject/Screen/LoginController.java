package finalTermProject.Screen;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {
    @RequestMapping("/login")
    public ModelAndView login(ModelAndView mav){
        mav.setViewName("login");  // login.jsp
        return mav;
    }

}
