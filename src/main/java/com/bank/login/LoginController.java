package com.bank.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;





@Controller
public class LoginController {
	
	
	@Autowired
	private LoginService loginService;
	
	@GetMapping("/login")
	public String login() {
		
		
		
		return "login";
	}
	@GetMapping(value= { "/" , "/index","/home"} )
	public String home() {
		
		
		return "home";
	}
	
	@GetMapping("/join")
	public String join() {
		return "join";
	}
	
	@GetMapping("/warning")
	public String warning() {
		return "warning";
	}
	
	@PostMapping("/login")
	public String login(HttpServletRequest request) {

		LoginDTO dto = new LoginDTO();
		
		
		dto.setM_id(request.getParameter("id"));

		dto.setM_pw(request.getParameter("pw"));
		
	
		LoginDTO result = loginService.login(dto);
	
		// 제이슨에서getparameter한거는 클라이언트에서 받아온거임 

		System.out.println("로그인컨트롤러출력문"+result.getM_name());
		System.out.println("로그인컨트롤러출력문"+result.getCount());
		
		
		if (result.getCount() == 1) {
			// 세션을 만들어서 로그인 지정 시간동안 유지 시킵니다.
			
			HttpSession session = request.getSession();
			long cTime=session.getCreationTime();
			long laTime=session.getLastAccessedTime();
			
			//세션타임아웃 구현하기위해 jsp로 보낼 모델구현 
			int interval = 600;  //15초 설정
			session.setMaxInactiveInterval(interval);  //세션종료시간설정 초단위 20초부여
			
			/*
			if(interval < 10 ) {
				
				interval = 10;
				
				if( interval ==0) {
					session.invalidate(); // 세션초기화 = 종료 = 세션의 모든속성 값을제거
					System.out.println("사용자로그인시간이만료되었습니다.");
					return "redirect:login";
					*/
			session.setAttribute("mname", result.getM_name());
			session.setAttribute("mid", request.getParameter("id"));
			session.setAttribute("mpw", request.getParameter("pw"));
			session.setAttribute("count", result.getCount());
			
			System.out.println("세션 카운트"+"count");
			
			// session.setAttribute("result", 1);
			//session.setAttribute("mpw", result.getM_pw());
			// 세션 : 서버, 쿠키 : 클라이언트(브라우저)에 보관 됩니다.
			//return json.toString();
			// 정상적 로그인했다면 인덱스로가기
			//SecureRandom
			return "login";

		} else {
			return "redirect:login";
			//return json.toString(); // 암호 아이디가 일치 하지 않은 사람은 다시 로그인 하기
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		if (session.getAttribute("mname") != null) {
			// session.invalidate(); // 세션 삭제하기
			session.removeAttribute("mname");
		}
		if (session.getAttribute("mid") != null) {

			session.removeAttribute("mid");
		}
		session.setMaxInactiveInterval(0); // 세션 유지시간을 0으로 =종료시키기
		session.invalidate(); // 세션초기화 = 종료 = 세션의 모든속성 값을제거

		return "redirect:login";

	}

	
	
	
}
