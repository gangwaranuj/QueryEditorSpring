package com.thinksys.query.model;

public class Column {

	private String column_name;
	private String data_type;
	private Integer character_maximum_length;
	private String column_default;
	public String getColumn_default() {
		return column_default;
	}
	public void setColumn_default(String column_default) {
		this.column_default = column_default;
	}
	public String getColumn_name() {
		return column_name;
	}
	public void setColumn_name(String column_name) {
		this.column_name = column_name;
	}
	public String getData_type() {
		return data_type;
	}
	public void setData_type(String data_type) {
		this.data_type = data_type;
	}
	public Integer getCharacter_maximum_length() {
		return character_maximum_length;
	}
	public void setCharacter_maximum_length(Integer character_maximum_length) {
		this.character_maximum_length = character_maximum_length;
	}
	@Override
	public String toString() {
		return "Column [column_name=" + column_name + ", data_type=" + data_type + ", character_maximum_length="
				+ character_maximum_length + "]";
	}
	

}
