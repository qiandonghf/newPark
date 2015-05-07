package com.wiiy.oa.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.ContractRecordAtt;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.ContractRecordAttService;

/**
 * @author my
 */
public class ContractRecordAttAction extends JqGridBaseAction<ContractRecordAtt>{
	
	private ContractRecordAttService contractRecordAttService;
	private Result result;
	private ContractRecordAtt contractRecordAtt;
	private Long id;
	private String ids;
	
	private HttpSession getSession(){
		return ServletActionContext.getRequest().getSession();
	}
	
	@SuppressWarnings("unchecked")
	private List<ContractRecordAtt> getSessionPatentAttList(){
		HttpSession session = getSession();
		return (List<ContractRecordAtt>) session.getAttribute("contractRecordAttList");
	}
	
	public String saveToSession(){
		if(getSessionPatentAttList()==null){
			List<ContractRecordAtt> contractRecordAttList = new ArrayList<ContractRecordAtt>();
			getSession().setAttribute("contractRecordAttList", contractRecordAttList);
		}
		contractRecordAtt.setId((new Date()).getTime());
		getSessionPatentAttList().add(contractRecordAtt);
		result = Result.success(R.ContractRecordAtt.SAVE_SUCCESS,contractRecordAtt);
		return JSON;
	}
	
	public String deleteFromSession(){
		List<ContractRecordAtt> list = getSessionPatentAttList();
		ContractRecordAtt delete = null;
		if(list!=null){
			for (ContractRecordAtt task : list) {
				if(task.getId().longValue()==id.longValue()){
					delete = task;
					break;
				}
			}
			if(delete!=null){
				OaActivator.getResourcesService().delete(delete.getNewName());
				list.remove(delete);
			}
		}
		result = Result.success(R.ContractRecordAtt.DELETE_SUCCESS);
		return JSON;
	}
	public String save(){
		result = contractRecordAttService.save(contractRecordAtt);
		return JSON;
	}
	
	public String view(){
		result = contractRecordAttService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = contractRecordAttService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		ContractRecordAtt dbBean = contractRecordAttService.getBeanById(contractRecordAtt.getId()).getValue();
		BeanUtil.copyProperties(contractRecordAtt, dbBean);
		result = contractRecordAttService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = contractRecordAttService.deleteById(id);
		} else if(ids!=null){
			result = contractRecordAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(ContractRecordAtt.class));
	}
	
	@Override
	protected List<ContractRecordAtt> getListByFilter(Filter fitler) {
		return contractRecordAttService.getListByFilter(fitler).getValue();
	}
	
	
	public ContractRecordAtt getContractRecordAtt() {
		return contractRecordAtt;
	}

	public void setContractRecordAtt(ContractRecordAtt contractRecordAtt) {
		this.contractRecordAtt = contractRecordAtt;
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

	public void setContractRecordAttService(ContractRecordAttService contractRecordAttService) {
		this.contractRecordAttService = contractRecordAttService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
