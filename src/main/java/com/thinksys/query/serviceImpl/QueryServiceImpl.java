package com.thinksys.query.serviceImpl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinksys.query.bean.QueryBean;
import com.thinksys.query.dao.QueryDao;
import com.thinksys.query.model.Column;
import com.thinksys.query.service.QueryService;
import com.thinksys.query.util.Constants;
import com.thinksys.query.util.JsonResponse;
import com.thinksys.query.util.Response;
import com.thinksys.query.util.ResponseMessage;

@Service
public class QueryServiceImpl implements QueryService{
	private Logger logger = LoggerFactory.getLogger(QueryServiceImpl.class);

	@Autowired
	QueryDao queryDao;


	@SuppressWarnings("unchecked")
	public JsonResponse<String> fetchTablesName() {

		JsonResponse<String> jsonResponse=null;
		try{
			Response response =	this.queryDao.findTables();
			if(response.getStatus()){
				List<String> list =(List<String>) response.getData();
				jsonResponse=new JsonResponse<String>(Constants.SUCCESS, list, list.size());
			}
		}catch(Exception e){
			this.logger.info("TableList " + e.getMessage());
		}
		return jsonResponse;
	}


	@SuppressWarnings("unchecked")
	public JsonResponse<Column> fetchTableColumns(String tablename) {
		JsonResponse<Column> jsonResponse=null;
		try{
			Response response =	this.queryDao.findColumns(tablename);
			if(response.getStatus()){
				List<Column> list =(List<Column>) response.getData();
				jsonResponse=new JsonResponse<Column>(Constants.SUCCESS, list, list.size());
			}
		}
		catch(Exception e){
			this.logger.info("TablecolumnList " + e.getMessage());
		}
		return jsonResponse;
	}


	@SuppressWarnings({ "rawtypes", "unchecked" } )
	public JsonResponse<List> findTableData(String queryString) {
		JsonResponse jsonResponse=new JsonResponse<List>();
		try{
			
			Response response =	this.queryDao.findData(queryString);
			if(response.getStatus()){
				List list = response.getData();
				jsonResponse=new JsonResponse(Constants.SUCCESS, list, list.size());
				
			}
			else{
				jsonResponse=new JsonResponse(Constants.SUCCESS, "No Row Selected ");
				jsonResponse.setMessage(response.getMessage());
			}
		}catch(Exception e){
			this.logger.info("TableList " + e.getMessage());
		}
		return jsonResponse;
	}


	@Override
	public ResponseMessage updateRow(QueryBean queryBean) {
		ResponseMessage jsonResponse=null;
		try{
			String queryString =queryBean.getQuery();
			Response response =	this.queryDao.updateRowData(queryString);
			if(response.getIntegerResult()>0){
				int count = response.getIntegerResult();
				jsonResponse=new ResponseMessage(Constants.SUCCESS_CODE,"SuccessFully Update" +count +" "+"row");
			}
			else{
				jsonResponse=new ResponseMessage(Constants.SUCCESS_CODE,"No Row Updated");
			}
		}catch (Exception e) {
			jsonResponse = new ResponseMessage(Constants.ERROR_CODE_UNKNOWN, e.getMessage());
			logger.error(" updateRow  ::  " , e);
		}
		return jsonResponse;
	}


	@Override
	public ResponseMessage saveRow(String query) {
		ResponseMessage jsonResponse=null;
		try{
			Response response =	this.queryDao.saveData(query);
			if(response.getIntegerResult()>0){
				int count = response.getIntegerResult();
				jsonResponse=new ResponseMessage(Constants.SUCCESS_CODE,"SuccessFully Inserted " +"  "+count +" "+"row");
			}
			else{
				jsonResponse=new ResponseMessage(Constants.SUCCESS_CODE," No Row Inserted ");
			}
		}catch (Exception e) {
			jsonResponse = new ResponseMessage(Constants.ERROR_CODE_UNKNOWN, e.getMessage());
			logger.error(" insertRow ::  " , e);
		}
		return jsonResponse;
	}


	@Override
	public ResponseMessage deleteRow(QueryBean queryBean) {
		ResponseMessage jsonResponse=null;
		try{
			String queryString =queryBean.getQuery();
			Response response =	this.queryDao.deleteRowData(queryString);
			if(response.getIntegerResult()>0){
				int count = response.getIntegerResult();
				jsonResponse=new ResponseMessage(Constants.SUCCESS_CODE,"SuccessFully deleted " + " "+count +" "+"row");
			}
			else{
				jsonResponse=new ResponseMessage(Constants.SUCCESS_CODE,"No Row deleted");
			}
		}catch (Exception e) {
			jsonResponse = new ResponseMessage(Constants.ERROR_CODE_UNKNOWN, e.getMessage());
			logger.error(" deleteRow ::   " , e);
		}
		return jsonResponse;
	}


}
