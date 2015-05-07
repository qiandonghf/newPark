package com.wiiy.core.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.core.entity.DesktopItem;
import com.wiiy.core.service.DesktopItemService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class DesktopItemAction extends JqGridBaseAction<DesktopItem>{
	private DesktopItemService desktopItemService;
	private List<DesktopItem> desktopItemList;
	
	private Result result;
	
	public String list(){
		desktopItemList = desktopItemService.getList().getValue();
		
		return LIST;
	}

	
	
	
	@Override
	protected List<DesktopItem> getListByFilter(Filter filter) {
		return desktopItemService.getListByFilter(filter).getValue();
	}
	public void setDesktopItemService(DesktopItemService desktopItemService) {
		this.desktopItemService = desktopItemService;
	}
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}




	public List<DesktopItem> getDesktopItemList() {
		return desktopItemList;
	}




	public void setDesktopItemList(List<DesktopItem> desktopItemList) {
		this.desktopItemList = desktopItemList;
	}

}
