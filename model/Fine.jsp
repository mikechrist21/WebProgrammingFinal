<%@page import="java.util.*" %>

<%!
    public class Fine {
        private Connect connect;

        private Integer id;
        private Integer userId;
        private String date;
        private Integer status;
        public Fine() {
            /*
             * Set value with Connect class instance
             */
            this.connect = Connect.getConnection();
        }

        public Fine(ResultSet resultSet) {
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
                this.userId = resultSet.getInt("userId");
                this.date = resultSet.getString("date");
                this.status = resultSet.getInt("status");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        /*
         * Setter and Getter from this class
         */
        public void setId(Integer id) { this.id = id; }
        public Integer getId() { return id; }
        public void setUserId(Integer userId) { this.userId = userId; }
        public Integer getUserId() { return userId; }
        public void setDate(String date) { this.date = date; }
        public String getDate() { return date; }
        public void setStatus(Integer status) { this.status = status; }
        public Integer getStatus() { return status; }

        /*
         * Method to get all data from the database
         */
        public Vector<Fine> get() {
            Vector<Fine> fines = new Vector<Fine>();
    
            try {
                /*
                 * Query to get all data
                 */
                String query = "SELECT * FROM fines";
                
                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);    
                
                /*
                 * Add all result from the database to the list
                 */
                while (resultSet.next()) {
                    fines.add(new Fine(resultSet));        
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            return fines;
        }

        /*
         * Method to get data from the database by id 
         */
        public Fine find(Integer id) {
            Fine result = null;
    
            try {
                String query = String.format("SELECT * FROM fines WHERE id = %d LIMIT 1", id);
                ResultSet resultSet = connect.executeQuery(query);
                if (resultSet.next()) {
                    result = new Fine(resultSet);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            return result;
        }

        /*
         * Method to get data from the database by column name and value 
         */
        public Fine exists(String column, String value) {
            Fine result = null;
            
            try {
                /*
                 * Query to get data by column name and value
                 */
                String query = String.format("SELECT * FROM fines WHERE %s = '%s' LIMIT 1", column, value);
                
                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);
                
                /*
                 * Set result value to course model
                 */
                if (resultSet.next()) {
                    result = new Fine(resultSet);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return result;    
        }

        /*
         * Method to get last data from the database
         */
        public Fine last() {
            Fine result = null;
            
            try {
                /*
                 * Query to get data last data
                 */
                String query = "SELECT * FROM fines ORDER BY id DESC LIMIT 1";

                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);            
                
                /*
                 * Set result value to course model
                 */
                if (resultSet.next()) {
                    result = new Fine(resultSet);
                } 
            } catch (Exception e) {
                e.printStackTrace();
            }

            return result;
        }

        /*
         * Method to insert data to the database
         */
        public Fine insert() {
            try {
                /*
                 * Query to insert data
                 */
                Integer id = 0;
                String query = "SELECT COUNT(*) FROM fines";
                ResultSet rs = connect.executeQuery(query);
                while(rs.next()){
                    id = Integer.parseInt(rs.getString(1));
                }
                query = String.format("INSERT INTO fines (userId, date, status) VALUES (%d, '%s', %d)", userId, date, status);
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
        public Fine update() {
            try {
                /*
                 * Query to update data
                 */
                String query = String.format("UPDATE fines SET userId = %d, date = '%s', status = %d  WHERE id = %d", userId, date, status, id);
                
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
                String query = String.format("DELETE FROM fines WHERE id = %d", id);

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
