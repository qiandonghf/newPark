package com.wiiy.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.wiiy.cms.entity.Advicement;
import com.wiiy.cms.entity.Article;
import com.wiiy.cms.entity.ArticleAtt;
import com.wiiy.cms.entity.ArticleType;
import com.wiiy.cms.entity.ContactInfo;
import com.wiiy.cms.entity.Federation;
import com.wiiy.cms.entity.Mail;
import com.wiiy.cms.entity.Param;
import com.wiiy.cms.entity.Platform;
import com.wiiy.cms.entity.Receipt;
import com.wiiy.cms.entity.ReceiptAtt;
import com.wiiy.cms.entity.Resource;
import com.wiiy.cms.preferences.enums.ArticleKindEnum;
import com.wiiy.cms.service.AdvicementService;
import com.wiiy.cms.service.ArticleService;
import com.wiiy.cms.service.ArticleTypeService;
import com.wiiy.cms.service.ContactInfoService;
import com.wiiy.cms.service.FederationService;
import com.wiiy.cms.service.LinksService;
import com.wiiy.cms.service.MailService;
import com.wiiy.cms.service.ParamService;
import com.wiiy.cms.service.PlatformService;
import com.wiiy.cms.service.ReceiptAttService;
import com.wiiy.cms.service.ReceiptService;
import com.wiiy.cms.service.ResourceService;
import com.wiiy.cms.service.WaterMarkService;
import com.wiiy.commons.action.BaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.dto.UploadResult;
import com.wiiy.core.entity.User;
import com.wiiy.crm.entity.Agency;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerInfo;
import com.wiiy.crm.entity.Investment;
import com.wiiy.crm.entity.InvestmentArchiveAtt;
import com.wiiy.crm.entity.InvestmentDirector;
import com.wiiy.crm.entity.Product;
import com.wiiy.crm.preferences.enums.CustomerApplyState;
import com.wiiy.crm.preferences.enums.CustomerBaseEnum;
import com.wiiy.crm.service.AgencyService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.crm.service.InvestmentArchiveAttService;
import com.wiiy.crm.service.InvestmentDirectorService;
import com.wiiy.crm.service.InvestmentService;
import com.wiiy.crm.service.ProductService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.Document;
import com.wiiy.oa.service.DocumentService;
import com.wiiy.pb.entity.GardenApply;
import com.wiiy.pb.entity.GardenApplyAtt;
import com.wiiy.pb.preferences.enums.GardenApplyStateEnum;
import com.wiiy.pb.preferences.enums.GardenProjectStateEnum;
import com.wiiy.pb.service.GardenApplyAttService;
import com.wiiy.pb.service.GardenApplyService;
import com.wiiy.web.Activator;
import com.wiiy.web.dto.BaseDto;
import com.wiiy.web.listener.InitListener;
import com.wiiy.web.util.RandomValidateCode;

public class HomeAction extends BaseAction {
	private ArticleService articleService;
	private WaterMarkService waterMarkService;
	private ParamService paramService;
	private ContactInfoService contactInfoService;
	private GardenApplyService gardenApplyService;
	private InvestmentService investmentService;
	private CustomerService customerService;
	private ProductService productService;
	private ArticleTypeService articleTypeService;
	private LinksService linksService;
	private AdvicementService advicementService;
	private MailService mailService;
	private PlatformService platformService;
	private FederationService federationService;
	private ReceiptService receiptService;
	private GardenApplyAttService gardenApplyAttService;
	private InvestmentArchiveAttService investmentArchiveAttService;
	private InvestmentDirectorService investmentDirectorService;
	private ReceiptAttService receiptAttService;
	private ResourceService resourceService;
	private DocumentService documentService;
	private AgencyService agencyService;
	
	public InputStream inputStream;
	
	private Mail mail;
	private Advicement advicement;
	@SuppressWarnings("rawtypes")
	private Result result;
	private GardenApply gardenApply;
	private GardenApplyAtt gardenApplyAtt;
	private Investment investment;
	private InvestmentDirector investmentDirector;
	private InvestmentArchiveAtt investmentArchiveAtt;
	private Receipt receipt;
	private Resource floatAd;

	private List<Article> articleList;	
	private List<ArticleType> categoryList;
	private ArticleType parentCategory;	
	private List<ArticleType> currentCategories;
	private List<BaseDto> list;
	
	private Long id;
	private Long categoryId;
	private Article article;
	private String type;
	private Long noticeId;
	private String searchContent;
	private String pos;
	
	private Pager pager;
	private Integer page;
	private ArticleType category;
	private Object[] baseIds ;
	private File file;
	private String fileFileName;
	private String root;
	private String module;
	private String directory;
	private String verify;
	public HomeAction() {
		noticeId = 11L;
		baseIds = new Object[]{76L,78L,28L,29L};
		root = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/upload/";
	}
	
	public String findImage() {
		inputStream = new RandomValidateCode().getRandcode(ServletActionContext.getRequest());
		return "image";
	}
	
	public String checkVerify() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		String sessionValue = session.getAttribute("RANDOMVALIDATECODEKEY").toString();
		if (sessionValue != null && verify != null) {
			sessionValue = sessionValue.trim().toLowerCase();
			verify = verify.toLowerCase();
			if (verify.equals(sessionValue)) {
				result = Result.success("验证通过");
				return JSON;
			}
		}
		result = Result.failure("验证失败");
		return JSON;
	}
	
	/**
	 * 删除本地文件
	 * @return JSON
	 */
	public String delFile() {
		directory = root+directory;
		file = new File(directory);
		if ("archiveAtt".equals(type)) {//附件
			if (id != null) {
				investmentArchiveAttService.deleteById(id);
			}
		}
		if (file.exists()) {
			if (file.delete()) {
				result = Result.success("删除成功！");
			}else {
				result = Result.failure("删除失败！");
			}
		}else {
			result = Result.success("删除失败,文件不存在！");
		}
		return JSON;
	}
	
	
	//上传
	public void upload() {
		FileOutputStream fos = null;
		FileInputStream fis = null;
		String path = "";
		try {
			UploadResult result = new UploadResult();
			result.setOriginalName(fileFileName);
			result.setSize(file.length());
			if(directory!=null && directory.length()>0) path += directory;
			if(module!=null && module.length()>0) path += File.separator + module;
			if(!new File(root+path).exists()){
				new File(root+path).mkdirs();
			}
			Date uploadTime = new Date();
			String nowTime = new SimpleDateFormat("yyyyMMddHHmmss").format(uploadTime);
			String suffixName = "";
			if (fileFileName.indexOf(".") >= 0) {
				suffixName = fileFileName.substring(fileFileName.lastIndexOf("."));
			}
			result.setSuffixName(suffixName);
			int random = new Random().nextInt(50);
			String fileName  = nowTime + random + suffixName;
			result.setName(fileName);
			result.setPath((path + File.separator + fileName).replace(File.separator, "/"));
			String filePath = root + result.getPath();
			fos = new FileOutputStream(filePath);
			fis = new FileInputStream(file);
			byte[] buf = new byte[10240];
			int len = -1;
			while ((len = fis.read(buf)) != -1) {
				fos.write(buf, 0, len);
			}
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setCharacterEncoding("utf-8");
			PrintWriter writer = response.getWriter();
			writer.println(JSONObject.fromObject(result).toString());//回调数据
			writer.flush();
			writer.close();
			fos.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (fos != null) {
				try {
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	
	
	/**
	 * 首页上的栏目 作用于网站导航里的链接
	 * @return
	 */
	public String indexItem() {
		if ("news".equals(type)) {//新闻资讯
			id=10L;
			return list();
		}else if ("policy".equals(type)) {//政策导航
			id=4L;
			return list();
		}else if ("base".equals(type)) {//服务平台
			id = null;
			return serviceView();
		}else if ("south".equals(type)) {//企业专栏
			id = 29L;
			enterprise();
			return "customer";
		}else if ("incubation".equals(type)) {//孵化基地
			type = "north";
			categoryId = 46L;
			id = null;
			return base();
		}else if ("download".equals(type)) {//下载中心
			navigation();
			category = articleTypeService.getBeanById(categoryId).getValue();
			if (category != null) {
				relativeCategories();
			}
			Filter filter = new Filter(Document.class);
			filter.eq("isFolder", BooleanEnum.NO);
			filter.eq("pubed", BooleanEnum.YES);
			filter.orderBy("pubTime", Filter.DESC);
			filter.pager(createPager(15));
			List<Document> documents = documentService.
					getListByFilter(filter).getValue();
			setRequestAttribute("documents", documents);
			return type;
		}
		return view();
	}
	
	//广告
	public void	templeteList(){
		Param param = InitListener.webParam;
		if (param != null) {
			List<Resource> resources = resourceService.getListByFilter(
					new Filter(Resource.class).eq("positionId", "cms.100101").
					eq("paramId", param.getId())).getValue();
			if (resources != null && resources.size() > 0) {
				floatAd = resources.get(0);
			}
		}
	}
	
	/**
	 * 截取HTML代码
	 * 
	 * @author YangJunping
	 * @date 2010-7-15
	 */
	/*public String Html2Text(String inputString) {    
	    String htmlStr = inputString; // 含html标签的字符串    
	    String textStr = "";    
        java.util.regex.Pattern p_script;    
        java.util.regex.Matcher m_script;    
        java.util.regex.Pattern p_style;    
        java.util.regex.Matcher m_style;    
        java.util.regex.Pattern p_html;    
        java.util.regex.Matcher m_html;    
  
        java.util.regex.Pattern p_html1;    
        java.util.regex.Matcher m_html1;    
	  
       try {    
            String regEx_script = "<[//s]*?script[^>]*?>[//s//S]*?<[//s]*?///[//s]*?script[//s]*?>"; // 定义script的正则表达式{或<script[^>]*?>[//s//S]*?<///script>    
	        String regEx_style = "<[//s]*?style[^>]*?>[//s//S]*?<[//s]*?///[//s]*?style[//s]*?>"; // 定义style的正则表达式{或<style[^>]*?>[//s//S]*?<///style>    
	        String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式    
	        String regEx_html1 = "<[^>]+"; 
	        p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);    
	        m_script = p_script.matcher(htmlStr);    
	        htmlStr = m_script.replaceAll(""); // 过滤script标签    
  
            p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);    
            m_style = p_style.matcher(htmlStr);    
            htmlStr = m_style.replaceAll(""); // 过滤style标签    
  
            p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);    
            m_html = p_html.matcher(htmlStr);    
            htmlStr = m_html.replaceAll(""); // 过滤html标签    
  
            p_html1 = Pattern.compile(regEx_html1, Pattern.CASE_INSENSITIVE);    
            m_html1 = p_html1.matcher(htmlStr);    
            htmlStr = m_html1.replaceAll(""); // 过滤html标签    
            
            textStr = htmlStr;    
  
        } catch (Exception e) {    
            System.err.println("Html2Text: " + e.getMessage());    
        }    
	  
       return textStr;// 返回文本字符串    
	}   */

	public String save() {
		if (type != null && !"".equals(type)) {
			if ("advicement".equals(type)) {
				if (advicement != null) {
					advicement.setParamId(InitListener.webID);
					result = advicementService.save(advicement);
				}
			}else if ("mail".equals(type)) {
				if (mail != null) {
					mail.setParamId(InitListener.webID);
					mail.setTime(new Date());
					result = mailService.save(mail);
				}
			}else if ("receipt".equals(type)) {
				if (receipt != null) {
					receipt.setParamId(InitListener.webID);
					if (receipt.getArticleId() != null) {
						article = articleService.getBeanById(receipt.getArticleId()).getValue();
						article.setRecord(type);
						articleService.update(article);
					}
					result = receiptService.save(receipt);
					if (result.isSuccess()) {
						if (fileFileName != null) {
							receipt = (Receipt)(result.getValue());
							id = receipt.getId();
							List<ReceiptAtt> atts = backListFromJSON(fileFileName);
							for (ReceiptAtt receiptAtt : atts) {
								receiptAtt.setReceiptId(id);
								receiptAttService.save(receiptAtt);
							}
						}
					}
				}
			}else  if ("gardenApply".equals(type)) {
				if (gardenApply != null) {
					if (gardenApply.getApplyState() == null) {
						gardenApply.setApplyState(GardenApplyStateEnum.EVAL);
					}
					if (gardenApply.getProjectState() == null) {
						gardenApply.setProjectState(GardenProjectStateEnum.APPLYING);
					}
					if (gardenApply.getFinancing() == null) {
						gardenApply.setFinancing(BooleanEnum.NO);
					}
					if (gardenApply.getPub() == null) {
						gardenApply.setPub(BooleanEnum.NO);
					}
					result = gardenApplyService.save(gardenApply);
				}
			}else  if ("applyAtt".equals(type)) {
				if (gardenApplyAtt != null) {
					result = gardenApplyAttService.save(gardenApplyAtt);
				}
			}else  if ("investment".equals(type)) {
				if (investment != null) {
					result = investmentService.save(investment);
					if(result.isSuccess()){
						investment = (Investment) result.getValue();
						if(investment.getId() != null && investmentDirector != null){
							investmentDirector.setInvestmentId(investment.getId());
							if("".equals(investmentDirector.getDegreeId())){
								investmentDirector.setDegreeId(null);
							}
							if("".equals(investmentDirector.getPoliticalId())){
								investmentDirector.setPoliticalId(null);
							}
							investmentDirectorService.save(investmentDirector);
						}
					}
				}else{
					result = Result.failure("保存失败");
				}
			}else  if ("archiveAtt".equals(type)) {
				if (investmentArchiveAtt != null && 
						investmentArchiveAtt.getInvestmentId() != null) {
					result = investmentArchiveAttService.save(investmentArchiveAtt);
				}else{
					result = Result.failure("保存失败");
				}
			}else  if ("update".equals(type)) {
				if (gardenApplyAtt != null) {
					GardenApplyAtt att = gardenApplyAttService.
							getBeanById(gardenApplyAtt.getId()).getValue();
					att.setName(gardenApplyAtt.getName());
					result = gardenApplyAttService.update(att);
				}
			}
		}
		return JSON;
	}
	
	/**
	 * 解析从js中发回的JSON格式的数据
	 * @param json
	 * @return
	 */
	private List<ReceiptAtt> backListFromJSON(Object json) {
		JSONArray jsonArray = JSONArray.fromObject(json);
		List<ReceiptAtt> att = new ArrayList<ReceiptAtt>();
		if (jsonArray.size() > 0) {
			for (int i = 0; i <jsonArray.size(); i++) {
				JSONObject o = jsonArray.getJSONObject(i);
				String oldName = o.getString("fileName");
				try {
					oldName = URLDecoder.decode(oldName, "utf-8");
					oldName = URLDecoder.decode(oldName, "utf-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				ReceiptAtt a = new ReceiptAtt();
				a.setOldName(oldName);
				a.setNewName(o.getString("filePath"));
				att.add(a);
			}
		}
		return att;
	}
	
	public String garden() {
		String resultStr = navigation();
		if (resultStr != null) {
			return resultStr;
		}
		
		if ("rename".equals(type)) {
			result = gardenApplyAttService.getBeanById(id);
			return type;
		}else if("deletePic".equals(type)){
			File file = new File(root + directory);
			if (file.exists()) {
				boolean suc = file.delete();
				if (suc) {
					result = Result.success("删除文件成功");
				}else {
					result = Result.failure("删除文件失败");
				}
			}else {
				result = Result.success("删除文件失败,文件不存在");

			}
			return JSON;
		}else if(id!=null){
			gardenApplyAtt = gardenApplyAttService.getBeanById(id).getValue();
			File file = new File(root + gardenApplyAtt.getNewName());
			if (file.exists()) {
				file.delete();
			}
			result = gardenApplyAttService.deleteById(id);
			return JSON;
		}
		return type;
	}
	
	/**
	 * 全文搜索
	 * @return
	 */
	public String search() {
		String resultStr = navigation();
		if (resultStr != null) {
			return resultStr;
		}
		
		Filter filter = new Filter(Article.class);
		filter.eq("paramId", InitListener.webID);
		try {
			searchContent = URLDecoder.decode(searchContent, "utf-8");
			searchContent = URLDecoder.decode(searchContent, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		filter.or(Filter.Like("title", searchContent), Filter.Like("content", searchContent));
		filter.eq("kind", ArticleKindEnum.LIST);
		filter.eq("pubed", BooleanEnum.YES);
		filter.eq("deleted", BooleanEnum.NO);
		filter.pager(createPager(10));
		if (type != null && !"".equals(type)) {
			if ("time".equals(type)) {
				filter.orderBy("pubTime", Filter.DESC);
			}
		}
		articleList = articleService.getListByFilter(filter).getValue();
		return "list";
	}

	/**
	 * 创业导师显示
	 * @return
	 */
	public String showView() {
		return view();
	}
	
	/**
	 * 创业导师列表
	 * @return
	 */
	public String show() {
		return list();
	}
	
	public String login() {
		String resultStr = navigation();
		if (resultStr != null) {
			return resultStr;
		}
		HttpServletRequest request = ServletActionContext.getRequest();
		Activator.getHttpSessionService().removeSession(request);
		return "login";
	}
	
	public String serviceView() {
		String resultStr = navigation();
		if (resultStr != null) {
			return resultStr;
		}
		if ("nursery".equals(type)) {
			//苗圃服务
			categoryId = 49L;
			return base();
		}
		if ("base".equals(type)) {
			//入孵指南
			categoryId = 20L;
			type = "incubation";
		}
		if (categoryId != null) {
			category = articleTypeService.getBeanById(categoryId).getValue();
			relativeCategories();
		}
		if (type != null && !"".equals(type)) {
			if ("platform".equals(type)) {
				Platform platform = platformService.getBeanById(id).getValue();
				setRequestAttribute("platform", platform);
			}else if ("federation".equals(type)) {
				Federation federation = federationService.getBeanById(id).getValue();
				setRequestAttribute("federation", federation);
			}else{
				if (id != null) {
					article = articleService.getBeanById(id).getValue();
				}else if (category != null && category.getKind() == ArticleKindEnum.SINGLE) {
					article = articleService.getBeanByFilter(
							new Filter(Article.class).
							eq("paramId", InitListener.webID).
							eq("typeId", category.getId()).
							eq("kind", ArticleKindEnum.SINGLE)).getValue();
				}
			}
			return type;
		}
		return VIEW;
	}
	
	
	/**
	 * 服务平台列表
	 * @return
	 */
	public String service() {
		String resultStr = navigation();
		if (resultStr != null) {
			return resultStr;
		}
		if (categoryId == null && id != null) {
			categoryId = id;
			id = null;
		}
		category = articleTypeService.getBeanById(categoryId).getValue();
		relativeCategories();
		if (id != null) {
			article = articleService.getBeanById(id).getValue();
		}else {
			if (category != null && category.getKind() == ArticleKindEnum.SINGLE) {
				article = articleService.getBeanByFilter(new Filter(Article.class).
						eq("paramId", InitListener.webID).eq("typeId", category.getId())).getValue();
			}
		}
		if (type != null && !"".equals(type.trim())) {
			List<Article> activities = null;
			Filter filter = new Filter(Article.class);
			filter.eq("pubed", BooleanEnum.YES);
			String tag = null;
			if ("platform".equals(type) ){
				//技术平台
				Filter pFilter = new Filter(Platform.class);
				pFilter.eq("paramId", InitListener.webID);
				pFilter.eq("typeId", category.getId());
				pFilter.eq("pubed", BooleanEnum.YES);
				List<Platform> platforms = platformService.getListByFilter(pFilter).getValue();
				platformSort(platforms);
				setRequestAttribute("platforms", platforms);
			}else if("federation".equals(type)) {
				//服务联盟
				Filter pFilter = new Filter(Federation.class);
				pFilter.eq("paramId", InitListener.webID);
				pFilter.eq("typeId", category.getId());
				pFilter.eq("pubed", BooleanEnum.YES);
				List<Federation> federations = federationService.getListByFilter(pFilter).getValue();
				federationSort(federations);
				setRequestAttribute("federations", federations);
			}else if ("train".equals(type)) {
				//所有培训活动
				tag = "培训活动";
				filter.eq("pubed", BooleanEnum.YES);
			}else if ("finance".equals(type)) {
				//投资融资活动
				tag = "投资融资活动";
			}else if ("hiring".equals(type)) {
				//招聘活动
				tag = "招聘活动";
			}
			if (tag != null) {
				filter.eq("deleted", BooleanEnum.NO);
				if (pager == null)
					pager = new Pager(1,15);
				filter.pager(pager);
				filter.eq("paramId", InitListener.webID).like("tags", "培训活动");
				activities = articleService.getListByFilter(filter).getValue();
			}
			if (activities != null) {
				setRequestAttribute("activities", activities);
			}
			return type;
		}
		return "list";
	}
	
	/**
	 * 基地
	 * @return
	 */
	public String base() {
		Long baseId = 3L;
		categoryList = articleTypeService.getListByFilter(
				new Filter(ArticleType.class).eq("parentId", baseId)).getValue();
		if (categoryId == null && id != null) {
			categoryId = id;
			id = null;
			category = articleTypeService.getBeanById(categoryId).getValue();
		}else {
			category = articleTypeService.getBeanById(categoryId).getValue();
		}
		if (category != null) {
			CustomerBaseEnum tag = null;
			if ("south".equals(type)) {
				tag = CustomerBaseEnum.SOUTH;//江南
			}else if ("north".equals(type)) {
				tag = CustomerBaseEnum.NORTH;//江北
			}else if ("accelerator".equals(type)) {
				tag = CustomerBaseEnum.ACCELERATOR;//加速器
			}else if ("nursery".equals(type)) {
				//苗圃
				navigation();
				article = articleService.getBeanById(82L).getValue();
				Filter filter = new Filter(GardenApply.class);//苗圃
				filter.eq("pub", BooleanEnum.YES).
				orderBy("createTime", Filter.DESC).maxResults(3);
				List<GardenApply> applies = gardenApplyService.getListByFilter(filter).getValue();
				setRequestAttribute("applies", applies);
				filter = new Filter(Agency.class);//机构
				filter.eq("pub", BooleanEnum.YES).
				orderBy("createTime", Filter.DESC).maxResults(3);
				List<Agency> agencies = agencyService.getListByFilter(filter).getValue();
				setRequestAttribute("agencies", agencies);
				filter = new Filter(Article.class);//苗圃知识
				filter.eq("paramId", InitListener.webID);
				filter.eq("typeId", 56L);
				filter.eq("pubed", BooleanEnum.YES);
				filter.eq("deleted", BooleanEnum.NO);
				filter.orderBy("pubTime", Filter.DESC);
				filter.maxResults(16);
				articleList = articleService.getListByFilter(filter).getValue();
			}
			if (tag != null) {
				articleList = articleService.getListByFilter(
						new Filter(Article.class).eq("typeId", category.getId()).
						eq("deleted", BooleanEnum.NO).eq("paramId", InitListener.webID).
						notIn("id", baseIds)).getValue();
				Set<ArticleAtt> atts = new HashSet<ArticleAtt>();
				for (Article article : articleList) {
					atts.addAll(article.getArticleAtts());
				}
				setRequestAttribute("atts", atts);
				List<Customer> customers = customerService.getListByFilter(
						new Filter(Customer.class).eq("pub", BooleanEnum.YES).
						eq("base", tag)).getValue();
				setRequestAttribute("customers", customers);
			}
		}
		return type;
	}
	
	
	/**
	 * 当前菜单及网页左侧菜单
	 */
	private void relativeCategories() {
		Filter pFilter = new Filter(ArticleType.class);
		pFilter.eq("paramId", InitListener.webID);
		pFilter.orderBy("displayOrder", Filter.ASC);
		if (category.getParentId() == null) {
			pFilter.like("parentIds", ","+category.getId()+",");
			currentCategories = articleTypeService.
					getListByFilter(pFilter).getValue();
			parentCategory = category;
		}else {
			Object[] parents = createArrayFromString(category.getParentIds());
			pFilter.like("parentIds", ","+parents[1]+",");
			currentCategories = 
					articleTypeService.getListByFilter(pFilter).getValue();
			parentCategory = articleTypeService.getBeanById(
					Long.parseLong(parents[1].toString())).getValue();
		}
	}
	
	/**
	 * 网站导航
	 */
	private String navigation() {
		Param param =  InitListener.webParam;
		if (param != null) {
			categoryList = articleTypeService.getListByFilter(
					new Filter(ArticleType.class).
					eq("paramId", InitListener.webID).
					orderBy("displayOrder", Filter.ASC).
					eq("display", BooleanEnum.YES)).getValue();
		}else {
			return "error";
		}
		return NULL;
	}
	
	private Pager createPager(Integer total) {
		if (total == null) {
			total = 15;
		}
		if (page == null)
			pager = new Pager(1,total);
		else {
			pager = new Pager(page,total);
		}
		return pager;
	}
	
	/**
	 * 自定义列表
	 * @return
	 */
	public String enterprise() {
		String resultStr = navigation();
		if (resultStr != null) {
			return resultStr;
		}
		list = new ArrayList<BaseDto>();
		if ("south".equals(type) || "north".equals(type)
				|| "accelerator".equals(type)) {
			id = 29L;
			type = "customer";
		}else if ("nursery".equals(type)) {
			id = 28L;
			type = "gardenApply";
		}
		if (id != null) {
			category = articleTypeService.getBeanById(id).getValue();
			relativeCategories();
		}
		if (type != null && !"".equals(type.trim())) {
			if ("gardenApply".equals(type)) {
				Filter filter = new Filter(GardenApply.class);
				filter.eq("pub", BooleanEnum.YES);
				filter.pager(createPager(15));
				List<GardenApply> applies = gardenApplyService.getListByFilter(filter).getValue();
				list = createApplies(applies, category);
			}else if ("customer".equals(type)) {
				Filter filter = new Filter(Customer.class);
				filter.eq("pub", CustomerApplyState.AGREE);
				filter.orderBy("applyTime", Filter.DESC);
				filter.pager(createPager(15));
				if ("south".equals(type)) {
					filter.eq("base", CustomerBaseEnum.SOUTH);
				}
				List<Customer> customers = customerService.getListByFilter(filter).getValue();
				type = "customer";
				list = createCustomers(customers, category);
			}
		}
		setRequestAttribute("list", list);
		return "list";
	}
	
	/**
	 * 自定义显示
	 * @return
	 */
	public String enterpriseView() {
		String resultStr = navigation();
		if (resultStr != null) {
			return resultStr;
		}
		BaseDto baseDto = null;
		if (categoryId == null && id != null) {
			if ("south".equals(type) || "north".equals(type)
					|| "accelerator".equals(type)) {
				categoryId = 29L;
				type = "customer";
			}else if ("nursery".equals(type)) {
				categoryId = 28L;
				type = "gardenApply";
			}
		}
		category = articleTypeService.getBeanById(categoryId).getValue();
		if (type != null && !"".equals(type.trim())) {
			if ("gardenApply".equals(type)) {
				GardenApply apply = gardenApplyService.getBeanById(id).getValue();
				baseDto = createBaseDto(apply,category);
			}else if ("customer".equals(type)) {
				Customer customer = customerService.getBeanById(id).getValue();
				baseDto = createBaseDto(customer, category);
				List<Product> products = 
						productService.getListByFilter(
								new Filter(Product.class).
								eq("customerId", id).
								eq("pub", CustomerApplyState.AGREE)).getValue();
				setRequestAttribute("products", products);
			}
		}
		if (baseDto != null) {
			if (pos != null) {
				int fd = pos.indexOf(",");
				int fj = pos.indexOf(".");
				Integer page = Integer.parseInt(pos.substring(0,fd));
				Integer records = Integer.parseInt(pos.substring(fd+1,fj));
				Integer index = Integer.parseInt(pos.substring(fj+1));
				BaseDto lastDto = null;
				BaseDto nextDto = null;
				if (page >= 1  && (page-1)*15+index < records) {
					id = category.getId();
					this.page = page;
					enterprise();
					if (index == 1) {
						//当前页的第一篇
						nextDto = list.get(index);
						pos = page+","+records+"."+(index+1);
						nextDto.setRecord(pos);
						if (page != 1) {
							this.page = page -1;
							enterprise();
							lastDto = list.get(list.size()-1);
							pos = page-1+","+records+"."+(list.size());
							lastDto.setRecord(pos);
						}
					}else {
						lastDto = list.get(index-2);
						pos = page+","+records+"."+(index-1);
						lastDto.setRecord(pos);
						//当前页面的最后一篇
						if (index != 15) {
							nextDto = list.get(index);
							pos = page+","+records+"."+(index+1);
							nextDto.setRecord(pos);
						}else if (index == 15) {
							this.page = page+1;
							enterprise();
							if (list.size() > 0) {
								nextDto = list.get(0);
								pos = page+1+","+records+".1";
								nextDto.setRecord(pos);
							}
						}
					}
					
				}else if ((page-1)*15+index == records && index > 1) {
					id = category.getId();
					this.page = page;
					enterprise();
					lastDto = list.get(index-2);
					pos = page+","+records+"."+(index-1);
					lastDto.setRecord(pos);
				}
				if (lastDto != null && nextDto != null) {
					HashMap<Integer, BaseDto> dtoMap = new HashMap<Integer, BaseDto>();
					dtoMap.put(1, lastDto);
					dtoMap.put(2, nextDto);
					setRequestAttribute("dtoMap", dtoMap);
				}
				if (list != null) {
					list.clear();
				}
			}
		}
		if (category != null) {
			relativeCategories();
		}
		setRequestAttribute("baseDto", baseDto);
		return VIEW;
	}
	
	private BaseDto createBaseDto(GardenApply apply,ArticleType category) {
		BaseDto dto = new BaseDto();
		dto.setTime(apply.getCreateTime());
		dto.setId(apply.getId());
		dto.setName(apply.getProjectName());
		dto.setPhone(apply.getLeaderMobile());
		dto.setEmail(apply.getLeaderEmail());
		dto.setContent(apply.getIntroduction());
		dto.setPhoto(apply.getPhoto());
		dto.setOldName(apply.getOldName());
		dto.setType(type);
		dto.setCategory(category);
		return dto;
	}
	
	private BaseDto createBaseDto(Customer customer,ArticleType category) {
		BaseDto dto = new BaseDto();
		dto.setTime(customer.getCreateTime());
		dto.setId(customer.getId());
		dto.setName(customer.getName());
		CustomerInfo info = customer.getCustomerInfo();
		dto.setPhone(info.getOfficePhone());
		dto.setEmail(info.getEmail());
		dto.setContent(customer.getContent());
		dto.setUrl(info.getWebSite());
		dto.setType(type);
		dto.setCategory(category);
		dto.setAddress(info.getAddress());
		dto.setLogo(customer.getLogo());
		return dto;
	}
	
	private List<BaseDto> createApplies(List<GardenApply> applies,ArticleType category) {
		List<BaseDto> dtos = new ArrayList<BaseDto>();
		for (GardenApply apply : applies) {
			dtos.add(createBaseDto(apply, category));
		}
		return dtos;
	}
	
	private List<BaseDto> createCustomers(List<Customer> customers,ArticleType category) {
		List<BaseDto> dtos = new ArrayList<BaseDto>();
		for (Customer customer : customers) {
			dtos.add(createBaseDto(customer, category));
		}
		return dtos;
	}

//	public String search() {
//		categoryList = categoryService.getList(new Filter(Category.class).orderBy("order", Filter.ASC)).getValue();
//		Filter filter = new Filter(Article.class);
//		String field = getRequestParameter("field");
//		String keyword = getRequestParameter("keyword");
//		if (keyword != null && keyword.trim().length() > 0) {
//			keyword = StringUtil.ISOToUTF8(keyword);
//			filter.like(field, keyword);
//		}
//		String category = getRequestParameter("category");
//		setRequestAttribute("category", category);
//		setRequestAttribute("field", field);
//		setRequestAttribute("keyword", keyword);
//		Category c = new Category(Integer.parseInt(category));
//		filter.createAlias("category", "category");
//		filter.or(Filter.Eq("category", c), Filter.Eq("category.parent", c));
//		filter.orderBy("order", Filter.DESC);
//		if (pager == null)
//			pager = new Pager(1);
//		filter.pager(pager);
//		articleList = articleService.getList(filter).getValue();
//		return "search";
//	}
//


	public String execute() {
		
		InitListener.webParam=paramService.getBeanById(InitListener.webID).getValue();
		String resultStr = navigation();
		if (resultStr != null) {
			return resultStr;
		}
		
		templeteList();//获取浮动
		
		ContactInfo contactInfo = contactInfoService.getBeanByFilter(
				new Filter(ContactInfo.class).eq("paramId", InitListener.webID)).getValue();
		setRequestAttribute("contactInfo",contactInfo);

		
		// 中心动态
		category = articleTypeService.getBeanById(9L).getValue();
		findArticleList("zxdt",category,8,false);
		
		/**
		 *  新闻资讯中的文字图片部分
		 */
		List<Article> tpzx = articleService.getListByFilter(
				new Filter(Article.class).maxResults(4).
				eq("typeId", 10L).notNull("photo").
				eq("pubed", BooleanEnum.YES).
				eq("recommend", BooleanEnum.YES)).getValue();
		mySort(tpzx);
		setRequestAttribute("tpzx", tpzx);
		
		/**
		 *  新闻资讯 中的文字资讯部分
		 */ 
		category = articleTypeService.getBeanById(10L).getValue();
		findArticleList("wzzx",category,8,false);
		
		/**
		 * 通知公告
		 */
		category = articleTypeService.getBeanById(11L).getValue();
		findArticleList("tzgg",category,7,false);
		
		/**
		 * 扶持政策
		 */
		category = articleTypeService.getBeanById(4L).getValue();
		findArticleList("fczc",category,7,true);
		
		/**
		 * 企业专栏
		 */
		List<Customer> qyzl = customerService.getListByFilter(
				new Filter(Customer.class).eq("pub", CustomerApplyState.AGREE).
				orderBy("applyTime", Filter.DESC).maxResults(7)).getValue();
		category = articleTypeService.getBeanById(29L).getValue();
		setRequestAttribute("qyzlType", category);
		setRequestAttribute("qyzl", createCustomers(qyzl, category));
		
		/**
		 * 创业导师
		 */
		category = articleTypeService.getBeanById(42L).getValue();
		findArticleList("cyds",category,20,false);
		
		/**
		 * 服务平台
		 */
		//服务平台Id(顶级菜单)
		Long serviceId = 6L;
		List<ArticleType> serviceTypes = articleTypeService.getListByFilter(
				new Filter(ArticleType.class).
				eq("paramId", InitListener.webID).
				eq("parentId", serviceId).
				orderBy("displayOrder", Filter.ASC)).getValue();
		setRequestAttribute("serviceTypes", serviceTypes);
		
		
		/**
		 * 孵化基地
		 */
		articleList = articleService.getListByFilter(
				new Filter(Article.class).eq("deleted", BooleanEnum.NO).
				in("id", baseIds).orderBy("typeId", Filter.ASC)).getValue();
		category = articleTypeService.getBeanById(3L).getValue();
		setRequestAttribute("fhjdType", category);
		setRequestAttribute("fhjd",articleList);
		
		/**
		 * 邮件订阅
		 */
		List<Mail> mails = mailService.getListByFilter(
				new Filter(Mail.class).eq("paramId", InitListener.webID)).getValue();
		setRequestAttribute("yjdy", mails.size());
		
		/**
		 * 下载中心
		 */
		List<Document> documents = documentService.getListByFilter(
				new Filter(Document.class).eq("isFolder", BooleanEnum.NO).
				eq("pubed", BooleanEnum.YES).orderBy("pubTime", Filter.DESC).maxResults(4)).getValue();
		category = articleTypeService.getBeanById(55L).getValue();
		setRequestAttribute("xzzxType", category);
		setRequestAttribute("xzzx", documents);
		return INDEX;
	}
	
	/**
	 * 根据栏目名称(汉语首字母拼音)、栏目Id、查询条数、是否查询所有子菜单
	 * @param categoryName
	 * @param categoryId
	 * @param maxNums
	 */
	private void findArticleList(
			String categoryName,ArticleType category,Integer maxNums,boolean checkAll){
		if (category != null) {
			categoryId = category.getId();
			setRequestAttribute(categoryName+"Id", categoryId);
			setRequestAttribute(categoryName+"Type", category);
			Filter filter = new Filter(Article.class);
			if (checkAll) {
				Filter typeFilter = new Filter(ArticleType.class);
				typeFilter.eq("paramId", InitListener.webID);
				typeFilter.like("parentIds", ","+categoryId+",");
				currentCategories = articleTypeService.
						getListByFilter(typeFilter).getValue();
				filter.in("typeId", createArrayFromList(currentCategories));
			}else
				filter.eq("typeId", categoryId);
			filter.eq("paramId", InitListener.webID);
			filter.eq("pubed", BooleanEnum.YES);
			filter.eq("recommend", BooleanEnum.YES);
			filter.eq("kind", ArticleKindEnum.LIST);
			filter.eq("deleted", BooleanEnum.NO);
			filter.orderBy("pubTime", Filter.DESC);
			filter.maxResults(maxNums);
			List<Article> list = articleService.getListByFilter(filter).getValue();
			mySort(list);
			setRequestAttribute(categoryName, list);
		}
	}

	public String list() {
		String resultStr = navigation();
		if (resultStr != null) {
			return resultStr;
		}
		Filter pFilter = new Filter(ArticleType.class);
		Filter newFilter = new Filter(ArticleType.class);
		Filter filter = new Filter(Article.class);
		
		pFilter.eq("paramId", InitListener.webID).
			orderBy("displayOrder", Filter.ASC);
		newFilter.eq("paramId", InitListener.webID).
			orderBy("displayOrder", Filter.ASC).
			eq("display", BooleanEnum.YES);
		//所有菜单
		//当前菜单
		category = articleTypeService.getBeanById(id).getValue();
		
		if (category.getParentId() == null) {
			pFilter.like("parentIds", ","+category.getId()+",");
			currentCategories = articleTypeService.
					getListByFilter(pFilter).getValue();
			filter.in("articleType.id", createArrayFromList(currentCategories));
			parentCategory = category;
		}else {
			Object[] parents = createArrayFromString(category.getParentIds());
			pFilter.like("parentIds", ","+parents[1]+",");
			currentCategories = 
					articleTypeService.getListByFilter(pFilter).getValue();
			filter.eq("articleType.id", id);
			parentCategory = articleTypeService.getBeanById(
					Long.parseLong(parents[1].toString())).getValue();
		}
		filter.eq("pubed", BooleanEnum.YES);
		filter.eq("kind", ArticleKindEnum.LIST);
		if (pager == null)
			pager = new Pager(1,15);
		filter.pager(pager);
		articleList = articleService.getListByFilter(filter).getValue();
		mySort(articleList);
		return LIST;
	}
	
	public void mySort(List<Article> list) {
		if (list == null) {
			return;
		}
		Collections.sort(list, new Comparator<Article>(){
			@Override
			public int compare(Article o1, Article o2) {
				if (o1.getToped() == o2.getToped()) {
				}else {
					if (o1.getToped() == BooleanEnum.YES) 
						return -1;
					else 
						return 1;
				}
				return o2.getPubTime().compareTo(o1.getPubTime());
			}
		});
		
	}
	
	public void platformSort(List<Platform> list) {
		if (list == null) {
			return;
		}
		Collections.sort(list, new Comparator<Platform>(){
			@Override
			public int compare(Platform o1, Platform o2) {
				if (o1.getToped() == o2.getToped()) {
				}else {
					if (o1.getToped() == BooleanEnum.YES) 
						return -1;
					else 
						return 1;
				}
				return o2.getPubTime().compareTo(o1.getPubTime());
			}
		});
	}
	
	public void federationSort(List<Federation> list) {
		if (list == null) {
			return;
		}
		Collections.sort(list, new Comparator<Federation>(){
			@Override
			public int compare(Federation o1, Federation o2) {
				if (o1.getToped() == o2.getToped()) {
				}else {
					if (o1.getToped() == BooleanEnum.YES) 
						return -1;
					else 
						return 1;
				}
				return o2.getPubTime().compareTo(o1.getPubTime());
			}
		});
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
	
	private Object[] createArrayFromString(String oldStr) {
		Object[] obj = null;
		if (oldStr != null) {
			obj = oldStr.split(",");
		}
		return obj;
	}
	
	public String view() {
		//导航菜单
		String resultStr = navigation();
		if (resultStr != null) {
			return resultStr;
		}
		if (id != null) {
			article = articleService.getBeanByFilter(new Filter(Article.class).eq("id", id)).getValue();
			category = article.getArticleType();
		}else if (categoryId != null) {
			category = articleTypeService.getBeanById(categoryId).getValue();
			article = articleService.getBeanByFilter(
					new Filter(Article.class).
					eq("typeId", categoryId).
					eq("kind", ArticleKindEnum.SINGLE)).getValue();
		}
		if (article != null) {
			if (pos != null) {
				int fd = pos.indexOf(",");
				int fj = pos.indexOf(".");
				Integer page = Integer.parseInt(pos.substring(0,fd));
				Integer records = Integer.parseInt(pos.substring(fd+1,fj));
				Integer index = Integer.parseInt(pos.substring(fj+1));
				Article lastArticle = null;
				Article nextAtricle = null;
				id = category.getId();
				pager = new Pager(page);
				list();
				if (articleList.size() < records) {
					if (category.getParentIds() != null) {
						Object[] pids = createArrayFromString(category.getParentIds());
						if (pids!= null && pids.length >= 2) {
							categoryId = Long.parseLong(pids[1].toString());
							if (categoryId != null) {
								category = articleTypeService.getBeanById(categoryId).getValue();
								id = category.getId();
								pager = new Pager(page);
								list();
							}
						}
					}
				}
				if (page >= 1  && (page-1)*15+index < records) {
					if (index == 1) {
						//当前页的第一篇
						nextAtricle = articleList.get(index);
						pos = page+","+records+"."+(index+1);
						nextAtricle.setRecord(pos);
						if (page != 1) {
							pager = new Pager(page-1);
							list();
							lastArticle = articleList.get(articleList.size()-1);
							pos = page-1+","+records+"."+(articleList.size());
							lastArticle.setRecord(pos);
						}
					}else {
						lastArticle = articleList.get(index-2);
						pos = page+","+records+"."+(index-1);
						lastArticle.setRecord(pos);
						//当前页面的最后一篇
						if (index != 15) {
							nextAtricle = articleList.get(index);
							pos = page+","+records+"."+(index+1);
							nextAtricle.setRecord(pos);
						}else if (index == 15) {
							pager = new Pager(page+1);
							list();
							if (articleList.size() > 0) {
								nextAtricle = articleList.get(0);
								pos = page+1+","+records+".1";
								nextAtricle.setRecord(pos);
							}
						}
					}
					
				}else if ((page-1)*15+index == records && index > 1) {
					lastArticle = articleList.get(index-2);
					pos = page+","+records+"."+(index-1);
					lastArticle.setRecord(pos);
				}
				HashMap<Integer, Article> articleMap = new HashMap<Integer, Article>();
				articleMap.put(1, lastArticle);
				articleMap.put(2, nextAtricle);
				setRequestAttribute("articleMap", articleMap);
				articleList.clear();
			}
			category = article.getArticleType();
		}
		if (category != null) {
			relativeCategories();
		}
			
		if(article!=null){
			id = article.getId();
			//左侧菜单及当前菜单的父级菜单
			
			if(article.getArticleAtts()!=null) {
				List<ArticleAtt> atts = new ArrayList<ArticleAtt>(article.getArticleAtts());
				Collections.sort(atts, new Comparator<ArticleAtt>() {
					public int compare(ArticleAtt o1, ArticleAtt o2) {
						return (int)(o1.getId()-o2.getId());
					}
				});
				article.setArticleAtts(new LinkedHashSet<ArticleAtt>(atts));
			}
		}
		return VIEW;
	}
	
	public String viewt() {
		
		article = articleService.getBeanByFilter(new Filter(Article.class).eq("articleType.id", id).maxResults(1).fetchMode("articleAtts", Filter.JOIN)).getValue();
		categoryList = articleTypeService.getListByFilter(new Filter(ArticleType.class).eq("paramId", InitListener.webID).orderBy("displayOrder", Filter.ASC).eq("display", BooleanEnum.YES)).getValue();
		if(article!=null)
		category = articleTypeService.getBeanById(id).getValue();
		

		if(article.getArticleAtts()!=null) {
			List<ArticleAtt> atts = new ArrayList<ArticleAtt>(article.getArticleAtts());
			Collections.sort(atts, new Comparator<ArticleAtt>() {
				public int compare(ArticleAtt o1, ArticleAtt o2) {
					return (int)(o1.getId()-o2.getId());
				}
			});
			article.setArticleAtts(new LinkedHashSet<ArticleAtt>(atts));
		}
		return VIEW;
	}
	
	public String easy() {
		String resultStr = navigation();
		if (resultStr != null) {
			return resultStr;
		}
		if (type == null || "".equals(type.trim())) {
			type = VIEW;
		}
		if ("contact".equals(type)) {
			ContactInfo contactInfo = contactInfoService.getBeanByFilter(
					new Filter(ContactInfo.class).eq("paramId", InitListener.webID)).getValue();
			setRequestAttribute("contactInfo",contactInfo);
			categoryId = 19L;
		}else if ("legal".equals(type)) {
			categoryId = 31L;
		}else if ("privacy".equals(type)) {
			categoryId = 32L;
		}else if ("drafting".equals(type)) {
			categoryId = 33L;
		}else if ("navigation".equals(type)) {
			List<ArticleType> all = articleTypeService.getListByFilter(
					new Filter(ArticleType.class).
					eq("paramId", InitListener.webID).
					orderBy("displayOrder", Filter.ASC)).getValue();
			setRequestAttribute("all",all);
			categoryId = 34L;
		}else if ("feedback".equals(type)) {
			categoryId = 35L;
		}
		if (categoryId != null) {
			category = articleTypeService.getBeanById(categoryId).getValue();
			relativeCategories();
			article = articleService.getBeanByFilter(
					new Filter(Article.class).eq("typeId", categoryId).
					eq("kind", ArticleKindEnum.SINGLE)).getValue();
			if (article != null) {
				id = article.getId();
			}
		}
		
		return type;
	}


	private void setRequestAttribute(String string, Object set) {
		ServletActionContext.getRequest().setAttribute(string, set);
	}


	public List<Article> getArticleList() {
		return articleList;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Article getArticle() {
		return article;
	}

	public void setArticle(Article article) {
		this.article = article;
	}

	public void setParamService(ParamService paramService) {
		this.paramService = paramService;
	}

	public Pager getPager() {
		return pager;
	}


	public void setPager(Pager pager) {
		this.pager = pager;
	}


	public ArticleType getCategory() {
		return category;
	}


	public void setCategory(ArticleType category) {
		this.category = category;
	}


	public List<ArticleType> getCurrentCategories() {
		return currentCategories;
	}


	public void setCurrentCategories(List<ArticleType> currentCategories) {
		this.currentCategories = currentCategories;
	}


	public ArticleType getParentCategory() {
		return parentCategory;
	}


	public void setParentCategory(ArticleType parentCategory) {
		this.parentCategory = parentCategory;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public Long getCategoryId() {
		return categoryId;
	}


	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}


	public void setWaterMarkService(WaterMarkService waterMarkService) {
		this.waterMarkService = waterMarkService;
	}


	public void setContactInfoService(ContactInfoService contactInfoService) {
		this.contactInfoService = contactInfoService;
	}


	public void setGardenApplyService(GardenApplyService gardenApplyService) {
		this.gardenApplyService = gardenApplyService;
	}


	public void setInvestmentService(InvestmentService investmentService) {
		this.investmentService = investmentService;
	}


	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}
	
	public void setArticleService(ArticleService articleService) {
		this.articleService = articleService;
	}


	public void setLinksService(LinksService linksService) {
		this.linksService = linksService;
	}
	
	public void setArticleTypeService(ArticleTypeService articleTypeService) {
		this.articleTypeService = articleTypeService;
	}

	public List<ArticleType> getCategoryList() {
		return categoryList;
	}


	public void setCategoryList(List<ArticleType> categoryList) {
		this.categoryList = categoryList;
	}

	public Long getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(Long noticeId) {
		this.noticeId = noticeId;
	}

	public void setProductService(ProductService productService) {
		this.productService = productService;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public String getSearchContent() {
		return searchContent;
	}

	public void setSearchContent(String searchContent) {
		this.searchContent = searchContent;
	}

	public void setAdvicementService(AdvicementService advicementService) {
		this.advicementService = advicementService;
	}

	public Advicement getAdvicement() {
		return advicement;
	}

	public void setAdvicement(Advicement advicement) {
		this.advicement = advicement;
	}
	
	@SuppressWarnings("rawtypes")
	public Result getResult() {
		return result;
	}

	public Mail getMail() {
		return mail;
	}

	public void setMail(Mail mail) {
		this.mail = mail;
	}

	public void setPlatformService(PlatformService platformService) {
		this.platformService = platformService;
	}

	public void setFederationService(FederationService federationService) {
		this.federationService = federationService;
	}

	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}

	public void setReceiptService(ReceiptService receiptService) {
		this.receiptService = receiptService;
	}

	public GardenApply getGardenApply() {
		return gardenApply;
	}

	public void setGardenApply(GardenApply gardenApply) {
		this.gardenApply = gardenApply;
	}

	public GardenApplyAtt getGardenApplyAtt() {
		return gardenApplyAtt;
	}

	public void setGardenApplyAtt(GardenApplyAtt gardenApplyAtt) {
		this.gardenApplyAtt = gardenApplyAtt;
	}

	public void setGardenApplyAttService(GardenApplyAttService gardenApplyAttService) {
		this.gardenApplyAttService = gardenApplyAttService;
	}
	
	
	public String getRoot(){
		return root;
	}
	public void setFile(File upload) {
		this.file = upload;
	}
	public void setFileFileName(String uploadFileName) {
		this.fileFileName = uploadFileName;
	}
	public void setModule(String module) {
		this.module = module;
	}
	public void setDirectory(String directory) {
		this.directory = directory;
	}
	
	public String getPos() {
		return pos;
	}

	public void setPos(String pos) {
		this.pos = pos;
	}


	public Receipt getReceipt() {
		return receipt;
	}


	public void setReceipt(Receipt receipt) {
		this.receipt = receipt;
	}


	public void setReceiptAttService(ReceiptAttService receiptAttService) {
		this.receiptAttService = receiptAttService;
	}


	public Resource getFloatAd() {
		return floatAd;
	}


	public void setFloatAd(Resource floatAd) {
		this.floatAd = floatAd;
	}


	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}


	public void setDocumentService(DocumentService documentService) {
		this.documentService = documentService;
	}


	public void setAgencyService(AgencyService agencyService) {
		this.agencyService = agencyService;
	}
	
	public Investment getInvestment() {
		return investment;
	}


	public void setInvestment(Investment investment) {
		this.investment = investment;
	}


	public void setInvestmentArchiveAtt(InvestmentArchiveAtt investmentArchiveAtt) {
		this.investmentArchiveAtt = investmentArchiveAtt;
	}


	public InvestmentArchiveAtt getInvestmentArchiveAtt() {
		return investmentArchiveAtt;
	}


	public void setInvestmentArchiveAttService(
			InvestmentArchiveAttService investmentArchiveAttService) {
		this.investmentArchiveAttService = investmentArchiveAttService;
	}


	public void setInvestmentDirectorService(
			InvestmentDirectorService investmentDirectorService) {
		this.investmentDirectorService = investmentDirectorService;
	}


	public void setInvestmentDirector(InvestmentDirector investmentDirector) {
		this.investmentDirector = investmentDirector;
	}


	public InvestmentDirector getInvestmentDirector() {
		return investmentDirector;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public void setVerify(String verify) {
		this.verify = verify;
	}
}
