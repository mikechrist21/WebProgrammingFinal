<%@page import="java.util.*" %>

<%!
    public class User {
        private Connect connect;

        private Integer id;
        private String email;
        private String name;
        private String password;
        private Integer role;
        private Integer borrow;
        public User() {
            /*
             * Set value with Connect class instance
             */
            this.connect = Connect.getConnection();
        }

        public User(ResultSet resultSet) {
            /*
             * Set value with Connect class instance
             */
            this.connect = Connect.getConnection();
            
            try {
                
                /*
                 * Fill this Course class attribute with the data from the.
                 * getInt(<column>) -> to get integer value
                 * getString(<column>) -> to get string value
                 * The parameter from getInt() and getString() method base on column name from course table or column order that start from 1..n
                 */
                this.id = resultSet.getInt("id");
                this.email = resultSet.getString("email");
                this.name = resultSet.getString("name");
                this.password = resultSet.getString("password");
                this.role = resultSet.getInt("role");
                this.borrow = resultSet.getInt("borrow");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        /*
         * Setter and Getter from this class
         */
        public void setId(Integer id) { this.id = id; }
        public Integer getId() { return id; }
        public void setEmail(String email) { this.email = email; }
        public String getEmail() { return email; }
        public void setName(String name) { this.name = name; }
        public String getName() { return name; }
        public void setPassword(String password) { this.password = password; }
        public String getPassword() { return password; }
        public void setRole(Integer role) { this.role = role; }
        public Integer getRole() { return role; }
        public void setBorrow(Integer borrow) { this.borrow = borrow; }
        public Integer getBorrow() { return borrow; }
        /*
         * Method to get all data from the database
         */
        public Vector<User> get() {
            Vector<User> users = new Vector<User>();
    
            try {
                /*
                 * Query to get all data
                 */
                String query = "SELECT * FROM users";
                
                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);    
                
                /*
                 * Add all result from the database to the list
                 */
                while (resultSet.next()) {
                    users.add(new User(resultSet));        
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            return users;
        }

        /*
         * Method to get data from the database by id 
         */
        public User find(Integer id) {
            User result = null;
    
            try {
                String query = String.format("SELECT * FROM users WHERE id = %d LIMIT 1", id);
                ResultSet resultSet = connect.executeQuery(query);
                if (resultSet.next()) {
                    result = new User(resultSet);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            return result;
        }

        /*
         * Method to get data from the database by column name and value 
         */
        public User exists(String column, String value) {
            User result = null;
            
            try {
                /*
                 * Query to get data by column name and value
                 */
                String query = String.format("SELECT * FROM users WHERE %s = '%s' LIMIT 1", column, value);
                
                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);
                
                /*
                 * Set result value to course model
                 */
                if (resultSet.next()) {
                    result = new User(resultSet);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return result;    
        }

        /*
         * Method to get last data from the database
         */
        public User last() {
            User result = null;
            
            try {
                /*
                 * Query to get data last data
                 */
                String query = "SELECT * FROM users ORDER BY id DESC LIMIT 1";

                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);            
                
                /*
                 * Set result value to course model
                 */
                if (resultSet.next()) {
                    result = new User(resultSet);
                } 
            } catch (Exception e) {
                e.printStackTrace();
            }

            return result;
        }

        /*
         * Method to insert data to the database
         */
        public User insert() {
            try {
                /*
                 * Query to insert data
                 */
                Integer id = 0;
                String query = "SELECT COUNT(*) FROM users";
                ResultSet rs = connect.executeQuery(query);
                while(rs.next()){
                    id = Integer.parseInt(rs.getString(1));
                }
                query = String.format("INSERT INTO users (email, name, password, role, borrow) VALUES ('%s', '%s', '%s', %d, %d)", email, name, password, role, borrow);
                /*
                 * Execute the query
                 */
                connect.executeUpdate(query);
            } catch (Exception e) {
                e.printStackTrace();
            }

            /*
             * Return last inserted data
             */
            return last();
        }

        /*
         * Method to update data from the database
         */
        public User update() {
            try {
                /*
                 * Query to update data
                 */
                String query = String.format("UPDATE users SET email = '%s', name = '%s', password = '%s', role = %d, borrow = %d  WHERE id = %d", email, name, password, role, borrow, id);
                
                /*
                 * Execute the query
                 */
                connect.executeUpdate(query);
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            return this;
        }

        /*
         * Method to delete data from the database by id
         */
        public Boolean delete(Integer id) {
            Integer affected = 0;
            try {
                /*
                 * Query to delete data
                 */
                String query = String.format("DELETE FROM users WHERE id = %d", id);

                /*
                 * Execute the query
                 */
                affected = connect.executeUpdate(query);
            } catch (Exception e) {
                e.printStackTrace();
            }

            return affected > 0;
        }
    }
%>
