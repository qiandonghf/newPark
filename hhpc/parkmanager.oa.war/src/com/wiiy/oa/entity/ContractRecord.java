package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.oa.entity.ContractRecordAtt;
import com.wiiy.oa.preferences.enums.ContractCharacterEnum;

/**
 * <br/>class-description 合同备案
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ContractRecord extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 甲方
	 */
	@FieldDescription("甲方")
	private String partya;
	/**
	 * 乙方
	 */
	@FieldDescription("乙方")
	private String partyb;
	/**
	 * 合同名称
	 */
	@FieldDescription("合同名称")
	private String contractName;
	/**
	 * 合同期限
	 */
	@FieldDescription("合同期限")
	private String duration;
	/**
	 * 合同性质
	 */
	@FieldDescription("合同性质")
	private ContractCharacterEnum contractCharacter;
	/**
	 * 签约时间
	 */
	@FieldDescription("签约时间")
	private Date signingDate;
	/**
	 * 金额
	 */
	@FieldDescription("金额")
	private Long money;
	private Set<ContractRecordAtt> atts;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 甲方
	 */
	public String getPartya(){
		return partya;
	}
	public void setPartya(String partya){
		this.partya = partya;
	}
	/**
	 * 乙方
	 */
	public String getPartyb(){
		return partyb;
	}
	public void setPartyb(String partyb){
		this.partyb = partyb;
	}
	/**
	 * 合同名称
	 */
	public String getContractName(){
		return contractName;
	}
	public void setContractName(String contractName){
		this.contractName = contractName;
	}
	/**
	 * 合同期限
	 */
	public String getDuration(){
		return duration;
	}
	public void setDuration(String duration){
		this.duration = duration;
	}
	/**
	 * 合同性质
	 */
	public ContractCharacterEnum getContractCharacter(){
		return contractCharacter;
	}
	public void setContractCharacter(ContractCharacterEnum contractCharacter){
		this.contractCharacter = contractCharacter;
	}
	/**
	 * 签约时间
	 */
	public Date getSigningDate(){
		return signingDate;
	}
	public void setSigningDate(Date signingDate){
		this.signingDate = signingDate;
	}
	/**
	 * 金额
	 */
	public Long getMoney(){
		return money;
	}
	public void setMoney(Long money){
		this.money = money;
	}
	public Set<ContractRecordAtt> getAtts(){
		return atts;
	}
	public void setAtts(Set<ContractRecordAtt> atts){
		this.atts = atts;
	}
}