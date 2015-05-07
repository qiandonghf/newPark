package com.wiiy.crm.preferences.format;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dto.DataPropertyDto;
import com.wiiy.crm.entity.DataProperty;
import com.wiiy.crm.entity.DataReportProperty;
import com.wiiy.crm.entity.DataReportValue;

public class BusinessDataReportFormat extends DataReportFormat {
	
	protected int index;
	
	@Override
	public String format(List<DataProperty> propertyList) {
		Collections.sort(propertyList, new Comparator<DataProperty>() {
			@Override
			public int compare(DataProperty p1, DataProperty p2) {
				return p1.getOrder()-p2.getOrder();
			}
		});
		List<DataReportProperty> rpList = new ArrayList<DataReportProperty>();
		for (DataProperty property : propertyList) {
			DataReportProperty rp = new DataReportProperty();
			BeanUtil.copyProperties(property, rp);
			rp.setPropertyId(property.getId());
			rpList.add(rp);
		}
		return format(rpList, new HashMap<Long, DataReportValue>());
	}
	@Override
	public String format(List<DataReportProperty> propertyList,Map<Long, DataReportValue> valueMap) {
		Collections.sort(propertyList, new Comparator<DataReportProperty>() {
			@Override
			public int compare(DataReportProperty p1, DataReportProperty p2) {
				return p1.getOrder()-p2.getOrder();
			}
		});
		this.valueMap = valueMap;
		clear();
		a("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"table_sy1\" style=\"margin:0 auto;table-layout:fixed;\">");
		a("<colgroup><col width=\"110\" /><col width=\"171\" /><col width=\"40\" /><col width=\"150\" /></colgroup>");
		a("<tr><th>&nbsp;</th><th>项目</th><th>序号</th><th>本期数</th><th>本年累计数</th></tr>");
		index = 0;
		for(DataReportProperty rp : propertyList){
			appendProperty(rp);
		}
		a("</table>");
		return html();
	}
	protected void appendProperty(DataReportProperty property){
		a("<tr><th>"+property.getName()+"</th><td colspan=\"4\" style=\"padding:0;width:725px;\">");
		a("<table align=\"left\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" class=\"table_sy4\" style=\"width:100%; \">");
			if(property.getName().equals("企业经营状况")){
				a("<colgroup><col width=\"170\" /><col width=\"40\" /><col width=\"150\" /></colgroup>");
			} else {
				a("<colgroup><col width=\"170\" /><col width=\"40\" /></colgroup>");
			}
			if(property.getChildren()!=null && property.getChildren().size()>0){
				sort(property.getChildren());
				for (Object obj : property.getChildren()) {
					appendSubProperty(obj);
				}
			}
		a("</table>");	
		a("</td></tr>");
	}
	protected void appendSubProperty(Object obj) {
		if(obj instanceof DataProperty) {
			appendPropertyHtml((DataProperty)obj);
		} else if(obj instanceof DataReportProperty){
			DataReportProperty rp = (DataReportProperty)obj;
			DataPropertyDto dto = new DataPropertyDto();
			dto.setDataReportProperty(rp);
			appendPropertyHtml(dto);
		}
	}
	protected void appendPropertyHtml(DataPropertyDto propertyDto) {
		DataReportProperty property = propertyDto.getDataReportProperty();
		if(property.getName().equals("本期数") || property.getName().equals("本年累计数")) return;
		StringBuilder prefix = new StringBuilder();
		for (int i = 1; i < property.getLevel(); i++) {
			prefix.append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
		}
		a("<tr>");
		a("<td style=\"text-align:left\">"+prefix.toString()+property.getName()+"&nbsp;</td>");
		a("<td>"+nextIndex()+"&nbsp;</td>");
		if(property.getDataType()==null){
			if(property.getChildren()!=null && property.getChildren().size()>0){
				sort(property.getChildren());
				for (Object obj : property.getChildren()) {
					appendLevelThree(obj);
				}
			}
		} else {
			a("<td colspan=\"2\">"+propertyDataHtml(property)+property.getUnit()+"&nbsp;</td>");
		}
		a("</tr>");
		if(property.getChildren()!=null && property.getChildren().size()>0){
			sort(property.getChildren());
			for (Object obj : property.getChildren()) {
				appendSubProperty(obj);
			}
		}
	}
	protected boolean appendLevelThree(Object obj) {
		boolean append = false;
		if(obj instanceof DataProperty) {
			DataProperty property = (DataProperty)obj;
			if(property.getName().equals("本期数") || property.getName().equals("本年累计数")){
				append = true;
				a("<td>"+propertyDataHtml(property )+property.getUnit()+"&nbsp;</td>");
			}
			
		} else if(obj instanceof DataReportProperty){
			DataReportProperty property = (DataReportProperty)obj;
			if(property.getName().equals("本期数") || property.getName().equals("本年累计数")){
				append = true;
				a("<td>"+propertyDataHtml(property )+property.getUnit()+"&nbsp;</td>");
			}
		}
		return append;
	}
	protected void appendPropertyHtml(DataProperty property) {
		if(property.getName().equals("本期数") || property.getName().equals("本年累计数")) return;
		StringBuilder prefix = new StringBuilder();
		for (int i = 1; i < property.getLevel(); i++) {
			prefix.append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
		}
		a("<tr>");
		a("<td style=\"text-align:left\">"+prefix.toString()+property.getName()+"&nbsp;</td>");
		a("<td>"+nextIndex()+"&nbsp;</td>");
		if(property.getDataType()==null){
			if(property.getChildren()!=null && property.getChildren().size()>0){
				sort(property.getChildren());
				for (Object obj : property.getChildren()) {
					appendLevelThree(obj);
				}
			}
		} else {
			a("<td colspan=\"2\">"+propertyDataHtml(property)+property.getUnit()+"&nbsp;</td>");
		}
		a("</tr>");
		if(property.getChildren()!=null && property.getChildren().size()>0){
			sort(property.getChildren());
			for (Object obj : property.getChildren()) {
				appendSubProperty(obj);
			}
		}
	}
	protected int nextIndex(){
		return ++index;
	}
	protected void appendProperty(DataProperty property){
		DataReportProperty rp = new DataReportProperty();
		BeanUtil.copyProperties(property, rp);
		rp.setPropertyId(property.getId());
		appendProperty(rp);
	}

}