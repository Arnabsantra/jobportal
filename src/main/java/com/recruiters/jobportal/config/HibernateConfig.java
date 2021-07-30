package com.recruiters.jobportal.config;

import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.hibernate.SessionFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBuilder;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.recruiters.jobportal.constants.ApplicationConstants;

/**
 * Represents the hibernate configuration/spring integration
 * */
@Configuration
@ComponentScan(basePackages={"com.recruiters.jobportal"})
@EnableTransactionManagement
public class HibernateConfig {
	
	@Bean
	public DataSource getDataSource() {
		
		BasicDataSource dataSource = new BasicDataSource();
		
		//Providing the database connection information
		dataSource.setDriverClassName(ApplicationConstants.DATABASE_DRIVER);
		dataSource.setUrl(ApplicationConstants.DATABASE_URL);
		dataSource.setUsername(ApplicationConstants.DATABASE_USERNAME);
		dataSource.setPassword(ApplicationConstants.DATABASE_PASSWORD);
		
		return dataSource;
	}
	
	@Bean
	public SessionFactory getSessionFactory(DataSource dataSource) {
		
		LocalSessionFactoryBuilder builder = new LocalSessionFactoryBuilder(dataSource);
		
		builder.addProperties(getHibernateProperties());
		builder.scanPackages("com.recruiters.jobportal.model");
		
		return builder.buildSessionFactory();
	}

	//All the hibernate properties will be returned in this method
	private Properties getHibernateProperties() {
		Properties properties = new Properties();
		properties.put("hibernate.dialect", ApplicationConstants.DATABASE_DIALECT);
		properties.put("hibernate.show_sql", "true");
		properties.put("hibernate.format_sql", "true");
		return properties;
	}
	
	@Bean
	public HibernateTransactionManager getTransactionManager(SessionFactory sessionFactory) {
		HibernateTransactionManager transactionManager = new HibernateTransactionManager(sessionFactory);
		return transactionManager;
	}
}
