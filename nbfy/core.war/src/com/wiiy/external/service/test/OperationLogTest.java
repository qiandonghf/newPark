package com.wiiy.external.service.test;

import com.wiiy.core.activator.CoreActivator;

public class OperationLogTest {
	public void test(){
		CoreActivator.getOperationLogService().logOP("操作日志测试");
		CoreActivator.getOperationLogService().logLogin("登录日志测试");
		CoreActivator.getOperationLogService().logLogout("登出日志测试");
	}
}
