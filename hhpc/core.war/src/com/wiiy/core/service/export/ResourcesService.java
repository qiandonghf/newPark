package com.wiiy.core.service.export;

import java.io.File;
import java.io.InputStream;


public interface ResourcesService {
	
	/**
	 * 物理删除文件
	 * @param path
	 * @return
	 */
	boolean delete(String path);
	
	/**
	 * 物理删除文件
	 * @param path
	 * @return
	 */
	File getFileByPath(String path);
	
	/**
	 * 
	 * @param path
	 * @return
	 */
	File saveFile(String path, InputStream in);

}
