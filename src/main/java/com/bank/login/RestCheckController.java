package com.bank.login;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RestCheckController {
	// produces = "application/json"
	@Autowired
	LoginService loginService;
	
	@PostMapping("/checkID")
	public String checkID(@RequestParam("id") String id, @RequestParam("pw") String pw ) {
//	public ResponseEntity<String> checkID(@RequestParam("id") String id,@RequestParam("pw") String pw) {
		JSONObject json = new JSONObject();
		LoginDTO dto = new LoginDTO();
		dto.setM_id(id);
		dto.setM_pw(pw);
		
		int checkLogin = loginService.checkID(dto);
		json.put("result", checkLogin);
		
		System.out.println(json.toString());
		System.out.println(dto.getM_id());
		System.out.println(dto.getM_pw());
		System.out.println(id+pw);
		
		return json.toString();
	}
}
