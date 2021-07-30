package com.recruiters.jobportal.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.stereotype.Component;


/**
 * The persistent class for the user_details database table.
 * 
 */
@Entity
@Table(name="user_details")
@NamedQuery(name="UserDetail.findAll", query="SELECT u FROM UserDetail u")
@Component
public class UserDetail implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="USER_ID")
	private int userId;
	
	@Column(name="CONTACT_PERSON")
	private String contactPerson;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CRTD_TIMESTAMP", updatable = false)
	@CreationTimestamp
	private Date crtdTimestamp;

//	@Temporal(TemporalType.TIMESTAMP)
//	@Column(name="DATE_OF_BIRTH")
//	@CreationTimestamp
//	private Date dateOfBirth = new java.sql.Date(new java.util.Date().getTime());

	@Column(name="EMAIL_ID")
	private String emailId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="LAST_UPDTD_TIMESTAMP")
	@UpdateTimestamp
	private Date lastUpdtdTimestamp;

	@Column(name="MOBILE_NO")
	private String mobileNo;

	@Column(name="ORGANIZATION_NAME")
	private String organizationName;

	private String password;

	@Column(name="USER_STATUS")
	private String userStatus;

	//bi-directional many-to-one association to JobDetail
	@OneToMany(mappedBy="userDetail")
	private List<JobDetail> jobDetails;

	//bi-directional many-to-one association to RoleDetail
	@ManyToOne
	@JoinColumn(name="ROLE_ID")
	private RoleDetail roleDetail; 
	
	public UserDetail() {
		// TODO Auto-generated constructor stub
		setRoleDetail(new RoleDetail());
	}
	
	
	
	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getContactPerson() {
		return this.contactPerson;
	}

	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}

	public Date getCrtdTimestamp() {
		return this.crtdTimestamp;
	}

	public void setCrtdTimestamp(Date crtdTimestamp) {
		this.crtdTimestamp = crtdTimestamp;
	}

	/*
	 * public Date getDateOfBirth() { return this.dateOfBirth; }
	 * 
	 * public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth =
	 * dateOfBirth; }
	 */

	public String getEmailId() {
		return this.emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public Date getLastUpdtdTimestamp() {
		return this.lastUpdtdTimestamp;
	}

	public void setLastUpdtdTimestamp(Date lastUpdtdTimestamp) {
		this.lastUpdtdTimestamp = lastUpdtdTimestamp;
	}

	public String getMobileNo() {
		return this.mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getOrganizationName() {
		return this.organizationName;
	}

	public void setOrganizationName(String organizationName) {
		this.organizationName = organizationName;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserStatus() {
		return this.userStatus;
	}

	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}

	public List<JobDetail> getJobDetails() {
		return this.jobDetails;
	}

	public void setJobDetails(List<JobDetail> jobDetails) {
		this.jobDetails = jobDetails;
	}

	public JobDetail addJobDetail(JobDetail jobDetail) {
		getJobDetails().add(jobDetail);
		jobDetail.setUserDetail(this);

		return jobDetail;
	}

	public JobDetail removeJobDetail(JobDetail jobDetail) {
		getJobDetails().remove(jobDetail);
		jobDetail.setUserDetail(null);

		return jobDetail;
	}

	public RoleDetail getRoleDetail() {
		return this.roleDetail;
	}

	public void setRoleDetail(RoleDetail roleDetail) {
		this.roleDetail = roleDetail;
	}
}