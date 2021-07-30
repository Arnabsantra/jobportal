package com.recruiters.jobportal.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;


/**
 * The persistent class for the tmp_user database table.
 * 
 */
@Entity
@Table(name="tmp_user")
@NamedQuery(name="TmpUser.findAll", query="SELECT t FROM TmpUser t")
public class TmpUser implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="EMAIL_ID")
	private String emailId;

	@Column(name="CONTACT_PERSON")
	private String contactPerson;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CRTD_TIMESTAMP", updatable = false)
	@CreationTimestamp
	private Date crtdTimestamp;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="LAST_UPDTD_TIMESTAMP")
	@UpdateTimestamp
	private Date lastUpdtdTimestamp;

	@Column(name="MOBILE_NO")
	private String mobileNo;

	@Column(name="ORGANIZATION_NAME")
	private String organizationName;

	private String otp;

	private String password;

	@Column(name="ROLE_ID")
	private int roleId;

	public TmpUser() {
	}

	public String getEmailId() {
		return this.emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
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

	public String getOtp() {
		return this.otp;
	}

	public void setOtp(String otp) {
		this.otp = otp;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getRoleId() {
		return this.roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
}