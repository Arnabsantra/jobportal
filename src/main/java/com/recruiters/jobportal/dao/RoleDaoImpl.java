package com.recruiters.jobportal.dao;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.recruiters.jobportal.model.RoleDetail;

@Repository
@Transactional
public class RoleDaoImpl implements RoleDao{

	@Autowired
	SessionFactory sessionFactory;
	
	@Override
	public RoleDetail fetchRecruiterRole() {
		// TODO Auto-generated method stub
		Query<RoleDetail> query = sessionFactory.getCurrentSession().createQuery("from RoleDetail r where r.roleName ='ROLE_RECRUITER'", RoleDetail.class);
		return query.getSingleResult();
	}

}
