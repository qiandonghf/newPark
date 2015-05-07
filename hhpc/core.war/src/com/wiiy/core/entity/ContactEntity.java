package com.wiiy.core.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.preferences.enums.ContactResolveStatusEnum;
import com.wiiy.core.preferences.enums.ContactStatusEnum;
import com.wiiy.core.preferences.enums.ContactTypeEnum;

@SuppressWarnings("serial")
public  class ContactEntity  extends BaseEntity implements Serializable {
	/**
	 * 联系单解决状态
	 */
	@FieldDescription("联系单解决状态")
	protected ContactResolveStatusEnum resolveStatus;
	/**
	 * 联系单受理状态
	 */
	@FieldDescription("联系单受理状态")
	protected ContactStatusEnum status;
	/**
	 * 联系单类型
	 */
	@FieldDescription("联系单类型")
	protected ContactTypeEnum type;
	/**
	 * 受理人id
	 */
	@FieldDescription("受理人id")
	protected Long receiveId;
	/**
	 * 受理人
	 */
	@FieldDescription("受理人")
	protected String receiveName;
	/**
	 * 当前审批
	 */
	@FieldDescription("当前审批")
	protected String opinionNow;
	/**
	 * 处理过的人的id
	 */
	@FieldDescription("处理过的人的id")
	protected String usedIds;
	/**
	 * 联系人ID
	 */
	@FieldDescription("联系人ID")
	protected Long linkmanId;
	/**
	 * 联系人
	 */
	@FieldDescription("联系人")
	protected String linkman;
	/**
	 * 联系电话
	 */
	@FieldDescription("联系电话")
	protected String telephone;
	/**
	 * 受理开始时间
	 */
	@FieldDescription("受理开始时间")
	protected Date startDate;
	/**
	 * 受理结束时间
	 */
	@FieldDescription("受理结束时间")
	protected Date endDate;
	/**
	 * 情况说明
	 */
	@FieldDescription("情况说明")
	protected String description;

	public ContactResolveStatusEnum getResolveStatus() {
		return resolveStatus;
	}

	public void setResolveStatus(ContactResolveStatusEnum resolveStatus) {
		this.resolveStatus = resolveStatus;
	}

	public ContactStatusEnum getStatus() {
		return status;
	}

	public void setStatus(ContactStatusEnum status) {
		this.status = status;
	}

	public ContactTypeEnum getType() {
		return type;
	}

	public void setType(ContactTypeEnum type) {
		this.type = type;
	}

	public Long getReceiveId() {
		return receiveId;
	}

	public void setReceiveId(Long receiveId) {
		this.receiveId = receiveId;
	}

	public String getReceiveName() {
		return receiveName;
	}

	public void setReceiveName(String receiveName) {
		this.receiveName = receiveName;
	}

	public String getUsedIds() {
		return usedIds;
	}

	public void setUsedIds(String usedIds) {
		this.usedIds = usedIds;
	}

	public Long getLinkmanId() {
		return linkmanId;
	}

	public void setLinkmanId(Long linkmanId) {
		this.linkmanId = linkmanId;
	}

	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getOpinionNow() {
		return opinionNow;
	}

	public void setOpinionNow(String opinionNow) {
		this.opinionNow = opinionNow;
	}
	
	
}
