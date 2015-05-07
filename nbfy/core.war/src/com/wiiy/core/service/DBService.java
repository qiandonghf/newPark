package com.wiiy.core.service;

import java.util.List;

import com.wiiy.core.dto.DBDto;
import com.wiiy.hibernate.Pager;

public interface DBService {
	public List<DBDto> loadBackupList(Pager pager);
	public String doBackup()throws Exception ;
	
	public void deleteByDayCnt(int days)throws Exception;
}
