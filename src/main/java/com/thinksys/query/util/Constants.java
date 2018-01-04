package com.thinksys.query.util;

public interface Constants {

	
	int ERROR_CODE_UNKNOWN = 520;
	int ERROR_CODE_INVALID = 206;
	int SUCCESS_CODE = 200;
	String SUCCESS = "Success";
	String ERROR = "ERROR";
	String SELECT_ALL_TABLE="SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_type='BASE TABLE'";
    String SELECT_TABLE_COLUMNS="SELECT column_name,data_type ,character_maximum_length ,column_default FROM information_schema.columns WHERE table_schema = 'public' AND table_name = :table_name"; 
    String SELECT_ALL_TABLE_DATA="SELECT :column_names FROM :table_name";
}