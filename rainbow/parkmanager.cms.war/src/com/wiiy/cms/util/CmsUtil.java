package com.wiiy.cms.util;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import com.sun.syndication.feed.synd.SyndEntry;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.FeedException;
import com.sun.syndication.io.SyndFeedInput;
import com.sun.syndication.io.XmlReader;
import com.wiiy.cms.dto.WebContentDto;
import com.wiiy.cms.dto.WebInfoDto;

public class CmsUtil {

	public static WebInfoDto getInfoByURL(String link){
		try{
			WebInfoDto wi  = new WebInfoDto();
			URL url = new URL(link);
			XmlReader reader = new XmlReader(url);  
			SyndFeedInput input = new SyndFeedInput(); 
			SyndFeed feed = input.build(reader);
			wi.setId(Long.parseLong(feed.getTitle().split(",")[0]));
			wi.setTitle(feed.getTitle().split(",")[1]);
			wi.setLink(feed.getLink());
			List<WebContentDto> dtoList = new ArrayList<WebContentDto>();
			List<SyndEntry> entries = feed.getEntries();
			for(SyndEntry se : entries){
				WebContentDto w = new WebContentDto();
				w.setTitle(se.getTitle());
				w.setLink(se.getLink());
				w.setPublishedDate(se.getPublishedDate());
				if(se.getAuthor().split("`_`").length>1){
					w.setContentId(se.getAuthor().split("`_`")[0]);
					w.setWebInfoId(Long.parseLong(se.getAuthor().split("`_`")[1]));
				}else{
					w.setImage(se.getAuthor());
				}
				if(se.getUri().split("`_`").length>1){
					w.setMemo(se.getUri().split("`_`")[1]);
				}
				dtoList.add(w);
			}
			wi.setWebContentDtoList(dtoList);
			return wi;
		}catch (Exception e) {
			return null;
		}
	}
	
	public static void main(String[] args) throws IOException, IllegalArgumentException, FeedException {
		URL url = new URL("http://127.0.0.1:96/parkmanager.cloudService/rss!news.action?id=2");   
		 // 读取Rss源   
		   XmlReader reader = new XmlReader(url);   
		  // System.out.println("Rss源的编码格式为：" + reader.getEncoding());   
		   SyndFeedInput input = new SyndFeedInput();   
		   // 得到SyndFeed对象，即得到Rss源里的所有信息   
		   SyndFeed feed = input.build(reader);
		   
		   System.out.println(feed.getTitle());
		   System.out.println(feed.getLink());
		   System.out.println(feed.getDescription());
		   List<SyndEntry> entries = feed.getEntries();
		   System.out.println("----------------------------------------");
		   for(SyndEntry se : entries){
			   System.out.println(se.getTitle());
			   System.out.println(se.getLink());
			   System.out.println(se.getPublishedDate());
			   System.out.println(se.getAuthor());
			   System.out.println(se.getUri());
			   System.out.println("----------------------------------------");
		   }
	}


	public static List<WebInfoDto> getInfoList(String link){
		try{
			List<WebInfoDto> list = new ArrayList<WebInfoDto>();
			URL url = new URL(link);
			XmlReader reader = new XmlReader(url);  
			SyndFeedInput input = new SyndFeedInput(); 
			SyndFeed feed = input.build(reader);
			String memo = feed.getTitle();
			if(memo.split(",")!=null){
				String[] params = memo.split(",");
				for(String param : params){
					WebInfoDto w = new WebInfoDto();
					w.setId(Long.parseLong(param.split(":")[0]));
					w.setTitle(param.split(":")[1]);
					list.add(w);
				}
			}
			return list;
		}catch (Exception e) {
			return null;
		}
	}

}
