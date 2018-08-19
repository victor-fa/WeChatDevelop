package com.wwk.wechatServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.xml.internal.ws.util.StringUtils;
import com.wwk.entity.Signature;
import com.wwk.service.CoreService;
import com.wwk.utils.CheckUtil;
import com.wwk.utils.MessageUtil;
import com.wwk.utils.SignUtil;

/**
 * Servlet implementation class WechatDevelopServlet
 */
@WebServlet("/WechatDevelopServlet")
public class WechatDevelopServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * 验证消息的确来自微信服务器
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		System.out.println("GET发送消息了！！！");
		Signature sg = new Signature(req.getParameter("signature"), req.getParameter("timestamp"),
				req.getParameter("nonce"), req.getParameter("echostr"));

		PrintWriter out = resp.getWriter();
		if (CheckUtil.checkSignature(sg)) {
			out.print(sg.getEchostr());
		}
		if (out != null) {
			out.close();
			out = null;
		}
		System.out.println("Signature: " + sg);
		doPost(req, resp);
	}

	/**
	 * 处理微信服务器发来的消息
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 将请求、响应的编码均设置为UTF-8（防止中文乱码）
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("UTF-8");

		System.out.println("POST发送消息了！！！");
		Signature sg = new Signature(req.getParameter("signature"), req.getParameter("timestamp"),
				req.getParameter("nonce"), req.getParameter("echostr"));

		PrintWriter out = resp.getWriter();
		// 校验参数
		if (CheckUtil.checkSignature(sg)) {
			// out.print(sg.getEchostr());
			try {
				String respXML = CoreService.processRequest(req);
				out.write(respXML);
				System.out.println("发送消息： " + respXML);

				// 调用parseXml方法解析请求消息
				Map<String, String> respMap;
				Map<String, String> reqMap;
				// 该方法中文乱码
				respMap = MessageUtil.xmlParse(respXML);
//				reqMap = MessageUtil.parseXML(req);
				// 发送方帐号
				String fromUserName = respMap.get("FromUserName");
				// 开发者微信号
				String toUserName = respMap.get("ToUserName");
				// 消息类型
				String msgType = respMap.get("MsgType");
				// 发送时间
				String createTime = respMap.get("CreateTime");
				// 消息内容
				String content = respMap.get("Content");

				System.out.println("respMap: " + respMap);
//				System.out.println("reqMap: " + reqMap);
				System.out.println("fromUserName: " + fromUserName);
				System.out.println("toUserName: " + toUserName);
				System.out.println("msgType: " + msgType);
				System.out.println("createTime: " + createTime);
				System.out.println("content: " + content);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (out != null) {
					out.close();
					out = null;
				}
			}
		} else {
			System.out.println("校验失败！");
		}
	}
}
