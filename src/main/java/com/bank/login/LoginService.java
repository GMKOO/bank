package com.bank.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

	@Autowired
	private LoginDAO loginDAO;
	
	public LoginDTO login(LoginDTO dto) {
		
		return loginDAO.login(dto);
	}

	public LoginDTO checkID(LoginDTO dto) {
		
		return loginDAO.checkID(dto);
	}

	
	
	
/*
	// final로 설정하는것은 비밀번호가 이후에 변경 될수 없게 할려는거
	//BCryptPasswordEncoder 사용시 pom에 프러퍼티 스프링부트 추가해주고 메이븐 도 넣어줘야된다
	    private final BCryptPasswordEncoder passwordEncoder;

	   
	    //생성자는 리턴값을 가지지않는다 
	    @Autowired
	    public LoginService(BCryptPasswordEncoder passwordEncoder ) {
	        this.passwordEncoder = passwordEncoder;
	    }

	    public String encodePassword(String rawPassword) {
	        // 패스워드를 암호화하여 반환
	        return passwordEncoder.encode(rawPassword);
	    }

	    public boolean isPasswordMatch(String rawPassword, String encodedPassword) {
	        // 입력된 비밀번호와 저장된 암호화된 비밀번호를 비교하여 일치 여부를 반환
	        return passwordEncoder.matches(rawPassword, encodedPassword);
	    }
	    */
	}


