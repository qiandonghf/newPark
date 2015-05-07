package com.wiiy.core.service;

import java.util.List;

import com.wiiy.core.dto.ContactDto;
import com.wiiy.core.entity.ContactLog;
import com.wiiy.core.preferences.enums.ContactTypeEnum;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;


/**
 * @author my
 */
public interface ContactService{

	List<ContactDto> listMyAll(Pager pager,Long userId);
	List<ContactDto> listMyAll(Pager pager,Long userId,ContactTypeEnum type);

	List<ContactLog> getContactLogList(ContactTypeEnum type, Long id);

	ContactDto getContactDto(ContactTypeEnum type, Long id);

	int totalCount();

	int myTotalCount(Long userId);

	List<ContactDto> listAll(Pager pager);
	
	List<ContactDto> listAll(Pager pager,ContactTypeEnum type);

	int myTotalDidCountersignCount(Long userId);
	
	int myTotalWaitCountersignCount(Long userId);

	List<ContactDto> listMyDidCountersignAll(Pager pager, Long userId);

	List<ContactDto> listMyWaitCountersignAll(Pager pager, Long userId);

	int myTotalCount(Long userId, ContactTypeEnum type);
}
