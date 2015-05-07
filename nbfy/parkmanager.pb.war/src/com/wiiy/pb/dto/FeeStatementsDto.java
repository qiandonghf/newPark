package com.wiiy.pb.dto;

import java.util.Date;
import java.util.List;

import com.wiiy.pb.entity.Building;
import com.wiiy.pb.entity.Meter;
import com.wiiy.pb.entity.MeterLabelRecord;

/**
 * 
 * @author my
 *
 */
public class FeeStatementsDto {
	
	private List<MeterLabelRecord> labelRecords;
	private List<Meter> meters;
	private Date startTime;
	private Date endTime;
	private long labelId;
	private String labelType;
	private String checkOut;
	
	public String getCheckOut() {
		return checkOut;
	}
	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}
	public String getLabelType() {
		return labelType;
	}
	public void setLabelType(String labelType) {
		this.labelType = labelType;
	}
	public long getLabelId() {
		return labelId;
	}
	public void setLabelId(long labelId) {
		this.labelId = labelId;
	}
	public List<MeterLabelRecord> getLabelRecords() {
		return labelRecords;
	}
	public void setLabelRecords(List<MeterLabelRecord> labelRecords) {
		this.labelRecords = labelRecords;
	}
	public List<Meter> getMeters() {
		return meters;
	}
	public void setMeters(List<Meter> meters) {
		this.meters = meters;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
}
