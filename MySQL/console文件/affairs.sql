-- 事务
-- 数据准备
create table account(
    id int auto_increment primary key comment '主键ID',
    name varchar(10) comment'姓名',
    money int comment'余额'
) comment'账户表';

insert into account (name, money) VALUES ('张三',2000),('李四',2000);

select @@autocommit; -- 值为1代表当前事务是自动提交

set @@autocommit=0; -- 将提交方式设置为手动提交

-- 转账操作（张三给李四1000）
-- 方式1
-- 1。查询张三的余额
select account.money from account where name='张三';

-- 2.将张三账户的余额 -1000
update account set money =money-1000 where name='张三';

-- 3。李四的账户余额 +1000
update account set money =money+1000 where name='李四';

-- 提交事务
commit ;

-- 执行出错的话，回滚事务
rollback ;

-- 方式2
start transaction ;
-- 1。查询张三的余额
select account.money from account where name='张三';

-- 2.将张三账户的余额 -1000
update account set money =money-1000 where name='张三';

-- 3。李四的账户余额 +1000
update account set money =money+1000 where name='李四';

-- 提交事务
commit ;

-- 执行出错的话，回滚事务
rollback ;

-- 查看事务的隔离级别
SELECT @@TRANSACTION_ISOLATION;

set session transaction isolation level repeatable read ;
