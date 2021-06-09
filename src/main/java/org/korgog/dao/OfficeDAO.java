package org.korgog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.korgog.config.Environment;
import org.korgog.service.DBManager;
import org.korgog.service.Pages;
import org.korgog.dto.OfficeDTO;

public class OfficeDAO {
	private final String TABLE_OFFICE = Environment.getTABLE_OFFICE();
	private final String TABLE_SCORE = Environment.getTABLE_SCORE();
	private Connection connection = null;
	private PreparedStatement pStatement = null;
	private ResultSet resultSet = null;

	public Pages getPage(int currentPage, String searchColumn, String searchString) {
		searchColumn = searchColumn.trim();
		searchString = searchString.trim();

		String querySQL = "SELECT COUNT(*) AS TOTALROW FROM " + TABLE_OFFICE;

		int rowsPerPage = Environment.getOFFICE_LIST_ROWS();
		int pagesPerWindow = Environment.getOFFICE_LIST_PAGES();

		Pages page = new Pages(currentPage, rowsPerPage, pagesPerWindow, querySQL, searchColumn, searchString);
		return page;
	}

	public List<OfficeDTO> getList(int currentPage, int startRow, int endRow, String searchColumn, String searchString) {
		List<OfficeDTO> listDTO = new ArrayList<>();
		searchColumn = searchColumn.trim();
		searchString = searchString.trim();

		try {
			String queryWhere = "";
			if (searchColumn.length() > 0 && searchString.length() > 0) {
				queryWhere = " AND " + searchColumn + " LIKE '%' || ? || '%' ";
			}

			String querySQL = "SELECT * FROM "
					+ "("
					+ "SELECT ROWNUM AS RNUM, "
					+ "OFFICENUM, PART, SNAME, FNAME, "
					+ "(SELECT COUNT(SCORE) FROM " + TABLE_SCORE + " WHERE OFFICENUM = " + TABLE_OFFICE + ".OFFICENUM) AS SCORECOUNT, "
					+ "(SELECT CEIL(AVG(SCORE)) FROM " + TABLE_SCORE + " WHERE OFFICENUM = " + TABLE_OFFICE + ".OFFICENUM) AS SCOREAVERAGE "
					+ "FROM " + TABLE_OFFICE + " "
					+ "WHERE ROWNUM <= ?"
					+ queryWhere
					+ ") "
					+ "WHERE RNUM >= ? ORDER BY RNUM DESC";

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			if (queryWhere.length() > 0) {
				pStatement.setInt(1, startRow);
				pStatement.setString(2, searchString);
				pStatement.setInt(3, endRow);
			} else {
				pStatement.setInt(1, startRow);
				pStatement.setInt(2, endRow);
			}

			resultSet = pStatement.executeQuery();
			if (resultSet.next()) {
				do {
					OfficeDTO officeDTO = new OfficeDTO();
					officeDTO.setOfficeNum(resultSet.getInt("OFFICENUM"));
					officeDTO.setPart(resultSet.getString("PART"));
					officeDTO.setSname(resultSet.getString("SNAME"));
					officeDTO.setFname(resultSet.getString("FNAME"));
					officeDTO.setScoreCount(resultSet.getInt("SCORECOUNT"));
					officeDTO.setScoreAverage((int) Math.round((double) resultSet.getInt("SCOREAVERAGE") / 10) * 10);
					listDTO.add(officeDTO);
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

	public OfficeDTO getView(int num) {
		OfficeDTO officeDTO = new OfficeDTO();
		try {
			String querySQL = "SELECT OFFICE.*, "
					+ "(SELECT COUNT(SCORE) FROM " + TABLE_SCORE + " WHERE OFFICENUM = " + TABLE_OFFICE + ".OFFICENUM) AS SCORECOUNT, "
					+ "(SELECT CEIL(AVG(SCORE)) FROM " + TABLE_SCORE + " WHERE OFFICENUM = " + TABLE_OFFICE + ".OFFICENUM) AS SCOREAVERAGE "
					+ "FROM " + TABLE_OFFICE + " "
					+ "WHERE OFFICENUM = ?";

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setInt(1, num);
			resultSet = pStatement.executeQuery();

			if (resultSet.next()) {
				officeDTO.setPart(resultSet.getString("PART"));
				officeDTO.setParent(resultSet.getString("PARENT"));
				officeDTO.setCat(resultSet.getString("CAT"));
				officeDTO.setSname(resultSet.getString("SNAME"));
				officeDTO.setFname(resultSet.getString("FNAME"));
				officeDTO.setTell(resultSet.getString("TELL"));
				officeDTO.setZipcode(resultSet.getString("ZIPCODE"));
				officeDTO.setAddress(resultSet.getString("ADDRESS"));
				officeDTO.setScoreCount(resultSet.getInt("SCORECOUNT"));
				officeDTO.setScoreAverage((int) Math.round((double) resultSet.getInt("SCOREAVERAGE") / 10) * 10);
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
		return officeDTO;
	}
}