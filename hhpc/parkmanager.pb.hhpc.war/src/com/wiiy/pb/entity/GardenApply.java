package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.pb.preferences.enums.GardenApplyDirectionEnum;
import com.wiiy.pb.preferences.enums.GardenApplySourceEnum;
import com.wiiy.pb.preferences.enums.GardenApplyStateEnum;
import com.wiiy.pb.preferences.enums.GardenProjectSourceEnum;
import com.wiiy.pb.preferences.enums.GardenProjectStateEnum;
import com.wiiy.pb.preferences.enums.GardenProjectTypeEnum;

/**
 * <br/>class-description 苗圃申请
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class GardenApply extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 项目名称
	 */
	@FieldDescription("项目名称")
	private String projectName;
	/**
	 * 项目来源
	 */
	@FieldDescription("项目来源")
	private GardenProjectSourceEnum projectSource;
	/**
	 * 项目具体来源
	 */
	@FieldDescription("项目具体来源")
	private String sourceDetail;
	/**
	 * 项目类型
	 */
	@FieldDescription("项目类型")
	private GardenProjectTypeEnum projectType;
	/**
	 * 项目具体类型
	 */
	@FieldDescription("项目具体类型")
	private String projectTypeDetail;
	/**
	 * 负责人姓名
	 */
	@FieldDescription("负责人姓名")
	private String leaderName;
	/**
	 * 负责人手机
	 */
	@FieldDescription("负责人手机")
	private String leaderMobile;
	/**
	 * 负责人Email
	 */
	@FieldDescription("负责人Email")
	private String leaderEmail;
	/**
	 * 负责人QQ
	 */
	@FieldDescription("负责人QQ")
	private String leaderQQ;
	/**
	 * 负责人学校
	 */
	@FieldDescription("负责人学校")
	private String leaderSchool;
	/**
	 * 院系年级
	 */
	@FieldDescription("院系年级")
	private String leaderCollege;
	/**
	 * 负责人紧急联系方式
	 */
	@FieldDescription("负责人紧急联系方式")
	private String leaderPhone;
	/**
	 * 项目简介
	 */
	@FieldDescription("项目简介")
	private String introduction;
	/**
	 * 比赛
	 */
	@FieldDescription("比赛")
	private String competition;
	/**
	 * 奖励专利
	 */
	@FieldDescription("奖励专利")
	private String reward;
	/**
	 * 指导老师
	 */
	@FieldDescription("指导老师")
	private String teacher;
	/**
	 * 项目成员姓名1
	 */
	@FieldDescription("项目成员姓名1")
	private String memberName1;
	/**
	 * 项目成员姓名2
	 */
	@FieldDescription("项目成员姓名2")
	private String memberName2;
	/**
	 * 项目成员姓名3
	 */
	@FieldDescription("项目成员姓名3")
	private String memberName3;
	/**
	 * 项目成员姓名4
	 */
	@FieldDescription("项目成员姓名4")
	private String memberName4;
	/**
	 * 项目成员姓名5
	 */
	@FieldDescription("项目成员姓名5")
	private String memberName5;
	/**
	 * 项目成员专业1
	 */
	@FieldDescription("项目成员专业1")
	private String memberMajor1;
	/**
	 * 项目成员专业2
	 */
	@FieldDescription("项目成员专业2")
	private String memberMajor2;
	/**
	 * 项目成员专业3
	 */
	@FieldDescription("项目成员专业3")
	private String memberMajor3;
	/**
	 * 项目成员专业4
	 */
	@FieldDescription("项目成员专业4")
	private String memberMajor4;
	/**
	 * 项目成员专业5
	 */
	@FieldDescription("项目成员专业5")
	private String memberMajor5;
	/**
	 * 项目成员联系方式1
	 */
	@FieldDescription("项目成员联系方式1")
	private String memberPhone1;
	/**
	 * 项目成员联系方式2
	 */
	@FieldDescription("项目成员联系方式2")
	private String memberPhone2;
	/**
	 * 项目成员联系方式3
	 */
	@FieldDescription("项目成员联系方式3")
	private String memberPhone3;
	/**
	 * 项目成员联系方式4
	 */
	@FieldDescription("项目成员联系方式4")
	private String memberPhone4;
	/**
	 * 项目成员联系方式5
	 */
	@FieldDescription("项目成员联系方式5")
	private String memberPhone5;
	/**
	 * 项目成员职能1
	 */
	@FieldDescription("项目成员职能1")
	private String memberRole1;
	/**
	 * 项目成员职能2
	 */
	@FieldDescription("项目成员职能2")
	private String memberRole2;
	/**
	 * 项目成员职能3
	 */
	@FieldDescription("项目成员职能3")
	private String memberRole3;
	/**
	 * 项目成员职能4
	 */
	@FieldDescription("项目成员职能4")
	private String memberRole4;
	/**
	 * 项目成员职能5
	 */
	@FieldDescription("项目成员职能5")
	private String memberRole5;
	/**
	 * 需要工位数
	 */
	@FieldDescription("需要工位数")
	private Integer tableCnt;
	/**
	 * 申请人
	 */
	@FieldDescription("申请人")
	private String applyer;
	/**
	 * 申请时间
	 */
	@FieldDescription("申请时间")
	private Date applyTime;
	/**
	 * 是否融资
	 */
	@FieldDescription("是否融资")
	private BooleanEnum financing;
	/**
	 * 是否发布到网站
	 */
	@FieldDescription("是否发布到网站")
	private BooleanEnum pub;
	/**
	 * 团队图片
	 */
	@FieldDescription("团队图片")
	private String photo;
	/**
	 * 团队图片原始名称
	 */
	@FieldDescription("团队图片原始名称")
	private String oldName;
	/**
	 * 入驻工位信息
	 */
	@FieldDescription("入驻工位信息")
	private String tableInfo;
	/**
	 * 信息来源
	 */
	@FieldDescription("信息来源")
	private GardenApplySourceEnum applySource;
	/**
	 * 项目状态
	 */
	@FieldDescription("项目状态")
	private GardenProjectStateEnum projectState;
	/**
	 * 申请状态
	 */
	@FieldDescription("申请状态")
	private GardenApplyStateEnum applyState;
	
	/**
	 * 项目去向
	 */
	@FieldDescription("项目去向")
	private GardenApplyDirectionEnum applyDirection;
	
	/**
	 * 项目计划书附件
	 */
	@FieldDescription("项目计划书附件")
	private List<GardenApplyAtt> gardenApplyAtts;
	
	/**
	 * 附件
	 */
	@FieldDescription("附件")
	private List<GardenApplyAtt> applyAtts;
	
	/**
	 * 创业导师
	 */
	@FieldDescription("创业导师")
	private List<GardenApplyEval> gardenApplyEvals ;
	
	/**
	 * 企业id
	 */
	private Long customerId;
	
	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 项目名称
	 */
	public String getProjectName(){
		return projectName;
	}
	public void setProjectName(String projectName){
		this.projectName = projectName;
	}
	/**
	 * 项目来源
	 */
	public GardenProjectSourceEnum getProjectSource(){
		return projectSource;
	}
	public void setProjectSource(GardenProjectSourceEnum projectSource){
		this.projectSource = projectSource;
	}
	/**
	 * 项目具体来源
	 */
	public String getSourceDetail(){
		return sourceDetail;
	}
	public void setSourceDetail(String sourceDetail){
		this.sourceDetail = sourceDetail;
	}
	/**
	 * 项目类型
	 */
	public GardenProjectTypeEnum getProjectType(){
		return projectType;
	}
	public void setProjectType(GardenProjectTypeEnum projectType){
		this.projectType = projectType;
	}
	/**
	 * 项目具体类型
	 */
	public String getProjectTypeDetail(){
		return projectTypeDetail;
	}
	public void setProjectTypeDetail(String projectTypeDetail){
		this.projectTypeDetail = projectTypeDetail;
	}
	/**
	 * 负责人姓名
	 */
	public String getLeaderName(){
		return leaderName;
	}
	public void setLeaderName(String leaderName){
		this.leaderName = leaderName;
	}
	/**
	 * 负责人手机
	 */
	public String getLeaderMobile(){
		return leaderMobile;
	}
	public void setLeaderMobile(String leaderMobile){
		this.leaderMobile = leaderMobile;
	}
	/**
	 * 负责人Email
	 */
	public String getLeaderEmail(){
		return leaderEmail;
	}
	public void setLeaderEmail(String leaderEmail){
		this.leaderEmail = leaderEmail;
	}
	/**
	 * 负责人QQ
	 */
	public String getLeaderQQ(){
		return leaderQQ;
	}
	public void setLeaderQQ(String leaderQQ){
		this.leaderQQ = leaderQQ;
	}
	/**
	 * 负责人学校
	 */
	public String getLeaderSchool(){
		return leaderSchool;
	}
	public void setLeaderSchool(String leaderSchool){
		this.leaderSchool = leaderSchool;
	}
	/**
	 * 院系年级
	 */
	public String getLeaderCollege(){
		return leaderCollege;
	}
	public void setLeaderCollege(String leaderCollege){
		this.leaderCollege = leaderCollege;
	}
	/**
	 * 负责人紧急联系方式
	 */
	public String getLeaderPhone(){
		return leaderPhone;
	}
	public void setLeaderPhone(String leaderPhone){
		this.leaderPhone = leaderPhone;
	}
	/**
	 * 项目简介
	 */
	public String getIntroduction(){
		return introduction;
	}
	public void setIntroduction(String introduction){
		this.introduction = introduction;
	}
	/**
	 * 比赛
	 */
	public String getCompetition(){
		return competition;
	}
	public void setCompetition(String competition){
		this.competition = competition;
	}
	/**
	 * 奖励专利
	 */
	public String getReward(){
		return reward;
	}
	public void setReward(String reward){
		this.reward = reward;
	}
	/**
	 * 指导老师
	 */
	public String getTeacher(){
		return teacher;
	}
	public void setTeacher(String teacher){
		this.teacher = teacher;
	}
	/**
	 * 项目成员姓名1
	 */
	public String getMemberName1(){
		return memberName1;
	}
	public void setMemberName1(String memberName1){
		this.memberName1 = memberName1;
	}
	/**
	 * 项目成员姓名2
	 */
	public String getMemberName2(){
		return memberName2;
	}
	public void setMemberName2(String memberName2){
		this.memberName2 = memberName2;
	}
	/**
	 * 项目成员姓名3
	 */
	public String getMemberName3(){
		return memberName3;
	}
	public void setMemberName3(String memberName3){
		this.memberName3 = memberName3;
	}
	/**
	 * 项目成员姓名4
	 */
	public String getMemberName4(){
		return memberName4;
	}
	public void setMemberName4(String memberName4){
		this.memberName4 = memberName4;
	}
	/**
	 * 项目成员姓名5
	 */
	public String getMemberName5(){
		return memberName5;
	}
	public void setMemberName5(String memberName5){
		this.memberName5 = memberName5;
	}
	/**
	 * 项目成员专业1
	 */
	public String getMemberMajor1(){
		return memberMajor1;
	}
	public void setMemberMajor1(String memberMajor1){
		this.memberMajor1 = memberMajor1;
	}
	/**
	 * 项目成员专业2
	 */
	public String getMemberMajor2(){
		return memberMajor2;
	}
	public void setMemberMajor2(String memberMajor2){
		this.memberMajor2 = memberMajor2;
	}
	/**
	 * 项目成员专业3
	 */
	public String getMemberMajor3(){
		return memberMajor3;
	}
	public void setMemberMajor3(String memberMajor3){
		this.memberMajor3 = memberMajor3;
	}
	/**
	 * 项目成员专业4
	 */
	public String getMemberMajor4(){
		return memberMajor4;
	}
	public void setMemberMajor4(String memberMajor4){
		this.memberMajor4 = memberMajor4;
	}
	/**
	 * 项目成员专业5
	 */
	public String getMemberMajor5(){
		return memberMajor5;
	}
	public void setMemberMajor5(String memberMajor5){
		this.memberMajor5 = memberMajor5;
	}
	/**
	 * 项目成员联系方式1
	 */
	public String getMemberPhone1(){
		return memberPhone1;
	}
	public void setMemberPhone1(String memberPhone1){
		this.memberPhone1 = memberPhone1;
	}
	/**
	 * 项目成员联系方式2
	 */
	public String getMemberPhone2(){
		return memberPhone2;
	}
	public void setMemberPhone2(String memberPhone2){
		this.memberPhone2 = memberPhone2;
	}
	/**
	 * 项目成员联系方式3
	 */
	public String getMemberPhone3(){
		return memberPhone3;
	}
	public void setMemberPhone3(String memberPhone3){
		this.memberPhone3 = memberPhone3;
	}
	/**
	 * 项目成员联系方式4
	 */
	public String getMemberPhone4(){
		return memberPhone4;
	}
	public void setMemberPhone4(String memberPhone4){
		this.memberPhone4 = memberPhone4;
	}
	/**
	 * 项目成员联系方式5
	 */
	public String getMemberPhone5(){
		return memberPhone5;
	}
	public void setMemberPhone5(String memberPhone5){
		this.memberPhone5 = memberPhone5;
	}
	/**
	 * 项目成员职能1
	 */
	public String getMemberRole1(){
		return memberRole1;
	}
	public void setMemberRole1(String memberRole1){
		this.memberRole1 = memberRole1;
	}
	/**
	 * 项目成员职能2
	 */
	public String getMemberRole2(){
		return memberRole2;
	}
	public void setMemberRole2(String memberRole2){
		this.memberRole2 = memberRole2;
	}
	/**
	 * 项目成员职能3
	 */
	public String getMemberRole3(){
		return memberRole3;
	}
	public void setMemberRole3(String memberRole3){
		this.memberRole3 = memberRole3;
	}
	/**
	 * 项目成员职能4
	 */
	public String getMemberRole4(){
		return memberRole4;
	}
	public void setMemberRole4(String memberRole4){
		this.memberRole4 = memberRole4;
	}
	/**
	 * 项目成员职能5
	 */
	public String getMemberRole5(){
		return memberRole5;
	}
	public void setMemberRole5(String memberRole5){
		this.memberRole5 = memberRole5;
	}
	/**
	 * 需要工位数
	 */
	public Integer getTableCnt(){
		return tableCnt;
	}
	public void setTableCnt(Integer tableCnt){
		this.tableCnt = tableCnt;
	}
	/**
	 * 申请人
	 */
	public String getApplyer(){
		return applyer;
	}
	public void setApplyer(String applyer){
		this.applyer = applyer;
	}
	/**
	 * 申请时间
	 */
	public Date getApplyTime(){
		return applyTime;
	}
	public void setApplyTime(Date applyTime){
		this.applyTime = applyTime;
	}
	/**
	 * 是否融资
	 */
	public BooleanEnum getFinancing(){
		return financing;
	}
	public void setFinancing(BooleanEnum financing){
		this.financing = financing;
	}
	/**
	 * 是否发布到网站
	 */
	public BooleanEnum getPub() {
		return pub;
	}
	public void setPub(BooleanEnum pub) {
		this.pub = pub;
	}
	/**
	 * 入驻工位信息
	 */
	public String getTableInfo(){
		return tableInfo;
	}
	public void setTableInfo(String tableInfo){
		this.tableInfo = tableInfo;
	}
	/**
	 * 信息来源
	 */
	public GardenApplySourceEnum getApplySource(){
		return applySource;
	}
	public void setApplySource(GardenApplySourceEnum applySource){
		this.applySource = applySource;
	}
	/**
	 * 项目状态
	 */
	public GardenProjectStateEnum getProjectState(){
		return projectState;
	}
	public void setProjectState(GardenProjectStateEnum projectState){
		this.projectState = projectState;
	}
	/**
	 * 申请状态
	 */
	public GardenApplyStateEnum getApplyState(){
		return applyState;
	}
	public void setApplyState(GardenApplyStateEnum applyState){
		this.applyState = applyState;
	}
	
	public GardenApplyDirectionEnum getApplyDirection() {
		return applyDirection;
	}
	public void setApplyDirection(GardenApplyDirectionEnum applyDirection) {
		this.applyDirection = applyDirection;
	}
	/**
	 * 项目计划书附件
	 */
	public List<GardenApplyAtt> getGardenApplyAtts() {
		return gardenApplyAtts;
	}
	public void setGardenApplyAtts(List<GardenApplyAtt> gardenApplyAtts) {
		this.gardenApplyAtts = gardenApplyAtts;
	}
	
	/**
	 * 附件
	 */
	public List<GardenApplyAtt> getApplyAtts() {
		return applyAtts;
	}
	public void setApplyAtts(List<GardenApplyAtt> applyAtts) {
		this.applyAtts = applyAtts;
	}
	
	/**
	 * 创业导师
	 */
	public List<GardenApplyEval> getGardenApplyEvals() {
		return gardenApplyEvals;
	}
	public void setGardenApplyEvals(List<GardenApplyEval> gardenApplyEvals) {
		this.gardenApplyEvals = gardenApplyEvals;
	}
	
	/**
	 * 企业id
	 */
	public Long getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getOldName() {
		return oldName;
	}
	public void setOldName(String oldName) {
		this.oldName = oldName;
	}
}