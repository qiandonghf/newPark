package com.wiiy.core.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dto.EasyUITreeNode;
import com.wiiy.core.dto.ResourceDto;
import com.wiiy.core.entity.Role;
import com.wiiy.core.entity.RoleAuthorityRef;
import com.wiiy.core.entity.UserRoleRef;
import com.wiiy.core.entity.UserTopButton;
import com.wiiy.core.extensions.ResourceExtensions;
import com.wiiy.core.service.UserService;
import com.wiiy.core.service.UserTopButtonService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class UserTopButtonAction extends JqGridBaseAction<UserTopButton>{
	
	private UserTopButtonService userTopButtonService;
	private Result result;
	private UserTopButton userTopButton;
	private Long id;
	private String ids;
	private List<EasyUITreeNode> easyUITreeNode;
	private List<UserTopButton> userTopButtons;
	private List<ResourceDto> moduleList;
	private UserService userService;
	private List<ResourceDto> menuList;
	private Map<String,ResourceDto> newResourceMap = new HashMap<String, ResourceDto>();
	
	public String selectedTopButton(){
		List<UserTopButton> userTopButtons = userTopButtonService.getListByFilter(new Filter(UserTopButton.class).eq("user.id", CoreActivator.getSessionUser().getId())).getValue();
		for (UserTopButton userTopButton : userTopButtons) {
			result = userTopButtonService.delete(userTopButton);
		}
		String[] id = ids.split(",");
		Map<String,ResourceDto> resourceMap = ResourceExtensions.resourceMap;
		for (int i = 0; i < id.length; i++) {
			if(id[i].length()>0){
				String[] ide = id[i].split(";");
				ResourceDto resource = resourceMap.get(ide[0]);
				if("module".equals(resource.getType())){
					userTopButton = new UserTopButton();
					userTopButton.setModuleId(resource.getIdSpace());
					userTopButton.setUser(CoreActivator.getSessionUser());
					result = userTopButtonService.save(userTopButton);
				}else if("menu".equals(resource.getType())){
					userTopButton = new UserTopButton();
					userTopButton.setModuleId(ide[1]);
					userTopButton.setMenuId(resource.getIdSpace());
					userTopButton.setUser(CoreActivator.getSessionUser());
					result = userTopButtonService.save(userTopButton);
				}	
			}
		}
		if(result==null){
			result = Result.success("快速按钮保存成功");
		}
		return JSON;
	}
	
	public String userMenus(){
		//拿到用户已经有的
		List<UserTopButton> userTopButtons = userTopButtonService.getListByFilter(new Filter(UserTopButton.class).eq("user.id", CoreActivator.getSessionUser().getId())).getValue();
		Map<String, UserTopButton> userTopButtonsMap = new HashMap<String, UserTopButton>();
		for (UserTopButton userTopButton : userTopButtons) {
			if(userTopButton.getMenuId()!=null&&userTopButton.getMenuId()!=""){
				userTopButtonsMap.put(userTopButton.getMenuId(), userTopButton);
			}
		}
		//所有的
		Map<String,ResourceDto> resourceMap = ResourceExtensions.resourceMap;
		Set<UserRoleRef> roleRefs = userService.getUserRoleRefs(CoreActivator.getSessionUser().getId());
		
		newResourceMap = new HashMap<String, ResourceDto>();
		
		for (UserRoleRef userRoleRef : roleRefs) {
			if(userRoleRef!=null){
				Role role = userRoleRef.getRole();
				Set<RoleAuthorityRef> roleAuthorityRefs = role.getAuthorityRefs();
				for (RoleAuthorityRef roleAuthorityRef : roleAuthorityRefs) {
					if (roleAuthorityRef == null) continue;
					ResourceDto dto = resourceMap.get(String.valueOf(roleAuthorityRef.getAuthorityId()));
					if(dto!=null){
						formResourceMap(dto,resourceMap);
					}
				}
			}
		}
		List<ResourceDto> resourceList = new ArrayList<ResourceDto>();
		for (ResourceDto dto : newResourceMap.values()) {
			if(dto.getParentId()!=null && dto.getParentId().trim().length()>0){
			}else{
				resourceList.add(dto);
			}
		}
		try {
			if(easyUITreeNode==null){
				easyUITreeNode = new ArrayList<EasyUITreeNode>();
			}
			for (ResourceDto resource : resourceList) {
				if(!resource.getName().equals("企业服务平台") && !resource.getName().equals("基本功能")){
						EasyUITreeNode node = new EasyUITreeNode();
						node.setId(resource.getIdSpace());
						node.setText(resource.getName()+"<input type='hidden' value='"+resource.getIdSpace()+"'/>");
						childrenNode(node,resource,userTopButtonsMap,resource.getIdSpace());
						easyUITreeNode.add(node);
					}
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return JSON;
	}
	
	private void formResourceMap(ResourceDto dto,Map<String,ResourceDto> resourceMap){
		if(newResourceMap.get(dto.getIdSpace())==null){
			newResourceMap.put(dto.getIdSpace(), dto);
		}
		String parentId = dto.getParentId();
		if(parentId!=null && parentId.trim().length()>0){
			ResourceDto resourceDto = resourceMap.get(parentId);
			if(newResourceMap.get(parentId)!=null){
				if(newResourceMap.get(parentId).getResChildren()!=null){
					newResourceMap.get(parentId).getResChildren().add(dto);
				}else{
					Set<ResourceDto> children = new HashSet<ResourceDto>();
					children.add(dto);
					newResourceMap.get(parentId).setResChildren(children);
				}
			}else{
				if(resourceDto!=null){
					Set<ResourceDto> children = new HashSet<ResourceDto>();;
					children.add(dto);
					resourceDto.setResChildren(children);
					newResourceMap.put(parentId, resourceDto);
				}
			}
			formResourceMap(resourceDto,resourceMap);
		}
	}
	
	private void childrenNode(EasyUITreeNode node,ResourceDto resource,Map<String, UserTopButton> userTopButtonsMap,String mouldId){
		List<EasyUITreeNode> ret = new ArrayList<EasyUITreeNode>();
		Set<ResourceDto> children= resource.getResChildren();
		if(children!=null&&children.size()>0){
			for (ResourceDto r : children) {
				if(!"operation".equals(r.getType())){
					EasyUITreeNode n = new EasyUITreeNode();
					n.setId(r.getIdSpace());
					n.setText(r.getName()+"<input type='hidden' value='"+r.getIdSpace()+";"+mouldId+"'/>");
					if(r.getUris()!=null && r.getUris().trim().length()>0){
						if(userTopButtonsMap.get(r.getIdSpace())!=null){
							n.setChecked(true);
						}
					}
					if(r.getResChildren()!=null){
						childrenNode(n,r,userTopButtonsMap,mouldId);
					}
					ret.add(n);
				}
			}
		}
		node.setChildren(ret);
	}
		
	public List<EasyUITreeNode> getEasyUITreeNode() {
		return easyUITreeNode;
	}

	public String save(){
		result = userTopButtonService.save(userTopButton);
		return JSON;
	}
	
	public String view(){
		result = userTopButtonService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = userTopButtonService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		UserTopButton dbBean = userTopButtonService.getBeanById(userTopButton.getId()).getValue();
		BeanUtil.copyProperties(userTopButton, dbBean);
		result = userTopButtonService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = userTopButtonService.deleteById(id);
		} else if(ids!=null){
			result = userTopButtonService.deleteByIds(ids);
		}
		return JSON;
	}
	public String desktopList(){
		//已有的BUTTON
				userTopButtons = userTopButtonService.getListByFilter(new Filter(UserTopButton.class).eq("user.id", CoreActivator.getSessionUser().getId())).getValue();
				
				Map<String,ResourceDto> resourceMap = ResourceExtensions.resourceMap;
				//遍历
				
				for (UserTopButton userTopButton: userTopButtons) {
					if(userTopButton.getMenuId()!=null&&userTopButton.getModuleId()!=null){
						if(menuList==null){
							menuList = new ArrayList<ResourceDto>();
						}
						ResourceDto menu = resourceMap.get(userTopButton.getMenuId());
						Set<ResourceDto> childrenRes = null;
						if(menu != null){
							childrenRes = menu.getResChildren();
						}
								
						boolean flag = false;
						if(childrenRes!=null&&childrenRes.size()>0){
							for(ResourceDto r:childrenRes){
								if("menu".equals(r.getType())){
									flag = true;
								}
							}
						}
						if(menu != null && menu.getUris()!=null && menu.getUris().length()>0&&!flag){
							ResourceDto m = new ResourceDto();
							m.setIdSpace(menu.getIdSpace());
							m.setName(menu.getName());
							m.setParentId(menu.getParentId());
							m.setUri(menu.getUri());
							m.setUris(menu.getUris());
							m.setModuleId(userTopButton.getModuleId());
							if(menu.getIcon()!=null && menu.getIcon()!=""){
								String icon = menu.getIcon();
								m.setIcon(icon.replace("_min.", "."));
							}else{
								m.setIcon("/core/common/images/menuone.gif");
							}
							m.setUris(menu.getUri());
							menuList.add(m);
								}
							}
					if(userTopButton.getMenuId()==null&&userTopButton.getModuleId()!=null){
						if(moduleList==null){
							moduleList = new ArrayList<ResourceDto>();
						}
						moduleList.add(resourceMap.get(userTopButton.getModuleId()));
					}
				}
		return "desktopList";
	}
	public String list(){
		//已有的BUTTON
		userTopButtons = userTopButtonService.getListByFilter(new Filter(UserTopButton.class).eq("user.id", CoreActivator.getSessionUser().getId())).getValue();
		
		Map<String,ResourceDto> resourceMap = ResourceExtensions.resourceMap;
		//遍历
		
		for (UserTopButton userTopButton: userTopButtons) {
			if(userTopButton.getMenuId()!=null&&userTopButton.getModuleId()!=null){
				if(menuList==null){
					menuList = new ArrayList<ResourceDto>();
				}
				ResourceDto menu = resourceMap.get(userTopButton.getMenuId());
				Set<ResourceDto> childrenRes = null;
				if(menu != null){
					childrenRes = menu.getResChildren();
				}
						
				boolean flag = false;
				if(childrenRes!=null&&childrenRes.size()>0){
					for(ResourceDto r:childrenRes){
						if("menu".equals(r.getType())){
							flag = true;
						}
					}
				}
				if(menu != null && menu.getUris()!=null && menu.getUris().length()>0&&!flag){
					ResourceDto m = new ResourceDto();
					m.setIdSpace(menu.getIdSpace());
					m.setName(menu.getName());
					m.setParentId(menu.getParentId());
					m.setUri(menu.getUri());
					m.setUris(menu.getUris());
					m.setModuleId(userTopButton.getModuleId());
					if(menu.getIcon()!=null && menu.getIcon()!=""){
						String icon = menu.getIcon();
						m.setIcon(icon.replace("_min.", "."));
					}else{
						m.setIcon("/core/common/images/menuone.gif");
					}
					m.setUris(menu.getUri());
					menuList.add(m);
						}
					}
			if(userTopButton.getMenuId()==null&&userTopButton.getModuleId()!=null){
				if(moduleList==null){
					moduleList = new ArrayList<ResourceDto>();
				}
				moduleList.add(resourceMap.get(userTopButton.getModuleId()));
			}
		}
		return LIST;
	}
	@Override
	protected List<UserTopButton> getListByFilter(Filter fitler) {
		return userTopButtonService.getListByFilter(fitler).getValue();
	}
	
	
	public UserTopButton getUserTopButton() {
		return userTopButton;
	}

	public void setUserTopButton(UserTopButton userTopButton) {
		this.userTopButton = userTopButton;
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

	public void setUserTopButtonService(UserTopButtonService userTopButtonService) {
		this.userTopButtonService = userTopButtonService;
	}
	
	public Result getResult() {
		return result;
	}
	public List<EasyUITreeNode> getModlues() {
		return easyUITreeNode;
	}

	public void setModlues(List<EasyUITreeNode> easyUITreeNode) {
		this.easyUITreeNode = easyUITreeNode;
	}

	public List<UserTopButton> getUserTopButtons() {
		return userTopButtons;
	}

	public void setUserTopButtons(List<UserTopButton> userTopButtons) {
		this.userTopButtons = userTopButtons;
	}
	public List<ResourceDto> getModuleList() {
		return moduleList;
	}

	public void setModuleList(List<ResourceDto> moduleList) {
		this.moduleList = moduleList;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public List<ResourceDto> getMenuList() {
		return menuList;
	}

	public void setMenuList(List<ResourceDto> menuList) {
		this.menuList = menuList;
	}

}
