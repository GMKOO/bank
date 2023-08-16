package com.bank.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
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
		int interval = 40; 
		LoginDTO checkLogin = loginService.checkID(dto);
		json.put("result", checkLogin.getCount());
		json.put("interval",interval);
		
		if (checkLogin.getCount() == 1) {
			// 세션을 만들어서 로그인 지정 시간동안 유지 시킵니다.
			
			HttpSession session = request.getSession();
			 //15초 설정
		session.setMaxInactiveInterval(interval);  //세션종료시간설정 초단위 20초부여
		session.setAttribute("mname", checkLogin.getM_name());
		session.setAttribute("id",id);
		session.setAttribute("count", checkLogin.getCount());
		
	System.out.println("세션id출력"+dto.getM_id());
	System.out.println("세션id출력1" + id);
		//System.out.println("세션카운트출력"+checkLogin.getCount());
		//System.out.println("세션카운트출력"+session.getAttribute("count")); 1출력함
		
		
		
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
	@PostMapping(value="/name", produces = "application/json; charset=UTF-8")
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
	}
	
	@PostMapping("/accountInfo")
	public ResponseEntity<String> accountInfo (@RequestParam("id") String id) {
		JSONObject json = new JSONObject();
		LoginDTO dto = new LoginDTO();
		dto.setM_id(id);
		LoginDTO result = loginService.accountInfo(dto);
		
		json.put("balance",result.getA_balance());
		json.put("account",result.getA_account_number());
		
		System.out.println(dto.getA_account_number());
		System.out.println(dto.getA_balance());

		System.out.println(json.toString());
	
		
		return ResponseEntity.ok(json.toString());
	}
	
	@PostMapping("/extendSession")
	public ResponseEntity<String> extendSession(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		HttpSession session = request.getSession();
		
		
		if(session.getMaxInactiveInterval() != 0) {
			
		
		   // 현재 시간과 세션 만료 시간 사이의 차이를 계산
		long currentTimeMillis = System.currentTimeMillis();
        long sessionExpirationMillis = session.getLastAccessedTime() + session.getMaxInactiveInterval() * 1000;
        long remainingMillis = sessionExpirationMillis - currentTimeMillis;
        
     // 남은 시간을 초 단위로 계산
        long remainingSeconds = remainingMillis / 1000;

        json.put("remainingTime", remainingSeconds);
        
		}
  
         System.out.println("rest남은시간"+json.toString());
        
		return ResponseEntity.ok(json.toString());
	}
	
	@PostMapping("/sessionextend")
	public ResponseEntity<String> sessionextend(HttpServletRequest request ) {
		JSONObject json = new JSONObject();
	
		int interval = 40; 
		json.put("interval",interval);
		System.out.println("interval추가문"+json.toString());	
	
		return ResponseEntity.ok(json.toString());
		
		} 
	
	@PostMapping("/checkLoginStatus")
	public ResponseEntity<String> checkLoginStatus(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		HttpSession session = request.getSession();
	
		String result = (String) session.getAttribute("id");
		json.put("session",result );
		
		
		System.out.println("새로고침시session값확인"+json.toString());
		
		
		return ResponseEntity.ok(json.toString());
	}
	
}
