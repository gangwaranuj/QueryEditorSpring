/**
 * 
 */

		function service(_render, url, data) {
			var _request = new XMLHttpRequest();
			_request.onreadystatechange = function(_response) {
				if (_request.readyState === 4) {
					if (_request.status === 200) {
						_responseData = JSON.parse(this.responseText);
						_render()
					}
				}
			};
			if (data) {
				_request.open('POST', url, true);
				_request.send();
			} else {
				_request.open('GET', url, true);
				_request.send();
			}
		};