package tdtu.bookstore.service.impl;

import tdtu.bookstore.service.AuthService;
import tdtu.bookstore.repository.UserRepository;

import tdtu.bookstore.customenum.RoleEnum;
//import com.example.shoponline.customenum.UserTypeEnum;
import tdtu.bookstore.dto.auth.UserAuthentication;
import tdtu.bookstore.dto.auth.input.LoginInput;
import tdtu.bookstore.dto.auth.input.SignUpInput;
import tdtu.bookstore.dto.auth.output.LoginOutput;
import tdtu.bookstore.dto.auth.output.SignUpOutput;
import tdtu.bookstore.model.User;
import tdtu.bookstore.exception.BusinessException;
import tdtu.bookstore.mapper.UserMapper;
import tdtu.bookstore.util.AuthUtil;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class AuthServiceImpl implements AuthService {

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private ObjectMapper objectMapper;
	@Autowired
	private RedisTemplate<String, Object> redisTemplate;

	@Value("${app.secret-key}")
	private String secretKey;

	@Override
	public LoginOutput login(LoginInput input) {
		Object test = redisTemplate.opsForValue().get("test");
		if (test != null) return (LoginOutput) test;
		// Kiểm tra username có tồn tại chưa
		String username = input.getUsername();
		User existedUser = userRepository.findByUsername(username);
		if (existedUser == null) {
			throw new BusinessException("NOT_EXISTED_USERNAME", "Tài khoản chưa tồn tại!");
		}
		String hashedPassword = AuthUtil.hashPassword(input.getPassword());
		String savedPassword = existedUser.getPassword();
		if (!hashedPassword.equals(savedPassword)) {
			throw new BusinessException("INCORRECT_PASSWORD", "Mật khẩu nhập không chính xác!");
		}
		// Generate jwt(json web token) and return
		UserAuthentication userAuthentication = new UserAuthentication();
		userAuthentication.setUserId(existedUser.getId());
		userAuthentication.setRole(existedUser.getRole());
//		userAuthentication.setType(existedUser.getType());
		Map<String, Object> payload = objectMapper.convertValue(userAuthentication, new TypeReference<>() {
		});
		LoginOutput output = new LoginOutput();
		output.setUserId(existedUser.getId());
		output.setToken(AuthUtil.generateToken(payload, secretKey));
		redisTemplate.delete("test");
		return output;
	}

	@Override
	public SignUpOutput signUp(SignUpInput input) {
		// Kiểm tra username có tồn tại chưa
		String username = input.getUsername();
		User existedUsername = userRepository.findByUsername(username);
		if (existedUsername != null) {
			throw new BusinessException("EXISTED_USERNAME", "Tài khoản đã tồn tại!");
		}
		String phoneNumber = input.getPhone();
		User existedPhoneNumber = userRepository.findFirstByPhoneNumber(phoneNumber);
		if (existedPhoneNumber != null) {
			throw new BusinessException("EXISTED_PHONE_NUMBER", "Số điện thoại đã tồn tại!");
		}
		User newUser = UserMapper.INSTANCE.mapFromSignUpInput(input);
		newUser.setRole(RoleEnum.USER);
//		newUser.setType(UserTypeEnum.BASIC);
		userRepository.save(newUser);

		return new SignUpOutput(newUser.getId());
	}
}
