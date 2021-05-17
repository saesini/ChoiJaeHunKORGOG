package org.korgog.service;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.korgog.config.Environment;

public class DBManager {
	private static Connection connection = null;
	public static Connection getConnection() {
		try {
			Class.forName(Environment.getDB_DRIVER());
			connection = DriverManager.getConnection(Environment.getDB_URL(), Environment.getDB_USER(), Environment.getDB_PASSWORD());
		} catch (ClassNotFoundException e) {
			System.out.println("오류 Message : " + e.getMessage());
			e.printStackTrace(System.out);
		} catch (SQLException e) {
			System.out.println("오류 SQLException : " + e.getSQLState());
			System.out.println("오류 Message : " + e.getErrorCode() + " - " + e.getMessage());
			e.printStackTrace(System.out);
		} catch (Exception e) {
			System.out.println("오류 Message : " + e.getMessage());
			e.printStackTrace(System.out);
		}
		return connection;
	}

	public static void close(Connection connection, PreparedStatement pStatement, ResultSet resultSet) {
		try {
			if (resultSet != null) {
				resultSet.close();
			}
		} catch (SQLException e) {
			System.out.println("오류 SQLException : " + e.getSQLState());
			System.out.println("오류 Message : " + e.getErrorCode() + " - " + e.getMessage());
			e.printStackTrace(System.out);
		} catch (Exception e) {
			System.out.println("오류 Message : " + e.getMessage());
			e.printStackTrace(System.out);
		}

		try {
			if (pStatement != null) {
				pStatement.close();
			}
		} catch (SQLException e) {
			System.out.println("오류 SQLException : " + e.getSQLState());
			System.out.println("오류 Message : " + e.getErrorCode() + " - " + e.getMessage());
			e.printStackTrace(System.out);
		} catch (Exception e) {
			System.out.println("오류 Message : " + e.getMessage());
			e.printStackTrace(System.out);
		}

		try {
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			System.out.println("오류 SQLException : " + e.getSQLState());
			System.out.println("오류 Message : " + e.getErrorCode() + " - " + e.getMessage());
			e.printStackTrace(System.out);
		} catch (Exception e) {
			System.out.println("오류 Message : " + e.getMessage());
			e.printStackTrace(System.out);
		}
	}

	public static void close(Connection connection, PreparedStatement pStatement) {
		try {
			if (pStatement != null) {
				pStatement.close();
			}
		} catch (SQLException e) {
			System.out.println("오류 SQLException : " + e.getSQLState());
			System.out.println("오류 Message : " + e.getErrorCode() + " - " + e.getMessage());
			e.printStackTrace(System.out);
		} catch (Exception e) {
			System.out.println("오류 Message : " + e.getMessage());
			e.printStackTrace(System.out);
		}

		try {
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			System.out.println("오류 SQLException : " + e.getSQLState());
			System.out.println("오류 Message : " + e.getErrorCode() + " - " + e.getMessage());
			e.printStackTrace(System.out);
		} catch (Exception e) {
			System.out.println("오류 Message : " + e.getMessage());
			e.printStackTrace(System.out);
		}
	}

	public static void close(PreparedStatement pStatement, ResultSet resultSet) {
		try {
			if (resultSet != null) {
				resultSet.close();
			}
		} catch (SQLException e) {
			System.out.println("오류 SQLException : " + e.getSQLState());
			System.out.println("오류 Message : " + e.getErrorCode() + " - " + e.getMessage());
			e.printStackTrace(System.out);
		} catch (Exception e) {
			System.out.println("오류 Message : " + e.getMessage());
			e.printStackTrace(System.out);
		}

		try {
			if (pStatement != null) {
				pStatement.close();
			}
		} catch (SQLException e) {
			System.out.println("오류 SQLException : " + e.getSQLState());
			System.out.println("오류 Message : " + e.getMessage());
			e.printStackTrace(System.out);
		} catch (Exception e) {
			System.out.println("오류 Message : " + e.getMessage());
			e.printStackTrace(System.out);
		}
	}
}