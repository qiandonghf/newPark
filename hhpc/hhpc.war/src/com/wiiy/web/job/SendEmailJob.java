package com.wiiy.web.job;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;

import org.springframework.context.ApplicationContext;

import com.wiiy.cms.entity.Article;
import com.wiiy.cms.entity.ArticleType;
import com.wiiy.cms.entity.Mail;
import com.wiiy.cms.preferences.enums.ArticleKindEnum;
import com.wiiy.cms.service.ArticleService;
import com.wiiy.cms.service.ArticleTypeService;
import com.wiiy.cms.service.MailService;
import com.wiiy.cms.service.impl.ArticleServiceImpl;
import com.wiiy.cms.service.impl.ArticleTypeServiceImpl;
import com.wiiy.cms.service.impl.MailServiceImpl;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.web.Activator;
import com.wiiy.web.entity.EmailData;
import com.wiiy.web.enums.EmailDataType;
import com.wiiy.web.listener.InitListener;
import com.wiiy.web.service.EmailDataService;
import com.wiiy.web.service.impl.EmailDataServiceImpl;

public class SendEmailJob extends RepeatJob {
	private Long intervalTime = 604800000L;//唤醒间隔 7天
	protected ApplicationContext applicationContext;
	private EmailDataService emailDataService;
	private ArticleService articleService;
	private ArticleTypeService articleTypeService;
	private MailService mailService;//获取订阅网站邮件用户列表
	private SysEmailSenderPubService senderPubService;
	private EmailData sendData;
	private EmailData checkData;
	private Integer sendDate;
	private Long paramId;
	private String emailContent;
	private String subject = "HHPC邮件订阅";
	private String sendResult;
	private String rootPath;
	private final static String serviceURL = System.getProperty("rootLocation");

	
	public SendEmailJob(ApplicationContext applicationContext) {
		super(applicationContext);
		System.out.println("=====================serviceURL:"+serviceURL);
		this.applicationContext = applicationContext;
		emailDataService = applicationContext.getBean(EmailDataServiceImpl.class);
		articleService = applicationContext.getBean(ArticleServiceImpl.class);
		articleTypeService = applicationContext.getBean(ArticleTypeServiceImpl.class);
		mailService = applicationContext.getBean(MailServiceImpl.class);
		sendDate = InitListener.sendDate;
		paramId = InitListener.webID;
		rootPath = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/parkmanager.pb.hhpc.war/";
	}
	
	private EmailData createBean(EmailDataType type){
		EmailData data = null;
		if (emailDataService != null) {
			Filter filter = new Filter(EmailData.class);
			filter.eq("paramId", paramId);
			filter.eq("type", type);
			filter.orderBy("createTime", Filter.DESC);
			filter.maxResults(1);
			List<EmailData> list = emailDataService.getListByFilter(filter).getValue();
			if (list.size() > 0) {
				data = list.get(0);
			}
		}
		return data;
	}
	
	@Override
	public void init() {
		new Timer().schedule(new JobTask(), 10000,intervalTime);
	}
	
	/**
	 * 检查
	 * 1.未到发送日期,保存本次检查的日期
	 * 2.当前为发送日期,开始发送邮件
	 * 3.当前已经超过发送日期:
	 * 	3.1已发送,不做任何操作
	 * 	3.2 未发送,开始发送,记录本次发送日期
	 */
	@Override
	protected void execute() {
		while (senderPubService == null) {
			try {
			Thread.sleep(60000);
			senderPubService = Activator.getService(SysEmailSenderPubService.class);
			System.out.println("===============启动发送邮件JOB成功===============");
			} catch (Exception e) {
				System.out.println("===============启动发送邮件JOB失败,1分钟后重新启动===============");
			}
		}
		sendData = createBean(EmailDataType.SEND);//发送
		checkData = createBean(EmailDataType.CHECK);//每次唤醒记录
		/**
		 * 记录本次检查日期
		 */
		if(sendData == null){
			sendData = new EmailData();
			sendData.setType(EmailDataType.SEND);
			sendData.setParamId(paramId);
			sendEmal();
		}else {
			sendData.setLastTime(sendData.getCreateTime());
			sendEmal();
		}
		if(checkData == null){
			checkData = new EmailData();
			checkData.setType(EmailDataType.CHECK);
			checkData.setParamId(paramId);
			checkData.setContent(sendResult);
		}else {
			checkData.setLastTime(checkData.getCreateTime());
			String lastTime = dateFormat(checkData.getLastTime(),null);
			System.out.println("--------邮件发送JOB:上次唤醒时间:"+lastTime+"-----------");
			checkData.setContent(sendResult);
		}
		emailDataService.save(checkData);
		
	}
	
	/**
	 * 检测并发送邮件
	 */
	private void sendEmal() {
		if(checkEmail()){
			if(sendNow()){
				sendCompleted();
			}
		}else {
			System.out.println("--------邮件发送JOB:在指定发送邮件的日期内已发送,无需再发送-----------");
			sendResult = "检测未通过:在指定发送邮件的日期内已发送";
		}
	}
	
	/**
	 * 发送邮件
	 */
	private boolean sendNow(){
		List<Mail> mails = mailService.getListByFilter(
				new Filter(Mail.class).eq("paramId", paramId)).getValue(); 
		int begin = 0;
		int end = 0;
		if (mails != null && mails.size() > 0) {
			createEmailContent();
			end = mails.size();
			sendEmailLoop(mails, begin, end);
			sendResult = "检测通过:本次共发送"+mails.size()+"个用户";
			return true;
		}else {
			System.out.println("--------邮件发送JOB:没有订阅用户-----------");
			sendResult = "检测未通过:没有订阅用户";
			return false;
		}
	}
	
	/**
	 * 循环发送
	 * @param mails 需要发送的邮件用户
	 * @param begin 开始数(包含)
	 * @param end 结束(不包含)
	 */
	private void sendEmailLoop(
			List<Mail> mails,int begin,int end){
		for (int i = begin; i < end; i++) {
			Mail mail = mails.get(i);
			String url = mail.getEmail();
			if (!"".equals(url.trim())) {
				senderPubService.send(url, emailContent, subject);
			}
			try {
				Thread.sleep(30000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 是否需要发送邮件
	 * @return
	 */
	private boolean checkEmail(){
		if (sendData.getLastTime() == null) {
			return true;
		}
		String lastTime = dateFormat(sendData.getLastTime(),null);
		System.out.println("--------邮件发送JOB:上次发送时间:"+lastTime+"-----------");
		System.out.println("--------邮件发送JOB:每月的"+sendDate+"日发送邮件-----------");
		Calendar dt = Calendar.getInstance();
		dt.setTime(new Date());
		dt.set(Calendar.DAY_OF_MONTH, sendDate);
		dt.set(Calendar.HOUR_OF_DAY, 0);
		dt.set(Calendar.MINUTE, 0);
		dt.set(Calendar.SECOND, 0);
		dt.set(Calendar.MILLISECOND, 0);
		Long needDate = dt.getTime().getTime();
		Long lastDate = sendData.getLastTime().getTime();
		if (lastDate >= needDate) {
			return false;
		}else {
			return true;
		}
	}
	
	
	private void createEmailContent(){
		System.out.println("--------邮件发送JOB:开始生成邮件内容");
		emailContent = toHtml(rootPath+"web/msgRemindModule/subscribeModule.html");
		System.out.println(emailContent);
		System.out.println("--------邮件发送JOB:生成邮件内容完成");
	}
	
	private void sendCompleted(){
		System.out.println("--------邮件发送JOB:邮件发送完毕");
		sendData.setContent("邮件发送完毕");
		emailDataService.save(sendData);
	}
	
	/**
	 * 格式化日期
	 * @param date 要格式化的日期
	 * @param format 格式化的样式,默认(null)格式为:yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	private String dateFormat(Date date,String format){
		if (format == null) {
			format = "yyyy-MM-dd HH:mm:ss";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}
	
	
	 /** 
     * 根据本地模板生成静态页面 
	  * @param filePath 模版路经 
	  * @return 
	  */ 
	private String toHtml(String filePath) {
		String str = "";
		long beginDate = (new Date()).getTime();
		String createDate = dateFormat(new Date(), "yyyy/MM/dd");
		StringBuilder content;
		/**
		 * 新闻资讯
		 */
		Long xwzxId = 10L;
		List<Article> xwzxList = articleService.getListByFilter(
				new Filter(Article.class).
				eq("paramId", paramId).eq("typeId", xwzxId).eq("kind", ArticleKindEnum.LIST).
				eq("deleted", BooleanEnum.NO).eq("pubed", BooleanEnum.YES).
				orderBy("pubTime", Filter.DESC).maxResults(10)).getValue();
		content = new 
				StringBuilder("<p style=\"FONT-SIZE: 14px; COLOR: #0165ab; MARGIN: 0px 0px 10px\">[新闻资讯]<br/>");
		for (Article article : xwzxList) {
			content.append("<a style=\"COLOR: #0165ab\"");
			content.append("href=\""+serviceURL+"view.action?id="+article.getId()+"\" target=\"_blank\">");
			content.append(article.getTitle());
			content.append("</a><br/>");
		}
		content.append("</p><br/>");
		
		
		/**
		 * 政策导航
		 */
		Long zcdhId = 4L;
		Filter filter = new Filter(ArticleType.class);
		filter.eq("paramId", paramId).like("parentIds", "%,"+zcdhId+",%");
		List<ArticleType> types = articleTypeService.getListByFilter(filter).getValue();
		
		List<Article> zcdhList = articleService.getListByFilter(
				new Filter(Article.class).
				eq("paramId", paramId).eq("kind", ArticleKindEnum.LIST).
				in("typeId", createArrayFromList(types)).
				eq("deleted", BooleanEnum.NO).eq("pubed", BooleanEnum.YES).
				orderBy("pubTime", Filter.DESC).maxResults(10)).getValue();
		content.append("<p style=\"FONT-SIZE: 14px; COLOR: #0165ab; MARGIN: 0px 0px 10px\">[政策导航]<br/>");
		for (Article article : zcdhList) {
			content.append("<a style=\"COLOR: #0165ab\"");
			content.append("href=\""+serviceURL+"view.action?id="+article.getId()+"\" target=\"_blank\">");
			content.append(article.getTitle());
			content.append("</a><br/>");
		}
		content.append("</p><br/>");
		
		try {
			String tempStr = "";
			FileInputStream is = new FileInputStream(filePath);// 读取模块文件
			BufferedReader br = new BufferedReader(new InputStreamReader(is,"utf-8"));
			while ((tempStr = br.readLine()) != null)
				str = str + tempStr;
			is.close();
			str = str.replaceAll("###createDate###", createDate);
			str = str.replaceAll("###content###", content.toString());
			System.out.println("本次生成邮件内容共用时：" + ((new Date()).getTime() - beginDate)+ "ms");
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		return str;
	}
	
	private Object[] createArrayFromList(List<ArticleType> list){
		Object[] obj = null;
		if (list != null) {
			obj = new Object[list.size()];
			for (int i = 0; i < obj.length; i++) {
				obj[i] = list.get(i).getId();
			}
		}
		return obj;
	}
}
