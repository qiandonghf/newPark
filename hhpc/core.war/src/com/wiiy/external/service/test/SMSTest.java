package com.wiiy.external.service.test;


import com.wiiy.external.service.SMSSender;

import com.wiiy.core.activator.CoreActivator;




public class SMSTest {
	
	private SMSSender smsSender;
	
	public void setSmsSender(SMSSender smsSender) {
		this.smsSender = smsSender;
	}

	public void sendTest() {
		new Thread(new Runnable() {

			@Override
			public void run() {
				int retCode = CoreActivator.getService(SMSSender.class).sendSMS(new String[]{"13957111692"}, "测试[杭州三略]");
				System.out.println("_________________________________________");
				if (retCode == 0) {
					System.out.println("sms test successfully!");
				} else {
					System.out.println("sms test failed with retCode : " + retCode);
				}
			}
			
		}).start();
	}
}
