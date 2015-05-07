package com.wiiy.crm.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.Customer;

/**
 * <br/>class-description 企业详细信息
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class CustomerInfo extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 注册类型实体
	 */
	@FieldDescription("注册类型实体")
	private DataDict regType;
	/**
	 * 币种实体
	 */
	@FieldDescription("币种实体")
	private DataDict currencyType;
	/**
	 * 纳税地
	 */
	@FieldDescription("纳税地")
	private DataDict taxAddress;
	/**
	 * 证件类型实体
	 */
	@FieldDescription("证件类型实体")
	private DataDict documentType;
	/**
	 * 企业实体
	 */
	@FieldDescription("企业实体")
	private Customer customer;
	/**
	 * 联系地址
	 */
	@FieldDescription("联系地址")
	private String address;
	/**
	 * 经营地址
	 */
	@FieldDescription("经营地址")
	private String managerAddress;
	/**
	 * 邮编
	 */
	@FieldDescription("邮编")
	private String zipCode;
	/**
	 * 网址
	 */
	@FieldDescription("网址")
	private String webSite;
	/**
	 * 办公电话
	 */
	@FieldDescription("办公电话")
	private String officePhone;
	/**
	 * 传真
	 */
	@FieldDescription("传真")
	private String fax;
	/**
	 * Email地址
	 */
	@FieldDescription("Email地址")
	private String email;
	/**
	 * 注册时间
	 */
	@FieldDescription("注册时间")
	private Date regTime;
	private Integer userCount;
	private Integer userbs;
	private Integer userbsh;
	private Integer userss;
	private Integer userbk;
	private Integer userqt;
	private Integer usergj;
	private Integer userzj;
	private Integer usercj;
	private Integer userlxs;
	/**
	 * 注册类型外键
	 */
	@FieldDescription("注册类型外键")
	private String regTypeId;
	/**
	 * 注册资本
	 */
	@FieldDescription("注册资本")
	private BigDecimal regCapital;
	/**
	 * 实际资本
	 */
	@FieldDescription("实际资本")
	private BigDecimal realCapital;
	/**
	 * 是否在园区内
	 */
	@FieldDescription("是否在园区内")
	private BooleanEnum inPark;
	/**
	 * 是否在大厦内
	 */
	@FieldDescription("是否在大厦内")
	private BooleanEnum inBuild;
	/**
	 * 是否研发机构
	 */
	@FieldDescription("是否研发机构")
	private BooleanEnum research;
	/**
	 * 是否有自营进出口权
	 */
	@FieldDescription("是否有自营进出口权")
	private BooleanEnum zyjck;
	/**
	 * 是否一般纳税人
	 */
	@FieldDescription("是否一般纳税人")
	private BooleanEnum ybnsr;
	/**
	 * 币种外键
	 */
	@FieldDescription("币种外键")
	private String currencyTypeId;
	/**
	 * 组织机构代码
	 */
	@FieldDescription("组织机构代码")
	private String organizationNumber;
	/**
	 * 工商注册号
	 */
	@FieldDescription("工商注册号")
	private String businessNumber;
	/**
	 * 税务登记证(国税)
	 */
	@FieldDescription("税务登记证(国税)")
	private String taxNumberG;
	/**
	 * 税务登记证(地税)
	 */
	@FieldDescription("税务登记证(地税)")
	private String taxNumberD;
	/**
	 * 纳税地
	 */
	@FieldDescription("纳税地")
	private String taxAddressId;
	/**
	 * 法定代表人
	 */
	@FieldDescription("法定代表人")
	private String legalPerson;
	/**
	 * 股东
	 */
	@FieldDescription("股东")
	private String shareholder;
	/**
	 * 证件类型外键
	 */
	@FieldDescription("证件类型外键")
	private String documentTypeId;
	/**
	 * 证件号
	 */
	@FieldDescription("证件号")
	private String documentNumber;
	/**
	 * 注册EMAIL
	 */
	@FieldDescription("注册EMAIL")
	private String regMail;
	/**
	 * 移动电话
	 */
	@FieldDescription("移动电话")
	private String cellphone;
	/**
	 * 注册地址
	 */
	@FieldDescription("注册地址")
	private String regAddress;
	/**
	 * 经营范围
	 */
	@FieldDescription("经营范围")
	private String businessScope;
	/**
	 * 营业截至日期
	 */
	@FieldDescription("营业截至日期")
	private Date businessExpireDate;
	/**
	 * 公司描述
	 */
	@FieldDescription("公司描述")
	private String description;
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
	 * 注册类型实体
	 */
	public DataDict getRegType(){
		return regType;
	}
	public void setRegType(DataDict regType){
		this.regType = regType;
	}
	/**
	 * 币种实体
	 */
	public DataDict getCurrencyType(){
		return currencyType;
	}
	public void setCurrencyType(DataDict currencyType){
		this.currencyType = currencyType;
	}
	/**
	 * 纳税地
	 */
	public DataDict getTaxAddress(){
		return taxAddress;
	}
	public void setTaxAddress(DataDict taxAddress){
		this.taxAddress = taxAddress;
	}
	/**
	 * 证件类型实体
	 */
	public DataDict getDocumentType(){
		return documentType;
	}
	public void setDocumentType(DataDict documentType){
		this.documentType = documentType;
	}
	/**
	 * 企业实体
	 */
	public Customer getCustomer(){
		return customer;
	}
	public void setCustomer(Customer customer){
		this.customer = customer;
	}
	/**
	 * 联系地址
	 */
	public String getAddress(){
		return address;
	}
	public void setAddress(String address){
		this.address = address;
	}
	/**
	 * 经营地址
	 */
	public String getManagerAddress(){
		return managerAddress;
	}
	public void setManagerAddress(String managerAddress){
		this.managerAddress = managerAddress;
	}
	/**
	 * 邮编
	 */
	public String getZipCode(){
		return zipCode;
	}
	public void setZipCode(String zipCode){
		this.zipCode = zipCode;
	}
	/**
	 * 网址
	 */
	public String getWebSite(){
		return webSite;
	}
	public void setWebSite(String webSite){
		this.webSite = webSite;
	}
	/**
	 * 办公电话
	 */
	public String getOfficePhone(){
		return officePhone;
	}
	public void setOfficePhone(String officePhone){
		this.officePhone = officePhone;
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
	 * Email地址
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	/**
	 * 注册时间
	 */
	public Date getRegTime(){
		return regTime;
	}
	public void setRegTime(Date regTime){
		this.regTime = regTime;
	}
	public Integer getUserCount(){
		return userCount;
	}
	public void setUserCount(Integer userCount){
		this.userCount = userCount;
	}
	public Integer getUserbs(){
		return userbs;
	}
	public void setUserbs(Integer userbs){
		this.userbs = userbs;
	}
	public Integer getUserbsh(){
		return userbsh;
	}
	public void setUserbsh(Integer userbsh){
		this.userbsh = userbsh;
	}
	public Integer getUserss(){
		return userss;
	}
	public void setUserss(Integer userss){
		this.userss = userss;
	}
	public Integer getUserbk(){
		return userbk;
	}
	public void setUserbk(Integer userbk){
		this.userbk = userbk;
	}
	public Integer getUserqt(){
		return userqt;
	}
	public void setUserqt(Integer userqt){
		this.userqt = userqt;
	}
	public Integer getUsergj(){
		return usergj;
	}
	public void setUsergj(Integer usergj){
		this.usergj = usergj;
	}
	public Integer getUserzj(){
		return userzj;
	}
	public void setUserzj(Integer userzj){
		this.userzj = userzj;
	}
	public Integer getUsercj(){
		return usercj;
	}
	public void setUsercj(Integer usercj){
		this.usercj = usercj;
	}
	public Integer getUserlxs(){
		return userlxs;
	}
	public void setUserlxs(Integer userlxs){
		this.userlxs = userlxs;
	}
	/**
	 * 注册类型外键
	 */
	public String getRegTypeId(){
		return regTypeId;
	}
	public void setRegTypeId(String regTypeId){
		this.regTypeId = regTypeId;
	}
	/**
	 * 注册资本
	 */
	public BigDecimal getRegCapital(){
		return regCapital;
	}
	public void setRegCapital(BigDecimal regCapital){
		this.regCapital = regCapital;
	}
	/**
	 * 实际资本
	 */
	public BigDecimal getRealCapital(){
		return realCapital;
	}
	public void setRealCapital(BigDecimal realCapital){
		this.realCapital = realCapital;
	}
	/**
	 * 是否在园区内
	 */
	public BooleanEnum getInPark(){
		return inPark;
	}
	public void setInPark(BooleanEnum inPark){
		this.inPark = inPark;
	}
	/**
	 * 是否在大厦内
	 */
	public BooleanEnum getInBuild(){
		return inBuild;
	}
	public void setInBuild(BooleanEnum inBuild){
		this.inBuild = inBuild;
	}
	/**
	 * 是否研发机构
	 */
	public BooleanEnum getResearch(){
		return research;
	}
	public void setResearch(BooleanEnum research){
		this.research = research;
	}
	/**
	 * 是否有自营进出口权
	 */
	public BooleanEnum getZyjck(){
		return zyjck;
	}
	public void setZyjck(BooleanEnum zyjck){
		this.zyjck = zyjck;
	}
	/**
	 * 是否一般纳税人
	 */
	public BooleanEnum getYbnsr(){
		return ybnsr;
	}
	public void setYbnsr(BooleanEnum ybnsr){
		this.ybnsr = ybnsr;
	}
	/**
	 * 币种外键
	 */
	public String getCurrencyTypeId(){
		return currencyTypeId;
	}
	public void setCurrencyTypeId(String currencyTypeId){
		this.currencyTypeId = currencyTypeId;
	}
	/**
	 * 组织机构代码
	 */
	public String getOrganizationNumber(){
		return organizationNumber;
	}
	public void setOrganizationNumber(String organizationNumber){
		this.organizationNumber = organizationNumber;
	}
	/**
	 * 工商注册号
	 */
	public String getBusinessNumber(){
		return businessNumber;
	}
	public void setBusinessNumber(String businessNumber){
		this.businessNumber = businessNumber;
	}
	/**
	 * 税务登记证(国税)
	 */
	public String getTaxNumberG(){
		return taxNumberG;
	}
	public void setTaxNumberG(String taxNumberG){
		this.taxNumberG = taxNumberG;
	}
	/**
	 * 税务登记证(地税)
	 */
	public String getTaxNumberD(){
		return taxNumberD;
	}
	public void setTaxNumberD(String taxNumberD){
		this.taxNumberD = taxNumberD;
	}
	/**
	 * 纳税地
	 */
	public String getTaxAddressId(){
		return taxAddressId;
	}
	public void setTaxAddressId(String taxAddressId){
		this.taxAddressId = taxAddressId;
	}
	/**
	 * 法定代表人
	 */
	public String getLegalPerson(){
		return legalPerson;
	}
	public void setLegalPerson(String legalPerson){
		this.legalPerson = legalPerson;
	}
	/**
	 * 股东
	 */
	public String getShareholder(){
		return shareholder;
	}
	public void setShareholder(String shareholder){
		this.shareholder = shareholder;
	}
	/**
	 * 证件类型外键
	 */
	public String getDocumentTypeId(){
		return documentTypeId;
	}
	public void setDocumentTypeId(String documentTypeId){
		this.documentTypeId = documentTypeId;
	}
	/**
	 * 证件号
	 */
	public String getDocumentNumber(){
		return documentNumber;
	}
	public void setDocumentNumber(String documentNumber){
		this.documentNumber = documentNumber;
	}
	/**
	 * 注册EMAIL
	 */
	public String getRegMail(){
		return regMail;
	}
	public void setRegMail(String regMail){
		this.regMail = regMail;
	}
	/**
	 * 移动电话
	 */
	public String getCellphone(){
		return cellphone;
	}
	public void setCellphone(String cellphone){
		this.cellphone = cellphone;
	}
	/**
	 * 注册地址
	 */
	public String getRegAddress(){
		return regAddress;
	}
	public void setRegAddress(String regAddress){
		this.regAddress = regAddress;
	}
	/**
	 * 经营范围
	 */
	public String getBusinessScope(){
		return businessScope;
	}
	public void setBusinessScope(String businessScope){
		this.businessScope = businessScope;
	}
	/**
	 * 营业截至日期
	 */
	public Date getBusinessExpireDate(){
		return businessExpireDate;
	}
	public void setBusinessExpireDate(Date businessExpireDate){
		this.businessExpireDate = businessExpireDate;
	}
	/**
	 * 公司描述
	 */
	public String getDescription(){
		return description;
	}
	public void setDescription(String description){
		this.description = description;
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