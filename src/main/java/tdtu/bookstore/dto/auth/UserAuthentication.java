package tdtu.bookstore.dto.auth;

import tdtu.bookstore.customenum.RoleEnum;
import tdtu.bookstore.customenum.UserTypeEnum;
import lombok.Getter;
import lombok.Setter;
import tdtu.bookstore.customenum.RoleEnum;

@Getter
@Setter
public class UserAuthentication {
	private Integer userId;
	private RoleEnum role;
//	private UserTypeEnum type;

}
