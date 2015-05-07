package com.wiiy.core.action;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.json.annotations.JSON;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.core.dto.EasyUITreeNode;
import com.wiiy.core.dto.Module;
import com.wiiy.core.dto.ModuleAuthorityDto;
import com.wiiy.core.dto.ResourceDto;
import com.wiiy.core.entity.DesktopItem;
import com.wiiy.core.entity.Role;
import com.wiiy.core.entity.RoleAuthorityRef;
import com.wiiy.core.entity.RoleDesktop;
import com.wiiy.core.extensions.ResourceExtensions;
import com.wiiy.core.service.DesktopItemService;
import com.wiiy.core.service.RoleDesktopService;
import com.wiiy.core.service.RoleService;
import com.wiiy.core.service.export.ModuleService;
import com.wiiy.core.service.export.RoleAuthorityRefService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class RoleAction extends JqGridBaseAction<Role>{
	
	private Role role;
	
	private RoleService roleService;
	
	private RoleAuthorityRefService roleAuthorityRefService;
	
	private RoleDesktopService roleDesktopService;
	private DesktopItemService desktopItemService;
	
	private Result<Role> result;
	
	private Long id;
	
	private String ids;
	
	private ModuleService moduleService;
	
	private List<EasyUITreeNode> nodeList;
	
	private ResourceDto[] moduleAuthorities;
	
	private List<DesktopItem> desktopItemList;
	private List<DesktopItem> desktopItemList2;
	private List<RoleDesktop> roleDesktopList;
	
	//角色应用配置
	public String configRoleDesktop(){
		desktopItemList = desktopItemService.getList().getValue();
		roleDesktopList = roleDesktopService.getListByFilter(new Filter(RoleDesktop.class).eq("roleId", id)).getValue();
		if(roleDesktopList.size()>0 && roleDesktopList!=null){
			for (RoleDesktop roleDesktop : roleDesktopList) {
				desktopItemList.remove(roleDesktop.getDesktopItem());
			}
		}
		return "configRoleDesktop";
	}
	
	//保存应用配置
	public String submitConfigRoleDesktop(){
		String orders = ServletActionContext.getRequest().getParameter("orders");
		result = roleService.submitConfigRoleDesktop(id,ids,orders);
		return JSON;
	}
	
	public String execute() {
		return LIST;
	}
	
	public String save(){
		result = roleService.save(role);
		return JSON;
	}
	
	public String view(){
		role = roleService.getBeanById(id).getValue();
		return VIEW;
	}
	
	@JSON(serialize=false)
	public List<Module> getModuleList() {
		return moduleService.listModules();
	}
	
	public String create(){
		role = new Role();
		return EDIT;
	}
	
	public String edit(){
		role = roleService.getBeanById(id).getValue();
		return EDIT;
	}
	
	public String update(){
		result = roleService.update(role);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = roleService.deleteById(id);
		} else if(ids!=null){
			result = roleService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String editAuthorityConfig(){
		return "authorityRefs";
	}
	
	public String treeAuthorities() {
		if (id == null) {
			return "listJson";
		}
		List<ResourceDto> resourceList = ResourceExtensions.resourceList;
		
		//List<Module> moduleList = moduleService.listModules();
		Set<RoleAuthorityRef> roleAuthorityRefs = roleService.getBeanById(id).getValue().getAuthorityRefs();
		//nodeList = calculateNodeList(moduleList, roleAuthorityRefs);
		nodeList = calculateNodeList(resourceList, roleAuthorityRefs);
		return JSON;
	}

	
	private List<EasyUITreeNode> calculateNodeList(List<ResourceDto> resourceList,
			Set<RoleAuthorityRef> roleAuthorityRefs) {
		
		Set<String> grantedIdSet = populateGrandedIds(roleAuthorityRefs);
		List<EasyUITreeNode> ret = new ArrayList<EasyUITreeNode>();
		for (ResourceDto resourceDto : resourceList) {
			ret.add(parseModule(resourceDto, grantedIdSet));
		}
		return ret;
	}

	private Set<String> populateGrandedIds(
			Set<RoleAuthorityRef> roleAuthorityRefs) {
		
		Set<String> grantedAutoritySet = new HashSet<String>();
		
		for (RoleAuthorityRef roleAuthorityRef : roleAuthorityRefs) {
			//String authorityId = buildGlobalId(roleAuthorityRef);
			String authorityId = roleAuthorityRef.getAuthorityId();
			grantedAutoritySet.add(authorityId);
		}
		return grantedAutoritySet;
	}

	private EasyUITreeNode parseModule(ResourceDto resourceDto, Set<String> grantedAutoritySet) {
		
		EasyUITreeNode node = new EasyUITreeNode();
		
		node.setId(resourceDto.getIdSpace()+"_"+resourceDto.getType());
		
		node.setText(resourceDto.getName());
		
		if(resourceDto.getChildren()==null || resourceDto.getChildren().size()==0){
			node.setChecked(grantedAutoritySet.contains(resourceDto.getIdSpace()));
		}
		
		List<EasyUITreeNode> children = parseMenus(resourceDto.getChildren(), grantedAutoritySet);
		
		//children.addAll(parseOperations(module.getOperationList(), grantedAutoritySet));

		if (children != null && children.size() > 0) {
			node.setChildren(children);
		}
		
		return node;
	}

	private List<EasyUITreeNode> parseMenus(List<ResourceDto> menus, Set<String> grantedAutoritySet) {
		
		if (menus == null || menus.size() == 0) {
			return new ArrayList<EasyUITreeNode>();
		}
		
		List<EasyUITreeNode> ret = new ArrayList<EasyUITreeNode>();
		for (ResourceDto menu : menus) {
			EasyUITreeNode node = new EasyUITreeNode();
			node.setId(menu.getIdSpace()+"_"+menu.getType());
			node.setText(menu.getName());
			
			if(menu.getChildren()==null || menu.getChildren().size()==0){
				node.setChecked(grantedAutoritySet.contains(menu.getIdSpace()));
			}
			List<EasyUITreeNode> children = new ArrayList<EasyUITreeNode>();
			children.addAll(parseMenus(menu.getChildren(), grantedAutoritySet));
			//children.addAll(parseOperations(menu.getOperationList(), grantedAutoritySet));
			if (children.size() > 0) {
				node.setChildren(children);
			}
			ret.add(node);
		}
		return ret;
	}

	/*private List<EasyUITreeNode> parseOperations(
			List<Operation> operationList, Set<String> grantedAutoritySet) {
		
		if (operationList == null || operationList.size() == 0) {
			return new ArrayList<EasyUITreeNode>();
		}
		
		List<EasyUITreeNode> ret = new ArrayList<EasyUITreeNode>();
		for (Operation operation: operationList) {
			EasyUITreeNode node = new EasyUITreeNode();
			node.setId(
					AuthorityType.OPERATION.toString() + "_" + 
							operation.getModule().getId() + "_" + operation.getId());
			node.setText(operation.getName());
			node.setChecked(grantedAutoritySet.contains(node.getId()));
			ret.add(node);
		}
		
		return ret;
	}
*/
	public String saveAuthorityConfig(){
		result = roleAuthorityRefService.saveAuthorityRefs(id, moduleAuthorities);
		roleAuthorityRefService.refreshAuthorityRefs(id);
		return JSON;
	}
	

	public String refreshRoleAuthorityRefs(){
		result = roleAuthorityRefService.refreshAuthorityRefs(id);
		return JSON;
	}

	public String list(){
		return refresh(new Filter(Role.class));
	}

	@Override
	protected List<Role> getListByFilter(Filter fitler) {
		return roleService.getListByFilter(fitler).getValue();
	}
	public ResourceDto[] getModuleAuthorities() {
		return moduleAuthorities;
	}

	public List<EasyUITreeNode> getNodeList() {
		return nodeList;
	}

	public void setRoleAuthorityRefService(
			RoleAuthorityRefService roleAuthorityRefService) {
		this.roleAuthorityRefService = roleAuthorityRefService;
	}

	public void setModuleAuthorities(ResourceDto[] moduleAuthorities) {
		this.moduleAuthorities = moduleAuthorities;
	}


	public void setModuleService(ModuleService moduleService) {
		this.moduleService = moduleService;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getId() {
		return id;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public Result<Role> getResult() {
		return result;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}
	public void setRoleDesktopService(RoleDesktopService roleDesktopService) {
		this.roleDesktopService = roleDesktopService;
	}
	public void setDesktopItemService(DesktopItemService desktopItemService) {
		this.desktopItemService = desktopItemService;
	}
	public List<DesktopItem> getDesktopItemList() {
		return desktopItemList;
	}
	public List<DesktopItem> getDesktopItemList2() {
		return desktopItemList2;
	}
	public List<RoleDesktop> getRoleDesktopList() {
		return roleDesktopList;
	}
	public void setRoleDesktopList(List<RoleDesktop> roleDesktopList) {
		this.roleDesktopList = roleDesktopList;
	}
	
}
