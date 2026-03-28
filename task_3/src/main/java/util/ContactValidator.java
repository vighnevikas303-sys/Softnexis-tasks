package util;

import java.util.HashMap;
import java.util.Map;

public class ContactValidator {
    public static Map<String, String> validate(String name, String email, String phone) {
        Map<String, String> errors = new HashMap<>();
        if (name == null || name.trim().length() < 2 || name.trim().length() > 50)
            errors.put("name", "Please enter valid name");
        if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$"))
            errors.put("email", "Invalid email address");
        if (phone != null && !phone.isEmpty() && !phone.matches("\\d{10}"))
            errors.put("phone", "Use 10-digit format");
        return errors;
    }
}
