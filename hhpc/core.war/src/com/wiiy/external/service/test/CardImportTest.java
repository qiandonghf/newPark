package com.wiiy.external.service.test;

import java.util.ArrayList;
import java.util.List;

import com.wiiy.commons.preferences.enums.GenderEnum;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.external.service.CardPubService;
import com.wiiy.external.service.dto.CardDto;

public class CardImportTest {
	public void test(){
		try {
			CardPubService cardService=CoreActivator.getService(CardPubService.class);
			if(cardService!=null){
				List<CardDto> list=new ArrayList<CardDto>();
				for(int i=1;i<10;i++){
					CardDto card=new CardDto();
					card.setGroupName("测试组");
					card.setCateName("测试类");
					card.setName("名片"+i);
					card.setFax("传真"+i);
					card.setHomeTel("家庭电话"+i);
					card.setGender(GenderEnum.Male);
					card.setHomePage("http://www.wiiy.com");
					card.setMsn("MSN"+i);
					card.setZipCode("邮编"+i);
					card.setQq("QQ"+i);
					card.setPosition("职位"+i);
					card.setOfficeTel("办公电话"+i);
					card.setCompany("公司"+i);
					card.setMobile("手机"+i);
					card.setEmail("邮件地址"+i);
					list.add(card);
				}
				for(int i=1;i<10;i++){
					CardDto card=new CardDto();
					card.setGroupName("测试组1");
					card.setCateName("测试类"+i);
					card.setName("名片"+i);
					card.setFax("传真"+i);
					card.setHomeTel("家庭电话"+i);
					card.setGender(GenderEnum.Female);
					card.setHomePage("http://www.wiiy.com");
					card.setMsn("MSN"+i);
					card.setZipCode("邮编"+i);
					card.setQq("QQ"+i);
					card.setPosition("职位"+i);
					card.setOfficeTel("办公电话"+i);
					card.setMobile("手机"+i);
					card.setCompany("公司"+i);
					card.setEmail("邮件地址"+i);
					list.add(card);
				}
				cardService.ImportCards(list);
			}
				
			System.out.println("cardService:"+cardService);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	}
}
