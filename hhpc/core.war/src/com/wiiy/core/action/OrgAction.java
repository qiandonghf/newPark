package com.wiiy.core.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wiiy.commons.action.BaseAction;
import com.wiiy.core.dto.EasyUITreeNode;
import com.wiiy.core.entity.Org;
import com.wiiy.core.service.OrgService;
import com.wiiy.hibernate.Result;

public class OrgAction extends BaseAction {
	
	private OrgService orgService;
	
	private List<Org> orgTree;
	
	private Org srcOrg;
	
	private Org org;
	
	private String ids;
	
	private Result<Org> result;
	
	private List<EasyUITreeNode> nodeList;

    public String execute() {
//    	orgTree = orgService.getOrgTree().getValue();
        return LIST;
    }

    public List<EasyUITreeNode> getNodeList() {
		return nodeList;
	}

	public String select() {
    	orgTree = orgService.getOrgTree().getValue();
        return SELECT;
    }

    public String createChild() {

        Org parent = orgService.getBeanById(srcOrg.getId()).getValue();

        org = new Org();

        org.setParent(parent);

        return EDIT;
    }

    public String createSibling() {

        Org siblingOrg = orgService.getBeanById(srcOrg.getId()).getValue();

        org = new Org();

        org.setParent(siblingOrg.getParent());

        org.setOrderCode(siblingOrg.getOrderCode());

        return EDIT;
    }
    
public String treeOrgsSelf() {
    	
    	nodeList = new ArrayList<EasyUITreeNode>();
    	
    	Map<Long, EasyUITreeNode> nodeMap = new HashMap<Long, EasyUITreeNode>(); 
    	
    	List<Org> orgList = orgService.getOrgTree().getValue();
    	
    	for (Org org : orgList) {
    		if("企业部门".equals(org.getName())){
    			continue;
    		}
    		EasyUITreeNode node = new EasyUITreeNode();
    		node.setId(org.getId().toString());
    		node.setText(org.getName());
    		
    		Org parentOrg = org.getParent();
    		if (parentOrg != null) {
    			EasyUITreeNode parentNode = nodeMap.get(parentOrg.getId());
    			parentNode.addChildren(node);
    		} else {
    			nodeList.add(node);
    		}
    		
    		nodeMap.put(org.getId(), node);
    	}
    	
    	return "listJson";
    }

    public String treeOrgs() {

    	nodeList = new ArrayList<EasyUITreeNode>();
    	
    	Map<Long, EasyUITreeNode> nodeMap = new HashMap<Long, EasyUITreeNode>(); 
    	
    	List<Org> orgList = orgService.getOrgTree().getValue();
    	
    	for (Org org : orgList) {
    		/*if("企业部门".equals(org.getName())){
    			continue;
    		}*/
    		EasyUITreeNode node = new EasyUITreeNode();
			node.setId(org.getId().toString());
			node.setText(org.getName());
			
			Org parentOrg = org.getParent();
			if (parentOrg != null) {
				EasyUITreeNode parentNode = nodeMap.get(parentOrg.getId());
				parentNode.addChildren(node);
			} else {
				nodeList.add(node);
			}
			
			nodeMap.put(org.getId(), node);
    	}
    	
    	return "listJson";
    }
    
	public String edit() {
    	org = orgService.getBeanById(srcOrg.getId()).getValue();
        return EDIT;
    }

    public String save() {
        result = orgService.saveOrUpdateOrg(org);
        if(result.getValue().getParent().getId()==null) {
        	result.getValue().setParent(null);
        }
        return JSON;
    }

    public String delete() {
    	if (ids != null) {
            result = orgService.deleteByIds(ids);
    	} else {
    		result = orgService.deleteById(srcOrg.getId());
    	}
        return JSON;
    }

	public Org getSrcOrg() {
		return srcOrg;
	}

	public void setSrcOrg(Org srcOrg) {
		this.srcOrg = srcOrg;
	}

	public Org getOrg() {
		return org;
	}

	public void setOrg(Org org) {
		this.org = org;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public List<Org> getOrgTree() {
		return orgTree;
	}

	public Result<Org> getResult() {
		return result;
	}

	public void setOrgService(OrgService orgService) {
		this.orgService = orgService;
	}
}
