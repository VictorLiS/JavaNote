-- 多表查询
-- 准备数据
create table dept1(
     id   int auto_increment comment 'ID' primary key,
     name varchar(50) not null comment '部门名称'
)comment '部门表';

create table employee3(
    id  int auto_increment comment 'ID' primary key,
    name varchar(50) not null comment '姓名',
    age  int comment '年龄',
    job varchar(20) comment '职位',
    salary int comment '薪资',
    entrydate date comment '入职时间',
    managerid int comment '直属领导ID',
    dept_id int comment '部门ID'
)comment '员工表';

-- 添加外键
alter table employee3 add constraint fk_empdept_id foreign key (dept_id) references dept1(id);

INSERT INTO dept1 (id, name) VALUES (1, '研发部'), (2, '市场部'),(3, '财务部'), (4, '销售部'), (5, '总经办'), (6, '人事部');
INSERT INTO employee3
    (id, name, age, job,salary, entrydate, managerid, dept_id)
VALUES
   (1, '金庸', 66, '总裁',20000, '2000-01-01', null,5),
   (2, '张无忌', 20, '项目经理',12500, '2005-12-05', 1,1),
   (3, '杨逍', 33, '开发', 8400,'2000-11-03', 2,1),
   (4, '韦一笑', 48, '开发',11000, '2002-02-05', 2,1),
   (5, '常遇春', 43, '开发',10500, '2004-09-07', 3,1),
   (6, '小昭', 19, '程序员鼓励师',6600, '2004-10-12', 2,1),
   (7, '灭绝', 60, '财务总监',8500, '2002-09-12', 1,3),
   (8, '周芷若', 19, '会计',48000, '2006-06-02', 7,3),
   (9, '丁敏君', 23, '出纳',5250, '2009-05-13', 7,3),
   (10, '赵敏', 20, '市场部总监',12500, '2004-10-12', 1,2),
   (11, '鹿杖客', 56, '职员',3750, '2006-10-03', 10,2),
   (12, '鹤笔翁', 19, '职员',3750, '2007-05-09', 10,2),
   (13, '方东白', 19, '职员',5500, '2009-02-12', 10,2),
   (14, '张三丰', 88, '销售总监',14000, '2004-10-12', 1,4),
   (15, '俞莲舟', 38, '销售',4600, '2004-10-12', 14,4),
   (16, '宋远桥', 40, '销售',4600, '2004-10-12', 14,4),
   (17, '陈友谅', 42, null,2000, '2011-10-12', 1,null);

-- 笛卡尔积
select *from employee3,dept1 where dept_id=dept1.id;

-- 内连接
-- 1.查询每一个员工的姓名及关联的部门的名称（式内连接实现）
select employee3.name,dept1.name from dept1,employee3 where dept_id=dept1.id;

-- 2.查询每一个员工的姓名，及关联的部门的名称(显式内连接实现)
select employee3.name,dept1.name from employee3 inner join dept1 on employee3.dept_id=dept1.id;

-- 外连接
-- 左外连接
-- 查询emp表的所有数据，和对应的部门信息(左外连接)
select employee3.*,dept1.name from employee3 left outer join dept1 on dept_id=dept1.id;

-- 右外连接
-- 查询dept表的所有数据，和对应的员工信息(右外连接)
select dept1.*,employee3.name from dept1 right join employee3 on dept_id=dept1.id;

-- 自连接
-- 1.查询员工及其所属领导的名字
select e1.name '员工',e2.name'领导' from employee3 e1,employee3 e2 where e1.managerid=e2.id;

-- 2.查询所有员工 emp 及其领导的名字emp，如果员工没有领导，也需要查询出来
select e1.name '员工',e2.name'领导' from employee3 e1 left join employee3 e2 on e1.managerid=e2.id;

-- 联合查询
-- 将薪资低于 5000 的员工，和年龄大于 50 岁的员工全部查询出来。
select * from employee3 where salary<5000
union
select * from employee3 where age>50;

-- 子查询
-- 标量子查询
-- 1.查询“销售部”的所有员工信息
-- 先查询销售部的部门id，再根据id来查询员工
select *from employee3 where dept_id=(select id from dept1 where dept1.name='销售部');

-- 2.查询在“方东白”入职之后的员工信息
select *from employee3 where entrydate>(select entrydate from employee3 where name='方东白');

-- 列子查询
-- 1.查询“销售部”和“市场部”的所有员工信息
select *from employee3 where dept_id in (select dept1.id from dept1 where dept1.name='销售部' or dept1.name='市场部');

-- 2.查询比市场部所有人工资都高的员工信息
select *from employee3 where salary > all(select employee3.salary from employee3 where dept_id=(select id from dept1 where dept1.name='财务部'));

-- 3.查询比研发部任意一人工资高的员工信息
select *from employee3 where salary> any(select employee3.salary from employee3 where dept_id=(select id from dept1 where dept1.name='研发部'));

-- 行子查询
-- 1.查询与“张无忌”的薪资及直属领导相同的员工信息
select *from employee3 where (salary,managerid)=(select salary,managerid from employee3 where name='张无忌');

-- 表子查询
-- 1.查询与“鹿杖客”，"宋远桥”的职位和薪资相同的员工信息
select *from employee3 where (job,salary) in (select job,salary from employee3 where name in('鹿杖客','宋远桥'));

-- 2.查询入职日期是“2006-01-01”之后的员工信息，及其部门信息
select e.name,e.entrydate,d.name from (select * from employee3 where entrydate >'2006-01-01') as e left join dept1 as d on e.dept_id=d.id;

-- 多表查询案例
-- 薪资等级表
create table salgrade(
                         grade int,
                         losal int,
                         hisal int
) comment '薪资等级表';

insert into salgrade values (1,0,3000);
insert into salgrade values (2,3001,5000);
insert into salgrade values (3,5001,8000);
insert into salgrade values (4,8001,10000);
insert into salgrade values (5,10001,15000);
insert into salgrade values (6,15001,20000);
insert into salgrade values (7,20001,25000);
insert into salgrade values (8,25001,30000);


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