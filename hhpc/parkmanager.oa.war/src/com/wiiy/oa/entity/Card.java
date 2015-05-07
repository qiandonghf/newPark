package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.preferences.enums.GenderEnum;
import com.wiiy.commons.preferences.enums.TitleEnum;
import com.wiiy.oa.entity.CardCategory;
import com.wiiy.oa.preferences.enums.CardOwnerEnum;
import com.wiiy.oa.preferences.enums.CardTypeEnum;

/**
 * <br/>class-description 名片
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class Card extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 分类
	 */
	@FieldDescription("分类")
	private CardCategory category;
	/**
	 * 姓名
	 */
	@FieldDescription("姓名")
	private String name;
	/**
	 * 昵称
	 */
	@FieldDescription("昵称")
	private String nickName;
	/**
	 * 称谓
	 */
	@FieldDescription("称谓")
	private TitleEnum appellation;
	/**
	 * 公司名称
	 */
	@FieldDescription("公司名称")
	private String company;
	/**
	 * 公司地址
	 */
	@FieldDescription("公司地址")
	private String companyAddr;
	/**
	 * 家庭地址
	 */
	@FieldDescription("家庭地址")
	private String homeAddr;
	/**
	 * 生日
	 */
	@FieldDescription("生日")
	private Date birthday;
	/**
	 * 性别
	 */
	@FieldDescription("性别")
	private GenderEnum gender;
	/**
	 * 家庭电话
	 */
	@FieldDescription("家庭电话")
	private String homeTel;
	/**
	 * 公司电话
	 */
	@FieldDescription("公司电话")
	private String officeTel;
	/**
	 * 移动电话
	 */
	@FieldDescription("移动电话")
	private String mobile;
	/**
	 * 传真
	 */
	@FieldDescription("传真")
	private String fax;
	/**
	 * 职位
	 */
	@FieldDescription("职位")
	private String position;
	/**
	 * QQ
	 */
	@FieldDescription("QQ")
	private String qq;
	/**
	 * MSN
	 */
	@FieldDescription("MSN")
	private String msn;
	/**
	 * 网址
	 */
	@FieldDescription("网址")
	private String homepage;
	/**
	 * Email
	 */
	@FieldDescription("Email")
	private String email;
	/**
	 * 邮编
	 */
	@FieldDescription("邮编")
	private String zipcode;
	/**
	 * 配偶
	 */
	@FieldDescription("配偶")
	private String spouse;
	/**
	 * 子女
	 */
	@FieldDescription("子女")
	private String child;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;
	/**
	 * 分类外键
	 */
	@FieldDescription("分类外键")
	private Long categoryId;
	/**
	 * 名片性质
	 */
	@FieldDescription("名片性质")
	private CardTypeEnum typeEnum;
	/**
	 * 标签拥有者ID
	 */
	@FieldDescription("标签拥有者ID")
	private Long ownerId;
	/**
	 * 拥有类型
	 */
	@FieldDescription("拥有类型")
	private CardOwnerEnum ownerEnum;
	/**
	 * 实体状态
	 */
	@FieldDescription("实体状态")
	private EntityStatus entityStatus;
	/**
	 * 创建时间
	 */
	@FieldDescription("创建时间")
	private Date createTime;
	/**
	 * 创建人姓名
	 */
	@FieldDescription("创建人姓名")
	private String creator;
	/**
	 * 创建人ID
	 */
	@FieldDescription("创建人ID")
	private Long creatorId;
	/**
	 * 修改时间
	 */
	@FieldDescription("修改时间")
	private Date modifyTime;
	/**
	 * 修改人姓名
	 */
	@FieldDescription("修改人姓名")
	private String modifier;
	/**
	 * 修改人ID
	 */
	@FieldDescription("修改人ID")
	private Long modifierId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 分类
	 */
	public CardCategory getCategory(){
		return category;
	}
	public void setCategory(CardCategory category){
		this.category = category;
	}
	/**
	 * 姓名
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 昵称
	 */
	public String getNickName(){
		return nickName;
	}
	public void setNickName(String nickName){
		this.nickName = nickName;
	}
	/**
	 * 称谓
	 */
	public TitleEnum getAppellation(){
		return appellation;
	}
	public void setAppellation(TitleEnum appellation){
		this.appellation = appellation;
	}
	/**
	 * 公司名称
	 */
	public String getCompany(){
		return company;
	}
	public void setCompany(String company){
		this.company = company;
	}
	/**
	 * 公司地址
	 */
	public String getCompanyAddr(){
		return companyAddr;
	}
	public void setCompanyAddr(String companyAddr){
		this.companyAddr = companyAddr;
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
	 * 生日
	 */
	public Date getBirthday(){
		return birthday;
	}
	public void setBirthday(Date birthday){
		this.birthday = birthday;
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
	 * 家庭电话
	 */
	public String getHomeTel(){
		return homeTel;
	}
	public void setHomeTel(String homeTel){
		this.homeTel = homeTel;
	}
	/**
	 * 公司电话
	 */
	public String getOfficeTel(){
		return officeTel;
	}
	public void setOfficeTel(String officeTel){
		this.officeTel = officeTel;
	}
	/**
	 * 移动电话
	 */
	public String getMobile(){
		return mobile;
	}
	public void setMobile(String mobile){
		this.mobile = mobile;
	}
	/**
	 * 传真
	 */
	public String getFax(){
		return fax;
	}
	public void setFax(String fax){
		this.fax = fax;
	}
	/**
	 * 职位
	 */
	public String getPosition(){
		return position;
	}
	public void setPosition(String position){
		this.position = position;
	}
	/**
	 * QQ
	 */
	public String getQq(){
		return qq;
	}
	public void setQq(String qq){
		this.qq = qq;
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
	 * 网址
	 */
	public String getHomepage(){
		return homepage;
	}
	public void setHomepage(String homepage){
		this.homepage = homepage;
	}
	/**
	 * Email
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	/**
	 * 邮编
	 */
	public String getZipcode(){
		return zipcode;
	}
	public void setZipcode(String zipcode){
		this.zipcode = zipcode;
	}
	/**
	 * 配偶
	 */
	public String getSpouse(){
		return spouse;
	}
	public void setSpouse(String spouse){
		this.spouse = spouse;
	}
	/**
	 * 子女
	 */
	public String getChild(){
		return child;
	}
	public void setChild(String child){
		this.child = child;
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
	/**
	 * 分类外键
	 */
	public Long getCategoryId(){
		return categoryId;
	}
	public void setCategoryId(Long categoryId){
		this.categoryId = categoryId;
	}
	/**
	 * 名片性质
	 */
	public CardTypeEnum getTypeEnum(){
		return typeEnum;
	}
	public void setTypeEnum(CardTypeEnum typeEnum){
		this.typeEnum = typeEnum;
	}
	/**
	 * 标签拥有者ID
	 */
	public Long getOwnerId(){
		return ownerId;
	}
	public void setOwnerId(Long ownerId){
		this.ownerId = ownerId;
	}
	/**
	 * 拥有类型
	 */
	public CardOwnerEnum getOwnerEnum(){
		return ownerEnum;
	}
	public void setOwnerEnum(CardOwnerEnum ownerEnum){
		this.ownerEnum = ownerEnum;
	}
	/**
	 * 实体状态
	 */
	public EntityStatus getEntityStatus(){
		return entityStatus;
	}
	public void setEntityStatus(EntityStatus entityStatus){
		this.entityStatus = entityStatus;
	}
	/**
	 * 创建时间
	 */
	public Date getCreateTime(){
		return createTime;
	}
	public void setCreateTime(Date createTime){
		this.createTime = createTime;
	}
	/**
	 * 创建人姓名
	 */
	public String getCreator(){
		return creator;
	}
	public void setCreator(String creator){
		this.creator = creator;
	}
	/**
	 * 创建人ID
	 */
	public Long getCreatorId(){
		return creatorId;
	}
	public void setCreatorId(Long creatorId){
		this.creatorId = creatorId;
	}
	/**
	 * 修改时间
	 */
	public Date getModifyTime(){
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime){
		this.modifyTime = modifyTime;
	}
	/**
	 * 修改人姓名
	 */
	public String getModifier(){
		return modifier;
	}
	public void setModifier(String modifier){
		this.modifier = modifier;
	}
	/**
	 * 修改人ID
	 */
	public Long getModifierId(){
		return modifierId;
	}
	public void setModifierId(Long modifierId){
		this.modifierId = modifierId;
	}
}