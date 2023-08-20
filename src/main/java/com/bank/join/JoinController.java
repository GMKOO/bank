package com.bank.join;

import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
			
			//System.out.println(checkid);
			//System.out.println(json.toString());
			
			
	
				
				
			return ResponseEntity.ok(json.toString());
		}
		
			
			@PostMapping("/joincreateid")
			public ResponseEntity<String> joinCreateID(JoinDTO dto) {
			
			Boolean result = loginService.joinCreateID(dto);
				
			JSONObject json = new JSONObject();
			System.out.println(result);
		
		
		  
				
				return ResponseEntity.ok(json.toString());
			}
			
			@PostMapping("/serchid")
			public ResponseEntity<String> serchid() {
			
			
				
			JSONObject json = new JSONObject();
	
		
		
		  
				
				return ResponseEntity.ok(json.toString());
			}
			
			@PostMapping("/serchck")
			public ResponseEntity<String> serchck(JoinDTO dto) {
				
				String id=loginService.serchck(dto);
			
			
			
				
			JSONObject json = new JSONObject();
	
			json.put("id", id);
			
			System.out.println("반환값"+id);
			System.out.println("반환값 궁금"+json.toString());
		
		
		  
				
				return ResponseEntity.ok(json.toString());
			}

}

