package com.wiiy.crm.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.util.DateUtil;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.crm.dto.ContractStatisticDto;
import com.wiiy.crm.dto.StatisticDto;
import com.wiiy.crm.dto.StatisticGroupDto;
import com.wiiy.crm.service.StatisticService;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;

public class StatisticAction {
	
	private StatisticService statisticService;
	private Result<?> result;
	private Date startTime;//开始时间
	private Date endTime;//结束时间
	private Date time;//指定时间
	private String type;//汇总方式   日   月   年   企业
	
	private List<Integer> years;
	private Integer curYear;
	private Integer curMonth;
	
	private Integer startYear;
	private Integer endYear;
	private Integer startMonth;
	private Integer endMonth;
	
	private Long customerId;//用于查询企业
	private String customerName;
	
	private Pager pager;
	
	private String fileName;
	private InputStream inputStream;
	
	public String index(){
		return "index";
	}
	public String exportContract(){
		fileName = StringUtil.URLEncoderToUTF8("企业收费情况表")+".xls";
		List<ContractStatisticDto> dtoList = (List<ContractStatisticDto>) statisticService.customerContract(null).getValue();
		List<Object[]> dataList = new ArrayList<Object[]>();
		int rowIndex = 1;
		for (ContractStatisticDto dto : dtoList) {
			Object[] data = new Object[24];
			int i = 0;
			data[i++] = rowIndex++;
			data[i++] = dto.getContract().getContractNo();
			data[i++] = dto.getRooms();
			data[i++] = dto.getContract().getCustomerName();
			data[i++] = dto.getArea();
			data[i++] = dto.getRentPrice();
			data[i++] = dto.getEnergyPrice();
			data[i++] = dto.getRentTotal();
			data[i++] = dto.getEnergyTotal();
			data[i++] = dto.getFirstHalfYearTime();
			data[i++] = dto.getFirstHalfYearMoneyRent();
			data[i++] = dto.getFirstHalfYearMoneyEnergy();
			data[i++] = dto.getFirstHalfYearMoneyNet();
			data[i++] = dto.getSecondHalfYearTime();
			data[i++] = dto.getSecondHalfYearMoneyRent();
			data[i++] = dto.getSecondHalfYearMoneyEnergy();
			data[i++] = dto.getSecondHalfYearMoneyNet();
			data[i++] = dto.getDeposit();
			data[i++] = dto.getContract().getPolicy();
			data[i++] = DateUtil.format(dto.getContract().getStartDate())+"-"+DateUtil.format(dto.getContract().getEndDate());
			data[i++] = dto.getManager();
			data[i++] = dto.getManagerPhone();
			data[i++] = dto.getContract().getReceiveDate();
			data[i++] = "";
			dataList.add(data);
		}
		try {
			InputStream is = PbActivator.getURL("doc/ContractStatistic.xls").openStream();
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			POIUtil.export(is, 2, dataList, out);
			inputStream = new ByteArrayInputStream(out.toByteArray());
		} catch (Exception e) {
		}
		return "export";
	}
	public String customerContract(){
		pager = new Pager(1, 15);
		String page = ServletActionContext.getRequest().getParameter("page");
		if(page!=null) pager.setPage(Integer.parseInt(page));
		result = statisticService.customerContract(pager);
		ServletActionContext.getRequest().setAttribute("pager", pager);
		return "customerContract";
	}
	public String propertyRight(){
		result = statisticService.propertyRight();
		return "propertyRight";
	}
	public String customerStaffer(){
		result = statisticService.customerStaffer();
		return "customerStaffer";
	}
	public String registeredCapital(){
		result = statisticService.registeredCapital();
		return "registeredCapital";
	}
	public String productTechnic(){
		result = statisticService.productTechnic();
		return "productTechnic";
	}
	public String customerLabel(){
		result = statisticService.customerLabel();
		return "customerLabel";
	}
	public String customerParkStatus(){
		result = statisticService.customerParkStatus();
		return "customerParkStatus";
	}
	public String customerIncubationStatus(){
		result = statisticService.customerIncubationStatus();
		return "customerIncubationStatus";
	}
	public String customerTechnic(){
		result = statisticService.customerTechnic();
		return "customerTechnic";
	}
	//日结算汇总
	public String billCostByDay(){
		result = statisticService.billCost(startTime, endTime, time, type);
		ServletActionContext.getRequest().setAttribute("startTime", startTime);
		ServletActionContext.getRequest().setAttribute("endTime", endTime);
		return "billCostByDay";
	}
	/*public String billCostByMonth(){
		curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		years = new ArrayList<Integer>();
		for(int n=(curYear-15);n<(curYear+5);n++){
			years.add(n);
		}
		if(type!=null){
			type = type + "-10";
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
			try {
				time = fmt.parse(type);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			curYear = Integer.parseInt(DateUtil.format(time,"yyyy"));
		}
		List<StatisticGroupDto> topGroupList = (List<StatisticGroupDto>) statisticService.billCostByTime(time, "month").getValue();
		List<StatisticGroupDto> topTotalGroupList = (List<StatisticGroupDto>) statisticService.billCostByTime(time, "year").getValue();
		Map<Long,String> map = new HashMap<Long,String>();
		for (StatisticGroupDto top : topGroupList) {
			for (StatisticGroupDto group : top.getGroups()) {
				if(!map.containsKey(group.getLid())){
					map.put(group.getLid(), group.getName());
				}
			}
		}
		result = Result.value(topGroupList);
		ServletActionContext.getRequest().setAttribute("mapValues", map.values());
		ServletActionContext.getRequest().setAttribute("mapSize", map.values().size());
		ServletActionContext.getRequest().setAttribute("topTotalGroupList", topTotalGroupList);
		return "billCostByMonth";
	}*/
	//月结算汇总
	@SuppressWarnings("unchecked")
	public String billCostByMonth(){
		curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		startYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		endYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		startMonth = Integer.parseInt(DateUtil.format(new Date(),"MM"));
		endMonth = Integer.parseInt(DateUtil.format(new Date(),"MM"));
		
		years = new ArrayList<Integer>();
		for(int n=(curYear-15);n<(curYear+5);n++){
			years.add(n);
		}
		
		List<StatisticGroupDto> topGroupList = new ArrayList<StatisticGroupDto>();
		List<StatisticGroupDto> topTotalGroupList = new ArrayList<StatisticGroupDto>();
		if(startTime!=null && endTime !=null){
			startYear = Integer.parseInt(DateUtil.format(startTime,"yyyy"));
			endYear = Integer.parseInt(DateUtil.format(endTime,"yyyy"));
			startMonth = Integer.parseInt(DateUtil.format(startTime,"MM"));
			endMonth = Integer.parseInt(DateUtil.format(endTime,"MM"));
			topGroupList = (List<StatisticGroupDto>) statisticService.billCostByMonth(startTime,endTime,"month").getValue();
			topTotalGroupList = (List<StatisticGroupDto>) statisticService.billCostByMonth(startTime,endTime, "year").getValue();
		}else{
			topGroupList = (List<StatisticGroupDto>) statisticService.billCostByTime(time, "month").getValue();
			topTotalGroupList = (List<StatisticGroupDto>) statisticService.billCostByTime(time, "year").getValue();
		}
		Map<Long,String> map = new HashMap<Long,String>();
		for (StatisticGroupDto top : topGroupList) {
			for (StatisticGroupDto group : top.getGroups()) {
				if(!map.containsKey(group.getLid())){
					map.put(group.getLid(), group.getName());
				}
			}
		}
		result = Result.value(topGroupList);
		ServletActionContext.getRequest().setAttribute("mapValues", map.values());
		ServletActionContext.getRequest().setAttribute("mapSize", map.values().size());
		ServletActionContext.getRequest().setAttribute("topTotalGroupList", topTotalGroupList);
		return "billCostByMonth";
	}
	//年结算汇总
	@SuppressWarnings("unchecked")
	public String billCostByYear(){
		List<StatisticGroupDto> topGroupList = (List<StatisticGroupDto>) statisticService.billCostByTime(time, "year").getValue();
		List<StatisticDto> yearCountList = (List<StatisticDto>) statisticService.billCostYearCount().getValue();
		Map<Long,String> map = new HashMap<Long,String>();
		for (StatisticGroupDto top : topGroupList) {
			for (StatisticGroupDto group : top.getGroups()) {
				if(!map.containsKey(group.getLid())){
					map.put(group.getLid(), group.getName());
				}
			}
		}
		result = Result.value(topGroupList);
		ServletActionContext.getRequest().setAttribute("mapValues", map.values());
		ServletActionContext.getRequest().setAttribute("mapSize", map.values().size());
		ServletActionContext.getRequest().setAttribute("yearCountList", yearCountList);
		return "billCostByYear";
	}
	//分户明细汇总
	@SuppressWarnings("unchecked")
	public String billCostByCustomer(){
		List<StatisticGroupDto> topGroupList = (List<StatisticGroupDto>) statisticService.billCostByCustomer(customerId,startTime,endTime).getValue();
		Map<Long,String> map = new HashMap<Long,String>();
		for (StatisticGroupDto top : topGroupList) {
			for (StatisticGroupDto group : top.getGroups()) {
				if(!map.containsKey(group.getLid())){
					map.put(group.getLid(), group.getName());
				}
			}
		}
		result = Result.value(topGroupList);
		ServletActionContext.getRequest().setAttribute("mapValues", map.values());
		ServletActionContext.getRequest().setAttribute("mapSize", map.values().size());
		ServletActionContext.getRequest().setAttribute("customerId", customerId);
		if(customerName!=null){
			try {
				customerName = new String(customerName.getBytes("ISO8859_1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			ServletActionContext.getRequest().setAttribute("customerName", customerName);
		}
		ServletActionContext.getRequest().setAttribute("startTime", startTime);
		ServletActionContext.getRequest().setAttribute("endTime", endTime);
		return "billCostByCustomer";
	}
	//物业应收未收统计
	@SuppressWarnings("unchecked")
	public String billWzubCostByProperty(){
		List<StatisticGroupDto> topGroupList = (List<StatisticGroupDto>) statisticService.billWzubCostByProperty(startTime,endTime).getValue();
		Map<Long,String> map = new HashMap<Long,String>();
		for (StatisticGroupDto top : topGroupList) {
			for (StatisticGroupDto group : top.getGroups()) {
				if(!map.containsKey(group.getLid())){
					map.put(group.getLid(), group.getName());
				}
			}
		}
		result = Result.value(topGroupList);
		ServletActionContext.getRequest().setAttribute("mapValues", map.values());
		ServletActionContext.getRequest().setAttribute("result", result);
		ServletActionContext.getRequest().setAttribute("startTime", startTime);
		ServletActionContext.getRequest().setAttribute("endTime", endTime);
		return "billWzubCostByProperty";
	}
	//物业应收实收统计
	@SuppressWarnings("unchecked")
	public String billCostByProperty(){
		List<StatisticGroupDto> topGroupList = (List<StatisticGroupDto>) statisticService.billCostByProperty(startTime,endTime).getValue();
		Map<Long,String> map = new HashMap<Long,String>();
		for (StatisticGroupDto top : topGroupList) {
			for (StatisticGroupDto group : top.getGroups()) {
				if(!map.containsKey(group.getLid())){
					map.put(group.getLid(), group.getName());
				}
			}
		}
		result = Result.value(topGroupList);
		ServletActionContext.getRequest().setAttribute("mapValues", map.values());
		ServletActionContext.getRequest().setAttribute("result", result);
		ServletActionContext.getRequest().setAttribute("startTime", startTime);
		ServletActionContext.getRequest().setAttribute("endTime", endTime);
		return "billCostByProperty";
	}
	
	public Result<?> getResult() {
		return result;
	}

	public void setStatisticService(StatisticService statisticService) {
		this.statisticService = statisticService;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public List<Integer> getYears() {
		return years;
	}
	public void setYears(List<Integer> years) {
		this.years = years;
	}
	public Integer getCurYear() {
		return curYear;
	}
	public void setCurYear(Integer curYear) {
		this.curYear = curYear;
	}
	public Long getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}
	public InputStream getInputStream() {
		return inputStream;
	}
	public String getFileName() {
		return fileName;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public Integer getStartYear() {
		return startYear;
	}
	public void setStartYear(Integer startYear) {
		this.startYear = startYear;
	}
	public Integer getEndYear() {
		return endYear;
	}
	public void setEndYear(Integer endYear) {
		this.endYear = endYear;
	}
	public Integer getStartMonth() {
		return startMonth;
	}
	public void setStartMonth(Integer startMonth) {
		this.startMonth = startMonth;
	}
	public Integer getEndMonth() {
		return endMonth;
	}
	public void setEndMonth(Integer endMonth) {
		this.endMonth = endMonth;
	}
	public Integer getCurMonth() {
		return curMonth;
	}
	public void setCurMonth(Integer curMonth) {
		this.curMonth = curMonth;
	}
}
