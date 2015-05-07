package com.wiiy.json;



import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.json.JSONResult;

/** 
 * 本类说明： 
 * 编写人员：  aswan 
 * @version V1.0  
 * 创建时间：2014-5-14 下午8:09:15 
 * 修改人员：
 * 修改时间：
 * 是否测试：
 */

public class JsonResult extends JSONResult {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1299625626752790793L;
	private static final Log logger = LogFactory.getLog(JsonResult.class);
	
	@Override
	protected void writeToResponse(HttpServletResponse response, String json,
			boolean gzip) throws IOException {
		// TODO Auto-generated method stub
		System.out.println("json:"+json);
		logger.debug("json:" + json);
		super.writeToResponse(response, json, gzip);
	}

}
