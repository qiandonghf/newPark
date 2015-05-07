package com.wiiy.crm.preferences.format;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wiiy.commons.util.DateUtil;
import com.wiiy.crm.entity.DataProperty;
import com.wiiy.crm.entity.DataReportProperty;
import com.wiiy.crm.entity.DataReportValue;
import com.wiiy.crm.preferences.enums.DataTypeEnum;

public abstract class DataReportFormat {
	public abstract String format(List<DataReportProperty> propertyList,Map<Long, DataReportValue> valueMap);
	public abstract String format(List<DataProperty> propertyList);
	protected Map<Long, DataReportValue> valueMap = new HashMap<Long, DataReportValue>();
	public Map<Long, DataReportValue> getValueMap() {
		return valueMap;
	}
	public void setValueMap(Map<Long, DataReportValue> valueMap) {
		this.valueMap = valueMap;
	}
	protected StringBuilder sb = new StringBuilder();
	public DataReportFormat a(String s){
		sb.append(s);
		return this;
	}
	public DataReportFormat dqm(String s){
		sb.append("\"").append(s).append("\"");
		return this;
	}
	public void clear(){
		sb = new StringBuilder();
		System.out.println("-----------clear------------");
	}
	public String propertyDataHtml(DataTypeEnum dataType, Long propertyId, String dataTypeExt){
		StringBuilder s = new StringBuilder();
		DataReportValue value = valueMap.get(propertyId);
		String v = "";
		NumberFormat numberFormat = new DecimalFormat("#0.00");
		if(dataType!=null){
			s.append("<input class='pinput' name=\"propertyIds\" value=\""+propertyId+"\" type=\"hidden\"/>");
			switch(dataType){
				case DATETIME:
					if(value!=null && value.getDateVal()!=null) v = DateUtil.format(value.getDateVal()); 
					s.append("<input class='pinput' name=\"propertyValues\" value=\""+v+"\" id=\"property"+propertyId+"\" onclick=\"return showCalendar(this.id);\" readonly=\"readonly\" />");
					break;
				case INT:
					if(value!=null && value.getIntVal()!=null) v = value.getIntVal()+"";
					s.append("<input class='pinput' name=\"propertyValues\" value=\""+v+"\" class=\"int\" />");
					break;
				case DOUBLE:
					if(value!=null && value.getDoubleVal()!=null) v = numberFormat.format(value.getDoubleVal())+"";
					s.append("<input class='pinput' name=\"propertyValues\" value=\""+v+"\" class=\"double\" />");
					break;
				case SELECT:
					if(value!=null) v = value.getSelVal()+"";
					s.append("<select name=\"propertyValues\"><option value=\"\">----请选择----</option>");
					String[] values = dataTypeExt.split("\\|");
					if(values!=null && values.length>0){
						for(int i = 0; i < values.length; i++){
							if(values[i].equals(v)) {
								s.append("<option value=\""+values[i]+"\" selected=\"selected\">"+values[i]+"</option>");
							} else {
								s.append("<option value=\""+values[i]+"\">"+values[i]+"</option>");
							}
						}
					}
					s.append("</select>");
					break;
				case STRING:
					if(value!=null) v = value.getDoubleVal()+"";
					s.append("<input class='pinput' name=\"propertyValues\" value=\""+v+"\" />");
					break;
			}
		}
		return s.toString();
	}
	public String propertyDataHtml(DataProperty property){
		return propertyDataHtml(property.getDataType(), property.getId(), property.getDataTypeExt());
	}
	public String propertyDataHtml(DataReportProperty property){
		return propertyDataHtml(property.getDataType(), property.getId(), property.getDataTypeExt());
	}
	public String html(){
		return sb.toString();
	}
	public void sort(List<Object> list){
		Collections.sort(list, new Comparator<Object>() {
			@Override
			public int compare(Object o1, Object o2) {
				if(o1 instanceof DataProperty){
					DataProperty p1 = (DataProperty)o1;
					DataProperty p2 = (DataProperty)o2;
					return p1.getOrder()-p2.getOrder();
				} else {
					DataReportProperty p1 = (DataReportProperty)o1;
					DataReportProperty p2 = (DataReportProperty)o2;
					return p1.getOrder()-p2.getOrder();
				}
			}
		});
	}
}
