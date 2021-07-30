package com.recruiters.jobportal.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

  @Autowired
  private UserDetailsService userDetailsService;
  
  @Bean
  public BCryptPasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
  };
  
  @Override
  protected void configure(AuthenticationManagerBuilder auth) throws Exception {
    auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
  }

  @Override
  protected void configure(HttpSecurity http) throws Exception {
	 http.authorizeRequests().antMatchers("/", "/home", "/index").permitAll()
	 .antMatchers("/job/**").hasAnyRole("ADMIN","RECRUITER")
	 .antMatchers("/user/viewCreatedUser").hasAnyRole("ADMIN")
	 .antMatchers("/user/approveUser").hasAnyRole("ADMIN")
	 .antMatchers("/user/**").permitAll()
	 .antMatchers("/resources/**").permitAll()
	 .and()
     .authorizeRequests().antMatchers("/login**").permitAll()
     .and()
     .formLogin().loginPage("/login").loginProcessingUrl("/loginAction").defaultSuccessUrl("/job/jobDetails")
     .and()
     .logout().permitAll()
     .and()
//     .requiresChannel().anyRequest().requiresSecure()
//     .and()
	 .csrf().disable().exceptionHandling().accessDeniedPage("/access-denied");
  }
}
