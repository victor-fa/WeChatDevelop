package com.wwk.wechatServlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wwk.utils.SetMenuUtils;

/**
 * Servlet implementation class SetMenuServlet
 */
@WebServlet("/SetMenuServlet")
public class SetMenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
//			String token = SetMenuUtils.getAccessToken();
//			SetMenuUtils.deleteMenu(token);
//			System.out.println(token);
			
			SetMenuUtils.createCustomMenu();
			
			response.getWriter().print("stormfa");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
