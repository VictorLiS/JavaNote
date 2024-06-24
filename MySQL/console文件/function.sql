-- 函数
-- 字符串函数
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

-- 数值函数
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

-- 日期函数
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

-- 流程控制函数
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


create table score(
    id int comment 'ID',
    name varchar(20)comment'姓名',
    math int comment'数学',
    english int comment'英语',
    chinese int comment'语文')
comment'学员成绩表';
insert into
    score(id, name, math, english, chinese)
values
    (1, 'Tom', 67, 88, 95 ),
    (2, 'Rose', 23,66, 9),
    (3, 'Jack' ,56, 98, 76);
-- 案例:统计班级各个学员的成绩，展示的规则如下:
-- >= 85，展示优秀
-- >= 60，展示及格,否则，展示不及格
select
    id,
    name,
    (case when math >= 85 then'优秀'when math >=60 then'及格'else'不及格'end )as '数学',
    (case when score.english >= 85 then'优秀'when score.english >=60 then'及格'else'不及格'end )as '英语',
    (case when score.chinese >= 85 then'优秀'when score.chinese >=60 then'及格'else'不及格'end )as '语文'
    from score;