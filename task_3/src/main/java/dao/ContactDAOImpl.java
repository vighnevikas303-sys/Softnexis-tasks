package dao;

import model.Contact;
import util.DBUtil;

import javax.sql.DataSource;
import java.sql.*;
import java.util.*;
import java.util.logging.Logger;

public class ContactDAOImpl implements ContactDAO {

    private static final Logger log = Logger.getLogger(ContactDAOImpl.class.getName());
    private final DataSource dataSource;

    public ContactDAOImpl() {
        this.dataSource = DBUtil.getDataSource();
    }

    @Override
    public void addContact(Contact contact) throws SQLException {
        String sql = "INSERT INTO contacts (name, email, phone) VALUES (?, ?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, contact.getName());
            stmt.setString(2, contact.getEmail());
            stmt.setString(3, contact.getPhone());
            stmt.executeUpdate();
        } catch (SQLException e) {
            log.severe("addContact error: " + e.getMessage());
            throw e;
        }
    }

    @Override
    public List<Contact> getAllContacts() throws SQLException {
        String sql = "SELECT id, name, email, phone, created_at FROM contacts ORDER BY created_at DESC";
        List<Contact> list = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            log.severe("getAllContacts error: " + e.getMessage());
            throw e;
        }
        return list;
    }

    @Override
    public List<Contact> searchContacts(String keyword) throws SQLException {
        String sql = "SELECT id, name, email, phone, created_at FROM contacts " +
                     "WHERE LOWER(name) LIKE LOWER(?) OR LOWER(email) LIKE LOWER(?) " +
                     "ORDER BY created_at DESC";
        List<Contact> list = new ArrayList<>();
        String pattern = "%" + keyword + "%";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, pattern);
            stmt.setString(2, pattern);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            log.severe("searchContacts error: " + e.getMessage());
            throw e;
        }
        return list;
    }

    private Contact mapRow(ResultSet rs) throws SQLException {
        return new Contact(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("email"),
            rs.getString("phone"),
            rs.getTimestamp("created_at")
        );
    }
}
