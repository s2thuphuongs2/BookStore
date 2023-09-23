package tdtu.bookstore.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {

		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();

		if (userDetails.getUser().getRole().equals( "admin")) {
			response.sendRedirect("/admin/books");
			return;
		}

		response.sendRedirect(request.getContextPath());
	}
}