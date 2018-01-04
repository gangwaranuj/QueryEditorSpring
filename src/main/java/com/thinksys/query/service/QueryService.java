package com.thinksys.query.service;

import java.util.List;

import com.thinksys.query.bean.QueryBean;
import com.thinksys.query.model.Column;
import com.thinksys.query.util.JsonResponse;
import com.thinksys.query.util.ResponseMessage;

public interface QueryService {

	
	public JsonResponse<String> fetchTablesName();
	
	public JsonResponse<Column> fetchTableColumns(String tablename);
	
	public JsonResponse<List> findTableData(String query);
	
	public ResponseMessage updateRow(QueryBean queryBean );
	
	public ResponseMessage saveRow(String query);
	
	public ResponseMessage deleteRow(QueryBean queryBean );
	
}
