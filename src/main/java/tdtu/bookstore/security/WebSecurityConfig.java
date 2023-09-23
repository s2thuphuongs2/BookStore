package tdtu.bookstore.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfiguration;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;


@Configuration
@EnableWebSecurity
public class WebSecurityConfig {
	
	@Autowired
	private LoginSuccessHandler loginSuccessHandler;
	
	@Bean
	public DaoAuthenticationProvider getDaoAuthProvider(UserService userService) {
	  DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
	  provider.setUserDetailsService(userService);
	  provider.setPasswordEncoder(new BCryptPasswordEncoder());
	  return provider;
	}
	
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http.csrf().disable()
		.authorizeHttpRequests()
		.requestMatchers("/admin", "/admin/**").hasAnyAuthority("admin")
		.requestMatchers("/checkout", "/checkout/**", "/bills", "/bills/**").hasAnyAuthority("user", "admin")
		.anyRequest().permitAll()
		.and()
		.formLogin().successHandler(loginSuccessHandler)
		.and()
		.logout().logoutSuccessUrl("/");
		


		return http.build();
	}
}
