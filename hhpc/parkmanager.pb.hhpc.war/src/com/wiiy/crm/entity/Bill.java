package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.crm.preferences.enums.BillInOutEnum;
import com.wiiy.crm.preferences.enums.BillStatusEnum;
import com.wiiy.crm.preferences.enums.PayTypeEnum;
import com.wiiy.pb.entity.Room;

/**
 * <br/>class-description 账单
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Bill extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	
	public Bill() {
		super();
	}
	public Bill(Long id, Date planPayTime) {
		super();
		this.id = id;
		this.planPayTime = planPayTime;
	}
	
	public Bill(Long id, Long billTypeId, Long customerId,Double factPayment,Date createTime) {
		super();
		this.id = id;
		this.billTypeId = billTypeId;
		this.customerId = customerId;
		this.factPayment = factPayment;
		this.createTime = createTime;
	}

	private Long id;
	/**
	 * 费用类型
	 */
	@FieldDescription("费用类型")
	private BillType billType;
	/**
	 * 企业
	 */
	@FieldDescription("企业")
	private Customer customer;
	/**
	 * 房间
	 */
	@FieldDescription("房间")
	private Room room;
	/**
	 * 流水号
	 */
	@FieldDescription("流水号")
	private String number;
	/**
	 * 账单拆分
	 */
	@FieldDescription("账单拆分")
	private Integer billSplit;
	/**
	 * 费用类型ID
	 */
	@FieldDescription("费用类型ID")
	private Long billTypeId;
	/**
	 * 企业ID
	 */
	@FieldDescription("企业ID")
	private Long customerId;
	/**
	 * 房间ID
	 */
	@FieldDescription("房间ID")
	private Long roomId;
	/**
	 * 资金计划ID
	 */
	@FieldDescription("资金计划ID")
	private Long billPlanId;
	/**
	 * 资金计划表名
	 */
	@FieldDescription("资金计划表名")
	private String billPlanTableName;
	/**
	 * 单价
	 */
	@FieldDescription("单价")
	private String price;
	/**
	 * 数量
	 */
	@FieldDescription("数量")
	private Double amount;
	/**
	 * 合同编号
	 */
	@FieldDescription("合同编号")
	private String contractNo;
	/**
	 * 是否发票
	 */
	@FieldDescription("是否发票")
	private BooleanEnum invoice;
	/**
	 * 已催缴
	 */
	@FieldDescription("已催缴")
	private BooleanEnum urged;
	/**
	 * 支付方式
	 */
	@FieldDescription("支付方式")
	private PayTypeEnum payType;
	/**
	 * 总金额
	 */
	@FieldDescription("总金额")
	private Double totalAmount;
	/**
	 * 实际支付金额
	 */
	@FieldDescription("实际支付金额")
	private Double factPayment;
	/**
	 * 计划支付日期
	 */
	@FieldDescription("计划支付日期")
	private Date planPayTime;
	/**
	 * 实际支付日期
	 */
	@FieldDescription("实际支付日期")
	private Date payTime;
	/**
	 * 出账日期
	 */
	@FieldDescription("出账日期")
	private Date checkoutTime;
	/**
	 * 违约金
	 */
	@FieldDescription("违约金")
	private Double penalty;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private BillStatusEnum status;
	/**
	 * 收支类型
	 */
	@FieldDescription("收支类型")
	private BillInOutEnum inOut;
	/**
	 * 优惠金额
	 */
	@FieldDescription("优惠金额")
	private Double discountRate;
	/**
	 * 计费开始时间
	 */
	@FieldDescription("计费开始时间")
	private Date feeStartTime;
	/**
	 * 计费结束时间
	 */
	@FieldDescription("计费结束时间")
	private Date feeEndTime;
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
	 * 费用类型
	 */
	public BillType getBillType(){
		return billType;
	}
	public void setBillType(BillType billType){
		this.billType = billType;
	}
	/**
	 * 企业
	 */
	public Customer getCustomer(){
		return customer;
	}
	public void setCustomer(Customer customer){
		this.customer = customer;
	}
	/**
	 * 房间
	 */
	public Room getRoom(){
		return room;
	}
	public void setRoom(Room room){
		this.room = room;
	}
	/**
	 * 流水号
	 */
	public String getNumber(){
		return number;
	}
	public void setNumber(String number){
		this.number = number;
	}
	/**
	 * 账单拆分
	 */
	public Integer getBillSplit(){
		return billSplit;
	}
	public void setBillSplit(Integer billSplit){
		this.billSplit = billSplit;
	}
	/**
	 * 费用类型ID
	 */
	public Long getBillTypeId(){
		return billTypeId;
	}
	public void setBillTypeId(Long billTypeId){
		this.billTypeId = billTypeId;
	}
	/**
	 * 企业ID
	 */
	public Long getCustomerId(){
		return customerId;
	}
	public void setCustomerId(Long customerId){
		this.customerId = customerId;
	}
	/**
	 * 房间ID
	 */
	public Long getRoomId(){
		return roomId;
	}
	public void setRoomId(Long roomId){
		this.roomId = roomId;
	}
	/**
	 * 资金计划ID
	 */
	public Long getBillPlanId(){
		return billPlanId;
	}
	public void setBillPlanId(Long billPlanId){
		this.billPlanId = billPlanId;
	}
	/**
	 * 资金计划表名
	 */
	public String getBillPlanTableName(){
		return billPlanTableName;
	}
	public void setBillPlanTableName(String billPlanTableName){
		this.billPlanTableName = billPlanTableName;
	}
	/**
	 * 单价
	 */
	public String getPrice(){
		return price;
	}
	public void setPrice(String price){
		this.price = price;
	}
	/**
	 * 数量
	 */
	public Double getAmount(){
		return amount;
	}
	public void setAmount(Double amount){
		this.amount = amount;
	}
	/**
	 * 合同编号
	 */
	public String getContractNo(){
		return contractNo;
	}
	public void setContractNo(String contractNo){
		this.contractNo = contractNo;
	}
	/**
	 * 是否发票
	 */
	public BooleanEnum getInvoice(){
		return invoice;
	}
	public void setInvoice(BooleanEnum invoice){
		this.invoice = invoice;
	}
	/**
	 * 已催缴
	 */
	public BooleanEnum getUrged(){
		return urged;
	}
	public void setUrged(BooleanEnum urged){
		this.urged = urged;
	}
	/**
	 * 支付方式
	 */
	public PayTypeEnum getPayType(){
		return payType;
	}
	public void setPayType(PayTypeEnum payType){
		this.payType = payType;
	}
	/**
	 * 总金额
	 */
	public Double getTotalAmount(){
		return totalAmount;
	}
	public void setTotalAmount(Double totalAmount){
		this.totalAmount = totalAmount;
	}
	/**
	 * 实际支付金额
	 */
	public Double getFactPayment(){
		return factPayment;
	}
	public void setFactPayment(Double factPayment){
		this.factPayment = factPayment;
	}
	/**
	 * 计划支付日期
	 */
	public Date getPlanPayTime(){
		return planPayTime;
	}
	public void setPlanPayTime(Date planPayTime){
		this.planPayTime = planPayTime;
	}
	/**
	 * 实际支付日期
	 */
	public Date getPayTime(){
		return payTime;
	}
	public void setPayTime(Date payTime){
		this.payTime = payTime;
	}
	/**
	 * 出账日期
	 */
	public Date getCheckoutTime(){
		return checkoutTime;
	}
	public void setCheckoutTime(Date checkoutTime){
		this.checkoutTime = checkoutTime;
	}
	/**
	 * 违约金
	 */
	public Double getPenalty(){
		return penalty;
	}
	public void setPenalty(Double penalty){
		this.penalty = penalty;
	}
	/**
	 * 状态
	 */
	public BillStatusEnum getStatus(){
		return status;
	}
	public void setStatus(BillStatusEnum status){
		this.status = status;
	}
	/**
	 * 收支类型
	 */
	public BillInOutEnum getInOut(){
		return inOut;
	}
	public void setInOut(BillInOutEnum inOut){
		this.inOut = inOut;
	}
	/**
	 * 优惠金额
	 */
	public Double getDiscountRate(){
		return discountRate;
	}
	public void setDiscountRate(Double discountRate){
		this.discountRate = discountRate;
	}
	/**
	 * 计费开始时间
	 */
	public Date getFeeStartTime(){
		return feeStartTime;
	}
	public void setFeeStartTime(Date feeStartTime){
		this.feeStartTime = feeStartTime;
	}
	/**
	 * 计费结束时间
	 */
	public Date getFeeEndTime(){
		return feeEndTime;
	}
	public void setFeeEndTime(Date feeEndTime){
		this.feeEndTime = feeEndTime;
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