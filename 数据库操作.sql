-- Active: 1664204611911@@127.0.0.1@3306@class_manage_system
-- 1. 创建数据库：class_manage_system
create database if not exists class_manage_system default character set "utf8";

------------------------------------------------------------------------------------

-- 2. 创建表：
-- 2.1班级表classes
create table if not exists class_manage_system.classes(
    id                  int         not null primary key auto_increment comment "id",
    cls                 varchar(32) not null comment "班级",
    grade               varchar(32) comment "年级",
    depart              varchar(32) comment "院系",
    head_teacher_id     tinyint not null comment "班主任id"
) default charset=utf8 comment '班级表';

-- 2.2班主任表head_teachers
create table if not exists class_manage_system.head_teachers(
    id          int         not null primary key auto_increment comment "id",
    name        varchar(32) not null comment "姓名",
    username    varchar(64) not null comment "用户名",
    passwd      varchar(64) not null comment "密码",
    depart      varchar(32) comment "院系",
    token       varchar(32) comment "token"
) default charset=utf8 comment '班主任表';

-- 2.3系主任表head_departs
create table if not exists class_manage_system.head_departs(
    id          int         not null primary key auto_increment comment "id",
    name        varchar(32) not null comment "姓名",
    username    varchar(64) not null comment "用户名",
    passwd      varchar(64) not null comment "密码",
    depart      varchar(32) comment "院系",
    token       varchar(32) comment "token"
) default charset=utf8 comment '系主任表';

-- 2.4检查员表inspectors
create table if not exists class_manage_system.inspectors(
    id          int         not null primary key auto_increment comment "id",
    name        varchar(32) not null comment "姓名",
    username    varchar(64) not null comment "用户名",
    passwd      varchar(64) not null comment "密码",
    depart      varchar(32) comment "院系",
    token       varchar(32) comment "token"
) default charset=utf8 comment '检查员表';

-- 2.5检查结果表inspect_results
create table if not exists class_manage_system.inspect_results(
    id          int             not null primary key auto_increment comment "id",
    cls         varchar(32)     not null comment "班级",
    clean       varchar(512)    not null default '{"分数":100}' comment "卫生",
    dormitory   varchar(512)    not null default '{"分数":100}' comment "宿舍",
    clothes     varchar(512)    not null default '{"分数":100}' comment "校服",
    discipline  varchar(512)    not null default '{"分数":100}' comment "纪律",
    head_teacher_id     tinyint not null comment "班主任id",
    inspect_time        datetime    default now() comment "检查时间"
) default charset=utf8 comment '检查结果表';

-- 2.6 检查项目表


-- 删除表
-- drop table  if exists classes;
-- drop table  if exists head_teachers;
-- drop table  if exists head_departs;
-- drop table  if exists inspectors;
-- drop table  if exists inspect_results;

------------------------------------------------------------------------------------

-- 3. 插入数据
-- 3.1班级表
insert into classes(`cls`,`grade`,`depart`,`head_teacher_id`)
values 
("1班","2020级","大数据",1),
("2班","2020级","大数据",2),
("1班","2021级","大数据",3);

-- 3.2班主任表
insert into head_teachers(`name`,`username`,`passwd`,`depart`)
values
("邢予","邢予","xingyu321","大数据"),
("吴洁","吴洁","wujie321","大数据"),
("王钰坤","王钰坤","wangyukun321","大数据");

-- 3.3系主任表
insert into head_departs(`name`,`username`,`passwd`,`depart`)
values 
("陕娟娟","陕娟娟","shanjuanjuan321","大数据"),
("王璐","王璐","wanglu321","大数据"),
("赵东","赵东","zhaodong321","大数据"),
("方荣卫","方荣卫","fangrongwei321","大数据");

-- 3.4检查员表
insert into inspectors(`name`,`username`,`passwd`,`depart`)
values 
("陕娟娟","陕娟娟","shanjuanjuan321","大数据"),
("王璐","王璐","wanglu321","大数据"),
("赵东","赵东","zhaodong321","大数据"),
("吴洁","吴洁","wujie321","大数据");

