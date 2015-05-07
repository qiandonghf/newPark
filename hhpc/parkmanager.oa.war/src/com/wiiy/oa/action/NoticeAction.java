package com.wiiy.oa.action;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.dto.NoticeDto;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dto.UserNoticeDto;
import com.wiiy.oa.entity.Notice;
import com.wiiy.oa.entity.NoticeAtt;
import com.wiiy.oa.entity.UserNotice;
import com.wiiy.oa.preferences.enums.NoticeStatusEnum;
import com.wiiy.oa.service.NoticeAttService;
import com.wiiy.oa.service.NoticeService;
import com.wiiy.oa.service.UserNoticeService;

/**
 * @author my
 */
public class NoticeAction extends JqGridBaseAction<Notice>{
	
	private NoticeService noticeService;
	private NoticeAttService noticeAttService;
	private UserNoticeService userNoticeService;

	public void setUserNoticeService(UserNoticeService userNoticeService) {
		this.userNoticeService = userNoticeService;
	}

	private Result result;
	private Notice notice;
	private List<Notice> list;
	private List<UserNoticeDto> undList;
	private Long id;
	private String ids;
	private String attAddress;
	private String attNames = "";
	private String attSizes = "";
	private String attPaths = "";
	private String totalCount;
	private String path = "";
	private String fileName ="";
	private InputStream inputStream;
	
	private List<NoticeDto> noticeList = new ArrayList<NoticeDto>();
	private NoticeDto noticeDto = new NoticeDto();

	/*public String rmiSave(){
		RmiNotice rmiNotice = new RmiNotice();
		noticeDto.setCenter("NO");
		noticeDto.setContent(notice.getContent());
		noticeDto.setIssuer(notice.getIssuer());
		noticeDto.setIncubator(notice.getIncubator());
		noticeDto.setTime(notice.getIssueTime());
		noticeDto.setTitle(notice.getName());
		result = rmiNotice.saveNotice(noticeDto);
		return JSON;
	}
	
	public String initNoticeList(){
		RmiNotice rmiNotice = new RmiNotice();
		noticeList = rmiNotice.getNoticeList();
		return JSON;
	}
	
	public String viewById(){
		RmiNotice rmiNotice = new RmiNotice();
		noticeList = rmiNotice.getNoticeById(id);
		if(noticeList!=null){
			noticeDto = noticeList.get(0);
			if(noticeDto.getNoticeAttList()!=null){
				for (NoticeAttDto noticeAtt : noticeDto.getNoticeAttList()) {
					attNames += noticeAtt.getName()+",";
					attSizes += noticeAtt.getSize()+",";
					attPaths += noticeAtt.getNewName()+",";
				}
				if(attNames.length()>0){
					attNames = attNames.substring(0, attNames.length()-1);
					attSizes = attSizes.substring(0, attSizes.length()-1);
					attPaths = attPaths.substring(0, attPaths.length()-1);
				}
			}
		}
		result = Result.value(noticeList.get(0));
		return "viewOnDesktop";
	}*/
	
	public String countNotice(){
		undList = new ArrayList<UserNoticeDto>();
		list = noticeService.getListByFilter(new Filter(Notice.class).eq("state", NoticeStatusEnum.ISSUED).le("issueTime", new Date()).orderBy("issueTime", Filter.DESC).maxResults(15)).getValue();
		/*for(Notice n:list){
			UserNoticeDto und = new UserNoticeDto();
			UserNotice un = userNoticeService.getBeanByFilter(new Filter(UserNotice.class).eq("userId", OaActivator.getSessionUser().getId()).eq("noticeId", n.getId())).getValue();
			if(null!=un){
				und.setName(n.getName());
				und.setContent(n.getContent());
				und.setIssuer(n.getIssuer());
				und.setIssueTime(n.getIssueTime().toString());
				und.setUserView("YES");
				und.setState(n.getState().getTitle());
				undList.add(und);
			}
			
		}
		totalCount = noticeService.getRowCount()-undList.size()+"";*/
		totalCount = list.size()+"";
		return JSON;
	}
	
	public String listDesktop(){
		list = noticeService.getListByFilter(new Filter(Notice.class).eq("state", NoticeStatusEnum.ISSUED).le("issueTime", new Date()).orderBy("issueTime", Filter.DESC).maxResults(15)).getValue();
		undList = new ArrayList<UserNoticeDto>();
		for(Notice n:list){
			UserNoticeDto und = new UserNoticeDto();
			UserNotice un = userNoticeService.getBeanByFilter(new Filter(UserNotice.class).eq("userId", OaActivator.getSessionUser().getId()).eq("noticeId", n.getId())).getValue();
			if(null!=un){
				und.setId(n.getId());
				und.setName(n.getName());
				und.setContent(n.getContent());
				und.setIssuer(n.getIssuer());
				und.setIssueTime(n.getIssueTime().toString());
				und.setUserView("YES");
				und.setState(n.getState().getTitle());
			}else{
				und.setId(n.getId());
				und.setName(n.getName());
				und.setContent(n.getContent());
				und.setIssuer(n.getIssuer());
				und.setIssueTime(n.getIssueTime().toString());
				und.setUserView("NO");
				und.setState(n.getState().getTitle());
			}
			undList.add(und);
		}
		return JSON;
	}
	
	/*public String export(){
		RmiNotice rmiNotice = new RmiNotice();
		byte[] file = rmiNotice.export(path);
		if (file != null) {
			System.out.println("文件存在!");
		}else{
			result = Result.failure("您请求的资源不存在 或 已被删除");
			return JSON;
		}
		inputStream = new ByteArrayInputStream(file);
		return "export";
	}*/
	
	public String save(){
		result = noticeService.save(notice,attAddress);
		return JSON;
	}
	
	public String view(){
		List<NoticeAtt> list = noticeAttService.getListByFilter(new Filter(NoticeAtt.class).eq("noticeId", id)).getValue();
		for (NoticeAtt noticeAtt : list) {
			attNames += noticeAtt.getName()+",";
			attSizes += noticeAtt.getSize()+",";
			attPaths += noticeAtt.getNewName()+",";
		}
		if(attNames.length()>0){
			attNames = attNames.substring(0, attNames.length()-1);
			attSizes = attSizes.substring(0, attSizes.length()-1);
			attPaths = attPaths.substring(0, attPaths.length()-1);
		}
		result = noticeService.getBeanById(id);
		UserNotice un = new UserNotice();
		un.setUserId(OaActivator.getSessionUser().getId());
		un.setNoticeId(id);
		userNoticeService.save(un);
		return VIEW;
	}
	
	public String edit(){
		List<NoticeAtt> list = noticeAttService.getListByFilter(new Filter(NoticeAtt.class).eq("noticeId", id)).getValue();
		for (NoticeAtt noticeAtt : list) {
			attNames += noticeAtt.getName()+",";
			attSizes += noticeAtt.getSize()+",";
			attPaths += noticeAtt.getNewName()+",";
		}
		if(attNames.length()>0){
			attNames = attNames.substring(0, attNames.length()-1);
			attSizes = attSizes.substring(0, attSizes.length()-1);
			attPaths = attPaths.substring(0, attPaths.length()-1);
		}
		result = noticeService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Notice dbBean = noticeService.getBeanById(notice.getId()).getValue();
		BeanUtil.copyProperties(notice, dbBean);
		result = noticeService.update(dbBean,attAddress);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = noticeService.deleteById(id);
		} else if(ids!=null){
			result = noticeService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(Notice.class));
	}
	
	@Override
	protected List<Notice> getListByFilter(Filter fitler) {
		return noticeService.getListByFilter(fitler).getValue();
	}
	
	
	public Notice getNotice() {
		return notice;
	}

	public void setNotice(Notice notice) {
		this.notice = notice;
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

	public void setNoticeService(NoticeService noticeService) {
		this.noticeService = noticeService;
	}
	
	public Result getResult() {
		return result;
	}

	public String getAttAddress() {
		return attAddress;
	}

	public void setAttAddress(String attAddress) {
		this.attAddress = attAddress;
	}

	public String getAttNames() {
		return attNames;
	}

	public void setAttNames(String attNames) {
		this.attNames = attNames;
	}

	public String getAttSizes() {
		return attSizes;
	}

	public void setAttSizes(String attSizes) {
		this.attSizes = attSizes;
	}

	public String getAttPaths() {
		return attPaths;
	}

	public void setAttPaths(String attPaths) {
		this.attPaths = attPaths;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public void setNoticeAttService(NoticeAttService noticeAttService) {
		this.noticeAttService = noticeAttService;
	}

	public String getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}

	public List<Notice> getList() {
		return list;
	}

	public void setList(List<Notice> list) {
		this.list = list;
	}

	public List<UserNoticeDto> getUndList() {
		return undList;
	}

	public void setUndList(List<UserNoticeDto> undList) {
		this.undList = undList;
	}


	public List<NoticeDto> getNoticeList() {
		return noticeList;
	}

	public void setNoticeList(List<NoticeDto> noticeList) {
		this.noticeList = noticeList;
	}

	public NoticeDto getNoticeDto() {
		return noticeDto;
	}

	public void setNoticeDto(NoticeDto noticeDto) {
		this.noticeDto = noticeDto;
	}
	
	public InputStream getInputStream() {
		return inputStream;
	}
}
