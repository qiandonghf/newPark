package com.wiiy.oa.system;

import java.util.ArrayList;
import java.util.List;

import com.wiiy.core.entity.DataDict;

public class DataDictInit {
	private List<DataDict> list=new ArrayList<DataDict>();
	public boolean init(){
		boolean r=true;
		
		/*this.newData("oa.0001", null, "办公管理系统", "CarType", "车辆类型", 1, 1,1);
		this.newData("oa.000101", "oa.0001", "办公管理系统", "Car", "轿车", 1, 1,1);
		this.newData("oa.000102", "oa.0001", "办公管理系统", "Truck", "货车", 1, 1,2);
		this.newData("oa.000103", "oa.0001", "办公管理系统", "Vehicle", "商务车", 1, 1,3);
		this.newData("oa.0002", null, "办公管理系统", "CarFixType", "车辆维修类型", 1, 1,2);
		this.newData("oa.000201", "oa.0002", "办公管理系统", "Maintenance", "保养", 1, 1,1);
		this.newData("oa.000202", "oa.0002", "办公管理系统", "Fix", "维修", 1, 1,2);*/
		this.newData("oa.0003", null, "办公管理系统", "FixedAssetsType", "资产类别", 1, 1,3);
		this.newData("oa.000301", "oa.0003", "办公管理系统", "OfficeSupplies", "办公用品", 1, 1,1);
		this.newData("oa.000302", "oa.0003", "办公管理系统", "Car", "车辆", 1, 1,2);
		this.newData("oa.000303", "oa.0003", "办公管理系统", "Machine", "机械设备", 1, 1,3);
		
		this.newData("oa.0004", null, "办公管理系统", "Religious", "宗教信仰", 1, 1,4);
		this.newData("oa.000401", "oa.0004", "办公管理系统", "Buddhism", "佛教", 1, 1,1);
		this.newData("oa.000402", "oa.0004", "办公管理系统", "Islam", "伊斯兰教", 1, 1,2);
		this.newData("oa.000403", "oa.0004", "办公管理系统", "Other", "其他", 1, 1,3);
		
		this.newData("oa.0005", null, "办公管理系统", "Political", "政治面貌", 1, 1,5);
		this.newData("oa.000501", "oa.0005", "办公管理系统", "PartyMember", "党员", 1, 1,1);
		this.newData("oa.000502", "oa.0005", "办公管理系统", "LeagueMember", "团员", 1, 1,2);
		this.newData("oa.000503", "oa.0005", "办公管理系统", "Masses", "群众", 1, 1,3);
		
		this.newData("oa.0006", null, "办公管理系统", "Nationality", "国籍", 1, 1,6);
		this.newData("oa.000601", "oa.0006", "办公管理系统", "China", "中国", 1, 1,1);
		
		this.newData("oa.0007", null, "办公管理系统", "Ethnic", "民族", 1, 1,7);
		this.newData("oa.000701", "oa.0007", "办公管理系统", "Han", "汉族", 1, 1,1);

		this.newData("oa.0008", null, "办公管理系统", "MeetingType", "会议类型", 1, 1,7);
		this.newData("oa.000801", "oa.0008", "会议类型", "OfficeConference", "办公会议", 1, 1,1);
		this.newData("oa.000802", "oa.0008", "会议类型", "FireSafetyConference", "消防安全会议", 1, 1,1);
		
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
