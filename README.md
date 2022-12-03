## Docker commands to build , tag and push docker image to ECR registry
``` 
docker build -t 8xxxxxxxxx3.dkr.ecr.us-east-1.amazonaws.com/<registry>:<tag> -f Dockerfile .
docker push 8xxxxxxxxx3.dkr.ecr.us-east-1.amazonaws.com/<registry>:<tag>
```

## s3 backend -- i am using s3 bucket as backend to save .tfstate file. you have to configure your s3 bucket in terraform's providers.tf file or you can remove s3 backend resourse to save your .tfstate file in local


## This terraform module builds an Elastic Container Service(ECS) Cluster in AWS.
## The following resources will be created:
```hcl
-- VPC , NAT Gateway , Security Group for Auto scaling group , RDS , ALB
-- RDS , SSM Parameter 
-- Application Load Balancer , Target Group
-- ECS , Task Defination , Service 
```

## Terraform ecs Modules 

#### usage for ecs modules   -- update container_cpu , container_memory , containerPort ,hostPort according to your application requirement in ecs module

```hcl
  source         = "./modules/ecs"
  name           = "demo1"
  vpc_id         = module.network.vpcid



  container_cpu    =                #default=100
  container_memory =                #default=512
  containerPort    =                #default=80
  hostPort         =                #default=80
  #load balancer 
  path =                            #default="/" #target_group_health_check_path
  #port =                            #default=80  #dynamic port mapping
```

#### additional variable you can use

```hcl
imageURI         = []
```
## Terraform asg Modules

#### usage for asg modules  -- update auto scaling group module accoring to your requirement you can update asg_max , asg_min , desired_capacity (for your instances) , update instance_types accoring to your requirement 
#### suggetion -- use instance type "t3.small/2vCPU 2Gib memory" if you are deploying spring-boot-app else your task in ecs sservice will not get updated
```hcl
module "asg" {
  source            = "./modules/asg"
  name              = "demo1"
  asg_max           =               #default=1
  asg_min           =               #default=1
  health_check_type =               #default="ELB"
  desired_capacity  =               #default=1
  force_delete      =               #default="true"
  instance_types    =               #default="t2.micro"


}
```


## Terraform rds Modules
#### usage for rds modules  -- in rds module you can define engine and engine_version (like if you want mysql version 5.7 ) , in allocated_storage you can define storage capacity , in instance_class define database instance class , in db_name define your database name , in username define database user  for data base password i use random_string password generator it will store password in ssm parameter store. i am using aws ssm parameter to store database name , username , password , endpoint. 
```hcl
module "rds" {
  source            = "./modules/rds"
  allocated_storage =               #default=10
  db_name           =               #default="database23"
  engine            =               #default="mysql"
  engine_version    =               #default="5.7"
  instance_class    =               #default="db.t3.micro"
  username          =               #default="database23"

  parameter_group_name   =          #default="default.mysql5.7"
  skip_final_snapshot    =          #default=true
  

}
```
## Terraform security group Modules

#### usage for sg modules  -- using three security group for RDS , Auto Scaling Group , ALB you can control access with port and CIDR range or from ip
```hcl
module "sgRDS" {
  source    = "./modules/sg"
  name      = "ecs3"
  sg_cidr   = [module.network.cidr_block]
  from_port = 3306
  to_port   = 3306
}
```


#### terraform command

##### to initialize module dependencies

``` terraform init ```

##### it will show details what terraform creating       

``` terraform plan ```    

##### to create planned resource 

``` terraform apply ```


```terraform apply & plan instructions
when you use terraform apply & terraform plan command it will ask value for imageURI you have to enter you image uri.
you can use following command passing variable
``` 

```terraform plan -var imageURI=8xxxxxxxxx3.dkr.ecr.us-east-1.amazonaws.com/<registry>:<tag> --auto-approve```

```terraform apply -var imageURI=8xxxxxxxxx3.dkr.ecr.us-east-1.amazonaws.com/<registry>:<tag> --auto-approve```



## s3 backend -- i am using s3 bucket as backend to save .tfstate file. you have to configure your s3 bucket or you can use local to save your .tfstate file

## used policy -- AmazonEC2ContainerServiceforEC2Role , AmazonEC2RoleforSSM , AmazonECSTaskExecutionRolePolicy 




# The following instructions are for sprin-boot-app  (provided with application)


# Spring Boot "Microservice" Example Project

This is a sample Java / Maven / Spring Boot (version 1.5.6) application that can be used as a starter for creating a microservice complete with built-in health check, metrics and much more. I hope it helps you.

## How to Run 

This application is packaged as a war which has Tomcat 8 embedded. No Tomcat or JBoss installation is necessary. You run it using the ```java -jar``` command.

* Clone this repository 
* Make sure you are using JDK 1.8 and Maven 3.x
* You can build the project and run the tests by running ```mvn clean package```
* Once successfully built, you can run the service by one of these two methods:
```
        java -jar -Dspring.profiles.active=test target/spring-boot-rest-example-0.5.0.war
or
        mvn spring-boot:run -Drun.arguments="spring.profiles.active=test"
```
* Check the stdout or boot_example.log file to make sure no exceptions are thrown

Once the application runs you should see something like this

```
2017-08-29 17:31:23.091  INFO 19387 --- [           main] s.b.c.e.t.TomcatEmbeddedServletContainer : Tomcat started on port(s): 8090 (http)
2017-08-29 17:31:23.097  INFO 19387 --- [           main] com.khoubyari.example.Application        : Started Application in 22.285 seconds (JVM running for 23.032)
```

## About the Service

The service is just a simple hotel review REST service. It uses an in-memory database (H2) to store the data. You can also do with a relational database like MySQL or PostgreSQL. If your database connection properties work, you can call some REST endpoints defined in ```com.khoubyari.example.api.rest.hotelController``` on **port 8090**. (see below)

More interestingly, you can start calling some of the operational endpoints (see full list below) like ```/metrics``` and ```/health``` (these are available on **port 8091**)

You can use this sample service to understand the conventions and configurations that allow you to create a DB-backed RESTful service. Once you understand and get comfortable with the sample app you can add your own services following the same patterns as the sample service.
 
Here is what this little application demonstrates: 

* Full integration with the latest **Spring** Framework: inversion of control, dependency injection, etc.
* Packaging as a single war with embedded container (tomcat 8): No need to install a container separately on the host just run using the ``java -jar`` command
* Demonstrates how to set up healthcheck, metrics, info, environment, etc. endpoints automatically on a configured port. Inject your own health / metrics info with a few lines of code.
* Writing a RESTful service using annotation: supports both XML and JSON request / response; simply use desired ``Accept`` header in your request
* Exception mapping from application exceptions to the right HTTP response with exception details in the body
* *Spring Data* Integration with JPA/Hibernate with just a few lines of configuration and familiar annotations. 
* Automatic CRUD functionality against the data source using Spring *Repository* pattern
* Demonstrates MockMVC test framework with associated libraries
* All APIs are "self-documented" by Swagger2 using annotations 

Here are some endpoints you can call:

### Get information about system health, configurations, etc.

```
http://localhost:8091/env
http://localhost:8091/health
http://localhost:8091/info
http://localhost:8091/metrics
```

### Create a hotel resource

```
POST /example/v1/hotels
Accept: application/json
Content-Type: application/json

{
"name" : "Beds R Us",
"description" : "Very basic, small rooms but clean",
"city" : "Santa Ana",
"rating" : 2
}

RESPONSE: HTTP 201 (Created)
Location header: http://localhost:8090/example/v1/hotels/1
```

### Retrieve a paginated list of hotels

```
http://localhost:8090/example/v1/hotels?page=0&size=10

Response: HTTP 200
Content: paginated list 
```

### Update a hotel resource

```
PUT /example/v1/hotels/1
Accept: application/json
Content-Type: application/json

{
"name" : "Beds R Us",
"description" : "Very basic, small rooms but clean",
"city" : "Santa Ana",
"rating" : 3
}

RESPONSE: HTTP 204 (No Content)
```
### To view Swagger 2 API docs

Run the server and browse to localhost:8090/swagger-ui.html

# About Spring Boot

Spring Boot is an "opinionated" application bootstrapping framework that makes it easy to create new RESTful services (among other types of applications). It provides many of the usual Spring facilities that can be configured easily usually without any XML. In addition to easy set up of Spring Controllers, Spring Data, etc. Spring Boot comes with the Actuator module that gives the application the following endpoints helpful in monitoring and operating the service:

**/metrics** Shows “metrics” information for the current application.

**/health** Shows application health information.

**/info** Displays arbitrary application info.

**/configprops** Displays a collated list of all @ConfigurationProperties.

**/mappings** Displays a collated list of all @RequestMapping paths.

**/beans** Displays a complete list of all the Spring Beans in your application.

**/env** Exposes properties from Spring’s ConfigurableEnvironment.

**/trace** Displays trace information (by default the last few HTTP requests).

### To view your H2 in-memory datbase

The 'test' profile runs on H2 in-memory database. To view and query the database you can browse to http://localhost:8090/h2-console. Default username is 'sa' with a blank password. Make sure you disable this in your production profiles. For more, see https://goo.gl/U8m62X

# Running the project with MySQL

This project uses an in-memory database so that you don't have to install a database in order to run it. However, converting it to run with another relational database such as MySQL or PostgreSQL is very easy. Since the project uses Spring Data and the Repository pattern, it's even fairly easy to back the same service with MongoDB. 

Here is what you would do to back the services with MySQL, for example: 

### In pom.xml add: 

```
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
        </dependency>
```

### Append this to the end of application.yml: 

```
---
spring:
  profiles: mysql

  datasource:
    driverClassName: com.mysql.jdbc.Driver
    url: jdbc:mysql://<your_mysql_host_or_ip>/bootexample
    username: <your_mysql_username>
    password: <your_mysql_password>

  jpa:
    hibernate:
      dialect: org.hibernate.dialect.MySQLInnoDBDialect
      ddl-auto: update # todo: in non-dev environments, comment this out:


hotel.service:
  name: 'test profile:'
```

### Then run is using the 'mysql' profile:

```
        java -jar -Dspring.profiles.active=mysql target/spring-boot-rest-example-0.5.0.war
or
        mvn spring-boot:run -Drun.jvmArguments="-Dspring.profiles.active=mysql"
```

# Attaching to the app remotely from your IDE

Run the service with these command line options:

```
mvn spring-boot:run -Drun.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"
or
java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -Dspring.profiles.active=test -Ddebug -jar target/spring-boot-rest-example-0.5.0.war
```
and then you can connect to it remotely using your IDE. For example, from IntelliJ You have to add remote debug configuration: Edit configuration -> Remote.

# Star History

[![Star History Chart](https://api.star-history.com/svg?repos=khoubyari/spring-boot-rest-example&type=Date)](https://star-history.com/#khoubyari/spring-boot-rest-example&Date)

# Questions and Comments: khoubyari@gmail.com


