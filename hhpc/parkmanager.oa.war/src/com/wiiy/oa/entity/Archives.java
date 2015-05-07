package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.GenderEnum;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.entity.Org;
import com.wiiy.core.entity.User;
import com.wiiy.oa.preferences.enums.PositionConditionEnum;

/**
 * <br/>class-description 档案
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Archives extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 宗教信仰
	 */
	@FieldDescription("宗教信仰")
	private DataDict religious;
	/**
	 * 用户
	 */
	@FieldDescription("用户")
	private User user;
	/**
	 * 政治面貌
	 */
	@FieldDescription("政治面貌")
	private DataDict political;
	/**
	 * 国籍
	 */
	@FieldDescription("国籍")
	private DataDict nationality;
	/**
	 * 民族
	 */
	@FieldDescription("民族")
	private DataDict ethnic;
	/**
	 * 所属部门
	 */
	@FieldDescription("所属部门")
	private Org org;
	/**
	 * 档案编号
	 */
	@FieldDescription("档案编号")
	private String serialNo;
	/**
	 * 员工姓名
	 */
	@FieldDescription("员工姓名")
	private String name;
	/**
	 * 身份证号
	 */
	@FieldDescription("身份证号")
	private String idNo;
	/**
	 * 宗教信仰外键
	 */
	@FieldDescription("宗教信仰外键")
	private String religiousId;
	/**
	 * 用户外键
	 */
	@FieldDescription("用户外键")
	private Long userId;
	/**
	 * 出生日期
	 */
	@FieldDescription("出生日期")
	private Date birthDay;
	/**
	 * 政治面貌外键
	 */
	@FieldDescription("政治面貌外键")
	private String politicalId;
	/**
	 * 性别
	 */
	@FieldDescription("性别")
	private GenderEnum gender;
	/**
	 * 国籍外键
	 */
	@FieldDescription("国籍外键")
	private String nationalityId;
	/**
	 * 是否已婚
	 */
	@FieldDescription("是否已婚")
	private BooleanEnum marriage;
	/**
	 * 民族外键
	 */
	@FieldDescription("民族外键")
	private String ethnicId;
	/**
	 * 籍贯
	 */
	@FieldDescription("籍贯")
	private String homeTown;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private PositionConditionEnum status;
	/**
	 * 照片
	 */
	@FieldDescription("照片")
	private String photo;
	/**
	 * 部门外键
	 */
	@FieldDescription("部门外键")
	private Long orgId;
	/**
	 * 职务
	 */
	@FieldDescription("职务")
	private String position;
	/**
	 * 入职时间
	 */
	@FieldDescription("入职时间")
	private Date entryTime;
	/**
	 * 合同开始时间
	 */
	@FieldDescription("合同开始时间")
	private Date startTime;
	/**
	 * 合同结束时间
	 */
	@FieldDescription("合同结束时间")
	private Date endTime;
	/**
	 * 开户行
	 */
	@FieldDescription("开户行")
	private String bank;
	/**
	 * 银行账号
	 */
	@FieldDescription("银行账号")
	private String bankAccount;
	/**
	 * 培训情况
	 */
	@FieldDescription("培训情况")
	private String train;
	/**
	 * 家庭地址
	 */
	@FieldDescription("家庭地址")
	private String homeAddr;
	/**
	 * 电话号码
	 */
	@FieldDescription("电话号码")
	private String phone;
	/**
	 * 家庭邮编
	 */
	@FieldDescription("家庭邮编")
	private String zipCode;
	/**
	 * QQ号码
	 */
	@FieldDescription("QQ号码")
	private String qq;
	/**
	 * 邮箱地址
	 */
	@FieldDescription("邮箱地址")
	private String email;
	/**
	 * 手机号码
	 */
	@FieldDescription("手机号码")
	private String mobile;
	/**
	 * 学历
	 */
	@FieldDescription("学历")
	private String degree;
	/**
	 * 毕业学校
	 */
	@FieldDescription("毕业学校")
	private String school;
	/**
	 * 专业
	 */
	@FieldDescription("专业")
	private String profession;
	/**
	 * 参加工作时间
	 */
	@FieldDescription("参加工作时间")
	private String workTime;
	/**
	 * 教育背景
	 */
	@FieldDescription("教育背景")
	private String education;
	/**
	 * 奖惩情情况
	 */
	@FieldDescription("奖惩情情况")
	private String rewards;
	/**
	 * 工作经验
	 */
	@FieldDescription("工作经验")
	private String experience;
	/**
	 * 个人爱好
	 */
	@FieldDescription("个人爱好")
	private String hobby;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 宗教信仰
	 */
	public DataDict getReligious(){
		return religious;
	}
	public void setReligious(DataDict religious){
		this.religious = religious;
	}
	/**
	 * 用户
	 */
	public User getUser(){
		return user;
	}
	public void setUser(User user){
		this.user = user;
	}
	/**
	 * 政治面貌
	 */
	public DataDict getPolitical(){
		return political;
	}
	public void setPolitical(DataDict political){
		this.political = political;
	}
	/**
	 * 国籍
	 */
	public DataDict getNationality(){
		return nationality;
	}
	public void setNationality(DataDict nationality){
		this.nationality = nationality;
	}
	/**
	 * 民族
	 */
	public DataDict getEthnic(){
		return ethnic;
	}
	public void setEthnic(DataDict ethnic){
		this.ethnic = ethnic;
	}
	/**
	 * 所属部门
	 */
	public Org getOrg(){
		return org;
	}
	public void setOrg(Org org){
		this.org = org;
	}
	/**
	 * 档案编号
	 */
	public String getSerialNo(){
		return serialNo;
	}
	public void setSerialNo(String serialNo){
		this.serialNo = serialNo;
	}
	/**
	 * 员工姓名
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 身份证号
	 */
	public String getIdNo(){
		return idNo;
	}
	public void setIdNo(String idNo){
		this.idNo = idNo;
	}
	/**
	 * 宗教信仰外键
	 */
	public String getReligiousId(){
		return religiousId;
	}
	public void setReligiousId(String religiousId){
		this.religiousId = religiousId;
	}
	/**
	 * 用户外键
	 */
	public Long getUserId(){
		return userId;
	}
	public void setUserId(Long userId){
		this.userId = userId;
	}
	/**
	 * 出生日期
	 */
	public Date getBirthDay(){
		return birthDay;
	}
	public void setBirthDay(Date birthDay){
		this.birthDay = birthDay;
	}
	/**
	 * 政治面貌外键
	 */
	public String getPoliticalId(){
		return politicalId;
	}
	public void setPoliticalId(String politicalId){
		this.politicalId = politicalId;
	}
	/**
	 * 性别
	 */
	public GenderEnum getGender(){
		return gender;
	}
	public void setGender(GenderEnum gender){
		this.gender = gender;
	}
	/**
	 * 国籍外键
	 */
	public String getNationalityId(){
		return nationalityId;
	}
	public void setNationalityId(String nationalityId){
		this.nationalityId = nationalityId;
	}
	/**
	 * 是否已婚
	 */
	public BooleanEnum getMarriage(){
		return marriage;
	}
	public void setMarriage(BooleanEnum marriage){
		this.marriage = marriage;
	}
	/**
	 * 民族外键
	 */
	public String getEthnicId(){
		return ethnicId;
	}
	public void setEthnicId(String ethnicId){
		this.ethnicId = ethnicId;
	}
	/**
	 * 籍贯
	 */
	public String getHomeTown(){
		return homeTown;
	}
	public void setHomeTown(String homeTown){
		this.homeTown = homeTown;
	}
	/**
	 * 状态
	 */
	public PositionConditionEnum getStatus() {
		return status;
	}
	public void setStatus(PositionConditionEnum status) {
		this.status = status;
	}
	/**
	 * 照片
	 */
	public String getPhoto(){
		return photo;
	}
	
	public void setPhoto(String photo){
		this.photo = photo;
	}
	/**
	 * 部门外键
	 */
	public Long getOrgId(){
		return orgId;
	}
	public void setOrgId(Long orgId){
		this.orgId = orgId;
	}
	/**
	 * 职务
	 */
	public String getPosition(){
		return position;
	}
	public void setPosition(String position){
		this.position = position;
	}
	/**
	 * 入职时间
	 */
	public Date getEntryTime(){
		return entryTime;
	}
	public void setEntryTime(Date entryTime){
		this.entryTime = entryTime;
	}
	/**
	 * 合同开始时间
	 */
	public Date getStartTime(){
		return startTime;
	}
	public void setStartTime(Date startTime){
		this.startTime = startTime;
	}
	/**
	 * 合同结束时间
	 */
	public Date getEndTime(){
		return endTime;
	}
	public void setEndTime(Date endTime){
		this.endTime = endTime;
	}
	/**
	 * 开户行
	 */
	public String getBank(){
		return bank;
	}
	public void setBank(String bank){
		this.bank = bank;
	}
	/**
	 * 银行账号
	 */
	public String getBankAccount(){
		return bankAccount;
	}
	public void setBankAccount(String bankAccount){
		this.bankAccount = bankAccount;
	}
	/**
	 * 培训情况
	 */
	public String getTrain(){
		return train;
	}
	public void setTrain(String train){
		this.train = train;
	}
	/**
	 * 家庭地址
	 */
	public String getHomeAddr(){
		return homeAddr;
	}
	public void setHomeAddr(String homeAddr){
		this.homeAddr = homeAddr;
	}
	/**
	 * 电话号码
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
	/**
	 * 家庭邮编
	 */
	public String getZipCode(){
		return zipCode;
	}
	public void setZipCode(String zipCode){
		this.zipCode = zipCode;
	}
	/**
	 * QQ号码
	 */
	public String getQq(){
		return qq;
	}
	public void setQq(String qq){
		this.qq = qq;
	}
	/**
	 * 邮箱地址
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	/**
	 * 手机号码
	 */
	public String getMobile(){
		return mobile;
	}
	public void setMobile(String mobile){
		this.mobile = mobile;
	}
	/**
	 * 学历
	 */
	public String getDegree(){
		return degree;
	}
	public void setDegree(String degree){
		this.degree = degree;
	}
	/**
	 * 毕业学校
	 */
	public String getSchool(){
		return school;
	}
	public void setSchool(String school){
		this.school = school;
	}
	/**
	 * 专业
	 */
	public String getProfession(){
		return profession;
	}
	public void setProfession(String profession){
		this.profession = profession;
	}
	/**
	 * 参加工作时间
	 */
	public String getWorkTime(){
		return workTime;
	}
	public void setWorkTime(String workTime){
		this.workTime = workTime;
	}
	/**
	 * 教育背景
	 */
	public String getEducation(){
		return education;
	}
	public void setEducation(String education){
		this.education = education;
	}
	/**
	 * 奖惩情情况
	 */
	public String getRewards(){
		return rewards;
	}
	public void setRewards(String rewards){
		this.rewards = rewards;
	}
	/**
	 * 工作经验
	 */
	public String getExperience(){
		return experience;
	}
	public void setExperience(String experience){
		this.experience = experience;
	}
	/**
	 * 个人爱好
	 */
	public String getHobby(){
		return hobby;
	}
	public void setHobby(String hobby){
		this.hobby = hobby;
	}
	/**
	 * 备注
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
}