package com.bank.login;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bank.join.JoinDTO;

@Repository
public class LoginDAO {
	
	@Autowired
	private SqlSession sqlSession;

	public LoginDTO login(LoginDTO dto) {
		return sqlSession.selectOne("login.login",dto);
	}

	public LoginDTO checkID(LoginDTO dto) {
		
		return sqlSession.selectOne("login.checkID", dto);
	}

	public LoginDTO accountInfo(LoginDTO dto) {
		
		return sqlSession.selectOne("login.accountInfo", dto);
	}

	public int joincheckID(String id) {
	
		return sqlSession.selectOne("login.joincheckID", id);
	}

	public int joinCreateID(JoinDTO dto) {
		
		return sqlSession.selectOne("login.joinCreateID",dto);
	}

}
