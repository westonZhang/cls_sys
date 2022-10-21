-- Active: 1666235150193@@101.43.61.66@3306@cls_sys
-- 一、 创建数据库：cls_sys
create database if not exists cls_sys default character set "utf8";

------------------------------------------------------------------------------------

-- 二、 创建表：
-- 2.1 人员表 user
create table if not exists user(
    id         varchar(64) not null primary key comment "对姓名使用md5加密的id",
    name        varchar(32) not null comment "姓名",
    username    varchar(64) not null comment "登陆的用户名",
    password    varchar(64) not null comment "登陆的密码",
    is_headdepart   tinyint not null default 0 comment "是不是系主任",
    is_inspector    tinyint not null default 0 comment "是不是检查员",
    is_headteacher  tinyint not null default 0 comment "是不是班主任",
    depart      varchar(32) default "信息技术" comment "院系",
    permission_level    tinyint not null default 1 comment "权限等级:1级、2级、3级、4级,4级最高",
    token       varchar(32) comment "token"
) default charset=utf8 comment '人员表';

-- 2.2 创建检查表：检查的班级、检查项目的分类
-- 2.2.1 需要检查的班级 inspect_class
create table if not exists inspect_class(
    id          int         not null primary key auto_increment comment "id",
    cls         varchar(32) not null comment "班级",
    grade       varchar(32) comment "年级",
    depart      varchar(32) default "信息技术" comment "院系",
    user_id     tinyint not null comment "对应的user表中的班主任id"
) default charset=utf8 comment '班级表';

-- 2.2.2 检查项目的分类：教室、宿舍、个人卫生、楼值、纪律
-- 1） 教室 inspectitem_classroom
-- create table if not exists inspectitem_classroom (
--     id              int not null    primary key auto_increment comment "id",
--     blackboard      int comment "黑板的分值",
--     chair           int comment "桌椅的分值",
--     cup             int comment "杯子的摆放分值",
--     ground          int comment "地面的分值",
--     light           int comment "灯的分值",
--     door            int comment  "门窗的分值",
--     waste_basket    int comment  "垃圾桶的分值"
-- ) default charset=utf8 comment '检查项目-教室表';

-- -- 2） 宿舍 inspectitem_dorm
-- create table if not exists inspectitem_dorm (
--     id          int not null    primary key auto_increment comment "id",
--     blackboard  int comment "黑板的分值",
--     bed         int comment "床、被子的分值",
--     door        int comment  "门窗的分值",
--     waste_basket    int comment  "垃圾桶的分值"
-- ) default charset=utf8 comment '检查项目-宿舍表';

-- -- 3） 个人卫生 inspectitem_personal
-- create table if not exists inspectitem_personal (
--     id          int not null    primary key auto_increment comment "id",
--     hair        int comment  "头发的分值",
--     clothes     int comment  "服装的分值",
--     jewelry     int comment  "饰品的分值"
-- ) default charset=utf8 comment '检查项目-个人卫生表';

-- -- 4） 楼值 inspectitem_floor
-- create table if not exists inspectitem_floor (
--     id          int not null    primary key auto_increment comment "id",
--     toilet      int comment  "卫生间的分值",
--     corridor    int comment  "楼道的分值"
-- ) default charset=utf8 comment '检查项目-楼值表';

-- -- 5） 纪律 inspectitem_discipline
-- create table if not exists inspectitem_discipline (
--     id      int not null    primary key auto_increment comment "id",
--     talk    int comment  "上课讲话的分值",
--     sleep   int comment  "上课睡觉的分值",
--     phone   int comment  "上课玩手机的分值"
-- ) default charset=utf8 comment '检查项目-纪律表';

-- 2.2.3 检查结果表 inspect_result
create table if not exists inspect_result(
    id          int             not null primary key auto_increment comment "id",
    cls         varchar(32)     not null comment "班级",
    classroom   varchar(512)    default '{"分数":100}' comment "教室",
    dormitory   varchar(512)    default '{"分数":100}' comment "宿舍",
    personal    varchar(512)    default '{"分数":100}' comment "个人卫生",
    floor       varchar(512)    default '{"分数":100}' comment "楼值",
    discipline  varchar(512)    default '{"分数":100}' comment "纪律",
    user_id     tinyint not null comment "对应user表中的班主任id",
    inspect_time       datetime    default now() comment "检查时间"
) default charset=utf8 comment '检查结果表';

------------------------------------------------------------------------------------

-- 3 插入数据
-- 3.1 班级表
insert into inspect_class(`cls`,`grade`,`user_id`)
values 
("1班","2020级",1),
("2班","2020级",2),
("1班","2021级",3);

-- 3.2 人员表
insert into user(`id`,`name`,`username`,`password`,`is_headdepart`,`is_inspector`,`is_headteacher`,`permission_level`)
values
("1","邢予","邢予","xingyu321",0,1,1,2),
("2","吴洁","吴洁","wujie321",0,1,1,2),
("3","王钰坤","王钰坤","wangyukun321",0,0,1,1),
("4","陕娟娟","陕娟娟","shanjuanjuan321",0,1,0,3),
("5","王璐","王璐","wanglu321",1,1,0,3),
("6","赵东","赵东","zhaodong321",1,0,0,3),
("7","方荣卫","方荣卫","fangrongwei321",1,0,0,3);
