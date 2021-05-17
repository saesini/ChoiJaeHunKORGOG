package org.korgog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import org.korgog.config.Environment;
import org.korgog.service.DBManager;
import org.korgog.service.Tools;
import org.korgog.dto.AccessLogDTO;
import org.korgog.dto.MemberDTO;

public class MemberDAO {
	private static final String TABLE_MEMBER = Environment.getTABLE_MEMBER();
	private Connection connection = null;
	private PreparedStatement pStatement = null;
	private ResultSet resultSet = null;

	public int getCount(String memberID, String checkColumn, String checkString) {
		int count = 1;
		checkColumn = checkColumn.trim();
		checkString = checkString.trim().toLowerCase();
		try {
			String querySQL = "SELECT COUNT(*) AS GETCOUNT FROM " + TABLE_MEMBER
					+ " WHERE " + checkColumn + " = ?";
			if (memberID.length() > 0) {
				querySQL += " AND MEMBERID != ?";
			}
			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setString(1, checkString);
			if (memberID.length() > 0) {
				pStatement.setString(2, memberID);
			}
			resultSet = pStatement.executeQuery();

			if (resultSet.next()) {
				count = resultSet.getInt("GETCOUNT");
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
		return count;
	}

	public boolean addMember(MemberDTO memberDTO, String ipAddress) {
		boolean result = false;

		try {
			int memberNum = Tools.getTableCount(TABLE_MEMBER) + 1;
			java.sql.Date currentDateTime = new java.sql.Date(Calendar.getInstance().getTime().getTime());

			String querySQL = "INSERT INTO "
					+ TABLE_MEMBER
					+ " ("
					+ "MEMBERNUM, PERMISSION, EMAIL, MEMBERID, PASSWORD, MEMBERNAME, AREA, TELL, BIRTHDAY, GENDER, JOINTIME, UPDATETIME, EXITTIME"
					+ ") VALUES("
					+ "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?"
					+ ")";

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setInt(1, memberNum);
			pStatement.setInt(2, memberDTO.getPermission());
			pStatement.setString(3, memberDTO.getEmail());
			pStatement.setString(4, memberDTO.getMemberID());
			pStatement.setString(5, Tools.getEncrypt(memberDTO.getPassword()));
			pStatement.setString(6, memberDTO.getMemberName());
			pStatement.setString(7, memberDTO.getArea());
			pStatement.setString(8, memberDTO.getTell());
			pStatement.setDate(9, java.sql.Date.valueOf(memberDTO.getBirthday()));
			pStatement.setString(10, memberDTO.getGender());
			pStatement.setDate(11, currentDateTime);
			pStatement.setDate(12, null);
			pStatement.setDate(13, null);
			pStatement.executeUpdate();

			AccessLogDTO accessLogDTO = new AccessLogDTO();
			accessLogDTO.setMemberNum(memberNum);
			accessLogDTO.setIpAddress(ipAddress);
			accessLogDTO.setWorkTable(TABLE_MEMBER);
			accessLogDTO.setWorkNum(memberNum);
			accessLogDTO.setDetail(
					"[회원 가입] ID:" + memberDTO.getMemberID() + ", "
					+ memberDTO.getMemberName() + ", " + memberDTO.getArea());
			accessLogDTO.setAccessTime(currentDateTime);
			AccessLogDAO accessLogDAO = new AccessLogDAO();
			accessLogDAO.addLog(accessLogDTO);

			result = true;
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

		return result;
	}

	public boolean updateMember(MemberDTO memberDTO, String ipAddress) {
		boolean result = false;

		try {
			java.sql.Date currentDateTime = new java.sql.Date(Calendar.getInstance().getTime().getTime());

			String sqlUpdatePassword = "";
			if (memberDTO.getPassword().length() > 0) {
				sqlUpdatePassword = "PASSWORD = ?, ";
			}
			String querySQL = "UPDATE "
					+ TABLE_MEMBER
					+ " SET "
					+ "EMAIL = ?, "
					+ sqlUpdatePassword
					+ "AREA = ?, "
					+ "TELL = ?, "
					+ "UPDATETIME = ? "
					+ "WHERE "
					+ "MEMBERID = ?";
			querySQL = querySQL.replaceAll("  ", " ");

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			int setStatementCount = 1;
			pStatement.setString(setStatementCount++, memberDTO.getEmail());
			if (memberDTO.getPassword().length() > 0) {
				pStatement.setString(setStatementCount++, Tools.getEncrypt(memberDTO.getPassword()));
			}
			pStatement.setString(setStatementCount++, memberDTO.getArea());
			pStatement.setString(setStatementCount++, memberDTO.getTell());
			pStatement.setDate(setStatementCount++, currentDateTime);
			pStatement.setString(setStatementCount, memberDTO.getMemberID());
			pStatement.executeUpdate();

			MemberDTO accessLogMemberDTO = this.getMember(memberDTO.getMemberID());
			AccessLogDTO accessLogDTO = new AccessLogDTO();
			accessLogDTO.setMemberNum(accessLogMemberDTO.getMemberNum());
			accessLogDTO.setIpAddress(ipAddress);
			accessLogDTO.setWorkTable(TABLE_MEMBER);
			accessLogDTO.setWorkNum(accessLogMemberDTO.getMemberNum());
			accessLogDTO.setDetail("[회원 정보수정] ID : " + memberDTO.getMemberID());
			accessLogDTO.setAccessTime(currentDateTime);
			AccessLogDAO accessLogDAO = new AccessLogDAO();
			accessLogDAO.addLog(accessLogDTO);

			result = true;
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

		return result;
	}

	public boolean exitMember(MemberDTO memberDTO, String ipAddress) {
		boolean result = false;

		try {
			java.sql.Date currentDateTime = new java.sql.Date(Calendar.getInstance().getTime().getTime());

			String querySQL = "UPDATE "
					+ TABLE_MEMBER
					+ " SET "
					+ "PASSWORD = '', "
					+ "EXITTIME = ? "
					+ "WHERE "
					+ "MEMBERID = ?";
			querySQL = querySQL.replaceAll("  ", " ");

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setDate(1, currentDateTime);
			pStatement.setString(2, memberDTO.getMemberID());
			pStatement.executeUpdate();

			MemberDTO accessLogMemberDTO = this.getMember(memberDTO.getMemberID());
			AccessLogDTO accessLogDTO = new AccessLogDTO();
			accessLogDTO.setMemberNum(accessLogMemberDTO.getMemberNum());
			accessLogDTO.setIpAddress(ipAddress);
			accessLogDTO.setWorkTable(TABLE_MEMBER);
			accessLogDTO.setWorkNum(accessLogMemberDTO.getMemberNum());
			accessLogDTO.setDetail("[회원 탈퇴] ID : " + memberDTO.getMemberID());
			accessLogDTO.setAccessTime(currentDateTime);
			AccessLogDAO accessLogDAO = new AccessLogDAO();
			accessLogDAO.addLog(accessLogDTO);

			result = true;
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

		return result;
	}

	public MemberDTO getMember(String memberID) {
		MemberDTO outputMemberDTO = new MemberDTO();
		try {
			String querySQL = "SELECT * FROM "
					+ TABLE_MEMBER + " "
					+ "WHERE MEMBERID = ? ";

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setString(1, memberID);
			resultSet = pStatement.executeQuery();

			if (resultSet.next()) {
				outputMemberDTO.setMemberNum(resultSet.getInt("MEMBERNUM"));
				outputMemberDTO.setPermission(resultSet.getInt("PERMISSION"));
				outputMemberDTO.setEmail(resultSet.getString("EMAIL"));
				outputMemberDTO.setMemberID(resultSet.getString("MEMBERID"));
				outputMemberDTO.setMemberName(resultSet.getString("MEMBERNAME"));
				outputMemberDTO.setArea(resultSet.getString("AREA"));
				outputMemberDTO.setTell(resultSet.getString("TELL"));
				outputMemberDTO.setBirthday(resultSet.getString("BIRTHDAY"));
				outputMemberDTO.setGender(resultSet.getString("GENDER"));
				outputMemberDTO.setJoinDate(resultSet.getTimestamp("JOINTIME"));
				outputMemberDTO.setUpdateDate(resultSet.getTimestamp("UPDATETIME"));
				outputMemberDTO.setExitDate(resultSet.getTimestamp("EXITTIME"));
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
		return outputMemberDTO;
	}

	public int getCountLogin(String memberID, String password) {
		int count = 0;
		memberID = memberID.trim().toLowerCase();
		try {
			String querySQL = "SELECT COUNT(*) AS GETCOUNT FROM " + TABLE_MEMBER
					+ " WHERE MEMBERID = ? AND PASSWORD = ? AND EXITTIME IS NULL";
			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setString(1, memberID);
			pStatement.setString(2, Tools.getEncrypt(password));
			resultSet = pStatement.executeQuery();

			if (resultSet.next()) {
				count = resultSet.getInt("GETCOUNT");
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
		return count;
	}

	public void addLoginLog(MemberDTO loginMemberDTO, String ipAddress) {
		java.sql.Date currentDateTime = new java.sql.Date(Calendar.getInstance().getTime().getTime());

		AccessLogDTO accessLogDTO = new AccessLogDTO();
		accessLogDTO.setMemberNum(loginMemberDTO.getMemberNum());
		accessLogDTO.setWorkTable(TABLE_MEMBER);
		accessLogDTO.setIpAddress(ipAddress);
		accessLogDTO.setWorkNum(loginMemberDTO.getMemberNum());
		accessLogDTO.setDetail("[회원 로그인] ID:" + loginMemberDTO.getMemberID());
		accessLogDTO.setAccessTime(currentDateTime);
		AccessLogDAO accessLogDAO = new AccessLogDAO();
		accessLogDAO.addLog(accessLogDTO);
	}

	public String getMemberID(int memberNum) {
		String memberID = "";
		try {
			String querySQL = "SELECT MEMBERID FROM "
					+ TABLE_MEMBER + " "
					+ "WHERE MEMBERNUM=? ";

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setInt(1, memberNum);
			resultSet = pStatement.executeQuery();

			if (resultSet.next()) {
				memberID = resultSet.getString("MEMBERID");
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
		return memberID;
	}

	public int getMemberNum(String memberID) {
		int memberNum = 0;
		try {
			String querySQL = "SELECT MEMBERNUM FROM "
					+ TABLE_MEMBER + " "
					+ "WHERE MEMBERID=? ";

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setString(1, memberID);
			resultSet = pStatement.executeQuery();

			if (resultSet.next()) {
				memberNum = resultSet.getInt("MEMBERNUM");
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
		return memberNum;
	}

		public MemberDTO getMember(MemberDTO inputMemberDTO) {
		MemberDTO outputMemberDTO = new MemberDTO();
		try {
			String querySQL = "SELECT MEMBERNUM, PERMISSION, MEMBERID, MEMBERNAME FROM "
					+ TABLE_MEMBER + " "
					+ "WHERE MEMBERID=? "
					+ "AND PASSWORD=?";

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			pStatement.setString(1, inputMemberDTO.getMemberID());
			pStatement.setString(2, Tools.getEncrypt(inputMemberDTO.getPassword()));
			resultSet = pStatement.executeQuery();

			if (resultSet.next()) {
				outputMemberDTO.setMemberNum(resultSet.getInt("MEMBERNUM"));
				outputMemberDTO.setPermission(resultSet.getInt("PERMISSION"));
				outputMemberDTO.setMemberID(resultSet.getString("MEMBERID"));
				outputMemberDTO.setMemberName(resultSet.getString("MEMBERNAME"));
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

		return outputMemberDTO;
	}
}