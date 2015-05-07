package com.wiiy.pb.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.pb.entity.Meter;
import com.wiiy.pb.preferences.enums.MeterTypeEnum;

/**
 * <br/>class-description 水电表费用设置
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class RoomMeterFee extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 水电表实体
	 */
	@FieldDescription("水电表实体")
	private Meter meter;
	/**
	 * 水电表外键
	 */
	@FieldDescription("水电表外键")
	private Long meterId;
	/**
	 * 类型
	 */
	@FieldDescription("类型")
	private MeterTypeEnum type;
	/**
	 * 房间外键
	 */
	@FieldDescription("房间外键")
	private Long roomId;
	/**
	 * 价格
	 */
	@FieldDescription("价格")
	private Double price;
	/**
	 * 价格类型
	 */
	@FieldDescription("价格类型")
	private String priceType;
	/**
	 * 是否公摊
	 */
	@FieldDescription("是否公摊")
	private BooleanEnum share;
	/**
	 * 系数
	 */
	@FieldDescription("系数")
	private String ratio;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 水电表实体
	 */
	public Meter getMeter(){
		return meter;
	}
	public void setMeter(Meter meter){
		this.meter = meter;
	}
	/**
	 * 水电表外键
	 */
	public Long getMeterId(){
		return meterId;
	}
	public void setMeterId(Long meterId){
		this.meterId = meterId;
	}
	/**
	 * 类型
	 */
	public MeterTypeEnum getType(){
		return type;
	}
	public void setType(MeterTypeEnum type){
		this.type = type;
	}
	/**
	 * 房间外键
	 */
	public Long getRoomId(){
		return roomId;
	}
	public void setRoomId(Long roomId){
		this.roomId = roomId;
	}
	/**
	 * 价格
	 */
	public Double getPrice(){
		return price;
	}
	public void setPrice(Double price){
		this.price = price;
	}
	/**
	 * 价格类型
	 */
	public String getPriceType(){
		return priceType;
	}
	public void setPriceType(String priceType){
		this.priceType = priceType;
	}
	/**
	 * 是否公摊
	 */
	public BooleanEnum getShare(){
		return share;
	}
	public void setShare(BooleanEnum share){
		this.share = share;
	}
	/**
	 * 系数
	 */
	public String getRatio(){
		return ratio;
	}
	public void setRatio(String ratio){
		this.ratio = ratio;
	}
}