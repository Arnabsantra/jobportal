package com.recruiters.jobportal.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.recruiters.jobportal.model.UserDetail;
import com.recruiters.jobportal.util.PasswordEncode;

/**
 * Represents the DAO implementation for user related use cases
 * */
@Repository
public class UserDAOImpl implements UserDAO {

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
	public Integer save(UserDetail user) {
		Integer id = null;
		try {
//			String encoded=new BCryptPasswordEncoder().encode(user.getPassword());
//			user.setPassword(encoded);
			id = (Integer) sessionFactory.getCurrentSession().save(user);
		}catch(HibernateException e) {
			e.printStackTrace();
		}
		return id;
	}
	

	/**
	 * Retrieves the users list
	 * @return list
	 * */
	@Transactional
	@Override
	public List<UserDetail> list() {
		List<UserDetail> list = null;
		try {
			list = new ArrayList<UserDetail>();
			Query<UserDetail> query = sessionFactory.getCurrentSession().createQuery("from UserDetail");
			list = query.getResultList();
		}catch(HibernateException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * Retrieves the user object
	 * @param id
	 * @return user
	 * */
	@Transactional
	@Override
	public UserDetail get(int id) {
		UserDetail user = null;
		try {
			user = (UserDetail)sessionFactory.getCurrentSession().get(UserDetail.class, id);
			
		}catch(HibernateException e) {
			e.printStackTrace();
		}
		return user;
	}

	/**
	 * Delete the user object
	 * @param id
	 * @return flag
	 * */
	@Transactional
	@Override
	public boolean delete(int id) {
		boolean flag = false;
		UserDetail user = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			user = (UserDetail)session.load(UserDetail.class, id);
			session.delete(user);
			flag = true;
		}catch(HibernateException e) {
			e.printStackTrace();
		}
		return flag;
	}

	/**
	 * Retrieves the active user object based on email
	 * @param name
	 * @return user
	 * */
	@Transactional
	@Override
	public UserDetail findActiveUserByEmail(String email) {
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
	
	/**
	 * Retrieves user object based on email
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
			Query<UserDetail> query = sessionFactory.getCurrentSession().createQuery("from UserDetail where emailId = :email", UserDetail.class);
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
	
	@Transactional
	@Override
	public boolean changePassword(String newPassword, UserDetail user) {
		boolean flag = false;
		try {
			String encoded=new BCryptPasswordEncoder().encode(newPassword);
			user.setPassword(encoded);
			sessionFactory.getCurrentSession().update(user);
			flag = true;
		}catch(HibernateException e) {
			e.printStackTrace();
		}
		return flag;
	}


	@Override
	@Transactional
	public void update(UserDetail userDetail) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().update(userDetail);
		
	}


	@Override
	@Transactional
	public List<UserDetail> findCreatedUsers() {
		// TODO Auto-generated method stub
		Query<UserDetail> query = sessionFactory.getCurrentSession().createQuery("from UserDetail where userStatus = 'CREATED'", UserDetail.class);
		List<UserDetail> userList = query.getResultList();
		return userList;
	}
}
