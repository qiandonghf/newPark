package com.wiiy.core.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.preferences.enums.LogTypeEnum;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.core.dto.LoginDetailsDto;
import com.wiiy.core.dto.LoginStatisticalDto;
import com.wiiy.core.entity.OperationLog;
import com.wiiy.core.entity.Org;
import com.wiiy.core.service.OperationLogService;
import com.wiiy.core.service.OrgService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;

public class StatisticalAction {
	
	private Result<?> result;
	private Integer days = 7;
	private OperationLogService operationLogService;
	private OrgService orgService;
	private List<Org> orgList;
	private Long userId;
	private Pager pager;
	private Integer page = 1;
	private Integer rows = 15;
	
	public String opStatistical(){
		result = orgService.getList();
		return "opStatistical";
	}
	
	public String smsStatistical(){
		return "smsStatistical";
	}
	
	public String loginStatistical(){
		Filter filter = new Filter(OperationLog.class);
		filter.ge("createTime", CalendarUtil.getEarliest(CalendarUtil.add(Calendar.DAY_OF_MONTH, (days-1)*-1).getTime(), Calendar.DAY_OF_MONTH));
		String username = ServletActionContext.getRequest().getParameter("username");
		String orgId = ServletActionContext.getRequest().getParameter("orgId");
		ServletActionContext.getRequest().setAttribute("username", username);
		ServletActionContext.getRequest().setAttribute("orgId", orgId);
		ServletActionContext.getRequest().setAttribute("days", days);
		if(username!=null && username.length()>0){
			filter.like("creator", username);
		}
		if(orgId!=null && orgId.length()>0){
			filter.eq("orgId", Long.parseLong(orgId));
		}
		List<OperationLog> list = operationLogService.getListByFilter(filter).getValue();
		Map<Long, LoginStatisticalDto> map = new HashMap<Long,LoginStatisticalDto>();
		for (OperationLog op : list) {
			if(op.getLogType().equals(LogTypeEnum.LOGIN)){
				LoginStatisticalDto dto = map.get(op.getCreatorId());
				if(dto == null){
					dto = new LoginStatisticalDto(op.getCreatorId());
					dto.setUsername(op.getCreator());
					dto.setDepart(op.getOrgName());
					map.put(dto.getUserId(), dto);
				}
				dto.setLoginCount(dto.getLoginCount()+1);
				if(!dto.getIps().contains(op.getIp())){
					dto.getIps().add(op.getIp());
					dto.setIpCount(dto.getIpCount()+1);
				}
			}
		}
		List<LoginStatisticalDto> dtoList = new ArrayList<LoginStatisticalDto>();
		for (LoginStatisticalDto loginStatisticalDto : map.values()) {
			dtoList.add(loginStatisticalDto);
		}
		result = Result.value(dtoList);
		List<Org> orgList = orgService.getList().getValue();
		ServletActionContext.getRequest().setAttribute("orgList", orgList);
		return "loginStatistical";
	}
	
	/**
	 * 账号使用明细
	 * @return
	 */
	public String showDetails() {
		Filter filter = new Filter(OperationLog.class);
		filter.ge("createTime", CalendarUtil.getEarliest(
				CalendarUtil.add(Calendar.DAY_OF_MONTH, (days-1)*-1).getTime(), 
				Calendar.DAY_OF_MONTH));
		filter.eq("creatorId", userId);
		filter.ne("logType", LogTypeEnum.OP);
		if (pager == null) {
			pager = new Pager(page,rows);
		}
		filter.pager(pager);
		//倒序排列
		filter.orderBy("id", Filter.DESC);
		List<OperationLog> list = 
				operationLogService.getListByFilter(filter).getValue();
		
		//无记录直接返回
		if (list.size() < 0) {
			return "showDetails";
		}
		
		List<LoginDetailsDto> dtoList = 
				new ArrayList<LoginDetailsDto>();
		String username = list.get(0).getCreator();
		//转发传参
		ServletActionContext.getRequest().setAttribute("username", username);
		ServletActionContext.getRequest().setAttribute("days", days);
		ServletActionContext.getRequest().setAttribute("pager", pager);
		ServletActionContext.getRequest().setAttribute("userId", userId);
		
		for (OperationLog op : list) {
			LoginDetailsDto dto = 
					new LoginDetailsDto(userId);
			dto.setDepart(op.getOrgName());
			dto.setContent(getContent(op));
			dto.setIp(op.getIp());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			dto.setTime(sdf.format(op.getCreateTime()));
			dtoList.add(dto);
		}
		result = Result.value(dtoList);
		return "showDetails";
	}
	
	public String getContent(OperationLog op) {
		if ("LOGIN".equals(op.getLogType().toString())) {
			return "登录";
		}else if ("LOGOUT".equals(op.getLogType().toString())) {
			return "登出";
		}else {
			return op.getMsg();
		}
	}

	public void setOperationLogService(OperationLogService operationLogService) {
		this.operationLogService = operationLogService;
	}

	public Result<?> getResult() {
		return result;
	}

	public void setDays(Integer days) {
		this.days = days;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public List<Org> getOrgList() {
		return orgList;
	}

	public void setOrgService(OrgService orgService) {
		this.orgService = orgService;
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


}
