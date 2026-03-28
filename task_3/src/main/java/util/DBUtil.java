package util;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.util.logging.Logger;

public class DBUtil {

    private static final Logger log = Logger.getLogger(DBUtil.class.getName());
    private static DataSource dataSource;

    public static synchronized DataSource getDataSource() {
        if (dataSource == null) {
            try {
                Context ctx = new InitialContext();
                dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/ContactDB");
                log.info("DataSource acquired from JNDI");
            } catch (NamingException e) {
                log.severe("JNDI lookup failed: " + e.getMessage());
                throw new RuntimeException("Cannot initialize DataSource", e);
            }
        }
        return dataSource;
    }
}
