package com.wiiy.crm.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.crm.dto.AnalyseDto;
import com.wiiy.crm.dto.DataReportDto;
import com.wiiy.crm.dto.ParkLogDto;
import com.wiiy.crm.dto.TreeDto;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.DataReport;
import com.wiiy.crm.entity.DataReportGroup;
import com.wiiy.crm.entity.DataReportToCustomer;
import com.wiiy.crm.entity.DataTemplate;
import com.wiiy.crm.entity.ParkLog;
import com.wiiy.crm.preferences.enums.CustomerReportStatusEnum;
import com.wiiy.crm.preferences.enums.ReportStatusEnum;
import com.wiiy.crm.service.DataReportGroupService;
import com.wiiy.crm.service.DataReportService;
import com.wiiy.crm.service.DataReportToCustomerService;
import com.wiiy.crm.service.DataTemplateService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.service.ParkLogService;

/**
 * @author my
 */
public class DataReportAction extends JqGridBaseAction<DataReport>{
	
	private DataReportService dataReportService;
	private DataReportGroupService dataReportGroupService;
	private DataTemplateService dataTemplateService;
	private DataReportToCustomerService dataReportToCustomerService;
	private Result result;
	private DataReport dataReport;
	private Long id;
	private Long groupId;
	private String msg;
	private String ids;
	private List<Customer> customerList;
	private List<DataTemplate> dataTemplateList;
	private List<DataReport> dataReportList;
	private List<DataReportGroup> dataReportGroupList;
	
	private int finishCount;
	private int unFinishCount;
	
	private Long cId;
	private List<Integer> yearList;
	private List<Integer> monthList;
	private String propertyName;
	private String time;
	private Long propertyId;
	private Long templateId;
	private ParkLogService parkLogService ;
	private List<ParkLog> list ;
	
	private List<ParkLogDto> parkLogList;
	
	public void setParkLogService(ParkLogService parkLogService) {
		this.parkLogService = parkLogService;
	}
	public void setList(List<ParkLog> list) {
		this.list = list;
	}
	public List<ParkLog> getList() {
		return list;
	}
	public void setParkLogList(List<ParkLogDto> parkLogList) {
		this.parkLogList = parkLogList;
	}
	public List<ParkLogDto> getParkLogList() {
		return parkLogList;
	}
	
	public String getParkLog(){
		parkLogList = new ArrayList<ParkLogDto>() ;
		List<ParkLog> list = parkLogService.getListByFilter(new Filter(ParkLog.class).orderBy("createTime", Filter.DESC)).getValue() ;
		for (int i = 0; i < list.size(); i++) {
			ParkLog parkLog = list.get(i);
			ParkLogDto dto = new ParkLogDto() ;
			dto.setId(parkLog.getId());
			dto.setLogTime(parkLog.getCreateTime());
			dto.setLogType(parkLog.getParkLogType().getTitle());
			dto.setLogData("");
			dto.setLogCustormer(parkLog.getContent());
			parkLogList.add(dto);
			if (i >11) {
				break ;
			}
		}
		//parkLogList = dataReportService.getParkLog();
		return JSON;
	}
	public String getParkLogAll(){
		return refresh(new Filter(ParkLog.class).orderBy("createTime", Filter.DESC)) ;
	}
	public String loadReport(){
		result = dataReportService.getListByFilter(new Filter(DataReport.class).eq("groupId", id));
		return "rvalue";
	}
	public String loadReportGroup(){
		result = dataReportGroupService.getList();
		return "rvalue";
	}
	public String loadGroup(){
		dataReportGroupList = dataReportGroupService.getList().getValue();
		List<TreeDto> dtoList = new ArrayList<TreeDto>();
		for (DataReportGroup group : dataReportGroupList) {
			TreeDto dto = new TreeDto();
			dto.setId(group.getId());
			dto.setText(group.getName()+"<input type='hidden' value='"+group.getId()+"'>");
			dto.setState(TreeDto.CLOSED);
			dtoList.add(dto);
		}
		result = Result.value(dtoList);
		return "rvalue";
	}
	
	public String loadReportByGroupId(){
		dataReportList = dataReportService.getListByFilter(new Filter(DataReport.class).eq("groupId", id)).getValue();
		List<TreeDto> dtoList = new ArrayList<TreeDto>();
		for (DataReport report : dataReportList) {
			TreeDto dto = new TreeDto();
			dto.setId(report.getId());
			dto.setText(report.getName()+"<input type='hidden' value='"+report.getId()+"'>");
			dto.setState(TreeDto.OPEN);
			dtoList.add(dto);
		}
		result = Result.value(dtoList);
		return "rvalue";
	}
	
	public String count(){
		result = dataReportService.count(id);
		return "count";
	}
	
	public String open(){
		result = dataReportService.open(id);
		return JSON;
	}
	
	public String close(){
		result = dataReportService.close(id);
		msg = result.getMsg();
		return JSON;
	}
	
	public String addCustomer(){
		result = dataReportService.addCustomer(id,ids);
		msg = result.getMsg();
		return JSON;
	}
	
	public String publish(){
		result = dataReportService.publish(id,ids);
		msg = result.getMsg();
		return JSON;
	}
	
	public String add(){
		dataTemplateList = dataTemplateService.getList().getValue();
		dataReportGroupList = dataReportGroupService.getList().getValue();
		return "add";
	}
	
	public String save(){
		dataReport.setStatus(ReportStatusEnum.UNPUB);
		result = dataReportService.save(dataReport);
		msg = result.getMsg();
		id= ((DataReport)result.getValue()).getId();
		groupId = ((DataReport)result.getValue()).getGroupId();
		return JSON;
	}
	
	public String view(){
		result = dataReportService.getBeanById(id);
		finishCount = dataReportToCustomerService.countByFilter(new Filter(DataReportToCustomer.class).eq("status",CustomerReportStatusEnum.PUB).eq("reportId",id)).getValue();
		unFinishCount = dataReportToCustomerService.countByFilter(new Filter(DataReportToCustomer.class).ne("status",CustomerReportStatusEnum.PUB).eq("reportId",id)).getValue();
		return VIEW;
	}
	
	public String viewByCustomerId(){
		if(ids!=null){
			id = Long.parseLong(ids.split(",")[0]);
			cId = Long.parseLong(ids.split(",")[1]);
		}
		result = dataReportService.getBeanById(id);
		ServletActionContext.getRequest().setAttribute("cId", cId);
		
		dataTemplateList = dataTemplateService.getList().getValue();
		yearList = new ArrayList<Integer>();
		monthList = new ArrayList<Integer>();
		Integer curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		for(int i = curYear-10;i<curYear+4;i++){
			yearList.add(i);
		}
		for(int j=1;j<13;j++){
			monthList.add(j);
		}
		Integer cYear = Integer.parseInt(DateUtil.format(new Date(), "yyyy"));
		ServletActionContext.getRequest().setAttribute("cYear", cYear);
		return "viewByCustomerId";
	}
	
	public String countData(){
		String[] t = time.split(":");
		AnalyseDto dto = new AnalyseDto();
		dto.setsYear(Integer.parseInt(t[0]));
		dto.setsMonth(Integer.parseInt(t[1]));
		dto.seteYear(Integer.parseInt(t[2]));
		dto.seteMonth(Integer.parseInt(t[3]));
		dto.setPropertyId(propertyId);
		dto.setTemplateId(templateId);
		ServletActionContext.getRequest().setAttribute("dto", dto);
		
		dataTemplateList = dataTemplateService.getList().getValue();
		yearList = new ArrayList<Integer>();
		monthList = new ArrayList<Integer>();
		Integer curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		for(int i = curYear-10;i<curYear+4;i++){
			yearList.add(i);
		}
		for(int j=1;j<13;j++){
			monthList.add(j);
		}
		return "customerView";
	}
	
	public String listByCustomerId(){
		if(ids!=null){
			id = Long.parseLong(ids.split(",")[0]);
			cId = Long.parseLong(ids.split(",")[1]);
		}
		Filter filter = new Filter(DataReportToCustomer.class);
		filter.eq("reportId", id);
		filter.eq("customerId", cId);
		filter.createAlias("customer", "customer");
		return refresh(filter);
	}
	
	public String edit(){
		DataReport dbBean = dataReportService.getBeanById(id).getValue();
		customerList = dataReportToCustomerService.getCustomerListByReportId(id).getValue();
		dataTemplateList = dataTemplateService.getList().getValue();
		result = Result.value(dbBean);
		if(dbBean.getStatus().equals(ReportStatusEnum.UNPUB))
			return EDIT;
		else if(dbBean.getStatus().equals(ReportStatusEnum.PUBED)){
			return "editSimple";
		} else return null;
	}
	
	public String update(){
		DataReport dbBean = dataReportService.getBeanById(dataReport.getId()).getValue();
		BeanUtil.copyProperties(dataReport, dbBean);
		result = dataReportService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = dataReportService.deleteById(id);
		} else if(ids!=null){
			result = dataReportService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		dataReportList = dataReportService.getList().getValue();
		dataReportGroupList = dataReportGroupService.getList().getValue();
		return LIST;
	}
	
	@Override
	protected List<DataReport> getListByFilter(Filter fitler) {
		return dataReportService.getListByFilter(fitler).getValue();
	}
	
	
	public DataReport getDataReport() {
		return dataReport;
	}

	public void setDataReportDef(DataReport dataReport) {
		this.dataReport = dataReport;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public void setDataReportService(DataReportService dataReportService) {
		this.dataReportService = dataReportService;
	}
	
	public Result getResult() {
		return result;
	}

	public void setDataTemplateService(DataTemplateService dataTemplateService) {
		this.dataTemplateService = dataTemplateService;
	}

	public void setDataReportToCustomerService(
			DataReportToCustomerService dataReportToCustomerService) {
		this.dataReportToCustomerService = dataReportToCustomerService;
	}

	public List<Customer> getCustomerList() {
		return customerList;
	}

	public List<DataTemplate> getDataTemplateList() {
		return dataTemplateList;
	}
	public int getFinishCount() {
		return finishCount;
	}

	public int getUnFinishCount() {
		return unFinishCount;
	}

	public void setDataReportGroupService(
			DataReportGroupService dataReportGroupService) {
		this.dataReportGroupService = dataReportGroupService;
	}

	public List<DataReport> getDataReportList() {
		return dataReportList;
	}

	public List<DataReportGroup> getDataReportGroupList() {
		return dataReportGroupList;
	}

	public void setDataReport(DataReport dataReport) {
		this.dataReport = dataReport;
	}
	public Long getcId() {
		return cId;
	}
	public void setcId(Long cId) {
		this.cId = cId;
	}
	public List<Integer> getYearList() {
		return yearList;
	}
	public void setYearList(List<Integer> yearList) {
		this.yearList = yearList;
	}
	public List<Integer> getMonthList() {
		return monthList;
	}
	public void setMonthList(List<Integer> monthList) {
		this.monthList = monthList;
	}
	public String getPropertyName() {
		return propertyName;
	}
	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public Long getPropertyId() {
		return propertyId;
	}
	public void setPropertyId(Long propertyId) {
		this.propertyId = propertyId;
	}
	public Long getTemplateId() {
		return templateId;
	}
	public void setTemplateId(Long templateId) {
		this.templateId = templateId;
	}
	public Long getGroupId() {
		return groupId;
	}
	public void setGroupId(Long groupId) {
		this.groupId = groupId;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
}
