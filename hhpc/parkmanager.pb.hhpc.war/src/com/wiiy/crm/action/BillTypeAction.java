package com.wiiy.crm.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.BillType;
import com.wiiy.crm.service.BillTypeService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class BillTypeAction extends JqGridBaseAction<BillType>{
	
	private BillTypeService billTypeService;
	private Result result;
	private BillType billType;
	private Long id;
	private String ids;
	private List<BillType> billTypeList;
	
	public String loadChildrenType(){
		result = billTypeService.getListByFilter(new Filter(BillType.class).eq("parentId",id).orderBy("parentId", Filter.ASC));
		return JSON;
	}
	
	public String loadTopType(){
		result = billTypeService.getListByFilter(new Filter(BillType.class).isNull("parentId"));
		return JSON;
	}

	public String typeTree(){
		List<BillType> list = billTypeService.getListByFilter(new Filter(BillType.class)).getValue();
		Map<Long,List<BillType>> map = new HashMap<Long, List<BillType>>();
		for (BillType billType : list) {
			if(billType.getParentId()!=null){
				if(map.get(billType.getParentId())!=null){
					map.get(billType.getParentId()).add(billType);
				}else{
					List<BillType> billTypes = new ArrayList<BillType>();
					billTypes.add(billType);
					map.put(billType.getParentId(), billTypes);
				}
				
			}
		}
		for (BillType billType : list) {
			if(map.get(billType.getId())!=null){
				billType.setText(billType.getTypeName());
				billType.setState(TreeEntity.STATE_CLOSED);
				billType.setLevel(0);
				List<BillType> listBt = map.get(billType.getId());
				List<BillType> children = new ArrayList<BillType>();
				for (BillType bt : listBt) {
					bt.setText(bt.getTypeName());
					bt.setLevel(1);
					children.add(bt);
				}
				billType.setChildren(children);
				if(billTypeList==null){
					billTypeList = new ArrayList<BillType>();
				}
				billTypeList.add(billType);
			}
		}
		return JSON;
	}
	
	public String save(){
		result = billTypeService.save(billType);
		return JSON;
	}
	
	public String view(){
		result = billTypeService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = billTypeService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		BillType dbBean = billTypeService.getBeanById(billType.getId()).getValue();
		BeanUtil.copyProperties(billType, dbBean);
		result = billTypeService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = billTypeService.deleteById(id);
		} else if(ids!=null){
			result = billTypeService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(BillType.class));
	}
	
	@Override
	protected List<BillType> getListByFilter(Filter fitler) {
		return billTypeService.getListByFilter(fitler).getValue();
	}
	
	
	public BillType getBillType() {
		return billType;
	}

	public void setBillType(BillType billType) {
		this.billType = billType;
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

	public void setBillTypeService(BillTypeService billTypeService) {
		this.billTypeService = billTypeService;
	}
	
	public Result getResult() {
		return result;
	}
	
	public List<BillType> getBillTypeList() {
		return billTypeList;
	}

	public void setBillTypeList(List<BillType> billTypeList) {
		this.billTypeList = billTypeList;
	}

}
