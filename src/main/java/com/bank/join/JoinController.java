package com.bank.join;

import org.json.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class JoinController {
	
	
	@PostMapping("/join")
	public ResponseEntity<String> join (){
		
		
		JSONObject json = new JSONObject();
		
		
		return ResponseEntity.ok(json.toString());
	}

}
