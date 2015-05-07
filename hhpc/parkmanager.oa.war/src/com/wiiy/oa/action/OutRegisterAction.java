package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.OutRegister;
import com.wiiy.oa.service.OutRegisterService;

public class OutRegisterAction extends JqGridBaseAction<OutRegister> {
	private OutRegisterService outRegisterService;
	private OutRegister outRegister;
	private Result result;
	private Long id;
	private String ids;

	public String save() {
		result = outRegisterService.save(outRegister);
		return JSON;
	}

	public String view() {
		result = outRegisterService.getBeanById(id);
		return VIEW;
	}
	public String edit() {
		result = outRegisterService.getBeanById(id);
		return EDIT;
	}

	public String delete() {
		if (id != null) {
			result = outRegisterService.deleteById(id);
		} else if (ids != null) {
			result = outRegisterService.deleteByIds(ids);
		}
		return JSON;
	}

	public String update() {
		OutRegister dbBean = outRegisterService
				.getBeanById(outRegister.getId()).getValue();
		BeanUtil.copyProperties(outRegister, dbBean);
		result = outRegisterService.update(dbBean);
		return JSON;
	}

	public String list() {
		Filter filter = new Filter(OutRegister.class);
		return refresh(filter);
	}

	@Override
	protected List<OutRegister> getListByFilter(Filter fitler) {
		return outRegisterService.getListByFilter(fitler).getValue();
	}

	public OutRegister getOutRegister() {
		return outRegister;
	}

	public void setOutRegister(OutRegister outRegister) {
		this.outRegister = outRegister;
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

	public void setOutRegisterService(OutRegisterService outRegisterService) {
		this.outRegisterService = outRegisterService;
	}

}
