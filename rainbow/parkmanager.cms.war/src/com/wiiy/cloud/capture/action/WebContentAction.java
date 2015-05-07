package com.wiiy.cloud.capture.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.rsslibj.elements.Channel;
import com.sun.syndication.feed.synd.SyndContent;
import com.sun.syndication.feed.synd.SyndContentImpl;
import com.sun.syndication.feed.synd.SyndEntry;
import com.sun.syndication.feed.synd.SyndEntryImpl;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.feed.synd.SyndFeedImpl;
import com.sun.syndication.io.FeedException;
import com.sun.syndication.io.SyndFeedOutput;
import com.wiiy.cloud.capture.dto.WebContentDto;
import com.wiiy.cloud.capture.entity.Column;
import com.wiiy.cloud.capture.entity.WebContent;
import com.wiiy.cloud.capture.entity.WebContentConfig;
import com.wiiy.cloud.capture.entity.WebInfo;
import com.wiiy.cloud.capture.service.ColumnService;
import com.wiiy.cloud.capture.service.WebContentConfigService;
import com.wiiy.cloud.capture.service.WebContentService;
import com.wiiy.cloud.capture.service.WebInfoService;
import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;

public class WebContentAction extends JqGridBaseAction<WebContent>{
	private WebContentService webContentService;
	private WebInfoService webInfoService;
	private WebContentConfigService webContentConfigService;
	private ColumnService columnService;
	
	private List<WebContent> webContents;
	private List<WebContentDto> contentDtos;
	
	private String ids;
	private Long id;
	private Result result;
	
	private Pager pager;
	private Integer webContentSize;
	private Integer showRows = 14;

	public String xmlData() throws IOException{
		try{
			List<WebInfo> webInfoList = new ArrayList<WebInfo>();
			if(ids!=null){
				for(String id : ids.split(",")){
					Long lid = Long.parseLong(id);
					WebInfo w = webInfoService.getBeanById(lid).getValue();
					webInfoList.add(w);
				}
			}else{
				webInfoList = webInfoService.getList().getValue();
			}
			Channel channel=new Channel();
			for(WebInfo webInfo : webInfoList){
				List<WebContent> list = webContentService.getListByFilter(new Filter(WebContent.class).maxResults(15).eq("webInfoId", webInfo.getId()).orderBy("modifyTime", Filter.DESC)).getValue();
				channel.setDescription(webInfo.getName());
				channel.setLink(webInfo.getUrl());
				channel.setTitle(webInfo.getName());
				channel.setDcPublisher(webInfo.getCreator());
				for(WebContent w : list){
					channel.addItem(w.getUrl(), w.getReleaseDate()+"",w.getTitle());
				}
			}
			String rss = channel.getFeed("rss");
			
			ServletActionContext.getResponse().setContentType("text/xml;charset=utf8");
			PrintWriter writer=ServletActionContext.getResponse().getWriter();
			writer.write(rss);
			writer.close();
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		return null;
	}
	
	public String list(){
		List<WebInfo> list = webInfoService.getList().getValue();
		String memo = "";
		if(list.size()>0 && list!=null){
			for(WebInfo w : list){
				memo += w.getId()+":"+w.getName()+",";
			}
		}
		if(memo.endsWith(","))memo = memo.substring(0, memo.length()-1);
		SyndFeed feed = new SyndFeedImpl();
		feed = createList(memo);
		outputRssFeed(ServletActionContext.getResponse(), feed); 
		return null;
	}
	public String acceptance(){
	    WebContent wc = webContentService.getBeanById(id).getValue();
	    if(wc != null){
	    	wc.setHear("Yes");
	    }
	    result = webContentService.update(wc);
	    //result.setMsg("受理成功");
		return JSON;
	}
	public String unAcceptance(){
		WebContent wc = webContentService.getBeanById(id).getValue();
	    if(wc != null){
	    	wc.setHear("No");
	    }
	    result = webContentService.update(wc);
	    //result.setMsg("已经取消受理");
		return JSON ;
	}
	public String news(){
		WebInfo webInfo = new WebInfo();
		if(id!=null){
			webInfo = webInfoService.getBeanById(id).getValue();
		}
		SyndFeed feed = new SyndFeedImpl();
		List<WebContent> list = webContentService.getListByFilter(new Filter(WebContent.class).maxResults(15).eq("webInfoId", webInfo.getId()).orderBy("releaseDate", Filter.DESC).isNull("content")).getValue();
		WebContent w = webContentService.getBeanByFilter(new Filter(WebContent.class).notNull("content").eq("webInfoId", webInfo.getId())).getValue();
		feed = createFeed(list,w,webInfo);
		outputRssFeed(ServletActionContext.getResponse(), feed); 
		return null;
	}
	
	private Boolean outputRssFeed(HttpServletResponse response, SyndFeed feed) {
		boolean result = false;    
        feed.setFeedType("rss_2.0");    
        response.setContentType("application/xml; charset=UTF-8");    
        SyndFeedOutput output = new SyndFeedOutput();    
        try {    
            output.output(feed, response.getWriter());    
            result = true;    
        } catch (IOException e) {    
            e.printStackTrace();    
        } catch (FeedException e) {    
            e.printStackTrace();    
        }    
        return result;  
	}

	public SyndFeed createFeed(List<WebContent> news ,WebContent w,WebInfo webInfo) {    
	    SyndFeed feed = new SyndFeedImpl();    
	    feed.setTitle(webInfo.getId()+","+webInfo.getName());    
	    feed.setLink(webInfo.getUrl());    
	    feed.setDescription("新闻");    
	    feed.setEntries(getEntries(news,w));    
	    return feed;    
	}   
	
	public SyndFeed createList(String memo){
		 SyndFeed feed = new SyndFeedImpl();    
		 feed.setTitle(memo);    
		 feed.setLink("");    
	     feed.setDescription("网站列表");    
		 return feed;  
	}
	
	public List<SyndEntry> getEntries(List<WebContent> news,WebContent w) {    
	   List<SyndEntry> entries = new ArrayList<SyndEntry>();  
       SyndEntry entry;    
       SyndContent description;    
       for (WebContent dto : news) {    
           entry = new SyndEntryImpl();    
           entry.setTitle(dto.getTitle());    
           entry.setLink(dto.getUrl());    
           entry.setPublishedDate(dto.getReleaseDate());   
           entry.setUri("mx`_`"+dto.getContent());
           entry.setAuthor(dto.getContentId()+"`_`"+dto.getWebInfoId());
           description = new SyndContentImpl();    
           description.setType("text/html");    
           description.setValue(dto.getContent());    
           
               
           entry.setDescription(description);    
           entries.add(entry);    
       }    
       
       entry = new SyndEntryImpl();    
       entry.setTitle(w.getTitle());    
       entry.setLink(w.getUrl());    
       entry.setPublishedDate(w.getReleaseDate());   
       entry.setUri("mx`_`"+w.getContent());
       entry.setAuthor(w.getContentId());
       description = new SyndContentImpl();    
       description.setType("text/html");    
       description.setValue(w.getContent());    
       entry.setDescription(description);  
       
       entries.add(entry);   
       return entries;    
	}   
	
	/**
	 * 工作台新闻总页码
	 */
	public String counts(){
		Filter filter = new Filter(WebContent.class);
		filter.orderBy("hear", Filter.ASC);
		result = webContentService.getRowCount(filter);
		if(result.isSuccess()){
			webContentSize = (Integer)result.getValue();
		}else{
			webContentSize = 0;
		}
		if(page!=0){
			pager = new Pager(page,showRows);
		} else {
			pager = new Pager(1,showRows);
		}
		pager.setRecords(webContentSize);
		return JSON;
	}
	
	/**
	 * 工作台新闻列表
	 */
	public String desktopList(){
		Filter filter = new Filter(WebContent.class);
		filter.orderBy("hear", Filter.ASC);
		if(page!=0){
			pager = new Pager(page,showRows);
		} else {
			pager = new Pager(1,showRows);
		}
		filter.pager(pager);
		filter.createAlias("webInfo", "webInfo");
		String[] names = {"id","url","title","releaseDate","webInfo.columnId"}; 
		filter.include(names);
		webContents = webContentService.getListByFilter(filter).getValue();
		filter = new Filter(WebContentConfig.class).eq("userId", CmsActivator.getSessionUser().getId());
		filter.include("webContentId").include("userId");
		List<WebContentConfig> list = webContentConfigService.getListByFilter(filter).getValue();
		List<Column> columnList = columnService.getListByFilter(new Filter(Column.class)).getValue();
		Map<Long,Column> columnMap = new HashMap<Long, Column>();
		for (Column column : columnList) {
			columnMap.put(column.getId(), column);
		}
		
		contentDtos = new ArrayList<WebContentDto>();
		Map<Long,WebContentDto> map = new HashMap<Long,WebContentDto>();
		for (WebContent webContent : webContents) {
			WebContentDto dto = new WebContentDto();
			dto.setDate(webContent.getReleaseDate());
			dto.setId(webContent.getId());
			dto.setUrl(webContent.getUrl());
			dto.setTitle(webContent.getTitle());
			dto.setSource(columnMap.get(webContent.getWebInfo().getColumnId()).getName());
			dto.setContentCollect(false);
			map.put(dto.getId(), dto);
		}
		for (WebContentConfig webContentConfig : list) {
			if(map.get(webContentConfig.getWebContentId())!=null){
				map.get(webContentConfig.getWebContentId()).setContentCollect(true);
			}
		}
		Iterator it = map.keySet().iterator();  
		while (it.hasNext()) {  
           Long key = Long.valueOf(it.next().toString());
           contentDtos.add(map.get(key));  
		}
		return JSON;
	}
	
	public List<WebContentDto> getContentDtos() {
		return contentDtos;
	}

	public void setContentDtos(List<WebContentDto> contentDtos) {
		this.contentDtos = contentDtos;
	}

	/**
	 * 新闻列表
	 * @return
	 */
	public String listContent(){
		Filter filter = new Filter(WebContent.class);
		filter.orderBy("hear", Filter.ASC);
		return refresh(filter);
	}
	/**
	 * 视图
	 * @return
	 */
	public String view(){
		result = webContentService.getBeanById(id);
		return VIEW;
	}
	
	//新闻立即抓取
	public String doBackUp(){
		result = webContentService.doBackUp();
		return JSON;
	}
	/**
	 * 删除
	 * @return
	 */
	public String delete(){
		if(id!=null){
			result = webContentService.deleteById(id);
		}
		if(ids!=null){
			result = webContentService.deleteByIds(ids);
		}
		return JSON;
	}
	/**
	 * 根据条件来过滤列表
	 */
	@Override
	protected List<WebContent> getListByFilter(Filter filter) {
		return webContentService.getListByFilter(filter).getValue();
	}

	public void setWebContentService(WebContentService webContentService) {
		this.webContentService = webContentService;
	}

	public void setWebInfoService(WebInfoService webInfoService) {
		this.webInfoService = webInfoService;
	}

	public void setWebContentConfigService(
			WebContentConfigService webContentConfigService) {
		this.webContentConfigService = webContentConfigService;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}

	public List<WebContent> getWebContents() {
		return webContents;
	}

	public void setWebContents(List<WebContent> webContents) {
		this.webContents = webContents;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public Integer getWebContentSize() {
		return webContentSize;
	}

	public void setWebContentSize(Integer webContentSize) {
		this.webContentSize = webContentSize;
	}

	public void setColumnService(ColumnService columnService) {
		this.columnService = columnService;
	}
	
}
