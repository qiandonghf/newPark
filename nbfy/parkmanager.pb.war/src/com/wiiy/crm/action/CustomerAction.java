package com.wiiy.crm.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.entity.User;
import com.wiiy.core.service.export.DataDictInitService;
import com.wiiy.core.service.export.OsgiUserService;
import com.wiiy.crm.dto.TreeDto;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerCategory;
import com.wiiy.crm.entity.CustomerInfo;
import com.wiiy.crm.entity.CustomerLabel;
import com.wiiy.crm.entity.CustomerLabelRef;
import com.wiiy.crm.entity.CustomerQualification;
import com.wiiy.crm.entity.CustomerVentureType;
import com.wiiy.crm.entity.IncubationInfo;
import com.wiiy.crm.entity.IncubationRoute;
import com.wiiy.crm.preferences.enums.OwnerEnum;
import com.wiiy.crm.preferences.enums.ParkStatusEnum;
import com.wiiy.crm.service.CustomerCategoryService;
import com.wiiy.crm.service.CustomerLabelService;
import com.wiiy.crm.service.CustomerQualificationService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.crm.service.CustomerVentureTypeService;
import com.wiiy.crm.service.IncubationRouteService;
import com.wiiy.crm.service.StatisticService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class CustomerAction extends JqGridBaseAction<Customer>{
	
	private CustomerService customerService;
	private CustomerCategoryService customerCategoryService;
	private CustomerLabelService customerLabelService;
	private StatisticService statisticService;
	private IncubationRouteService incubationRouteService;
	private CustomerQualificationService customerQualificationService;
	private CustomerVentureTypeService customerVentureTypeService;
	private Result result;
	private List<CustomerCategory> customerCategoryList;
	private List<CustomerLabel> customerLabelList;
	private List<CustomerLabel> myLabelList;
	private List<Customer> customerList;
	private List<DataDict> incubationRouteList;
	private List<DataDict> customerQualificationList;
	private List<IncubationRoute> incubationRoutes;
	private List<CustomerQualification> customerQualifications;
	private Customer customer;
	private CustomerInfo customerInfo;
	private IncubationInfo incubationInfo;
	private Long id;
	private Long labelId;
	private String routeId;
	private String ids;
	
	private String excelName;
	private InputStream inputStream;
	private String columns;
	
	private String username;
	private String password;
	
	private String status;
	private String customerIds;
	
	private boolean desktop;
	
	public String workBenchCustomerEdit(){
		List<CustomerVentureType> typeList = customerVentureTypeService.getListByFilter(new Filter(CustomerVentureType.class).eq("customerId", id)).getValue();
		StringBuilder sb = new StringBuilder();
		if(typeList!=null && typeList.size()>0){
			for(CustomerVentureType it : typeList){
				sb.append(it.getVentureTypeId()).append(",");  
			}
			if(sb.toString().endsWith(","))sb.deleteCharAt(sb.length()-1);
		}
		ServletActionContext.getRequest().setAttribute("typeIds", sb.toString());
		incubationRoutes = incubationRouteService.getListByFilter(new Filter(IncubationRoute.class).eq("customerId", id)).getValue();
		customerQualifications = customerQualificationService.getListByFilter(new Filter(CustomerQualification.class).eq("customerId", id)).getValue();
		customer = customerService.getBeanByFilter(new Filter(Customer.class).eq("id", id).fetchMode("labelRefs", Filter.JOIN)).getValue();
		result = Result.value(customer);
		return "workBenchCustomerEdit";
	}
	
	public String workBenchCustomerList(){
		result = customerService.getListByHql("select new Customer(c.id,c.name,c.parkStatus) from Customer c where c.parkStatus != '"+ParkStatusEnum.APPLY+"' and c.time > '"+DateUtil.format(CalendarUtil.add(Calendar.DAY_OF_MONTH, -30).getTime())+"'");
		return JSON;
	}
	
	public String initRZKH(){
		result = customerService.getListByLimitNum(6);
		
		return JSON;
	}
	
	public String add(){
		incubationRouteList = new ArrayList<DataDict>();
		customerQualificationList = new ArrayList<DataDict>();
		DataDictInitService dataDictInitService = PbActivator.getDataDictInitService();
		if(dataDictInitService!=null){
			incubationRouteList = dataDictInitService.getDataDictByParentId("crm.0025");
			customerQualificationList = dataDictInitService.getDataDictByParentId("crm.0027");
		}
		return "add";
	}
	
	public String parkStatusGraph(){
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("width", request.getParameter("width"));
		result = statisticService.customerParkStatus();
		return "parkStatusGraph";
	}
	
	public String importCard(){
		result = customerService.importCard(ids);
		return JSON;
	}
	
	public String configAccount(){
		return "configAccount";
	}
	
	public String saveAccount(){
		result = customerService.saveAccount(id,username,password);
		return JSON;
	}
	
	public String updatePassword(){
		OsgiUserService userService = PbActivator.getService(OsgiUserService.class);
		result = Result.value(userService.getById(id));
		return "updatePassword";
	}
	
	public String updateAccountPassword(){
		result = customerService.updateAccountPassword(id,password);
		return JSON;
	}
	
	public String loadCategory(){
		Filter filter = new Filter(CustomerCategory.class);
		filter.or(Filter.Eq("ownerId", PbActivator.getSessionUser().getId()),Filter.Eq("ownerEnum", OwnerEnum.PUBLIC));
		customerCategoryList = customerCategoryService.getListByFilter(filter).getValue();
		List<TreeDto> dtoList = new ArrayList<TreeDto>();
		TreeDto allCustomerDto = new TreeDto();
		allCustomerDto.setId(-1l);
		allCustomerDto.setText("所有企业");
		dtoList.add(allCustomerDto);
		
		TreeDto incubatorRoteDto = new TreeDto();
		incubatorRoteDto.setId(-2l);
		incubatorRoteDto.setText("孵化状态分组");
		incubatorRoteDto.setState(TreeDto.CLOSED);
		dtoList.add(incubatorRoteDto);
		
		for (CustomerCategory category : customerCategoryList) {
			TreeDto dto = new TreeDto();
			dto.setId(category.getId());
			dto.setText(category.getName()+"<input type='hidden' value='"+category.getId()+"'>");
			dto.setState(TreeDto.CLOSED);
			dtoList.add(dto);
		}
		TreeDto myLabelDto = new TreeDto();
		myLabelDto.setId(0l);
		myLabelDto.setText("我的分组");
		myLabelDto.setState(TreeDto.CLOSED);
		dtoList.add(myLabelDto);
		result = Result.value(dtoList);
		return "rvalue";
	}
	
	public String loadIncubatorRote(){
		List<TreeDto> dtoList = new ArrayList<TreeDto>();
		List<DataDict> list = PbActivator.getDataDictInitService().getDataDictByParentId("crm.0025");
		for (DataDict dataDict : list) {
			TreeDto dto = new TreeDto();
			dto.setId(-2L);
			dto.setText(dataDict.getDataValue()+"<input type='hidden' value='"+dataDict.getId()+"'>");
			dtoList.add(dto);
		}
		result = Result.value(dtoList);
		return "rvalue";
	}
	
	public String loadLabelByCategoryId(){
		Filter filter = new Filter(CustomerLabel.class);
		System.out.println(id);
		if(id!=0){
			filter.eq("categoryId", id);
		} else {
			filter.eq("ownerEnum",OwnerEnum.PRIVATE).eq("ownerId", PbActivator.getSessionUser().getId());
		}
		customerLabelList = customerLabelService.getListByFilter(filter).getValue();
		List<TreeDto> dtoList = new ArrayList<TreeDto>();
		for (CustomerLabel category : customerLabelList) {
			TreeDto dto = new TreeDto();
			dto.setId(category.getId());
			dto.setText(category.getName()+"<input type='hidden' value='"+category.getId()+"'>");
			dto.setState(TreeDto.OPEN);
			dtoList.add(dto);
		}
		result = Result.value(dtoList);
		return "rvalue";
	}
	
	public String loadMyLabel(){
		Filter filter = new Filter(CustomerLabel.class);
		filter.eq("ownerEnum",OwnerEnum.PRIVATE).eq("ownerId", PbActivator.getSessionUser().getId());
		customerLabelList = customerLabelService.getListByFilter(filter).getValue();
		List<TreeDto> dtoList = new ArrayList<TreeDto>();
		for (CustomerLabel category : customerLabelList) {
			TreeDto dto = new TreeDto();
			dto.setId(category.getId());
			dto.setText(category.getName());
			dto.setState(TreeDto.OPEN);
			dtoList.add(dto);
		}
		result = Result.value(dtoList);
		return "rvalue";
	}
	
	public String export(){
		Filter filter = new Filter(Customer.class);
		filter.createAlias("customerInfo", "customerInfo");
		filter.createAlias("incubationInfo", "incubationInfo");
		if(filters!=null && filters.indexOf("incubationInfoStatusRoute.")>-1){
			filter.createAlias("incubationInfo.status", "incubationInfoStatus");
			filter.createAlias("incubationInfoStatus.route", "incubationInfoStatusRoute");
		}
		if(labelId!=null){
			filter.createAlias("labelRefs", "labelRef");
			filter.eq("labelRef.labelId", labelId);
		}
		page=0;//不要分页
		refresh(filter);
		excelName = StringUtil.URLEncoderToUTF8("企业列表")+".xls";
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		POIUtil.export("企业列表", generateExportColumns(columns), root, out);
		inputStream = new ByteArrayInputStream(out.toByteArray());
		return "export";
	}
	
	private LinkedHashMap<String, String> generateExportColumns(String columns){
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		columns = columns.replace("{", "");
		columns = columns.replace("}", "");
		String[] properties = columns.split(",");
		for (String string : properties) {
			String[] ss = string.split(":");
			String field = ss[0].replace("\"", "");
			String description = ss[1].replace("\"", "");
			map.put(field, description);
		}
		return map;
	}
	
	public String multiSelect(){
		select();
		customerList = customerService.getListByFilter(new Filter(Customer.class).include("id").include("name")).getValue();
		return "multiSelect";
	}
	
	public String select(){
		Filter filter = new Filter(CustomerCategory.class);
		filter.or(Filter.Eq("ownerId", PbActivator.getSessionUser().getId()),Filter.Eq("ownerEnum", OwnerEnum.PUBLIC));
		customerCategoryList = customerCategoryService.getListByFilter(filter).getValue();
		customerLabelList = customerLabelService.getList().getValue();
		myLabelList = customerLabelService.getListByFilter(new Filter(CustomerLabel.class).eq("ownerEnum",OwnerEnum.PRIVATE).eq("ownerId", PbActivator.getSessionUser().getId())).getValue();
		return SELECT;
	}
	
	public String generateCode(){
		result = customerService.generateCode();
		return JSON;
	}
	
	public String save(){
		List<Customer> list = customerService.getListByFilter(new Filter(Customer.class).eq("name", customer.getName())).getValue();
		if(list!=null && list.size()>0){
			result = Result.failure("企业名称不能重复");
			return JSON;
		}
		if(customerInfo==null)customerInfo = new CustomerInfo();
		else{
			if(customerInfo.getRegTypeId().equals(""))customerInfo.setRegTypeId(null);
			if(customerInfo.getDocumentTypeId().equals(""))customerInfo.setDocumentTypeId(null);
			if(customerInfo.getCurrencyTypeId().equals(""))customerInfo.setCurrencyTypeId(null);
		}
		if(incubationInfo==null)incubationInfo = new IncubationInfo();
		String[] enterpriseTypeIds = ServletActionContext.getRequest().getParameterValues("enterpriseTypeId");
		String[] incubationRouteIds = ServletActionContext.getRequest().getParameterValues("incubationRouteId");
		String[] incubationRouteTimes = ServletActionContext.getRequest().getParameterValues("incubationRouteTime");
		String[] customerQualificationIds = ServletActionContext.getRequest().getParameterValues("customerQualificationId");
		String[] custimerQualificationTimes = ServletActionContext.getRequest().getParameterValues("custimerQualificationTime");
		result = customerService.save(customer,customerInfo,incubationInfo,ids,incubationRouteIds,incubationRouteTimes,customerQualificationIds,custimerQualificationTimes,enterpriseTypeIds);
		return JSON;
	}
	
	public String simpleView(){
		customer = customerService.getBeanById(id).getValue();
		result = Result.value(customer);
		loadCustoemrOtherInfo();
		return "simpleView";
	}
	
	private void loadCustoemrOtherInfo(){
		OsgiUserService userService = PbActivator.getService(OsgiUserService.class);
		if(customer.getUserId()!=null){
			User user = userService.getById(customer.getUserId());
			ServletActionContext.getRequest().setAttribute("user", user);
		}
	}
	
	public String view(){
		if(id==null){                                    //id为空说明是企业帐号查看。
			customer = customerService.getSessionUserCustomer().getValue();
			if(customer==null){
				return VIEW;
			}else{
				if(customer.getLabelRefs()!=null){
					Iterator<CustomerLabelRef> it = customer.getLabelRefs().iterator();
					while (it.hasNext()) {
						CustomerLabelRef ref = it.next();
						CustomerLabel label = ref.getCustomerLabel();
						if(label.getOwnerEnum().equals(OwnerEnum.PRIVATE) && label.getOwnerId().longValue() != PbActivator.getSessionUser().getId().longValue()){
							it.remove();
						}
					}
				}
				incubationRoutes = incubationRouteService.getListByFilter(new Filter(IncubationRoute.class).eq("customerId", customer.getId())).getValue();
				customerQualifications = customerQualificationService.getListByFilter(new Filter(CustomerQualification.class).eq("customerId", customer.getId())).getValue();
				result = Result.value(customer);
				loadCustoemrOtherInfo();
				if(PbActivator.getHttpSessionService().isInResourceMap("ps_customerMessage_basicView")){
					return "customerView";
				}else if(PbActivator.getHttpSessionService().isInResourceMap("ps_linkman")){
					return "customerLinkman";
				}else if(PbActivator.getHttpSessionService().isInResourceMap("ps_contectInfo")){
					return "customerContectInfo";
				}else if(PbActivator.getHttpSessionService().isInResourceMap("ps_customer_investmentView")){
					return "customerInvestmentView";
				}else if(PbActivator.getHttpSessionService().isInResourceMap("ps_staffer")){
					return "customerStaffer";
				}else if(PbActivator.getHttpSessionService().isInResourceMap("ps_knowledge")){
					return "customerKnowledge";
				}else if(PbActivator.getHttpSessionService().isInResourceMap("ps_dataFill")){
					return "customerDataFill";
				}else {
					return "error";
				}
			}
		} else {
			customer = customerService.getBeanByFilter(new Filter(Customer.class).eq("id", id).fetchMode("labelRefs", Filter.JOIN)).getValue();
		}
		if(customer.getLabelRefs()!=null){
			Iterator<CustomerLabelRef> it = customer.getLabelRefs().iterator();
			while (it.hasNext()) {
				CustomerLabelRef ref = it.next();
				CustomerLabel label = ref.getCustomerLabel();
				if(label.getOwnerEnum().equals(OwnerEnum.PRIVATE) && label.getOwnerId().longValue() != PbActivator.getSessionUser().getId().longValue()){
					it.remove();
				}
			}
		}
		incubationRoutes = incubationRouteService.getListByFilter(new Filter(IncubationRoute.class).eq("customerId", customer.getId())).getValue();
		customerQualifications = customerQualificationService.getListByFilter(new Filter(CustomerQualification.class).eq("customerId", customer.getId())).getValue();
		/*IncubationRoute incubationRoute = incubationRouteService.getBeanById(customer.getIncubationInfo().getStatusId()).getValue();
		status = incubationRoute.getRoute().getDataValue();*/
		result = Result.value(customer);
		loadCustoemrOtherInfo();
		if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerMessage_basicView")){
			return VIEW;
		}else if(PbActivator.getHttpSessionService().isInResourceMap("pb_linkman")){
			return "linkman";
		}else if(PbActivator.getHttpSessionService().isInResourceMap("pb_contectInfo")){
			return "contectInfo";
		}else if(PbActivator.getHttpSessionService().isInResourceMap("pb_customer_investmentView")){
			return "investmentView";
		}else if(PbActivator.getHttpSessionService().isInResourceMap("pb_staffer")){
			return "staffer";
		}else if(PbActivator.getHttpSessionService().isInResourceMap("pb_knowledge")){
			return "knowledge";
		}else if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractMessage")){
			return "contractMessage";
		}else if(PbActivator.getHttpSessionService().isInResourceMap("pb_bill_listByCustomer")){
			return "billMessage";
		}else if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataFill")){
			return "dataFill";
		}else {
			return "error";
		}
	}
	
	public String edit(){
		List<CustomerVentureType> typeList = customerVentureTypeService.getListByFilter(new Filter(CustomerVentureType.class).eq("customerId", id)).getValue();
		StringBuilder sb = new StringBuilder();
		if(typeList!=null && typeList.size()>0){
			for(CustomerVentureType it : typeList){
				sb.append(it.getVentureTypeId()).append(",");  
			}
			if(sb.toString().endsWith(","))sb.deleteCharAt(sb.length()-1);
		}
		ServletActionContext.getRequest().setAttribute("typeIds", sb.toString());
		incubationRoutes = incubationRouteService.getListByFilter(new Filter(IncubationRoute.class).eq("customerId", id)).getValue();
		customerQualifications = customerQualificationService.getListByFilter(new Filter(CustomerQualification.class).eq("customerId", id)).getValue();
		customer = customerService.getBeanByFilter(new Filter(Customer.class).eq("id", id).fetchMode("labelRefs", Filter.JOIN)).getValue();
		result = Result.value(customer);
		return EDIT;
	}
	
	public String update(){
		List<Customer> list = customerService.getListByFilter(new Filter(Customer.class).ne("id", customer.getId()).eq("name", customer.getName())).getValue();
		if(list!=null && list.size()>0){
			result = Result.failure("企业名称不能重复");
			return JSON;
		}
		String[] enterpriseTypeIds = ServletActionContext.getRequest().getParameterValues("enterpriseTypeId");
		String[] incubationRouteIds = ServletActionContext.getRequest().getParameterValues("incubationRouteId");
		String[] incubationRouteTimes = ServletActionContext.getRequest().getParameterValues("incubationRouteTime");
		String[] customerQualificationIds = ServletActionContext.getRequest().getParameterValues("customerQualificationId");
		String[] custimerQualificationTimes = ServletActionContext.getRequest().getParameterValues("custimerQualificationTime");
		result = customerService.update(customer,customerInfo,incubationInfo,ids,incubationRouteIds,incubationRouteTimes,customerQualificationIds,custimerQualificationTimes,enterpriseTypeIds);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = customerService.deleteById(id);
		} else if(ids!=null){
			result = customerService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String loadCustomer(){
		Filter filter = new Filter(Customer.class);
		filter.include("id").include("name");
		if(labelId!=null && labelId!=0){
			filter.createAlias("labelRefs", "labelRef");
			filter.eq("labelRef.labelId", labelId);
		}
		customerList = customerService.getListByFilter(filter).getValue();
		List<TreeDto> dtoList = new ArrayList<TreeDto>();
		for (Customer customer : customerList) {
			TreeDto dto = new TreeDto();
			dto.setId(customer.getId());
			dto.setText(customer.getName()+"<input type='hidden' value='"+customer.getId()+"'>");
			dto.setState(TreeDto.OPEN);
			dtoList.add(dto);
		}
		result = Result.value(dtoList);
		return "rvalue";
	}
	
	public String simpleList(){
		Filter filter = new Filter(Customer.class);
		filter.include("id").include("name");
		if(labelId!=null){
			filter.createAlias("labelRefs", "labelRef");
			filter.eq("labelRef.labelId", labelId);
		}
		return refresh(filter);
	}
	//incubationInfoStatus.route.id
	public String list(){
		Filter filter = new Filter(Customer.class);
		filter.createAlias("customerInfo", "customerInfo");
		filter.createAlias("incubationInfo", "incubationInfo");
		if(filters == null){
			if(labelId!=null && labelId!=-1){
				filter.createAlias("labelRefs", "labelRef");
				filter.eq("labelRef.labelId", labelId);
			}
			if(routeId!=null){
				filter.createAlias("incubationInfo.status", "incubationInfoStatus");
				filter.eq("incubationInfoStatus.routeId", routeId);
			}
		}else{
			if(filters!=null && filters.indexOf("incubationInfoStatusRoute.")>-1){
				filter.createAlias("incubationInfo.status", "incubationInfoStatus");
				filter.createAlias("incubationInfoStatus.route", "incubationInfoStatusRoute");
			}
			if(labelId!=null){
				filter.createAlias("labelRefs", "labelRef");
				filter.eq("labelRef.labelId", labelId);
			}
			if(routeId!=null){
				filter.createAlias("incubationInfo.status", "incubationInfoStatus");
				filter.eq("incubationInfoStatus.routeId", routeId);
			}
		}
		//createCustomerAccount();
		return refresh(filter);
		
	}
	
	public String listOnDesktop(){
		Filter filter = new Filter(Customer.class);
		filter.createAlias("customerInfo", "customerInfo");
		filter.createAlias("incubationInfo", "incubationInfo");
		if(filters == null){
			if(labelId!=null && labelId!=-1){
				filter.createAlias("labelRefs", "labelRef");
				filter.eq("labelRef.labelId", labelId);
			}
		}else{
			if(filters!=null && filters.indexOf("incubationInfoStatusRoute.")>-1){
				filter.createAlias("incubationInfo.status", "incubationInfoStatus");
				filter.createAlias("incubationInfoStatus.route", "incubationInfoStatusRoute");
			}
			if(labelId!=null){
				filter.createAlias("labelRefs", "labelRef");
				filter.eq("labelRef.labelId", labelId);
			}
		}
		
		if(customerIds!=null && !customerIds.equals("null")){
			//工作台中点击具体某栋楼入驻企业欠费账单
			String[] idArray = customerIds.split(",");
			Long[] idArray2 = new Long[idArray.length];
			for (int i=0;i<idArray.length;i++) {
				idArray2[i] =Long.parseLong(idArray[i]);
			}
			filter.in("id", idArray2);
		}
		return refresh(filter);
	}
	public void createCustomerAccount(){//给迁移到数据库中的企业创建账号 专用方法
		customerService.createCustomerAccount();
	}
	
	@Override
	protected List<Customer> getListByFilter(Filter fitler) {
		return customerService.getListByFilter(fitler).getValue();
	}	
	
	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
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

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}
	
	public void setCustomerCategoryService(
			CustomerCategoryService customerCategoryService) {
		this.customerCategoryService = customerCategoryService;
	}

	public List<CustomerCategory> getCustomerCategoryList() {
		return customerCategoryList;
	}

	public Result getResult() {
		return result;
	}
	
	public CustomerInfo getCustomerInfo() {
		return customerInfo;
	}

	public void setCustomerInfo(CustomerInfo customerInfo) {
		this.customerInfo = customerInfo;
	}

	public IncubationInfo getIncubationInfo() {
		return incubationInfo;
	}

	public void setIncubationInfo(IncubationInfo incubationInfo) {
		this.incubationInfo = incubationInfo;
	}

	public List<CustomerLabel> getCustomerLabelList() {
		return customerLabelList;
	}
	
	public Long getLabelId() {
		return labelId;
	}
	public void setLabelId(Long labelId) {
		this.labelId = labelId;
	}

	public String getExcelName() {
		return excelName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setColumns(String columns) {
		this.columns = columns;
	}

	public List<Customer> getCustomerList() {
		return customerList;
	}

	public void setCustomerLabelService(CustomerLabelService customerLabelService) {
		this.customerLabelService = customerLabelService;
	}

	public List<CustomerLabel> getMyLabelList() {
		return myLabelList;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setStatisticService(StatisticService statisticService) {
		this.statisticService = statisticService;
	}
	public void setIncubationRouteService(
			IncubationRouteService incubationRouteService) {
		this.incubationRouteService = incubationRouteService;
	}

	public List<DataDict> getIncubationRouteList() {
		return incubationRouteList;
	}

	public void setIncubationRouteList(List<DataDict> incubationRouteList) {
		this.incubationRouteList = incubationRouteList;
	}
	public List<DataDict> getCustomerQualificationList() {
		return customerQualificationList;
	}

	public void setCustomerQualificationList(
			List<DataDict> customerQualificationList) {
		this.customerQualificationList = customerQualificationList;
	}
	public List<IncubationRoute> getIncubationRoutes() {
		return incubationRoutes;
	}

	public void setIncubationRoutes(List<IncubationRoute> incubationRoutes) {
		this.incubationRoutes = incubationRoutes;
	}

	public List<CustomerQualification> getCustomerQualifications() {
		return customerQualifications;
	}

	public void setCustomerQualifications(
			List<CustomerQualification> customerQualifications) {
		this.customerQualifications = customerQualifications;
	}
	public void setCustomerQualificationService(
			CustomerQualificationService customerQualificationService) {
		this.customerQualificationService = customerQualificationService;
	}
	public String getStatus() {
		return status;
	}
	public void setCustomerVentureTypeService(
			CustomerVentureTypeService customerVentureTypeService) {
		this.customerVentureTypeService = customerVentureTypeService;
	}

	public String getCustomerIds() {
		return customerIds;
	}

	public void setCustomerIds(String customerIds) {
		this.customerIds = customerIds;
	}

	public boolean isDesktop() {
		return desktop;
	}

	public void setDesktop(boolean desktop) {
		this.desktop = desktop;
	}
	public String getRouteId() {
		return routeId;
	}

	public void setRouteId(String routeId) {
		this.routeId = routeId;
	}
}
