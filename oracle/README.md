# Setup

* Oracle does not provide preconfigured docker images, however, it does provide a nice open-source project you can use to build them.

* In order to build an Oracle Image you need 2 things

  1. The Oracle installation for the specific oracle version you need from [Oracle Database Software Downloads](https://www.oracle.com/database/technologies/oracle-database-software-downloads.html).
An account with oracle is needed to download the installation files (free).

  2. The Oracle's GitHub [Docker Images](https://github.com/oracle/docker-images.git) project.

* Once you have the database software and GitHub docker image repository
 
* Go to the single instance dockerfiles for the oracle builds

  ```
  cd OracleDatabase/SingleInstance/dockerfiles
  ```
      
* build the docker image

  ```
  buildDockerImage.sh -s -i -v {version}
  ```  

* Specifically, for `19.3.0`, follow these steps:

  * download `LINUX.X64_193000_db_home.zip` from [Oracle Database Software Downloads](https://www.oracle.com/database/technologies/oracle-database-software-downloads.html). 

    * If you do not have an oracle account, you will need to [sign-up](https://profile.oracle.com/myprofile/account/create-account.jspx). You are redirected to the log in page after accepting terms and proceeding with the download.

  * clone the git-hub repo to wherever you like to keep projects

    * `git clone https://github.com/oracle/docker-images.git`
        
  * place that download into the `19.3.0` directory `(docker-images/OracleDatabase/SingleInstance/dockerfiles/19.3.0)`.
    
  * cd to the dockerfiles directory `docker-images/OracleDatabase/SingleInstance/dockerfiles`.
    
  * run `./buildDockerImage.sh -s -i -v 19.3.0`
    
    * this will take some time; this builder does not actually initialize a database; that step is actually done at the first launch of an image using a container.
    
    * Do not do `docker-compose down` or remove the docker container unless you want to truly rebuild the database in that container, since that is a lengthy startup process.
    
* I have used 19.3.0, 18.4.0, and 12.2.0.1 standard edition with LogMiner enabled.

* The scripts to enable LogMiner should work for each version, I haven't double-checked this though with the script that ended up.
This script to enable logminer is in init.d/startup/logminer.sql.

* When the oracle instance is started for the first time `init.d/setup/logminer.sql` will execute after the database is built.
The initial startup of oracle will take some time, since buildDockerImage.sh builds an image with all the software installed, but the database is not yet created.

* Avoid doing `docker-compose down` on oracle, otherwise it will have to rebuild the database.  You want to `stop` the database so the container image
is not destored

* On initial startup or any other startup, all SQL scripts in `init.d/startup` is executed; in alphabetical order.  Write scripts
where they are idempotent (trap exceptions in PSQL; e.g. table already existing) or truncate data before insertion.

* Logminer notes

  * While I have used logminer with Oracle 11 XE, that was not based on Oracle's build scripts.

  * Logminer for 12+ requires standard or enterprise, express edition does not support logminer

  * Logminer in 11 was with XE and was with slightly different script.
