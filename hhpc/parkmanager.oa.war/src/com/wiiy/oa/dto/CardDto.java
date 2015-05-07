package com.wiiy.oa.dto;

import java.util.List;

import com.wiiy.oa.entity.Card;

public class CardDto {
	private String groupName;
	private String categoryName;
	private List<Card> cards;
	
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public List<Card> getCards() {
		return cards;
	}
	public void setCards(List<Card> cards) {
		this.cards = cards;
	}
}
