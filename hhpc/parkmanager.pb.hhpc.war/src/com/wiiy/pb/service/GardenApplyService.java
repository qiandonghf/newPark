package com.wiiy.pb.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Pager;
import com.wiiy.pb.entity.GardenApply;

/**
 * @author my
 */
public interface GardenApplyService extends IService<GardenApply> {
	
	/**
	 * 根据字段下的值进行排序,顺序为fields字符串数组的顺序
	 * @param pager 分页
	 * @param conditions 查询条件
	 * @param searchName 搜索内容
	 * @param field 字段
	 * @param fields 字符串
	 * @return
	 */
	List<GardenApply> getListByConditions(
			Pager pager,
			String conditions,
			String searchName,
			String field,
			String[] fields);
}
