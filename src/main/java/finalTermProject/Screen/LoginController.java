package finalTermProject.Screen;

import finalTermProject.DAO.UserDao;
import finalTermProject.DTO.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
public class LoginController {
    @Autowired
    UserDao userDao;
    UserDto userDto;

    @RequestMapping("/join")
    public ModelAndView join(ModelAndView mav){
        mav.setViewName("join");  // login.jsp
        return mav;
    }

    @RequestMapping("/joinAction") // 경로
    public ModelAndView joinAction(ModelAndView mav, HttpServletResponse response, HttpServletRequest request,
                                   @RequestParam(value = "userID", required = false) String id,
                                    @RequestParam(value = "userPWD", required = false) String pwd,
                                   @RequestParam(value = "userPwdCheck", required = false) String pwdCheck,
                                   @RequestParam(value = "userName", required = false) String name,
                                   @RequestParam(value = "userEmail", required = false) String email,
                                   @RequestParam(value = "userPhone", required = false) String phone,
                                   @RequestParam(value = "userAddress", required = false) String address,
                                   @RequestParam(value = "userSSN", required = false) String ssn
                                   ) throws ServletException, IOException {
        mav.setViewName("joinAction");
        if (id.equals("") || pwd.equals("")|| pwdCheck.equals("")|| name.equals("") || email.equals("") || phone.equals("")|| address.equals("")|| ssn.equals("")) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력안된사항 있음');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
        } else {
            int result = userDao.join(id,pwd,name,email,phone,ssn,address);
            if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('이미 존재하는 아이디');");
                script.println("history.back();");
                script.println("</script>");
                script.close();
            }else{
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href = 'main'");
                script.println("</script>");
            }
        }
        return mav;
    }


    @RequestMapping("/login")
    public ModelAndView login(ModelAndView mav){
        mav.setViewName("login");  // login.jsp
        return mav;
    }

    @RequestMapping("/main")
    public ModelAndView main(ModelAndView mav){
        mav.setViewName("main");  // login.jsp
        return mav;
    }

    @RequestMapping("/bbs")
    public ModelAndView bbs(ModelAndView mav){
        mav.setViewName("bbs");  // login.jsp
        return mav;
    }

    @RequestMapping("/find_info")
    public ModelAndView find_info(ModelAndView mav){
        mav.setViewName("find_info");  // login.jsp
        return mav;
    }

    @RequestMapping("/loginAction") // 경로
    public ModelAndView loginAction(ModelAndView mav, HttpServletResponse response, HttpServletRequest request, @RequestParam(value = "userID", required = false) String id,
                              @RequestParam(value = "userPWD", required = false) String pwd) throws ServletException, IOException {
        mav.setViewName("loginAction");
        if (id.equals("") || pwd.equals("")) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('모두 입력해주세요.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
        } else {
            String userID = null;
            HttpSession session = request.getSession();
            if(session.getAttribute("userID")!=null){
                userID = (String) session.getAttribute("userID");
            }
            if(userID!=null){
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('이미 로그인이 되어있습니다.');");
                script.println("location.href='main'");
                script.println("</script>");
            }
            int result = userDao.login(id, pwd);
            if (result == 1) {
                session.setAttribute("userID", id);
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('login success 로그인이 성공했습니다.');");
                script.println("location.href='main'");
                script.println("</script>");
                script.close();
            } else if (result == 0) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('비밀번호가 틀렸습니다.');");
                script.println("history.back();");
                script.println("</script>");
                script.close();
            } else if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('아이디가 틀렸습니다.');");
                script.println("history.back();");
                script.println("</script>");
                script.close();
            } else if (result == -2) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('데이터베이스 에러');");
                script.println("history.back();");
                script.println("</script>");
                script.close();
            }
        }
        return mav;
    }
    @RequestMapping("/logout")
    public ModelAndView logout(ModelAndView mav, HttpServletResponse response) throws IOException {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그아웃되었습니다.');");
        script.println("location.href='main'");
        script.println("</script>");
        mav.setViewName("logout");
        return mav;
    }
}