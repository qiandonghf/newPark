Pre-requisites : 
--------------
Ruby 1.8.6-26 or above
Rails 2.0.2 or above
MySQL 4.0 or above
gem install mysql
WEBrick or any other HTTP server


Database Creation: 
-----------------
Modify config/database.yml to enter the database name, user and password of your database.
Run the following scripts present in the db folder: 
create_tables.sql
insert_sample_data.sql

Viewing The Charts: 
------------------
Start The Server:
Run the command, 
ruby script/server 
from the application root folder.

View The Default Page:
Open the browser and type the address 
http://localhost:3000/fusioncharts/index
to view the index page of this application. 

The address to be typed in the address bar, 
may vary based on the server configuration on your computer.