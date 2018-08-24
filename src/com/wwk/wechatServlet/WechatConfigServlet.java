package com.wwk.wechatServlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.wwk.entity.WinXinEntity;
import com.wwk.utils.MessageUtil;
import com.wwk.utils.SetMenuUtils;
import com.wwk.utils.WeinXinUtil;

import net.sf.json.JSONObject;

@WebServlet("/WechatConfigServlet")
public class WechatConfigServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=UTF-8");
		Map<String, Object> mapRes=new HashMap<String, Object>();
		
        //微信分享
        String strUrl = MessageUtil.IP
                + request.getContextPath()   //项目名称  
                + request.getServletPath()   //请求页面或其他地址  
                + "?" + (request.getQueryString()); //参数  
        System.out.println("strUrl" + strUrl);
        WinXinEntity wx = WeinXinUtil.getWinXinEntity(strUrl);
        
        HttpSession session = request.getSession();
        try {
             String access_token = SetMenuUtils.getAccessToken();
			 mapRes.put("appid", wx.getAppid());
			 mapRes.put("nonceStr", wx.getNoncestr());
			 mapRes.put("timestamp", wx.getTimestamp());
			 mapRes.put("signature", wx.getSignature());
			 mapRes.put("code", MessageUtil.SUCCESS);
			 mapRes.put("msg", "上传成功");
		} catch (Exception e) {
			 e.printStackTrace();
			 mapRes.put("code", "201");
			 mapRes.put("msg", "上传失败");
		}
        System.out.println(mapRes);
        
        //将wx的信息到给页面
//        request.setAttribute("wx", wx);
        response.getWriter().print(JSONObject.fromObject(mapRes).toString());
	}
}
