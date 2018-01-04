package com.thinksys.query.util;

public class ResponseMessage {
	
	int responseCode;
	String responseDescription;


	public ResponseMessage(int responseCode, String responseDescription) {
		this.responseCode = responseCode;
		this.responseDescription = responseDescription;
	}
	public ResponseMessage() {
	}

	public int getResponseCode() {
		return responseCode;
	}
	public void setResponseCode(int responseCode) {
		this.responseCode = responseCode;
	}
	
	
	public String getResponseDescription() {
		return responseDescription;
	}
	public void setResponseDescription(String responseDescription) {
		this.responseDescription = responseDescription;
	}

	@Override
	public String toString() {
		return "ResponseMessage [responseCode=" + responseCode + ", responseDescription=" + responseDescription + "]";
	}

}
