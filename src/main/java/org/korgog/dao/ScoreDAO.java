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
import org.korgog.dto.ScoreDTO;

public class ScoreDAO {
	private final String TABLE_SCORE = Environment.getTABLE_SCORE();
	private final String TABLE_MEMBER = Environment.getTABLE_MEMBER();
	private final String TABLE_OFFICE = Environment.getTABLE_OFFICE();
	private Connection connection = null;
	private PreparedStatement pStatement = null;
	private ResultSet resultSet = null;

	public void scoreOffice(ScoreDTO scoreDTO, String ipAddress) {
		try {
			int scoreNum = Tools.getTableNum(TABLE_SCORE, "") + 1;
			java.sql.Date currentDateTime = new java.sql.Date(Calendar.getInstance().getTime().getTime());

			String querySQL = "INSERT INTO "
					+ TABLE_SCORE
					+ " ("
					+ "SCORENUM, MEMBERNUM, OFFICENUM, SCORE, COMMENTS, SCORINGTIME"
					+ ") VALUES("
					+ "?, ?, ?, ?, ?, ?"
					+ ")";
			querySQL = querySQL.replaceAll("  ", " ");

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setInt(1, scoreNum);
			pStatement.setInt(2, scoreDTO.getMemberNum());
			pStatement.setInt(3, scoreDTO.getOfficeNum());
			pStatement.setInt(4, scoreDTO.getScore());
			pStatement.setString(5, scoreDTO.getComments());
			pStatement.setDate(6, currentDateTime);
			pStatement.executeUpdate();

			String sname = "";
			String queryGetSname = "SELECT SNAME FROM "
					+ TABLE_OFFICE
					+ " WHERE OFFICENUM = ?";
			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(queryGetSname);
			pStatement.setInt(1, scoreDTO.getOfficeNum());
			resultSet = pStatement.executeQuery();
			if (resultSet.next()) {
				sname = resultSet.getString("SNAME");
			}
			MemberDAO memberDAO = new MemberDAO();
			AccessLogDTO accessLogDTO = new AccessLogDTO();
			accessLogDTO.setMemberNum(scoreDTO.getMemberNum());
			accessLogDTO.setIpAddress(ipAddress);
			accessLogDTO.setWorkTable(TABLE_SCORE);
			accessLogDTO.setWorkNum(scoreNum);
			accessLogDTO.setDetail(
					"[관공서 평가] ID:" + memberDAO.getMemberID(scoreDTO.getMemberNum()) + ", "
					+ "관공서:" + sname + ", "
					+ "평가점수:" + scoreDTO.getScore());
			accessLogDTO.setAccessTime(currentDateTime);
			AccessLogDAO accessLogDAO = new AccessLogDAO();
			accessLogDAO.addLog(accessLogDTO);
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

	public Pages getPage(int officeNum, int currentPage, String searchColumn, String searchString) {
		searchColumn = searchColumn.trim();
		searchString = searchString.trim();

		String querySQL = "SELECT COUNT(*) AS TOTALROW FROM " + TABLE_SCORE + " NATURAL JOIN " + TABLE_OFFICE;

		if (officeNum > 0) {
			searchColumn = "OFFICENUM";
			searchString = String.valueOf(officeNum);
		}

		int rowsPerPage = Environment.getSCORE_LIST_ROWS();
		int pagesPerWindow = Environment.getSCORE_LIST_PAGES();

		Pages page = new Pages(currentPage, rowsPerPage, pagesPerWindow, querySQL, searchColumn, searchString);
		return page;
	}

	public List<ScoreDTO> getList(int officeNum, int currentPage, int startRow, int endRow, String searchColumn, String searchString) {
		List<ScoreDTO> listDTO = new ArrayList<>();
		searchColumn = searchColumn.trim();
		searchString = searchString.trim();

		try {
			String queryWhere = "";
			if (officeNum > 0) {
				queryWhere = " AND " + TABLE_OFFICE + ".OFFICENUM=? ";
				searchString = String.valueOf(officeNum);
			} else if (searchColumn.length() > 0 && searchString.length() > 0) {
				queryWhere = " AND " + TABLE_OFFICE + "." + searchColumn + " LIKE '%' || ? || '%' ";
			}

			String querySQL = "SELECT  * FROM "
					+ "("
					+ "SELECT ROWNUM AS RNUM, "
					+ TABLE_SCORE + ".SCORENUM, " + TABLE_MEMBER + ".MEMBERNAME, " + TABLE_SCORE + ".SCORINGTIME, " + TABLE_OFFICE + ".SNAME, " + TABLE_SCORE + ".SCORE, " + TABLE_SCORE + ".COMMENTS "
					+ "FROM " + TABLE_SCORE + " JOIN OFFICE "
					+ "ON " + TABLE_SCORE + ".OFFICENUM = " + TABLE_OFFICE + ".OFFICENUM JOIN MEMBER "
					+ "ON " + TABLE_SCORE + ".MEMBERNUM = " + TABLE_MEMBER + ".MEMBERNUM "
					+ " WHERE ROWNUM <= ? "
					+ "queryWhere"
					+ ") "
					+ "WHERE RNUM >= ? ORDER BY RNUM DESC";
			querySQL = querySQL.replace("queryWhere", queryWhere);

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setInt(1, startRow);
			if (queryWhere.length() > 0) {
				if (officeNum > 0) {
					pStatement.setInt(2, officeNum);
				} else if (searchString != null && searchString.length() > 0) {
					pStatement.setString(2, searchString);
				}
				pStatement.setString(2, searchString);
				pStatement.setInt(3, endRow);
			} else {
				pStatement.setInt(2, endRow);
			}

			resultSet = pStatement.executeQuery();
			if (resultSet.next()) {
				do {
					ScoreDTO scoreDTO = new ScoreDTO();
					scoreDTO.setScoreNum(resultSet.getInt("SCORENUM"));
					scoreDTO.setMemberName(resultSet.getString("MEMBERNAME"));
					scoreDTO.setScoringTime(resultSet.getTimestamp("SCORINGTIME"));
					scoreDTO.setOfficeSname(resultSet.getString("SNAME"));
					scoreDTO.setScore(resultSet.getInt("SCORE"));
					scoreDTO.setComments(resultSet.getString("COMMENTS"));
					listDTO.add(scoreDTO);
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
}