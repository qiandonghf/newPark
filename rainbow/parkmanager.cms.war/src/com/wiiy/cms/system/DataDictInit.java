package com.wiiy.cms.system;

import java.util.ArrayList;
import java.util.List;

import com.wiiy.core.entity.DataDict;

public class DataDictInit {
	private List<DataDict> list=new ArrayList<DataDict>();
	public boolean init(){
		boolean r=true;
		this.newData("cms.10001", null, "内容管理系统", "TEMPLETE", "浮动广告模版", 1, 1,1);
		this.newData("cms.100101", "cms.10001", "内容管理系统", "RESOURCE", "首页浮窗", 1, 1,1);
		this.newData("cms.100102", "cms.10001", "内容管理系统", "RESOURCE", "页面左右侧", 1, 1,2);
		//this.newData("cms.000103", "cms.0001", "内容管理系统", "ARTICLE", "首页第1行栏目3(校园概况)", 1, 1,3);
		/*this.newData("cms.000104", "cms.0001", "内容管理系统", "ARTICLE", "首页第1行栏目4(通知公告)", 1, 1,4);
		this.newData("cms.000105", "cms.0001", "内容管理系统", "ARTICLE", "首页第2行栏目1(科研动态)", 1, 1,5);
		this.newData("cms.000106", "cms.0001", "内容管理系统", "ARTICLE", "首页第2行栏目2(专题活动)", 1, 1,6);
		this.newData("cms.000107", "cms.0001", "内容管理系统", "ARTICLE", "首页第2行栏目3(校本培训)", 1, 1,7);
		this.newData("cms.000108", "cms.0001", "内容管理系统", "ARTICLE", "首页第3行栏目1(名师风采)", 1, 1,8);
		this.newData("cms.000109", "cms.0001", "内容管理系统", "ARTICLE", "首页第3行栏目2(科研管理)", 1, 1,9);
		this.newData("cms.000110", "cms.0001", "内容管理系统", "ARTICLE", "首页第4行栏目1(队的组织)", 1, 1,10);
		this.newData("cms.000111", "cms.0001", "内容管理系统", "ARTICLE", "首页第4行栏目2(领巾广场)", 1, 1,11);
		this.newData("cms.000112", "cms.0001", "内容管理系统", "ARTICLE", "首页第4行栏目3(星星火炬)", 1, 1,12);
		this.newData("cms.000113", "cms.0001", "内容管理系统", "ARTICLE", "首页第4行栏目4(辅导员天地)", 1, 1,13);
		this.newData("cms.000114", "cms.0001", "内容管理系统", "ARTICLE", "首页第4行栏目5(群星璀璨)", 1, 1,14);
		this.newData("cms.000115", "cms.0001", "内容管理系统", "ARTICLE", "首页第5行栏目1(专题)", 1, 1,15);
		this.newData("cms.000116", "cms.0001", "内容管理系统", "ARTICLE", "首页第6行栏目1(电子图书)", 1, 1,16);
		this.newData("cms.000117", "cms.0001", "内容管理系统", "ARTICLE", "首页第6行栏目2(名师工作室)", 1, 1,17);
		this.newData("cms.000118", "cms.0001", "内容管理系统", "ARTICLE", "首页第6行栏目3(家长频道)", 1, 1,18);
		
		this.newData("cms.000151", "cms.0001", "内容管理系统", "RESOURCE", "网站头部Flash", 1, 1,1);
		this.newData("cms.000152", "cms.0001", "内容管理系统", "RESOURCE", "第2行栏目标题", 1, 1,2);
		this.newData("cms.000153", "cms.0001", "内容管理系统", "RESOURCE", "中间通栏广告位", 1, 1,3);
		this.newData("cms.000154", "cms.0001", "内容管理系统", "RESOURCE", "广告位下方栏目标题", 1, 1,4);
		this.newData("cms.000155", "cms.0001", "内容管理系统", "RESOURCE", "资源在线栏目标题", 1, 1,5);*/
		
		
		
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
