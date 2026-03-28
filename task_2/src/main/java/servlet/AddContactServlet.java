package servlet;

import service.ContactService;
import util.ContactValidator;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/contacts/add")
public class AddContactServlet extends HttpServlet {

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

        if (ContactService.isDuplicate(email))
            errors.put("email", "Email already exists");

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("name",  name);
            req.setAttribute("email", email);
            req.setAttribute("phone", phone);
            req.getRequestDispatcher("/WEB-INF/views/contact-form.jsp").forward(req, resp);
            return;
        }

        ContactService.add(name.trim(), email.trim(), phone == null ? "" : phone.trim());

        HttpSession session = req.getSession();
        session.setAttribute("success", "Contact added successfully!");
        resp.sendRedirect(req.getContextPath() + "/contacts");
    }
}
