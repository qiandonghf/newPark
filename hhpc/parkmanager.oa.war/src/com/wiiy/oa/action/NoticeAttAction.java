package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.oa.entity.MeetingAtt;
import com.wiiy.oa.entity.NoticeAtt;
import com.wiiy.oa.service.NoticeAttService;

/**
 * @author my
 */
public class NoticeAttAction extends JqGridBaseAction<NoticeAtt>{
	
	private NoticeAttService noticeAttService;
	private Result result;
	private NoticeAtt noticeAtt;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = noticeAttService.save(noticeAtt);
		return JSON;
	}
	
	public String view(){
		result = noticeAttService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = noticeAttService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		NoticeAtt dbBean = noticeAttService.getBeanById(noticeAtt.getId()).getValue();
		BeanUtil.copyProperties(noticeAtt, dbBean);
		result = noticeAttService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = noticeAttService.deleteById(id);
		} else if(ids!=null){
			result = noticeAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(NoticeAtt.class);
		filter.createAlias("notice","notice");
		return refresh(filter);
	}
	
	@Override
	protected List<NoticeAtt> getListByFilter(Filter fitler) {
		return noticeAttService.getListByFilter(fitler).getValue();
	}
	
	
	public NoticeAtt getNoticeAtt() {
		return noticeAtt;
	}

	public void setNoticeAtt(NoticeAtt noticeAtt) {
		this.noticeAtt = noticeAtt;
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

	public void setNoticeAttService(NoticeAttService noticeAttService) {
		this.noticeAttService = noticeAttService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
