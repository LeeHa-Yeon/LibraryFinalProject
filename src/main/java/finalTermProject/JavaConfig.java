package finalTermProject;

import finalTermProject.DAO.BookDao;
import finalTermProject.DAO.CommentDao;
import finalTermProject.DAO.LibraryDao;
import finalTermProject.DAO.UserDao;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class JavaConfig {

    @Bean
    public UserDao userDao() {
        return new UserDao();
    }

    @Bean
    public BookDao bookDao() {
        return new BookDao();
    }

    @Bean
    public CommentDao commentDao() {
        return new CommentDao();
    }
    @Bean
    public LibraryDao libraryDao() {
        return new LibraryDao();
    }
}