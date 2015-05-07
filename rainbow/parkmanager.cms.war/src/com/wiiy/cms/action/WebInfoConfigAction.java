package com.wiiy.cms.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.dto.WebInfoDto;
import com.wiiy.cms.entity.WebInfoConfig;
import com.wiiy.cms.service.WebInfoConfigService;
import com.wiiy.cms.util.CmsUtil;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.core.service.export.AppConfig.Config;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class WebInfoConfigAction extends JqGridBaseAction<WebInfoConfig>{
	private WebInfoConfigService webInfoConfigService;
	private Long id;
	private String ids;
	private Result<WebInfoConfig> result;
	
	public String save(){
		if(ids!=null){
			WebInfoConfig w = webInfoConfigService.getBeanByFilter(
					new Filter(WebInfoConfig.class).
					eq("userId", id)).getValue();
			if(w!=null){
				w.setWebInfoIds(ids);
				result = webInfoConfigService.update(w);
			}else{
				WebInfoConfig wf = new WebInfoConfig();
				wf.setWebInfoIds(ids);
				wf.setUserId(id);
				result = webInfoConfigService.save(wf);
			}
		}
		return JSON;
	}
	
	public String list(){
		Config config = CmsActivator.getAppConfig().getConfig("newsList");
		String newsListURL = config.getParameter("name");
		List<WebInfoDto> dtoList = CmsUtil.getInfoList(newsListURL);
		WebInfoConfig w = webInfoConfigService.getBeanByFilter(new Filter(WebInfoConfig.class).eq("userId", CmsActivator.getSessionUser().getId())).getValue();
		List<Long> idList = new ArrayList<Long>();
		List<WebInfoDto> list = new ArrayList<WebInfoDto>();
		if(w!=null){
			if(dtoList!=null && dtoList.size()>0){
				for(WebInfoDto dto : dtoList){
					for(String id : w.getWebInfoIds().split(",")){
						Long wId = Long.parseLong(id);
							if(dto.getId()==wId){
								dto.setIsCheck(true);
							}else{
								dto.setIsCheck(false);
							}
					}
				list.add(dto);
				}
			}
		}
		ServletActionContext.getRequest().setAttribute("list", list);
		ServletActionContext.getRequest().setAttribute("idList", idList);
		return "webInfoList";
	}
	
	
	@Override
	protected List<WebInfoConfig> getListByFilter(Filter filter) {
		return webInfoConfigService.getListByFilter(filter).getValue();
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Result<WebInfoConfig> getResult() {
		return result;
	}

	public void setResult(Result<WebInfoConfig> result) {
		this.result = result;
	}
	public void setWebInfoConfigService(WebInfoConfigService webInfoConfigService) {
		this.webInfoConfigService = webInfoConfigService;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
}
