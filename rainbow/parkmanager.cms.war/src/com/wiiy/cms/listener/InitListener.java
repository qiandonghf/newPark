package com.wiiy.cms.listener;

import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.wiiy.cloud.capture.job.NewsJob;
import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.entity.Article;
import com.wiiy.cms.service.ArticleService;
import com.wiiy.core.dto.DocumentDto;
import com.wiiy.core.service.export.LuceneService;

public class InitListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		
	}

	@Override
	public void contextInitialized(ServletContextEvent e) {
//		new Timer().schedule(new JobTask(e), 1000*60);//延迟启动
	}
	
	class JobTask extends TimerTask{
		
		private ServletContextEvent servletContextEvent;
		public JobTask(ServletContextEvent servletContextEvent) {
			this.servletContextEvent = servletContextEvent;
		}
		@Override
		public void run() {
//		System.out.println("-----------------------------------------");
//			System.out.println("InitListener.contextInitialized()");
//			System.out.println("-----------------------------------------");
//			System.out.println("启动文章抓取JOB");
//			ApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(servletContextEvent.getServletContext());
//			new NewsJob(applicationContext);
//			ApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(servletContextEvent.getServletContext());
//			ArticleService articleService = applicationContext.getBean(ArticleService.class);
//			List<Article> articleList = articleService.getList().getValue();
//			List<DocumentDto> dtoList = new ArrayList<DocumentDto>();
//			if(articleList!=null){
//				for (Article article : articleList) {
//					DocumentDto dto = new DocumentDto();
//					dto.setId("article"+article.getId());
//					dto.setTitle(article.getTitle());
//					dto.setContent(article.getContentText());
//					dto.setUrl("parkmanager.cms/article!view.action?id="+article.getId());
//					dtoList.add(dto);
//				}
//			}
			
			//CmsActivator.getService(LuceneService.class).createIndex(dtoList);
		}
		
	}

}
