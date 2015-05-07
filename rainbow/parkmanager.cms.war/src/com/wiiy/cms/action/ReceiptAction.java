package com.wiiy.cms.action;

import java.util.List;

import com.wiiy.cms.entity.Receipt;
import com.wiiy.cms.service.ReceiptService;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class ReceiptAction extends JqGridBaseAction<Receipt>{
	
	private ReceiptService receiptService;
	@SuppressWarnings("rawtypes")
	private Result result;
	private Receipt receipt;
	private Long id;
	private String ids;
	
	public String save(){
		result = receiptService.save(receipt);
		return JSON;
	}
	
	public String view(){
		result = receiptService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = receiptService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Receipt dbBean = receiptService.getBeanById(receipt.getId()).getValue();
		BeanUtil.copyProperties(receipt, dbBean);
		result = receiptService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			ids = id+"";
		} else if(ids!=null){
			if (ids.indexOf(",") != -1) {
				id = Long.parseLong(ids.substring(0, ids.indexOf(",")));
			}else {
				id = Long.parseLong(ids);
			}
		}
		if (id != null) {
			receipt = receiptService.getBeanById(id).getValue();
			Long articleId = receipt.getArticleId();
			result = receiptService.deleteByIds(ids, articleId);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(Receipt.class);
		if (id != null) {
			filter.eq("articleId", id);
		}
		return refresh(filter);
	}
	
	@Override
	protected List<Receipt> getListByFilter(Filter fitler) {
		return receiptService.getListByFilter(fitler).getValue();
	}
	
	
	public Receipt getReceipt() {
		return receipt;
	}

	public void setReceipt(Receipt receipt) {
		this.receipt = receipt;
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

	public void setReceiptService(ReceiptService receiptService) {
		this.receiptService = receiptService;
	}
	
	@SuppressWarnings("rawtypes")
	public Result getResult() {
		return result;
	}

}
