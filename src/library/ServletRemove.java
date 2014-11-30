package library;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name="remove", urlPatterns={"/remove"})
public class ServletRemove extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String md5 = request.getParameter("md5");
        library.MetaCenter.remove(md5);
        response.sendRedirect("index.jsp");
    }
}
