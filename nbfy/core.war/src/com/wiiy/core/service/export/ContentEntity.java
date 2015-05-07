package com.wiiy.core.service.export;

public class ContentEntity {
	
	//唯一标示
	private String id;
	//
	private String url;
	
	private String title;
	
	private String location;
	
    private String content;

    public ContentEntity(String id, String url, String title, String location,
			String content) {
		super();
		this.id = id;
		this.url = url;
		this.title = title;
		this.location = location;
		this.content = content;
	}

	public ContentEntity() {
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
    
}
