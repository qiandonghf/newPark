package com.wiiy.crm.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.crm.entity.BillPlanRent;
import com.wiiy.crm.entity.SubjectRent;
import com.wiiy.crm.preferences.enums.BillPlanStatusEnum;
import com.wiiy.crm.preferences.enums.BillingMethodEnum;
import com.wiiy.crm.preferences.enums.PriceUnitEnum;
import com.wiiy.crm.preferences.enums.RentBillPlanEnum;
import com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum;
import com.wiiy.crm.service.BillPlanRentService;
import com.wiiy.crm.service.SubjectRentService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class BillPlanRentAction extends JqGridBaseAction<BillPlanRent>{
	
	private BillPlanRentService billPlanRentService;
	private SubjectRentService subjectRentService;
	private Result result;
	private BillPlanRent billPlanRent;
	private Long id;
	private String ids;
	private List<SubjectRent> subjectRentList;
	
	
	private RentBillPlanFeeEnum feeType;
	private RentBillPlanEnum rentBillPlan;
	private BillingMethodEnum billingMethod;
	private Date startDate;
	private Date endDate;
	private String memo;
	private Double roomArea;
	private Double rentPrice;
	private PriceUnitEnum rentPriceUnit;
	private Double managePrice;
	private PriceUnitEnum managePriceUnit;
	
	private String year;
	private String status;
	private String roomIds;
	
	public String batchCheckout(){
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean autoRemind = request.getParameter("autoRemind") != null;
		String types = request.getParameter("types");
		result = billPlanRentService.batchCheckout(ids,types.split(","),autoRemind);
		return JSON;
	}
	
	public String submitBillPlan(){
		SubjectRent subjectRent = subjectRentService.getBeanById(id).getValue();
		String[] startDates = ServletActionContext.getRequest().getParameterValues("startDates");
		String[] endDates = ServletActionContext.getRequest().getParameterValues("endDates");
		String[] planPayDates = ServletActionContext.getRequest().getParameterValues("planPayDates");
		String[] planFees = ServletActionContext.getRequest().getParameterValues("planFees");
		String[] realFees = ServletActionContext.getRequest().getParameterValues("realFees");
		String[] prices = ServletActionContext.getRequest().getParameterValues("prices");
		String[] amounts = ServletActionContext.getRequest().getParameterValues("amounts");
		List<BillPlanRent> billPlanRentList = new ArrayList<BillPlanRent>();
		for (int i = 0; i < planFees.length; i++) {
			BillPlanRent billPlanRent = new BillPlanRent();
			billPlanRent.setStartDate(DateUtil.parse(startDates[i]));
			billPlanRent.setEndDate(DateUtil.parse(endDates[i]));
			billPlanRent.setPlanPayDate(DateUtil.parse(planPayDates[i]));
			billPlanRent.setPlanFee(Double.valueOf(planFees[i]));
			
			billPlanRent.setPrice(prices[i]);
			billPlanRent.setAmount(Double.valueOf(amounts[i]));
			
			if(realFees[i]!=null && realFees[i].length()>0){
				billPlanRent.setRealFee(Double.valueOf(realFees[i]));
			}
			billPlanRent.setStatus(BillPlanStatusEnum.UNCHECK);
			billPlanRent.setFeeType(feeType);
			billPlanRent.setContractId(subjectRent.getContractId());
			billPlanRent.setMemo(memo);
			billPlanRent.setRoomId(subjectRent.getRoomId());
			billPlanRent.setRoomName(subjectRent.getRoomName());
			billPlanRent.setSubjectId(id);
			if(billPlanRent.getAutoCheck()==null) billPlanRent.setAutoCheck(BooleanEnum.NO);
			billPlanRentList.add(billPlanRent);
		}
		billPlanRentService.save(billPlanRentList);
		result = Result.success("保存成功");
		return JSON;
	}
	
	public String autoGenerate(){
		if(feeType.equals(RentBillPlanFeeEnum.RENT)){
			result = billPlanRentService.autoGenerate(feeType,rentBillPlan,billingMethod,startDate,endDate,roomArea,rentPrice,rentPriceUnit);
		} else {
			result = billPlanRentService.autoGenerate(feeType,rentBillPlan,billingMethod,startDate,endDate,roomArea,managePrice,managePriceUnit);
		}
		return "autoGenerate";
	}
	
	public String checkinById(){
		result = billPlanRentService.checkoutById(id, BillPlanStatusEnum.INCHECKED);
		return JSON;
	}
	public String checkoutById(){
		result = billPlanRentService.checkoutById(id, BillPlanStatusEnum.OUTCHECKED);
		return JSON;
	}
	
	public String add(){
		return "add";
	}
	
	public String save(){
		if(billPlanRent.getRoomId()!=null){
			List<SubjectRent> subjectRentList = subjectRentService.getListByFilter(new Filter(SubjectRent.class).eq("contractId", billPlanRent.getContractId())).getValue();
			for (SubjectRent subjectRent : subjectRentList) {
				if(Long.valueOf(billPlanRent.getRoomId())==Long.valueOf(subjectRent.getRoomId())){
					billPlanRent.setSubjectId(subjectRent.getId());
				}
			}
		}
		if(billPlanRent.getStatus()==null){
			billPlanRent.setStatus(BillPlanStatusEnum.UNCHECK);
		}
		if(billPlanRent.getAutoCheck()==null) billPlanRent.setAutoCheck(BooleanEnum.NO);
		result = billPlanRentService.save(billPlanRent);
		return JSON;
	}
	
	public String view(){
		result = billPlanRentService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		BillPlanRent billPlanRent = billPlanRentService.getBeanById(id).getValue();
		if(billPlanRent.getRoomId()!=null){
			List<SubjectRent> subjectRentList = subjectRentService.getListByFilter(new Filter(SubjectRent.class).eq("contractId", billPlanRent.getContractId())).getValue();
			for (SubjectRent subjectRent : subjectRentList) {
				if(Long.valueOf(billPlanRent.getRoomId())==Long.valueOf(subjectRent.getRoomId())){
					billPlanRent.setSubjectId(subjectRent.getId());
				}
			}
		}
		result = Result.value(billPlanRent);
		return EDIT;
	}
	
	public String update(){
		BillPlanRent dbBean = billPlanRentService.getBeanById(billPlanRent.getId()).getValue();
		BeanUtil.copyProperties(billPlanRent, dbBean);
		result = billPlanRentService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = billPlanRentService.deleteById(id);
		} else if(ids!=null){
			result = billPlanRentService.deleteByIds(ids);
		}
		return JSON;
	}
	public String listRendPredict(){
		Filter filter = new Filter(BillPlanRent.class).ne("status", BillPlanStatusEnum.CHARGEOFF);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date date = sdf.parse(year+"-01-01 00:00:00");
			Date latestDate = CalendarUtil.getLatest(date, Calendar.YEAR);
			filter.ge("planPayDate", date).le("planPayDate", latestDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if("YS".equals(status)){
			filter.ne("status", BillPlanStatusEnum.OUTCHECKED);
		}else if("WS".equals(status)){
			filter.eq("status", BillPlanStatusEnum.UNCHECK);
		}else if("SS".equals(status)){
			filter.ne("status", BillPlanStatusEnum.UNCHECK);
		}
		return refresh(filter);
	}
	
	public String list(){
		Filter filter = new Filter(BillPlanRent.class);
		filter.createAlias("contract", "contract");
		refresh(filter);
		return JSON;
	}
	
	@Override
	protected List<BillPlanRent> getListByFilter(Filter fitler) {
		return billPlanRentService.getListByFilter(fitler).getValue();
	}
	
	
	public BillPlanRent getBillPlanRent() {
		return billPlanRent;
	}

	public void setBillPlanRent(BillPlanRent billPlanRent) {
		this.billPlanRent = billPlanRent;
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

	public void setBillPlanRentService(BillPlanRentService billPlanRentService) {
		this.billPlanRentService = billPlanRentService;
	}
	
	public Result getResult() {
		return result;
	}

	public void setSubjectRentService(SubjectRentService subjectRentService) {
		this.subjectRentService = subjectRentService;
	}
	
	public List<SubjectRent> getSubjectRentList() {
		return subjectRentList;
	}

	public void setFeeType(RentBillPlanFeeEnum feeType) {
		this.feeType = feeType;
	}

	public void setRentBillPlan(RentBillPlanEnum rentBillPlan) {
		this.rentBillPlan = rentBillPlan;
	}

	public void setBillingMethod(BillingMethodEnum billingMethod) {
		this.billingMethod = billingMethod;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public void setRoomArea(Double roomArea) {
		this.roomArea = roomArea;
	}

	public void setRentPrice(Double rentPrice) {
		this.rentPrice = rentPrice;
	}

	public void setRentPriceUnit(PriceUnitEnum rentPriceUnit) {
		this.rentPriceUnit = rentPriceUnit;
	}

	public void setManagePrice(Double managePrice) {
		this.managePrice = managePrice;
	}

	public void setManagePriceUnit(PriceUnitEnum managePriceUnit) {
		this.managePriceUnit = managePriceUnit;
	}

	public RentBillPlanFeeEnum getFeeType() {
		return feeType;
	}

	public String getMemo() {
		return memo;
	}
	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getRoomIds() {
		return roomIds;
	}

	public void setRoomIds(String roomIds) {
		this.roomIds = roomIds;
	}

	public Date getStartDate() {
		return startDate;
	}

	public Date getEndDate() {
		return endDate;
	}
}
