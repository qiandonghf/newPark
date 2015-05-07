package com.wiiy.external.service.test;

import com.wiiy.core.activator.CoreActivator;
import com.wiiy.external.service.GtasksService;

public class GtasksTest {
	public void test(){
		GtasksService gtasksService = CoreActivator.getService(GtasksService.class);
		int num = gtasksService.gtasksCount(CoreActivator.getSessionUser().getId());
		System.out.println(num);
	}
}
