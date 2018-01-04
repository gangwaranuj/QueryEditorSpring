
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<style>
body {
	margin: 0px;
	padding: 0
}

.topbar {
	text-align: right;
	background: #f2f2f2;
	padding: 10px;
	border: 1px solid #e2e2e2;
	box-shadow: 5px 4px 3px #f3ebeb;
}

.topbar .logout-btn {
	background: #0cc5d0;
	color: #fff;
	text-decoration: none;
	padding: 5px 10px;
	border-radius: 3px;
	font-size: 13px;
}

.checklist {
	background: #c7c7c7;
	padding: 10px;
	font-size: 15px;
	text-transform: uppercase;
}

.checklist label {
	margin: 12px;
}

.pull-left {
	float: left;
}

.pull-right {
	float: right;
}

.contain {
	border: 1px solid #e2e2e2;
	float: left;
	width: 100%;
	margin-top: 10px !important;
}

#checkboxes {
	float: left;
}

#checkboxes div {
	float: left;
	margin: 10px;
	text-align: left;
}

#submitbutton {
	float: right;
}
/* #submitbutton {
	top: 45px;
	position: relative;
	float: left;
} */
button {
	background: #0cc5d0;
	color: #fff;
	text-decoration: none;
	padding: 8px 10px;
	border-radius: 3px;
	font-size: 13px;
	border: none;
	cursor: pointer;
}

p {
	padding: 0;
	margin: 0;
}

input[type="text"], select {
	background: #f2f2f2;
	border: 1px solid #e2e2e2;
	padding: 7px;
}

#select_col_Checkboxes {
	margin-bottom: 10px;
}

#select_col_Checkboxes div {
	float: left;
}

#whereConditionCheckboxes {
	float: left;
}

#columnDiv {
	margin-top: 10px;
}

.element-center, .contain {
	width: 50%;
	margin: auto;
	text-align: center;
	margin-top: 45px;
	float: none;
	display: table;
	padding: 10px;
}

table {
	width: 100%;
}

table th {
	background: #c7c7c7;
	color: #fff;
}

table td, th {
	padding: 7px 15px;
	border: 1px solid #e2e2e2;
}

#renderdata {
	margin-top: 20px;
	float: left;
	width: 100%;
}

#select_col_Checkboxes {
	float: left;
}
</style>
</head>
<body>
	<c:url value="/j_spring_security_logout" var="logoutUrl" />
	<form action="${logoutUrl}" method="post" id="logoutForm">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
	</form>
	<script>
		function formSubmit() {
			document.getElementById("logoutForm").submit();
		}
	</script>

	<c:if test="${pageContext.request.userPrincipal.name != null}">
		<div class="topbar">
			<b> Current User : ${pageContext.request.userPrincipal.name} | <a
				href="javascript:formSubmit()" class="logout-btn"> Logout</a>
			</b>
		</div>
	</c:if>

	<div class="checklist">
		<label><input type='checkbox' id="Check1"
			onclick='handleCheckBoxClick(this.value,this.id,this);'
			value="insert" onchange="">Insert</label> <label><input
			type='checkbox' id="Check2"
			onclick='handleCheckBoxClick(this.value,this.id);' value="update"
			onchange="">Update</label> <label><input type='checkbox'
			id="Check3" onclick='handleCheckBoxClick(this.value,this.id);'
			value="select" onchange="">Select</label>
		<c:if test="${pageContext.request.userPrincipal.name == 'admin'}">
			<label><input type='checkbox' id="Check4"
				onclick='handleCheckBoxClick(this.value,this.id);' value="delete"
				onchange="">Delete</label>
		</c:if>
	</div>
	<div style="margin: 20px 25px;">
		<div id="tableDiv" style="display: none;">
			<div class="element-center">
				<div class="pull-left" style="margin-right: 10px;">
					Table : <select name="table" id="table"
						onChange="columnListHandler(this.value)"><option
							value="Other">Select table.</option></select>
				</div>
				<div style="display: none;" id="limit" class="pull-right">
					limit:<input type="text" name="limit" id='limit_textbox' />
				</div>
				<div id="columnDiv" style="display: none;" class="pull-left">
					<input type="checkbox" onclick='showColumnCheckboxes();' id="sel">select
					column</input>
				</div>
			</div>
			<!-- <div  id ="search"> search <input type="text" name ="limit" id='search_textbox'	/></div>
			 -->
			<div style="clear: both"></div>
			<div class="contain">
				<div id="select_col_Checkboxes" style="display: none;"></div>
				<div id='whereConditionButton' style="display: none;">
					<button id="whereSubmit" onclick='whereConditionHandler()'>Conditions</button>
				</div>
				<div id="whereConditionCheckboxes" style="display: none;">
					<p>
						<a> Where : </a> <select name="conditionOperator"
							id="columnCondition"><option value="Other">Select
								column</option>
						</select> <a> &nbsp </a> <select name="Operator" id="Operators">
							<option value="Other">Select condition</option>
							<option value="=">'=' Equals to</option>
							<option value="<">'<' Less than</option>
							<option value="<=">'<=' Less than or Equals to</option>
							<option value=">">'>' Greater than</option>
							<option value=">=">'>=' Greater than or Equals to</option>
						</select> <a> &nbsp <input type="text" id='condt_textBox' name='user'
							placeHolder="Enter value" />
						</a>
					</p>
					<div id="deleteAction"></div>
				</div>
				<div id="submitbutton" style="display: none;">
					<button id="submit" onclick="submit()">submit</button>
				</div>
				<div id="renderdata"></div>
			</div>
		</div>
	</div>
	<script>
		/*****************global variables*************************/

		var user = '${pageContext.request.userPrincipal.name}';
		var divContainer = document.getElementById("renderdata");
		var selectColumnChildContainer = document
				.getElementById('select_col_Checkboxes');
		var columnCondition = document.getElementById('columnCondition');
		var buttonParent = document.getElementById('submitbutton');
		var searchcontainer = document.getElementById('search');
		var limitcontainer = document.getElementById('limit');
		var selectColumnParentContainer = '';
		var selectTableParent = '';
		var activeCheckboxIds = [];
		var tableColumnId = [];
		var textBoxValue = [];
		var columnArray = [];
		var tableContraints = {};
		var columnDataType = {};
		var requestJson = {};
		var responseMessage = '';
		var responseCode = '';
		var responseText = '';
		var tablename = '';
		var active = '';
		var query = '';
		var total = 0;
		var flag = 0;

		/*******************************************************/
		/***************** Ajax call ***********************/

		function service(_render, _url, _data) {
			var _request = new XMLHttpRequest();
			_request.onreadystatechange = function(_response) {
				if (_request.readyState === 4) {
					if (_request.status === 200) {
						responseText = this.responseText;
						responseData = JSON.parse(this.responseText);
						if (typeof _render === "function")
							_render()
					}
				}
			};
			if (_data) {
				_request.open('POST', _url, false);
				_request.send(_data);
			} else {
				_request.open('GET', _url, false);
				_request.send();
			}
		};

		/**************************************************/
		/*************************API's End Points ******************************/

		var api_urls = {
			tableList : 'http://localhost:8080/query/tablesList',
			columnList : 'http://localhost:8080/query/columnsList',
			findTableData : 'http://localhost:8080/query/findTableData',
			updateRow : 'http://localhost:8080/query/updateRow',
			insertRow : 'http://localhost:8080/query/insertRow',
			deleteRow:'http://localhost:8080/query/deleteRow'
		}
		/**************************************************/

		/**********************json data Sorting****************************/
		var sorting = function(a, b) {
			if (a.id > b.id) {
				return 1;
			} else if (a.id == b.id) {
				return 0;
			} else
				return -1;
		};

		/**************************************************/

		/****************find active checkboxes*********************/

		function findActiveCheckbox(_element_id) {
			var _ids = [];
			var checkedCbs = document.querySelectorAll(_element_id);
			for (var i = 0; i < checkedCbs.length; i++)
				_ids.push(checkedCbs[i].id);
			return _ids;
		}

		/******************Find Table Contraints And Column DataTypes****************************/
		var tableContraints = function() {
			tableContraints = {};
			columnDataType = {};
			columnArray = [];
			for (var i = 0; i < responseData.Records.length; i++) {
				tableContraints[responseData.Records[i].column_name] = responseData.Records[i].column_default;
				columnDataType[responseData.Records[i].column_name] = responseData.Records[i].data_type;
				columnArray[i] = responseData.Records[i].column_name
			}
		}

		/***********************************************************/

		/**********************handleCheckBoxClick*********************************/
		function handleCheckBoxClick(value, id, element) {
			var _authority = (user === 'admin') ? 4 : 3;
			for (var i = 1; i <= _authority; i++) {
				document.getElementById("Check" + i).checked = false;
			}
			document.getElementById('whereConditionCheckboxes').style.display = "none";
			selectColumnParentContainer = document.getElementById('columnDiv');
			selectTableParent = document.getElementById('tableDiv');
			buttonParent = document.getElementById('submitbutton');
			document.getElementById('renderdata').innerHTML = '';
			selectColumnParentContainer.style.display = "none";
			selectColumnChildContainer.style.display = "none"
			document.getElementById(id).checked = true;
			selectTableParent.style.display = "block"
			limitcontainer.style.display = "none"
			buttonParent.style.display = "none";
			active = value;
			tableListHandler();
		}

		/**************  *************/
		var data;
		var responseData = '';
		function tableListHandler() {
			var _tableList = function() {

				var _tableListContainer = document.getElementById('table');
				_tableListContainer.innerHTML = '';
				var _option = document.createElement('option');
				_option.value = 'others';
				_option.text = 'select table'
				_tableListContainer.appendChild(_option);
				for (var i = 0; i < responseData.Records.length; i++) {
					var _option = document.createElement('option');
					_option.value = responseData.Records[i].table_name;
					_option.text = responseData.Records[i].table_name;
					_tableListContainer.appendChild(_option);
					limitcontainer.style.display = "none";
				}
			};
			service(_tableList, api_urls.tableList, data);
		}
		/**********   column list   **********/

		function columnListHandler(tablename) {
			if ((active === 'update')) {
				document.getElementById('whereConditionCheckboxes').style.display = "none";
				buttonParent.style.display = "none";
				showColumnCheckboxes();
			}

			else if ((active === 'delete')) {
				document.getElementById('whereConditionCheckboxes').style.display = "none";
				buttonParent.style.display = "none";
				showColumnCheckboxes();

			} else if ((active === 'select')) {
				selectColumnParentContainer = document
						.getElementById('columnDiv');
				document.getElementById('whereConditionCheckboxes').style.display = "none";
				buttonParent.style.display = "none";
				divContainer.innerHTML = '';
				showColumnCheckboxes()
			} else {

				selectParent = document.getElementById('columnDiv');
				document.getElementById("sel").checked = false;
				divContainer.innerHTML = '';
				selectParent.style.display = "block";
				document.getElementById('whereConditionCheckboxes').style.display = "none";
				buttonParent.style.display = "none";

			}
		}

		/******************column CheckBoxes***********************/
		function showColumnCheckboxes() {
			var tablename = document.getElementById('table').value;

			if (active === 'select') {
				var _container = function() {
					columnArray = [];
					selectColumnChildContainer.style.display = "block";
					buttonParent.style.display = "block";
					limitcontainer.style.display = "block";
					for (var i = 0; i < responseData.Records.length; i++) {

						tableContraints[responseData.Records[i].column_name] = responseData.Records[i].column_default;
						columnArray[i] = responseData.Records[i].column_name;
					}
					selectColumnChildContainer.innerHTML = '';
					for ( var option in columnArray) {

						var _label = document.createElement('label')
						if (columnArray.hasOwnProperty(option)) {
							var _pair = columnArray[option];
							var _checkbox = document.createElement("input");
							_checkbox.type = "checkbox";
							_checkbox.name = 'checkbox';
							_checkbox.value = _pair;
							_checkbox.id = columnArray[option];
							selectColumnChildContainer.appendChild(_checkbox);
							_label.htmlFor = _pair;
							_label.appendChild(document.createTextNode(_pair));
							selectColumnChildContainer.appendChild(_label);
						}
					}
				}
				service(_container, api_urls.columnList + '/' + tablename, data);
			} else if (active === 'insert') {
				columnWithDataType = {};
				var _container = function() {
					selectColumnChildContainer.style.display = "block";
					buttonParent.style.display = "block";
					selectColumnChildContainer.innerHTML = '';
					var _div = document.createElement("div");
					if (document.getElementById("sel").checked === true) {
						for (i = 0; i < responseData.Records.length; i++) {
							var _div = document.createElement("div");
							var _input = document.createElement("input");
							_div
									.appendChild(document
											.createTextNode(responseData.Records[i].column_name
													+ ":"));
							tableContraints[responseData.Records[i].column_name] = responseData.Records[i].column_default;
							_input.type = "text";
							_input.name = responseData.Records[i].column_name
									+ "_textBox";
							_input.placeholder = responseData.Records[i].data_type;
							_input.id = responseData.Records[i].column_name
									+ "_textBox";
							var validateMessageDiv = document
									.createElement("div");
							validateMessageDiv.id = responseData.Records[i].column_name
									+ "_div";
							validateMessageDiv.innerHTML = '';

							if (responseData.Records[i].column_default)
								_input.disabled = true;
							_div.appendChild(_input);
							_div.appendChild(validateMessageDiv);
							selectColumnChildContainer.appendChild(_div);
						}
					}
				}
				service(_container, api_urls.columnList + '/' + tablename, data);
			} else if (active === 'update') {
				var _tablename = document.getElementById('table').value;
				service(tableContraints,
						api_urls.columnList + '/' + _tablename, data)
				//var _limit=document.getElementById('limit_textbox').value
				//var _query = limit?('select * from ' + table_name + ' ' + 'limit ' +' '+limit):('select * from ' + table_name + ' ' + 'limit 50');
				var _query = 'select * from ' + _tablename + ' ' + 'limit 50';
				service(renderDivContainer, api_urls.findTableData + '/'
						+ _query, data);
			} else if (active === 'delete') {
				document.getElementById('condt_textBox').value = '';
				var _tablename = document.getElementById('table').value;

				service(tableContraints,
						api_urls.columnList + '/' + _tablename, data);
				//var limit=document.getElementById('limit_textbox').value
				//var _query = limit?('select * from ' + table_name + ' ' + 'limit ' +' '+limit):('select * from ' + table_name + ' ' + 'limit 50');
				var _query = 'select * from ' + _tablename ;
				service(renderDivContainer, api_urls.findTableData + '/'
						+ _query, data);
			}
		}

		
		/*********************************************************************************/
		/*****************Table Factory related functions****************************/
		/*********************************************************************************/

		function tableFactory(jsonData) {
			var _table = document.createElement("table");

			columnArray = [];
			for (var i = 0; i < jsonData.length; i++) {
				for ( var key in jsonData[i]) {
					if (columnArray.indexOf(key) === -1) {
						columnArray.push(key);
					}
				}
			}
			_table.border = "1";
			_table.cellspacing = "0";
			var _tr = _table.insertRow(-1); // TABLE ROW.
			for (var i = 0; i < columnArray.length; i++) {
				var _th = document.createElement("th"); // TABLE HEADER.
				_th.innerHTML = columnArray[i];
				_tr.appendChild(_th);
			}

			for (var i = 0; i < jsonData.length; i++) {
				_tr = _table.insertRow(-1);
				_tr.id = 'row' + i
				var k = (active === 'update') ? columnArray.length + 1
						: columnArray.length;
				for (var j = 0; j < k; j++) {
					var tabCell = _tr.insertCell(-1);
					tabCell.id = columnArray[j] + i;
					if ((active === 'select') || (active === 'delete')) {
						tabCell.innerHTML = jsonData[i][columnArray[j]];

					} else if (active === 'update') {
						var buttons = '<input type='
								+ '\''
								+ 'checkbox\''
								+ ' '
								+ 'id="'
								+ i
								+ '"  value="select" onclick="checkBoxEventHandler(this.id)">'
								+ '<input type="button" id="' + 'edit_button'
								+ i + '"'
								+ 'value="Edit"  onclick="edit_row(\'' + i
								+ '\')"style="display: none;">'
								+ '<input type="button" id="' + 'save_button'
								+ i + '"'
								+ 'value="Update"  onclick="update_row(\'' + i
								+ '\')"style="display: none;">';
						tabCell.innerHTML = (j < columnArray.length) ? jsonData[i][columnArray[j]]
								: buttons;
					}
					document.getElementById('whereConditionCheckboxes').style.display = (active === 'delete') ? 'block'
							: 'none';
					if (active === 'delete')
						whereConditionHandler();
				}
			}
			divContainer.innerHTML = "";
			divContainer.appendChild(_table);
		}

		/**************************************************/
		/**********************edit row****************************/
		function edit_row(no) {
			document.getElementById("edit_button" + no).style.display = "none";
			document.getElementById("save_button" + no).style.display = "block";
			tableColumnId = [];
			for (var i = 0; i < columnArray.length; i++) {

				tableColumnId[i] = document.getElementById(columnArray[i] + no);
			}

			for (var j = 0; j < columnArray.length; j++) {

				var value = document.getElementById(columnArray[j] + no).innerHTML;
				tableColumnId[j].innerHTML = !tableContraints[columnArray[j]] ? ("<input type='text' id='"
						+ columnArray[j]
						+ "_text"
						+ no
						+ "' value='"
						+ document.getElementById(columnArray[j] + no).innerHTML + "'>")
						: value;
			}
		}

		/**************************************************/
		/********************update row********************/

		function update_row(no) {

			var columnValues = {};
			var whereCondition = {};
			var _updatedValues = [];
			var _whereCombination = [];
			var _x = 0;
			for (var i = 0; i < columnArray.length; i++) {

				if (!tableContraints[columnArray[i]]) {
					columnValues[columnArray[i]] = "'"
							+ document.getElementById(columnArray[i] + "_text"
									+ no).value + "'";
				} else {
					whereCondition[columnArray[i]] = document
							.getElementById(columnArray[i] + no).innerHTML;
				}
			}
			for ( var k in columnValues) {
				if (columnValues.hasOwnProperty(k)) {
					var str = columnDataType[k] === 'integer' ? (k + "=" + parseInt(whereCondition[k]))
							: (k + "=" + columnValues[k]);
					_updatedValues[_x] = str;
					_x++;
				}
			}
			_x = 0;
			for ( var k in whereCondition) {
				if (whereCondition.hasOwnProperty(k)) {
					var str = columnDataType[k] === 'integer' ? (k + "=" + parseInt(whereCondition[k]))
							: (k + "=" + columnValues[k]);
					_whereCombination[_x] = str;
					_x++;
				}
			}
			var _data = {
				query : ''
			};
			var _table_name = document.getElementById('table').value;
			var _queryString = "UPDATE " + " " + _table_name + " " + "SET"
					+ " " + _updatedValues + " " + "WHERE" + " "
					+ _whereCombination;
			_data.query = _queryString;
			requestJson = JSON.stringify(_data);
			service(resultMessage, 'http://localhost:8080/query/updateRow',
					requestJson);

			for (var i = 0; i < columnArray.length; i++) {
				if (responseCode === 200) {
					document.getElementById(columnArray[i] + no).innerHTML = !tableContraints[columnArray[i]] ? document
							.getElementById(columnArray[i] + "_text" + no).value
							: (document.getElementById(columnArray[i] + no).innerHTML);
				}
				showColumnCheckboxes();
				var _oText = document.createTextNode(responseMessage);
				divContainer.appendChild(_oText);
			}
			document.getElementById("edit_button" + no).style.display = "none";
			document.getElementById("save_button" + no).style.display = "none";
			document.getElementById(no).checked = false
		}

		/****************************checkBoxEventHandler() in update ****************************************/
		function checkBoxEventHandler(id) {
			document.getElementById("edit_button" + id).style.display = (document
					.getElementById(id).checked === true) ? "block" : "none";
			if (document.getElementById(id).checked === false) {
				document.getElementById("save_button" + id).style.display = "none";
				showColumnCheckboxes();
			}
		}

		/*********************************************************************************/
		/*******************************End****************************/
		/*********************************************************************************/
		
		

		/********************** Data Container****************************/

		var renderDivContainer = function() {

			if ((active === 'select')) {
				var _jsonData = responseData.Records;
				if (_jsonData) {
					_jsonData.sort(sorting);
					tableFactory(_jsonData);
				} else {
					var _oText = document.createTextNode(JSON
							.parse(this.responseText).Message);
					divContainer.appendChild(_oText);
				}
			} else if (active === 'insert') {
				divContainer.innerHTML = JSON.parse(this.responseText).responseDescription;
			} else if ((active === 'update')) {
				columnArray = [];
				var _jsonData = responseData.Records;
				_jsonData.sort(sorting);
				divContainer.innerHTML = '';
				tableFactory(_jsonData);
			} else if ((active === 'delete')) {

				columnArray = [];
				var _jsonData = responseData.Records;
				divContainer.innerHTML = '';
				if (_jsonData) {
					_jsonData.sort(sorting)
					tableFactory(_jsonData);
				} else {

					responseMessage = JSON.parse(this.responseText).Message;
					var _oText = document.createTextNode(JSON
							.parse(this.responseText).Message);
					divContainer.appendChild(_oText)
				}
			}
		}
		/**********************************************************/

		/******************method when click on condition Button******************/
		function whereConditionHandler() {

			document.getElementById('whereConditionCheckboxes').style.display = 'block';
			columnCondition.innerHTML = '';
			buttonParent.style.display = "block";
			var _option = document.createElement('option');
			_option.value = 'select column';
			_option.text = 'select column';
			columnCondition.appendChild(_option);
			for ( var k in columnArray) {

				var _option = document.createElement('option');
				_option.value = columnArray[k];
				_option.text = columnArray[k];
				columnCondition.appendChild(_option);
			}
			;
		}
		/**********************************************************/

		/*************************render result Message***********************************/

		var resultMessage = function() {
			responseCode = JSON.parse(this.responseText).responseCode;
			responseMessage = JSON.parse(this.responseText).responseDescription;
			var _oText = document
					.createTextNode(JSON.parse(this.responseText).responseDescription);
			divContainer.appendChild(_oText);
		}
		/************************************************************/
		
		
		
		/**********   submit button handler   **********/
		/************************************************************/

		function submit() {
			
			var _query = '';
			if ((active === 'select') || (active === 'update')) {

				var _column = findActiveCheckbox('#select_col_Checkboxes input[type="checkbox"]:checked');
				var _table_name = document.getElementById('table').value;
				var _limit = document.getElementById('limit_textbox').value

				_query = _column.length > 0 ? (_limit ? ('select ' + _column
						+ ' ' + 'from ' + _table_name + ' ' + 'limit ' + _limit)
						: ('select ' + _column + ' ' + 'from ' + _table_name
								+ ' ' + 'limit 50'))
						: (_limit ? ('select * from ' + _table_name + ' '
								+ 'limit  ' + _limit) : ('select * from '
								+ _table_name + ' ' + 'limit 50 '));

				service(renderDivContainer,
						'http://localhost:8080/query/findTableData/' + _query,
						data);
			} else if ((active === 'insert')) {
				
				columnArray = [];
				textBoxValue = [];
				var _fieldValue = [];
				var _data_type = [];
				flag = 0;
				var _tablename = document.getElementById('table').value
				var _getValue = function() {

					for (var i = 0; i < responseData.Records.length; i++) {
						if (document
								.getElementById(responseData.Records[i].column_name
										+ "_textBox").disabled) {
						} else {
							_fieldValue = responseData.Records[i].data_type === 'integer' ? parseInt(document
									.getElementById(responseData.Records[i].column_name
											+ "_textBox").value)
									: (document
											.getElementById(responseData.Records[i].column_name
													+ "_textBox").value);
							_data_type[flag] = responseData.Records[i].data_type;
							columnArray[flag] = responseData.Records[i].column_name;
							textBoxValue[flag] = Number.isInteger(_fieldValue) ? _fieldValue
									: '\'' + _fieldValue + '\''
							flag = flag + 1;
						}
					}
					query = 'INSERT INTO ' + _tablename + '(' + columnArray
							+ ')VALUES(' + textBoxValue + ')';
				}

				service(_getValue, api_urls.columnList + '/' + _tablename, data);
				if (query != '') {
					service(renderDivContainer, api_urls.insertRow + '/'
							+ query, data);
				}
			} else if ((active === 'delete')) {

				var _table_name = document.getElementById('table').value;
				var _wherecondition = [];
				var _str = columnDataType[document
						.getElementById('columnCondition').value] === 'integer' ? (document
						.getElementById('columnCondition').value
						+ document.getElementById('Operators').value + parseInt(document
						.getElementById('condt_textBox').value))
						: (document.getElementById('columnCondition').value
								+ document.getElementById('Operators').value
								+ " \'"
								+ document.getElementById('condt_textBox').value + "\'");
				_wherecondition[0] = _str;
				var _query = 'DELETE FROM ' + _table_name + ' WHERE '
						+ _wherecondition;
				var _data = {
					query : ''
				};
				_data.query = _query;
				requestJson = JSON.stringify(_data);
				service(resultMessage, api_urls.deleteRow,
						requestJson);
				if (responseCode === 200) {
					showColumnCheckboxes();
					var _oText = document.createTextNode(responseMessage);
					divContainer.appendChild(_oText);
				}
			}
		}
	</script>
</body>
</html>