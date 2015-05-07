package com.wiiy.core.preferences;

import com.wiiy.commons.preferences.BaseR;

public class R extends BaseR{
	
	public static final class Approval {
		private static final String E = "审批";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
	}
	public static final class User {
		private static final String E = "用户";
		private static final String F = "密码";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String SAVE_FAILURE_DUPLICATED_NAME = E+"名称已使用";
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
		public static final String UPDATE_PASSWORD_FAILURE = E+F+UPDATE+FAILURE;
		public static final String UPDATE_PASSWORD_SUCCESS = E+F+UPDATE+SUCCESS;
	}
	public static final class UserEmailParam {
		private static final String E = "邮箱设置";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
	}
	public static final class UserTopButton {
		private static final String E = "快速按钮";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
	}
	public static final class DataDict {
		private static final String E = "数据字典";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
	}
	public static final class Role {
		private static final String E = "角色";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String SAVE_FAILURE_DUPLICATED_NAME = E+"名称已使用";
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
	}
	
	public static final class Org {
		private static final String E = "组织";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String SAVE_FAILURE_DUPLICATED_NAME = E+"名称已使用";
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
	}
	
	public static final class App {
		private static final String E = "应用";
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UNLOAD_FAILURE = E+"卸载"+FAILURE;
		public static final String CORE_CANT_UNLOAD = "核心管理不能卸载";
	}
	
	public static final class OperationLog {
		private static final String E = "操作日志";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
	}
	public static final class RoleAuthorityRef {
		private static final String E = "角色权限配置";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
	}
	public static final class UserRoleRef {
		private static final String E = "用户角色配置";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
	}
	public static final class DesktopItem {
		private static final String E = "工作台模块";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
	}
	public static final class RoleDesktop {
		private static final String E = "角色工作台配置";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
	}
	public static final class Countersign {
		private static final String E = "会签单";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
	}
	public static final class ContactAtt {
		private static final String E = "联系单附件";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
	}
	public static final class Corporation {
		private static final String E = "集团公司";
		public static final String DELETE_SUCCESS = E+DELETE+SUCCESS;
		public static final String DELETE_FAILURE = E+DELETE+FAILURE;
		public static final String SAVE_SUCCESS = E+SAVE+SUCCESS;
		public static final String SAVE_FAILURE = E+SAVE+FAILURE;
		public static final String LOAD_SUCCESS = E+LOAD+SUCCESS;
		public static final String LOAD_FAILURE = E+LOAD+FAILURE;
		public static final String UPDATE_SUCCESS = E+UPDATE+SUCCESS;
		public static final String UPDATE_FAILURE = E+UPDATE+FAILURE;
	}
}
