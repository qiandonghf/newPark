package com.wiiy.core.action;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ModelDriven;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.preferences.enums.UserTypeEnum;
import com.wiiy.core.dto.EasyUITreeNode;
import com.wiiy.core.entity.Org;
import com.wiiy.core.entity.Role;
import com.wiiy.core.entity.User;
import com.wiiy.core.entity.UserRoleRef;
import com.wiiy.core.preferences.R;
import com.wiiy.core.service.OrgService;
import com.wiiy.core.service.RoleService;
import com.wiiy.core.service.UserService;
import com.wiiy.core.util.Cipher;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class UserAction extends JqGridBaseAction<User> implements ModelDriven<User> {
	
	private OrgService orgService;
	private UserService userService;
	private RoleService roleService;
	private Result<?> result;
	private User user;
	private Long id;
	private String groupName;
	private Long objType;
	private String ids;
	private List<Role> roleList;
	private Map<Long, Long> selectedRoleIds;
	private List<EasyUITreeNode> nodeList;
	private List<User> selectedUsers;
	private UserTypeEnum userType;//用户类型
	
	private int selType=0;//0单选 1多选
	
	private int type = 0;//0普通，1 floatbox window弹层
	
	public String loadUserByOrgId(){
    	Filter filter = new Filter(User.class);
    	List<Org> orgList = orgService.getListByFilter(new Filter(Org.class).eq("parent.id", id)).getValue();
    	if(orgList!=null&&orgList.size()>0){
    		Long[] ids = new Long[orgList.size()+1];
    		ids[0] = id;
        	for (int i = 0; i < orgList.size(); i++) {
    			ids[i+1] = orgList.get(i).getId();
    		}
    		filter.in("org.id", ids);
    	}else{
    		filter.eq("org.id", id);
    	}
    	return refresh(filter);
    }
	public String selectSelf(){
		selType=0;
		if (id != null) {
			user = userService.getBeanById(id).getValue();
		}
		return "singleSelectSelf";
	}

	public String loadUsersByOrgId(){
		Filter filter = new Filter(User.class);
    	List<Org> orgList = orgService.getListByFilter(new Filter(Org.class).eq("parent.id", id)).getValue();
    	if(orgList!=null&&orgList.size()>0){
    		Long[] ids = new Long[orgList.size()+1];
    		ids[0] = id;
        	for (int i = 0; i < orgList.size(); i++) {
    			ids[i+1] = orgList.get(i).getId();
    		}
    		filter.in("org.id", ids);
    	}else{
    		filter.eq("org.id", id);
    	}
		return refresh(filter.ne("entityStatus", EntityStatus.LOCKED));
	}

	
	public List<User> getSelectedUsers() {
		return selectedUsers;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	public List<EasyUITreeNode> getNodeList() {
		return nodeList;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public void setOrgService(OrgService orgService) {
		this.orgService = orgService;
	}

	public String execute() {
		return LIST;
	}
	
	public String save(){
		user.setRoleRefs(convert2Set(user.getRoleRefList()));
		user.setPassword(Cipher.md5("123456"));
		result = userService.save(user);
		return JSON;
	}
	
	private Set<UserRoleRef> convert2Set(List<UserRoleRef> roleRefs) {
		
		if (roleRefs == null || roleRefs.size() == 0) return new HashSet<UserRoleRef>();
		
		Set<UserRoleRef> ret = new HashSet<UserRoleRef>();
		for (UserRoleRef userRoleRef : roleRefs) {
			ret.add(userRoleRef);
		}
		return ret;
	}

	public String view(){
		user = userService.getBeanById(id).getValue();
		return VIEW;
	}
	
	public String create(){
		/*if(userType != null && userType.equals(UserTypeEnum.Association)){
			user = new User();
			user.setUserType(userType);
		}else{*/
			user = new User();
		/*}*/
		roleList = roleService.getList().getValue();
		return EDIT;
	}
	
	public String select(){
		selType=0;
		if (id != null) {
			user = userService.getBeanById(id).getValue();
		}
		return "singleSelect";
	}
	public String select2(){
		selType=1;
		if (ids != null && ids.trim().length() > 0) {
				Set<Long> idSet = splitIds(ids);
				Filter filter = new Filter(User.class);
				filter.in("id", idSet.toArray(new Long[idSet.size()])).eq("entityStatus",EntityStatus.NORMAL);
				selectedUsers = userService.getListByFilter(filter).getValue();
		}
		return "multiSelect";
			
	}
	
	public String getUsers(){
		if (ids != null && ids.trim().length() > 0) {
				Set<Long> idSet = splitIds(ids);
				Filter filter = new Filter(User.class);
				filter.in("id", idSet.toArray(new Long[idSet.size()])).eq("entityStatus",EntityStatus.NORMAL);
				result = userService.getListByFilter(filter);
		}
		return JSON;
			
	}
	
    private Set<Long> splitIds(String ids2) {
    	
    	if (ids2 == null) return new HashSet<Long>();
    	
		Set<Long> ret = new HashSet<Long>();
		
		String[] idArray = ids2.split("\\,");
		
		for (String id : idArray) {
			try {
				ret.add(Long.valueOf(id.trim()));
			} catch (NumberFormatException e) {
			}
		}
		return ret;
	}

	public String edit(){
		user = userService.getBeanById(id).getValue();
		roleList = roleService.getList().getValue();
		Set<UserRoleRef> roleRefs = user.getRoleRefs();
		selectedRoleIds = new HashMap<Long, Long>();
		for (UserRoleRef userRoleRef : roleRefs) {
			if (userRoleRef == null) continue;
			Long selectedRoleId = userRoleRef.getRole().getId();
			selectedRoleIds.put(selectedRoleId, selectedRoleId);
		}
		return EDIT;
	}
	
	public String update(){
		user.setRoleRefs(convert2Set(user.getRoleRefList()));
		try {
			result = userService.update(user);
		} catch (Exception e) {
			result = Result.failure(R.User.SAVE_FAILURE_DUPLICATED_NAME);
		}
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = userService.deleteById(id);
		} else if(ids!=null){
			result = userService.deleteByIds(ids);
		}
		return JSON;
	}
	public String resetPwd(){
		if(id!=null){
			result = userService.resetPwd(id);
		}
		return JSON;
	}
	public String importCard() {
		result = userService.importCard(ids);
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(User.class).createAlias("org", "org").ne("entityStatus", EntityStatus.LOCKED));
	}
	public String listSelf(){
		return refresh(new Filter(User.class).createAlias("org", "org").ne("userType", UserTypeEnum.Customer));
	}
	
	@Override
	protected List<User> getListByFilter(Filter fitler) {
		return userService.getListByFilter(fitler).getValue();
	}
	
	
	public User getUser() {
		return user;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	public Result<?> getResult() {
		return result;
	}
	

	public List<Role> getRoleList() {
		return roleList;
	}

	
	public Map<Long, Long> getSelectedRoleIds() {
		return selectedRoleIds;
	}

	@Override
	public User getModel() {
		String userId = ServletActionContext.getRequest().getParameter("user.id");
		if (userId != null) {
			user = userService.getBeanById(Long.valueOf(userId)).getValue();
			if (user != null) {
				user.getRoleRefs().clear();
				user.setOrg(new Org());
				return user;
			} 
		}
		
		return user;
	}

	public int getSelType() {
		return selType;
	}

	public void setSelType(int selType) {
		this.selType = selType;
	}

	public UserTypeEnum getUserType() {
		return userType;
	}

	public void setUserType(UserTypeEnum userType) {
		this.userType = userType;
	}
	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
	public Long getObjType() {
		return objType;
	}
	public void setObjType(Long objType) {
		this.objType = objType;
	}

}
