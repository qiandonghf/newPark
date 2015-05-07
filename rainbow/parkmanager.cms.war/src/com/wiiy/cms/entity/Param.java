package com.wiiy.cms.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DataDict;

/**
 * <br/>class-description 基本参数
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Param extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 资源位置
	 */
	@FieldDescription("资源位置")
	private DataDict templete;
	/**
	 * 网站管理员ids
	 */
	@FieldDescription("网站管理员ids")
	private String managerIds;
	/**
	 * 网站管理员名称
	 */
	@FieldDescription("网站管理员名称")
	private String managerNames;
	/**
	 * 网站名称
	 */
	@FieldDescription("网站名称")
	private String name;
	/**
	 * 文档HTML默认保存位置
	 */
	@FieldDescription("文档HTML默认保存位置")
	private String htmlPath;
	/**
	 * 有效期起始日期
	 */
	@FieldDescription("有效期起始日期")
	private Date validPeriodStart;
	/**
	 * 有效期结束日期
	 */
	@FieldDescription("有效期结束日期")
	private Date validPeriodEnd;
	/**
	 * 网站域名
	 */
	@FieldDescription("网站域名")
	private String domainName;
	/**
	 * 图片或上传文件默认路径
	 */
	@FieldDescription("图片或上传文件默认路径")
	private String uploadPath;
	/**
	 * 关键字
	 */
	@FieldDescription("关键字")
	private String keyWord;
	/**
	 * 描述
	 */
	@FieldDescription("描述")
	private String description;
	/**
	 * 资源位置外键
	 */
	@FieldDescription("资源位置外键")
	private String templeteId;
	/**
	 * 版权信息
	 */
	@FieldDescription("版权信息")
	private String copyright;
	/**
	 * 备案号
	 */
	@FieldDescription("备案号")
	private String icp;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 资源位置
	 */
	public DataDict getTemplete(){
		return templete;
	}
	public void setTemplete(DataDict templete){
		this.templete = templete;
	}
	/**
	 * 网站管理员ids
	 */
	public String getManagerIds(){
		return managerIds;
	}
	public void setManagerIds(String managerIds){
		this.managerIds = managerIds;
	}
	/**
	 * 网站管理员名称
	 */
	public String getManagerNames(){
		return managerNames;
	}
	public void setManagerNames(String managerNames){
		this.managerNames = managerNames;
	}
	/**
	 * 网站名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 文档HTML默认保存位置
	 */
	public String getHtmlPath(){
		return htmlPath;
	}
	public void setHtmlPath(String htmlPath){
		this.htmlPath = htmlPath;
	}
	/**
	 * 有效期起始日期
	 */
	public Date getValidPeriodStart(){
		return validPeriodStart;
	}
	public void setValidPeriodStart(Date validPeriodStart){
		this.validPeriodStart = validPeriodStart;
	}
	/**
	 * 有效期结束日期
	 */
	public Date getValidPeriodEnd(){
		return validPeriodEnd;
	}
	public void setValidPeriodEnd(Date validPeriodEnd){
		this.validPeriodEnd = validPeriodEnd;
	}
	/**
	 * 网站域名
	 */
	public String getDomainName(){
		return domainName;
	}
	public void setDomainName(String domainName){
		this.domainName = domainName;
	}
	/**
	 * 图片或上传文件默认路径
	 */
	public String getUploadPath(){
		return uploadPath;
	}
	public void setUploadPath(String uploadPath){
		this.uploadPath = uploadPath;
	}
	/**
	 * 关键字
	 */
	public String getKeyWord(){
		return keyWord;
	}
	public void setKeyWord(String keyWord){
		this.keyWord = keyWord;
	}
	/**
	 * 描述
	 */
	public String getDescription(){
		return description;
	}
	public void setDescription(String description){
		this.description = description;
	}
	/**
	 * 资源位置外键
	 */
	public String getTempleteId(){
		return templeteId;
	}
	public void setTempleteId(String templeteId){
		this.templeteId = templeteId;
	}
	/**
	 * 版权信息
	 */
	public String getCopyright(){
		if(copyright!=null){
			copyright=copyright.replaceAll("&amp;", "&");
			copyright=copyright.replaceAll("&lt;", "<");
			copyright=copyright.replaceAll("&gt;", ">");
			copyright=copyright.replaceAll("&nbsp;", " ");
			copyright=copyright.replaceAll("&quot;", "\"");
		}
		
		System.out.println("Param.getCopyright()="+copyright);
		return copyright;
	}
	public void setCopyright(String copyright){
		this.copyright = copyright;
	}
	/**
	 * 备案号
	 */
	public String getIcp(){
		return icp;
	}
	public void setIcp(String icp){
		this.icp = icp;
	}
}