## Podman

podman run --name qa_mysql_instance -p 7000:3306  -e MYSQL_ROOT_PASSWORD=root123 -d mysql

podman logs qa_mysql_instance

podman exec -it qa_mysql_instance mysql -uroot -proot123

mysql> CREATE USER 'qa'@'%' IDENTIFIED BY 'root123';

mysql> GRANT ALL PRIVILEGES ON *.* TO 'qa'@'%';

mysql> update mysql.user set host = '%' where user='qa';

https://stackoverflow.com/questions/50469587/django-db-utils-operationalerror-2059-authentication-plugin-caching-sha2-pas

CREATE USER 'username'@'ip_address' IDENTIFIED WITH mysql_native_password BY 'password';

ALTER USER 'username'@'ip_address' IDENTIFIED WITH mysql_native_password BY 'password';


