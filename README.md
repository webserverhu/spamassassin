# What is SpamAssassin?
SpamAssassin is the #1 Open Source anti-spam platform giving system administrators a filter to classify email and block spam (unsolicited bulk email).

It uses a robust scoring framework and plug-ins to integrate a wide range of advanced heuristic and statistical analysis tests on email headers and body text including text analysis, Bayesian filtering, DNS blocklists, and collaborative filtering databases.

# How to use SpamAssassin Images
## Start a SpamAssassin Instance
Start a SpamAssassin instance as follows:
```
docker run --name my-container-name -ti webserverhu/spamassassin:latest
```
where ```my-container-name``` is the name you want to assign to your container.

## Container Shell Access and SpamAssassin Log Files
The ```docker exec``` command allows you to run commands inside a Docker container. The following command line will give you a bash shell inside your SpamAssassin container:
```
docker exec -ti my-container-name /bin/bash
```
The SpamAssassin Server log is located at ```STDOUT```, and the following command line will let you inspect it:
```
docker attach --sig-proxy=false my-container-name
```
where you only see the new log messages.

## Connect to SpamAssassin from an Application in Another Docker Container
This image exposes the standard SpamAsssassin port (783), so container linking makes the SpamAssassin instance available to other application containers. Start your application container like this in order to link it to the SpamAssassin container:
```
docker run --name app-container-name --link my-container-name:spamassassin -d app-that-uses-spamasssassin
```
## Port forwarding
Docker allows mapping of ports on the container to ports on the host system by using the -p option. If you start the container as follows, you can connect to the database by connecting your client to a port on the host machine, in this example port 7783:
```
docker run --name my-container-name -p 7783:783 -d webserverhu/spamassassin
```

# Environment Variables
When you start the SpamAssassin image, you can adjust the configuration of the MySQL instance by passing one or more environment variables on the ```docker run``` command line.
All of the variables listed below are optional.
## ```BAYES_ADDRESS, BAYES_USER, BAYES_PASSWORD```
These variables specifies the address, the username and the password of the bayesian filter database connection.
The database schema for storage of the bayesian filter data contains several different tablesm which located at
https://svn.apache.org/repos/asf/spamassassin/branches/3.4/sql/bayes_mysql.sql.

These variables are optional, if you do not specifies these, then the default values will use to connect the database.
If the SpamAssassin can not connect to database, then it will you it's own, local file format database.
## ```ALLOWED_IP_RANGES```
Specify a list of authorized hosts or networks which can connect to this spamd instance. Single IP addresses can be given, ranges of IP addresses in address/masklength CIDR format, or ranges of IP addresses by listing 3 or less octets with a trailing dot.
Hostnames are not supported, only IP addresses.
You can take a list of addresses separated by commas.
By default, connections are accepted from ```0.0.0.0/0```
## ```MIN_CHILDREN```
The minimum number of children that will be kept running. The minimum value is 1, the default value is 1. 
## ```MAX_CHILDREN```
This option specifies the maximum number of children to spawn. The minimum value is 1, the default value is 5.
## ```MIN_SPARE```
The lower limit for the number of spare children allowed to run. The default value is 1.
## ```MAX_SPARE```
The upper limit for the number of spare children allowed to run. The default value is 2.
### Note, more information
For more information and related downloads for SpamAssassin, please visit http://spamassassin.apache.org/.

For more information about the ```spamd``` process, please visit https://spamassassin.apache.org/full/3.4.x/doc/spamd.html.
# User Feedback
We welcome your feedback! For general comments or discussion, please drop us a line in the Comments section below.

For bugs, issues and feature requests, please submit a report at https://github.com/webserverhu/spamassassin/issues.
