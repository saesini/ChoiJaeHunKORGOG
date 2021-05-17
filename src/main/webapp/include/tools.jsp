<%@page language="java" contentType="text/html;charesultsetet=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.net.InetAddress"%>
<%request.setCharacterEncoding("UTF-8");%>
<%!
	public static String getIP(HttpServletRequest request) {
		String ipAddress = "";
		try {
			ipAddress = request.getHeader("X-Forwarded-For");

			if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getHeader("Proxy-Client-IP");
			}

			if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getHeader("WL-Proxy-Client-IP");
			}

			if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getHeader("HTTP_CLIENT_IP");
			}

			if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getHeader("HTTP_X_FORWARDED_FOR");
			}

			if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getRemoteAddr();
			}

			if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getRemoteHost();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			return ipAddress;
		}
	}
%>