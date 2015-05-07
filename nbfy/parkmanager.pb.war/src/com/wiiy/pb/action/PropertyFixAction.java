package com.wiiy.pb.action;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.User;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.entity.PropertyFix;
import com.wiiy.pb.preferences.enums.PropertyFixStatusEnum;
import com.wiiy.pb.service.PropertyFixService;

public class PropertyFixAction extends JqGridBaseAction<PropertyFix>{
	private PropertyFixService propertyFixService;
	private CustomerService customerService;
	private PropertyFix propertyFix;
	private List<PropertyFix> propertyFixList;

	private int countPropertyRepairs;
	
	private Long id;
	private String ids;
	private Result result;
	
	private String oddNum;
	
	public String workBenchPropertyFixList(){
		Filter filter = new Filter(PropertyFix.class);
		String[] names = {"id","status","reportReason","reporter","reportTime"};
		filter.include(names);
		filter.orderBy("reportTime", Filter.DESC).maxResults(6);
		propertyFixList = propertyFixService.getListByFilter(filter).getValue();
		return JSON;
	}
	
	public String countRepairs(){
		countPropertyRepairs = propertyFixService.getListByFilter(new Filter(PropertyFix.class).eq("status", PropertyFixStatusEnum.UNSTART)).getValue().size();
		return JSON;
	}
	
	public 	String add(){
		oddNum = propertyFixService.getOrderNum();
		return "add";
	}
	
	public String list(){
		Filter filter = new Filter(PropertyFix.class);
		return refresh(filter);
	}
	
	public String listByUserId(){
		Customer customer = customerService.getBeanByFilter(new Filter(Customer.class).eq("userId", PbActivator.getSessionUser().getId())).getValue();
		Filter filter = new Filter(PropertyFix.class).eq("customerId", customer.getId());
		return refresh(filter);
	}
	
	public String save(){
		propertyFix.setFinished(BooleanEnum.NO);
		propertyFix.setStatus(PropertyFixStatusEnum.UNSTART);
		if(propertyFix.getTypeId().equals("")){
			propertyFix.setTypeId(null);
		}
		if(propertyFix.getMethodId().equals("")){
			propertyFix.setMethodId(null);
		}
		result = propertyFixService.save(propertyFix);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = propertyFixService.deleteById(id);
		}else if(ids!=null){
			result = propertyFixService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		result = propertyFixService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		if(propertyFix.getFinishTime()!=null){
			propertyFix.setFinished(BooleanEnum.YES);
		}else{
			propertyFix.setFinished(BooleanEnum.NO);
		}
		if(propertyFix.getTypeId().equals("")){
			propertyFix.setTypeId(null);
		}
		if(propertyFix.getMethodId().equals("")){
			propertyFix.setMethodId(null);
		}
		result = propertyFixService.update(propertyFix);
		return JSON;
	}
	
	public String view(){
		result = propertyFixService.getBeanById(id);
		return VIEW;
	}
	
	public String handle(){
		result = propertyFixService.getBeanById(id);
		return "handle";
	}
	public String handleDesktop(){
		result = propertyFixService.getBeanById(id);
		return "handleDesktop";
	}
	
	public String handleOrder(){
		result = propertyFixService.update(propertyFix);
		return JSON;
	}
	
	public String serviceList(){
		return "serviceList";
	}
	
	public String hangIn(){
		propertyFix = propertyFixService.getBeanById(id).getValue();
		propertyFix.setStatus(PropertyFixStatusEnum.HANGIN);
		result = propertyFixService.update(propertyFix);
		if(result.isSuccess()){
			SysEmailSenderPubService sysEmailSenderPubService = PbActivator.getService(SysEmailSenderPubService.class);
			Long userId = Long.valueOf(PbActivator.getAppConfig().getConfig("propertyContect").getParameter("name"));
			User user = PbActivator.getUserById(userId);
			String receiverName = user.getRealName();
			if(sysEmailSenderPubService!=null && emailActive()){
				String content = parseHTML("web/msgRemindModule/msgRemindModule.html").toString();
				String subject = "物业保修单递交提醒";
				content = content.replace("${subject}", propertyFix.getReporter());
				content = content.replace("${msgType}", "报修提醒");
				content = content.replace("${url}", basePath()+"parkmanager.pb/propertyFix!view.action?id="+propertyFix.getId());
				content = content.replace("${receiver}",receiverName);
				content = content.replace("${customerName}",receiverName);
				content = content.replace("${sender}", PbActivator.getSessionUser().getRealName());
				content = content.replace("${content}", "报修地点："+propertyFix.getReportAddr()+"&lt;br&gt;"+propertyFix.getReportReason());
				content = content.replace("${msgLink}",PbActivator.getRemindEmailService().getRemindEmailLink());
				sendMail(receiverName,user.getEmail(),subject,content,sysEmailSenderPubService);
			}
			SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
			if(smsPubService!=null && smsActive()){
				String content = PbActivator.getAppConfig().getConfig("propertyRemind").getParameter("smsModule");
				String receiverMobile = user.getMobile();
				sendSms(receiverMobile, content, receiverName, smsPubService);
			}
		}
		return JSON;
	}
	
	private void sendSms(String receiverMobile, String content,
			String receiverName,SMSPubService smsPubService) {
		smsPubService.send(receiverMobile, content, receiverName);
	}

	public void sendMail(String receiverName,String receiverEmail,String subject,String content,SysEmailSenderPubService sysEmailSenderPubService){
		if(receiverEmail == null){
			receiverEmail = "";
		}
		sysEmailSenderPubService.send(receiverEmail,content,subject);
	}
	
	private boolean emailActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("propertyRemind").getParameter("email");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	
	private boolean smsActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("propertyRemind").getParameter("sms");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	
	private StringBuffer parseHTML(String str){
		URL url = PbActivator.getURL(str);
		InputStreamReader Inputreader;
		StringBuffer data = new StringBuffer();
		try {
			Inputreader = new InputStreamReader(url.openStream(),"utf-8");
			BufferedReader br = new BufferedReader(Inputreader);
			String temp=br.readLine();
			while( temp!=null){
				data.append(temp+"\n");
				temp=br.readLine(); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	
	private String basePath(){
		return ServletActionContext.getRequest().getScheme()+"://"+ServletActionContext.getRequest().getServerName()+":"+ServletActionContext.getRequest().getServerPort()+"/";
	}

	
	@Override
	protected List<PropertyFix> getListByFilter(Filter fitler) {
		return propertyFixService.getListByFilter(fitler).getValue();
	}
	public PropertyFix getPropertyFix() {
		return propertyFix;
	}
	public void setPropertyFix(PropertyFix propertyFix) {
		this.propertyFix = propertyFix;
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
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}
	public void setPropertyFixService(PropertyFixService propertyFixService) {
		this.propertyFixService = propertyFixService;
	}

	public String getOddNum() {
		return oddNum;
	}

	public void setOddNum(String oddNum) {
		this.oddNum = oddNum;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}
	public List<PropertyFix> getPropertyFixList() {
		return propertyFixList;
	}

	public void setPropertyFixList(List<PropertyFix> propertyFixList) {
		this.propertyFixList = propertyFixList;
	}

	public int getCountPropertyRepairs() {
		return countPropertyRepairs;
	}

	public void setCountPropertyRepairs(int countPropertyRepairs) {
		this.countPropertyRepairs = countPropertyRepairs;
	}
	
}
