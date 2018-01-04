package com.thinksys.query.daoImpl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.thinksys.query.dao.QueryDao;
import com.thinksys.query.model.Column;
import com.thinksys.query.util.Constants;
import com.thinksys.query.util.Response;

@Repository
public class QueryDaoImpl implements QueryDao{

	private Logger logger = LoggerFactory.getLogger(QueryDaoImpl.class);

	@Autowired
	JdbcTemplate jbdcTemplate;	

	@Autowired
	NamedParameterJdbcTemplate namedJdbcTemplate;

	@Override
	public Response findTables() {

		Response response = new Response();
		List<Map<String,Object>> tableList =  jbdcTemplate.queryForList(Constants.SELECT_ALL_TABLE);
		if(tableList.size()>0){
			response.setStatus(true);
			response.setData(tableList);
			logger.info(" Table List : "+tableList);
		}else{
			logger.info("Status "+Constants.SUCCESS);
			response.setStatus(false);
			logger.info("table list is blank");
		}
		return response;
	}


	@Override
	public  Response findColumns(String tablename) {

		Response response = new Response();
		/*List<Column> list =this.jbdcTemplate.query("SELECT column_name,data_type ,character_maximum_length FROM information_schema.columns WHERE table_schema = 'public' AND table_name ='firebase_detail'",
		 * new ResultSetExtractor<List<Column>>(){  
			@Override  
			public List<Column> extractData(ResultSet rs) throws SQLException,  
			DataAccessException {  

				List<Column> list=new ArrayList<Column>();  
				while(rs.next()){  
					Column e=new Column();  
					e.setColumn_name(rs.getString(1));
					e.setData_type(rs.getString(2));
					e.setCharacter_maximum_length((Integer)rs.getInt(3));
					list.add(e);  
				}  
				return list;  
			}  
		});  */
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("table_name", tablename);
		List<Column> list=	this.namedJdbcTemplate.query(Constants.SELECT_TABLE_COLUMNS.toString(), map, new RowMapper<Column>() {
			public Column mapRow(ResultSet rs, int rowNum) throws SQLException {
				
				Column column = new Column();
				column.setColumn_default(rs.getString(4));
				column.setColumn_name(rs.getString(1));
				column.setData_type(rs.getString(2));
				column.setCharacter_maximum_length((Integer)rs.getInt(3));
				return column;
			}
		});
		System.out.println(list);
		if(list.size()>0){
			response.setStatus(true);
			response.setData(list);
			logger.info(" Column List : "+list);
		}else{
			logger.info("Status "+Constants.SUCCESS);
			response.setStatus(false);
			logger.info("table list is blank");
		}
		return response;
	}


	@Override
	public Response findData(String query) {

		Response response = new Response();
		List<Map<String,Object>> list =  jbdcTemplate.queryForList(query);

		if(list.size()>0){
			response.setStatus(true);
			response.setData(list);
			logger.info(" Table data : "+list);
		}else{
			logger.info("Status "+Constants.SUCCESS);
			response.setStatus(false);
			response.setMessage("table have no data");
			logger.info("table have no row");
		}
		return response;
	}


	@Override
	public Response updateRowData(String queryString) {

		Response respone = new Response();

		int i = this.jbdcTemplate.update(queryString);
		if(i>0){
			respone.setIntegerResult(i);
			respone.setMessage("Successfully Update "+i+" Row " +" ");
			respone.setStatus(true);
			logger.info("status :"+Constants.SUCCESS +" "+ i+" Row Updated  ");
		}else{
			respone.setStatus(false);
			logger.info(" no row Updated");
		}
		return respone;
	}

    @Override
	public Response saveData(String queryString) {

		Response respone = new Response();
		int i =this.jbdcTemplate.update(queryString);
		if(i>0){
			respone.setIntegerResult(i);
			respone.setMessage("Successfully insert "+i+" Row " +" ");
			respone.setStatus(true);
			logger.info("status :"+Constants.SUCCESS +" "+ i+" Row Inserted  ");
		}else{
			respone.setStatus(false);
			logger.info(" no row Inserted");
		}
		return respone;
	}

	@Override
	public Response deleteRowData(String queryString) {
		Response respone = new Response();

		int i = this.jbdcTemplate.update(queryString);
		if(i>0){
			respone.setIntegerResult(i);
			respone.setMessage("Successfully deleted "+i+" Row " +" ");
			respone.setStatus(true);
			logger.info("status :"+Constants.SUCCESS +" "+ i+" Row delete  ");
		}else{
			respone.setStatus(false);
			logger.info(" no row Updated");
		}
		return respone;
	}
}
