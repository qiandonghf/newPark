package com.wiiy.cloud.capture.job;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.context.ApplicationContext;

import com.wiiy.cloud.capture.entity.WebContent;
import com.wiiy.cloud.capture.entity.WebInfo;
import com.wiiy.cloud.capture.service.WebContentService;
import com.wiiy.cloud.capture.service.WebInfoService;


public class NewsJob extends WebJob {
	private  WebContentService webContentService;
	private  WebInfoService webInfoService ;
	public NewsJob(ApplicationContext applicationContext) {
		super(applicationContext);
		webContentService = applicationContext.getBean(WebContentService.class);
		webInfoService = applicationContext.getBean(WebInfoService.class);
		execute();
		//deleteNews();
		//timeNews();
	}
	/**
	 * 在一定的时间间隔内,重新抓取新闻信息
	 */
	@Override
	protected void execute() {
		webContentService.doBackUp();	
	}
	/**
	 * 定时处理一些过期的数据
	 * 删掉过时的新闻
	 */
	public void deleteNews(){
		List<WebContent> list = webContentService.getList().getValue();
		for (int i = 0; i < list.size(); i++) {
			WebContent webContent = list.get(i);
			Date dateDB = webContent.getCreateTime() ;
			Date newDate = new Date();
			long time = newDate.getTime() - dateDB.getTime();
			//把时间差转换为天数
			long dd = time/1000/60/60/24 ;
			//如果时间差大于15天,就删除掉该条记录
			if (dd>15) {
				webContentService.delete(webContent);
			}
		}
		
	}
	public void timeNews(){
		List<WebInfo> list = webInfoService.getList().getValue();
		for (int i = 0; i < list.size(); i++) {
			WebInfo webInfo = list.get(i);
			double date = webInfo.getPeriod();
			System.out.println(date+"------------------");
		}
	}

}
