package finalTermProject.Screen;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class InitController {
    @GetMapping("/")
    public String init(Model model){
        return "index";
    }
}
