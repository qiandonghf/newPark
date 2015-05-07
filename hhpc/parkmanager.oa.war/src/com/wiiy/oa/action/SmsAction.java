package com.wiiy.oa.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.Card;
import com.wiiy.oa.entity.CardCategory;
import com.wiiy.oa.entity.Sms;
import com.wiiy.oa.entity.SmsReceiver;
import com.wiiy.oa.preferences.enums.CardOwnerEnum;
import com.wiiy.oa.service.CardCategoryService;
import com.wiiy.oa.service.CardService;
import com.wiiy.oa.service.SmsReceiverService;
import com.wiiy.oa.service.SmsService;

/**
 * @author my
 */
public class SmsAction extends JqGridBaseAction<Sms>{
	private SmsReceiverService smsReceiverService;
	
	private CardCategoryService cardCategoryService;
	private CardService cardService; 
	private List<Card> cards;
	private List<CardCategory> allCardCategory;
	private List<CardCategory> cardCategoryList;

	private SmsService smsService;
	private Result result;
	private Sms sms;
	private Long id;
	private String ids;
	private String type;
	
	private String smsSign;
	
	public String save(){
		result = smsService.save(sms);
		return JSON;
	}
	
	public String view(){
		result = smsService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = smsService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Sms dbBean = smsService.getBeanById(sms.getId()).getValue();
		BeanUtil.copyProperties(sms, dbBean);
		result = smsService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = smsService.deleteById(id);
		} else if(ids!=null){
			result = smsService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String smsPage(){
		Filter filter = new Filter(CardCategory.class);
		filter.or(Filter.Eq("ownerId", OaActivator.getSessionUser().getId()),Filter.Eq("ownerEnum", CardOwnerEnum.PUBLIC),Filter.Eq("name", "我的名片夹"));
		allCardCategory = cardCategoryService.getListByFilter(filter).getValue();
		filter = new Filter(Card.class);
		filter.or(Filter.Eq("ownerId", OaActivator.getSessionUser().getId()),Filter.Eq("ownerEnum", CardOwnerEnum.PUBLIC));
		Map<Long,CardCategory> cardCategoryMap = new HashMap<Long,CardCategory>();
		for (CardCategory cardCategory : allCardCategory) {
			List<CardCategory> children = new ArrayList<CardCategory>();
			cardCategory.setChildren(children);
			cardCategoryMap.put(cardCategory.getId(), cardCategory);
		}
		
		cards = cardService.getListByFilter(filter).getValue();
		for (Card card : cards) {
			card.setLevel(2);
			card.setText("<input type='hidden' class='cardMobile' value='"+card.getMobile()+";"+card.getName()+"'/>"+card.getName());
			card.setIconCls("icon-card");
			if(cardCategoryMap.get(card.getCategoryId())!=null){
				CardCategory cardCategory = new CardCategory();
				cardCategory.setLevel(2);
				cardCategory.setText("<input type='hidden' class='cardMobile' value='"+card.getMobile()+";"+card.getName()+"'/>"+card.getName());
				cardCategory.setIconCls("icon-card");
				cardCategoryMap.get(card.getCategoryId()).getChildren().add(cardCategory);
			}
		}
		for (CardCategory cardCategory : cardCategoryMap.values()) {
			if(cardCategory.getParentId()!=null){
				if(cardCategory.getOwnerEnum().equals(CardOwnerEnum.PRIVATE)){
					cardCategory.setIconCls("icon-group");
					cardCategory.setLevel(1);
				}else{
					cardCategory.setIconCls("icon-folder");
					cardCategory.setLevel(1);
				}
				if(cardCategoryMap.get(cardCategory.getParentId())!=null){
					cardCategoryMap.get(cardCategory.getParentId()).getChildren().add(cardCategory);
				}
			}else if(cardCategory.getOwnerEnum().equals(CardOwnerEnum.PRIVATE)){
				cardCategory.setLevel(0);
				cardCategory.setIconCls("icon-my");
			}
			cardCategory.setText(cardCategory.getName());
			cardCategory.setState(TreeEntity.STATE_CLOSED);
		}
		cardCategoryList = new ArrayList<CardCategory>();
		for (CardCategory cardCategory : cardCategoryMap.values()) {
			if(cardCategory.getParentId()==null){
				cardCategoryList.add(cardCategory);
			}
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(Sms.class);
		if(type.equals("send")){
			filter.eq("sended",BooleanEnum.YES).eq("creatorId", OaActivator.getSessionUser().getId());
		}else{
			filter.eq("sended",BooleanEnum.NO).eq("creatorId", OaActivator.getSessionUser().getId());
		}
		refresh(filter);
		for(Sms sms:root){
			List<SmsReceiver> smsReceivers = smsReceiverService.getListByFilter(new Filter(SmsReceiver.class).eq("smsId", sms.getId())).getValue();
			if(smsReceivers!=null&&smsReceivers.size()>0){
				String receivers=" ";
				if(smsReceivers.size()>1){
					for (SmsReceiver smsReceiver : smsReceivers) {
						receivers += smsReceiver.getReceiverName()+";";
					}
					sms.setReceivers(receivers);
				}else{
					for (SmsReceiver smsReceiver : smsReceivers) {
						sms.setReceivers(smsReceiver.getReceiverName());
					}
				}
			}
		}
		return JSON;
	}
	
	@Override
	protected List<Sms> getListByFilter(Filter fitler) {
		return smsService.getListByFilter(fitler).getValue();
	}
	
	
	public Sms getSms() {
		return sms;
	}

	public void setSms(Sms sms) {
		this.sms = sms;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public void setSmsService(SmsService smsService) {
		this.smsService = smsService;
	}
	
	public Result getResult() {
		return result;
	}
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setSmsReceiverService(SmsReceiverService smsReceiverService) {
		this.smsReceiverService = smsReceiverService;
	}

	public List<CardCategory> getAllCardCategory() {
		return allCardCategory;
	}

	public List<CardCategory> getCardCategoryList() {
		return cardCategoryList;
	}
	public void setCardCategoryService(CardCategoryService cardCategoryService) {
		this.cardCategoryService = cardCategoryService;
	}

	public void setCardService(CardService cardService) {
		this.cardService = cardService;
	}
	public List<Card> getCards() {
		return cards;
	}

	public String getSmsSign() {
		return smsSign;
	}

	public void setSmsSign(String smsSign) {
		this.smsSign = smsSign;
	}


}
