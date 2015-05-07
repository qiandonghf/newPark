package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.oa.entity.Document;
import com.wiiy.oa.preferences.enums.DocTypeEnum;

/**
 * <br/>class-description 文档
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class Document extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 文件夹实体
	 */
	@FieldDescription("文件夹实体")
	private Document parent;
	/**
	 * 是否目录
	 */
	@FieldDescription("是否目录")
	private BooleanEnum isFolder;
	/**
	 * 是否发布
	 */
	@FieldDescription("是否发布")
	private BooleanEnum pubed;
	/**
	 * 发布时间
	 */
	@FieldDescription("发布时间")
	private Date pubTime;
	/**
	 * 文档类型
	 */
	@FieldDescription("文档类型")
	private DocTypeEnum docType;
	/**
	 * 文档名称
	 */
	@FieldDescription("文档名称")
	private String name;
	/**
	 * 附件文件名
	 */
	@FieldDescription("附件文件名")
	private String fileName;
	/**
	 * 扩展名
	 */
	@FieldDescription("扩展名")
	private String fileExt;
	/**
	 * 附件大小
	 */
	@FieldDescription("附件大小")
	private Long size;
	/**
	 * 内容说明
	 */
	@FieldDescription("内容说明")
	private String memo;
	/**
	 * 标签拥有者ID
	 */
	@FieldDescription("标签拥有者ID")
	private Long ownerId;
	/**
	 * 共享IDs
	 */
	@FieldDescription("共享IDs")
	private String shareToIds;
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
	 * 文件夹实体
	 */
	public Document getParent(){
		return parent;
	}
	public void setParent(Document parent){
		this.parent = parent;
	}
	/**
	 * 是否目录
	 */
	public BooleanEnum getIsFolder(){
		return isFolder;
	}
	public void setIsFolder(BooleanEnum isFolder){
		this.isFolder = isFolder;
	}
	/**
	 * 文档类型
	 */
	public DocTypeEnum getDocType(){
		return docType;
	}
	public void setDocType(DocTypeEnum docType){
		this.docType = docType;
	}
	/**
	 * 文档名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 附件文件名
	 */
	public String getFileName(){
		return fileName;
	}
	public void setFileName(String fileName){
		this.fileName = fileName;
	}
	/**
	 * 扩展名
	 */
	public String getFileExt(){
		return fileExt;
	}
	public void setFileExt(String fileExt){
		this.fileExt = fileExt;
	}
	/**
	 * 附件大小
	 */
	public Long getSize(){
		return size;
	}
	public void setSize(Long size){
		this.size = size;
	}
	/**
	 * 内容说明
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
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
	 * 共享IDs
	 */
	public String getShareToIds(){
		return shareToIds;
	}
	public void setShareToIds(String shareToIds){
		this.shareToIds = shareToIds;
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
	/**
	 * 是否发布
	 */
	public BooleanEnum getPubed() {
		return pubed;
	}
	public void setPubed(BooleanEnum pubed) {
		this.pubed = pubed;
	}
	/**
	 * 发布时间
	 */
	public Date getPubTime() {
		return pubTime;
	}
	public void setPubTime(Date pubTime) {
		this.pubTime = pubTime;
	}
}