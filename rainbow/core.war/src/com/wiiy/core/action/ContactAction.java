package com.wiiy.core.action;

import java.util.List;

import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dto.ContactDto;
import com.wiiy.core.entity.ContactAtt;
import com.wiiy.core.entity.ContactEntity;
import com.wiiy.core.entity.ContactLog;
import com.wiiy.core.preferences.enums.ContactStatusEnum;
import com.wiiy.core.preferences.enums.ContactTypeEnum;
import com.wiiy.core.service.ContactAttService;
import com.wiiy.core.service.ContactService;

/**
 * @author my
 */
public class ContactAction {
	
	private ContactService contactService;
	private ContactAttService contactAttService;
	private Result result;
	private Long id;
	private String ids;
	private List<ContactDto> dtoList;
	private Pager pager;
	private Integer rows = 0;
	private Integer page = 0;
	private Integer total = 0;
	private Integer records = 0;
	private ContactTypeEnum[] typeEnums;
	private ContactTypeEnum type;
	private List<ContactLog> contactLogList;
	private List<ContactAtt> contactAttList;
	private ContactDto dto; 
	private int tabId = 1;//用于判断点击联系单出现的右边页面的tab页显示哪一个(联系单/扫描件),默认为1。
	
	
	public String listMyAll(){
		Long userId = CoreActivator.getSessionUser().getId();
		if(type!=null){
			int total = contactService.myTotalCount(userId,type);
			setPager(total);
			dtoList = contactService.listMyAll(pager,userId,type);
		}else{
			int total = contactService.myTotalCount(userId);
			setPager(total);
			dtoList = contactService.listMyAll(pager,userId);
		}
		
		typeEnums = ContactTypeEnum.values();
		return "listMyAll";
	}
	
	public String listAll(){
		int total = contactService.totalCount();
		setPager(total);
		dtoList = contactService.listAll(pager,type);
		typeEnums = ContactTypeEnum.values();
		return "listAll";
	}
	public String myDidCountersignList(){
		Long userId = CoreActivator.getSessionUser().getId();
		int total = contactService.myTotalDidCountersignCount(userId);
		setPager(total);
		dtoList = contactService.listMyDidCountersignAll(pager,userId);
		typeEnums = ContactTypeEnum.values();
		return "myDidCountersign";
	}
	public String myWaitCountersignList(){
		Long userId = CoreActivator.getSessionUser().getId();
		int total = contactService.myTotalWaitCountersignCount(userId);
		setPager(total);
		dtoList = contactService.listMyWaitCountersignAll(pager,userId);
		typeEnums = ContactTypeEnum.values();
		return "myWaitCountersign";
	}
	public String countCountersign(){
		Long userId = CoreActivator.getSessionUser().getId();
		int total = contactService.myTotalWaitCountersignCount(userId);
		result = Result.value(total);
		return "json";
	}
	public String myView(){
		dto = contactService.getContactDto(type,id);
		if(dto==null){
			return "index";
		}
		contactLogList = contactService.getContactLogList(type,id);
		contactAttList = contactAttService.getListByFilter(new Filter(ContactAtt.class).eq("contactType", type).eq("contactId", id)).getValue();
		return "myView";
	}
	public String view(){
		dto = contactService.getContactDto(type,id);
		contactLogList = contactService.getContactLogList(type,id);
		contactAttList = contactAttService.getListByFilter(new Filter(ContactAtt.class).eq("contactType", type).eq("contactId", id)).getValue();
		return "view";
	}
	
	public String countersignView(){
		dto = contactService.getContactDto(type, id);
		contactLogList = contactService.getContactLogList(type, id);
		contactAttList = contactAttService.getListByFilter(new Filter(ContactAtt.class).eq("contactType", type).eq("contactId", id)).getValue();
		return "countersignView";
	}
	
	private void setPager(int total){
		if(page!=0){
			pager = new Pager(page,15);
			pager.setRecords(total);
		} else {
			pager = new Pager(1,15);
			pager.setRecords(total);
		}
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

	public void setContactService(ContactService contactService) {
		this.contactService = contactService;
	}
	
	public Result getResult() {
		return result;
	}

	public List<ContactDto> getDtoList() {
		return dtoList;
	}

	public void setDtoList(List<ContactDto> dtoList) {
		this.dtoList = dtoList;
	}


	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Integer getRecords() {
		return records;
	}

	public void setRecords(Integer records) {
		this.records = records;
	}

	public ContactTypeEnum[] getTypeEnums() {
		return typeEnums;
	}

	public void setTypeEnums(ContactTypeEnum[] typeEnums) {
		this.typeEnums = typeEnums;
	}

	public ContactTypeEnum getType() {
		return type;
	}

	public void setType(ContactTypeEnum type) {
		this.type = type;
	}

	public List<ContactLog> getContactLogList() {
		return contactLogList;
	}

	public void setContactLogList(List<ContactLog> contactLogList) {
		this.contactLogList = contactLogList;
	}

	public ContactDto getDto() {
		return dto;
	}

	public void setDto(ContactDto dto) {
		this.dto = dto;
	}
	public void setContactAttService(ContactAttService contactAttService) {
		this.contactAttService = contactAttService;
	}
	public List<ContactAtt> getContactAttList() {
		return contactAttList;
	}
	public void setContactAttList(List<ContactAtt> contactAttList) {
		this.contactAttList = contactAttList;
	}
	public int getTabId() {
		return tabId;
	}
	public void setTabId(int tabId) {
		this.tabId = tabId;
	}
}
