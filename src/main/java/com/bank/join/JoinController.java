package com.bank.join;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bank.login.LoginService;

@RestController
public class JoinController {

	@Autowired
	LoginService loginService;
	
	@PostMapping("/join")
	public ResponseEntity<String> join (){
		
		
		JSONObject json = new JSONObject();
		
		
		return ResponseEntity.ok(json.toString());
	}
	

		
		@PostMapping("/joincheckid")
		
		public ResponseEntity<String> joincheckID(@RequestParam("id") String id) {
		JSONObject json = new JSONObject();
					
		 
			int checkid = loginService.joincheckID(id);
			json.put("result", checkid);
			
			System.out.println(checkid);
			System.out.println(json.toString());
			
			
	
				
				
			return ResponseEntity.ok(json.toString());
		}
		
		
			@PostMapping("/joincreateid")
			public ResponseEntity<String> joinCreateID(@ModelAttribute JoinDTO dto) {
			
			int result=loginService.joinCreateID(dto);
				
			JSONObject json = new JSONObject();
			System.out.println(result);
			System.out.println(dto.getId());
			
		
		  
				
				return ResponseEntity.ok(json.toString());
			}

}

