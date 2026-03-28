package servlet;

import dao.ContactDAO;
import dao.ContactDAOImpl;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet("/contacts")
public class ContactServlet extends HttpServlet {

    private static final Logger log = Logger.getLogger(ContactServlet.class.getName());
    private ContactDAO contactDAO;

    @Override
    public void init() { contactDAO = new ContactDAOImpl(); }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String search = req.getParameter("search");
        try {
            if (search != null && !search.trim().isEmpty()) {
                req.setAttribute("contacts", contactDAO.searchContacts(search.trim()));
                req.setAttribute("search", search);
            } else {
                req.setAttribute("contacts", contactDAO.getAllContacts());
            }
            req.getRequestDispatcher("/WEB-INF/views/contact-list.jsp").forward(req, resp);
        } catch (SQLException e) {
            log.severe("DB error: " + e.getMessage());
            resp.sendError(503, "Service Unavailable. Please try again later.");
        }
    }
}
