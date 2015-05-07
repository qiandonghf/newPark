package com.wiiy.oa.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.dto.CardDto;
import com.wiiy.oa.entity.Card;

public interface CardService extends IService<Card>{
	Result<List<CardDto>> importCard(List<CardDto> cardDtos);

	//Result<List<Card>> searchByName(String cardName);
}
