package com.recruiters.jobportal.dao;

import java.util.List;

import com.recruiters.jobportal.model.UserDetail;

/**
 * Represents the DAO for user related use cases
 * */
public interface UserDAO {
	
	Integer save(UserDetail user);
	
	List<UserDetail> list();
	
	UserDetail get(int id);
	
	boolean delete(int id);
	
	UserDetail findActiveUserByEmail(String email);
	
	UserDetail findUserByEmail(String email);
	
	boolean changePassword(String newPassword, UserDetail user);
	void update(UserDetail userDetail);
	List<UserDetail> findCreatedUsers();
	
}
