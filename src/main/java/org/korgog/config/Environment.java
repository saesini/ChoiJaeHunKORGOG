package org.korgog.config;

public class Environment {
	// DBMS 접속 정보
	private static final String DB_DRIVER = "oracle.jdbc.driver.OracleDriver"; // DBMS 접속 드라이버
	private static final String DB_HOST = "localhost"; // DBMS 서버 호스트
	private static final int DB_PORT = 1521; // DBMS 서버 포트 번호
	private static final String DB_SID = "XE"; // DBMS 인스턴스
	private static final String DB_URL = "jdbc:oracle:thin:@" + DB_HOST + ":" + DB_PORT + ":" + DB_SID; // DBMS 접속 URL
	private static final String DB_USER = "saesini"; // DBMS 사용자명
	private static final String DB_PASSWORD = "testpass"; // DBMS 사용자 비밀번호

	// DBMS 내 테이블명 정보
	private static final String TABLE_ACCESSLOG = "ACCESSLOG"; // 사용 기록(액세스 로그)
	private static final String TABLE_OFFICE = "OFFICE"; // 관공서 정보
	private static final String TABLE_SCORE = "SCORE"; // 관공서 평가
	private static final String TABLE_MEMBER = "MEMBER"; // 회원 정보
	private static final String TABLE_BOARD = "BOARD"; // 게시판 - 게시물

	// 관공서 출력 정보
	private static final int OFFICE_LIST_ROWS = 20; // 페이지당 출력할 행 수
	private static final int OFFICE_LIST_PAGES = 10; // 페이지 수 출력단위

	// 평가 리스트 출력 정보
	private static final int SCORE_LIST_ROWS = 30; // 페이지당 출력할 행 수
	private static final int SCORE_LIST_PAGES = 10; // 페이지 수 출력단위
	private static final int SCORE_OFFICE_ROWS = 30; // 광공서 상세정보에서 출력할 최근 평가의 갯수

	// 게시판 출력 정보
	private static final int BOARD_LIST_ROWS = 20; // 페이지당 출력할 행 수
	private static final int BOARD_LIST_PAGES = 10; // 페이지 수 출력단위

	// 회원로그 출력 정보
	private static final int ACCESSLOG_LIST_ROWS = 20; // 페이지당 출력할 행 수
	private static final int ACCESSLOG_LIST_PAGES = 10; // 페이지 수 출력단위

	public static String getDB_DRIVER() {
		return DB_DRIVER;
	}

	public static String getDB_HOST() {
		return DB_HOST;
	}

	public static int getDB_PORT() {
		return DB_PORT;
	}

	public static String getDB_SID() {
		return DB_SID;
	}

	public static String getDB_URL() {
		return DB_URL;
	}

	public static String getDB_USER() {
		return DB_USER;
	}

	public static String getDB_PASSWORD() {
		return DB_PASSWORD;
	}

	public static String getTABLE_ACCESSLOG() {
		return TABLE_ACCESSLOG;
	}

	public static String getTABLE_OFFICE() {
		return TABLE_OFFICE;
	}

	public static String getTABLE_SCORE() {
		return TABLE_SCORE;
	}

	public static String getTABLE_MEMBER() {
		return TABLE_MEMBER;
	}

	public static String getTABLE_BOARD() {
		return TABLE_BOARD;
	}

	public static int getOFFICE_LIST_ROWS() {
		return OFFICE_LIST_ROWS;
	}

	public static int getOFFICE_LIST_PAGES() {
		return OFFICE_LIST_PAGES;
	}

	public static int getSCORE_OFFICE_ROWS() {
		return SCORE_OFFICE_ROWS;
	}

	public static int getSCORE_LIST_ROWS() {
		return SCORE_LIST_ROWS;
	}

	public static int getSCORE_LIST_PAGES() {
		return SCORE_LIST_PAGES;
	}

	public static int getBOARD_LIST_ROWS() {
		return BOARD_LIST_ROWS;
	}

	public static int getBOARD_LIST_PAGES() {
		return BOARD_LIST_PAGES;
	}

	public static int getACCESSLOG_LIST_ROWS() {
		return ACCESSLOG_LIST_ROWS;
	}

	public static int getACCESSLOG_LIST_PAGES() {
		return ACCESSLOG_LIST_PAGES;
	}
}