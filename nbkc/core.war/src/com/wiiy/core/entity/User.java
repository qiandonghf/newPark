package com.wiiy.core.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.struts2.json.annotations.JSON;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.GenderEnum;
import com.wiiy.commons.preferences.enums.UserTypeEnum;
import com.wiiy.core.dto.CustomerDto;
import com.wiiy.core.dto.IncubatorDto;

/**
 * <br/>class-description 用户
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class User extends BaseEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	/**
	 * 邮箱配置
	 */
	@FieldDescription("邮箱配置")
	private UserEmailParam userEmailParam;
	
	
	
	/**
	 * 所属组织
	 */
	@FieldDescription("所属组织")
	private Org org;
	/**
	 * 用户名
	 */
	@FieldDescription("用户名")
	private String username;
	/**
	 * MD5加密密码
	 */
	@FieldDescription("MD5加密密码")
	private String password;
	/**
	 * 真实姓名
	 */
	@FieldDescription("真实姓名")
	private String realName;
	/**
	 * 性别
	 */
	@FieldDescription("性别")
	private GenderEnum gender;
	/**
	 * 出生日期
	 */
	@FieldDescription("出生日期")
	private Date birthday;
	/**
	 * 头像URL
	 */
	@FieldDescription("头像URL")
	private String imagery;
	/**
	 * 手机号码
	 */
	@FieldDescription("手机号码")
	private String mobile;
	/**
	 * 电话号码
	 */
	@FieldDescription("电话号码")
	private String telephone;
	/**
	 * Email地址
	 */
	@FieldDescription("Email地址")
	private String email;
	/**
	 * MSN
	 */
	@FieldDescription("MSN")
	private String msn;
	/**
	 * 本次登录IP
	 */
	@FieldDescription("本次登录IP")
	private String ip;
	/**
	 * 上次登录IP
	 */
	@FieldDescription("上次登录IP")
	private String lastIp;
	/**
	 * 最近登录时间
	 */
	@FieldDescription("最近登录时间")
	private Date lastLoginTime;
	/**
	 * 是否管理员
	 */
	@FieldDescription("是否管理员")
	private BooleanEnum admin = BooleanEnum.NO;
	
	private Date previousLoginTime;

	/**
	 * 用户类型
	 */
	@FieldDescription("用户类型")
	private UserTypeEnum userType = UserTypeEnum.Center;
	
	private Set<UserRoleRef> roleRefs;
	
	private Set<Long> roleRefIds;

	private List<UserRoleRef> roleRefList;

	private CustomerDto customerDto;
	/** 
	 * 
	 */ 
	private IncubatorDto incubator;
	
	private boolean valid = true;

	public IncubatorDto getIncubator() {
		return incubator;
	}
	public void setIncubator(IncubatorDto incubator) {
		this.incubator = incubator;
	}
	
	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}

	public String getOrgName(){
		try {
			return getOrg().getName();
		} catch (Throwable t) {
			return "";
		}
	}
	/**
	 * 所属组织
	 */
    @JSON(serialize=false)
	public Org getOrg(){
		return org;
	}
	public void setOrg(Org org){
		this.org = org;
	}
	/**
	 * 用户名
	 */
	public String getUsername(){
		return username;
	}
	public void setUsername(String username){
		this.username = username;
	}
	/**
	 * MD5加密密码
	 */
	public String getPassword(){
		return password;
	}
	public void setPassword(String password){
		this.password = password;
	}
	/**
	 * 真实姓名
	 */
	public String getRealName(){
		return realName;
	}
	public void setRealName(String realName){
		this.realName = realName;
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
	 * 出生日期
	 */
	public Date getBirthday(){
		return birthday;
	}
	public void setBirthday(Date birthday){
		this.birthday = birthday;
	}
	/**
	 * 头像URL
	 */
	public String getImagery(){
		return imagery;
	}
	public void setImagery(String imagery){
		this.imagery = imagery;
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
	 * 电话号码
	 */
	public String getTelephone(){
		return telephone;
	}
	public void setTelephone(String telephone){
		this.telephone = telephone;
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
	 * MSN
	 */
	public String getMsn(){
		return msn;
	}
	public void setMsn(String msn){
		this.msn = msn;
	}
	/**
	 * 本次登录IP
	 */
	public String getIp(){
		return ip;
	}
	public void setIp(String ip){
		this.ip = ip;
	}
	/**
	 * 上次登录IP
	 */
	public String getLastIp(){
		return lastIp;
	}
	public void setLastIp(String lastIp){
		this.lastIp = lastIp;
	}
	/**
	 * 最近登录时间
	 */
	public Date getLastLoginTime(){
		return lastLoginTime;
	}
	public void setLastLoginTime(Date lastLoginTime){
		this.lastLoginTime = lastLoginTime;
	}
	/**
	 * 是否管理员
	 */
	public BooleanEnum getAdmin(){
		return admin;
	}
	public void setAdmin(BooleanEnum admin){
		this.admin = admin;
	}
	/**
	 * 用户类型
	 */
	public UserTypeEnum getUserType(){
		return userType;
	}
	public void setUserType(UserTypeEnum userType){
		this.userType = userType;
	}
	public CustomerDto getCustomerDto() {
		return customerDto;
	}
	public void setCustomerDto(CustomerDto customerDto) {
		this.customerDto = customerDto;
	}
	public Set<UserRoleRef> getRoleRefs() {
		return roleRefs;
	}
	public void setRoleRefs(Set<UserRoleRef> roleRefs) {
		this.roleRefs = roleRefs;
	}
	
	public Set<Long> getRoleRefIds() {
		return roleRefIds;
	}
	public void setRoleRefIds(Set<Long> roleRefIds) {
		this.roleRefIds = roleRefIds;
	}
	public List<UserRoleRef> getRoleRefList() {
		return roleRefList;
	}
	public boolean getCenter() {
		return isCenter();
	}
	public boolean isCenter() {
		return userType != null && userType.equals(UserTypeEnum.Center);
	}
	
	public boolean isEnterprise() {
		return userType != null && userType.equals(UserTypeEnum.Customer);
	}

	public void setRoleRefList(List<UserRoleRef> roleRefList) {
		this.roleRefList = roleRefList;
	}
	public void addRoleRef(UserRoleRef roleRef) {
		if(roleRefs==null)roleRefs=new HashSet<UserRoleRef>();
		roleRefs.add(roleRef);
		
	}
	public void setPreviousLoginTime(Date previousLoginTime) {
		this.previousLoginTime = previousLoginTime;
	}
	public Date getPreviousLoginTime() {
		return previousLoginTime;
	}
	public UserEmailParam getUserEmailParam() {
		return userEmailParam;
	}
	public void setUserEmailParam(UserEmailParam userEmailParam) {
		this.userEmailParam = userEmailParam;
	}
	public void invalidate() {
		this.valid = false;
	}
	public boolean isValid() {
		return valid;
	}
	
}