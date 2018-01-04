package com.thinksys.query.model;

public class Employee {

	private int id;
	private String browser_name;
	private String token_id;
	
	
	public String getToken_id() {
		return token_id;
	}
	public void setToken_id(String token_id) {
		this.token_id = token_id;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getBrowser_name() {
		return browser_name;
	}
	public void setBrowser_name(String browser_name) {
		this.browser_name = browser_name;
	}
	
	
	
}
