package com.wiiy.pb.system;

public class InitSql {
	public static String[] sqls = new String[]{
		"INSERT INTO `crm_data_property` VALUES ('1', null, ',', '0', '0', '1', '企业经营状况', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 11:19:05', '超级管理员', '1', '2012-12-17 11:19:05', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('3', null, ',', '0', '0', '2', '企业人才引进情况', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 11:20:32', '超级管理员', '1', '2012-12-17 11:20:32', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('4', null, ',', '0', '0', '3', '知识产权情况', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 11:20:43', '超级管理员', '1', '2012-12-17 11:20:43', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('5', '1', ',1,', '0', '1', '1', '营业收入', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 11:21:06', '超级管理员', '1', '2012-12-17 11:21:06', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('6', '5', ',1,5,', '1', '2', '1', '本期数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:21:26', '超级管理员', '1', '2012-12-17 11:21:26', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('7', '5', ',1,5,', '1', '2', '2', '本年累计数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:21:45', '超级管理员', '1', '2012-12-17 11:21:45', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('8', '5', ',1,5,', '0', '2', '3', '软件收入', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 11:22:20', '超级管理员', '1', '2012-12-18 14:33:06', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('9', '8', ',1,5,8,', '1', '3', '1', '本期数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:22:38', '超级管理员', '1', '2012-12-17 11:22:38', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('10', '8', ',1,5,8,', '1', '3', '2', '本年累计数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:22:55', '超级管理员', '1', '2012-12-17 11:22:55', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('11', '1', ',1,', '0', '1', '2', '营业利润', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 11:23:19', '超级管理员', '1', '2012-12-17 11:23:19', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('12', '11', ',1,11,', '1', '2', '1', '本期数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:23:39', '超级管理员', '1', '2012-12-17 11:23:39', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('13', '11', ',1,11,', '1', '2', '2', '本年累计数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:23:54', '超级管理员', '1', '2012-12-17 11:23:54', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('14', '1', ',1,', '0', '1', '3', '利润总额', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 11:24:10', '超级管理员', '1', '2012-12-17 11:24:10', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('15', '14', ',1,14,', '1', '2', '1', '本期数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:24:22', '超级管理员', '1', '2012-12-17 11:24:22', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('16', '14', ',1,14,', '1', '2', '2', '本年累计数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:24:56', '超级管理员', '1', '2012-12-17 11:24:56', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('17', '1', ',1,', '0', '1', '4', '税金合计', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 11:25:08', '超级管理员', '1', '2012-12-17 11:25:08', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('18', '17', ',1,17,', '1', '2', '1', '本期数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:25:35', '超级管理员', '1', '2012-12-17 11:25:35', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('19', '17', ',1,17,', '1', '2', '2', '本年累计数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:25:53', '超级管理员', '1', '2012-12-17 11:25:53', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('20', '17', ',1,17,', '0', '2', '3', '营业税', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 11:26:10', '超级管理员', '1', '2012-12-18 14:33:22', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('21', '20', ',1,17,20,', '1', '3', '1', '本期数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:26:26', '超级管理员', '1', '2012-12-17 11:26:26', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('22', '20', ',1,17,20,', '1', '3', '2', '本年累计数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:26:54', '超级管理员', '1', '2012-12-17 11:26:54', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('23', '17', ',1,17,', '0', '2', '4', '增值税', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 11:27:30', '超级管理员', '1', '2012-12-17 11:27:30', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('24', '23', ',1,17,23,', '1', '3', '1', '本期数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:27:50', '超级管理员', '1', '2012-12-17 11:27:50', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('25', '23', ',1,17,23,', '1', '3', '2', '本年累计数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:28:07', '超级管理员', '1', '2012-12-17 11:28:07', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('26', '17', ',1,17,', '0', '2', '5', '所得税', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 11:28:23', '超级管理员', '1', '2012-12-17 11:28:23', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('27', '26', ',1,17,26,', '1', '3', '1', '本期数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:28:39', '超级管理员', '1', '2012-12-17 11:28:39', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('28', '26', ',1,17,26,', '1', '3', '2', '本年累计数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:28:59', '超级管理员', '1', '2012-12-17 11:28:59', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('29', '1', ',1,', '0', '1', '5', '从业人员工资总额', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 11:29:20', '超级管理员', '1', '2012-12-17 11:29:20', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('30', '29', ',1,29,', '1', '2', '1', '本期数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:29:34', '超级管理员', '1', '2012-12-17 11:29:34', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('31', '29', ',1,29,', '1', '2', '2', '本年累计数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:29:56', '超级管理员', '1', '2012-12-17 11:29:56', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('32', '1', ',1,', '0', '1', '6', '科技支出', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 11:30:17', '超级管理员', '1', '2012-12-17 11:30:17', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('33', '32', ',1,32,', '1', '2', '1', '本期数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:30:32', '超级管理员', '1', '2012-12-17 11:30:32', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('34', '32', ',1,32,', '1', '2', '2', '本年累计数', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:30:50', '超级管理员', '1', '2012-12-17 11:30:50', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('35', '1', ',1,', '1', '1', '7', '资产合计', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:52:34', '超级管理员', '1', '2012-12-17 11:52:34', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('36', '1', ',1,', '1', '1', '8', '负债合计', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:52:48', '超级管理员', '1', '2012-12-17 11:52:48', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('37', '1', ',1,', '1', '1', '9', '所有者权益', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-17 11:53:16', '超级管理员', '1', '2012-12-17 11:53:16', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('38', '3', ',3,', '0', '1', '1', '企业总人数', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-17 11:53:51', '超级管理员', '1', '2012-12-17 11:53:51', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('39', '38', ',3,38,', '1', '2', '1', '本月新增就业人员', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-17 11:54:19', '超级管理员', '1', '2012-12-17 11:54:19', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('40', '38', ',3,38,', '1', '2', '2', '博士', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-17 11:55:00', '超级管理员', '1', '2012-12-18 14:33:41', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('41', '38', ',3,38,', '1', '2', '3', '硕士', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-17 11:55:18', '超级管理员', '1', '2012-12-17 11:55:18', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('42', '38', ',3,38,', '1', '2', '4', '本科', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-17 11:56:22', '超级管理员', '1', '2012-12-17 11:56:22', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('43', '38', ',3,38,', '1', '2', '5', '大专', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-17 11:56:39', '超级管理员', '1', '2012-12-17 11:56:39', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('44', '38', ',3,38,', '1', '2', '6', '高级职称', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-17 11:59:11', '超级管理员', '1', '2012-12-18 14:34:07', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('45', '38', ',3,38,', '1', '2', '7', '中级职称', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-17 11:59:28', '超级管理员', '1', '2012-12-17 11:59:28', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('46', '38', ',3,38,', '1', '2', '8', '初级职称', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-17 11:59:43', '超级管理员', '1', '2012-12-17 11:59:43', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('47', '38', ',3,38,', '1', '2', '9', '留学人员', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-17 12:00:04', '超级管理员', '1', '2012-12-18 14:34:15', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('48', '4', ',4,', '0', '1', '1', '企业获得专利总数', 'INT', '', '', '', 'NO', 'NORMAL', '2012-12-17 12:02:48', '超级管理员', '1', '2012-12-17 12:02:48', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('49', '48', ',4,48,', '1', '2', '1', '本月新增发明专利', 'INT', '', '', '', 'NO', 'NORMAL', '2012-12-17 12:03:12', '超级管理员', '1', '2012-12-18 14:34:22', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('50', '48', ',4,48,', '1', '2', '2', '本月新增实用新型专利', 'INT', '', '', '', 'NO', 'NORMAL', '2012-12-17 12:03:36', '超级管理员', '1', '2012-12-17 12:03:36', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('51', '48', ',4,48,', '1', '2', '3', '本月新增外观专利', 'INT', '', '', '', 'NO', 'NORMAL', '2012-12-17 12:03:55', '超级管理员', '1', '2012-12-17 12:06:31', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('52', '4', ',4,', '0', '1', '2', '企业获得软件著作权总数', 'INT', '', '', '', 'NO', 'NORMAL', '2012-12-17 12:04:22', '超级管理员', '1', '2012-12-17 12:04:22', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('53', '52', ',4,52,', '1', '2', '1', '本月新增著作权', 'INT', '', '', '', 'NO', 'NORMAL', '2012-12-17 12:04:44', '超级管理员', '1', '2012-12-18 14:34:31', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('54', null, ',', '0', '0', '4', '企业基本情况', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 15:42:42', '超级管理员', '1', '2012-12-17 15:42:42', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('55', null, ',', '0', '0', '5', '企业经济概况', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 15:42:59', '超级管理员', '1', '2012-12-17 15:42:59', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('56', null, ',', '0', '0', '6', '企业从业人员情况', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 15:43:13', '超级管理员', '1', '2012-12-17 15:43:13', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('57', null, ',', '0', '0', '7', '企业知识产权情况', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 15:43:28', '超级管理员', '1', '2012-12-17 15:43:28', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('58', null, ',', '0', '0', '8', '国家科技项目情况', null, '', '', '', 'NO', 'NORMAL', '2012-12-17 15:43:43', '超级管理员', '1', '2012-12-17 15:43:43', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('59', '54', ',54,', '1', '1', '1', '企业成立时间', 'DATETIME', '', '', '', 'NO', 'NORMAL', '2012-12-17 15:44:50', '超级管理员', '1', '2012-12-17 15:44:50', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('60', '54', ',54,', '1', '1', '2', '企业登记注册类型', 'SELECT', '内资-国有企业|内资-集体企业|内资-股份合作企业|内资-私营企业|内资-股份有限公司|内资-有限责任公司|内资-联营企业|港澳台-合资经营企业|港澳台-合作经营企业|港澳台-独资经营企业|港澳台-股份有限公司|外资-中外合资|外资-中外合作|外资-外商独资|外资-股份有限公司', '', '', 'NO', 'NORMAL', '2012-12-18 11:21:19', '超级管理员', '1', '2012-12-18 11:25:15', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('61', '54', ',54,', '1', '1', '3', '行业类别', 'SELECT', '电子信息|先进制造|航空航天|现代交通|生物医药与医疗器械|新材料|新能源与节能|环境保护|地球空间与海洋|核应用技术|现代农业|其他', '', '', 'NO', 'NORMAL', '2012-12-18 11:28:42', '超级管理员', '1', '2012-12-18 11:28:42', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('62', '54', ',54,', '1', '1', '4', '企业所属技术领域', 'SELECT', '电子信息|先进制造|航空航天|现代交通|生物医药与医疗器械|新材料|新能源与节能|环境保护|地球空间与海洋|核应用技术|现代农业|其他', '', '', 'NO', 'NORMAL', '2012-12-18 11:31:00', '超级管理员', '1', '2012-12-18 11:31:00', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('63', '54', ',54,', '1', '1', '5', '获天使或风险投资额', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-18 11:31:40', '超级管理员', '1', '2012-12-18 11:31:40', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('64', '54', ',54,', '1', '1', '6', '占用孵化器场地面积', 'DOUBLE', '', '平方米', '', 'NO', 'NORMAL', '2012-12-18 11:32:06', '超级管理员', '1', '2012-12-18 11:32:06', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('65', '54', ',54,', '1', '1', '7', '企业成立时注册资本', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-18 14:11:17', '超级管理员', '1', '2012-12-18 14:11:17', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('66', '54', ',54,', '1', '1', '8', '高新技术企业', 'SELECT', '是|否', '', '', 'NO', 'NORMAL', '2012-12-18 14:12:14', '超级管理员', '1', '2012-12-18 14:12:14', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('67', '54', ',54,', '1', '1', '9', '毕业企业', 'SELECT', '是|否', '', '', 'NO', 'NORMAL', '2012-12-18 14:12:41', '超级管理员', '1', '2012-12-18 14:12:41', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('68', '54', ',54,', '1', '1', '10', '与创业导师建立辅导关系', 'SELECT', '是|否', '', '', 'NO', 'NORMAL', '2012-12-18 14:13:05', '超级管理员', '1', '2012-12-18 14:13:05', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('69', '54', ',54,', '1', '1', '11', '留学人员企业', 'SELECT', '是|否', '', '', 'NO', 'NORMAL', '2012-12-18 14:13:34', '超级管理员', '1', '2012-12-18 14:13:34', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('70', '54', ',54,', '1', '1', '12', '大学生科技企业', 'SELECT', '是|否', '', '', 'NO', 'NORMAL', '2012-12-18 14:14:14', '超级管理员', '1', '2012-12-18 14:14:14', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('71', '55', ',55,', '1', '1', '1', '在孵企业总收入', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-18 14:15:04', '超级管理员', '1', '2012-12-18 14:15:04', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('72', '55', ',55,', '1', '1', '2', '在孵企业净利润', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-18 14:15:33', '超级管理员', '1', '2012-12-18 14:15:33', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('73', '55', ',55,', '1', '1', '3', '在孵企业出口创汇', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-18 14:17:02', '超级管理员', '1', '2012-12-18 14:17:02', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('74', '55', ',55,', '1', '1', '4', '在孵企业R&D投入', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-18 14:17:30', '超级管理员', '1', '2012-12-18 14:17:30', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('75', '56', ',56,', '1', '1', '5', '在孵企业从业人员数', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-18 14:18:04', '超级管理员', '1', '2012-12-18 14:18:04', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('76', '56', ',56,', '1', '1', '6', '博士', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-18 14:18:24', '超级管理员', '1', '2012-12-18 14:34:49', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('77', '56', ',56,', '1', '1', '7', '大专以上', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-18 14:18:44', '超级管理员', '1', '2012-12-18 14:18:44', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('78', '56', ',56,', '1', '1', '8', '留学人员', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-18 14:19:19', '超级管理员', '1', '2012-12-18 14:19:19', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('79', '56', ',56,', '1', '1', '9', '千人计划人数', 'INT', '', '人', '', 'NO', 'NORMAL', '2012-12-18 14:19:53', '超级管理员', '1', '2012-12-18 14:19:53', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('80', '57', ',57,', '1', '1', '1', '申请知识产权保护数', 'INT', '', '', '', 'NO', 'NORMAL', '2012-12-18 14:21:19', '超级管理员', '1', '2012-12-18 14:21:19', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('81', '57', ',57,', '1', '1', '2', '批准知识产权保护数', 'INT', '', '', '', 'NO', 'NORMAL', '2012-12-18 14:21:39', '超级管理员', '1', '2012-12-18 14:21:39', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('82', '57', ',57,', '1', '1', '3', '发明专利', 'INT', '', '', '', 'NO', 'NORMAL', '2012-12-18 14:21:57', '超级管理员', '1', '2012-12-18 14:34:59', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('83', '57', ',57,', '1', '1', '4', '软件著作权', 'INT', '', '', '', 'NO', 'NORMAL', '2012-12-18 14:22:13', '超级管理员', '1', '2012-12-18 14:22:13', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('84', '57', ',57,', '1', '1', '5', '植物新品种', 'INT', '', '', '', 'NO', 'NORMAL', '2012-12-18 14:23:25', '超级管理员', '1', '2012-12-18 14:23:25', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('85', '57', ',57,', '1', '1', '6', '集成电路布图', 'INT', '', '', '', 'NO', 'NORMAL', '2012-12-18 14:23:55', '超级管理员', '1', '2012-12-18 14:23:55', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('86', '57', ',57,', '1', '1', '7', '购买国外专利', 'INT', '', '', '', 'NO', 'NORMAL', '2012-12-18 14:24:13', '超级管理员', '1', '2012-12-18 14:24:13', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('87', '58', ',58,', '1', '1', '1', '获得国家创新基金资助额', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-18 14:24:48', '超级管理员', '1', '2012-12-18 14:25:04', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('88', '58', ',58,', '1', '1', '2', '获得省创新基金资助额', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-18 14:25:39', '超级管理员', '1', '2012-12-18 14:25:39', '超级管理员', '1');",
		"INSERT INTO `crm_data_property` VALUES ('89', '58', ',58,', '1', '1', '3', '获得市创新基金资助额', 'DOUBLE', '', '万元', '', 'NO', 'NORMAL', '2012-12-18 14:26:10', '超级管理员', '1', '2012-12-18 14:26:10', '超级管理员', '1');",
		"drop view customer_change_view;",
		"CREATE VIEW `customer_change_view` AS (select '企业' AS `type`,`crm_customer`.`name` AS `title`,`crm_customer`.`id` AS `customer_id`,`crm_customer`.`name` AS `customer_name`,`crm_customer`.`modify_time` AS `modify_time` from `crm_customer`) union (select '产品' AS `type`,`crm_product`.`name` AS `title`,`crm_product`.`customer_id` AS `customer_id`,`crm_customer`.`name` AS `customer_name`,`crm_product`.`modify_time` AS `modify_time` from (`crm_product` left join `crm_customer` on((`crm_product`.`customer_id` = `crm_customer`.`id`)))) union (select '项目' AS `type`,`crm_project_apply`.`name` AS `title`,`crm_project_apply`.`customer_id` AS `customer_id`,`crm_customer`.`name` AS `customer_name`,`crm_project_apply`.`modify_time` AS `modify_time` from (`crm_project_apply` left join `crm_customer` on((`crm_project_apply`.`customer_id` = `crm_customer`.`id`)))) union (select '员工' AS `type`,`crm_staffer`.`name` AS `title`,`crm_staffer`.`customer_id` AS `customer_id`,`crm_customer`.`name` AS `customer_name`,`crm_staffer`.`modify_time` AS `modify_time` from (`crm_staffer` left join `crm_customer` on((`crm_staffer`.`customer_id` = `crm_customer`.`id`)))) union (select '专利' AS `type`,`crm_patent`.`name` AS `title`,`crm_patent`.`customer_id` AS `customer_id`,`crm_customer`.`name` AS `customer_name`,`crm_patent`.`modify_time` AS `modify_time` from (`crm_patent` left join `crm_customer` on((`crm_patent`.`customer_id` = `crm_customer`.`id`)))) ;",
		/*"INSERT INTO crm_bill_type VALUES ('1', null, '物业', 'NORMAL', '2013-06-05 09:39:16', '超级管理员', '1', '2013-06-05 09:39:16', '超级管理员', '1');",
		"INSERT INTO crm_bill_type VALUES ('2', '1', '租金', 'NORMAL', '2013-06-05 09:39:16', '超级管理员', '1', '2013-06-05 09:39:16', '超级管理员', '1');",
		"INSERT INTO crm_bill_type VALUES ('3', '1', '物管费', 'NORMAL', '2013-06-05 09:39:16', '超级管理员', '1', '2013-06-05 09:39:16', '超级管理员', '1');",
		"INSERT INTO crm_bill_type VALUES ('4', '1', '能源损耗费', 'NORMAL', '2013-06-05 09:39:16', '超级管理员', '1', '2013-06-05 09:39:16', '超级管理员', '1');",
		"INSERT INTO crm_bill_type VALUES ('5', '1', '场地租金', 'NORMAL', '2013-06-09 09:56:06', '超级管理员', '1', '2013-06-09 09:56:06', '超级管理员', '1');",
		"INSERT INTO crm_bill_type VALUES ('6', '1', '水电费押金', 'NORMAL', '2013-06-09 14:02:00', '超级管理员', '1', '2013-06-09 14:02:00', '超级管理员', '1');",
		"INSERT INTO crm_bill_type VALUES ('7', '1', '房租押金', 'NORMAL', '2013-06-09 14:02:01', '超级管理员', '1', '2013-06-09 14:02:01', '超级管理员', '1');",*/
		"drop view contacttotal;",
		"CREATE VIEW `contacttotal` AS(select `crm_investment_contact`.`id` AS `id`,`crm_investment_contact`.`type` AS `type`,`crm_investment_contact`.`creator` AS `creator`,`crm_investment_contact`.`modify_time` AS `modify_time`,`crm_investment_contact`.`status` AS `status`,`crm_investment_contact`.`create_time` AS `create_time`,`crm_investment_contact`.`creator_id` AS `creator_id`,`crm_investment_contact`.`used_ids` AS `used_ids`,`crm_investment_contact`.`receive_id` AS `receive_id` from `crm_investment_contact` union select `pb_rent_out_contact`.`id` AS `id`,`pb_rent_out_contact`.`type` AS `type`,`pb_rent_out_contact`.`creator` AS `creator`,`pb_rent_out_contact`.`modify_time` AS `modify_time`,`pb_rent_out_contact`.`status` AS `status`,`pb_rent_out_contact`.`create_time` AS `create_time`,`pb_rent_out_contact`.`creator_id` AS `creator_id`,`pb_rent_out_contact`.`used_ids` AS `used_ids`,`pb_rent_out_contact`.`receive_id` AS `receive_id` from `pb_rent_out_contact` union select `crm_business_center_contact`.`id` AS `id`,`crm_business_center_contact`.`type` AS `type`,`crm_business_center_contact`.`creator` AS `creator`,`crm_business_center_contact`.`modify_time` AS `modify_time`,`crm_business_center_contact`.`status` AS `status`,`crm_business_center_contact`.`create_time` AS `create_time`,`crm_business_center_contact`.`creator_id` AS `creator_id`,`crm_business_center_contact`.`used_ids` AS `used_ids`,`crm_business_center_contact`.`receive_id` AS `receive_id` from `crm_business_center_contact` union select `pb_tenement_center_contact`.`id` AS `id`,`pb_tenement_center_contact`.`type` AS `type`,`pb_tenement_center_contact`.`creator` AS `creator`,`pb_tenement_center_contact`.`modify_time` AS `modify_time`,`pb_tenement_center_contact`.`status` AS `status`,`pb_tenement_center_contact`.`create_time` AS `create_time`,`pb_tenement_center_contact`.`creator_id` AS `creator_id`,`pb_tenement_center_contact`.`used_ids` AS `used_ids`,`pb_tenement_center_contact`.`receive_id` AS `receive_id` from `pb_tenement_center_contact` union select `pb_finance_contact`.`id` AS `id`,`pb_finance_contact`.`type` AS `type`,`pb_finance_contact`.`creator` AS `creator`,`pb_finance_contact`.`modify_time` AS `modify_time`,`pb_finance_contact`.`status` AS `status`,`pb_finance_contact`.`create_time` AS `create_time`,`pb_finance_contact`.`creator_id` AS `creator_id`,`pb_finance_contact`.`used_ids` AS `used_ids`,`pb_finance_contact`.`receive_id` AS `receive_id` from `pb_finance_contact` union select `pb_carport_out_contact`.`id` AS `id`,`pb_carport_out_contact`.`type` AS `type`,`pb_carport_out_contact`.`creator` AS `creator`,`pb_carport_out_contact`.`modify_time` AS `modify_time`,`pb_carport_out_contact`.`status` AS `status`,`pb_carport_out_contact`.`create_time` AS `create_time`,`pb_carport_out_contact`.`creator_id` AS `creator_id`,`pb_carport_out_contact`.`used_ids` AS `used_ids`,`pb_carport_out_contact`.`receive_id` AS `receive_id` from `pb_carport_out_contact`);",
	};
	
	public static void main(String[] args) {
		String split = " ";
		for (String sql : sqls) {
			if(sql.startsWith("INSERT INTO `crm_data_property`")) {
				int index = "INSERT INTO `crm_data_property` VALUES (".length();
				for (int j = 0; j < 5; j++) {
					index = sql.indexOf(split, index+1);
				}
				int orderIndexS = sql.lastIndexOf(split);
				int orderIndexE = sql.lastIndexOf(")");
				String order = sql.substring(orderIndexS,orderIndexE);
//				System.out.println(sql);
				String sql2 = sql.substring(0, index) + order + "," + sql.substring(index, orderIndexS-1) + sql.substring(orderIndexE);
				System.out.println("\""+sql2+"\",");
			}
		}
	}
}
