<%@page import="java.util.*" %>

<%!
    public class Transaction {
        private Connect connect;

        private Integer id;
        private Integer userId;
        private Integer bookId;
        private String trxDate;
        private Integer status;
        public Transaction() {
            /*
             * Set value with Connect class instance
             */
            this.connect = Connect.getConnection();
        }

        public Transaction(ResultSet resultSet) {
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
                this.bookId = resultSet.getInt("bookId");
                this.trxDate = resultSet.getString("trxDate");
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
        public void setBookId(Integer bookId) { this.bookId = bookId; }
        public Integer getBookId() { return bookId; }
        public void setTrxDate(String trxDate) { this.trxDate = trxDate; }
        public String getTrxDate() { return trxDate; }
        public void setStatus(Integer status) { this.status = status; }
        public Integer getStatus() { return status; }

        /*
         * Method to get all data from the database
         */
        public Vector<Transaction> get() {
            Vector<Transaction> transactions = new Vector<Transaction>();
    
            try {
                /*
                 * Query to get all data
                 */
                String query = "SELECT * FROM transactions";
                
                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);    
                
                /*
                 * Add all result from the database to the list
                 */
                while (resultSet.next()) {
                    transactions.add(new Transaction(resultSet));        
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            return transactions;
        }

        /*
         * Method to get data from the database by id 
         */
        public Transaction find(Integer id) {
            Transaction result = null;
    
            try {
                String query = String.format("SELECT * FROM transactions WHERE id = %d LIMIT 1", id);
                ResultSet resultSet = connect.executeQuery(query);
                if (resultSet.next()) {
                    result = new Transaction(resultSet);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            return result;
        }

        /*
         * Method to get data from the database by column name and value 
         */
        public Transaction exists(String column, String value) {
            Transaction result = null;
            
            try {
                /*
                 * Query to get data by column name and value
                 */
                String query = String.format("SELECT * FROM transactions WHERE %s = '%s' LIMIT 1", column, value);
                
                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);
                
                /*
                 * Set result value to course model
                 */
                if (resultSet.next()) {
                    result = new Transaction(resultSet);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return result;    
        }

        /*
         * Method to get last data from the database
         */
        public Transaction last() {
            Transaction result = null;
            
            try {
                /*
                 * Query to get data last data
                 */
                String query = "SELECT * FROM transactions ORDER BY id DESC LIMIT 1";

                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);            
                
                /*
                 * Set result value to course model
                 */
                if (resultSet.next()) {
                    result = new Transaction(resultSet);
                } 
            } catch (Exception e) {
                e.printStackTrace();
            }

            return result;
        }

        /*
         * Method to insert data to the database
         */
        public Transaction insert() {
            try {
                /*
                 * Query to insert data
                 */
                Integer id = 0;
                String query = "SELECT COUNT(*) FROM transactions";
                ResultSet rs = connect.executeQuery(query);
                while(rs.next()){
                    id = Integer.parseInt(rs.getString(1));
                }
                query = String.format("INSERT INTO transactions (userId, bookId, trxDate, status) VALUES (%d, %d, '%s', %d)", userId, bookId, trxDate, status);
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
        public Transaction update() {
            try {
                /*
                 * Query to update data
                 */
                String query = String.format("UPDATE transactions SET userId = %d, bookId = %d, trxDate='%s', status = %d  WHERE id = %d", userId, bookId, trxDate, status, id);
                
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
                String query = String.format("DELETE FROM transactions WHERE id = %d", id);

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
