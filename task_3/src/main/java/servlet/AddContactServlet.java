package servlet;

import dao.ContactDAO;
import dao.ContactDAOImpl;
import model.Contact;
import util.ContactValidator;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;
import java.util.logging.Logger;

@WebServlet("/contacts/add")
public class AddContactServlet extends HttpServlet {

    private static final Logger log = Logger.getLogger(AddContactServlet.class.getName());
    private ContactDAO contactDAO;

    @Override
    public void init() { contactDAO = new ContactDAOImpl(); }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/contact-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String name  = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");

        Map<String, String> errors = ContactValidator.validate(name, email, phone);

        if (errors.isEmpty()) {
            Contact c = new Contact();
            c.setName(name.trim());
            c.setEmail(email.trim());
            c.setPhone(phone == null ? "" : phone.trim());
            try {
                contactDAO.addContact(c);
                req.getSession().setAttribute("success", "Contact added successfully!");
                resp.sendRedirect(req.getContextPath() + "/contacts");
                return;
            } catch (SQLException e) {
                if ("23505".equals(e.getSQLState())) {
                    errors.put("email", "Email already exists");
                } else {
                    log.severe("DB error: " + e.getMessage());
                    resp.sendError(503, "Service Unavailable. Please try again later.");
                    return;
                }
            }
        }

        req.setAttribute("errors", errors);
        req.setAttribute("name",  name);
        req.setAttribute("email", email);
        req.setAttribute("phone", phone);
        req.getRequestDispatcher("/WEB-INF/views/contact-form.jsp").forward(req, resp);
    }
}
