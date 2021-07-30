package com.recruiters.jobportal.dao;

import com.recruiters.jobportal.model.TmpUser;
import com.recruiters.jobportal.model.UserDetail;

/**
 * Represents the DAO for user related use cases
 * */
public interface TmpUserDAO {
	
	void save(TmpUser tmpUser);
	UserDetail findUserByEmail(String email);
	TmpUser get(String email);
}
