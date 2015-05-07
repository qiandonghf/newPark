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

public class DefaultReportFormat extends DataReportFormat {
	
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
		a("<colgroup><col width=\"110\" /><col width=\"171\" /><col width=\"150\" /><col width=\"60\" /></colgroup>");
		a("<tr><th>&nbsp;</th><th>指标</th><th>数值</th><th>单位</th><th>说明</th></tr>");
		if(propertyList!=null)
		for(DataReportProperty rp : propertyList){
			appendProperty(rp);
		}
		a("</table>");
		return html();
	}
	protected void appendProperty(DataReportProperty property){
		a("<tr><th>"+property.getName()+"</th><td colspan=\"4\" style=\"padding:0;\">");
		a("<table align=\"left\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" class=\"table_sy4\" style=\"width:100%; \">");
			a("<colgroup><col width=\"170\" /><col width=\"150\" /><col width=\"60\" /></colgroup>");
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
		StringBuilder prefix = new StringBuilder();
		for (int i = 1; i < property.getLevel(); i++) {
			prefix.append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
		}
		a("<tr>");
		a("<td style=\"text-align:left\">"+prefix.toString()+property.getName()+"&nbsp;</td>");
		a("<td>"+propertyDataHtml(property)+"&nbsp;</td>");
		a("<td>"+property.getUnit()+"&nbsp;</td>");
		a("<td>"+property.getNote()+"&nbsp;</td>");
		if(property.getChildren()!=null && property.getChildren().size()>0){
			sort(property.getChildren());
			for (Object obj : property.getChildren()) {
				appendSubProperty(obj);
			}
		}
		a("</tr>");
	}
	protected void appendPropertyHtml(DataProperty property) {
		StringBuilder prefix = new StringBuilder();
		for (int i = 1; i < property.getLevel(); i++) {
			prefix.append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
		}
		a("<tr>");
		a("<td style=\"text-align:left\">"+prefix.toString()+property.getName()+"&nbsp;</td>");
		a("<td>"+propertyDataHtml(property)+"&nbsp;</td>");
		a("<td>"+property.getUnit()+"&nbsp;</td>");
		a("<td>"+property.getNote()+"&nbsp;</td>");
		if(property.getChildren()!=null && property.getChildren().size()>0){
			sort(property.getChildren());
			for (Object obj : property.getChildren()) {
				appendSubProperty(obj);
			}
		}
		a("</tr>");
	}
	protected void appendProperty(DataProperty property){
		DataReportProperty rp = new DataReportProperty();
		BeanUtil.copyProperties(property, rp);
		rp.setPropertyId(property.getId());
		appendProperty(rp);
	}

}
