package org.korgog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Calendar;
import org.korgog.config.Environment;
import org.korgog.service.DBManager;
import org.korgog.service.Pages;
import org.korgog.service.Tools;
import org.korgog.dto.AccessLogDTO;

public class AccessLogDAO {
	private final String TABLE_ACCESSLOG = Environment.getTABLE_ACCESSLOG();
	private final String TABLE_MEMBER = Environment.getTABLE_MEMBER();
	private Connection connection = null;
	private PreparedStatement pStatement = null;
	private ResultSet resultSet = null;

	public void addLog(AccessLogDTO accessLogDTO) {
		try {
			int accessLogNum = Tools.getTableNum(TABLE_ACCESSLOG, "") + 1;
			java.sql.Date currentDateTime = new java.sql.Date(Calendar.getInstance().getTime().getTime());

			String querySQL = "INSERT INTO "
					+ TABLE_ACCESSLOG
					+ " ("
					+ "ACCESSLOGNUM, MEMBERNUM, IPADDRESS, WORKTABLE, WORKNUM, DETAIL, ACCESSTIME"
					+ ") VALUES("
					+ "?, ?, ?, ?, ?, ?, ?"
					+ ")";
			querySQL = querySQL.replaceAll("  ", " ");

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setInt(1, accessLogNum);
			pStatement.setInt(2, accessLogDTO.getMemberNum());
			pStatement.setString(3, accessLogDTO.getIpAddress());
			pStatement.setString(4, accessLogDTO.getWorkTable());
			pStatement.setInt(5, accessLogDTO.getWorkNum());
			pStatement.setString(6, accessLogDTO.getDetail());
			if(accessLogDTO.getAccessTime() != null) {
				pStatement.setDate(7, currentDateTime);
			}
			pStatement.executeUpdate();
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
	}

	public Pages getPage(int currentPage, String searchColumn, String searchString) {
		searchColumn = searchColumn.trim();
		searchString = searchString.trim();

		String querySQL = "SELECT COUNT(*) AS TOTALROW FROM " + TABLE_ACCESSLOG + " A, " + TABLE_MEMBER + " B "
				+ "WHERE A.MEMBERNUM=B.MEMBERNUM";
		if (searchColumn.length() > 1 && searchString.length() > 1) {
			querySQL += " AND " + searchColumn + " LIKE '%" + searchString + "%'";
		}
		querySQL = querySQL.replaceAll("  ", " ");

		int rowsPerPage = Environment.getACCESSLOG_LIST_ROWS();
		int pagesPerWindow = Environment.getACCESSLOG_LIST_PAGES();

		Pages page = new Pages(currentPage, rowsPerPage, pagesPerWindow, querySQL);
		return page;
	}

	public List<AccessLogDTO> getList(int currentPage, int startRow, int endRow, String searchColumn, String searchString) {
		List<AccessLogDTO> listDTO = null;
		searchColumn = searchColumn.trim();
		searchString = searchString.trim();

		try {
			String queryWhere = "";
			if (searchColumn.length() > 1 && searchString.length() > 0) {
				queryWhere = " AND " + searchColumn + " LIKE '%' || ? || '%' ";
			}
			String querySQL = "SELECT X.RNUM, X.* FROM (SELECT ROWNUM AS RNUM, Y.* FROM "
					+ "(SELECT A.*, B.MEMBERID, B.MEMBERNAME FROM "
					+ TABLE_ACCESSLOG
					+ " A, "
					+ TABLE_MEMBER
					+ " B "
					+ "WHERE A.MEMBERNUM=B.MEMBERNUM "
					+ "queryWhere"
					+ "ORDER BY ACCESSLOGNUM ASC) Y "
					+ "WHERE ROWNUM <= ?) X WHERE X.RNUM >= ? ORDER BY X.RNUM DESC";
			querySQL = querySQL.replace("queryWhere", queryWhere);
			querySQL = querySQL.replaceAll("  ", " ");

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);

			int i = 1;
			if (searchString != null && searchString.length() > 0) {
				pStatement.setString(i, searchString);
				i++;
			}
			pStatement.setInt(i, startRow);
			pStatement.setInt(i + 1, endRow);
			System.out.println(querySQL);

			resultSet = pStatement.executeQuery();
			if (resultSet.next()) {
				listDTO = new ArrayList<>();
				do {
					AccessLogDTO accessLogDTO = new AccessLogDTO();
					accessLogDTO.setAccessLogNum(resultSet.getInt("ACCESSLOGNUM"));
					accessLogDTO.setMemberNum(resultSet.getInt("MEMBERNUM"));
					accessLogDTO.setMemberID(resultSet.getString("MEMBERID"));
					accessLogDTO.setMemberName(resultSet.getString("MEMBERNAME"));
					accessLogDTO.setIpAddress(resultSet.getString("IPADDRESS"));
					accessLogDTO.setWorkTable(resultSet.getString("WORKTABLE"));
					accessLogDTO.setWorkNum(resultSet.getInt("WORKNUM"));
					accessLogDTO.setDetail(resultSet.getString("DETAIL"));
					accessLogDTO.setAccessTime(resultSet.getTimestamp("ACCESSTIME"));
					listDTO.add(accessLogDTO);
				} while (resultSet.next());
			} else {
				listDTO = null;
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

		return listDTO;
	}

	public AccessLogDTO getView(int num) {
		AccessLogDTO accessLogDTO = new AccessLogDTO();
		try {
			String querySQL = "SELECT A.*, B.MEMBERID, B.MEMBERNAME FROM "
					+ TABLE_ACCESSLOG + " A, "
					+ TABLE_MEMBER + " B "
					+ "WHERE A.MEMBERNUM=B.MEMBERNUM AND A.ACCESSLOGNUM = ?";

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setInt(1, num);
			resultSet = pStatement.executeQuery();

			if (resultSet.next()) {
				accessLogDTO.setAccessLogNum(resultSet.getInt("ACCESSLOGNUM"));
				accessLogDTO.setMemberNum(resultSet.getInt("MEMBERNUM"));
				accessLogDTO.setMemberID(resultSet.getString("MEMBERID"));
				accessLogDTO.setMemberName(resultSet.getString("MEMBERNAME"));
				accessLogDTO.setIpAddress(resultSet.getString("IPADDRESS"));
				accessLogDTO.setWorkTable(resultSet.getString("WORKTABLE"));
				accessLogDTO.setWorkNum(resultSet.getInt("WORKNUM"));
				accessLogDTO.setDetail(resultSet.getString("DETAIL"));
				accessLogDTO.setAccessTime(resultSet.getTimestamp("ACCESSTIME"));
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
		return accessLogDTO;
	}
}