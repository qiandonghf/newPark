package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.DataCheck;
import com.wiiy.crm.entity.DataCheckLog;
import com.wiiy.crm.service.DataCheckLogService;
import com.wiiy.crm.service.DataCheckService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class DataCheckAction extends JqGridBaseAction<DataCheck>{
	
	private DataCheckService dataCheckService;
	private DataCheckLogService dataCheckLogService;
	
	private Result result;
	private DataCheck dataCheck;
	private List<DataCheck> list;
	private List<DataCheckLog> checkLogs;
	private Long id;
	private String ids;
	private Pager pager;
	protected Integer page = 0;
	
	public String save(){
		result = dataCheckService.save(dataCheck);
		return JSON;
	}
	
	public String view(){
		result = dataCheckService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = dataCheckService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		DataCheck dbBean = dataCheckService.getBeanById(dataCheck.getId()).getValue();
		BeanUtil.copyProperties(dataCheck, dbBean);
		result = dataCheckService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = dataCheckService.deleteById(id);
		} else if(ids!=null){
			result = dataCheckService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(DataCheck.class);
		filter.isNull("type");
		filter.orderBy("date", Filter.DESC);
		setPager(filter);
		list = dataCheckService.getListByFilter(filter).getValue();
		filter = new Filter(DataCheckLog.class);
		checkLogs = dataCheckLogService.getListByFilter(filter).getValue();
		return LIST;
	}
	private void setPager(Filter filter){
		if(page!=0){
			pager = new Pager(page,15);
		} else {
			pager = new Pager(1,15);
		}
		filter.pager(pager);
	}
	@Override
	protected List<DataCheck> getListByFilter(Filter fitler) {
		return dataCheckService.getListByFilter(fitler).getValue();
	}
	
	
	public DataCheck getDataCheck() {
		return dataCheck;
	}

	public void setDataCheck(DataCheck dataCheck) {
		this.dataCheck = dataCheck;
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

	public void setDataCheckService(DataCheckService dataCheckService) {
		this.dataCheckService = dataCheckService;
	}
	public void setDataCheckLogService(DataCheckLogService dataCheckLogService) {
		this.dataCheckLogService = dataCheckLogService;
	}
	public Result getResult() {
		return result;
	}

	public List<DataCheck> getList() {
		return list;
	}

	public void setList(List<DataCheck> list) {
		this.list = list;
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

	public List<DataCheckLog> getCheckLogs() {
		return checkLogs;
	}

	public void setCheckLogs(List<DataCheckLog> checkLogs) {
		this.checkLogs = checkLogs;
	}
	
}
