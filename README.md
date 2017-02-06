# IT Services Portal
Web application of an IT issue reporting portal. Third assignment for the SENG 2050 course at the University of Newcastle, Australia.

SETUP PROCEDURE

## Database configuration
In MySQL, create a database called "it-portal-db". Import the "it-portal-db.sql" file in the database to create the tables. 
The "context.xml" located in the META-INF folder gives the connection details. The database works with localhost:3306, and the authentication 
works with a form-based authentication, the users and roles being defined in the database.


### Server configuration
The project runs with Apache Tomcat 8, and the "server.xml" file must include the following for authentication :
 
<Realm className="org.apache.catalina.realm.JDBCRealm" connectionName="XXX" 
	connectionPassword="XXX" connectionURL="jdbc:mysql://localhost:3306/it-portal-db" 
	driverName="com.mysql.jdbc.Driver" roleNameCol="role" userCredCol="password" 
	userNameCol="username" userRoleTable="user" userTable="user" />

The Realm must be inside the "<Engine defaultHost="localhost" name="Catalina">" and "<Realm className="org.apache.catalina.realm.LockOutRealm">". 
If a Realm such as "<Realm className="org.apache.catalina.realm.UserDatabaseRealm" resourceName="UserDatabase" />" is present, comment it and add the new JDBCRealm above.

The "connectionName" and "connectionPassword" fields must be replaced with your connection settings.


## Instructions for use
Two users have been added in the database: 

-	Username: user
	Password: user
	Role: user

-	Username: staff
	Password: staff
	Role: staff
