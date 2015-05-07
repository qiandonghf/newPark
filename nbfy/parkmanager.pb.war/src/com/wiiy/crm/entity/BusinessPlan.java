package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Set;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.crm.entity.BusinessPlanAtt;
import com.wiiy.crm.entity.Investment;

/**
 * <br/>class-description 商业计划书
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class BusinessPlan extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 招商项目实体
	 */
	@FieldDescription("招商项目实体")
	private Investment investment;
	/**
	 * 拟办企业概况
	 */
	@FieldDescription("拟办企业概况")
	private String CompanySummery;
	/**
	 * 创业团队概况
	 */
	@FieldDescription("创业团队概况")
	private String TeamSummery;
	/**
	 * 项目技术可行性分析
	 */
	@FieldDescription("项目技术可行性分析")
	private String ProjectFeasibility;
	/**
	 * 产品市场可行性分析
	 */
	@FieldDescription("产品市场可行性分析")
	private String MarketFeasibility;
	/**
	 * 经济效益及社会效益分析
	 */
	@FieldDescription("经济效益及社会效益分析")
	private String EconomicBenefits;
	/**
	 * 对创业中心的要求
	 */
	@FieldDescription("对创业中心的要求")
	private String requirements;
	private Set<BusinessPlanAtt> atts;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 招商项目实体
	 */
	public Investment getInvestment(){
		return investment;
	}
	public void setInvestment(Investment investment){
		this.investment = investment;
	}
	/**
	 * 拟办企业概况
	 */
	public String getCompanySummery(){
		return CompanySummery;
	}
	public void setCompanySummery(String CompanySummery){
		this.CompanySummery = CompanySummery;
	}
	/**
	 * 创业团队概况
	 */
	public String getTeamSummery(){
		return TeamSummery;
	}
	public void setTeamSummery(String TeamSummery){
		this.TeamSummery = TeamSummery;
	}
	/**
	 * 项目技术可行性分析
	 */
	public String getProjectFeasibility(){
		return ProjectFeasibility;
	}
	public void setProjectFeasibility(String ProjectFeasibility){
		this.ProjectFeasibility = ProjectFeasibility;
	}
	/**
	 * 产品市场可行性分析
	 */
	public String getMarketFeasibility(){
		return MarketFeasibility;
	}
	public void setMarketFeasibility(String MarketFeasibility){
		this.MarketFeasibility = MarketFeasibility;
	}
	/**
	 * 经济效益及社会效益分析
	 */
	public String getEconomicBenefits(){
		return EconomicBenefits;
	}
	public void setEconomicBenefits(String EconomicBenefits){
		this.EconomicBenefits = EconomicBenefits;
	}
	/**
	 * 对创业中心的要求
	 */
	public String getRequirements(){
		return requirements;
	}
	public void setRequirements(String requirements){
		this.requirements = requirements;
	}
	public Set<BusinessPlanAtt> getAtts(){
		return atts;
	}
	public void setAtts(Set<BusinessPlanAtt> atts){
		this.atts = atts;
	}
}