package servlet;

import service.ContactService;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/contacts")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();

        req.setAttribute("contacts", ContactService.getAll());
        req.getRequestDispatcher("/WEB-INF/views/contact-list.jsp").forward(req, resp);
    }
}
