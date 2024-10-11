drop database demo;
create database demo;
use demo;

create table jame_account(
	user_name varchar(50) primary key,
    password varchar(50)
);

create table class(
	class_id int primary key auto_increment,
    class_name varchar(50)
);

create table student(
	student_id int primary key auto_increment,
    student_name varchar(50),
    student_birthday date,
    student_gender bit,
    student_email varchar(50),
    student_point double,
    user_name varchar(50),
    class_id int,
    foreign key(user_name) references jame_account(user_name),
    foreign key(class_id) references class(class_id)
);

create table instructor(
	instructor_id int primary key auto_increment,
	instructor_name varchar(50),
    instructor_birthday date,
	instructor_salary double
);

create table instructor_class(
	class_id int,
    instructor_id int,
    primary key(class_id,instructor_id),
    foreign key(class_id) references class(class_id),
    foreign key(instructor_id) references instructor(instructor_id)
);

insert into class (class_name) values ('c1121g1'), ('c1221g1'),('a0821i1'),('a0921i1');

insert into jame_account(user_name,password)
 values('cunn','12345'),('chunglh','12345'),('hoanhh','12345'),('dungd','12345'),('huynhtd','12345'),
 ('hainm','12345'),('namtv','12345'),('hieuvm','12345'),('kynx','12345'),('vulm','12345'),('anv','12345'),('bnv','12345');


insert into instructor(instructor_name,instructor_birthday, instructor_salary)
 values('tran van chanh','1985-02-03',100),('dang chi trung','1985-02-03',200),('nguyen vu thanh tien','1985-02-03',300);

 
 insert into student(student_name,student_birthday, student_gender,student_point, class_id,user_name) 
 values ('nguyen ngoc cu','1981-12-12',1,8,1,'cunn'),('le hai chung','1981-12-12',1,5,1,'chunglh'),
 ('hoang huu hoan','1990-12-12',1,6,2,'hoanhh'),('dau dung','1987-12-12',1,8,1,'dungd'),
 ('ta dinh huynh','1981-12-12',1,7,2,'huynhtd'),('nguyen minh hai','1987-12-12',1,9,1,'hainm'),
 ('tran van nam','1989-12-12',1,4,2,'namtv'),('vo minh hieu','1981-12-12',1,3,1,'hieuvm'),
 ('le xuan ky','1981-12-12',1,7,2,'kynx'),('le minh vu','1981-12-12',1,7,1,'vulm'),
 ('nguyen van a','1981-12-12',1,8,null,'anv'),('tran van b','1981-12-12',1,5,null,'bnv');

 insert into instructor_class(class_id,instructor_id) values (1,1),(1,2),(2,1),(2,2),(3,1),(3,2);
 
-- 1. Lấy ra thông tin tất cả học viên có lớp học và tên lớp mà các học viên đó đang theo học. 
-- SELECT 
--     *
-- FROM
--     student
-- 		JOIN
--     class ON student.class_id = class.class_id;
    
 -- 2. Lấy ra thông tin tất cả học viên (bao gồm có và chưa có lớp) và tên lớp (nếu có) mà các học viên đó đang theo học.   
SELECT 
    *
FROM
    student
LEFT JOIN class ON student.class_id = class.class_id ;
    
-- 3. Lấy thông tin của các học viên tên “Hai” và 'Huynh’.
-- SELECT 
--     *
-- FROM	
--     student
-- WHERE
--     student_name LIKE "% hai" OR student_name LIKE "% huynh";
    
-- 4. Lấy ra thông tin học viên có điểm lớn hơn 5    
-- SELECT 
--     *
-- FROM
--     student
-- WHERE
--     student_point > 5;
--     
-- -- 5. Lấy ra thông tin học viên có họ là “nguyen”    
-- SELECT 
--     *
-- FROM
--     student
-- WHERE
--     student_name LIKE 'nguyen %';

-- 6. Thông kế số lượng học sinh theo từng loại điểm.    
-- SELECT 
--     COUNT(*), 
--     student_point
-- FROM
--     student
-- GROUP BY student_point;

-- -- 7. Thông kế số lượng học sinh theo điểm và điểm phải lớn hơn 5
-- SELECT 
--     COUNT(*) AS "so luong", student_point
-- FROM
--     student
-- WHERE
--     student_point > 5
-- GROUP BY student_point;

-- 8. Thông kế số lượng học sinh theo điểm lớn hơn 5 và chỉ hiện thị với số lượng >= 2    
-- SELECT 
--     COUNT(*), student_point
-- FROM
--     student
-- WHERE
--     student_point > 5
-- GROUP BY student_point
-- HAVING COUNT(*) >= 2;  

-- 9. Lấy ra danh sách học viên của lớp c1121g1 và sắp xếp tên học viên theo alphabet.

-- SELECT 
--     student.student_name,class.class_name
-- FROM
--     student
--         JOIN
--     class ON class.class_id = student.class_id
-- WHERE class.class_name = "c1121g1"
-- ORDER BY substring_index(student.student_name," ", -1);



-- 1. Hiện thị danh sách các lớp có học viên theo học và số lượng học viên của mỗi lớp.

SELECT 
    c.class_name, COUNT(*) AS students
FROM
    student s
        JOIN
    class c ON s.class_id = c.class_id
GROUP BY c.class_name;
    
-- 2. Tìm điểm lớn nhất của từng lớp.

SELECT 
    c.class_name, MAX(s.student_point) AS max_point
FROM
    student s
        JOIN
    class c ON s.class_id = c.class_id
GROUP BY c.class_name;

-- 3. Tìm điểm trung bình của từng lớp.

SELECT 
    c.class_name, AVG(s.student_point) AS avg_point
FROM
    student s
        JOIN
    class c ON s.class_id = c.class_id
GROUP BY c.class_name;

-- 4. Lấy ra toàn bộ tên và ngày sinh các instructor và student ở CodeGym (sử dụng UNION).

SELECT 
    s.student_name AS name_in_codegym,
    s.student_birthday AS birthday_in_codegym
FROM
    student s 
UNION SELECT 
    i.instructor_name, i.instructor_birthday
FROM
    instructor i;
    
-- 5. Lấy ra top 3 học viên có điểm cao nhất của trung tâm.

SELECT 
    s.student_name, s.student_point
FROM
    student s
ORDER BY s.student_point DESC
LIMIT 3;

-- 6. Lấy ra các học viên có điểm số là cao nhất của trung tâm.

SELECT 
    s.student_name, s.student_point
FROM
    student s
WHERE
    s.student_point IN (SELECT 
            MAX(s.student_point)
        FROM
            student s)



    

