package org.korgog.dto;

import java.util.Date;
import org.korgog.service.Tools;

public class ScoreDTO {
	private int scoreNum;
	private int memberNum;
	private String memberID;
	private String memberName;
	private int officeNum;
	private String officeSname;
	private String officeFname;
	private String officeAddress;
	private int score;
	private String comments;
	private Date scoringTime;

	public int getScoreNum() {
		return scoreNum;
	}

	public void setScoreNum(int scoreNum) {
		this.scoreNum = scoreNum;
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

	public int getOfficeNum() {
		return officeNum;
	}

	public void setOfficeNum(int officeNum) {
		this.officeNum = officeNum;
	}

	public String getOfficeSname() {
		return officeSname;
	}

	public void setOfficeSname(String officeSname) {
		this.officeSname = officeSname;
	}

	public String getOfficeFname() {
		return officeFname;
	}

	public void setOfficeFname(String officeFname) {
		this.officeFname = officeFname;
	}

	public String getOfficeAddress() {
		return officeAddress;
	}

	public void setOfficeAddress(String officeAddress) {
		this.officeAddress = officeAddress;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getScoringTime() {
		return Tools.dateTime(scoringTime);
	}

	public void setScoringTime(Date scoringTime) {
		this.scoringTime = scoringTime;
	}
}