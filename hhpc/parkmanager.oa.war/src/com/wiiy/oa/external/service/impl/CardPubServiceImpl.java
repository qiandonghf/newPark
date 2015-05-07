package com.wiiy.oa.external.service.impl;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.activator.AbstractActivator.CachedLog;
import com.wiiy.external.service.CardPubService;
import com.wiiy.external.service.dto.CardDto;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.dao.CardDao;
import com.wiiy.oa.entity.Card;
import com.wiiy.oa.entity.CardCategory;
import com.wiiy.oa.preferences.enums.CardOwnerEnum;
import com.wiiy.oa.preferences.enums.CardTypeEnum;

public class CardPubServiceImpl implements CardPubService {
	protected CachedLog logger = CachedLog.getLog(getClass());
	private CardDao cardDao;
	@Override
	public Result ImportCards(List<CardDto> cardList) {
		logger.debug("CardPubServiceImpl.ImportCards():cardDao="+cardDao);
		Result r=null;
		if(cardList!=null){
			Session session=null;
			try {
				session=cardDao.openSession();
				Transaction tr=session.beginTransaction();
				for(CardDto card:cardList){
					String groupName=card.getGroupName();
					String cateName=card.getCateName();
					List<CardCategory> groupList=session.createQuery("from CardCategory where ownerEnum='"
							+CardOwnerEnum.PUBLIC+"' and parentId is null  and name='"+groupName+"'").list();
					CardCategory group=null;
					if(groupList!=null&&groupList.size()>0){
						logger.debug("------------------名片组["+groupName+"]已存在--------------");
						group=groupList.get(0);
					}
					else{
						group=new CardCategory();
						group.setName(groupName);
						group.setParentId(null);
						group.setParentIds(",");
						group.setOwnerId(1l);
						group.setOwnerEnum(CardOwnerEnum.PUBLIC);
						group.setLevel(0);
						session.save(group);
						logger.debug("------------------新建名片组["+groupName+"]--------------");
					}
					logger.debug("CardPubServiceImpl.ImportCards():groupId="+group.getId());
					
					List<CardCategory> cateList=session.createQuery("from CardCategory where parentId="+group.getId()+" and name='"+cateName+"'").list();
					CardCategory cate=null;
					if(cateList!=null&&cateList.size()>0){
						logger.debug("------------------名片分类["+cateName+"]已存在--------------");
						cate=cateList.get(0);
					}
					else{
						logger.debug("------------------新建名片分类["+cateName+"]--------------");
						cate=new CardCategory();
						cate.setName(cateName);
						cate.setParentId(group.getId());
						cate.setParentIds(","+group.getId()+",");
						cate.setOwnerId(1l);
						cate.setOwnerEnum(CardOwnerEnum.PUBLIC);
						cate.setLevel(1);
						session.save(cate);
					}
					logger.debug("CardPubServiceImpl.ImportCards():cateId="+cate.getId());
					
					List<Card> oldCardList=session.createQuery("from Card where categoryId="+cate.getId()+" and name='"+card.getName()+"'").list();
					
					if(oldCardList!=null&&oldCardList.size()>0){
						logger.debug("------------------名片组["+card.getGroupName()+"]名片分类["+card.getCateName()+"]中已存在名片["+card.getName()+"]已存在--------------");
					}
					else{
						Card newCard=new Card();
						newCard.setEmail(card.getEmail());
						newCard.setBirthday(card.getBirthDay());
						newCard.setCategoryId(cate.getId());
						newCard.setCompany(card.getCompany());
						newCard.setFax(card.getFax());
						newCard.setGender(card.getGender());
						newCard.setHomepage(card.getHomePage());
						newCard.setHomeTel(card.getHomeTel());
						newCard.setMobile(card.getMobile());
						newCard.setMsn(card.getMsn());
						newCard.setName(card.getName());
						newCard.setOfficeTel(card.getOfficeTel());
						newCard.setOwnerEnum(CardOwnerEnum.PUBLIC);
						newCard.setOwnerId(card.getOwnerId());
						newCard.setPosition(card.getPosition());
						newCard.setQq(card.getQq());
						newCard.setTypeEnum(CardTypeEnum.COMPANY);
						newCard.setZipcode(card.getZipCode());
						
						newCard.setMemo(card.getMemo());
						newCard.setHomeAddr(card.getHomeAddr());
						newCard.setCompanyAddr(card.getCompanyAddr());
						newCard.setSpouse(card.getSpouse());
						newCard.setChild(card.getChild());
						
						session.save(newCard);
						logger.debug("------------------名片组["+card.getGroupName()+"]名片分类["+card.getCateName()+"]名片["+card.getName()+"]导入成功--------------");
					}
				}
				tr.commit();
				r=new Result<List<CardDto>>(true, cardList, "导入成功");
			} catch (HibernateException e) {
				e.printStackTrace();
			}finally{
				if(session!=null)session.close();
				if(r==null){
					r=new Result<List<CardDto>>(false, cardList, "导入失败");
				}
			}
		}
		
		return r;
	}
	public CardDao getCardDao() {
		return cardDao;
	}
	public void setCardDao(CardDao cardDao) {
		this.cardDao = cardDao;
	}

}
