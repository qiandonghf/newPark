package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.User;
import com.wiiy.pb.entity.GardenApply;
import com.wiiy.pb.preferences.enums.GardenProjectEvalEnum;

/**
 * <br/>class-description 苗圃申请评审
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class GardenApplyEval extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 评审人
	 */
	@FieldDescription("评审人")
	private User evalUser;
	/**
	 * 苗圃申请实体
	 */
	@FieldDescription("苗圃申请实体")
	private GardenApply gardenApply;
	/**
	 * 评审人外键
	 */
	@FieldDescription("评审人外键")
	private Long evalUserId;
	/**
	 * 苗圃申请外键
	 */
	@FieldDescription("苗圃申请外键")
	private Long applyId;
	/**
	 * 是否已评审
	 */
	@FieldDescription("是否已评审")
	private BooleanEnum finished;
	/**
	 * 是否符合产业导向
	 */
	@FieldDescription("是否符合产业导向")
	private BooleanEnum meetDevelop;
	/**
	 * 申请人资质
	 */
	@FieldDescription("申请人资质")
	private GardenProjectEvalEnum qualification;
	/**
	 * 团队情况
	 */
	@FieldDescription("团队情况")
	private GardenProjectEvalEnum team;
	/**
	 * 产品或服务的创新性
	 */
	@FieldDescription("产品或服务的创新性")
	private GardenProjectEvalEnum innovation;
	/**
	 * 商业模式
	 */
	@FieldDescription("商业模式")
	private GardenProjectEvalEnum businessModel;
	/**
	 * 创业计划
	 */
	@FieldDescription("创业计划")
	private GardenProjectEvalEnum businessPlan;
	/**
	 * 技术优势
	 */
	@FieldDescription("技术优势")
	private GardenProjectEvalEnum technicalSuperiority;
	/**
	 * 智力成果
	 */
	@FieldDescription("智力成果")
	private GardenProjectEvalEnum intellectualProperty;
	/**
	 * 总评
	 */
	@FieldDescription("总评")
	private GardenProjectEvalEnum totalScore;
	/**
	 * 评审详情
	 */
	@FieldDescription("评审详情")
	private String evalDetail;
	/**
	 * 评审时间
	 */
	@FieldDescription("评审时间")
	private Date evalTime;
	/**
	 * 是否同意入驻
	 */
	@FieldDescription("是否同意入驻")
	private BooleanEnum agree;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 评审人
	 */
	public User getEvalUser(){
		return evalUser;
	}
	public void setEvalUser(User evalUser){
		this.evalUser = evalUser;
	}
	/**
	 * 苗圃申请实体
	 */
	public GardenApply getGardenApply(){
		return gardenApply;
	}
	public void setGardenApply(GardenApply gardenApply){
		this.gardenApply = gardenApply;
	}
	/**
	 * 评审人外键
	 */
	public Long getEvalUserId(){
		return evalUserId;
	}
	public void setEvalUserId(Long evalUserId){
		this.evalUserId = evalUserId;
	}
	/**
	 * 苗圃申请外键
	 */
	public Long getApplyId(){
		return applyId;
	}
	public void setApplyId(Long applyId){
		this.applyId = applyId;
	}
	/**
	 * 是否已评审
	 */
	public BooleanEnum getFinished(){
		return finished;
	}
	public void setFinished(BooleanEnum finished){
		this.finished = finished;
	}
	/**
	 * 是否符合产业导向
	 */
	public BooleanEnum getMeetDevelop(){
		return meetDevelop;
	}
	public void setMeetDevelop(BooleanEnum meetDevelop){
		this.meetDevelop = meetDevelop;
	}
	/**
	 * 申请人资质
	 */
	public GardenProjectEvalEnum getQualification(){
		return qualification;
	}
	public void setQualification(GardenProjectEvalEnum qualification){
		this.qualification = qualification;
	}
	/**
	 * 团队情况
	 */
	public GardenProjectEvalEnum getTeam(){
		return team;
	}
	public void setTeam(GardenProjectEvalEnum team){
		this.team = team;
	}
	/**
	 * 产品或服务的创新性
	 */
	public GardenProjectEvalEnum getInnovation(){
		return innovation;
	}
	public void setInnovation(GardenProjectEvalEnum innovation){
		this.innovation = innovation;
	}
	/**
	 * 商业模式
	 */
	public GardenProjectEvalEnum getBusinessModel(){
		return businessModel;
	}
	public void setBusinessModel(GardenProjectEvalEnum businessModel){
		this.businessModel = businessModel;
	}
	/**
	 * 创业计划
	 */
	public GardenProjectEvalEnum getBusinessPlan(){
		return businessPlan;
	}
	public void setBusinessPlan(GardenProjectEvalEnum businessPlan){
		this.businessPlan = businessPlan;
	}
	/**
	 * 技术优势
	 */
	public GardenProjectEvalEnum getTechnicalSuperiority(){
		return technicalSuperiority;
	}
	public void setTechnicalSuperiority(GardenProjectEvalEnum technicalSuperiority){
		this.technicalSuperiority = technicalSuperiority;
	}
	/**
	 * 智力成果
	 */
	public GardenProjectEvalEnum getIntellectualProperty(){
		return intellectualProperty;
	}
	public void setIntellectualProperty(GardenProjectEvalEnum intellectualProperty){
		this.intellectualProperty = intellectualProperty;
	}
	/**
	 * 总评
	 */
	public GardenProjectEvalEnum getTotalScore(){
		return totalScore;
	}
	public void setTotalScore(GardenProjectEvalEnum totalScore){
		this.totalScore = totalScore;
	}
	/**
	 * 评审详情
	 */
	public String getEvalDetail(){
		return evalDetail;
	}
	public void setEvalDetail(String evalDetail){
		this.evalDetail = evalDetail;
	}
	/**
	 * 评审时间
	 */
	public Date getEvalTime(){
		return evalTime;
	}
	public void setEvalTime(Date evalTime){
		this.evalTime = evalTime;
	}
	/**
	 * 是否同意入驻
	 */
	public BooleanEnum getAgree(){
		return agree;
	}
	public void setAgree(BooleanEnum agree){
		this.agree = agree;
	}
}