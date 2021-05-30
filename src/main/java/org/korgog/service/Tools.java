package org.korgog.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.security.NoSuchAlgorithmException;
import java.security.MessageDigest;

public class Tools {
	public static String dateTime(Date sourceDateTime) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd. HH:mm");
		String formatedScoringTime = simpleDateFormat.format(sourceDateTime);
		return formatedScoringTime;
	}

	public static String removeTags(String html) {
		return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	}

	public static String getEncrypt(String rawString) {
		String encryptedString = null;
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-512");
			digest.reset();
			digest.update(rawString.getBytes("utf8"));
			encryptedString = String.format("%0128x", new BigInteger(1, digest.digest()));
		} catch (UnsupportedEncodingException | NoSuchAlgorithmException e) {
			System.out.println("오류 Message : " + e.getMessage());
			e.printStackTrace(System.out);
		}
		return encryptedString;
	}

	public static int getTableNum(String table, String queryWhere) {
		int tableNum = 0;
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet resultSet = null;
		try {
			String querySQL = "SELECT MAX(" + table + "NUM) AS "
					+ table + "NUM FROM " + table;
			if (queryWhere.length() > 0) {
				querySQL += " " + queryWhere;
			}
			querySQL = querySQL.replaceAll("  ", " ");

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			resultSet = pStatement.executeQuery();

			if (resultSet.next()) {
				tableNum = resultSet.getInt(table + "NUM");
			}
		} catch (SQLException e) {
			System.out.println("오류 SQLException : " + e.getSQLState());
			System.out.println("오류 Message : " + e.getErrorCode() + " - " + e.getMessage());
			e.printStackTrace(System.out);
		} catch (Exception e) {
			System.out.println("오류 Message : " + e.getMessage());
			e.printStackTrace(System.out);
		} finally {
			DBManager.close(connection, pStatement, resultSet);
		}
		return tableNum;
	}
}