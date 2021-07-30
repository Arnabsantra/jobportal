package com.recruiters.jobportal.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.recruiters.jobportal.model.JobDetail;

@Repository
public class JobDAOImpl implements JobDAO{

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	@Transactional
	public List<JobDetail> fetchJobByUserId(int userId) {
		// TODO Auto-generated method stub
		Query<JobDetail> query = sessionFactory.getCurrentSession().createQuery("from JobDetail where userDetail.userId=:userId and jobStatus='ACTIVE'", JobDetail.class);
		query.setParameter("userId", userId);
		List<JobDetail> jobDetails = query.getResultList();
		return jobDetails;
	}

	@Override
	@Transactional
	public List<JobDetail> fetchAllJob() {
		// TODO Auto-generated method stub
		Query<JobDetail> query = sessionFactory.getCurrentSession().createQuery("from JobDetail where jobStatus='ACTIVE'", JobDetail.class);
		List<JobDetail> jobDetails = query.getResultList();
		return jobDetails;
	}

	@Override
	@Transactional
	public int save(JobDetail jobDetail) {
		// TODO Auto-generated method stub
		int jobId = (int) sessionFactory.getCurrentSession().save(jobDetail);
		return jobId;
	}

	@Override
	@Transactional
	public void update(JobDetail jobDetail) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().update(jobDetail);
	}

	@Override
	@Transactional
	public JobDetail fetchJobById(int jobId) {
		// TODO Auto-generated method stub
		JobDetail jobDetail = sessionFactory.getCurrentSession().get(JobDetail.class, jobId);
		return jobDetail;
	}

	@Override
	@Transactional
	public void deleteJob(JobDetail jobdetail) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		session.delete(jobdetail);
		session.flush();
	}

	@Override
	@Transactional
	public String fetchComment(int JobId) {
		// TODO Auto-generated method stub
		Query<String> query = sessionFactory.getCurrentSession().createQuery("select c.comments FROM JobDetail c where c.jobId = :jobId", String.class);
		query.setParameter("jobId", JobId);
		String comment = query.getSingleResult();
		return comment;
	}

	@Override
	@Transactional
	public List<JobDetail> fetchCreatedJob() {
		// TODO Auto-generated method stub
		Query<JobDetail> query = sessionFactory.getCurrentSession().createQuery("from JobDetail where jobStatus='CREATED'", JobDetail.class);
		List<JobDetail> jobDetails = query.getResultList();
		return jobDetails;
	}

	@Override
	@Transactional
	public Long countJob() {
		// TODO Auto-generated method stub
		Query<Long> query = sessionFactory.getCurrentSession().createQuery("select count(*) from JobDetail j where j.jobStatus='ACTIVE'", Long.class);
		Long count = query.uniqueResultOptional().get();
		return count;
	}

	@Override
	@Transactional
	public List<JobDetail> topNJobs(int num) {
		// TODO Auto-generated method stub
		Query<JobDetail> query = sessionFactory.getCurrentSession().createQuery("from JobDetail j where j.jobStatus='ACTIVE' ORDER by j.crtdTimestamp desc", JobDetail.class).setMaxResults(num);
		List<JobDetail> jobDetails = query.getResultList();
		return jobDetails;
	}
	
	
}
