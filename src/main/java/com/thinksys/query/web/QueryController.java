package com.thinksys.query.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.thinksys.query.bean.QueryBean;
import com.thinksys.query.model.Column;
import com.thinksys.query.service.QueryService;
import com.thinksys.query.util.JsonResponse;
import com.thinksys.query.util.ResponseMessage;


@RestController
public class QueryController {


	@Autowired
	QueryService queryService;


	@CrossOrigin(origins={"*"})
	@RequestMapping(value = "/tablesList", method = RequestMethod.GET)
	public JsonResponse<String> getTableList() {
		JsonResponse<String> jsonResponse=this.queryService.fetchTablesName();
		return jsonResponse;
	}

	@CrossOrigin(origins={"*"})
	@RequestMapping(value = "/columnsList/{table}", method = RequestMethod.GET)
	public JsonResponse<Column> getColoumnList(@PathVariable String table) {
		JsonResponse<Column> jsonResponse=this.queryService.fetchTableColumns(table);
		return jsonResponse;
	}
	
	@CrossOrigin(origins={"*"})
	@RequestMapping(value = "/findTableData/{query}", method = RequestMethod.GET)
	public JsonResponse<List> getAllData(@PathVariable String query) {
		
		JsonResponse<List> jsonResponse=this.queryService.findTableData(query);
		return jsonResponse;
	}
	
	@CrossOrigin(origins={"*"})
	@RequestMapping(value = "/updateRow", method = RequestMethod.POST)
	public ResponseMessage updateData(@RequestBody String requestJson) {
		
		Gson gson =new Gson();
		QueryBean queryBean = gson.fromJson(requestJson, QueryBean.class);
		ResponseMessage jsonResponse=this.queryService.updateRow(queryBean);
		return jsonResponse;
	}
	@CrossOrigin(origins={"*"})
	@RequestMapping(value = "/insertRow/{query}", method = RequestMethod.GET)
	public ResponseMessage InsertData(@PathVariable String query) {

		ResponseMessage jsonResponse=this.queryService.saveRow(query);
		return jsonResponse;
	}
	@CrossOrigin(origins={"*"})
	@RequestMapping(value = "/deleteRow", method = RequestMethod.POST)
	public ResponseMessage deleteData(@RequestBody String requestJson) {
		
		Gson gson =new Gson();
		QueryBean queryBean = gson.fromJson(requestJson, QueryBean.class);
		ResponseMessage jsonResponse=this.queryService.deleteRow(queryBean);
		return jsonResponse;
	}
	/*@CrossOrigin(origins={"*"})
	@RequestMapping(value = "/insertRow", method = RequestMethod.POST)
	public ResponseMessage InsertData(@RequestBody String requestJson) {
		
		Gson gson =new Gson();
		QueryBean queryBean = gson.fromJson(requestJson, QueryBean.class);
		ResponseMessage jsonResponse=this.queryService.saveRow(queryBean);
		return jsonResponse;
	}*/
}
