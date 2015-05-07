package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.CardCategory;
import com.wiiy.oa.preferences.enums.CardOwnerEnum;
import com.wiiy.oa.service.CardCategoryService;
import com.wiiy.oa.service.CardService;

public class CardCategoryAction extends JqGridBaseAction<CardCategory>{
	private CardCategoryService cardCategoryService;
	private CardService cardService;
	private List<CardCategory> cardCategories;
	private List<CardCategory> myCardList;
	private List<CardCategory> cardCategoryLabel;
	private CardCategory cardCategory;
	private Result result;
	private Long id;
	private String ids;
	
	public String addCardCategoryByParentId(){
		result = cardCategoryService.getBeanById(id);
		return "addCategory";
	}
	
	public String addMyCardCategory(){
		result = cardCategoryService.getBeanById(id);
		return "addMyCategory";
	}

	public String addCardByCategoryId(){
		result = cardCategoryService.getBeanById(id);
		return "addCard";
	}
	
	public String loadCardCategoryByParentId(){
		result = cardCategoryService.getListByFilter(new Filter(CardCategory.class).eq("parentId", id));
		return JSON;
	}
	
	public String list(){
		List<CardCategory> cardCaList = cardCategoryService.getListByFilter(new Filter(CardCategory.class).isNull("parentId").eq("name", "我的名片夹")).getValue();
		if(cardCaList == null || cardCaList.size() < 1){
			CardCategory cc = new CardCategory();
			cc.setName("我的名片夹");
			cc.setOwnerEnum(CardOwnerEnum.PRIVATE);
			cardCategoryService.save(cc);
		}
		/*Filter filter = new Filter(CardCategory.class);
		filter.orderBy("ownerEnum", Filter.DESC).isNull("parentId");
		cardCategories = cardCategoryService.getListByFilter(filter).getValue();
		Filter filter2 = new Filter(CardCategory.class);
		filter2.notNull("parentId");
		filter2.or(Filter.Eq("ownerEnum", CardOwnerEnum.PUBLIC),Filter.Eq("ownerId",OaActivator.getSessionUser().getId()));
		cardCategoryLabel = cardCategoryService.getListByFilter(filter2).getValue();*/
		return LIST;
	}
	
	public String save(){
		result = cardCategoryService.save(cardCategory);
		return JSON;
	}
	
	public String edit(){
		cardCategory = cardCategoryService.getBeanById(id).getValue();
		result = Result.value(cardCategory);
		return EDIT;
	}
	
	public String update(){
		CardCategory dbBean = cardCategoryService.getBeanById(cardCategory.getId()).getValue();
		BeanUtil.copyProperties(cardCategory, dbBean);
		result = cardCategoryService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = cardCategoryService.deleteById(id);
		}else if(ids!=null){
			result = cardCategoryService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String addCardLabelByCategoryId(){
		result = cardCategoryService.getBeanById(id);
		return "addByCategoryId";
	}
	
	@Override
	protected List<CardCategory> getListByFilter(Filter fitler) {
		return cardCategoryService.getListByFilter(fitler).getValue();
	}

	public void setCardCategoryService(CardCategoryService cardCategoryService) {
		this.cardCategoryService = cardCategoryService;
	}

	public List<CardCategory> getCardCategories() {
		return cardCategories;
	}

	public void setCardCategories(List<CardCategory> cardCategories) {
		this.cardCategories = cardCategories;
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


	public CardCategory getCardCategory() {
		return cardCategory;
	}


	public void setCardCategory(CardCategory cardCategory) {
		this.cardCategory = cardCategory;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}


	public CardService getCardService() {
		return cardService;
	}

	public void setCardService(CardService cardService) {
		this.cardService = cardService;
	}

	public List<CardCategory> getMyCardList() {
		return myCardList;
	}

	public void setMyCardList(List<CardCategory> myCardList) {
		this.myCardList = myCardList;
	}


	public List<CardCategory> getCardCategoryLabel() {
		return cardCategoryLabel;
	}


	public void setCardCategoryLabel(List<CardCategory> cardCategoryLabel) {
		this.cardCategoryLabel = cardCategoryLabel;
	}
}
