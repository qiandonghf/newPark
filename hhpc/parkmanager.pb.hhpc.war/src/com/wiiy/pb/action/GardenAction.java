package com.wiiy.pb.action;

import java.io.File;
import java.io.InputStream;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.entity.User;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.entity.GardenApply;
import com.wiiy.pb.entity.GardenApplyAtt;
import com.wiiy.pb.entity.GardenApplyEval;
import com.wiiy.pb.entity.GardenApplyLog;
import com.wiiy.pb.preferences.enums.GardenApplyAttTypeEnum;
import com.wiiy.pb.preferences.enums.GardenApplyStateEnum;
import com.wiiy.pb.preferences.enums.GardenProjectStateEnum;
import com.wiiy.pb.service.GardenApplyAttService;
import com.wiiy.pb.service.GardenApplyEvalService;
import com.wiiy.pb.service.GardenApplyLogService;
import com.wiiy.pb.service.GardenApplyService;
import com.wiiy.pb.util.ImageUtil;

public class GardenAction extends JqGridBaseAction<GardenApply> {
	
	private GardenApplyService gardenApplyService;
	private GardenApplyAttService gardenApplyAttService;
	private GardenApplyEvalService gardenApplyEvalService;
	private GardenApplyLogService gardenApplyLogService;
	@SuppressWarnings("rawtypes")
	private Result result;
	private GardenApply gardenApply;
	private GardenApplyAtt gardenApplyAtt;
	private GardenApplyEval gardenApplyEval;
	private GardenApplyLog gardenApplyLog;
	private BooleanEnum isAgree;
	private GardenProjectStateEnum state;
	private String info;
	private Long id;
	private Long applyId;
	private Long customerId;
	private Pager pager;
	private String ids;
	private String rootPath;
	private InputStream inputStream;
	private String fileName;
	private String searchName;
	
	public GardenAction() {
		rootPath = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/upload/";
		setPager(total);
	}
	
	/**
	 * 入圃申请
	 * @return
	 */
	public String applySave() {
		if (gardenApply.getApplyState() == null) {
			gardenApply.setApplyState(GardenApplyStateEnum.EVAL);
		}
		if (gardenApply.getProjectState() == null) {
			gardenApply.setProjectState(GardenProjectStateEnum.APPLYING);
		}
		if (gardenApply.getFinancing() == null) {
			gardenApply.setFinancing(BooleanEnum.NO);
		}
		if(gardenApply.getPhoto() == null || "".equals(gardenApply.getPhoto())){
			gardenApply.setPhoto(null);
			gardenApply.setOldName(null);
		}
		result = gardenApplyService.save(gardenApply);
		return JSON;
	}
	
	/**
	 * 查看入圃申请
	 * @return
	 */
	public String applyView() {
		gardenApply = gardenApplyService.getBeanById(id).getValue();
		List<GardenApplyAtt> list = gardenApplyAttService.
			getListByFilter(
					new Filter(GardenApplyAtt.class).
					eq("applyId", gardenApply.getId()).
					eq("type", GardenApplyAttTypeEnum.BUSINESSPLAN)).getValue();
		gardenApply.setGardenApplyAtts(list);
		list = gardenApplyAttService.
				getListByFilter(
						new Filter(GardenApplyAtt.class).
						eq("applyId", gardenApply.getId()).
						eq("type", GardenApplyAttTypeEnum.OTHER)).getValue();
		gardenApply.setApplyAtts(list);
		List<GardenApplyEval> evals = 
				gardenApplyEvalService.
				getListByFilter(new Filter(GardenApplyEval.class).eq("applyId", gardenApply.getId())).getValue();
		gardenApply.setGardenApplyEvals(evals);
		result = Result.value(gardenApply);
		return "applyView";
	}
	
	/**
	 * 编辑入圃申请
	 * @return
	 */
	public String applyEdit() {
		result = gardenApplyService.getBeanById(id);
		return "applyEdit";
	}
	
	/**
	 * 更新入圃申请
	 * @return
	 */
	public String applyUpdate(){
		GardenApply dbBean = gardenApplyService.getBeanById(gardenApply.getId()).getValue();
		if(gardenApply.getPhoto() != null && "".equals(gardenApply.getPhoto())){
			gardenApply.setPhoto(null);
		}
		if (dbBean.getPhoto() != null && gardenApply.getPhoto() == null) {
			fileName = dbBean.getPhoto();
			dbBean.setPhoto(null);
			dbBean.setOldName(null);
			deleteByPath();
		}
		BeanUtil.copyProperties(gardenApply, dbBean);
		result = gardenApplyService.update(dbBean);
		return JSON;
	}
	
	/**
	 * 删除入圃申请
	 * @return
	 */
	public String applyDelete(){
		if(id!=null){
			result = gardenApplyService.deleteById(id);
		} else if(ids!=null){
			result = gardenApplyService.deleteByIds(ids);
		}
		return JSON;
	}
	
	/**
	 * 查询入圃申请
	 * @return
	 */
	public String view() {
		applyView();
		gardenApply = (GardenApply) result.getValue();
		gardenApply.setCustomerId(customerId);
		result = Result.value(gardenApply);
		return "view";
	}
	
	/**
	 * 查询入圃申请列表
	 * @return
	 */
	public String list() {
		refresh(new Filter(GardenApply.class));
		return JSON;
	}
	
	/**
	 * 入圃申请单列表
	 * @return
	 */
	public String applyList(){
		backGardenApplies(null);
		result = Result.value(root);
		return "applyList";
	}
	
	Comparator<GardenApply> comparator = new Comparator<GardenApply>() {
		public int compare(GardenApply o1, GardenApply o2) {
			int flag = -1;
			flag = o1.getCreateTime().compareTo(o2.getCreateTime());
			return flag;
		}
	};
	
	/**
	 * 是否同意入圃
	 * @return
	 */
	public String agreement() {
		gardenApply = gardenApplyService.getBeanById(id).getValue();
		if (isAgree == BooleanEnum.YES) {
			gardenApply.setTableInfo(info);
			changeState(GardenApplyStateEnum.AGREE,
					GardenProjectStateEnum.SEEDLING,gardenApply);
		}else  if (isAgree == BooleanEnum.NO) {
			gardenApply.setTableInfo(null);
			changeState(GardenApplyStateEnum.REJECT,
					GardenProjectStateEnum.TERMINATE,gardenApply);
		}
		if (isAgree == BooleanEnum.YES) {
			result = Result.success("该项目已成功入圃");
		}else {
			result = Result.success("已拒绝该项目入圃");
		}
		return JSON;
	}
	
	/**
	 * 更改状态
	 * @param applyState
	 * @param projectState
	 * @param gardenApply
	 */
	private void changeState(
			GardenApplyStateEnum applyState,
			GardenProjectStateEnum projectState,
			GardenApply gardenApply) {
		gardenApply.setApplyState(applyState);
		gardenApply.setProjectState(projectState);
		gardenApplyService.update(gardenApply);
	}
	
	
	public String changeState() {
		GardenApply apply = gardenApplyService.getBeanById(id).getValue();
		gardenApplyLog = new GardenApplyLog();
		User user = PbActivator.getSessionUser();
		if (apply != null && 
				apply.getApplyState() == GardenApplyStateEnum.AGREE) {
			gardenApplyLog.setApplyId(apply.getId());
			if (gardenApply != null) {
				apply.setApplyDirection(gardenApply.getApplyDirection());
				gardenApplyLog.setContent(user.getRealName()+"将项目去向设置为:"+
						gardenApply.getApplyDirection().getTitle());
				gardenApplyLogService.save(gardenApplyLog);
			}
			apply.setProjectState(state);
			gardenApplyService.update(apply);
			gardenApplyLog.setContent(user.getRealName()+"将项目状态设置为:"+state.getTitle());
			gardenApplyLogService.save(gardenApplyLog);
			result = Result.success("项目状态成功更改");
		}else {
			result = Result.failure("只有评审同意的项目才能更改状态");
		}
		return JSON;
	}
	
	/**
	 * 保存附件
	 * @return
	 */
	public String attSave() {
		result = gardenApplyAttService.save(gardenApplyAtt);
		return JSON;
	}
	
	/**
	 * 编辑附件
	 * @return
	 */
	public String attEdit() {
		result = gardenApplyAttService.getBeanById(id);
		return "attEdit";
	}
	
	
	/**
	 * 更新附件
	 * @return
	 */
	public String attUpdate(){
		GardenApplyAtt dbBean = gardenApplyAttService.getBeanById(gardenApplyAtt.getId()).getValue();
		BeanUtil.copyProperties(gardenApplyAtt, dbBean);
		result = gardenApplyAttService.update(dbBean);
		return JSON;
	}
	
	
	/**
	 * 删除本地文件
	 * <br/>删除原文件,若两种尺寸的缩列图存在,同时删除<br/>
	 * 缩列图尺寸:ImageUtil.MINSTR和ImageUtil.MAXSTR
	 */
	public String deleteByPath(){
		int pos = -1;
		File file1;//原文件
		File file2;//原文件名加上最小尺寸(ImageUtil.MINSTR)
		File file3;//原文件名加上最大尺寸(ImageUtil.MAXSTR)
		if (fileName != null && (pos = fileName.lastIndexOf("."))!= -1) {
			file1 = new File(rootPath+fileName);
			String prefix = fileName.substring(0,pos);//前缀
			String suffix = fileName.substring(pos);//后缀
			String newName = prefix+ImageUtil.MINSTR+suffix;
			file2 = new File(rootPath+newName);
			newName = prefix+ImageUtil.MAXSTR+suffix;
			file3 = new File(rootPath+newName);
			boolean isDel = false;
			if (file1.exists()) {
				isDel = file1.delete();
			}
			if (file2.exists()) {
				isDel = file2.delete() || isDel;
			}
			if (file3.exists()) {
				isDel = file3.delete() || isDel;
			}
			if(isDel){
				result = Result.success("删除文件成功");
			}else {
				result = Result.failure("删除文件失败");
			}
		}else {
			result = Result.success("删除文件失败,文件不存在!");
		}
		return JSON;
	}
	
	/**
	 * 删除数据库记录并删除服务器文件
	 * @return
	 */
	public String attDelete(){
		if(id!=null){
			gardenApplyAtt = gardenApplyAttService.getBeanById(id).getValue();
			fileName = gardenApplyAtt.getNewName();
			deleteByPath();
			result = gardenApplyAttService.deleteById(id);
		} else if(ids!=null){
			result = gardenApplyAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	/**
	 * 分配项目评审创业导师
	 * @return
	 */
	public String evalSave() {
		String[] uids = ids.split(",");
		gardenApplyEval = new GardenApplyEval();
		gardenApplyEval.setApplyId(applyId);
		gardenApplyEval.setFinished(BooleanEnum.NO);
		for (String uid : uids) {
			gardenApplyEval.setEvalUserId(Long.parseLong(uid));
			gardenApplyEvalService.save(gardenApplyEval);
		}
		result = Result.success("分配创业导师成功");
		return JSON;
	}
	
	/**
	 * 根据条件查找GardenApply列表
	 * @param propertyName 条件名:实体
	 * @param value 实体值
	 * @return
	 */
	private List<GardenApply> backGardenApplies(String conditions) {
		setPager(0);
		String[] fields = new String[]{
				GardenApplyStateEnum.EVAL.toString(),
				GardenApplyStateEnum.AGREE.toString(),
				GardenApplyStateEnum.REJECT.toString()};
		if (searchName != null) {
			searchName = StringUtil.ISOToUTF8(searchName);
		}
		root = gardenApplyService.getListByConditions(
				pager,conditions,searchName,"apply_state", fields);
		return root;
	}
	
	/**
	 * 育苗项目列表
	 * @return 
	 */
	public String seedling() {
		String conditions = "AND projectState='"+GardenProjectStateEnum.SEEDLING+"' ";
		backGardenApplies(conditions);
		result = Result.value(root);
		return "show";
	}
	
	/**
	 * 出苗项目列表
	 * @return
	 */
	public String emergence() {
		String conditions = "AND projectState='"+GardenProjectStateEnum.EMERGENCE+"' ";
		backGardenApplies(conditions);
		result = Result.value(root);
		return "show";
	}
	
	/**
	 * 终止项目列表
	 * @return
	 */
	public String terminate() {
		String conditions = "AND projectState='"+GardenProjectStateEnum.TERMINATE+"' ";
		backGardenApplies(conditions);
		result = Result.value(root);
		return "show";
	}
	
	/**
	 * 显示明细
	 * @return
	 */
	public String showView() {
		applyView();
		return "showView";
	}
	
	/**
	 * 删除评审信息
	 * @return
	 */
	public String evalDelete() {
		result = gardenApplyEvalService.deleteById(id);
		return JSON;
	}
	
	/**
	 * 查看评审信息
	 * @return
	 */
	public String evalView() {
		applyView();
		gardenApplyEval = gardenApplyEvalService.getBeanById(applyId).getValue();
		gardenApplyEval.setGardenApply(gardenApply);
		result = Result.value(gardenApplyEval);
		return "evalView";
	}
	
	/**
	 * 苗圃项目
	 * @return
	 */
	public String gardenProject() {
		return "gardenProject";
	}
	
	/**
	 * 项目审批
	 * @return
	 */
	public String evalApplyList() {
		User user = PbActivator.getSessionUser();
		List<GardenApplyEval> list = gardenApplyEvalService.getListByFilter(
				new Filter(GardenApplyEval.class).eq("evalUserId",user.getId())).getValue();
		Collections.sort(list,evalComparator);
		result = Result.value(list);
		return "evalApplyList";
	}
	
	Comparator<GardenApplyEval> evalComparator = new Comparator<GardenApplyEval>() {
		public int compare(GardenApplyEval o1, GardenApplyEval o2) {
			int flag = -1;
			if(o1.getFinished()== BooleanEnum.NO
					&& o2.getFinished() == BooleanEnum.NO){
				flag = o2.getModifyTime().compareTo(o1.getModifyTime());
			}else {
				if(o1.getFinished()== BooleanEnum.NO)
					flag = -1;
				else if (o2.getFinished() == BooleanEnum.NO)
					flag = 1;
				else
					flag = o2.getModifyTime().compareTo(o1.getModifyTime());
			}
			return flag;
		}
	};
	
	public String evalViewById(){
		result = gardenApplyEvalService.getBeanById(id);
		return "evalViewById";
	}
	
	
	/**
	 * 编辑评审
	 * @return
	 */
	public String evalEdit() {
		applyView();
		gardenApplyEval = gardenApplyEvalService.getBeanById(applyId).getValue();
		gardenApplyEval.setGardenApply(gardenApply);
		result = Result.value(gardenApplyEval);
		return "evalEdit";
	}
	
	/**
	 * 更新评审
	 * @return
	 */
	public String evalUpdate() {
		GardenApplyEval dbBean = gardenApplyEvalService.getBeanById(gardenApplyEval.getId()).getValue();
		BeanUtil.copyProperties(gardenApplyEval, dbBean);
		if (dbBean.getFinished() == BooleanEnum.NO) {
			dbBean.setFinished(BooleanEnum.YES);
		}
		result= Result.success("提交成功",gardenApplyEvalService.update(dbBean));
		return JSON;
	}
	
	
	/**
	 * 所有融资项目列表
	 * @return
	 */
	public String projects() {
		rows = pager.getRows();
		refresh(new Filter(GardenApply.class).eq("financing", BooleanEnum.YES));
		Collections.sort(root,comparator);
		setPager(root.size());
		result = Result.value(root);
		return "projects";
	}
	
	/**
	 * 新建备注信息
	 * @return
	 */
	public String applyLogAdd() {
		result = gardenApplyService.getBeanById(applyId);
		return "applyLogAdd";
	}
	
	/**
	 * 保存备注信息
	 * @return
	 */
	public String applyLogSave() {
		result = gardenApplyLogService.save(gardenApplyLog);
		return JSON;
	}
	
	/**
	 * 查看备注信息
	 * @return
	 */
	public String applyLogView() {
		result = gardenApplyLogService.getBeanById(id);
		return "applyLogView";
	}
	
	/**
	 * 更改备注信息
	 * @return
	 */
	public String applyLogEdit() {
		result = gardenApplyLogService.getBeanById(id);
		return "applyLogEdit";
	}
	
	/**
	 * 保存备注信息
	 * @return
	 */
	public String applyLogUpdate() {
		GardenApplyLog dbLog = gardenApplyLogService.
				getBeanById(gardenApplyLog.getId()).getValue();
		dbLog.setContent(gardenApplyLog.getContent());
		result = gardenApplyLogService.update(dbLog);
		return JSON;
	}
	
	/**
	 * 删除备注信息
	 * @return
	 */
	public String applyLogDelete() {
		result = gardenApplyLogService.deleteById(id);
		return JSON;
	}
	
	private void setPager(int total){
		if(page!=0){
			pager = new Pager(page,15);
			pager.setRecords(total);
		} else {
			pager = new Pager(1,15);
			pager.setRecords(total);
		}
	}
	
	@Override
	protected List<GardenApply> getListByFilter(Filter fitler) {
		return gardenApplyService.getListByFilter(fitler).getValue();
	}

	public void setGardenApplyService(GardenApplyService gardenApplyService) {
		this.gardenApplyService = gardenApplyService;
	}
	
	public void setGardenApplyAttService(GardenApplyAttService gardenApplyAttService) {
		this.gardenApplyAttService = gardenApplyAttService;
	}

	public void setGardenApplyEvalService(
			GardenApplyEvalService gardenApplyEvalService) {
		this.gardenApplyEvalService = gardenApplyEvalService;
	}
	
	public void setGardenApplyLogService(GardenApplyLogService gardenApplyLogService) {
		this.gardenApplyLogService = gardenApplyLogService;
	}

	@SuppressWarnings("rawtypes")
	public Result getResult() {
		return result;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public GardenApply getGardenApply() {
		return gardenApply;
	}

	public void setGardenApply(GardenApply gardenApply) {
		this.gardenApply = gardenApply;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getApplyId() {
		return applyId;
	}

	public void setApplyId(Long applyId) {
		this.applyId = applyId;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public GardenApplyAtt getGardenApplyAtt() {
		return gardenApplyAtt;
	}

	public void setGardenApplyAtt(GardenApplyAtt gardenApplyAtt) {
		this.gardenApplyAtt = gardenApplyAtt;
	}

	public GardenApplyEval getGardenApplyEval() {
		return gardenApplyEval;
	}

	public void setGardenApplyEval(GardenApplyEval gardenApplyEval) {
		this.gardenApplyEval = gardenApplyEval;
	}

	public GardenApplyLog getGardenApplyLog() {
		return gardenApplyLog;
	}

	public void setGardenApplyLog(GardenApplyLog gardenApplyLog) {
		this.gardenApplyLog = gardenApplyLog;
	}

	public BooleanEnum getIsAgree() {
		return isAgree;
	}

	public void setIsAgree(BooleanEnum isAgree) {
		this.isAgree = isAgree;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public GardenProjectStateEnum getState() {
		return state;
	}

	public void setState(GardenProjectStateEnum state) {
		this.state = state;
	}
	
	public InputStream getInputStream() {
		return inputStream;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}

	public String getSearchName() {
		return searchName;
	}

	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}

}
