package tdtu.bookstore.service;


import tdtu.bookstore.dto.auth.input.LoginInput;
import tdtu.bookstore.dto.auth.input.SignUpInput;
import tdtu.bookstore.dto.auth.output.LoginOutput;
import tdtu.bookstore.dto.auth.output.SignUpOutput;
import tdtu.bookstore.model.User;

public interface AuthService {
    String login(User input);
    String signUp(User input);
}
