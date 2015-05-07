package com.wiiy.core.preferences;

import com.wiiy.commons.preferences.BaseR;

public class ContactBaseR extends BaseR{
	public static final class ContactBase{
		private static final String E = "联系单";
		private static final String SEND = "发送";
		private static final String CLOSE = "关闭";
		private static final String SUSPEND = "挂起";
		private static final String ACCEPT = "受理";
		
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
		public static final String SEND_FAILURE = E+SEND+FAILURE;
		public static final String SEND_SUCCESS = E+SEND+SUCCESS;
		public static final String CLOSE_FAILURE = E+CLOSE+FAILURE;
		public static final String CLOSE_SUCCESS = E+CLOSE+SUCCESS;
		public static final String SUSPEND_FAILURE = E+SUSPEND+FAILURE;
		public static final String SUSPEND_SUCCESS = E+SUSPEND+SUCCESS;
		public static final String ACCEPT_FAILURE = E+ACCEPT+FAILURE;
		public static final String ACCEPT_SUCCESS = E+ACCEPT+SUCCESS;
	}
}
