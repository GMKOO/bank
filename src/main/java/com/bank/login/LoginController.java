package com.bank.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;





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
	
	@PostMapping("/login")
	public String login(HttpServletRequest request) {

		LoginDTO dto = new LoginDTO();
		dto.setM_id(request.getParameter("id"));

		dto.setM_pw(request.getParameter("pw"));
		// id/pw 보냈을때
		// 이름 + count(*) 올려라
		LoginDTO result = loginService.login(dto);
		// 이result 로그인서비스로그인을해서 디비갔다온거!

		System.out.println("로그인컨트롤러출력문"+result.getM_name());
		System.out.println("로그인컨트롤러출력문"+result.getCount());

		if (result.getCount() == 1) {
			// 세션을 만들어서 로그인 지정 시간동안 유지 시킵니다.

			HttpSession session = request.getSession();
			session.setAttribute("mname", result.getM_name());
			session.setAttribute("mid", request.getParameter("id"));
			// 세션 : 서버, 쿠키 : 클라이언트(브라우저)에 보관 됩니다.
			return "redirect:/index";
			// 정상적 로그인했다면 인덱스로가기

		} else { 
	
			return "login"; // 암호 아이디가 일치 하지 않은 사람은 다시 로그인 하기
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

		return "redirect:index";

	}

	
	
	
}
