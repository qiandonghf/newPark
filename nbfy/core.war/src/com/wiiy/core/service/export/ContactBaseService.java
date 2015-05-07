package com.wiiy.core.service.export;

import java.io.OutputStream;

import com.wiiy.core.entity.ContactEntity;
import com.wiiy.core.preferences.enums.ContactTypeEnum;
import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;

public interface ContactBaseService<T extends ContactEntity> extends IService<T>{
	Result<?> accept(Long id,Long userId);
	
	Result<?> close(Long id,Long userId);
	
	Result<?> suspend(Long id,Long userId);
	
	Result<?> print(Long id,OutputStream out);
	
	Result<?> send(Long id,Long receiveId,Long userId);
	
	Result<?> solved(Long id,Long userId);
	
	Result<?> unSolved(Long id,Long userId);
	
	Result<?> partsolved(Long id,Long userId);
    
    Result<?> save(T t,Long userId);
    
    Result<?> deleteById(Long id,ContactTypeEnum type);
    
    Result<?> revoke(T t);
}
