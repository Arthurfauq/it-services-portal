# IT Services Portal
J2E web application of an IT issue reporting portal. Third assignment for the SENG 2050 course at the University of Newcastle, Australia.


## Setup procedure
This is a J2E application that runs with Apache Tomcat and MySQL.

### Database configuration
In MySQL, create a database called **it-portal-db**. Import the [it-portal-db.sql](https://github.com/arthurfauq/it-services-portal/blob/master/it-portal.sql) file in the database to create the tables. 

Find the [context.xml](https://github.com/arthurfauq/it-services-portal/blob/master/WebContent/META-INF/context.xml) file located in the META-INF folder and replace the connection details (*username* and *password*) with yours. 

The database works with localhost:3306, and the authentication works with a form-based authentication, the users and roles being defined in the database.

### Server configuration
The project runs with Apache Tomcat 8 and was created with Eclipse.

Please check [this link](https://tomcat.apache.org/download-80.cgi) to download and install Apache Tomcat 8 on your computer.

Open Eclipse and create a new Apache Tomcat 8 server. To specify which authentication realm the server must use, open the **server.xml** file inside the Tomcat server and include the following (please read below where to paste this) :
 
```xml
<Realm className="org.apache.catalina.realm.JDBCRealm" connectionName="XXX" 
	connectionPassword="XXX" connectionURL="jdbc:mysql://localhost:3306/it-portal-db" 
	driverName="com.mysql.jdbc.Driver" roleNameCol="role" userCredCol="password" 
	userNameCol="username" userRoleTable="user" userTable="user" />
 ```
The *connectionName* and *connectionPassword* fields must be replaced with your connection settings.


The Realm must be inside the 
```xml
<Engine defaultHost="localhost" name="Catalina"><Realm className="org.apache.catalina.realm.LockOutRealm">

```

If a Realm such as the following is present, comment it and add the new JDBCRealm above.
```xml
<Realm className="org.apache.catalina.realm.UserDatabaseRealm" resourceName="UserDatabase" />
```

### Connecting Tomcat to MySQL database

Finally, to connect to the database using the JDBC driver, the [mysql-connector-java-5.1.40-bin.jar](https://github.com/arthurfauq/it-services-portal/blob/master/mysql-connector-java-5.1.40-bin.jar) file must be added to the *$CATALINA_HOME/lib* directory, where CATALINA_HOME represents your Apache Tomcat installation folder.


## Instructions for use

Two users have been added in the database: **user** and **staff**, with both respectively the same username and password.
