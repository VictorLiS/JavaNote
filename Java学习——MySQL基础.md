# Java学习——MySQL基础

## MySQL概述

![image-20240613191558001](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240613191558001.png)

### 关系型数据库（RDBMS）

概念：建立在关系模型基础上，由**多张相互连接的二维表**组成的数据库

特点：使用表存储，格式统一，便于维护；使用SQL语言进行操作，标准统一，使用方便

### MySQL数据模型

一个DBMS可以创建多个数据库，一个数据库有多张表

## SQL

### SQL通用语法

1. SQL语句可以单行或多行书写，以**分号**结尾，
2. SQL语句可以使用空格/缩进来增强语句的可读性。
3. MySQL数据库的SQL语句不区分大小写，关键字建议使用大写，
4. 注释:
   1. 单行注释:--注释内容 或 #注释内容(MySOL特有)
   2. 多行注释:/*注释内容 */

### SQL分类

![image-20240613195417382](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240613195417382.png)

#### DDL

##### 数据类型

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240613211002385.png" alt="image-20240613211002385"  />

![image-20240613211053424](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240613211053424.png)

![image-20240613211120804](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240613211120804.png)

##### 数据库操作

查询

```sql
查询所有数据库
SHOW DATABASES;

查询当前数据库
SELECT DATABASE();
```

创建

```sql
CREATE DATABASE [IF NOT EXISTS] 数据库名 [DEFAULT CHARSET字符集][COLLATE 排序规则];
```

删除

```sql
DROP DATABASE[IF EXISTS]数据库名
```

使用

```sql
USE 数据库名;
```

##### 表操作

查询

```sql
查询当前数据库中所有的表
SHOW TABLES;

查询表结构
DESC 表名;

查询指定表的建表语句
SHOW CREATE TABLE 表名;
```

创建

```sql
CREATE TABLE 表名(
	字段1 字段1类型[COMMENT 字段1注释],
    字段2 字段2类型[COMMENT 字段2注释],
	字段3 字段3类型[COMMENT 字段3注释],
	字段n 字段n类型[COMMENT 字段n注释]
)[COMMENT 表注释];
```

修改

```sql
添加字段
ALTER TABLE 表名 ADD 字段名 类型 (长度)[COMMENT 注释][约束];

修改数据类型
ALTER TABLE 表名 MODIFY 字段名 新数据类型(长度);

修改字段名和字段类型
ALTER TABLE 表名 CHANGE 旧字段名 新字段名 类型(长度)[COMMENT 注释][约束];

修改表名
ALTER TABLE 表名 RENAME TO 新表名;

删除字段
ALTER TABLE 表名 DROP 字段名;
```

删除

```sql
删除表
DAOP TABLE[IF EXISTS]表名;

删除指定表，并重新创建该表
TRUNCATE TABLE 表名;
```

#### DML

##### 添加数据（INSERT）

```sql
给指定字段添加数据
INSERT INTO 表名 (字段名1,字段名2,….) VALUES(值1,值2,..);
insert into employee(id, workno, name, gender, age, idcard, entrydate) values (1,'1','Itcast','男',10,'123456789123456789','2000-01-01');

给全部字段添加数据
INSERT INTO 表名 VALUES(值1,值2,..);
insert into employee values(2,'2','张三','男',18,'987654321123456789','2005-01-01');

批量添加数据
INSERT INTO 表名 (字段名1,字段名2,..) VALUES (值1,值2,….),(值1,值2,….),(值1,值2,.);
INSERT INTO 表名 VALUES (值1,值2,….),(值1,值2,….)(值1,值2,….);
insert into employee values(3,'3','李四','男',19,'987654321123456789','2006-01-01'),(4,'4','王五','男',20,'987654321123456789','2006-02-02');
```

注意：

- 插入数据时，字段顺序和值的顺序**一一对应**
- **字符串**和**日期**型数据包含在**引号**中

##### 修改数据（UPDATE）

```sql
UPDATE 表名 SET 字段名1=值1,字段名2=值2,…[WHERE 条件];

-- 修改id为1 的数据，将name修改为itheima
update employee set name ='itheima' where id=1;

-- 修改id为1 的数据，将name修改为小昭，gender 修改为女
update employee set name='小昭',gender='女' where id=1;

-- 将所有的员工入职日期修改为 2008-01-01
update employee set entrydate='2008-01-01';
```

##### 删除数据（DELETE）

```sql
DELETE FROM 表名[WHERE 条件]

-- 删除gender 为女的员工
delete FROM employee WHERE gender='女';
```

- DELETE 语句不能删除某一个字段的值

#### DQL

##### 语法

```sql
SELECT
	字段列表
FROM
	表名列表
WHERE
	条件列表
GROUP BY
	分组字段列表
HAVING
	分组后条件列表
ORDER BY
	排序字段列表
LIMIT
	分页参数
```

##### 基本查询

```sql
查询多个字段
SELECT 字段1,字段2,字段3.. FROM 表名;
SELECT *FROM 表名;

设置别名
SELECT 字段1[AS 别名1],字段2[AS 别名2]…. FROM 表名;

去除重复记录
SELECT DISTINCT 字段列表 FROM 表名;

-- 基本查询
-- 1.查询指定字段 name，workno，age 返回
select employee1.name,employee1.workno,employee1.age from employee1;

-- 2.查询所有字段返回
select *from employee1;

-- 3.查询所有员工的工作地址，起别名
select employee1.workaddress as '工作地址' from employee1;

-- 4.查询公司员工的上班地址(不要重复)
select distinct employee1.workaddress from employee1;
```

##### 条件查询（where）

```sql
SELECT 字段列表 FROM 表名 WHERE 条件列表;
```

条件可以是**比较运算符**和**逻辑运算符**

![image-20240616142722721](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240616142722721.png)

```sql
-- 1.查询年龄等于88的员工
select * from employee1 where age=88;

-- 2.查询年龄小于20的员工信息
select * from employee1 where age<20;

-- 3.查询年龄小于等于 20 的员工信息
select *from employee1 where age<=20;

-- 4.查询没有身份证好的员工信息
select *from employee1 where idcard is null;

-- 5.查询有身份证号的员工信息
select *from employee1 where idcard is not null;

-- 6.查询年龄不等于 88的员工信息
select *from employee1 where age!=88;

-- 7.查询年龄在15岁(包含)到20岁(包含)之间的员工信息
select *from employee1 where age between 15 and 20;

-- 8.查询性别为女且年龄小于 25岁的员工信息
select *from employee1 where gender='女' and age<25;

-- 9.查询年龄等于18或20或40的员工信息
select *from employee1 where age=18 or age=20 or age=40;
select *from employee1 where age in(18,20,40);

-- 10.查询姓名为两个字的员工信息
select *from employee1 where name like '__';

-- 11.查询身份证号最后一位是X的员工信息
select *from employee1 where idcard like '%X';
```

##### 聚合函数

将一列作为一个整体，进行**纵向计算**

###### 常见的聚合函数

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240616144321600.png" alt="image-20240616144321600" style="zoom: 67%;" />

```sql
SELECT 聚合函数(字段列表) FROM 表名;

-- 1.统计该企业员工数量
select count(*) from employee1;

-- 2.统计该企业员工的平均年龄
select avg(employee1.age) from employee1;

-- 3.统计该企业员工的最大年龄
select max(employee1.age) from employee1;

-- 4.统计该企业员工的最小年龄
select min(employee1.age) from employee1;

-- 5.统计西安地区员工的年龄之和
select sum(employee1.age) from employee1 where workaddress='西安';
```

null值不参与聚合函数

##### 分组查询（group by）

```sql
SELECT 字段列表 FROM 表名[WHERE 条件] GROUP BY 分组字段名[HAVING 分组后过滤条件];
```

where和having 的区别

- 执行时机不同:where是分组之前进行过滤，不满足where条件，不参与分组;而having是分组之后对结果进行过滤。
- 判断条件不同:where不能对聚合函数进行判断，而having可以。

```sql
-- 1.根据性别分组，统计男性员工和女性员工的数量
select gender,count(*) from employee1 group by gender;

-- 2.根据性别分组，统计男性员工和女性员工的平均年龄
select employee1.gender,avg(employee1.age) from employee1 group by gender;

-- 3.查询年龄小于45的员工 ，并根据工作地址分组 ，获取员工数量大于等于3的工作地址
select employee1.workaddress,count(*) from employee1 where age<45 group by workaddress having count(*)>=3;
```

##### 排序查询（order by）

```sql
SELECT 字段列表 FROM 表名 ORDER BY 字段1 排序方式1,字段2 排序方式2;
```

- ASC：升序（默认）
- DESC：降序
- 如果是多字段排序，当第一个字段值相同时，才会根据第二个字段进行排序

```sql
-- 1.根据年龄对公司的员工进行升序排序
select name,employee1.entrydate from employee1 order by entrydate asc;

-- 2.根据入职时间，对员工进行降序排序
select name,employee1.entrydate from employee1 order by entrydate desc;

-- 3.根据年龄对公司的员工进行升序排序，年龄相同 ，再按照入职时间进行降序排序
select name,employee1.age,employee1.entrydate from employee1 order by age asc ,entrydate desc;
```

##### 分页查询（limit）

```sql
SELECT 字段列表 FROM 表名 LIMIT 起始索引, 查询记录数;
```

起始索引=（查询页码-1）*每页显示的记录数

```sql
-- 1.查询第一页的数据，每一页展示10条记录
select *from employee1 limit 0,10;

-- 2.查询第2页员工数据，每页展示10条记录
select *from employee1 limit 10,10;
```

##### 案例

```sql
-- 1.查询年龄为20,21,22,23岁的员工信息。
select *from employee1 where age>=20 and age<=23;

-- 2.查询性别为 男 ，并且年龄在 20-40 岁(含)以内的姓名为三个字的员工。
select *from employee1 where gender='男' and age between 20 and 40 and name like '___';

-- 3.统计员工表中,年龄小于60岁的，男性员工和女性员工的人数。
select gender,count(*) from employee1 where age<60 group by gender;

-- 4.查询所有年龄小于等于35岁员工的姓名和年龄，并对查询结果按年龄升序排序，如果年龄相同按入职时间降序排序。
select employee1.name,employee1.age,entrydate from employee1 where age<35 order by age,entrydate desc ;

-- 5.查询性别为男，且年龄在20-40岁(含)以内的前5个员工信息，对查询的结果按年龄升序排序，年龄相同按入职时间升席排序
select *from employee1 where age between 20 and 40 order by age,entrydate;
```

##### 执行顺序

```sql
FROM
	表名列表
WHERE
	条件列表
GROUP BY
	分组字段列表
HAVING
	分组后条件列表
SELECT
	字段列表
ORDER BY
	排序字段列表
LIMIT
	分页参数
```

#### DCL

##### 管理用户

```sql
查询用户
USE mysql;
SELECT *FROM user;

创建用户
CREATE USER '用户名'@'主机名'IDENTIFIED BY '密码';

修改用户密码
ALTER USER '用户名'@'主机名’ IDENTIFIED WITH mysql native password BY '新密码';

删除用户
DROP USER'用户名'@'主机名';
```

```sql
-- 创建用户 itcast ，只能够在当前主机localhost访问，密码123456;
create user 'itcast'@'localhost' identified by '123456';

-- 创建用户 heima ，可以在任意主机访问该数据库，密码123456;
create user 'heima'@'%' identified by '123456';

-- 修改用户 heima 的访问密码为 1234;
alter user 'heima'@'%' identified with mysql_native_password by '1234';

-- 删除itcast@localhost用户
drop user 'itcast'@'localhost';
```

##### 权限控制

```sql
查询权限
SHOW GRANTS FOR'用户名'@'主机名;

授予权限
GRANT 权限列表 ON 数据库名.表名 TO '用户名'@'主机名';

撤销权限
REVOKE 权限列表 ON 数据库名.表名 FROM'用户名'@'主机名';
```

```sql
-- 查询权限
show grants for 'heima'@'%';

-- 授予权限
grant all on itcast.* to 'heima'@'%';

-- 撤销权限
revoke all on itcast.* from 'heima'@'%';
```

## 函数

### 字符串函数

![image-20240617195538657](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240617195538657.png)

```sql
-- 字符串拼接
select concat('Hello',' MuSQL');

-- lower
select lower('Hello');

-- upper
select upper('Hello');

-- lpad
select lpad('01',5,'-');

-- rpad
select rpad('01',5,'-');

-- trim
select trim(' 123 ');

-- substring
select substring('Hello MySQL',1,5);

-- 1、由于业务需求变更，企业员工的工号，统一为5位数，目前不足5位数的全部在前面补0。比如:1号员工的工号应该为00001。
update employee1 set workno=lpad(workno,5,'0');
```

### 数值函数

![image-20240617201100539](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240617201100539.png)

```sql
-- ceil
select ceil(1.5);

-- floor
select floor(2.4);

-- mod
select mod(7,4);

-- rand
select rand();

-- round
select round(2.345,2);

-- 生成一个六位数的随机验证码
select round(rand(),6)*1000000;
```

### 日期函数

![image-20240617201944400](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240617201944400.png)

```sql
-- curdate()
select curdate();

-- curtime()
select curtime();

-- now()
select now();

-- year month day
select year(now());
select month(now());
select day(now());

-- date_add
select date_add(now(),INTERVAL 99 day);

-- datediff
select datediff('2022-1-24',now());

-- 查询所有员工的入职天数:并根据入职天数倒序排序
select name,entrydate from employee1 order by datediff(now(),entrydate)desc ;
```

### 流程控制函数

![image-20240617203116906](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240617203116906.png)

```sql
-- if
select if(true,'ok','error');

-- ifnull
select ifnull('ok','default');

-- case when then else end
-- 需求:查询emp表的员工姓名和工作地址(北京/上海---->一线城市，其他---->二线城市)
select
    name,
    (case employee1.workaddress when '北京' then '一线城市' when '上海' then '一线城市'else '二线城市' end) as '工作地址'
from
    employee1;

select
    id,
    name,
    (case when math >= 85 then'优秀'when math >=60 then'及格'else'不及格'end )as '数学',
    (case when score.english >= 85 then'优秀'when score.english >=60 then'及格'else'不及格'end )as '英语',
    (case when score.chinese >= 85 then'优秀'when score.chinese >=60 then'及格'else'不及格'end )as '语文'
    from score;
```

## 约束

约束是作用于表中字段上的规则，用于限制存储在表中的数据

![image-20240617215045058](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240617215045058.png)

```sql
create table user(
    id int primary key auto_increment comment '主键',
    name varchar(10) not null unique comment '姓名',
    age int unsigned check ( age>0 and age<=120 ) comment '年龄',
    status char(1) default '1' comment '状态',
    gender char(1) comment '性别'
)comment '用户表';

-- 插入数据
insert into
    user(name, age, status, gender)
VALUES
    ('Tom',19,'1','男'),
    ('Jerry',25,'0','男'); 
```

### 外键

外键用来让两张表的数据之间建立连接，从而保证数据的一致性和完整性。

具有外键的表称为子表，外键所关联的表是父表

![image-20240618130241777](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240618130241777.png)

```sql
添加外键
CREATE TABLE 表名(
	字段名 数据类型,
    ...
	[CONSTRAINT][外键名称] FOREIGN KEY (外键字段名) REFERENCES 主表 (主表列名)
);
ALTER TABLE 表名 ADD CONSTRAINT 外键名称 FOREIGN KEY(外键字段名)REFERENCES 主表(主表列名);
```

```sql
create table dept(
    id int auto_increment primary key comment '部门ID',
    name varchar(10) not null comment '部门名称'
)comment '部门表';
INSERT INTo dept (id,name)
    VALUES
        (1,'研发部'),
        (2,'市场部'),
        (3,'财务部'),
        (4,'销售部'),
        (5,'总经办');

create table employee2(
    id int auto_increment comment 'ID' primary key,
    name varchar(50) not null comment '姓名',
    age int unsigned comment '年龄',
    job varchar(20)comment '职位',
    salary int comment '薪资',
    entrydate date comment '入职时间',
    managerid int comment '直属领导ID',
    dept_id int comment '部门ID'
)comment '员工表';

INSERT into employee2 (id, name, age, job,salary, entrydate, managerid, dept_id)
VALUES
    (1,'金庸',66,'总裁',20000,'2000-01-01',null,5),
    (2,'张无忌',20,'项目经理',12500,'2005-12-05',1,1),
    (3,'杨道',33,'开发',8480,'2000-11-03',2,1),
    (4,'韦一笑',48,'开发',11000,'2002-02-05',2,1),
    (5,'常遇春',43,'开发',10500,'2004-09-07',3,1),
    (6,'小昭',19,'程序员鼓励师',6600,'2004-10-12',2,1);

-- 添加外键
alter table employee2 add constraint fk_emp_dept_id foreign key (dept_id) references dept(id);
-- 删除外键
alter table employee2 drop foreign key fk_emp_dept_id;
```

### 外键的删除和更新

![image-20240618133858051](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240618133858051.png)

```sql
ALTER TABLE 表名 ADD CONSTRAINT 外键名称 FOREIGN KEY(外键字段) REFERENCES 主表名(主表字段名) OINUPDATE CASCADE ON DELETE CASCADE;

-- 外键的更新和删除行为
alter table employee2 add constraint fk_emp_dept_id foreign key (dept_id) references dept(id) on update cascade on delete cascade;
```

## 多表查询

### 多表关系

#### 一对多（多对一）

案例：部门和员工的关系，一个部门多个员工

实现：在多的一方建立外键，指向一的一方的主键

#### 多对多

案例：学生与课程的关系，一节课有多个学生，一个学生可以选择多节课

实现：建立第三张中间表，中间表包含两个外键，**分别关联两方主键**

![image-20240619122459808](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240619122459808.png)

#### 一对一

案例：用户与用户详情的关系

关系：可用于单表拆分，基础字段放在一张表中，详细信息放在另一张表

实现：在任意一方加入外键，关联另外一方的主键，并**设置外键是唯一的**

### 多表查询

在多表查询时，需要消除笛卡尔积

#### 连接查询

##### 内连接

相当于查询A,B交集的部分

###### 隐式内连接

```sql
SELECT 字段列表 FROM 表1,表2 WHERE 条件...;

-- 1.查询每一个员工的姓名及关联的部门的名称（式内连接实现）
select employee3.name,dept1.name from dept1,employee3 where dept_id=dept1.id;
```

###### 显式内连接

```sql
SELECT 字段列表 FROM 表1 [INNER] JOIN 表2 ON 连接条件...;

-- 2.查询每一个员工的姓名，及关联的部门的名称(显式内连接实现)
select employee3.name,dept1.name from employee3 inner join dept1 on employee3.dept_id=dept1.id;
```

##### 外连接

###### 左外连接

查询左表所有数据，以及两张表交集部分数据

```sql
SELECT 字段列表 FROM 表1 LEFT [OUTER] JOIN 表2 ON 条件...;

-- 查询emp表的所有数据，和对应的部门信息(左外连接)
select employee3.*,dept1.name from employee3 left outer join dept1 on dept_id=dept1.id;
```

###### 右外连接

查询右表所有数据，以及两张表交集部分数据

```sql
SELECT 字段列表 FROM 表1 RIGHT [OUTER] JOIN 表2 ON 条件...;

-- 查询dept表的所有数据，和对应的员工信息(右外连接)
select dept1.*,employee3.name from dept1 right join employee3 on dept_id=dept1.id;
```

##### 自链接

当前表与自身的连接查询，自连接必须使用表的别名

自连接查询可以是内连接，也可以是外连接

```sql
SELECT 字段列表 FROM 表A 别名A JOIN 表A 别名B ON 条件;

-- 1.查询员工及其所属领导的名字
select e1.name '员工',e2.name'领导' from employee3 e1,employee3 e2 where e1.managerid=e2.id;

-- 2.查询所有员工 emp 及其领导的名字emp，如果员工没有领导，也需要查询出来
select e1.name '员工',e2.name'领导' from employee3 e1 left join employee3 e2 on e1.managerid=e2.id;
```

#### 联合查询

把多次查询的结果合并起来，形成一个新的查询结果集

```sql
SELECT 字段列表 FROM 表A UNION [ALL] SELECT 字段列表 FROM 表B;

-- 将薪资低于 5000 的员工，和年龄大于 50 岁的员工全部查询出来。
select * from employee3 where salary<5000
union
select * from employee3 where age>50;
```

union all 会将全部的数据直接合并在一起，union 会对合并之后的数据去重。

#### 子查询

SOL语句中嵌套SELECT语句，称为嵌套查询，又称子查询

```sql
SELECT *FROM t1 WHERE column1=(SELECT column1 FROM t2);
外部的语句可以是INSERT/UPDATE/DELETE/SELECT
```

根据子查询的结果，可以分为

##### 标量子查询

子查询结果为单个值

常用的操作符 ：= <> > >= < <=

```sql
-- 1.查询“销售部”的所有员工信息
-- 先查询销售部的部门id，再根据id来查询员工
select *from employee3 where dept_id=(select id from dept1 where dept1.name='销售部');

-- 2.查询在“方东白”入职之后的员工信息
select *from employee3 where entrydate>(select entrydate from employee3 where name='方东白');
```

##### 列子查询

子查询结果为一列

常用操作符：IN、NOT IN、ANY、SOME、ALL

![image-20240620132823408](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240620132823408.png)

```sql
-- 列子查询
-- 1.查询“销售部”和“市场部”的所有员工信息
select *from employee3 where dept_id in (select dept1.id from dept1 where dept1.name='销售部' or dept1.name='市场部');

-- 2.查询比市场部所有人工资都高的员工信息
select *from employee3 where salary > all(select employee3.salary from employee3 where dept_id=(select id from dept1 where dept1.name='财务部'));

-- 3.查询比研发部任意一人工资高的员工信息
select *from employee3 where salary> any(select employee3.salary from employee3 where dept_id=(select id from dept1 where dept1.name='研发部'));
```

##### 行子查询

子查询结果为一行

常用操作符：= ,<>, IN, NOT IN

```sql
-- 1.查询与“张无忌”的薪资及直属领导相同的员工信息
select *from employee3 where (salary,managerid)=(select salary,managerid from employee3 where name='张无忌');
```

##### 表子查询

子查询结果为多行多列

常用操作符：IN

```sql
-- 表子查询
-- 1.查询与“鹿杖客”，"宋远桥”的职位和薪资相同的员工信息
select *from employee3 where (job,salary) in (select job,salary from employee3 where name in('鹿杖客','宋远桥'));

-- 2.查询入职日期是“2006-01-01”之后的员工信息，及其部门信息
select e.name,e.entrydate,d.name from (select * from employee3 where entrydate >'2006-01-01') as e left join dept1 as d on e.dept_id=d.id;
```

#### 练习

```sql
# 1.查询员工的姓名、年龄、职位、部门信息
select e.name,e.age,e.job,d.name from employee3 e left join dept1 d on dept_id=d.id;

# 2.查询年龄小于30岁的员工姓名、年龄、职位、部门信息
select e.name,e.age,e.job,d.name from employee3 e left join dept1 d on dept_id=d.id where e.age<30;

# 3.查询拥有员工的部门ID、部门名称
select distinct d.id,d.name from dept1 d left join employee3 e on d.id=e.dept_id where e.id IS NOT NULL ;

# 4.查询所有年龄大于40岁的员工,及其归属的部门名称;如果员工没有分配部门,也需要展示出来
select e.*,d.name from employee3 e left join dept1 d on dept_id=d.id where e.age>40;

# 5.查询所有员工的工资等级
select e.name'员工姓名',s.grade'工资等级',e.salary'工资' from employee3 e,salgrade s where salary>=s.losal and salary<=s.hisal;

# 6.查询"研发部"所有员工的信息及工资等级
select e.name,e.salary,d.name,s.grade
from employee3 e,dept1 d ,salgrade s
where (e.dept_id=d.id)
  and
    d.name='研发部'
  and
    (e.salary between s.losal and s.hisal);

# 7.查询"研发部"员工的平均工资
select avg(e.salary) from employee3 e,dept1 d where e.dept_id=d.id and d.name='研发部';

# 8.查询工资比"灭绝"高的员工信息。
select *from employee3 where salary>(select salary from employee3 where name='灭绝');

# 9.查询比平均薪资高的员工信息
select *from employee3 where salary>(select avg(salary) from employee3);

# 10.查询低于本部门平均工资的员工信息
select d.name,dept_id,avg(salary)'平均工资' from employee3 e1,dept1 d where dept_id=d.id group by dept_id;
select e1.name,e2.name,salary,e2.平均工资 from employee3 e1,(select d.name,dept_id,avg(salary)'平均工资' from employee3 e1,dept1 d where dept_id=d.id group by dept_id) e2
         where e1.salary< e2.平均工资 and e1.dept_id=e2.dept_id;

# 11.查询所有的部门信息,并统计部门的员工人数。
select d.name,count(*) from employee3 e,dept1 d where dept_id=d.id group by dept_id;

# 12.查询所有学生的选课情况,展示出学生名称,学号,课程名称
select s.name,c.name from student s,student_course sc,course c where s.id=sc.student_id and sc.course_id=c.id;
```

## 事务

事务是一组操作的集合，它是一个不可分割的工作单位，事务会把所有的操作作为一个整体一起向系统提交或撤销操作请求，即这些操作**要么同时成功，要么同时失败。**

### 事务操作

#### 方式一

- 设置事务的提交方式，autocommit是1就是自动提交，0是手动提交

```sql
SELECT @@autocommit;
SET @@autocommit=0;
```

- 提交事务

```sql
COMMIT;
```

- 回滚事务

```sql
ROLLBACK;
```

```sql
select @@autocommit; -- 值为1代表当前事务是自动提交

set @@autocommit=0; -- 将提交方式设置为手动提交

-- 转账操作（张三给李四1000）
-- 1.查询张三的余额
select account.money from account where name='张三';

-- 2.将张三账户的余额 -1000
update account set money =money-1000 where name='张三';

-- 3。李四的账户余额 +1000
update account set money =money+1000 where name='李四';

-- 提交事务
commit ;

-- 执行出错的话，回滚事务
rollback ;
```

#### 方式二

- 开启事务

```sql
START TRANSACTION 或 BEGIN ;
```

- 提交事务

```sql
COMMIT;
```

- 回滚事务

```sql
ROLLBACK;
```

```sql
start transaction ;
-- 1.查询张三的余额
select account.money from account where name='张三';

-- 2.将张三账户的余额 -1000
update account set money =money-1000 where name='张三';

-- 3。李四的账户余额 +1000
update account set money =money+1000 where name='李四';

-- 提交事务
commit ;

-- 执行出错的话，回滚事务
rollback ;
```

### 事务四大特性（ACID）

- 原子性(Atomicity):事务是不可分割的最小操作单元，要么全部成功，要么全部失败。
- 一致性(Consistency):事务完成时，必须使所有的数据都保持一致状态
- 隔离性(Isolation):数据库系统提供的隔离机制，保证事务在不受外部并发操作影响的独立环境下运行。
- 持久性(Durability):事务一旦提交或回滚，它对数据库中的数据的改变就是永久的。

### 并发事务问题

![image-20240622152035808](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240622152035808.png)

### 事务的隔离级别

![image-20240622152544935](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240622152544935.png)

越往下，安全性越好，但是效率越低

```sql
-- 查看事务隔离级别
SELECT @@TRANSACTION_ISOLATION;

-- 设置事务隔离级别
SET [SESSION|GLOBAL] TRANSACTION,ISOLATION LEVEL {READ UNCOMMITED | READ COMMITED | REPEATABLE READ | SERIALIZABLE}
```

## 索引

### 索引介绍

索引是帮助MySQL**高效获取数据**的**数据结构**，这些数据结构以某种方式引用(指向)数据，这样就可以在这些数据结构上实现高级查找算法，这种数据结构就是索引。
![image-20240623213252615](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240623213252615.png)

### 索引结构 

MySQL的索引是在存储引擎层实现的，不同的存储引警有不同的结构，主要包含以下几种:

![image-20240623213942434](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240623213942434.png)

MySQL索引数据结构对经典的B+Tree进行了优化。在原B+Tree的基础上，**增加一个指向相邻叶子节点的链表指针**，就形成了带有顺序
指针的B+Tree，提高区间访问的性能。

![image-20240623222249739](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240623222249739.png)

#### 为什么选择B+树

- 相对于二叉树，层级更少，搜索效率高
- 对于B-tree，无论是叶子节点还是非叶子节点，都会保存数据，这样导致一页中存储的键值减少，指针跟着减少，要同样保存大量数据，只能增加树的高度，导致性能降低
- 相对Hash索引，B+tree支持范围匹配及排序操作

### 索引分类

![image-20240624100819592](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240624100819592.png)

根据索引的存储形式，又可以分为以下两种

![image-20240624101047457](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240624101047457.png)

聚集索引的选取规则

- 如果存在主键，主键索引就是聚集索引
- 如果不存在主键，将使用第一个唯一(UNIQUE)索引作为聚集索引
- 如果表没有主键，或没有合适的唯一索引，则nnoDB会自动生成一个rowid作为隐藏的聚集索引

下图的案例可以看出，聚集索引是把主键id当作索引，叶子节点存储的是这一行的数据，而当把name当作索引时，叶子节点存储的是这一行的id

![image-20240624102549635](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240624102549635.png)

假如说执行 select* from user where name ='Arm'; 语句，首先会在二级索引中找到所对应的id，再去聚集索引中寻找其他的信息，称之为**回表查询**

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240624102933223.png" alt="image-20240624102933223" style="zoom:67%;" />

### 索引语法

#### 创建索引

```sql
CREATE [UNIQUE|FULLTEXT] INDEX index_name ON table name (index col name...);

# 1.name字段为姓名字段，该字段的值可能会重复，为该字段创建索引
create index idx_user_name on tb_user(name);

# 2.phone手机号字段的值，是非空，且唯一的，为该字段创建唯一索引
create unique index idx_user_phone on tb_user(phone);

# 3.为profession、age、status创建联合索引
create index idx_user_pro_age_sta on tb_user(profession,age,status);

# 4.为email建立合适的索引来提升查询效率
create index idx_user_email on tb_user(email);
```

#### 查看索引

```sql
SHOW INDEX FROM table_name ;

show index from tb_user;
```

#### 删除索引

```sql
DROP INDEX index_name ON table_name;

drop index idx_user_email on tb_user;
```
