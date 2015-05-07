package com.wiiy.core.newsWebService;

import java.util.ArrayList;
import java.util.List;

import com.wiiy.core.dto.ColumnDto;
import com.wiiy.core.dto.WebInfoDto;
import com.wiiy.core.entity.NewsParam;
import com.wiiy.core.service.NewsParamService;

public class ObtainInformation {
	private List<ColumnDto> columnList = new ArrayList<ColumnDto>();
	private List<WebInfoDto> webInfoList = new ArrayList<WebInfoDto>();
	private NewsParamService newsParamService;

	public void setNewsParamService(NewsParamService newsParamService) {
		this.newsParamService = newsParamService;
	}

	public List<ColumnDto> getColumnList() {
		return columnList;
	}

	public void setColumnList(List<ColumnDto> columnList) {
		this.columnList = columnList;
	}

	public List<WebInfoDto> getWebInfoList() {
		return webInfoList;
	}

	public void setWebInfoList(List<WebInfoDto> webInfoList) {
		this.webInfoList = webInfoList;
	}

	public String getInformation() {

		try {
			columnList = new ArrayList<ColumnDto>();
			ColumnService service = new CoulmnServiceImplService()
					.getCoulmnServiceImplPort();
			//webservice获取到所有的栏目
			String column_str = service.columnStr();
			String[] colums = column_str.split(",");
			ArrayList<ColumnDto> list = new ArrayList<ColumnDto>();
			//循环解析栏目信息
			for(int j = 0 ; j< colums.length; j++){
				String column = subStringToCustomField(colums[j]);
				String[] columnParmate = column.split("-");
				String columnId = columnParmate[0];
				String columnName = columnParmate[1];
				String superId =  columnParmate[2];
				ColumnDto columnDto = new ColumnDto();
				columnDto.setId(Long.parseLong(columnId));
				columnDto.setColumnName(columnName);
				if (!superId.equals("null")) {
					columnDto.setSuperId(superId);
				}
				
				list.add(columnDto);
			}
			//组成tree结构
			for (int i = 0; i < list.size(); i++) {
				
				ColumnDto columnDto = list.get(i);
				columnDto.setText(columnDto.getColumnName());
				columnDto.setLevel(0);
				columnDto.setIconCls("column");
				//如果没有父节点Id,则为最顶级的节点
				if (columnDto.getSuperId() == null) {
					List<ColumnDto> cherList = new ArrayList<ColumnDto>() ;
					for (int k = 0; k < list.size(); k++) {
						//如果有父节点Id,则把他添加到对应的父节点下面
						ColumnDto columnDto2 = list.get(k);
						if (columnDto2.getSuperId() != null && Long.parseLong(columnDto2.getSuperId()) == columnDto.getId()) {
							columnDto2.setText(columnDto2.getColumnName());
							columnDto2.setLevel(1);
							columnDto2.setIconCls("column");
							//判断是否是已经订阅的栏目
							columnDto2.setChecked(isCheckColumn(columnDto2.getId().toString()));
							//给栏目子节点添加对应的频道
							columnDto2.setChildren(getWebInfos(columnDto2.getId().toString()));
							cherList.add(columnDto2);

						}
					}
					columnDto.setChecked(isCheckColumn(columnDto.getId().toString()));
					columnDto.setChildren(cherList);
					columnList.add(columnDto);
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "json";
	}

	/**
	 * 截取字符串,去掉第一个和最后一个字符
	 * 
	 * @param str
	 * @return
	 */
	public String subStringToCustomField(String str) {
		return str.substring(1, str.length() - 1);
	}

	/**
	 * 根据栏目Id来获取频道列表
	 * 
	 * @param columnId
	 * @return
	 */
	public List<WebInfoDto> getWebInfos(String columnId) {
		webInfoList = new ArrayList<WebInfoDto>();
		WebInfoService service = new WebInfoServiceImplService()
				.getWebInfoServiceImplPort();
		String webInfo_str = service.getWebInfoList(columnId);
		if (webInfo_str.equals("")) {
			return null;
		}
		String[] webInfos = webInfo_str.split(",");
		for (int i = 0; i < webInfos.length; i++) {
			String webInfo = subStringToCustomField(webInfos[i]);
			String[] webInfo_parmate = webInfo.split("-");
			WebInfoDto webInfoDto = new WebInfoDto();
			webInfoDto.setId(Long.parseLong(webInfo_parmate[0]));
			webInfoDto.setWebInfoName(webInfo_parmate[1]);
			webInfoDto.setText(webInfo_parmate[1]);
			webInfoDto.setLevel(2);
			webInfoDto.setIconCls("webInfo");
			//设置是否是选择的属性
			webInfoDto.setChecked(isCheckWebInfo(webInfo_parmate[0]));

			webInfoList.add(webInfoDto);
		}
		return webInfoList;
	}

	/**
	 *判断是否是已经选择的栏目
	 * 
	 * @param columnId
	 * @return boolean
	 */
	public boolean isCheckColumn(String columnId) {
		if (newsParamService.getList() != null) {
			NewsParam newsParam = newsParamService.getList().getValue().get(0);
			String[] str = newsParam.getColumnId().split("-");
			for (int i = 0; i < str.length; i++) {
				if (str[i].equals(columnId)) {
					return true;
				}
			}
		}

		return false;
	}

	/**
	 *判断是否是已经选择的频道
	 * 
	 * @param webInfoId
	 * @return boolean
	 */
	public boolean isCheckWebInfo(String webInfoId) {
		if (newsParamService.getList() != null) {
			NewsParam newsParam = newsParamService.getList().getValue().get(0);
			String[] str = newsParam.getWebInfoId().split("-");
			for (int i = 0; i < str.length; i++) {
				if (str[i].equals(webInfoId)) {
					return true;
				}
			}
		}
		return false;
	}

}
