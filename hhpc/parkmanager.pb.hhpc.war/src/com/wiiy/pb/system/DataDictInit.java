package com.wiiy.pb.system;

import java.util.ArrayList;
import java.util.List;

import com.wiiy.core.entity.DataDict;

public class DataDictInit {
	private List<DataDict> list=new ArrayList<DataDict>();
	public boolean init(){
		boolean r=true;
		
		
		this.newData("pb.0001", null, "园区管理", "BUILDING_TYPE", "楼宇类型", 1, 1,1);
		this.newData("pb.000101", "pb.0001", "园区管理", "BUILDING_TYPE", "办公楼", 1, 1,1);
		this.newData("pb.000102", "pb.0001", "园区管理", "BUILDING_TYPE", "厂房", 1, 1,2);
		this.newData("pb.000103", "pb.0001", "园区管理", "BUILDING_TYPE", "宿舍公寓", 1, 1,3);
		this.newData("pb.000104", "pb.0001", "园区管理", "BUILDING_TYPE", "混合型", 1, 1,4);
		this.newData("pb.000105", "pb.0001", "园区管理", "BUILDING_TYPE", "其他", 1,1, 5);
		
		this.newData("pb.0002", null, "园区管理", "BUILDING_KIND", "楼宇性质", 1, 1,2);
		this.newData("pb.000201", "pb.0002", "园区管理", "BUILDING_KIND", "自营楼宇", 1, 1,1);
		this.newData("pb.000202", "pb.0002", "园区管理", "BUILDING_KIND", "托管楼宇", 1, 1,2);
		this.newData("pb.000203", "pb.0002", "园区管理", "BUILDING_KIND", "其他", 1, 1,3);
		
		this.newData("pb.0003", null, "园区管理", "INVEST_DIRECTION", "招商方向", 1, 1,3);
		this.newData("pb.000301", "pb.0003", "园区管理", "INVEST_DIRECTION", "旅游产业", 1, 1,1);
		this.newData("pb.000302", "pb.0003", "园区管理", "INVEST_DIRECTION", "文化创意产业", 1, 1,2);
		this.newData("pb.000303", "pb.0003", "园区管理", "INVEST_DIRECTION", "金融服务业", 1, 1,3);
		this.newData("pb.000304", "pb.0003", "园区管理", "INVEST_DIRECTION", "商贸物流业", 1, 1,4);
		this.newData("pb.000305", "pb.0003", "园区管理", "INVEST_DIRECTION", "信息服务与软件业", 1, 1,5);
		this.newData("pb.000306", "pb.0003", "园区管理", "INVEST_DIRECTION", "中介服务业", 1, 1,6);
		this.newData("pb.000307", "pb.0003", "园区管理", "INVEST_DIRECTION", "房地产业", 1, 1,7);
		this.newData("pb.000308", "pb.0003", "园区管理", "INVEST_DIRECTION", "社区服务业", 1, 1,8);
		this.newData("pb.000309", "pb.0003", "园区管理", "INVEST_DIRECTION", "其他", 1, 1,9);
		
		this.newData("pb.0004", null, "园区管理", "AIRCON_SITUATION", "空调设施", 1, 1,4);
		this.newData("pb.000401", "pb.0004", "园区管理", "AIRCON_SITUATION", "独立空调", 1, 1,1);
		this.newData("pb.000402", "pb.0004", "园区管理", "AIRCON_SITUATION", "中央空调", 1, 1,2);
		this.newData("pb.000403", "pb.0004", "园区管理", "AIRCON_SITUATION", "自配空调", 1, 1,3);

		this.newData("pb.0005", null, "园区管理", "DECORATION_SITUATION", "装修情况", 1, 1,5);
		this.newData("pb.000501", "pb.0005", "园区管理", "DECORATION_SITUATION", "未装", 1, 1,1);
		this.newData("pb.000502", "pb.0005", "园区管理", "DECORATION_SITUATION", "简装", 1, 1,2);
		this.newData("pb.000503", "pb.0005", "园区管理", "DECORATION_SITUATION", "精装", 1, 1,3);

		
		this.newData("pb.0006", null, "园区管理", "ROOM_TYPE", "房间用途", 1, 1,6);
		this.newData("pb.000601", "pb.0006", "园区管理", "ROOM_TYPE", "办公", 1, 1,1);
		this.newData("pb.000602", "pb.0006", "园区管理", "ROOM_TYPE", "厂房", 1, 1,2);
		this.newData("pb.000603", "pb.0006", "园区管理", "ROOM_TYPE", "宿舍", 1, 1,3);
		this.newData("pb.000699", "pb.0006", "园区管理", "ROOM_TYPE", "其他", 1, 1,99);
		
		this.newData("pb.0007", null, "园区管理", "ROOM_KIND", "房间性质", 1, 1,7);
		this.newData("pb.000701", "pb.0007", "园区管理", "ROOM_KIND", "出租", 1, 1,1);
		this.newData("pb.000702", "pb.0007", "园区管理", "ROOM_KIND", "出售", 1, 1,2);
		this.newData("pb.000703", "pb.0007", "园区管理", "ROOM_KIND", "自用", 1, 1,3);
		this.newData("pb.000704", "pb.0007", "园区管理", "ROOM_KIND", "共用", 1, 1,4);
		this.newData("pb.000799", "pb.0007", "园区管理", "ROOM_KIND", "其他", 1, 1,99);
		
		this.newData("pb.0008", null, "园区管理", "CHANGE_TYPE", "变更类型", 1, 1,8);
		this.newData("pb.000801", "pb.0008", "园区管理", "CHANGE_TYPE", "房屋合并", 1, 1,1);
		this.newData("pb.000802", "pb.0008", "园区管理", "CHANGE_TYPE", "房屋拆分", 1, 1,2);
		this.newData("pb.000803", "pb.0008", "园区管理", "CHANGE_TYPE", "水电气表变更", 1, 1,3);
		this.newData("pb.000899", "pb.0008", "园区管理", "CHANGE_TYPE", "其他", 1, 1,99);
		
		this.newData("pb.0009", null, "园区管理", "FACILITY_TYPE", "设施类型", 1, 1,9);
		this.newData("pb.000901", "pb.0009", "园区管理", "FACILITY_TYPE", "网络", 1, 1,1);
		this.newData("pb.000902", "pb.0009", "园区管理", "FACILITY_TYPE", "电梯", 1, 1,2);
		this.newData("pb.000903", "pb.0009", "园区管理", "FACILITY_TYPE", "车位", 1, 1,3);
		this.newData("pb.000904", "pb.0009", "园区管理", "FACILITY_TYPE", "广告位", 1, 1,4);
		this.newData("pb.000905", "pb.0009", "园区管理", "FACILITY_TYPE", "会议室", 1, 1,5);
		
		
		this.newData("pb.0010", null, "园区管理", "FIXREPORT_TYPE", "报修类型", 1, 1,10);
		this.newData("pb.001001", "pb.0010", "园区管理", "TYPE1", "空调报修", 1, 1,1);
		this.newData("pb.001002", "pb.0010", "园区管理", "TYPE2", "网络报修", 1, 1,2);
		this.newData("pb.001003", "pb.0010", "园区管理", "TYPE3", "墙体报修", 1, 1,3);
		this.newData("pb.0011", null, "园区管理", "FIXREPORT_METHOD", "报修方式", 1, 1,11);
		this.newData("pb.001101", "pb.0011", "园区管理", "NETWORK", "网络报修", 1, 1,1);
		this.newData("pb.001102", "pb.0011", "园区管理", "PHONE", "电话报修", 1, 1,2);
		this.newData("pb.001103", "pb.0011", "园区管理", "SCENCE", "现场报修", 1, 1,3);
		
		this.newData("pb.0012", null, "园区管理", "BONUS_TYPE", "奖励类型", 1, 1,12);
		this.newData("pb.001201", "pb.0012", "园区管理", "TYPE1", "企业退税", 1, 1,1);
		this.newData("pb.001202", "pb.0012", "园区管理", "TYPE2", "补贴", 1, 1,2);
		
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
