package com.thinksys.query.dao;

import com.thinksys.query.util.Response;

public interface QueryDao {

	
	public Response findTables();
	
	public Response findColumns(String tablename);
	
	public Response findData(String queryString);
	
	public Response updateRowData(String queryString);
	
	public Response saveData(String queryString);
	

	public Response deleteRowData(String queryString);
}
