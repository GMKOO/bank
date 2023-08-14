package com.bank.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RestCheckController {
	// 
	@Autowired
	LoginService loginService;
	
	@PostMapping("/checkID")
	public ResponseEntity<String> checkID(@RequestParam("id") String id, @RequestParam("pw") String pw, HttpServletRequest request ) {
//	public ResponseEntity<String> checkID(@RequestParam("id") String id,@RequestParam("pw") String pw) {
		JSONObject json = new JSONObject();
		LoginDTO dto = new LoginDTO();
		dto.setM_id(id);
		dto.setM_pw(pw);
		
		LoginDTO checkLogin = loginService.checkID(dto);
		json.put("result", checkLogin.getCount());
		
		if (checkLogin.getCount() == 1) {
			// 세션을 만들어서 로그인 지정 시간동안 유지 시킵니다.
			
			HttpSession session = request.getSession();
			int interval = 20;  //15초 설정
		session.setMaxInactiveInterval(interval);  //세션종료시간설정 초단위 20초부여
		session.setAttribute("mname", checkLogin.getM_name());
	
		System.out.println("REST컨트롤러출력문"+checkLogin.getM_name());	
	
		
		
			  
			
		//System.out.println(json.toString());
		//System.out.println(dto.getM_id());
		//System.out.println(dto.getM_pw());
		//System.out.println(id+pw);
		
		return ResponseEntity.ok(json.toString());
		
		} else { 
			json.put("result", "0");
			return ResponseEntity.ok(json.toString());
			}
	} 
	@GetMapping(value="/name", produces = "application/json; charset=UTF-8")
	public ResponseEntity<String> name(HttpServletRequest request) {
		HttpSession session = request.getSession();
	    JSONObject json = new JSONObject();
	    String mname =(String) session.getAttribute("mname"); 
	 
	    json.put("mname", mname);
	        //json.put("mname", session.getAttribute("mname"));
	  
	        //String jsonString = json.toString();
	        //HttpHeaders headers = new HttpHeaders();
	       // headers.setContentType(MediaType.APPLICATION_JSON);
	        System.out.println("mname컨트롤러"+mname);
	       
	        
	        //return new ResponseEntity<>(mname, headers, HttpStatus.OK);
	        return ResponseEntity.ok(json.toString());
	     
	     
	      
		    
	
		//return ResponseEntity.ok(json.toString());
	}
	
	
}
