-- 多表关系
-- 多对多

create table student(
    id int auto_increment primary key comment 'id',
    name varchar(10) not null comment '学生',
    no varchar(10) unique comment '学号'
)comment '学生';

insert into
    student(name, no)
values
    ('黛绮丝','2000100101'),
    ('谢逊','2000100102'),
    ('殷天正','2000100103'),
    ('韦一笑','2000100104');

create table course(
    id int auto_increment primary key comment 'id',
    name varchar(10) not null comment '课程名称'
)comment '课程';

insert into
    course(name)
values
    ('java'),
    ('PHP'),
    ('MySQL'),
    ('C#');

create table student_course(
    id int auto_increment primary key comment 'id',
    student_id int not null comment '学生id',
    course_id int not null comment '课程id',
    constraint fk_courseid foreign key (course_id) references course(id),
    constraint fk_studentid foreign key (student_id) references student(id)
)comment '学生课程中间表';

insert into
    student_course(student_id, course_id)
values
    (1,1),
    (1,2),
    (1,3),
    (2,2),
    (2,3),
    (3,4);