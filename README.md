# BDS Project 3
Goal of this project was to implement graphical user interface for an already existing database. Main parts that should GUI implement for database were CRUD operations, authentication of users from database, SQL Injection simulation and lastly non GUI requirements were basic logging and database backups.

&nbsp;
## How to run
We will be considering Linux as our OS.
In the first place we need to setup our PostgreSQL server. We will achieve that with a few steps:
1. Let's create a new database and database user. But beforehand, I do recommend you taking a look at this [wiki](https://wiki.archlinux.org/title/PostgreSQL#Installation) for more information on how to intialize database cluster and so on. Now we will continue with creation of our db:
    
    `createdb bds`, creates our database, then we need to create user **doma**, which I won't demonstrate here, again go and check this [wiki](https://wiki.archlinux.org/title/PostgreSQL#Installation).

2. Now we need to run our database server with

    `systemctl start postregsql`

3. Next step is to initialize our database

    `psql -d bds -f init.sql`

4. Now we need to download required packages for python using this command:

    `python -m pip install -r requirements.txt`

5. Create two directories `backups/` and `logs/`


6. Lastly we will go to `src/` directory and run the following command:

    `python manage.py runserver`

7. Project website should be accessible from browser at [localhost:8000](http://127.0.0.1:8000/)

&nbsp;
## Used libraries
| Name      | Version | License                                             |
|-----------|---------|-----------------------------------------------------|
| Django    | 4.0     | BSD License                                         |
| asgiref   | 3.4.1   | BSD License                                         |
| bcrypt    | 3.2.0   | Apache Software License                             |
| cffi      | 1.15.0  | MIT License                                         |
| psycopg2  | 2.9.2   | GNU Library or Lesser General Public License        |
| pycparser | 2.21    | BSD License                                         |
| six       | 1.16.0  | MIT License                                         |
| sqlparse  | 0.4.2   | BSD License                                         |
