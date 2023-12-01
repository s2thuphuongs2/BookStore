package tdtu.bookstore.service;


import tdtu.bookstore.dto.auth.input.LoginInput;
import tdtu.bookstore.dto.auth.input.SignUpInput;
import tdtu.bookstore.dto.auth.output.LoginOutput;
import tdtu.bookstore.dto.auth.output.SignUpOutput;

public interface AuthService {
    LoginOutput login(LoginInput input);
    SignUpOutput signUp(SignUpInput input);
}
