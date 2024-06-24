-- DML
insert into employee(id, workno, name, gender, age, idcard, entrydate) values (1,'1','Itcast','男',10,'123456789123456789','2000-01-01');

insert into employee values(2,'2','张三','男',18,'987654321123456789','2005-01-01');

insert into employee values(3,'3','李四','男',19,'987654321123456789','2006-01-01'),(4,'4','王五','男',20,'987654321123456789','2006-02-02');

-- 修改id为1 的数据，将name修改为itheima
update employee set name ='itheima' where id=1;

-- 修改id为1 的数据，将name修改为小昭，gender 修改为女
update employee set name='小昭',gender='女' where id=1;

-- 将所有的员工入职日期修改为 2008-01-01
update employee set entrydate='2008-01-01';

-- 删除gender 为女的员工
delete FROM employee WHERE gender='女';

-- DQL
