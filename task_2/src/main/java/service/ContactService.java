package service;

import model.Contact;
import java.util.*;

public class ContactService {
    private static List<Contact> contacts = new ArrayList<>();
    private static int idCounter = 1;

    public static List<Contact> getAll() { return contacts; }

    public static void add(String name, String email, String phone) {
        contacts.add(new Contact(idCounter++, name, email, phone));
    }

    public static boolean isDuplicate(String email) {
        return contacts.stream().anyMatch(c -> c.getEmail().equalsIgnoreCase(email));
    }
}
