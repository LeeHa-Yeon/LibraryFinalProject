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

    // 회원가입
    @RequestMapping("/join")
    public ModelAndView join(ModelAndView mav){
        mav.setViewName("join");  // join.jsp
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
            script.println("alert('There are items that have not been entered.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
        } else {
            int result = userDao.join(id,pwd,name,email,phone,ssn,address);
            if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('The ID that already exists.');");
                script.println("history.back();");
                script.println("</script>");
                script.close();
            }else{
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href = './login'");
                script.println("</script>");
                script.close();
            }
        }
        return mav;
    }

    // 로그인
    @RequestMapping("/login")
    public ModelAndView login(ModelAndView mav){
        mav.setViewName("login");
        return mav;
    }


    @RequestMapping("/loginAction") // 경로
    public ModelAndView loginAction(ModelAndView mav, HttpServletResponse response, HttpServletRequest request, @RequestParam(value = "userID", required = false) String id,
                              @RequestParam(value = "userPWD", required = false) String pwd) throws ServletException, IOException {
        mav.setViewName("loginAction");
        if (id.equals("") || pwd.equals("")) {
            PrintWriter script = response.getWriter();
            if (id.equals("")) {
                System.out.println("들어갔니222");
                script.println("<script>");
                script.println("alert('Please enter your ID');");
                script.println("history.back();");
                script.println("</script>");
                script.close();
            }else if (pwd.equals("")) {
                System.out.println("들어갔니");
                script.println("<script>");
                script.println("alert('Please enter your PASSWORD');");
                script.println("history.back();");
                script.println("</script>");
                script.close();
            }
        } else {
            String userID = null;
            HttpSession session = request.getSession();
            if(session.getAttribute("userID")!=null){
                userID = (String) session.getAttribute("userID");
            }
            if(userID!=null){
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('You are already logged in.');");
                script.println("location.href='main'");
                script.println("</script>");
            }
            int result = userDao.login(id, pwd);
            if (result == 1) {
                session.setAttribute("userID", id);
                if(id.equals("manager")) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("location.href='managerMain'");
                    script.println("</script>");
                    script.close();
                }else{
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("location.href='main'");
                    script.println("</script>");
                    script.close();
                }
            } else if (result == 0) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('The password is wrong.');");
                script.println("history.back();");
                script.println("</script>");
                script.close();
            } else if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('ID does not exist.');");
                script.println("history.back();");
                script.println("</script>");
                script.close();
            } else if (result == -2) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('Database error');");
                script.println("history.back();");
                script.println("</script>");
                script.close();
            }
        }
        return mav;
    }

    // 로그아웃
    @RequestMapping("/logout")
    public ModelAndView logout(ModelAndView mav, HttpServletResponse response) throws IOException {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그아웃되었습니다.');");
        script.println("location.href='login'");
        script.println("</script>");
        mav.setViewName("logout");
        return mav;
    }

    // 아이디 비번 찾기
    @RequestMapping("/find_info")
    public ModelAndView find_info(ModelAndView mav){
        mav.setViewName("find_info");
        return mav;
    }

    // 아이디 찾기
    @RequestMapping("/findIDAction")
    public ModelAndView findIDAction(ModelAndView mav){
        mav.setViewName("findIDAction");
        return mav;
    }
    // 비번 찾기
    @RequestMapping("/findPWDAction")
    public ModelAndView findPWDAction(ModelAndView mav){
        mav.setViewName("findPWDAction");
        return mav;
    }


    // 내 정보 화면
    @RequestMapping("/myInfo")
    public ModelAndView myInfo(ModelAndView mav){
        mav.setViewName("myInfo");
        return mav;
    }


    // 내 정보 수정
    @RequestMapping("/modifyInfo")
    public ModelAndView modifyInfo(ModelAndView mav){
        mav.setViewName("modifyInfo");
        return mav;
    }

    @RequestMapping("/modifyInfoAction")
    public ModelAndView modifyInfoAction(ModelAndView mav){
        mav.setViewName("modifyInfoAction");
        return mav;
    }

    // 비밀번호 변경
    @RequestMapping("/changePwd")
    public ModelAndView changePwd(ModelAndView mav){
        mav.setViewName("changePwd");
        return mav;
    }
    @RequestMapping("/changePwdAction")
    public ModelAndView changePwdAction(ModelAndView mav){
        mav.setViewName("changePwdAction");
        return mav;
    }


    // 내 대여 상태
    @RequestMapping("/myLendList")
    public ModelAndView myLendList(ModelAndView mav){
        mav.setViewName("myLendList");
        return mav;
    }


    // 회원 탈퇴
    @RequestMapping("/signout")
    public ModelAndView signout(ModelAndView mav, HttpServletResponse response) throws IOException {
        mav.setViewName("signout");
        return mav;
    }



}