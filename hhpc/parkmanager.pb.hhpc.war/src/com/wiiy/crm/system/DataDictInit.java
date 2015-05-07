package com.wiiy.crm.system;

import java.util.ArrayList;
import java.util.List;

import com.wiiy.core.entity.DataDict;

public class DataDictInit {
	private List<DataDict> list=new ArrayList<DataDict>();
	public boolean init(){
		boolean r=true;
		
		this.newData("crm.0002", null, "客户关系管理", "TECHNIC_TYPE", "技术领域", 1, 1,2);
		this.newData("crm.000201", "crm.0002", "客户关系管理", "TECHNIC_TYPE", "电子信息", 1, 1,1);
		this.newData("crm.000202", "crm.0002", "客户关系管理", "TECHNIC_TYPE", "先进制造", 1, 1,2);
		this.newData("crm.000203", "crm.0002", "客户关系管理", "TECHNIC_TYPE", "航空航天", 1, 1,3);
		this.newData("crm.000204", "crm.0002", "客户关系管理", "TECHNIC_TYPE", "现代交通", 1, 1,4);
		this.newData("crm.000205", "crm.0002", "客户关系管理", "TECHNIC_TYPE", "生物医药与医疗器械", 1, 1,5);
		this.newData("crm.000206", "crm.0002", "客户关系管理", "TECHNIC_TYPE", "新材料", 1, 1,6);
		this.newData("crm.000207", "crm.0002", "客户关系管理", "TECHNIC_TYPE", "新能源与节能", 1, 1,7);
		this.newData("crm.000208", "crm.0002", "客户关系管理", "TECHNIC_TYPE", "环境保护", 1, 1,8);
		this.newData("crm.000209", "crm.0002", "客户关系管理", "TECHNIC_TYPE", "地球空间与海洋", 1, 1,9);
		this.newData("crm.000210", "crm.0002", "客户关系管理", "TECHNIC_TYPE", "核应用技术", 1, 1,10);
		this.newData("crm.000211", "crm.0002", "客户关系管理", "TECHNIC_TYPE", "现代农业", 1, 1,11);
		this.newData("crm.000299", "crm.0002", "客户关系管理", "TECHNIC_TYPE", "其他", 1, 1,99);
		
		this.newData("crm.0003", null, "客户关系管理", "CUSTOMER_SOURCE", "客户来源", 1, 1,3);
		this.newData("crm.000301", "crm.0003", "客户关系管理", "CUSTOMER_SOURCE", "电话", 1, 1,1);
		this.newData("crm.000302", "crm.0003", "客户关系管理", "CUSTOMER_SOURCE", "网络", 1, 1,2);
		this.newData("crm.000303", "crm.0003", "客户关系管理", "CUSTOMER_SOURCE", "客户或朋友介绍", 1, 1,3);
		this.newData("crm.000399", "crm.0003", "客户关系管理", "CUSTOMER_SOURCE", "其他", 1, 1,99);
		
		this.newData("crm.0004", null, "客户关系管理", "REGISTER_TYPE", "注册类型", 1, 1,4);
		this.newData("crm.000401", "crm.0004", "客户关系管理", "REGISTER_TYPE", "内资-国有企业", 1, 1,1);
		this.newData("crm.000402", "crm.0004", "客户关系管理", "REGISTER_TYPE", "内资-集体企业", 1, 1,2);
		this.newData("crm.000403", "crm.0004", "客户关系管理", "REGISTER_TYPE", "内资-股份合作企业", 1, 1,3);
		this.newData("crm.000404", "crm.0004", "客户关系管理", "REGISTER_TYPE", "内资-私营企业", 1, 1,4);
		this.newData("crm.000405", "crm.0004", "客户关系管理", "REGISTER_TYPE", "内资-股份有限公司", 1, 1,5);
		this.newData("crm.000406", "crm.0004", "客户关系管理", "REGISTER_TYPE", "内资-有限责任公司", 1, 1,6);
		this.newData("crm.000407", "crm.0004", "客户关系管理", "REGISTER_TYPE", "内资-联营企业", 1, 1,7);
		this.newData("crm.000408", "crm.0004", "客户关系管理", "REGISTER_TYPE", "港澳台-合资经营企业", 1, 1,8);
		this.newData("crm.000409", "crm.0004", "客户关系管理", "REGISTER_TYPE", "港澳台-合作经营企业", 1, 1,9);
		this.newData("crm.000410", "crm.0004", "客户关系管理", "REGISTER_TYPE", "港澳台-独资经营企业", 1, 1,10);
		this.newData("crm.000411", "crm.0004", "客户关系管理", "REGISTER_TYPE", "港澳台-股份有限公司", 1, 1,11);
		this.newData("crm.000412", "crm.0004", "客户关系管理", "REGISTER_TYPE", "外资-中外合资", 1, 1,12);
		this.newData("crm.000413", "crm.0004", "客户关系管理", "REGISTER_TYPE", "外资-中外合作", 1, 1,13);
		this.newData("crm.000414", "crm.0004", "客户关系管理", "REGISTER_TYPE", "外资-外商独资", 1, 1,14);
		this.newData("crm.000415", "crm.0004", "客户关系管理", "REGISTER_TYPE", "外资-股份有限公司", 1, 1,15);
		
		this.newData("crm.0005", null, "客户关系管理", "CURRENCY_TYPE", "币种", 1, 1,5);
		this.newData("crm.000501", "crm.0005", "客户关系管理", "CURRENCY_TYPE", "人民币", 1, 1,1);
		this.newData("crm.000502", "crm.0005", "客户关系管理", "CURRENCY_TYPE", "港元", 1, 1,2);
		this.newData("crm.000503", "crm.0005", "客户关系管理", "CURRENCY_TYPE", "台币", 1, 1,3);
		this.newData("crm.000504", "crm.0005", "客户关系管理", "CURRENCY_TYPE", "美元", 1, 1,4);
		this.newData("crm.000505", "crm.0005", "客户关系管理", "CURRENCY_TYPE", "欧元", 1, 1,5);
		
		this.newData("crm.0006", null, "客户关系管理", "DOCUMENT_TYPE", "证件类型", 1, 1,6);
		this.newData("crm.000601", "crm.0006", "客户关系管理", "DOCUMENT_TYPE", "身份证", 1, 1,1);
		this.newData("crm.000602", "crm.0006", "客户关系管理", "DOCUMENT_TYPE", "护照", 1, 1,2);

		this.newData("crm.0007", null, "客户关系管理", "APPLY_TYPE", "申报类型", 1, 1,7);
		this.newData("crm.000701", "crm.0007", "客户关系管理", "APPLY_TYPE", "国家-自然科学基金", 1, 1,1);
		this.newData("crm.000702", "crm.0007", "客户关系管理", "APPLY_TYPE", "国家-863计划", 1, 1,2);
		this.newData("crm.000703", "crm.0007", "客户关系管理", "APPLY_TYPE", "国家-973计划", 1, 1,3);
		this.newData("crm.000704", "crm.0007", "客户关系管理", "APPLY_TYPE", "国家-科技新中小企业创新基金", 1, 1,4);
		this.newData("crm.000705", "crm.0007", "客户关系管理", "APPLY_TYPE", "国家-火炬计划", 1, 1,5);
		this.newData("crm.000706", "crm.0007", "客户关系管理", "APPLY_TYPE", "省市-省市级创新基金", 1, 1,6);
		this.newData("crm.000707", "crm.0007", "客户关系管理", "APPLY_TYPE", "省市-市级创新专项资金", 1, 1,7);
		
		this.newData("crm.0008", null, "客户关系管理", "APPLY_STATUS", "申报状态", 1, 1,8);
		this.newData("crm.000801", "crm.0008", "客户关系管理", "APPLY_STATUS", "申请", 1, 1,1);
		this.newData("crm.000802", "crm.0008", "客户关系管理", "APPLY_STATUS", "成功", 1, 1,2);
		this.newData("crm.000803", "crm.0008", "客户关系管理", "APPLY_STATUS", "失败", 1, 1,3);
		
		this.newData("crm.0009", null, "客户关系管理", "COPYRIGHT_TYPE", "著作权类型", 1, 1,9);
		this.newData("crm.000901", "crm.0009", "客户关系管理", "COPYRIGHT_TYPE", "软件著作权", 1, 1,1);
		
		this.newData("crm.0010", null, "客户关系管理", "PATENT_TYPE", "专利类型", 1, 1,10);
		this.newData("crm.001001", "crm.0010", "客户关系管理", "PATENT_TYPE", "发明专利", 1, 1,1);
		this.newData("crm.001002", "crm.0010", "客户关系管理", "PATENT_TYPE", "实用新型", 1, 1,2);
		this.newData("crm.001003", "crm.0010", "客户关系管理", "PATENT_TYPE", "外观设计", 1, 1,3);
		
		this.newData("crm.0011", null, "客户关系管理", "PATENT_STATUS", "专利状态", 1, 1,11);
		this.newData("crm.001101", "crm.0011", "客户关系管理", "PATENT_STATUS", "申请", 1, 1,1);
		this.newData("crm.001102", "crm.0011", "客户关系管理", "PATENT_STATUS", "授权", 1, 1,2);
		
		this.newData("crm.0012", null, "客户关系管理", "PATENT_SOURCE", "专利来源", 1, 1,12);
		this.newData("crm.001201", "crm.0012", "客户关系管理", "PATENT_SOURCE", "境内专利", 1, 1,1);
		this.newData("crm.001202", "crm.0012", "客户关系管理", "PATENT_SOURCE", "境外专利", 1, 1,2);
		this.newData("crm.001203", "crm.0012", "客户关系管理", "PATENT_SOURCE", "境内专利转让", 1, 1,3);
		this.newData("crm.001204", "crm.0012", "客户关系管理", "PATENT_SOURCE", "境外专利转让", 1, 1,4);
		
		this.newData("crm.0013", null, "客户关系管理", "PRODUCT_STAGE", "产品阶段", 1, 1,13);
		this.newData("crm.001301", "crm.0013", "客户关系管理", "PRODUCT_STAGE", "研发", 1, 1,1);
		this.newData("crm.001302", "crm.0013", "客户关系管理", "PRODUCT_STAGE", "中试", 1, 1,2);
		this.newData("crm.001303", "crm.0013", "客户关系管理", "PRODUCT_STAGE", "推广", 1, 1,3);
		this.newData("crm.001304", "crm.0013", "客户关系管理", "PRODUCT_STAGE", "发布", 1, 1,4);
		
		this.newData("crm.0014", null, "客户关系管理", "POST", "职位", 1, 1,14);
		this.newData("crm.001401", "crm.0014", "客户关系管理", "POST", "CEO", 1, 1,1);
		this.newData("crm.001402", "crm.0014", "客户关系管理", "POST", "COO", 1, 1,1);
		this.newData("crm.001403", "crm.0014", "客户关系管理", "POST", "CFO", 1, 1,1);
		this.newData("crm.001404", "crm.0014", "客户关系管理", "POST", "CTO", 1, 1,1);
		this.newData("crm.0015", null, "客户关系管理", "DEGREE", "学位", 1, 1,15);
		this.newData("crm.001501", "crm.0015", "客户关系管理", "DEGREE", "高中", 1, 1,1);
		this.newData("crm.001502", "crm.0015", "客户关系管理", "DEGREE", "大专", 1, 1,2);
		this.newData("crm.001503", "crm.0015", "客户关系管理", "DEGREE", "学士", 1, 1,3);
		this.newData("crm.001504", "crm.0015", "客户关系管理", "DEGREE", "硕士", 1, 1,4);
		this.newData("crm.001505", "crm.0015", "客户关系管理", "DEGREE", "博士", 1, 1,5);
		this.newData("crm.001506", "crm.0015", "客户关系管理", "DEGREE", "博士后", 1, 1,6);
		this.newData("crm.001507", "crm.0015", "客户关系管理", "DEGREE", "研究生", 1, 1,6);
		
		this.newData("crm.0016", null, "客户关系管理", "CONTECTTYPE", "交往类型", 1, 1,16);
		this.newData("crm.001601", "crm.0016", "客户关系管理", "VISIT", "拜访", 1, 1,1);
		this.newData("crm.001602", "crm.0016", "客户关系管理", "RECOMMEND", "引荐", 1, 1,2);
		this.newData("crm.001603", "crm.0016", "客户关系管理", "METTING", "会晤", 1, 1,3);
		
		
		this.newData("crm.0017", null, "客户关系管理", "CERTIFICATION_TYPE", "认证类型", 1, 1,17);
		this.newData("crm.001701", "crm.0017", "客户关系管理", "SOFTWERE", "双软认证", 1, 1,1);
		
		this.newData("crm.0018", null, "客户关系管理", "CAPITAL_FORM", "出资方式", 1, 1,18);
		this.newData("crm.001801", "crm.0018", "客户关系管理", "MONEY", "货币", 1, 1,1);
		this.newData("crm.001802", "crm.0018", "客户关系管理", "TECHNOLOGY", "技术", 1, 1,2);
		this.newData("crm.001803", "crm.0018", "客户关系管理", "EQUIPMENT", "设备", 1, 1,3);
		
		//this.newData("crm.0019", null, "客户关系管理", "CONTRACT_TYPE", "合同类型", 1, 1,19);
		//this.newData("crm.001901", "crm.0019", "客户关系管理", "RENT CONTRACT", "租赁合同", 1, 1,1);
		this.newData("crm.0020", null, "客户关系管理", "RENT_REBATE_RULE", "租赁优惠规则", 1, 1,20);
		this.newData("crm.002001", "crm.0020", "客户关系管理", "CollegeStudents", "大学生创业", 1, 1,1);
		this.newData("crm.0021", null, "客户关系管理", "资金计划自动出账提前时间（天）", "7", 1, 1,20);
		
		this.newData("crm.0022", null, "客户关系管理", "POLICY_TYPE", "招商政策类型", 1, 1,21);
		this.newData("crm.002201", "crm.0022", "客户关系管理", "STUDENT", "留学生", 1, 1,1);
		this.newData("crm.002202", "crm.0022", "客户关系管理", "STUDENT", "海归", 1, 1,1);
		
		this.newData("crm.0023", null, "客户关系管理", "Net_TYPE", "宽带类型", 1, 1,21);
		this.newData("crm.002301", "crm.0023", "客户关系管理", "10Mbps", "10Mbps", 1, 1,1);
		this.newData("crm.002302", "crm.0023", "客户关系管理", "5Mbps", "5Mbps", 1, 1,1);
		
		this.newData("crm.0024", null, "客服联系单服务类型", "Service_TYPE", "服务类型", 1, 1,21);
		this.newData("crm.002401", "crm.0024", "客服联系单服务类型", "项目申报", "项目申报", 1, 1,1);
		this.newData("crm.002402", "crm.0024", "客服联系单服务类型", "项目融资", "项目融资", 1, 1,1);
		this.newData("crm.002403", "crm.0024", "客服联系单服务类型", "培训", "培训", 1, 1,1);
		this.newData("crm.002404", "crm.0024", "客服联系单服务类型", "财务", "财务", 1, 1,1);
		
		
		
		this.newData("crm.0025", null, "孵化过程", "INCUBATE_ROUTE", "孵化过程", 1, 1,25);
		this.newData("crm.002501", "crm.0025", "孵化过程", "在孵", "在孵", 1, 1,1);
		this.newData("crm.002502", "crm.0025", "孵化过程", "毕业", "毕业", 1, 1,1);
		this.newData("crm.002503", "crm.0025", "孵化过程", "肄业", "肄业", 1, 1,1);
		this.newData("crm.002504", "crm.0025", "孵化过程", "消亡", "消亡", 1, 1,1);
		this.newData("crm.002505", "crm.0025", "孵化过程", "其他", "其他", 1, 1,1);
		
		this.newData("crm.0026", null, "入驻场所", "INCUBATE_SETTING", "入驻场所", 1, 1,26);
		this.newData("crm.002601", "crm.0026", "入驻场所", "嵌入式软件", "嵌入式软件", 1, 1,1);
		this.newData("crm.002602", "crm.0026", "入驻场所", "新能源与节能", "新能源与节能", 1, 1,1);
		this.newData("crm.002603", "crm.0026", "入驻场所", "创业中心", "创业中心", 1, 1,1);
		this.newData("crm.002604", "crm.0026", "入驻场所", "软件园", "软件园", 1, 1,1);
		this.newData("crm.002605", "crm.0026", "入驻场所", "科技企业加速器", "科技企业加速器", 1, 1,1);
		this.newData("crm.002606", "crm.0026", "入驻场所", "奉化科创", "奉化科创", 1, 1,1);
		this.newData("crm.002607", "crm.0026", "入驻场所", "余姚科创", "余姚科创", 1, 1,1);
		
		this.newData("crm.0027", null, "企业资质", "CUSTOMER_QUALIFICATION", "企业资质", 1, 1,27);
		this.newData("crm.002701", "crm.0027", "企业资质", "经认定的软件企业", "经认定的软件企业", 1, 1,1);
		this.newData("crm.002702", "crm.0027", "企业资质", "园区高新技术企业", "园区高新技术企业", 1, 1,1);
		this.newData("crm.002703", "crm.0027", "企业资质", "市级高新技术企业", "市级高新技术企业", 1, 1,1);
		this.newData("crm.002704", "crm.0027", "企业资质", "国家级高新技术企业", "国家级高新技术企业", 1, 1,1);
		this.newData("crm.002705", "crm.0027", "企业资质", "已参加新企业见面会企业", "已参加新企业见面会企业", 1, 1,1);
		this.newData("crm.002706", "crm.0027", "企业资质", "大学生企业", "大学生企业", 1, 1,1);
		this.newData("crm.002707", "crm.0027", "企业资质", "服务外包", "服务外包", 1, 1,1);
		this.newData("crm.002708", "crm.0027", "企业资质", "明星企业", "明星企业", 1, 1,1);
		this.newData("crm.002709", "crm.0027", "企业资质", "其他", "其他", 1, 1,1);
		
		this.newData("crm.0028", null, "企业纳税地", "CUSTOMER_TAXADRESS", "企业纳税地", 1, 1,28);
		this.newData("crm.002801", "crm.0028", "企业纳税地", "高新区", "高新区", 1, 1,1);
		this.newData("crm.002802", "crm.0028", "企业纳税地", "江东区", "江东区", 1, 1,1);
		this.newData("crm.002803", "crm.0028", "企业纳税地", "江北区", "江北区", 1, 1,1);
		this.newData("crm.002804", "crm.0028", "企业纳税地", "海曙区", "海曙区", 1, 1,1);
		this.newData("crm.002805", "crm.0028", "企业纳税地", "镇海区", "镇海区", 1, 1,1);
		this.newData("crm.002806", "crm.0028", "企业纳税地", "北仑区", "北仑区", 1, 1,1);
		this.newData("crm.002807", "crm.0028", "企业纳税地", "鄞州区", "鄞州区", 1, 1,1);
		
		this.newData("crm.0029", null, "政治面貌", "Political", "政治面貌", 1, 1,5);
		this.newData("crm.002901", "crm.0029", "政治面貌", "PartyMember", "党员", 1, 1,1);
		this.newData("crm.002902", "crm.0029", "政治面貌", "LeagueMember", "团员", 1, 1,2);
		this.newData("crm.002903", "crm.0029", "政治面貌", "Masses", "群众", 1, 1,3);
		
		this.newData("crm.0030", null, "企业类型", "EnterpriseType", "企业类型", 1, 1,5);
		this.newData("crm.003001", "crm.0030", "企业类型", "DXS", "大学生", 1, 1,1);
		this.newData("crm.003002", "crm.0030", "企业类型", "LXS", "留学生", 1, 1,2);
		this.newData("crm.003003", "crm.0030", "企业类型", "YB", "一般", 1, 1,2);
		this.newData("crm.003004", "crm.0030", "企业类型", "WZ", "外资", 1, 1,3);
		this.newData("crm.003005", "crm.0030", "企业类型", "ZD", "浙大企业", 1, 1,3);
		this.newData("crm.003006", "crm.0030", "企业类型", "JD", "街道企业", 1, 1,3);
		
		this.newData("crm.0031", null, "合同甲方类型", "ContractParty", "合同甲方", 1, 1,5);
		this.newData("crm.003101", "crm.0031", "合同甲方", "ZJWLCY", "浙江大学科技园宁波发展有限公司", 1, 1,1);
		return r;
	}
	/**
	 * 
	 * @param id
	 * @param parentId
	 * @param moduleName
	 * @param dataName
	 * @param value
	 * @param fixed 1 系统 0用户
	 * @param type 0单一值 1列表值
	 */
	private void newData(String id,String parentId,String moduleName,String dataName,String value,Integer fixed,Integer type,Integer order){
		DataDict dataDict=new DataDict();
		dataDict.setId(id);
		dataDict.setModuleName(moduleName);
		dataDict.setDataName(dataName);
		dataDict.setDataValue(value);
		dataDict.setFixed(fixed);
		dataDict.setParentId(parentId);
		dataDict.setType(type);
		dataDict.setDisplayOrder(order);
		list.add(dataDict);
	}
	public List<DataDict> getList() {
		init();
		return list;
	}
	
}
