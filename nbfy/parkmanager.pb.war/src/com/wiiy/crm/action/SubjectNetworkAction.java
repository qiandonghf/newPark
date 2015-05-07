package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.SubjectNetwork;
import com.wiiy.crm.service.ContractService;
import com.wiiy.crm.service.SubjectNetworkService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.Facility;
import com.wiiy.pb.preferences.enums.FacilityTypeEnum;
import com.wiiy.pb.service.FacilityService;

/**
 * @author my
 */
public class SubjectNetworkAction extends JqGridBaseAction<SubjectNetwork>{
	
	private SubjectNetworkService subjectNetworkService;
	private ContractService contractService;
	private FacilityService facilityService;
	private Result result;
	private SubjectNetwork subjectNetwork;
	private List<Facility> facilityList;
	private Long id;
	private String ids;
	private String saveFlag;
	
	public String add(){
		result = contractService.getBeanById(id);
		facilityList = facilityService.getListByFilter(new Filter(Facility.class).eq("type", FacilityTypeEnum.NETWORK)).getValue();
		return "add";
	}
	
	public String loadNetList(){
		facilityList = facilityService.getListByFilter(new Filter(Facility.class).eq("type", FacilityTypeEnum.NETWORK)).getValue();
		return JSON;
	}
	
	public String save(){
		result = subjectNetworkService.save(subjectNetwork);
		return JSON;
	}
	
	public String view(){
		result = subjectNetworkService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		facilityList = facilityService.getListByFilter(new Filter(Facility.class).eq("type", FacilityTypeEnum.NETWORK)).getValue();
		result = subjectNetworkService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		SubjectNetwork dbBean = subjectNetworkService.getBeanById(subjectNetwork.getId()).getValue();
		BeanUtil.copyProperties(subjectNetwork, dbBean);
		result = subjectNetworkService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = subjectNetworkService.deleteById(id);
		} else if(ids!=null){
			result = subjectNetworkService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(SubjectNetwork.class));
	}
	
	@Override
	protected List<SubjectNetwork> getListByFilter(Filter fitler) {
		return subjectNetworkService.getListByFilter(fitler).getValue();
	}
	
	
	public SubjectNetwork getSubjectNetwork() {
		return subjectNetwork;
	}

	public void setSubjectNetwork(SubjectNetwork subjectNetwork) {
		this.subjectNetwork = subjectNetwork;
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

	public void setSubjectNetworkService(SubjectNetworkService subjectNetworkService) {
		this.subjectNetworkService = subjectNetworkService;
	}
	
	public Result getResult() {
		return result;
	}

	public void setFacilityService(FacilityService facilityService) {
		this.facilityService = facilityService;
	}

	public List<Facility> getFacilityList() {
		return facilityList;
	}

	public String getSaveFlag() {
		return saveFlag;
	}

	public void setSaveFlag(String saveFlag) {
		this.saveFlag = saveFlag;
	}

	public void setContractService(ContractService contractService) {
		this.contractService = contractService;
	}
	
}
