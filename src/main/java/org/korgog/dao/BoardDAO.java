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
import org.korgog.dto.BoardDTO;

public class BoardDAO {
	private final String TABLE_BOARD = Environment.getTABLE_BOARD();
	private final String TABLE_MEMBER = Environment.getTABLE_MEMBER();
	private Connection connection = null;
	private PreparedStatement pStatement = null;
	private ResultSet resultSet = null;

	public void write(BoardDTO boardDTO, String ipAddress) {
		try {
			int boardNum = Tools.getTableNum(TABLE_BOARD, "") + 1;
			java.sql.Date currentDateTime = new java.sql.Date(Calendar.getInstance().getTime().getTime());

			String querySQL = "INSERT INTO "
					+ TABLE_BOARD
					+ " ("
					+ "BOARDNUM, MEMBERNUM, SUBJECT, CONTENT, WRITETIME, EDITTIME"
					+ ") VALUES("
					+ "?, ?, ?, ?, ?, ?"
					+ ")";
			querySQL = querySQL.replaceAll("  ", " ");

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setInt(1, boardNum);
			pStatement.setInt(2, boardDTO.getMemberNum());
			pStatement.setString(3, boardDTO.getSubject());
			pStatement.setString(4, boardDTO.getContent());
			pStatement.setDate(5, currentDateTime);
			pStatement.setDate(6, null);
			pStatement.executeUpdate();

			MemberDAO memberDAO = new MemberDAO();
			AccessLogDTO accessLogDTO = new AccessLogDTO();
			accessLogDTO.setMemberNum(boardDTO.getMemberNum());
			accessLogDTO.setIpAddress(ipAddress);
			accessLogDTO.setWorkTable(TABLE_BOARD);
			accessLogDTO.setWorkNum(boardNum);
			accessLogDTO.setDetail(
					"[게시판 글작성] ID:" + memberDAO.getMemberID(boardDTO.getMemberNum()) + ", "
					+ "글번호:" + boardNum + ", "
					+ "글제목:" + boardDTO.getSubject());
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

	public void edit(BoardDTO boardDTO, String ipAddress, int boardNum, int memberNum) {
		try {
			java.sql.Date currentDateTime = new java.sql.Date(Calendar.getInstance().getTime().getTime());

			String querySQL = "UPDATE "
					+ TABLE_BOARD
					+ " SET "
					+ "SUBJECT = ?, "
					+ "CONTENT = ?, "
					+ "EDITTIME = ? "
					+ "WHERE "
					+ "BOARDNUM = ? AND MEMBERNUM = ?";
			querySQL = querySQL.replaceAll("  ", " ");

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setString(1, boardDTO.getSubject());
			pStatement.setString(2, boardDTO.getContent());
			pStatement.setDate(3, currentDateTime);
			pStatement.setInt(4, boardNum);
			pStatement.setInt(5, memberNum);
			pStatement.executeUpdate();

			MemberDAO memberDAO = new MemberDAO();
			AccessLogDTO accessLogDTO = new AccessLogDTO();
			accessLogDTO.setMemberNum(memberNum);
			accessLogDTO.setIpAddress(ipAddress);
			accessLogDTO.setWorkTable(TABLE_BOARD);
			accessLogDTO.setWorkNum(boardNum);
			accessLogDTO.setDetail(
					"[게시판 글수정] ID:" + memberDAO.getMemberID(memberNum) + ", "
					+ "글번호:" + boardNum + ", "
					+ "글제목:" + boardDTO.getSubject());
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

	public void hit(int boardNum) {
		try {
			String querySQL = "UPDATE "
					+ TABLE_BOARD
					+ " SET "
					+ "HITS = HITS + 1 "
					+ "WHERE "
					+ "BOARDNUM = ?";

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setInt(1, boardNum);
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

	public void delete(BoardDTO boardDTO, String ipAddress) {
		try {
			String querySQL = "DELETE FROM "
					+ TABLE_BOARD
					+ " A WHERE EXISTS "
					+ "(SELECT * FROM "
					+ TABLE_MEMBER
					+ " B WHERE A.MEMBERNUM=B.MEMBERNUM AND "
					+ "B.MEMBERID = ?) AND "
					+ "BOARDNUM = ?";

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setString(1, boardDTO.getMemberID());
			pStatement.setInt(2, boardDTO.getBoardNum());
			pStatement.executeUpdate();

			java.sql.Date currentDateTime = new java.sql.Date(Calendar.getInstance().getTime().getTime());
			MemberDAO memberDAO = new MemberDAO();
			AccessLogDTO accessLogDTO = new AccessLogDTO();
			accessLogDTO.setMemberNum(memberDAO.getMemberNum(boardDTO.getMemberID()));
			accessLogDTO.setIpAddress(ipAddress);
			accessLogDTO.setWorkTable(TABLE_BOARD);
			accessLogDTO.setWorkNum(boardDTO.getBoardNum());
			accessLogDTO.setDetail(
					"[게시판 글삭제] ID:" + boardDTO.getMemberID() + ", "
					+ "글번호:" + boardDTO.getBoardNum());
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

	public Pages getPage(int currentPage, String searchColumn, String searchString) {
		searchColumn = searchColumn.trim();
		searchString = searchString.trim();

		String querySQL = "SELECT COUNT(*) AS TOTALROW FROM " + TABLE_BOARD + " NATURAL JOIN " + TABLE_MEMBER;

		int rowsPerPage = Environment.getBOARD_LIST_ROWS();
		int pagesPerWindow = Environment.getBOARD_LIST_PAGES();

		Pages page = new Pages(currentPage, rowsPerPage, pagesPerWindow, querySQL, searchColumn, searchString);
		return page;
	}

	public List<BoardDTO> getList(int currentPage, int startRow, int endRow, String searchColumn, String searchString) {
		List<BoardDTO> listDTO = null;
		searchColumn = searchColumn.trim();
		searchString = searchString.trim();

		try {
			String queryWhere = "";
			if (searchColumn.length() > 0 && searchString.length() > 0) {
				queryWhere = "AND " + searchColumn + " LIKE '%' || ? || '%' ";
			}

			String querySQL = "SELECT  * FROM "
					+ "("
					+ "SELECT ROWNUM AS RNUM, "
					+ "BOARDNUM, SUBJECT, MEMBERNAME, MEMBERID, WRITETIME, HITS "
					+ "FROM " + TABLE_BOARD + " NATURAL JOIN " + TABLE_MEMBER
					+ " WHERE ROWNUM <= ? "
					+ "queryWhere"
					+ ") "
					+ "WHERE RNUM >= ? ORDER BY RNUM DESC";
			querySQL = querySQL.replace("queryWhere", queryWhere);

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setInt(1, startRow);
			if (queryWhere.length() > 0) {
				pStatement.setString(2, searchString);
				pStatement.setInt(3, endRow);
			} else {
				pStatement.setInt(2, endRow);
			}

			resultSet = pStatement.executeQuery();
			if (resultSet.next()) {
				listDTO = new ArrayList<>();
				do {
					BoardDTO boardDTO = new BoardDTO();
					boardDTO.setBoardNum(resultSet.getInt("BOARDNUM"));
					boardDTO.setSubject(resultSet.getString("SUBJECT"));
					boardDTO.setMemberID(resultSet.getString("MEMBERID"));
					boardDTO.setMemberName(resultSet.getString("MEMBERNAME"));
					boardDTO.setWriteTime(resultSet.getTimestamp("WRITETIME"));
					boardDTO.setHits(resultSet.getInt("HITS"));
					listDTO.add(boardDTO);
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

	public BoardDTO getView(int num) {
		BoardDTO boardDTO = new BoardDTO();
		try {
			String querySQL = "SELECT BOARDNUM, MEMBERNUM, MEMBERID, MEMBERNAME, SUBJECT, CONTENT, WRITETIME, EDITTIME, HITS FROM "
					+ TABLE_BOARD + " NATURAL JOIN " + TABLE_MEMBER
					+ " WHERE BOARDNUM = ?";

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setInt(1, num);
			resultSet = pStatement.executeQuery();

			if (resultSet.next()) {
				boardDTO.setBoardNum(resultSet.getInt("BOARDNUM"));
				boardDTO.setMemberNum(resultSet.getInt("MEMBERNUM"));
				boardDTO.setMemberID(resultSet.getString("MEMBERID"));
				boardDTO.setMemberName(resultSet.getString("MEMBERNAME"));
				boardDTO.setSubject(resultSet.getString("SUBJECT"));
				boardDTO.setContent(resultSet.getString("CONTENT"));
				boardDTO.setWriteTime(resultSet.getTimestamp("WRITETIME"));
				boardDTO.setEditTime(resultSet.getTimestamp("EDITTIME"));
				boardDTO.setHits(resultSet.getInt("HITS"));
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
		return boardDTO;
	}
}