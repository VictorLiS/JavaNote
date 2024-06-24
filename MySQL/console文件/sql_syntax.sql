create table employee1(
    id          int                 comment '编号',
    workno      varchar(10)         comment '工号',
    name        varchar(10)         comment '姓名',
    gender      char(1)             comment '性别',
    age         tinyint unsigned    comment '年龄',
    idcard      char(18)            comment '身份证号',
    workaddress varchar(50)         comment '工作地址',
    entrydate   date                comment '入职时间'
)comment '员工表';

insert into employee1 values
    (1,'1','柳岩','女',20,'123456789012345678','北京','2000-01-01'),
    (2,'2','张无忌','男',18,'123456789012345670','北京','2005-09-01'),
    (3,'3','韦一笑','男',38,'123456789712345670','上海','2005-08-01'),
    (4,'4','赵敏','女',18,'123456757123845670','北京','2009-12-01'),
    (5,'5','小昭','女',16,'123456769012345678','上海','2007-07-01'),
    (6,'6','杨逍','男',28,'12345678931234567X','北京','2006-01-01'),
    (7,'7','范瑶','男',40,'123456789212345670','北京','2005-05-01'),
    (8,'8','黛绮丝','女',38,'123456157123645670','天津','2015-05-01'),
    (9,'9','范凉凉','女',45,'123156789012345678','北京','2010-04-01'),
    (10,'10','陈友谅','男',53,'123456789012345670','上海','2011-01-01'),
    (11,'11','张士诚','男',55,'123567897123465670','江苏','2015-05-01'),
    (12,'12','常遇春','男',32,'123446757152345670','北京','2004-02-01'),
    (13,'13','张三丰','男',88,'123656789012345678','江苏','2020-11-01'),
    (14,'14','灭绝','女',65,'123456719012345670','西安','2019-05-01'),
    (15,'15','胡青牛','男',70,'12345674971234567X','西安','2018-04-01'),
    (16,'16','周芷若','女',18,null,'北京','2012-06-01');


-- --------------------查询需求--------------------
-- 基本查询
-- 1.查询指定字段 name，workno，age 返回
select employee1.name,employee1.workno,employee1.age from employee1;

-- 2.查询所有字段返回
select *from employee1;

-- 3.查询所有员工的工作地址，起别名
select employee1.workaddress as '工作地址' from employee1;

-- 4.查询公司员工的上班地址(不要重复)
select distinct employee1.workaddress from employee1;

-- 条件查询
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

-- 聚合函数
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

-- 分组查询
-- 1.根据性别分组，统计男性员工和女性员工的数量
select gender,count(*) from employee1 group by gender;

-- 2.根据性别分组，统计男性员工和女性员工的平均年龄
select employee1.gender,avg(employee1.age) from employee1 group by gender;

-- 3.查询年龄小于45的员工 ，并根据工作地址分组 ，获取员工数量大于等于3的工作地址
select employee1.workaddress,count(*) from employee1 where age<45 group by workaddress having count(*)>=3;

-- 排序查询
-- 1.根据年龄对公司的员工进行升序排序
select name,employee1.entrydate from employee1 order by entrydate asc;

-- 2.根据入职时间，对员工进行降序排序
select name,employee1.entrydate from employee1 order by entrydate desc;

-- 3.根据年龄对公司的员工进行升序排序，年龄相同 ，再按照入职时间进行降序排序
select name,employee1.age,employee1.entrydate from employee1 order by age asc ,entrydate desc;

-- 分页查询
-- 1.查询第一页的数据，每一页展示10条记录
select *from employee1 limit 0,10;

-- 2.查询第2页员工数据，每页展示10条记录
select *from employee1 limit 10,10;

-- 案例
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


-- DCL
-- 管理用户
-- 创建用户 itcast ，只能够在当前主机localhost访问，密码123456;
create user 'itcast'@'localhost' identified by '123456';

-- 创建用户 heima ，可以在任意主机访问该数据库，密码123456;
create user 'heima'@'%' identified by '123456';

-- 修改用户 heima 的访问密码为 1234;
alter user 'heima'@'%' identified with mysql_native_password by '1234';

-- 删除itcast@localhost用户
drop user 'itcast'@'localhost';

-- 权限控制
-- 查询权限
show grants for 'heima'@'%';

-- 授予权限
grant all on itcast.* to 'heima'@'%';

-- 撤销权限
revoke all on itcast.* from 'heima'@'%';
