package org.korgog.dto;

import java.util.Date;
import org.korgog.service.Tools;

public class AccessLogDTO {
	private int accessLogNum;
	private int memberNum;
	private String memberID;
	private String memberName;
	private String ipAddress;
	private String workTable;
	private int workNum;
	private String detail;
	private Date accessTime;

	public int getAccessLogNum() {
		return accessLogNum;
	}

	public void setAccessLogNum(int accessLogNum) {
		this.accessLogNum = accessLogNum;
	}

	public int getMemberNum() {
		return memberNum;
	}

	public void setMemberNum(int memberNum) {
		this.memberNum = memberNum;
	}

	public String getMemberID() {
		return memberID;
	}

	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	public String getWorkTable() {
		return workTable;
	}

	public void setWorkTable(String workTable) {
		this.workTable = workTable;
	}

	public int getWorkNum() {
		return workNum;
	}

	public void setWorkNum(int workNum) {
		this.workNum = workNum;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getAccessTime() {
		return Tools.dateTime(accessTime);
	}

	public void setAccessTime(Date accessTime) {
		this.accessTime = accessTime;
	}
}