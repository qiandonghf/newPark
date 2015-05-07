package com.wiiy.oa.action;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.TreeUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dto.CardCategoryDto;
import com.wiiy.oa.entity.Card;
import com.wiiy.oa.entity.CardCategory;
import com.wiiy.oa.preferences.enums.CardOwnerEnum;
import com.wiiy.oa.service.CardCategoryService;
import com.wiiy.oa.service.CardService;

public class CardAction extends JqGridBaseAction<Card>{
	private CardService cardService;
	private CardCategoryService cardCategoryService;
	private Card card;
	private CardCategory cardCategory;
	private List<Card> cards;
	private Result result;
	private Long id;
	private Long categoryId;
	private String ids;
	private String copyIds;
	private String moveIds;
	private List<CardCategory> allCardCategory;
	private List<CardCategory> myCardCategory;
	private List<CardCategory> cardCategoryList;
	private List<CardCategory> cardCategories;
	private List<CardCategory> cardCategoryLabel;
	private String groupName;//导入的组名
	private String categoryName;//导入的分组名;
	private Boolean flag = false;
	private String cardName;
	
	private int type = 0;//0普通，1 floatbox window弹层
	
	public String selectCard(){
		
		return "selectCard";
	}
	
	public String CardSearchByName(){
		try {
			byte B[]=cardName.getBytes("ISO-8859-1"); 
			String name = new String(B); 
			cards = cardService.getListByFilter(new Filter(Card.class).or(Filter.Eq("ownerId", OaActivator.getSessionUser().getId()),Filter.Eq("ownerEnum", CardOwnerEnum.PUBLIC)).like("name", name)).getValue();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		//cards = cardService.searchByName(cardName).getValue();
		if(cards!=null&&cards.size()>0){
			for (Card card : cards) {
				card.setText("<input type='hidden' class='cardMobile' value='"+card.getMobile()+";"+card.getName()+"'/>"+card.getName());
				card.setId(card.getId());
			}
		}
		return JSON;
	}
	
	public String cmCard(){
		Filter filter = new Filter(CardCategory.class);
		filter.or(Filter.Eq("ownerEnum", CardOwnerEnum.PUBLIC),Filter.Eq("ownerId", OaActivator.getSessionUser().getId()));
		allCardCategory = cardCategoryService.getListByFilter(filter).getValue();
		CardCategory category = new CardCategory();
		cardCategory = cardCategoryService.getBeanByFilter(new Filter(CardCategory.class).eq("name", "我的名片夹").isNull("parentId")).getValue();
		allCardCategory.add(cardCategory);
		BeanUtil.copyProperties(cardCategory, category);
		Map<Long,CardCategory> cardCategoryMap = new HashMap<Long,CardCategory>();
		Map<Long,CardCategory> myCardCategoryMap = new HashMap<Long,CardCategory>();
		for (CardCategory cardCategory : allCardCategory) {
			if(cardCategory.getOwnerEnum().equals(CardOwnerEnum.PRIVATE)){
				if(cardCategory.getParentId()==null){
					category.setText(cardCategory.getName());
					category.setState(TreeEntity.STATE_CLOSED);
					category.setIconCls("icon-my");
				}else{
					List<CardCategory> cardCategoryCards = new ArrayList<CardCategory>();
					cardCategory.setIconCls("icon-card");
					cardCategory.setChildren(cardCategoryCards);
					cardCategory.setText(cardCategory.getName());
//					cardCategory.setState(TreeEntity.STATE_CLOSED);
					cardCategory.setLevel(cardCategory.getLevel()-1);
					myCardCategoryMap.put(cardCategory.getId(), cardCategory);
				}
			}else{
				if(cardCategory.getParentId()!=null){
					cardCategory.setIconCls("icon-card");
				}else{
					cardCategory.setIconCls("icon-group");
					cardCategory.setState(TreeEntity.STATE_CLOSED);
				}
				List<CardCategory> cardCategoryCards = new ArrayList<CardCategory>();
				cardCategory.setChildren(cardCategoryCards);
				cardCategory.setText(cardCategory.getName());
				cardCategoryMap.put(cardCategory.getId(), cardCategory);
			}
		}
		List<CardCategory> newList = new ArrayList<CardCategory>();
		for (CardCategory cardCategory : cardCategoryMap.values()) {
			newList.add(cardCategory);
		}
		List<CardCategory> newMyCardList = new ArrayList<CardCategory>();
		for (CardCategory cardCategory : myCardCategoryMap.values()) {
			newMyCardList.add(cardCategory);
		}
		category.setChildren(TreeUtil.generateTree(newMyCardList));
		if(newList.size()==0 || newList==null){
			newList.add(category);
			cardCategoryList = TreeUtil.generateTree(newList);
		}else{
			cardCategoryList = TreeUtil.generateTree(newList);
			cardCategoryList.add(category);
		}
		return JSON;
	}
	
	public String save(){
		String[] ids = ServletActionContext.getRequest().getParameterValues("ids");
		Card newCard = new Card();
		BeanUtil.copyProperties(card, newCard);
		for(String sId : ids){
			Long id = Long.parseLong(sId);
			cardCategory = cardCategoryService.getBeanById(id).getValue();
			newCard.setCategory(cardCategory);
			newCard.setCategoryId(id);
			newCard.setOwnerEnum(cardCategory.getOwnerEnum());
			result = cardService.save(newCard);
		}
		return JSON;
	}
	
	public String addByCategoryId(){
		result = cardCategoryService.getBeanById(id);
		return "addCard";
	}
	
	public String loadCardByCategoryId(){
		Filter filter = new Filter(Card.class).eq("categoryId", id);
		CardCategory cc = cardCategoryService.getBeanById(id).getValue();
		if(cc.getOwnerEnum().equals(CardOwnerEnum.PRIVATE)){
			flag = true;
		}
		fetchDepth = 2;
		return refresh(filter);
	}
	
	public String loadMyLabel(){
		List<CardCategory> parentCatList = cardCategoryService.getListByFilter(new Filter(CardCategory.class).isNull("parentId").ne("name", "我的名片夹")).getValue();
		List<CardCategory> labelList = cardCategoryService.getListByFilter(new Filter(CardCategory.class).notNull("parentId").or(Filter.Eq("ownerEnum", CardOwnerEnum.PUBLIC),Filter.Eq("ownerId", OaActivator.getSessionUser().getId()))).getValue();
		List<CardCategoryDto> dtoList = new ArrayList<CardCategoryDto>();
		Map<Long,CardCategory> cardCategoryMap = new HashMap<Long,CardCategory>();
		for(CardCategory cardCategory : parentCatList){
			cardCategoryMap.put(cardCategory.getId(), cardCategory);
		}
		Collection<CardCategory> list = cardCategoryMap.values();
		List<CardCategory> newList = new ArrayList<CardCategory>();
		for (CardCategory cardCategory : list) {
			newList.add(cardCategory);
		}
		
		for(CardCategory cardCategory : newList){
			CardCategoryDto dto = new CardCategoryDto();
			dto.setCardCategory(cardCategory);
			List<CardCategory> childList = new ArrayList<CardCategory>();
			for(CardCategory cc : labelList){
				if(cc.getOwnerEnum().equals(CardOwnerEnum.PUBLIC) && cc.getParentId().longValue()==cardCategory.getId()){
					childList.add(cc);
				}
			}
			dto.setCardLabelList(childList);
			dtoList.add(dto);
		}
		if(OaActivator.getSessionUser().getAdmin().equals(BooleanEnum.NO)){
			dtoList = new ArrayList<CardCategoryDto>();
		}
		result = Result.value(dtoList);
		myCardCategory = cardCategoryService.getListByFilter(new Filter(CardCategory.class).eq("ownerId", OaActivator.getSessionUser().getId()).eq("ownerEnum", CardOwnerEnum.PRIVATE).notNull("parentId")).getValue();
		
		allCardCategory = cardCategoryService.getListByFilter(new Filter(CardCategory.class).notNull("parentId")).getValue();
		return JSON;
	}
	
	public String loadMyCard(){
		Filter filter = new Filter(Card.class).eq("ownerId", OaActivator.getSessionUser().getId()).eq("ownerEnum", CardOwnerEnum.PRIVATE);
		fetchDepth = 2;
		return refresh(filter);
	}
	
	public String view(){
		result = cardService.getBeanById(id);
		card = cardService.getBeanById(id).getValue();
		cardCategoryList = cardCategoryService.getListByFilter(new Filter(CardCategory.class).eq("id",card.getCategoryId())).getValue();
		return VIEW;
	}
	
	public String edit(){
		result = cardService.getBeanById(id);
		card = cardService.getBeanById(id).getValue();
		cardCategoryList = cardCategoryService.getListByFilter(new Filter(CardCategory.class).eq("id",card.getCategoryId())).getValue();
		if(card.getOwnerEnum().equals(CardOwnerEnum.PUBLIC) && OaActivator.getSessionUser().getAdmin().equals(BooleanEnum.NO)){
			return VIEW;
		}else{
			return EDIT;
		}
	}
	
	public String update(){
		Card dbBean = cardService.getBeanById(card.getId()).getValue();
		String[] ids = ServletActionContext.getRequest().getParameterValues("ids");
		if(ids==null){
			BeanUtil.copyProperties(card, dbBean);
			result = cardService.update(dbBean);
		}else{
			Card newCard = new Card();
			BeanUtil.copyProperties(card, newCard);
			l:for(String sId : ids){
				Long id = Long.parseLong(sId);
				if(id==dbBean.getCategoryId().longValue())continue l;
				cardCategory = cardCategoryService.getBeanById(id).getValue();
				newCard.setCategory(cardCategory);
				newCard.setCategoryId(id);
				newCard.setOwnerEnum(cardCategory.getOwnerEnum());
				result = cardService.save(newCard);
			}
		}
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = cardService.deleteById(id);
		}else if(ids!=null){
			result = cardService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String copyMove(){
		if(OaActivator.getSessionUser().getAdmin().equals(BooleanEnum.YES)){
			allCardCategory = cardCategoryService.getListByFilter(new Filter(CardCategory.class).or(Filter.Eq("ownerId", OaActivator.getSessionUser().getId()),Filter.IsNull("parentId"))).getValue();
		}else{
			Filter filter = new Filter(CardCategory.class);
			filter.or(Filter.Eq("ownerId", OaActivator.getSessionUser().getId()), Filter.Eq("name", "我的名片夹"));
			allCardCategory = cardCategoryService.getListByFilter(filter).getValue();
		}
		CardCategory category = new CardCategory();
		cardCategory = cardCategoryService.getBeanByFilter(new Filter(CardCategory.class).eq("name", "我的名片夹").isNull("parentId")).getValue();
		BeanUtil.copyProperties(cardCategory, category);
		Map<Long,CardCategory> cardCategoryMap = new HashMap<Long,CardCategory>();
		Map<Long,CardCategory> myCardCategoryMap = new HashMap<Long,CardCategory>();
		for (CardCategory cardCategory : allCardCategory) {
			if(cardCategory.getOwnerEnum().equals(CardOwnerEnum.PRIVATE)){
				if(cardCategory.getParentId()==null){
					category.setText(cardCategory.getName());
					category.setState(TreeEntity.STATE_CLOSED);
					category.setIconCls("icon-my");
				}else{
					List<CardCategory> cardCategoryCards = new ArrayList<CardCategory>();
					cardCategory.setIconCls("icon-folder");
					cardCategory.setChildren(cardCategoryCards);
					cardCategory.setText(cardCategory.getName());
					cardCategory.setLevel(cardCategory.getLevel()-1);
					myCardCategoryMap.put(cardCategory.getId(), cardCategory);
				}
			}else{
				if(cardCategory.getParentId()!=null){
					cardCategory.setIconCls("icon-folder");
				}else{
					cardCategory.setIconCls("icon-group");
					cardCategory.setState(TreeEntity.STATE_CLOSED);
				}
				List<CardCategory> cardCategoryCards = new ArrayList<CardCategory>();
				cardCategory.setChildren(cardCategoryCards);
				cardCategory.setText(cardCategory.getName());
				cardCategoryMap.put(cardCategory.getId(), cardCategory);
			}
		}
		Collection<CardCategory> list = cardCategoryMap.values();
		List<CardCategory> newList = new ArrayList<CardCategory>();
		for (CardCategory cardCategory : list) {
			newList.add(cardCategory);
		}
		Collection<CardCategory> myCardList = myCardCategoryMap.values();
		List<CardCategory> newMyCardList = new ArrayList<CardCategory>();
		for (CardCategory cardCategory : myCardList) {
			newMyCardList.add(cardCategory);
		}
		category.setChildren(TreeUtil.generateTree(newMyCardList));
		if(newList.size()==0 || newList==null){
			newList.add(category);
			cardCategoryList = TreeUtil.generateTree(newList);
		}else{
			cardCategoryList = TreeUtil.generateTree(newList);
			cardCategoryList.add(category);
		}
		return JSON;
	}

	public String copyCard(){
		String[] eachId = ids.split(",");
		for(int i=0;i<eachId.length;i++){
			int n = 0;
			String idid = eachId[i];
			Long id1 = Long.parseLong(idid);
			Card card = cardService.getBeanById(id1).getValue();
			String[] Ids = copyIds.split(",");
			copyList:for(int j=0;j<Ids.length;j++){
				String idsids = Ids[j];
				Long id2 = Long.parseLong(idsids);
				cardCategory = cardCategoryService.getBeanById(id2).getValue();
				if(cardCategory.getParentId()==null){
					n++;
					continue copyList;
				}
				List<Card> list = cardService.getListByFilter(new Filter(Card.class).eq("categoryId", id2)).getValue();
				for(Card c : list){
					if(card.getName().equals(c.getName()) && card.getMobile().equals(c.getMobile())){
						if(Ids.length==1){
							result = new Result<Card>(true, card, card.getCategory().getName()+"已经有相同的名片");
						}else{
							result = new Result<Card>(true, card, "操作完成");
						}
						continue copyList;
					}
				}
				if(card.getCategoryId().equals(id2)){
					result = new Result<Card>(true, card, card.getCategory().getName()+"已经有相同的名片");
				}else{
					card.setCategoryId(id2);
					card.setOwnerEnum(cardCategory.getOwnerEnum());
					cardService.save(card);
					result = new Result<Card>(true, card, "操作完成");
				}
			}
			if(n==Ids.length){
				result = Result.failure("请先创建子目录名片夹");
			}
		}
		return JSON;
	}
	
	public String moveCard(){
		String[] moveids = ids.split(",");
		for(int i=0;i<moveids.length;i++){
			int n = 0;
			String myids = moveids[i];
			Long myId = Long.parseLong(myids);
			Card card = cardService.getBeanById(myId).getValue();
			if(card.getOwnerEnum().equals(CardOwnerEnum.PUBLIC) && OaActivator.getSessionUser().getAdmin().equals(BooleanEnum.NO)){
				flag = true;
			}else{
			String[] Ids = moveIds.split(",");
			moveList:for(int j=0;j<Ids.length;j++){
				Long myMoveId = Long.parseLong(Ids[j]);
				cardCategory = cardCategoryService.getBeanById(myMoveId).getValue();
				if(cardCategory.getParentId()==null){
					n++;
					continue moveList;
				}
				List<Card> list = cardService.getListByFilter(new Filter(Card.class).eq("categoryId", myMoveId)).getValue();
				for(Card c : list){
					if(card.getName().equals(c.getName()) && card.getMobile().equals(c.getMobile())){
						if(Ids.length==1){
							result = new Result<Card>(true, card, card.getCategory().getName()+"已经有相同的名片");
						}else{
							result = new Result<Card>(true, card, "操作完成");
						}
						continue moveList;
					}
				}
				if(card.getCategoryId().equals(myMoveId)){
					result = new Result<Card>(true, card,  card.getCategory().getName()+"已经有相同的名片");
				}else{
					card.setCategoryId(myMoveId);
					card.setOwnerEnum(cardCategory.getOwnerEnum());
					cardService.save(card);
					result = new Result<Card>(true, card, "操作完成");
					cardService.deleteById(myId);
				}
			}
			if(n==Ids.length){
				result = Result.failure("请先创建子目录名片夹");
			}
		  }
		}
		return JSON;
	}
	
	@Override
	protected List<Card> getListByFilter(Filter fitler) {
		return cardService.getListByFilter(fitler).getValue();
	}


	public CardService getCardService() {
		return cardService;
	}


	public void setCardService(CardService cardService) {
		this.cardService = cardService;
	}
	
	
	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}
	

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public List<Card> getCards() {
		return cards;
	}

	public void setCards(List<Card> cards) {
		this.cards = cards;
	}
	public Card getCard() {
		return card;
	}
	public void setCard(Card card) {
		this.card = card;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}
	public void setCardCategoryService(CardCategoryService cardCategoryService) {
		this.cardCategoryService = cardCategoryService;
	}

	public List<CardCategory> getAllCardCategory() {
		return allCardCategory;
	}

	public void setAllCardCategory(List<CardCategory> allCardCategory) {
		this.allCardCategory = allCardCategory;
	}

	public List<CardCategory> getMyCardCategory() {
		return myCardCategory;
	}

	public void setMyCardCategory(List<CardCategory> myCardCategory) {
		this.myCardCategory = myCardCategory;
	}
	
	public CardCategoryService getCardCategoryService() {
		return cardCategoryService;
	}

	public CardCategory getCardCategory() {
		return cardCategory;
	}

	public void setCardCategory(CardCategory cardCategory) {
		this.cardCategory = cardCategory;
	}

	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	public String getCopyIds() {
		return copyIds;
	}

	public void setCopyIds(String copyIds) {
		this.copyIds = copyIds;
	}

	public String getMoveIds() {
		return moveIds;
	}

	public void setMoveIds(String moveIds) {
		this.moveIds = moveIds;
	}

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

	public List<CardCategory> getCardCategoryList() {
		return cardCategoryList;
	}

	public void setCardCategoryList(List<CardCategory> cardCategoryList) {
		this.cardCategoryList = cardCategoryList;
	}
	public String getCardName() {
		return cardName;
	}

	public Boolean getFlag() {
		return flag;
	}

	public void setFlag(Boolean flag) {
		this.flag = flag;
	}
	public void setCardName(String cardName) {
		this.cardName = cardName;
	}

	public List<CardCategory> getCardCategories() {
		return cardCategories;
	}

	public void setCardCategories(List<CardCategory> cardCategories) {
		this.cardCategories = cardCategories;
	}

	public List<CardCategory> getCardCategoryLabel() {
		return cardCategoryLabel;
	}

	public void setCardCategoryLabel(List<CardCategory> cardCategoryLabel) {
		this.cardCategoryLabel = cardCategoryLabel;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
}
