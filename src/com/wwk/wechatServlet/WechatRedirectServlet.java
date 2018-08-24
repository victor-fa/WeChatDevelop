package com.wwk.wechatServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wwk.utils.CommonUtil;
import com.wwk.utils.MessageUtil;

import net.sf.json.JSONObject;

/**
 * 微信公众号网页授权获取用户信息 Servlet implementation class WechatRedirectServlet
 */
@WebServlet("/WechatRedirectServlet")
public class WechatRedirectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// 登录网页授权接口
	String authorizationUrl = MessageUtil.AUTHORIZATION_URL;

	// 测试号
	private static final String APPID = MessageUtil.APPID;
	private static final String SECRET = MessageUtil.SECRET;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");

		// 第一步：用户同意授权，获取code
		String code = request.getParameter("code");
		System.out.println("code" + code);
		
		String accessToken = "";
		String refreshToken = "";
		String openId = "";
		// 第二步：通过code换取网页授权access_token
		String url1 = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + APPID + "&secret=" + SECRET
				+ "&code=" + code + "&grant_type=authorization_code";
		if(!code.equals("")) {
			JSONObject accessJson = CommonUtil.httpsRequest(url1, "GET", null);

			accessToken = accessJson.getString("access_token");
			refreshToken = accessJson.getString("refresh_token");
			openId = accessJson.getString("openid");
			System.out.println("accessJson" + accessJson.toString());
		}else {
			// 第三步：刷新access_token（如果需要）
			String url2 = "https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=" + APPID + "&grant_type=refresh_token&refresh_token=" + refreshToken; 
			JSONObject refreshTokenJson = CommonUtil.httpsRequest(url2, "GET", null);

			accessToken = refreshTokenJson.getString("access_token");
			refreshToken = refreshTokenJson.getString("refresh_token");
			openId = refreshTokenJson.getString("openid");
			System.out.println("refreshJson" + refreshTokenJson.toString());
		}

		// 第四步：拉取用户信息(需scope为 snsapi_userinfo)
		String url3 = "https://api.weixin.qq.com/sns/userinfo?access_token=" + accessToken + "&openid=" + openId
				+ "&lang=zh_CN";
		JSONObject userInfoJson = CommonUtil.httpsRequest(url3, "GET", null);
		System.out.println("userInfoJson" + userInfoJson.toString());

		// 附：检验授权凭证（access_token）是否有效
		String url4 = "https://api.weixin.qq.com/sns/userinfo?access_token=" + accessToken + "&openid=" + openId
				+ "&lang=zh_CN";
		JSONObject jiaoyanJson = CommonUtil.httpsRequest(url4, "GET", null);
		System.out.println("jiaoyanJson" + jiaoyanJson.toString());

		// 获取用户信息成功跳转到web页面
		request.setAttribute("userInfoJson", userInfoJson);
		request.setAttribute("openId", openId);
		request.setAttribute("nickname", userInfoJson.getString("nickname"));
		response.sendRedirect(MessageUtil.RECRUIT_URL);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
