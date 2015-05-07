package com.wiiy.oa.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.SupplyApply;
import com.wiiy.oa.preferences.enums.CarApplyStatusEnum;
import com.wiiy.oa.service.SupplyApplyService;


public class SupplyApplyAction extends JqGridBaseAction<SupplyApply>{
	private SupplyApplyService supplyApplyService;
	private SupplyApply supplyApply;
	private Result result;
	private Long id;
	private String ids;
	private String approverl;//审批人
	private Long approverId;//审批人id
	private String applyCheck;//是否同意
	private String excelName;
	private InputStream inputStream;
	private String columns;
	
	public String export(){
		Filter filter = new Filter(SupplyApply.class);
		filter.createAlias("supply", "supply");
		page=0;//不要分页
		refresh(filter);
		excelName = StringUtil.URLEncoderToUTF8("办公用品申请")+".xls";
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		POIUtil.export("办公用品申请列表", generateExportColumns(columns), root, out);
		inputStream = new ByteArrayInputStream(out.toByteArray());
		return "export";
	}
	
	private LinkedHashMap<String, String> generateExportColumns(String columns){
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		columns = columns.replace("{", "");
		columns = columns.replace("}", "");
		String[] properties = columns.split(",");
		for (String string : properties) {
			String[] ss = string.split(":");
			String field = ss[0].replace("\"", "");
			String description = ss[1].replace("\"", "");
			map.put(field, description);
		}
		return map;
	}

	public String save(){
		supplyApply.setStatus(CarApplyStatusEnum.PENDING);
		result = supplyApplyService.save(supplyApply);
		return JSON;
	}
	
	public String view(){
		result = supplyApplyService.getBeanById(id);
		return VIEW;
	}
	public String edit(){
		result = supplyApplyService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		SupplyApply dbean = supplyApplyService.getBeanById(supplyApply.getId()).getValue();
		Double count = dbean.getAmount();
		BeanUtil.copyProperties(supplyApply, dbean);
		result = supplyApplyService.updateSupply(supplyApply,count);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = supplyApplyService.deleteById(id);
		}else if(ids!=null){
			result = supplyApplyService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		result = supplyApplyService.getList();
		return LIST;
	}
	
	public String listAll(){
		Filter filter = new Filter(SupplyApply.class);
		return refresh(filter);
	}
	//提交申请
	public String approve(){
		result = supplyApplyService.approve(id,approverId,approverl);
		return JSON;
	}
	//审批
	public String approveApply(){
		SupplyApply supplyApply = supplyApplyService.getBeanById(id).getValue();
		result = supplyApplyService.approveApply(supplyApply,applyCheck);
		return JSON;
	}
	@Override
	protected List<SupplyApply> getListByFilter(Filter fitler) {
		return supplyApplyService.getListByFilter(fitler).getValue();
	}
	public void setSupplyApplyService(SupplyApplyService supplyApplyService) {
		this.supplyApplyService = supplyApplyService;
	}
	public SupplyApply getSupplyApply() {
		return supplyApply;
	}
	public void setSupplyApply(SupplyApply supplyApply) {
		this.supplyApply = supplyApply;
	}
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
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

	public String getApproverl() {
		return approverl;
	}

	public void setApproverl(String approverl) {
		this.approverl = approverl;
	}

	public Long getApproverId() {
		return approverId;
	}

	public void setApproverId(Long approverId) {
		this.approverId = approverId;
	}

	public String getApplyCheck() {
		return applyCheck;
	}

	public void setApplyCheck(String applyCheck) {
		this.applyCheck = applyCheck;
	}

	public String getExcelName() {
		return excelName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setColumns(String columns) {
		this.columns = columns;
	}

}
