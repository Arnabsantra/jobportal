package com.recruiters.jobportal.dao;

import java.util.List;

import com.recruiters.jobportal.model.JobDetail;

public interface JobDAO {

	public List<JobDetail> fetchJobByUserId(int userId);
	public List<JobDetail> fetchAllJob();
	public List<JobDetail> fetchCreatedJob();
	public int save(JobDetail jobDetail);
	public void update(JobDetail jobDetail);
	public JobDetail fetchJobById(int jobId);
	public void deleteJob(JobDetail jobdetail);
	public String fetchComment(int JobId);
	public Long countJob();
	public List<JobDetail> topNJobs(int num);
}
