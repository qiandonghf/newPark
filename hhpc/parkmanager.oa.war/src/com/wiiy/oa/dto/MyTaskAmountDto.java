package com.wiiy.oa.dto;

public class MyTaskAmountDto {
	private int signed;//待签收
	private int pending;//我待办的
	private int normal;//正常的
	private int delay;//逾期的
	public int getSigned() {
		return signed;
	}
	public void setSigned(int signed) {
		this.signed = signed;
	}
	public int getPending() {
		return pending;
	}
	public void setPending(int pending) {
		this.pending = pending;
	}
	public int getNormal() {
		return normal;
	}
	public void setNormal(int normal) {
		this.normal = normal;
	}
	public int getDelay() {
		return delay;
	}
	public void setDelay(int delay) {
		this.delay = delay;
	}
	

}
