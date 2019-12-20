SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- 辅导员
-- ----------------------------
DROP TABLE IF EXISTS `s_admin`;
CREATE TABLE `s_admin` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `s_admin` VALUES ('1', 'admin', 'admin', '1');

-- ----------------------------
-- 学生
-- ----------------------------
DROP TABLE IF EXISTS `s_student`;
CREATE TABLE `s_student` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `sn` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `clazz_id` int(5) NOT NULL,
  `sex` varchar(5) NOT NULL DEFAULT '男',
  `mobile` varchar(12) DEFAULT NULL,
  `qq` varchar(18) DEFAULT NULL,
  `photo` mediumblob,
  PRIMARY KEY (`id`,`sn`),
  KEY `student_clazz_id_foreign` (`clazz_id`),
  KEY `id` (`id`),
  CONSTRAINT `student_clazz_id_foreign` FOREIGN KEY (`clazz_id`) REFERENCES `s_clazz` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- 教师
-- ----------------------------
DROP TABLE IF EXISTS `s_teacher`;
CREATE TABLE `s_teacher` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `sn` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `clazz_id` int(5) NOT NULL,
  `sex` varchar(5) NOT NULL DEFAULT '男',
  `mobile` varchar(12) DEFAULT NULL,
  `qq` varchar(18) DEFAULT NULL,
  `photo` mediumblob,
  PRIMARY KEY (`id`,`sn`),
  KEY `student_clazz_id_foreign` (`clazz_id`),
  KEY `id` (`id`),
  CONSTRAINT `s_teacher_ibfk_1` FOREIGN KEY (`clazz_id`) REFERENCES `s_clazz` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- 班级信息表
-- ----------------------------
DROP TABLE IF EXISTS `s_clazz`;
CREATE TABLE `s_clazz` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `info` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- 课程信息表
-- ----------------------------
DROP TABLE IF EXISTS `s_course`;
CREATE TABLE `s_course` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `teacher_id` int(5) NOT NULL,
  `course_date` varchar(32) DEFAULT NULL,
  `selected_num` int(5) NOT NULL DEFAULT '0',
  `max_num` int(5) NOT NULL DEFAULT '50',
  `info` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_teacher_foreign` (`teacher_id`),
  CONSTRAINT `course_teacher_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `s_teacher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- 签到信息表
-- ----------------------------
DROP TABLE IF EXISTS `s_attendance`;
CREATE TABLE `s_attendance` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `course_id` int(5) NOT NULL,
  `student_id` int(5) NOT NULL,
  `type` varchar(11) NOT NULL,
  `date` varchar(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `attendance_course_foreign_key` (`course_id`),
  KEY `attendace_student_foreign_key` (`student_id`),
  CONSTRAINT `attendace_student_foreign_key` FOREIGN KEY (`student_id`) REFERENCES `s_student` (`id`),
  CONSTRAINT `attendance_course_foreign_key` FOREIGN KEY (`course_id`) REFERENCES `s_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- 请假信息表
-- ----------------------------
DROP TABLE IF EXISTS `s_leave`;
CREATE TABLE `s_leave` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `student_id` int(5) NOT NULL,
  `info` varchar(512) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `remark` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `leave_student_foreign_key` (`student_id`),
  CONSTRAINT `leave_student_foreign_key` FOREIGN KEY (`student_id`) REFERENCES `s_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- 选课信息表
-- ----------------------------
DROP TABLE IF EXISTS `s_selected_course`;
CREATE TABLE `s_selected_course` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `student_id` int(5) NOT NULL,
  `course_id` int(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `selected_course_student_fk` (`student_id`),
  KEY `selected_course_course_fk` (`course_id`),
  CONSTRAINT `selected_course_course_fk` FOREIGN KEY (`course_id`) REFERENCES `s_course` (`id`),
  CONSTRAINT `selected_course_student_fk` FOREIGN KEY (`student_id`) REFERENCES `s_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- 学生成绩表
-- ----------------------------
DROP TABLE IF EXISTS `s_score`;
CREATE TABLE `s_score` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `student_id` int(5) NOT NULL,
  `course_id` int(5) NOT NULL,
  `score` double(5,2) NOT NULL,
  `remark` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `selected_course_student_fk` (`student_id`),
  KEY `selected_course_course_fk` (`course_id`),
  CONSTRAINT `s_score_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `s_course` (`id`),
  CONSTRAINT `s_score_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `s_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;
