package com.wiiy.core.dto;

import java.util.ArrayList;
import java.util.List;

public class EasyUITreeNode {
	
	public static final String STATE_OPEN = "open";
	
	public static final String STATE_CLOSED = "closed";
	
	private String id;
	
	private String text;
	
	private String state;
	
	private Boolean checked;
	
	private String type;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	private List<Attribute> attributes;
	
	private List<EasyUITreeNode> children;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	
	public void setClosedState() {
		this.state = STATE_CLOSED;
	}

	public String getState() {
		if (state != null) return state;
		return children == null || children.size() == 0 ? null : STATE_CLOSED;
	}

	public Boolean getChecked() {
		return checked;
	}
	public void setChecked(Boolean checked) {
		this.checked = checked;
	}

	public List<Attribute> getAttributes() {
		return attributes;
	}
	public void setAttributes(List<Attribute> attributes) {
		this.attributes = attributes;
	}

	public void addAttribute(String name, String value) {
		if (attributes == null) {
			attributes = new ArrayList<Attribute>();
		}
		attributes.add(new Attribute(name, value));
	}

	public List<EasyUITreeNode> getChildren() {
		return children;
	}
	
	public void addChildren(EasyUITreeNode child) {
		if (children == null) {
			children = new ArrayList<EasyUITreeNode>();
		}
		children.add(child);
	}
	
	public void setChildren(List<EasyUITreeNode> children) {
		this.children = children;
	}
	
	public static Attribute attribute(String name, String value) {
		return new Attribute(name, value);
	}

	public static class Attribute {

		private String name;
		private String value;
		
		public Attribute(String name, String value) {
			this.name = name;
			this.value = value;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getValue() {
			return value;
		}
		public void setValue(String value) {
			this.value = value;
		}
	}
}
