package com.wiiy.core.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.LogTypeEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.OperationLog;
import com.wiiy.core.service.OperationLogService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class OperationLogAction extends JqGridBaseAction<OperationLog>{
	
	private OperationLogService operationLogService;
	private Result result;
	private OperationLog operationLog;
	private Long id;
	private String ids;
	
	
	public String opList(){
		return refresh(new Filter(OperationLog.class).eq("logType", LogTypeEnum.OP).orderBy("id", Filter.DESC));
	}
	
	public String save(){
		result = operationLogService.save(operationLog);
		return JSON;
	}
	
	public String view(){
		result = operationLogService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = operationLogService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		OperationLog dbBean = operationLogService.getBeanById(operationLog.getId()).getValue();
		BeanUtil.copyProperties(operationLog, dbBean);
		result = operationLogService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = operationLogService.deleteById(id);
		} else if(ids!=null){
			result = operationLogService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(OperationLog.class));
	}
	
	@Override
	protected List<OperationLog> getListByFilter(Filter fitler) {
		return operationLogService.getListByFilter(fitler).getValue();
	}
	
	
	public OperationLog getOperationLog() {
		return operationLog;
	}

	public void setOperationLog(OperationLog operationLog) {
		this.operationLog = operationLog;
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

	public void setOperationLogService(OperationLogService operationLogService) {
		this.operationLogService = operationLogService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
