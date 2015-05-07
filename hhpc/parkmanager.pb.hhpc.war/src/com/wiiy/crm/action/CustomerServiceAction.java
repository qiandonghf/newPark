package com.wiiy.crm.action;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.entity.NewsParam;
import com.wiiy.core.entity.User;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerService;
import com.wiiy.crm.entity.CustomerServiceTrack;
import com.wiiy.crm.entity.CustomerVentureType;
import com.wiiy.crm.preferences.enums.CustomerServiceResultEnum;
import com.wiiy.crm.preferences.enums.CustomerServiceStatusEnum;
import com.wiiy.crm.preferences.enums.PriorityEnum;
import com.wiiy.crm.service.CustomerServiceService;
import com.wiiy.crm.service.CustomerServiceTrackService;
import com.wiiy.crm.service.CustomerVentureTypeService;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class CustomerServiceAction extends JqGridBaseAction<CustomerService>{
	
	private CustomerServiceService customerServiceService;
	private CustomerServiceTrackService customerServiceTrackService;
	private Result result;
	private CustomerService customerService;
	private Long id;
	private String ids;
	private Long userId;
	private PriorityEnum priority;
	
	private Pager pager;
	private String name;
	
	private String fileName;
	private InputStream inputStream;
	
	private int yetCustomerServiceCount;
	
	
	public String initCustomerView(){
		yetCustomerServiceCount = customerServiceService.countYetCustomer();
		return JSON;
	}
	
	public String initCustomerService(){
		Filter filter = new Filter(CustomerService.class);
		filter.createAlias("customer","customer");
		filter.createAlias("type","type");
		String[] names = {"id","status","type.moduleName","customer.name","result","createTime"};
		filter.include(names);
		result = customerServiceService.getListByFilter(filter);
		return JSON;
	}
	
	public String solved(){
		CustomerService dbBean = customerServiceService.getBeanById(id).getValue();
		dbBean.setResult(CustomerServiceResultEnum.SOLVED);
		result = customerServiceService.update(dbBean);
		if (result.isSuccess()) {
			CustomerServiceTrack track = new CustomerServiceTrack();
			track.setUserId(dbBean.getModifierId());
			track.setServiceId(dbBean.getId());
			track.setHandleTime(new Date());
			String content = dbBean.getModifier()+"将联系单服务结果更改为："+dbBean.getResult().getTitle();
			track.setContent(content);
			customerServiceTrackService.save(track);
		}
		return JSON;
	}
	
	public String partSolved(){
		CustomerService dbBean = customerServiceService.getBeanById(id).getValue();
		dbBean.setResult(CustomerServiceResultEnum.PartSOLVED);
		result = customerServiceService.update(dbBean);
		if (result.isSuccess()) {
			CustomerServiceTrack track = new CustomerServiceTrack();
			track.setUserId(dbBean.getModifierId());
			track.setServiceId(dbBean.getId());
			track.setHandleTime(new Date());
			String content = dbBean.getModifier()+"将联系单服务结果更改为："+dbBean.getResult().getTitle();
			track.setContent(content);
			customerServiceTrackService.save(track);
		}
		return JSON;
	}
	
	public String unsolved(){
		CustomerService dbBean = customerServiceService.getBeanById(id).getValue();
		dbBean.setResult(CustomerServiceResultEnum.UNSOLVE);
		result = customerServiceService.update(dbBean);
		if (result.isSuccess()) {
			CustomerServiceTrack track = new CustomerServiceTrack();
			track.setUserId(dbBean.getModifierId());
			track.setServiceId(dbBean.getId());
			track.setHandleTime(new Date());
			String content = dbBean.getModifier()+"将联系单服务结果更改为："+dbBean.getResult().getTitle();
			track.setContent(content);
			customerServiceTrackService.save(track);
		}
		return JSON;
	}
	
	public String accept(){
		CustomerService dbBean = customerServiceService.getBeanById(id).getValue();
		dbBean.setStatus(CustomerServiceStatusEnum.ACCEPT);
		result = customerServiceService.update(dbBean);
		if (result.isSuccess()) {
			CustomerServiceTrack track = new CustomerServiceTrack();
			track.setUserId(dbBean.getModifierId());
			track.setServiceId(dbBean.getId());
			track.setHandleTime(new Date());
			String content = dbBean.getModifier()+"将联系单状态更改为："+dbBean.getStatus().getTitle();
			track.setContent(content);
			customerServiceTrackService.save(track);
		}
		return JSON;
	}
	
	public String serviceClosed(){
		CustomerService dbBean = customerServiceService.getBeanById(id).getValue();
		dbBean.setStatus(CustomerServiceStatusEnum.CLOSE);
		dbBean.setEndDate(new Date());
		result = customerServiceService.update(dbBean);
		if (result.isSuccess()) {
			CustomerServiceTrack track = new CustomerServiceTrack();
			track.setUserId(dbBean.getModifierId());
			track.setServiceId(dbBean.getId());
			track.setHandleTime(new Date());
			String content = dbBean.getModifier()+"将联系单状态更改为："+dbBean.getStatus().getTitle();
			track.setContent(content);
			customerServiceTrackService.save(track);
		}
		return JSON;
	}
	
	public String suspend(){
		CustomerService dbBean = customerServiceService.getBeanById(id).getValue();
		dbBean.setStatus(CustomerServiceStatusEnum.PENDING);
		result = customerServiceService.update(dbBean);
		if (result.isSuccess()) {
			CustomerServiceTrack track = new CustomerServiceTrack();
			track.setUserId(dbBean.getModifierId());
			track.setServiceId(dbBean.getId());
			track.setHandleTime(new Date());
			String content = dbBean.getModifier()+"将联系单状态更改为："+dbBean.getStatus().getTitle();
			track.setContent(content);
			customerServiceTrackService.save(track);
		}
		return JSON;
	}
	
	public String send(){
		CustomerService customerService = customerServiceService.getBeanById(id).getValue();
		SysEmailSenderPubService sysEmailSenderPubService = PbActivator.getService(SysEmailSenderPubService.class);
		if(sysEmailSenderPubService!=null){
			User user = PbActivator.getUserById(userId);
			String receiverEmail = user.getEmail();
			String subject = "客服联系单";
			String content = "";
			try {
				URL url = PbActivator.getURL("web/msgRemindModule/msgRemindModule.html");
				InputStreamReader Inputreader = new InputStreamReader(url.openStream(),"utf-8");
				BufferedReader br = new BufferedReader(Inputreader);
				String temp=br.readLine();
				StringBuffer data=new StringBuffer();
				while( temp!=null){
					data.append(temp+"\n");
					temp=br.readLine(); 
				}
				content = data.toString();
				content = content.replace("${subject}", customerService.getCustomerName());
				content = content.replace("${msgType}", "客户联系单");
				content = content.replace("${url}",ServletActionContext.getRequest().getScheme()+"://"+ServletActionContext.getRequest().getServerName()+":"+ServletActionContext.getRequest().getServerPort()+"/"+"parkmanager.pb/customerService!view.action?id="+id);
				content = content.replace("${receiver}", user.getRealName());
				content = content.replace("${sender}", PbActivator.getSessionUser().getRealName());
				content = content.replace("${customerName}",user.getRealName());
				content = content.replace("${content}","有一份联系单需要您去处理!");
				content = content.replace("${msgLink}",PbActivator.getRemindEmailService().getRemindEmailLink());
				sysEmailSenderPubService.send(receiverEmail,content,subject);
				SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
				if(smsPubService!=null && smsActive()){
					String receiverMobile = user.getMobile();
					String receiverName = user.getRealName();
					String content2 = PbActivator.getAppConfig().getConfig("customerServiceRemind").getParameter("smsModule");
					content2 = content2.replace("${customerServiceName}",customerService.getCustomerName());
					smsPubService.send(receiverMobile, content2, receiverName);
				}
				result = Result.success("转交成功");
				customerService.setUser(user);
				customerService.setUserId(userId);
				customerServiceService.update(customerService);
				setTrack(PbActivator.getSessionUser().getRealName()+"将任务发送给"+user.getRealName());
			} catch (Exception e) {
				e.printStackTrace();
				result = Result.failure("转交失败");
			}
		}
		return JSON;
	}
	
	/**
	 * 保存轨迹信息
	 * @param content
	 */
	private void setTrack(String content) {
		CustomerServiceTrack customerServiceTrack = new CustomerServiceTrack();
		customerServiceTrack.setUser(PbActivator.getSessionUser());
		customerServiceTrack.setUserId(PbActivator.getSessionUser().getId());
		customerServiceTrack.setService(customerService);
		customerServiceTrack.setServiceId(customerService.getId());
		customerServiceTrack.setHandleTime(new Date());
		customerServiceTrack.setContent(content);
		customerServiceTrackService.save(customerServiceTrack);
	}
	
	private boolean smsActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("customerServiceRemind").getParameter("sms");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	
	public String print() {
		fileName = StringUtil.URLEncoderToUTF8("客服联系单")+".doc";
		try {
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			customerServiceService.print(id, out);
			inputStream = new ByteArrayInputStream(out.toByteArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "print";
	}
	
	public String chagePriority() {
		customerService = customerServiceService.getBeanById(id).getValue();
		customerService.setPriority(priority);
		customerServiceService.update(customerService);
		return JSON;
	}
	
	public String save(){
		customerService.setStatus(CustomerServiceStatusEnum.ACCEPT);
		customerService.setResult(CustomerServiceResultEnum.UNSOLVE);
		customerService.setPriority(PriorityEnum.LOW);
		result = customerServiceService.save(customerService);
		return JSON;
	}
	
	public String view(){
		result = customerServiceService.getBeanById(id);
		return VIEW;
	}
	
	public String view2(){
		result = customerServiceService.getBeanById(id);
		return "view2";
	}
	
	public String edit(){
		result = customerServiceService.getBeanById(id);
		return EDIT;
	}
	public String editDesktop(){
		result = customerServiceService.getBeanById(id);
		return "editDesktop";
	}
	
	public String update(){
		CustomerService dbBean = customerServiceService.getBeanById(customerService.getId()).getValue();
		id = customerService.getId();
		BeanUtil.copyProperties(customerService, dbBean);
		result = customerServiceService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = customerServiceService.deleteById(id);
		} else if(ids!=null){
			result = customerServiceService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(CustomerService.class);
		userId = PbActivator.getSessionUser().getId();
		if(name!=null && name.length()>0){
			name = StringUtil.ISOToUTF8(name);
			filter.like("customerName", name);
		}
		if(page!=0){
			pager = new Pager(page,15);
		} else {
			pager = new Pager(1,15);
		}
		filter.pager(pager);
		filter.eq("userId", userId);
		List<CustomerService> list = customerServiceService.
				getListByFilter(filter).getValue();
		mySort(list);
		result = Result.value(list);
		return LIST;
	}
	
	/**
	 * 排序:先按状态排序,再按重要性排序
	 * @param services
	 */
	public void mySort(List<CustomerService> services) {
		Collections.sort(services,new Comparator<CustomerService>() {
			@Override
			public int compare(CustomerService o1, CustomerService o2) {
				if (o1.getStatus() == o2.getStatus()) {
				}else {
					if (o1.getStatus() == CustomerServiceStatusEnum.ACCEPT) {
						return -1;
					}else if (o1.getStatus() == CustomerServiceStatusEnum.PENDING) {
						if (o2.getStatus() == CustomerServiceStatusEnum.ACCEPT) {
							return 1;
						}else if (o2.getStatus() == CustomerServiceStatusEnum.CLOSE) {
							return -1;
						}
					}else{
						return 1;
					}
				}
				if (o1.getPriority() == o2.getPriority()) {
					return o2.getCreateTime().compareTo(o1.getCreateTime());
				}else {
					if (o1.getPriority() == PriorityEnum.HIGH) {
						return -1;
					}else if (o1.getPriority() == PriorityEnum.MIDDLE) {
						if (o2.getPriority() == PriorityEnum.HIGH) {
							return 1;
						}else if (o2.getPriority() == PriorityEnum.LOW) {
							return -1;
						}
					}else {
						return 1;
					}
				}
				return 0;
			}
		});
	}
	
	@Override
	protected List<CustomerService> getListByFilter(Filter fitler) {
		return customerServiceService.getListByFilter(fitler).getValue();
	}
	
	
	public CustomerService getCustomerService() {
		return customerService;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
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

	public void setCustomerServiceService(CustomerServiceService customerServiceService) {
		this.customerServiceService = customerServiceService;
	}
	
	public Result getResult() {
		return result;
	}
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Pager getPager() {
		return pager;
	}
	public String getFileName() {
		return fileName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}
	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public void setCustomerServiceTrackService(
			CustomerServiceTrackService customerServiceTrackService) {
		this.customerServiceTrackService = customerServiceTrackService;
	}


	public int getYetCustomerServiceCount() {
		return yetCustomerServiceCount;
	}


	public void setYetCustomerServiceCount(int yetCustomerServiceCount) {
		this.yetCustomerServiceCount = yetCustomerServiceCount;
	}

	public PriorityEnum getPriority() {
		return priority;
	}

	public void setPriority(PriorityEnum priority) {
		this.priority = priority;
	}
	
}
