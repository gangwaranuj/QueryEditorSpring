package com.thinksys.query.model;

public class Table {

	private String tablename;

	public String getTablename() {
		return tablename;
	}

	public void setTablename(String tablename) {
		this.tablename = tablename;
	}

	@Override
	public String toString() {
		return "Table [tablename=" + tablename + "]";
	}
	 
}
