<%@page import="java.util.*" %>

<%!
    public class Book {
        private Connect connect;

        private Integer id;
        private String title;
        private String author;
        private Integer year;
        private Integer status;
        public Book() {
            /*
             * Set value with Connect class instance
             */
            this.connect = Connect.getConnection();
        }

        public Book(ResultSet resultSet) {
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
                this.title = resultSet.getString("title");
                this.author = resultSet.getString("author");
                this.year = resultSet.getInt("year");
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
        public void setTitle(String title) { this.title = title; }
        public String getTitle() { return title; }
        public void setAuthor(String author) { this.author = author; }
        public String getAuthor() { return author; }
        public void setYear(Integer year) { this.year = year; }
        public Integer getYear() { return year; }
        public void setStatus(Integer status) { this.status = status; }
        public Integer getStatus() { return status; }

        /*
         * Method to get all data from the database
         */
        public Vector<Book> get() {
            Vector<Book> books = new Vector<Book>();
    
            try {
                /*
                 * Query to get all data
                 */
                String query = "SELECT * FROM books";
                
                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);    
                
                /*
                 * Add all result from the database to the list
                 */
                while (resultSet.next()) {
                    books.add(new Book(resultSet));        
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            return books;
        }

        /*
         * Method to get data from the database by id 
         */
        public Book find(Integer id) {
            Book result = null;
    
            try {
                String query = String.format("SELECT * FROM books WHERE id = %d LIMIT 1", id);
                ResultSet resultSet = connect.executeQuery(query);
                if (resultSet.next()) {
                    result = new Book(resultSet);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            return result;
        }

        /*
         * Method to get data from the database by column name and value 
         */
        public Book exists(String column, String value) {
            Book result = null;
            
            try {
                /*
                 * Query to get data by column name and value
                 */
                String query = String.format("SELECT * FROM books WHERE %s = '%s' LIMIT 1", column, value);
                
                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);
                
                /*
                 * Set result value to course model
                 */
                if (resultSet.next()) {
                    result = new Book(resultSet);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return result;    
        }

        /*
         * Method to get last data from the database
         */
        public Book last() {
            Book result = null;
            
            try {
                /*
                 * Query to get data last data
                 */
                String query = "SELECT * FROM books ORDER BY id DESC LIMIT 1";

                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);            
                
                /*
                 * Set result value to course model
                 */
                if (resultSet.next()) {
                    result = new Book(resultSet);
                } 
            } catch (Exception e) {
                e.printStackTrace();
            }

            return result;
        }

        /*
         * Method to insert data to the database
         */
        public Book insert() {
            try {
                /*
                 * Query to insert data
                 */
                Integer id = 0;
                String query = "SELECT COUNT(*) FROM books";
                ResultSet rs = connect.executeQuery(query);
                while(rs.next()){
                    id = Integer.parseInt(rs.getString(1));
                }
                query = String.format("INSERT INTO books (title, author, year, status) VALUES ('%s', '%s', %d, %d)", title, author, year, status);
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
        public Book update() {
            try {
                /*
                 * Query to update data
                 */
                String query = String.format("UPDATE books SET title = '%s', author = '%s', year = %d, status = %d  WHERE id = %d", title, author, year, status, id);
                
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
                String query = String.format("DELETE FROM books WHERE id = %d", id);

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
