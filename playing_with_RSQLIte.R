# Loading the library
library(DBI)
library(RSQLite)

mydb = dbConnect(RSQLite::SQLite(),
                 #user='yani', 
                 #password='password', 
                 #host='localhost', 
                 dbname="users")

dbSendQuery(conn = mydb, "CREATE TABLE user_data
(user TEXT,
day_left_sts INT,
hour_left_sts INT,
sweet_boxes INT,
royal_boxes INT,
sweet_treats INT,
royal_cookies INT)")

dbSendQuery(mydb, 'SELECT * FROM user_data')

 dbSendQuery(mydb, "INSERT INTO user_data (user, day_left_sts, hour_left_sts, sweet_boxes, royal_boxes, sweet_treats, royal_cookies) VALUES ('user1', 29, 9, 5, 5, 10, 0)")



dbReadTable(mydb, "user_data")
