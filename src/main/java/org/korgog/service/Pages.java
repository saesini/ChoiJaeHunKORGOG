package org.korgog.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public final class Pages {
	private int currentPage;
	private int rowsPerPage;
	private int pagesPerWindow;
	private int totalRow;
	private int startRow;
	private int endRow;
	private int startPage;
	private int endPage;
	private int prevPage;
	private int nextPage;
	private int totalPage;

	private static Connection connection = null;
	private static PreparedStatement pStatement = null;
	private static ResultSet resultSet = null;

	public Pages() {}

	public Pages(int currentPage, int rowsPerPage, int pagesPerWindow, String querySQL, String searchColumn, String searchString) {
		searchColumn = searchColumn.trim();
		searchString = searchString.trim();
		
		this.setRowsPerPage(rowsPerPage);
		this.setPagesPerWindow(pagesPerWindow);

		try {
			if (searchColumn.length() > 0 && searchString.length() > 0) {
				querySQL += " WHERE " + searchColumn + " LIKE '%' || ? || '%' ";
			}

			connection = DBManager.getConnection();
			pStatement = connection.prepareStatement(querySQL);
			if (searchColumn.length() > 0 && searchString.length() > 0) {
				pStatement.setString(1, searchString);
			}
			resultSet = pStatement.executeQuery();
			if (resultSet.next()) {
				totalRow = resultSet.getInt(1);

				if (totalRow % rowsPerPage == 0) {
					totalPage = totalRow / rowsPerPage;
				} else {
					totalPage = totalRow / rowsPerPage + 1;
				}

				if (currentPage > totalPage) {
					currentPage = totalPage;
				}

				if (totalRow > 1) {
					startRow = totalRow;
				}

				if (currentPage > 1) {
					startRow = totalRow - (currentPage - 1) * rowsPerPage;
				}

				endRow = startRow - rowsPerPage + 1;
				endPage = pagesPerWindow;

				if (currentPage >= pagesPerWindow) {
					startPage = ((currentPage - 1) / pagesPerWindow) * pagesPerWindow;
					if (startPage % pagesPerWindow == 0) {
						startPage++;
					}
					endPage = startPage + pagesPerWindow - 1;
				}
				if (startPage < 1) {
					startPage = 1;
				}

				if (totalPage < pagesPerWindow) {
					endPage = totalPage;
				}

				if (endPage > totalPage) {
					endPage = totalPage;
				}

				prevPage = startPage - 1;
				nextPage = endPage + 1;

				if (prevPage < 1) {
					prevPage = 1;
				}

				if (nextPage > totalPage) {
					nextPage = totalPage;
				}
				
				if (totalRow == 1) {
					startRow = 1;
					endRow = 0;
				}
				
				if (endRow < 0) {
					endRow = 0;
				}

				this.setCurrentPage(currentPage);
				this.setTotalRow(totalRow);
				this.setStartRow(startRow);
				this.setEndRow(endRow);
				this.setStartPage(startPage);
				this.setEndPage(endPage);
				this.setPrevPage(prevPage);
				this.setNextPage(nextPage);
				this.setTotalPage(totalPage);
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
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getRowsPerPage() {
		return rowsPerPage;
	}

	public void setRowsPerPage(int rowsPerPage) {
		this.rowsPerPage = rowsPerPage;
	}

	public int getPagesPerWindow() {
		return pagesPerWindow;
	}

	public void setPagesPerWindow(int pagesPerWindow) {
		this.pagesPerWindow = pagesPerWindow;
	}

	public int getTotalRow() {
		return totalRow;
	}

	public void setTotalRow(int totalRow) {
		this.totalRow = totalRow;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
}