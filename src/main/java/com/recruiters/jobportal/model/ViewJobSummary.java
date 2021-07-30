package com.recruiters.jobportal.model;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigInteger;


/**
 * The persistent class for the view_job_summary database table.
 * 
 */
@Entity
@Table(name="view_job_summary")
@NamedQuery(name="ViewJobSummary.findAll", query="SELECT v FROM ViewJobSummary v")
public class ViewJobSummary implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="TOTAL_JOB_COUNT")
	private BigInteger totalJobCount;

	public ViewJobSummary() {
	}

	public BigInteger getTotalJobCount() {
		return this.totalJobCount;
	}

	public void setTotalJobCount(BigInteger totalJobCount) {
		this.totalJobCount = totalJobCount;
	}

}