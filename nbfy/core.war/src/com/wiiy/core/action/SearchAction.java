package com.wiiy.core.action;

import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.service.export.LuceneService;
import com.wiiy.core.service.export.Page;

public class SearchAction {
	
	private int pageNo;
	private String keyword;
	private Page page;
	
	public String execute() {
		page = new Page();
//		page.setPageSize(1);
		if(pageNo>0) page.setPageNo(pageNo);
		keyword = StringUtil.ISOToUTF8(keyword);
		CoreActivator.getService(LuceneService.class).search(keyword, page);
		return "success";
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
}
