***HRDATASET DATABASE***

1.
CREATE TABLE IF NOT EXISTS Manager_info
(
    id bigint NOT NULL,
    name char(40) NOT NULL,
    PRIMARY KEY (id)
);
insert into manager_info
select distinct managerid, managername
from hrd;

2.
CREATE TABLE IF NOT EXISTS Department_info
(
    id bigint NOT NULL,
    Dept_name cahr(40) NOT NULL,
    PRIMARY KEY (id)
);
insert into department_info
select distinct deptid, department
from hrd;

3.
CREATE TABLE IF NOT EXISTS Performance
(
    id bigint NOT NULL,
    metric char(40) NOT NULL,
    PRIMARY KEY (id)
);
insert into performance
select distinct perfscoreid, performancescore
from hrd;

4.
CREATE TABLE IF NOT EXISTS Role
(
    id bigint NOT NULL,
    role_name char(40) NOT NULL,
    dept_id bigint NOT NULL,
    PRIMARY KEY (id)
);
insert into role
select distinct positionid, position, deptid
from hrd;

ALTER TABLE IF EXISTS Role
    ADD CONSTRAINT id FOREIGN KEY (dept_id)
    REFERENCES Department_info (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

5.
CREATE TABLE IF NOT EXISTS Marital_status
(
    id bigint NOT NULL,
    status char(40) NOT NULL,
    PRIMARY KEY (id)
);
insert into marital_status
select distinct maritalstatusid, maritaldesc
from hrd;

6.
CREATE TABLE IF NOT EXISTS Emp_status
(
    id bigint NOT NULL,
    status char(40) NOT NULL,
    PRIMARY KEY (id)
);
insert into emp_status
select distinct empstatusid, employmentstatus
from hrd;

7.
CREATE TABLE IF NOT EXISTS Demographic
(
    Emp_id bigint NOT NULL,
    citizenship char(40) NOT NULL,
    hispano_latino char(40) NOT NULL,
    Race char(40) NOT NULL,
    FOREIGN KEY (Emp_id) REFERENCES Emp_info (id)
);
insert into demographic
select empid, citizendesc, hispaniclatino, racedesc
from hrd;

8.
CREATE TABLE IF NOT EXISTS Emp_hire_history
(
    hire_date date,
    term_date date,
    term_reason char(40),
    days_late integer,
    absences integer,
    emp_status_id bigint,
    perf_id bigint,
    FOREIGN KEY (emp_status_id)    REFERENCES Emp_status (id),
     FOREIGN KEY (perf_id)REFERENCES performance (id)
);
insert into emp_hire_history
select dateofhire, 
	dateoftermination,
	termreason,
	dayslatelast30,
	absences,
	empstatusid,
	perfscoreid
from hrd;

9.
CREATE TABLE IF NOT EXISTS Emp_info
(
    id bigint NOT NULL,
    name char(40),
    state char(40),
    zip integer,
    dob date,
    sex char(40),
    salary integer,
    recruit_method char(40),
    role_id bigint,
    perf_id bigint,
    marital_id bigint,
    manager_id bigint,
    PRIMARY KEY (id),
    FOREIGN KEY (role_id)    REFERENCES Role (id),
     FOREIGN KEY (perf_id)REFERENCES Performance (id),
     FOREIGN KEY (marital_id)    REFERENCES Marital_status (id),
      FOREIGN KEY (manager_id)    REFERENCES Manager_info (id)
);
insert into emp_info
select empid,
	employee_name,
	state,
	zip,
	dob,
	sex,
	salary,
	recruitmentsource,
	positionid,
	perfscoreid,
	maritalstatusid,
	managerid
from hrd;