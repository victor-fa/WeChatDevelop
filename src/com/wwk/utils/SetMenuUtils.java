package com.wwk.utils;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

public class SetMenuUtils {

	// 测试号 自己填
	private static final String APPID = "";
	private static final String SECRET = "";

	private static final String requstUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8beef4ae7533f617&redirect_uri=http%3A%2F%2F43.226.37.27%2FWeChatDevelop%2FWechatRedirectServlet&response_type=code&scope=snsapi_base&state=STATE&connect_redirect=1#wechat_redirect";

	private static final String DELETE_MENU_URL = "https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=ACCESS_TOKEN";

	/**
	 * 自定义菜单
	 * 
	 * @return
	 * @throws JSONException
	 */
	public static String getMenuStr() throws JSONException {
		JSONObject firstLevelMenu = new JSONObject();// 一级菜单
		JSONArray firstLevelMenuArray = new JSONArray();// 一级菜单列表

		// 一级菜单内容1
		JSONObject firstLevelMenuContext1 = new JSONObject();
		firstLevelMenuContext1.put("type", "view");
		firstLevelMenuContext1.put("name", "跳转链接");
		firstLevelMenuContext1.put("url", requstUrl);

		// 一级菜单内容2
		JSONObject firstLevelMenuContext2 = new JSONObject();
		// 一级菜单内容2的二级菜单列表
		JSONArray firstLevelMenuContext2Array = new JSONArray();
		// 一级菜单内容2的二级菜单内容1
		JSONObject jsonObject1 = new JSONObject();
		jsonObject1.put("type", "click");
		jsonObject1.put("name", "今日歌曲");
		jsonObject1.put("key", "acbYDOhmROIzZrcZPZpRNWTJIv6uoyQ5b5-JGuQWAVahH-gcAJ7nGPc9HorldbwA");
		// 一级菜单内容2的二级菜单内容2
		JSONObject jsonObject2 = new JSONObject();
		jsonObject2.put("type", "view");
		jsonObject2.put("name", "百度一下");
		jsonObject2.put("url", "http://www.baidu.com");
		// 一级菜单内容2的二级菜单内容3
		JSONObject jsonObject3 = new JSONObject();
		jsonObject3.put("type", "click");
		jsonObject3.put("name", "视频");
		jsonObject3.put("key", "BcIvJV9drIYebqjBEqbTAZwCjCXoyM25BJGxN8-NMoR0Gr9sNy75JNUb4UvVpAPZ");
		firstLevelMenuContext2Array.add(jsonObject1);
		firstLevelMenuContext2Array.add(jsonObject2);
		firstLevelMenuContext2Array.add(jsonObject3);
		firstLevelMenuContext2.put("name", "菜单");
		firstLevelMenuContext2.put("sub_button", firstLevelMenuContext2Array);


		// 一级菜单内容3
		JSONObject firstLevelMenuContext3 = new JSONObject();
		// 一级菜单内容3的二级菜单列表
		JSONArray firstLevelMenuContext3Array = new JSONArray();
		// 一级菜单内容3的二级菜单内容1
		JSONObject jsonObject21 = new JSONObject();
		jsonObject21.put("type", "scancode_waitmsg");
		jsonObject21.put("name", "扫码");
		jsonObject21.put("key", "rselfmenu_0_0");
//		jsonObject21.put("sub_button", "");
		// 一级菜单内容3的二级菜单内容2
		JSONObject jsonObject22 = new JSONObject();
		jsonObject22.put("type", "pic_sysphoto");
		jsonObject22.put("name", "相机");
		jsonObject22.put("key", "rselfmenu_1_0");
		// 一级菜单内容3的二级菜单内容3
		JSONObject jsonObject23 = new JSONObject();
		jsonObject23.put("type", "location_select");
		jsonObject23.put("name", "发送位置");
		jsonObject23.put("key", "rselfmenu_2_0");
		firstLevelMenuContext3Array.add(jsonObject21);
		firstLevelMenuContext3Array.add(jsonObject22);
		firstLevelMenuContext3Array.add(jsonObject23);
		firstLevelMenuContext3.put("name", "硬件");
		firstLevelMenuContext3.put("sub_button", firstLevelMenuContext3Array);

		firstLevelMenuArray.add(firstLevelMenuContext1);
		firstLevelMenuArray.add(firstLevelMenuContext2);
		firstLevelMenuArray.add(firstLevelMenuContext3);

		firstLevelMenu.put("button", firstLevelMenuArray);

		return firstLevelMenu.toString();
	}

	/**
	 * 获取access_token
	 * 
	 * @return
	 * @throws Exception
	 */
	public static String getAccessToken() throws Exception {
		String accessTokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + APPID
				+ "&secret=" + SECRET;
		URL url = new URL(accessTokenUrl);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();

		connection.setRequestMethod("GET");
		connection.setDoOutput(true);
		connection.setDoInput(true);
		connection.connect();

		// 获取返回的字符
		InputStream inputStream = connection.getInputStream();
		int size = inputStream.available();
		byte[] bs = new byte[size];
		inputStream.read(bs);
		String message = new String(bs, "UTF-8");

		// 获取access_token
		JSONObject jsonObject = JSONObject.fromObject(message);
		return jsonObject.getString("access_token");
	}

	/**
	 * 创建菜单
	 * 
	 * @throws Exception
	 */
	public static void createCustomMenu() throws Exception {
		String custmMenuUrl = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=";

		// 获取access_token
		String accessToken = getAccessToken();
		custmMenuUrl = custmMenuUrl + accessToken;

		URL url = new URL(custmMenuUrl);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();

		connection.setRequestMethod("POST");
		connection.setDoOutput(true);
		connection.setDoInput(true);
		connection.connect();

		OutputStream outputStream = connection.getOutputStream();
		outputStream.write(getMenuStr().getBytes("UTF-8"));
		outputStream.flush();
		outputStream.close();

		InputStream inputStream = connection.getInputStream();
		int size = inputStream.available();
		byte[] bs = new byte[size];
		inputStream.read(bs);
		String message = new String(bs, "UTF-8");

		System.out.println(message);
	}
	
	/**
	 * get请求
	 * 
	 * @param url
	 * @return
	 * @throws ParseException
	 * @throws IOException
	 */
	public static JSONObject doGetStr(String url) throws ParseException, IOException {
		DefaultHttpClient client = new DefaultHttpClient();
		HttpGet httpGet = new HttpGet(url);
		JSONObject jsonObject = null;
		HttpResponse httpResponse = client.execute(httpGet);
		HttpEntity entity = httpResponse.getEntity();
		if (entity != null) {
			String result = EntityUtils.toString(entity, "UTF-8");
			jsonObject = JSONObject.fromObject(result);
		}
		return jsonObject;
	}

	/**
	 * 删除菜单
	 * @param token
	 * @return
	 * @throws ParseException
	 * @throws IOException
	 */
	public static int deleteMenu(String token) throws ParseException, IOException {
		String url = DELETE_MENU_URL.replace("ACCESS_TOKEN", token);
		JSONObject jsonObject = doGetStr(url);
		int result = 0;
		if (jsonObject != null) {
			result = jsonObject.getInt("errcode");
		}
		System.out.println(jsonObject.toString());
		return result;
	}

}
