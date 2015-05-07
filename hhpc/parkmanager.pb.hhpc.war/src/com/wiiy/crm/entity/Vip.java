package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.GenderEnum;
import com.wiiy.core.entity.DataDict;

/**
 * <br/>class-description VIP
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Vip extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 所在城市
	 */
	@FieldDescription("所在城市")
	private DataDict city;
	/**
	 * 编号
	 */
	@FieldDescription("编号")
	private Long orderId;
	/**
	 * 账号ID
	 */
	@FieldDescription("账号ID")
	private Long userId;
	/**
	 * 名称
	 */
	@FieldDescription("名称")
	private String name;
	/**
	 * 性别
	 */
	@FieldDescription("性别")
	private GenderEnum gender;
	/**
	 * 所在城市外键
	 */
	@FieldDescription("所在城市外键")
	private String cityId;
	/**
	 * 单位地址
	 */
	@FieldDescription("单位地址")
	private String address;
	/**
	 * 手机
	 */
	@FieldDescription("手机")
	private String mobile;
	/**
	 * 专长领域
	 */
	@FieldDescription("专长领域")
	private String speciality;
	/**
	 * 所在单位
	 */
	@FieldDescription("所在单位")
	private String nuit;
	/**
	 * 联系电话
	 */
	@FieldDescription("联系电话")
	private String phone;
	/**
	 * 联系人名称
	 */
	@FieldDescription("联系人名称")
	private String expertName;
	/**
	 * 联系人电话
	 */
	@FieldDescription("联系人电话")
	private String expertPhone;
	/**
	 * Email地址
	 */
	@FieldDescription("Email地址")
	private String email;
	/**
	 * 联系人Email
	 */
	@FieldDescription("联系人Email")
	private String expertEmail;
	/**
	 * 照片
	 */
	@FieldDescription("照片")
	private String photo;
	/**
	 * 职称
	 */
	@FieldDescription("职称")
	private String position;
	/**
	 * 职务
	 */
	@FieldDescription("职务")
	private String job;
	/**
	 * 出生年月
	 */
	@FieldDescription("出生年月")
	private String birth;
	/**
	 * 学历
	 */
	@FieldDescription("学历")
	private String education;
	/**
	 * 简介
	 */
	@FieldDescription("简介")
	private String memo;
	/**
	 * 是否导师
	 */
	@FieldDescription("是否导师")
	private BooleanEnum tutor;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 所在城市
	 */
	public DataDict getCity(){
		return city;
	}
	public void setCity(DataDict city){
		this.city = city;
	}
	/**
	 * 编号
	 */
	public Long getOrderId(){
		return orderId;
	}
	public void setOrderId(Long orderId){
		this.orderId = orderId;
	}
	/**
	 * 名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
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
	 * 所在城市外键
	 */
	public String getCityId(){
		return cityId;
	}
	public void setCityId(String cityId){
		this.cityId = cityId;
	}
	/**
	 * 单位地址
	 */
	public String getAddress(){
		return address;
	}
	public void setAddress(String address){
		this.address = address;
	}
	/**
	 * 手机
	 */
	public String getMobile(){
		return mobile;
	}
	public void setMobile(String mobile){
		this.mobile = mobile;
	}
	/**
	 * 专长领域
	 */
	public String getSpeciality(){
		return speciality;
	}
	public void setSpeciality(String speciality){
		this.speciality = speciality;
	}
	/**
	 * 所在单位
	 */
	public String getNuit(){
		return nuit;
	}
	public void setNuit(String nuit){
		this.nuit = nuit;
	}
	/**
	 * 联系电话
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
	/**
	 * 联系人名称
	 */
	public String getExpertName(){
		return expertName;
	}
	public void setExpertName(String expertName){
		this.expertName = expertName;
	}
	/**
	 * 联系人电话
	 */
	public String getExpertPhone(){
		return expertPhone;
	}
	public void setExpertPhone(String expertPhone){
		this.expertPhone = expertPhone;
	}
	/**
	 * Email地址
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	/**
	 * 联系人Email
	 */
	public String getExpertEmail(){
		return expertEmail;
	}
	public void setExpertEmail(String expertEmail){
		this.expertEmail = expertEmail;
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
	 * 职称
	 */
	public String getPosition(){
		return position;
	}
	public void setPosition(String position){
		this.position = position;
	}
	/**
	 * 职务
	 */
	public String getJob(){
		return job;
	}
	public void setJob(String job){
		this.job = job;
	}
	/**
	 * 出生年月
	 */
	public String getBirth(){
		return birth;
	}
	public void setBirth(String birth){
		this.birth = birth;
	}
	/**
	 * 学历
	 */
	public String getEducation(){
		return education;
	}
	public void setEducation(String education){
		this.education = education;
	}
	/**
	 * 简介
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
	/**
	 * 是否导师
	 */
	public BooleanEnum getTutor(){
		return tutor;
	}
	public void setTutor(BooleanEnum tutor){
		this.tutor = tutor;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
}