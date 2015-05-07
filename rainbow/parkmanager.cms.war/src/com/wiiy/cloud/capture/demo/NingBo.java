package com.wiiy.cloud.capture.demo;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.context.ApplicationContext;

import com.wiiy.cloud.capture.dto.WebDto;
import com.wiiy.cloud.capture.entity.WebContent;
import com.wiiy.cloud.capture.entity.WebInfo;
import com.wiiy.cloud.capture.job.WebJob;
import com.wiiy.cloud.capture.service.WebContentService;
import com.wiiy.cloud.capture.util.WebUtil;
import com.wiiy.hibernate.Filter;

public class NingBo extends WebJob {
	private WebContentService webContentService;

	public NingBo(ApplicationContext applicationContext) {
		super(applicationContext);
		webContentService = applicationContext.getBean(WebContentService.class);
		execute();
	}

	public static final String url = "http://www.nbbi.net/doc/xwzx/zxyw/";

	public static void main(String[] args) throws InstantiationException,
			ClassNotFoundException, IllegalAccessException, IOException {
		// Channel channel=new Channel();
		// channel.setDescription("宁波孵化器中心新闻");
		// channel.setLink("http://www.nbbi.net/doc/xwzx/zxyw/");
		// channel.setTitle("宁波");
		// channel.addItem("1","2","3").setDcDate(new Date());
		// System.out.println("The feed in RDF: "+channel.getFeed("rss"));

	}

	public static List<WebDto> fetch(String url, Map<String, String> params,
			String beginFlag, String endFlag, String basePath,
			String itemRegex, String idRegex, String dateRegex,
			String datePattern) {
		//获得页面内容
		String html = WebUtil.request(url, params);
		// System.out.println(html);
		return parse(html, beginFlag, endFlag, basePath, itemRegex, idRegex,
				dateRegex, datePattern);
	}
	protected void execute() {
		List<WebInfo> webInfoList = webContentService.getWebInfoList();
		loot: for (WebInfo webInfo : webInfoList) {
			Double period = 0D;
			period = webInfo.getPeriod();
			if (period == null) {
				period = 1D;
			}
			Long time = (new Date()).getTime()
					- webInfo.getModifyTime().getTime();
			Long updateTime = (long) (1000 * 60 * 60 * period * 1L);
			if (time < updateTime) {
				continue loot;
			}
			webContentService.updateWebInfoTime(webInfo);
			String url = webInfo.getUrl();
			Map<String, String> params = new HashMap<String, String>();
			if (webInfo.getParams() != null && webInfo.getParams().length() > 0) {
				String p = webInfo.getParams().trim();
				for (String itemParams : p.split(",")) {
					for (int i = 0; i < itemParams.split(":").length; i++) {
						params.put(itemParams.split(":")[0],
								itemParams.split(":")[1]);
					}
				}
			}
			String beginFlag = webInfo.getBeginFlag();
			String endFlag = webInfo.getEndFlag();
			String basePath = getBasePath(url);
			String itemRegex = webInfo.getItemRegex();
			String idRegex = webInfo.getIdRegex();
			String dateRegex = webInfo.getDateRegex();
			String datePattern = webInfo.getDatePattern();

			List<WebDto> list = fetch(url, params, beginFlag, endFlag,
					basePath, itemRegex, idRegex, dateRegex, datePattern);
			loop: for (WebDto dto : list) {
				List<WebContent> webContentList = webContentService
						.getListByFilter(
								new Filter(WebContent.class).eq("contentId",
										dto.getId())).getValue();
				if (webContentList.size() > 0 && webContentList != null) {
					continue loop;
				}
				WebContent webContent = new WebContent();
				webContent.setWebInfoId(webInfo.getId());
				webContent.setWebInfo(webInfo);
				webContent.setContentId(dto.getId());
				webContent.setUrl(dto.getUrl());
				webContent.setTitle(dto.getTitle());
				webContent.setReleaseDate(dto.getDate());
				webContentService.save(webContent);
			}
			/*
			 * WebContent wt = test(); List<WebContent> webContentList =
			 * webContentService.getListByFilter(new
			 * Filter(WebContent.class).eq("contentId",
			 * wt.getContentId())).getValue(); if(webContentList.size()==0 ||
			 * webContentList==null){ wt.setWebInfoId(webInfo.getId());
			 * wt.setWebInfo(webInfo); wt.setImageUrl(wt.getContentId());
			 * webContentService.save(wt); }else{ for(WebContent webContent
			 * :webContentList){
			 * if(!webContent.getContentId().equals(wt.getContentId())){
			 * webContent.setContent(wt.getContent());
			 * webContent.setTitle(wt.getTitle());
			 * webContent.setUrl(wt.getUrl());
			 * webContent.setContentId(wt.getContentId());
			 * wt.setImageUrl(wt.getContentId());
			 * webContentService.update(webContent); } } }
			 */
		}
	}

	public static WebContent test() {
		WebContent wt = new WebContent();
		String url = "http://www.nbbi.net/index.shtml";
		Map<String, String> params = new HashMap<String, String>();
		String beginFlag = "pic_arr[0]=\"";
		String endFlag = "link_arr[0]";
		String basePath = getBasePath(url);
		String html = WebUtil.request(url, params);
		int start = html.indexOf(beginFlag) + beginFlag.length();
		String content = html.substring(start, html.indexOf(endFlag, start));
		content = content.replaceAll(">\\s*<", "><");
		content = content.substring(0, content.length() - 4);
		String image = basePath + content;

		beginFlag = "link_arr[0]=\"";
		endFlag = "text_arr[0]";
		start = html.indexOf(beginFlag) + beginFlag.length();
		content = html.substring(start, html.indexOf(endFlag, start));
		content = content.replaceAll(">\\s*<", "><");
		content = content.substring(0, content.length() - 4);
		String url2 = basePath + content;

		beginFlag = "text_arr[0]=\"";
		endFlag = "pic_arr[1]";
		start = html.indexOf(beginFlag) + beginFlag.length();
		content = html.substring(start, html.indexOf(endFlag, start));
		content = content.replaceAll(">\\s*<", "><");
		content = content.substring(0, content.length() - 4);
		String title = content;

		String html2 = WebUtil.request(url2, params);
		beginFlag = "border=0></P>";
		endFlag = "<!--ZJEG_RSS.content.end-->";
		start = html2.indexOf(beginFlag) + beginFlag.length();
		content = html2.substring(start, html2.indexOf(endFlag, start));
		content = content.substring(7, content.length() - 4);
		content = content.replaceAll("\\s*|\t|\r|\n", "");
		content = content.replaceAll("</P><P>", "");
		content = content.replaceAll("<P>", "");
		content = content.replaceAll("</P>", "");
		content = content.replaceAll("  ", "");

		wt.setContentId(image);
		wt.setUrl(url2);
		wt.setTitle(title);
		wt.setContent(content);
		return wt;
	}

	public static String getBasePath(String url) {
		int start = url.indexOf(".", url.indexOf("."));
		int end = url.indexOf("?", start);
		if (end == -1)
			end = url.indexOf("/", start);
		return url.substring(0, end);
	}

	public static List<WebDto> parse(String html, String beginFlag,
			String endFlag, String basePath, String itemRegex, String idRegex,
			String dateRegex, String datePattern) {
		List<WebDto> list = new ArrayList<WebDto>();
		//获得开始截取的位置
		int start = html.indexOf(beginFlag) + beginFlag.length();
		//得到我们想要的内容
		String content = html.substring(start, html.indexOf(endFlag, start));
		// content = content.replaceAll(">\\s*<", "><");
		List<String> itemList = WebUtil.compiles(content, itemRegex);
		for (String item : itemList) {
			WebDto dto = new WebDto();
			dto.setUrl(WebUtil.compile(item, WebUtil.REGEX_A, 1));
			dto.setTitle(WebUtil.compile(item, WebUtil.REGEX_A, 2));
			dto.setId(WebUtil.compile(item, idRegex, 0));
			String date = WebUtil.compile(item, dateRegex, 0);
			if (date.length() > 4) {
				date = date.replaceAll("_", "-");
			}
			dto.setDate(parseDate(datePattern, date));
			list.add(dto);
		}
		return list;
	}

	/**
	 * 获取文章内容
	 * 
	 * @param url
	 *            文章路径
	 * @param beginRegex
	 *            开始区域
	 * @param endRegex
	 *            结束区域
	 * @param headPath
	 *            头部路径
	 * @return
	 */
	public static String parseContent(String url, String beginRegex,
			String endRegex, String headPath) {
		try {
			URL path = new URL(url);
			URLConnection uc = path.openConnection();
			BufferedReader br = new BufferedReader(new InputStreamReader(
					uc.getInputStream()));
			String text = null;
			String str = "";
			while ((text = br.readLine()) != null) {
				str = str + text;

			}
			// 获得开始区域的位置
			int start = str.indexOf(beginRegex) + beginRegex.length();
			// 获得开始到结束之间的内容
			String content = str.substring(start, str.indexOf(endRegex)
					+ endRegex.length());
			ArrayList<String> imgList = new ArrayList<String>();
			String regEx = "<IMG.*?src=\"(.*?)\"";
			Pattern pat = Pattern.compile(regEx);
			Matcher mat = pat.matcher(content);
			while (mat.find()) {
				String imgPath = mat.group(1);
				if (imgPath.indexOf("http://") < 0) {					
					imgPath = headPath + imgPath;
				}
				imgList.add(imgPath);
			}
			for (int i = 0; i < imgList.size(); i++) {
				String filePath = imgList.get(0);
				//如果文章内容中间有图片,则把内容中的图片下载到本地
				saveImg(filePath);
			}
			// 检测是否是标签的正则
			String regexstr = "<[^>]*>";
			Pattern pattern = Pattern.compile(regexstr);
			Matcher matcher = pattern.matcher(content);
			// 将内容里面的所有标签替换为空
			String aa = matcher.replaceAll("");
			String bb = aa.replaceAll("&nbsp;", "");
			System.out.println(bb);
			br.close();
			// 设置网络连接超时时间
			// uc.setConnectTimeout(1000*10);
		} catch (MalformedURLException e) {
			// 请求路径异常
			e.printStackTrace();
		} catch (IOException e) {
			// 打开连接时异常
			e.printStackTrace();
		}
		return "";
	}
    /**
     * 保存文章内容中的图片
     * @param fileUrl 内容中的图片路径
     * @param imgName 图片的名称
     * @return
     */
	public static boolean saveImg(String fileUrl) {
		 String [] sa = fileUrl.split("/");
		 String imgName = sa[sa.length-1];
		try {
			//创建url对象
			URL url = new URL(fileUrl);
			try {
				//打开httpUrlConnection连接
				HttpURLConnection hc = (HttpURLConnection) url.openConnection();
				hc.setConnectTimeout(60000);
				//创建输入流
				DataInputStream in = new DataInputStream(hc.getInputStream());
				if(imgName==null)return false;
				//获取系统所在目录
				String root = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/upload/";
				//"/"的转义
				imgName.replace("/", File.separator);
				try {
					//创建文件
					File file = new File(root+imgName);
					if(!file.exists()){
						if(!file.getParentFile().exists()){
							file.getParentFile().mkdirs();
						}
						file.createNewFile();
					}
					//创建输出流
					FileOutputStream fileOut = new FileOutputStream(file);
					byte[] array = new byte[1024 * 64];
					int length;
					while ((length = in.read(array)) != -1) {
						//输出文件信息
						fileOut.write(array, 0, length);
					}
					//关闭输入流
					in.close();
					//关闭输出流
					fileOut.close();
					//停止连接
					hc.disconnect();
				} catch (Exception e) {
					e.printStackTrace();
				}

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace() ;
				return false ;
			}
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false ;
			}
		return true;
	}

	public static Date parseDate(String pattern, String source) {
		/*
		 * Calendar c = Calendar.getInstance(); c.setTime(new Date());
		 * if(pattern.indexOf("y")==-1) { pattern += "-yyyy"; source +=
		 * "-"+c.get(Calendar.YEAR); } if(pattern.indexOf("M")==-1) { pattern +=
		 * "-MM"; source += "-"+c.get(Calendar.MONTH)+1; }
		 * if(pattern.indexOf("dd")==-1) { pattern += "-dd"; source +=
		 * "-"+c.get(Calendar.DAY_OF_MONTH); } if(pattern.indexOf("h")==-1 &&
		 * pattern.indexOf("H")==-1) { pattern += "-HH"; source +=
		 * "-"+c.get(Calendar.HOUR_OF_DAY); } if(pattern.indexOf("m")==-1) {
		 * pattern += "-mm"; source += "-"+c.get(Calendar.MINUTE); }
		 * if(pattern.indexOf("s")==-1) { pattern += "-ss"; source +=
		 * "-"+c.get(Calendar.SECOND); }
		 */
		if (source.length() <= 0) {
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			source = c + "";
		}
		if (pattern.length() <= 0) {
			pattern = "yyyy-MM-dd";
		}
		try {
			return new SimpleDateFormat(pattern).parse(source);
		} catch (ParseException e) {
			return new Date();
		}
	}

}
