-- Start of DDL Script for Sequence HR.DEPARTMENTS_SEQ
-- Generated 16-Abr-2010 5:04:01 from HR@XE

CREATE SEQUENCE departments_seq
  INCREMENT BY 10
  START WITH 280
  MINVALUE 1
  MAXVALUE 9990
  NOCYCLE
  NOORDER
  NOCACHE
/


-- End of DDL Script for Sequence HR.DEPARTMENTS_SEQ

-- Start of DDL Script for Sequence HR.EMPLOYEES_SEQ
-- Generated 16-Abr-2010 5:04:02 from HR@XE

CREATE SEQUENCE employees_seq
  INCREMENT BY 1
  START WITH 207
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  NOCYCLE
  NOORDER
  NOCACHE
/


-- End of DDL Script for Sequence HR.EMPLOYEES_SEQ

-- Start of DDL Script for Sequence HR.LOCATIONS_SEQ
-- Generated 16-Abr-2010 5:04:02 from HR@XE

CREATE SEQUENCE locations_seq
  INCREMENT BY 100
  START WITH 3300
  MINVALUE 1
  MAXVALUE 9900
  NOCYCLE
  NOORDER
  NOCACHE
/


-- End of DDL Script for Sequence HR.LOCATIONS_SEQ

-- Start of DDL Script for Table HR.COUNTRIES
-- Generated 16-Abr-2010 5:02:41 from HR@XE

CREATE TABLE countries
    (country_id                     CHAR(2) NOT NULL,
    country_name                   VARCHAR2(40),
    region_id                      NUMBER
  ,
  CONSTRAINT COUNTRY_C_ID_PK
  PRIMARY KEY (country_id))
  ORGANIZATION INDEX
   PCTTHRESHOLD 50 
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/





-- Constraints for COUNTRIES

ALTER TABLE countries
ADD CONSTRAINT country_id_nn CHECK ("COUNTRY_ID" IS NOT NULL)
/



-- Comments for COUNTRIES

COMMENT ON TABLE countries IS 'country table. Contains 25 rows. References with locations table.'
/
COMMENT ON COLUMN countries.country_id IS 'Primary key of countries table.'
/
COMMENT ON COLUMN countries.country_name IS 'Country name'
/
COMMENT ON COLUMN countries.region_id IS 'Region ID for the country. Foreign key to region_id column in the departments table.'
/

-- End of DDL Script for Table HR.COUNTRIES

-- Foreign Key

-- End of DDL script for Foreign Key(s)
-- Start of DDL Script for Table HR.DEPARTMENTS
-- Generated 16-Abr-2010 5:02:43 from HR@XE

CREATE TABLE departments
    (department_id                  NUMBER(4,0) NOT NULL,
    department_name                VARCHAR2(30) NOT NULL,
    manager_id                     NUMBER(6,0),
    location_id                    NUMBER(4,0)
  ,
  CONSTRAINT DEPT_ID_PK
  PRIMARY KEY (department_id)
  USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  ))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/





-- Indexes for DEPARTMENTS

CREATE INDEX dept_location_ix ON departments
  (
    location_id                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/



-- Constraints for DEPARTMENTS

ALTER TABLE departments
ADD CONSTRAINT dept_name_nn CHECK ("DEPARTMENT_NAME" IS NOT NULL)
/




-- Comments for DEPARTMENTS

COMMENT ON TABLE departments IS 'Departments table that shows details of departments where employees
work. Contains 27 rows; references with locations, employees, and job_history tables.'
/
COMMENT ON COLUMN departments.department_id IS 'Primary key column of departments table.'
/
COMMENT ON COLUMN departments.department_name IS 'A not null column that shows name of a department. Administration,
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public
Relations, Sales, Finance, and Accounting. '
/
COMMENT ON COLUMN departments.location_id IS 'Location id where a department is located. Foreign key to location_id column of locations table.'
/
COMMENT ON COLUMN departments.manager_id IS 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.'
/

-- End of DDL Script for Table HR.DEPARTMENTS

-- Foreign Key

-- End of DDL script for Foreign Key(s)
-- Start of DDL Script for Table HR.EMPLOYEES
-- Generated 16-Abr-2010 5:02:43 from HR@XE

CREATE TABLE employees
    (employee_id                    NUMBER(6,0) NOT NULL,
    first_name                     VARCHAR2(20),
    last_name                      VARCHAR2(25) NOT NULL,
    email                          VARCHAR2(25) NOT NULL,
    phone_number                   VARCHAR2(20),
    hire_date                      DATE NOT NULL,
    job_id                         VARCHAR2(10) NOT NULL,
    salary                         NUMBER(8,2),
    commission_pct                 NUMBER(2,2),
    manager_id                     NUMBER(6,0),
    department_id                  NUMBER(4,0)
  ,
  CONSTRAINT EMP_EMP_ID_PK
  PRIMARY KEY (employee_id)
  USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  ))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/





-- Indexes for EMPLOYEES

CREATE INDEX emp_department_ix ON employees
  (
    department_id                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

CREATE INDEX emp_job_ix ON employees
  (
    job_id                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

CREATE INDEX emp_manager_ix ON employees
  (
    manager_id                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

CREATE INDEX emp_name_ix ON employees
  (
    last_name                       ASC,
    first_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/



-- Constraints for EMPLOYEES

ALTER TABLE employees
ADD CONSTRAINT emp_last_name_nn CHECK ("LAST_NAME" IS NOT NULL)
/

ALTER TABLE employees
ADD CONSTRAINT emp_email_nn CHECK ("EMAIL" IS NOT NULL)
/

ALTER TABLE employees
ADD CONSTRAINT emp_hire_date_nn CHECK ("HIRE_DATE" IS NOT NULL)
/

ALTER TABLE employees
ADD CONSTRAINT emp_job_nn CHECK ("JOB_ID" IS NOT NULL)
/

ALTER TABLE employees
ADD CONSTRAINT emp_salary_min CHECK (salary > 0)
/

ALTER TABLE employees
ADD CONSTRAINT emp_email_uk UNIQUE (email)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/





-- Triggers for EMPLOYEES

-- Comments for EMPLOYEES

COMMENT ON TABLE employees IS 'employees table. Contains 107 rows. References with departments,
jobs, job_history tables. Contains a self reference.'
/
COMMENT ON COLUMN employees.commission_pct IS 'Commission percentage of the employee; Only employees in sales
department elgible for commission percentage'
/
COMMENT ON COLUMN employees.department_id IS 'Department id where employee works; foreign key to department_id
column of the departments table'
/
COMMENT ON COLUMN employees.email IS 'Email id of the employee'
/
COMMENT ON COLUMN employees.employee_id IS 'Primary key of employees table.'
/
COMMENT ON COLUMN employees.first_name IS 'First name of the employee. A not null column.'
/
COMMENT ON COLUMN employees.hire_date IS 'Date when the employee started on this job. A not null column.'
/
COMMENT ON COLUMN employees.job_id IS 'Current job of the employee; foreign key to job_id column of the
jobs table. A not null column.'
/
COMMENT ON COLUMN employees.last_name IS 'Last name of the employee. A not null column.'
/
COMMENT ON COLUMN employees.manager_id IS 'Manager id of the employee; has same domain as manager_id in
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query)'
/
COMMENT ON COLUMN employees.phone_number IS 'Phone number of the employee; includes country code and area code'
/
COMMENT ON COLUMN employees.salary IS 'Monthly salary of the employee. Must be greater
than zero (enforced by constraint emp_salary_min)'
/

-- End of DDL Script for Table HR.EMPLOYEES

-- Foreign Key
ALTER TABLE employees
ADD CONSTRAINT emp_dept_fk FOREIGN KEY (department_id)
REFERENCES departments (department_id)
/

-- End of DDL script for Foreign Key(s)
-- Start of DDL Script for Table HR.JOB_HISTORY
-- Generated 16-Abr-2010 5:02:45 from HR@XE

CREATE TABLE job_history
    (employee_id                    NUMBER(6,0) NOT NULL,
    start_date                     DATE NOT NULL,
    end_date                       DATE NOT NULL,
    job_id                         VARCHAR2(10) NOT NULL,
    department_id                  NUMBER(4,0)
  ,
  CONSTRAINT JHIST_EMP_ID_ST_DATE_PK
  PRIMARY KEY (employee_id, start_date)
  USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  ))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/





-- Indexes for JOB_HISTORY

CREATE INDEX jhist_job_ix ON job_history
  (
    job_id                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

CREATE INDEX jhist_employee_ix ON job_history
  (
    employee_id                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

CREATE INDEX jhist_department_ix ON job_history
  (
    department_id                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/



-- Constraints for JOB_HISTORY

ALTER TABLE job_history
ADD CONSTRAINT jhist_employee_nn CHECK ("EMPLOYEE_ID" IS NOT NULL)
/

ALTER TABLE job_history
ADD CONSTRAINT jhist_start_date_nn CHECK ("START_DATE" IS NOT NULL)
/

ALTER TABLE job_history
ADD CONSTRAINT jhist_end_date_nn CHECK ("END_DATE" IS NOT NULL)
/

ALTER TABLE job_history
ADD CONSTRAINT jhist_job_nn CHECK ("JOB_ID" IS NOT NULL)
/

ALTER TABLE job_history
ADD CONSTRAINT jhist_date_interval CHECK (end_date > start_date)
/





-- Comments for JOB_HISTORY

COMMENT ON TABLE job_history IS 'Table that stores job history of the employees. If an employee
changes departments within the job or changes jobs within the department,
new rows get inserted into this table with old job information of the
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.'
/
COMMENT ON COLUMN job_history.department_id IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table'
/
COMMENT ON COLUMN job_history.employee_id IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table'
/
COMMENT ON COLUMN job_history.end_date IS 'Last day of the employee in this job role. A not null column. Must be
greater than the start_date of the job_history table.
(enforced by constraint jhist_date_interval)'
/
COMMENT ON COLUMN job_history.job_id IS 'Job role in which the employee worked in the past; foreign key to
job_id column in the jobs table. A not null column.'
/
COMMENT ON COLUMN job_history.start_date IS 'A not null column in the complex primary key employee_id+start_date.
Must be less than the end_date of the job_history table. (enforced by
constraint jhist_date_interval)'
/

-- End of DDL Script for Table HR.JOB_HISTORY



CREATE TABLE jobs
    (job_id                         VARCHAR2(10) NOT NULL,
    job_title                      VARCHAR2(35) NOT NULL,
    min_salary                     NUMBER(6,0),
    max_salary                     NUMBER(6,0)
  ,
  CONSTRAINT JOB_ID_PK
  PRIMARY KEY (job_id)
  USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  ))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/





-- Constraints for JOBS

ALTER TABLE jobs
ADD CONSTRAINT job_title_nn CHECK ("JOB_TITLE" IS NOT NULL)
/


-- Comments for JOBS

COMMENT ON TABLE jobs IS 'jobs table with job titles and salary ranges. Contains 19 rows.
References with employees and job_history table.'
/
COMMENT ON COLUMN jobs.job_id IS 'Primary key of jobs table.'
/
COMMENT ON COLUMN jobs.job_title IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT'
/
COMMENT ON COLUMN jobs.max_salary IS 'Maximum salary for a job title'
/
COMMENT ON COLUMN jobs.min_salary IS 'Minimum salary for a job title.'
/

-- End of DDL Script for Table HR.JOBS

-- Start of DDL Script for Table HR.LOCATIONS
-- Generated 16-Abr-2010 5:02:47 from HR@XE

CREATE TABLE locations
    (location_id                    NUMBER(4,0) NOT NULL,
    street_address                 VARCHAR2(40),
    postal_code                    VARCHAR2(12),
    city                           VARCHAR2(30) NOT NULL,
    state_province                 VARCHAR2(25),
    country_id                     CHAR(2)
  ,
  CONSTRAINT LOC_ID_PK
  PRIMARY KEY (location_id)
  USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  ))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/





-- Indexes for LOCATIONS

CREATE INDEX loc_city_ix ON locations
  (
    city                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

CREATE INDEX loc_state_province_ix ON locations
  (
    state_province                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

CREATE INDEX loc_country_ix ON locations
  (
    country_id                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/



-- Constraints for LOCATIONS

ALTER TABLE locations
ADD CONSTRAINT loc_city_nn CHECK ("CITY" IS NOT NULL)
/



-- Comments for LOCATIONS

COMMENT ON TABLE locations IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables. '
/
COMMENT ON COLUMN locations.city IS 'A not null column that shows city where an office, warehouse, or
production site of a company is located. '
/
COMMENT ON COLUMN locations.country_id IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.'
/
COMMENT ON COLUMN locations.location_id IS 'Primary key of locations table'
/
COMMENT ON COLUMN locations.postal_code IS 'Postal code of the location of an office, warehouse, or production site
of a company. '
/
COMMENT ON COLUMN locations.state_province IS 'State or Province where an office, warehouse, or production site of a
company is located.'
/
COMMENT ON COLUMN locations.street_address IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name'
/

-- End of DDL Script for Table HR.LOCATIONS

-- Foreign Key
ALTER TABLE locations
ADD CONSTRAINT loc_c_id_fk FOREIGN KEY (country_id)
REFERENCES countries (country_id)
/
-- End of DDL script for Foreign Key(s)
-- Start of DDL Script for Table HR.REGIONS
-- Generated 16-Abr-2010 5:02:47 from HR@XE

CREATE TABLE regions
    (region_id                      NUMBER NOT NULL,
    region_name                    VARCHAR2(25)
  ,
  CONSTRAINT REG_ID_PK
  PRIMARY KEY (region_id)
  USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  ))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/





-- Constraints for REGIONS

ALTER TABLE regions
ADD CONSTRAINT region_id_nn CHECK ("REGION_ID" IS NOT NULL)
/

ALTER TABLE countries
ADD CONSTRAINT countr_reg_fk FOREIGN KEY (region_id)
REFERENCES regions (region_id)
/
ALTER TABLE departments
ADD CONSTRAINT dept_loc_fk FOREIGN KEY (location_id)
REFERENCES locations (location_id)
/

ALTER TABLE employees
ADD CONSTRAINT emp_job_fk FOREIGN KEY (job_id)
REFERENCES jobs (job_id)
/
ALTER TABLE employees
ADD CONSTRAINT emp_manager_fk FOREIGN KEY (manager_id)
REFERENCES employees (employee_id)
/
-- Foreign Key
ALTER TABLE job_history
ADD CONSTRAINT jhist_job_fk FOREIGN KEY (job_id)
REFERENCES jobs (job_id)
/
ALTER TABLE job_history
ADD CONSTRAINT jhist_emp_fk FOREIGN KEY (employee_id)
REFERENCES employees (employee_id)
/
ALTER TABLE job_history
ADD CONSTRAINT jhist_dept_fk FOREIGN KEY (department_id)
REFERENCES departments (department_id)
/

