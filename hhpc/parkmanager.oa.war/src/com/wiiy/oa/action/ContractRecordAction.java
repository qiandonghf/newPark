package com.wiiy.oa.action;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.ContractRecord;
import com.wiiy.oa.entity.ContractRecordAtt;
import com.wiiy.oa.service.ContractRecordService;

/**
 * @author my
 */
public class ContractRecordAction extends JqGridBaseAction<ContractRecord>{
	
	private ContractRecordService contractRecordService;
	private Result result;
	private ContractRecord contractRecord;
	private Long id;
	private String ids;
	private Date start;
	private Date end;
	
	public String save(){
		result = contractRecordService.save(contractRecord,getSessionContractRecordAttList());
		return JSON;
	}
	private HttpSession getSession(){
		return ServletActionContext.getRequest().getSession();
	}
	@SuppressWarnings("unchecked")
	private List<ContractRecordAtt> getSessionContractRecordAttList(){
		HttpSession session = getSession();
		return (List<ContractRecordAtt>) session.getAttribute("contractRecordAttList");
	}
	public String view(){
		getSession().removeAttribute("contractRecordAttList");
		contractRecord = contractRecordService.getBeanById(id).getValue();
		result=Result.value(contractRecord);
		getSession().setAttribute("contractRecordAttList", new ArrayList<ContractRecordAtt>(contractRecord.getAtts()));
		return VIEW;
	}
	
	public String edit(){
		getSession().removeAttribute("contractRecordAttList");
		contractRecord = contractRecordService.getBeanById(id).getValue();
		String duration =  contractRecord.getDuration();
		if(null!=duration&&!"".equals(duration)){
			String[] durations = contractRecord.getDuration().split("至");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				start = sdf.parse(durations[0]);
				end = sdf.parse(durations[1]);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		result=Result.value(contractRecord);
		getSession().setAttribute("contractRecordAttList", new ArrayList<ContractRecordAtt>(contractRecord.getAtts()));
		return EDIT;
	}
	
	public String update(){
		ContractRecord dbBean = contractRecordService.getBeanById(contractRecord.getId()).getValue();
		BeanUtil.copyProperties(contractRecord, dbBean);
		result = contractRecordService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = contractRecordService.deleteById(id);
		} else if(ids!=null){
			result = contractRecordService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(ContractRecord.class));
	}
	
	@Override
	protected List<ContractRecord> getListByFilter(Filter fitler) {
		return contractRecordService.getListByFilter(fitler).getValue();
	}
	
	
	public ContractRecord getContractRecord() {
		return contractRecord;
	}

	public void setContractRecord(ContractRecord contractRecord) {
		this.contractRecord = contractRecord;
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

	public void setContractRecordService(ContractRecordService contractRecordService) {
		this.contractRecordService = contractRecordService;
	}
	
	public Result getResult() {
		return result;
	}
	public Date getStart() {
		return start;
	}
	public void setStart(Date start) {
		this.start = start;
	}
	public Date getEnd() {
		return end;
	}
	public void setEnd(Date end) {
		this.end = end;
	}
}
