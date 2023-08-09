create database Bank; -- creating the Database Bank
use Bank;   --  using the database Bank  


create table bank ( age int,job varchar(50),marital varchar(50),education varchar(50),                        -- creating the table bank with all the column names and importing CSV file downloaded after EDA analysis
balance int,housing varchar(15),loan varchar(15),contact varchar(50),day_ int,month_ varchar(15),duration int,campaign int,poutcome varchar(50),Term_deposit varchar(15));

-- 1) Write an SQL query to identify the age group which is taking more loan and then calculate the sum of all of the balances of it?
select age,count(age) from bank where housing = 'yes' and loan = 'yes' group by age order by count(age);              -- getting the details using select statemet and where condition
select sum(balance) as Sum_of_Balance from bank where age in (select age from bank where housing = 'yes' and loan = 'yes') and balance in (select balance from bank where housing = 'yes' and loan = 'yes');   -- calculating the total balance of age group people who take more loans

-- 2) Write an SQL query to calculate for each record if a loan has been taken less than 100, then  calculate the fine of 15% of the current balance and create a temp table and then add the amount for each month from that temp table? 
# Considering the given question is incomplete or inaccurate, we are assuming the question as 'Calculate for each record if a loan has been taken with duration less than 100, and so on...'
select month_,balance from bank where loan = 'yes'and housing = 'yes' and duration < 100;    -- getting month and balance using where clause for the assumed condition   
create temporary table temporary_table (select month_, ABS(0.15*balance) as interest from bank where loan = 'yes'and housing = 'yes' and duration < 100);   -- creating a temporary table and aloting the interest amount with month to the table, using ABS to get positive values only
select month_, sum(interest) from temporary_table group by month_;      -- selcting month and totaling up the interest from temporary table

-- 3) Write an SQL query to calculate each age group along with each department's highest balance record?
select age, job, balance from bank where balance in (select max(balance) from bank group by job) order by age;      -- Getting the highest balance from each department(job) with age group


-- 4) Write an SQL query to find the secondary highest education, where duration is more than 150. The query should contain only married people, and then calculate the interest amount? (Formula interest => balance*15%). 
select count(education) as num_of_secondary_edu from bank where education = 'secondary' and duration > 150 and marital = 'married';     -- Getting the secondary education count using where clause 
select sum(balance * 0.15) as sum_of_interest from bank where education = 'secondary' and duration > 150 and marital = 'married';    -- Calculating only interest amount as mentioned in the question


-- 5) Write an SQL query to find which profession has taken more loan along with age?
select age, job, count(job) as no_of_loan from bank where housing = 'yes' and loan = 'yes' group by job order by count(job);     -- Getting the age and profession with where condition who has taken more loan with age
select age, job, count(job) as no_of_loan from bank where housing = 'yes' and loan = 'yes' group by job order by count(job) desc limit 0,1;


-- 6) Write an SQL query to calculate each month's total balance and then calculate in which month the highest amount of transaction was performed?
select month_, sum(balance) as Total_Balance from bank group by month_;       -- Calculating total balance of each month using sum and group by function
select month_, sum(balance) as Total_Balance from bank group by month_ order by Total_Balance desc limit 0,1;   -- Getting the month with highest amount of transaction
