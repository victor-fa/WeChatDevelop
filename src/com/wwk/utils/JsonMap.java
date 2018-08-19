package com.wwk.utils;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

public class JsonMap {
	private String returnMsg;// 返回信息
	private String returnCode;// 返回代码
	private String retnrnJson;// 返回数据

	public JsonMap(String returnMsg, String returnCode, String retnrnJson) {
		this.returnMsg = returnMsg;
		this.returnCode = returnCode;
		this.retnrnJson = retnrnJson;
	}

	public JsonMap() {
	}

	public String getReturnMsg() {
		return returnMsg;
	}

	public void setReturnMsg(String returnMsg) {
		this.returnMsg = returnMsg;
	}

	public String getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}

	public String getRetnrnJson() {
		return retnrnJson;
	}

	public void setRetnrnJson(String retnrnJson) {
		this.retnrnJson = retnrnJson;
	}

	public String toString() {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("returnMsg", this.returnMsg);
		jsonObject.put("returnCode", this.returnCode);
		jsonObject.put("retnrnJson", this.retnrnJson);
		return jsonObject.toString();
	}

	public Map<String, Object> toMap() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("returnMsg", this.returnMsg);
		map.put("returnCode", this.returnCode);
		map.put("retnrnJson", this.retnrnJson);
		return map;
	}

}
