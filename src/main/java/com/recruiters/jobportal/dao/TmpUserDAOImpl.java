package com.recruiters.jobportal.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.recruiters.jobportal.model.TmpUser;
import com.recruiters.jobportal.model.UserDetail;
import com.recruiters.jobportal.util.PasswordEncode;

/**
 * Represents the DAO implementation for user related use cases
 * */
@Repository
public class TmpUserDAOImpl implements TmpUserDAO {

	@Autowired
	SessionFactory sessionFactory;
	
	BCryptPasswordEncoder bCryptPasswordEncoder = PasswordEncode.encode();
	
	/**
	 * Saves the user object
	 * @param user
	 * @return flag
	 * */
	/*
	 * @Transactional
	 * 
	 * @Override public boolean save(UserDetail user) { boolean flag = false; try {
	 * String encoded=new BCryptPasswordEncoder().encode(user.getPassword());
	 * user.setPassword(encoded);
	 * sessionFactory.getCurrentSession().saveOrUpdate(user); flag = true;
	 * }catch(HibernateException e) { e.printStackTrace(); } return flag; }
	 */
	
	@Transactional
	@Override
	public void save(TmpUser user) {
		String encoded=new BCryptPasswordEncoder().encode(user.getPassword());
		user.setPassword(encoded);
		sessionFactory.getCurrentSession().saveOrUpdate(user);
	}
	

	/**
	 * Retrieves the user object
	 * @param id
	 * @return user
	 * */
	@Transactional
	@Override
	public TmpUser get(String email) {
		TmpUser user = null;
		try {
			user = (TmpUser)sessionFactory.getCurrentSession().get(TmpUser.class, email);
			
		}catch(HibernateException e) {
			e.printStackTrace();
		}
		return user;
	}

	/**
	 * Retrieves the user object based on name
	 * @param name
	 * @return user
	 * */
	@Transactional
	@Override
	public UserDetail findUserByEmail(String email) {
		List<UserDetail> list = null;
		UserDetail user = null;
		try {
			list = new ArrayList<UserDetail>();
			Query<UserDetail> query = sessionFactory.getCurrentSession().createQuery("from UserDetail where emailId = :email and userStatus = 'ACTIVE'", UserDetail.class);
			query.setParameter("email", email);
			list = query.getResultList();
			if(list.size() > 0) {
				user = list.get(0);
			}
		}catch(HibernateException e) {
			e.printStackTrace();
		}
		return user;
	}
	
}
