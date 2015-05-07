package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.Complaint;
import com.wiiy.pb.service.ComplaintService;

/**
 * @author my
 */
public class ComplaintAction extends JqGridBaseAction<Complaint>{
	
	private ComplaintService complaintService;
	private Result result;
	private Complaint complaint;
	private Long id;
	private String ids;
	
	public String workBenchComplaint(){
		result = complaintService.getListByFilter(new Filter(Complaint.class).orderBy("complaintTime", Filter.ASC).maxResults(4));
		return "workBenchComplaint";
	}
	
	public String handIn(){
		result = Result.success();
		return JSON;
	}
	
	public String handle(){
		result = complaintService.getBeanById(id);
		return "handle";
	}
	
	public String save(){
		result = complaintService.save(complaint);
		return JSON;
	}
	
	public String view(){
		result = complaintService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = complaintService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Complaint dbBean = complaintService.getBeanById(complaint.getId()).getValue();
		BeanUtil.copyProperties(complaint, dbBean);
		result = complaintService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = complaintService.deleteById(id);
		} else if(ids!=null){
			result = complaintService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(Complaint.class));
	}
	
	@Override
	protected List<Complaint> getListByFilter(Filter fitler) {
		return complaintService.getListByFilter(fitler).getValue();
	}
	
	
	public Complaint getComplaint() {
		return complaint;
	}

	public void setComplaint(Complaint complaint) {
		this.complaint = complaint;
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

	public void setComplaintService(ComplaintService complaintService) {
		this.complaintService = complaintService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
