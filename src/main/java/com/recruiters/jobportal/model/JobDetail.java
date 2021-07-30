package com.recruiters.jobportal.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.web.multipart.commons.CommonsMultipartFile;


/**
 * The persistent class for the job_details database table.
 * 
 */
@Entity
@Table(name="job_details")
@NamedQuery(name="JobDetail.findAll", query="SELECT j FROM JobDetail j")
public class JobDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="JOB_ID")
	private int jobId;

	@Column(name="COMPANY_NAME")
	private String companyName;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CRTD_TIMESTAMP", updatable = false)
	@CreationTimestamp
	private Date crtdTimestamp;

	private String ctc;

	private String designation;

	@Column(name="EMPLOYMENT_TYPE")
	private String employmentType;
	
	@Transient
	private String[] employmentTypeArray;

	private String experience;

	@Column(name="JOB_DETAILS")
	private String jobDetails;

	@Column(name="JOB_LOCATION")
	private String jobLocation;

	@Column(name="JOB_STATUS")
	private String jobStatus;

	@Column(name="JOB_TITLE")
	private String jobTitle;

	@Column(name="KEY_SKILLS")
	private String keySkills;
	
	@Column(name="COMMENTS")
	private String comments;
	
	@Column(name="JD_FILE_NAME")
	private String jdFileName;
	
	@Transient
	private CommonsMultipartFile jdFile;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="LAST_UPDTD_TIMESTAMP")
	@UpdateTimestamp
	private Date lastUpdtdTimestamp;

	@Column(name="NO_OF_POSITION")
	private int noOfPosition;

	@Column(name="NOTICE_PERIOD")
	private String noticePeriod;

	//bi-directional many-to-one association to UserDetail
	@ManyToOne
	@JoinColumn(name="USER_ID")
	private UserDetail userDetail;

	public JobDetail() {
	}

	public int getJobId() {
		return this.jobId;
	}

	public void setJobId(int jobId) {
		this.jobId = jobId;
	}

	public String getCompanyName() {
		return this.companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public Date getCrtdTimestamp() {
		return this.crtdTimestamp;
	}

	public void setCrtdTimestamp(Date crtdTimestamp) {
		this.crtdTimestamp = crtdTimestamp;
	}

	public String getCtc() {
		return this.ctc;
	}

	public void setCtc(String ctc) {
		this.ctc = ctc;
	}

	public String getDesignation() {
		return this.designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public String getExperience() {
		return this.experience;
	}

	public void setExperience(String experience) {
		this.experience = experience;
	}

	public String getJobDetails() {
		return this.jobDetails;
	}

	public void setJobDetails(String jobDetails) {
		this.jobDetails = jobDetails;
	}

	public String getJobLocation() {
		return this.jobLocation;
	}

	public void setJobLocation(String jobLocation) {
		this.jobLocation = jobLocation;
	}

	public String getJobStatus() {
		return this.jobStatus;
	}

	public void setJobStatus(String jobStatus) {
		this.jobStatus = jobStatus;
	}

	public String getJobTitle() {
		return this.jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	public String getKeySkills() {
		return this.keySkills;
	}

	public void setKeySkills(String keySkills) {
		this.keySkills = keySkills;
	}

	public Date getLastUpdtdTimestamp() {
		return this.lastUpdtdTimestamp;
	}

	public void setLastUpdtdTimestamp(Date lastUpdtdTimestamp) {
		this.lastUpdtdTimestamp = lastUpdtdTimestamp;
	}

	public int getNoOfPosition() {
		return this.noOfPosition;
	}

	public void setNoOfPosition(int noOfPosition) {
		this.noOfPosition = noOfPosition;
	}

	public String getNoticePeriod() {
		return this.noticePeriod;
	}

	public void setNoticePeriod(String noticePeriod) {
		this.noticePeriod = noticePeriod;
	}

	public UserDetail getUserDetail() {
		return this.userDetail;
	}

	public void setUserDetail(UserDetail userDetail) {
		this.userDetail = userDetail;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getJdFileName() {
		return jdFileName;
	}

	public void setJdFileName(String jdFileName) {
		this.jdFileName = jdFileName;
	}

	public CommonsMultipartFile getJdFile() {
		return jdFile;
	}

	public void setJdFile(CommonsMultipartFile jdFile) {
		this.jdFile = jdFile;
	}

	public String getEmploymentType() {
		return employmentType;
	}

	public void setEmploymentType(String employmentType) {
		this.employmentType = employmentType;
	}

	public String[] getEmploymentTypeArray() {
		return employmentTypeArray;
	}

	public void setEmploymentTypeArray(String[] employmentTypeArray) {
		this.employmentTypeArray = employmentTypeArray;
	}

}