package com.wiiy.core.service.export;

import java.io.File;
import java.util.List;

import com.wiiy.core.dto.DocumentDto;

public interface LuceneService {
	
	void createIndex(List<DocumentDto> dtos);
	
	void createIndex(DocumentDto dto);
	
	void createIndex(String id,String title,String content, String url);
	
	void createIndex(String id,File file);
	
	void updateIndex(String id,String title,String content, String url);
	
	void updateIndex(DocumentDto dto);
	
	void deleteIndex(String id);
	
	void search(String keyword,Page page);
}
