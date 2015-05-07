package com.wiiy.crm.preferences.format;

import java.util.List;
import java.util.Map;

import com.wiiy.crm.dto.DataPropertyDto;
import com.wiiy.crm.entity.DataProperty;
import com.wiiy.crm.entity.DataReportProperty;
import com.wiiy.crm.entity.DataReportValue;
import com.wiiy.crm.preferences.enums.DataTypeEnum;

public class SearchReportFormat extends BusinessDataReportFormat{
	
	@Override
	public String propertyDataHtml(DataTypeEnum dataType, Long propertyId,String dataTypeExt) {
		StringBuilder s = new StringBuilder();
		if(dataType!=null){
			s.append("<input name=\"property\" type='checkbox' class=\"vetM\" value=\"propertyId"+propertyId+"\"/>");
			switch(dataType){
				case INT:
					s.append("<input name=\"property."+propertyId+".le\" class=\"input int\" size=\"8\"/>—<input name=\"property."+propertyId+".ge\" class=\"input int\" size=\"8\"/>");
					break;
				case DOUBLE:
					s.append("<input name=\"property."+propertyId+".le\" class=\"input double\" size=\"8\"/>—<input name=\"property."+propertyId+".ge\" class=\"input int\" size=\"8\"/>");
					break;
			}
		}
		return s.toString();
	}
	
	public String format(List<DataReportProperty> propertyList,Map<Long, DataReportValue> valueMap) {
		this.valueMap = valueMap;
		clear();
		a("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"table_sy1\" style=\"margin:0 auto;table-layout:fixed;\">");
		a("<colgroup><col width=\"110\" /><col width=\"171\" /><col width=\"40\" /><col width=\"210\" /></colgroup>");
		a("<tr><th>&nbsp;</th><th>项目</th><th>序号</th><th>本期数</th><th>本年累计数</th></tr>");
		index = 0;
		for(DataReportProperty rp : propertyList){
			appendProperty(rp);
		}
		a("</table>");
		return html();
	}
	protected void appendProperty(DataReportProperty property){
		a("<tr><th>"+property.getName()+"</th><td colspan=\"4\" style=\"padding:0;\">");
		a("<table align=\"left\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" class=\"table_sy4\" style=\"width:100%; \">");
			if(property.getName().equals("企业经营状况")){
				a("<colgroup><col width=\"170\" /><col width=\"40\" /><col width=\"210\" /></colgroup>");
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
				for (Object obj : property.getChildren()) {
					appendLevelThree(obj);
				}
			}
		} else {
			a("<td colspan=\"2\">"+propertyDataHtml(property)+"&nbsp;</td>");
		}
		a("</tr>");
		if(property.getChildren()!=null && property.getChildren().size()>0){
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
				a("<td>"+propertyDataHtml(property )+"&nbsp;</td>");
			}
			
		} else if(obj instanceof DataReportProperty){
			DataReportProperty property = (DataReportProperty)obj;
			if(property.getName().equals("本期数") || property.getName().equals("本年累计数")){
				append = true;
				a("<td>"+propertyDataHtml(property )+"&nbsp;</td>");
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
			a("<td colspan=\"2\">"+propertyDataHtml(property)+"&nbsp;</td>");
		}
		a("</tr>");
		if(property.getChildren()!=null && property.getChildren().size()>0){
			sort(property.getChildren());
			for (Object obj : property.getChildren()) {
				appendSubProperty(obj);
			}
		}
	}
}
