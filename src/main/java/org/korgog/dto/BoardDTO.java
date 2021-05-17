package org.korgog.dto;

import java.util.Date;
import org.korgog.service.Tools;

public class BoardDTO {
	private int boardNum;
	private int memberNum;
	private String memberID;
	private String memberName;
	private String subject;
	private String content;
	private Date writeTime;
	private Date editTime;
	private int hits;

	public int getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
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

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriteTime() {
		return Tools.dateTime(writeTime);
	}

	public void setWriteTime(Date writeTime) {
		this.writeTime = writeTime;
	}

	public String getEditTime() {
		if (editTime != null) {
			return Tools.dateTime(editTime);
		} else {
			return "수정내역 없음";
		}
	}

	public void setEditTime(Date editTime) {
		this.editTime = editTime;
	}

	public int getHits() {
		return hits;
	}

	public void setHits(int hits) {
		this.hits = hits;
	}
}