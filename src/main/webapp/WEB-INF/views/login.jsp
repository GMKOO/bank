
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/login.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>	
	
<%
    String mname = (String) session.getAttribute("mname");
%>

<html>
<head>
<title>로그인</title>
<script type="text/javascript">




//Jquery
$(function() {
	$(".login").click(function() {
		let id = $("#id").val();
		let pw = $("#pw").val();
		if (id.length < 4) {
			alert("아이디에 길이가 짧습니다.");
			$("#id").focus();
		} else {
			if (pw.length < 5) {
				alert("패스워드 길이가 짧습니다.");
				$("#pw").focus();
			} else { id=
				
				
			    $(function() { 
			    	
			    
			    	
			    	
			    	
			    	
			        if () {
			            $("#loginForm").hide();
			        }
			    });
		
				
				//아이디하고 암호하고 정확하게 입력되었습니다.
			

			} 
				
				
			}
		}
	});



// 세션 만료 알림 표시 함수
function showSessionExpirationAlert() {
	

	
	if(sessionExpirationTime <=10)  {
		const confirmed = confirm("세션이 만료되었습니다. 다시 로그인하시겠습니까?");
		
		if(confirmed) {
			
			
		}
		
	} else
		
	
	
	if (confirmed) {
	    // 로그인 페이지로 이동 또는 로그인 처리 등 필요한 작업 수행
	    window.location.href = "/login"; // 예시로 로그인 페이지로 이동하도록 설정
	  } else {
	    // 사용자가 로그인을 유지하지 않을 경우 처리
	    // 예: 로그아웃 처리 또는 다른 작업 수행
	    // 여기에 필요한 코드를 추가하세요
	  }
	}
	
//세션 상태 확인 및 알림 설정 함수

$.ajax({
  url: '/api/checkSession',
  method: 'GET',
  success: function(response) {
	  
	  
    // 세션 유효한 경우 처리
  },
  error: function(error) {
    // 세션이 만료된 경우 처리
    showSessionExpirationAlert();
  }
});

//jQuery AJAX 코드는 위와 같이 작성하면 됩니다. 따로 라이브러리 다운로드가 필요하지 않습니다.
//jQuery를 포함시키기만 하면 되므로, 해당 페이지에서 jQuery AJAX를 사용하실 수 있습니다.


// 페이지 로드 시 세션 상태 확인 시작
checkSessionStatus();

//세션 상태 확인 및 알림 설정 함수
function checkSessionStatus() {
  axios.get("/api/checkSession") // 서버에서 세션 상태 확인하는 API 엔드포인트
    .then(response => {
      // 세션 유효한 경우: 타이머 재설정
      setTimeout(checkSessionStatus, sessionExpirationTime * 1000);
    })
    .catch(error => {
      // 세션이 만료된 경우: 알림 표시
      showSessionExpirationAlert();
    });
}


function getSessionData() {
	  fetch('/api/getSessionData')
	    .then(response => response.json())
	    .then(sessionData => {
	      if (sessionData && sessionData.isLoggedIn) {
	        // 세션 유지 중인 경우 처리
	      } else {
	        // 세션 만료된 경우 처리
	        showSessionExpirationAlert();
	      }
	    })
	    .catch(error => {
	      // AJAX 요청 실패 시 처리
	    });
	}

	// 페이지 로드 시 세션 정보 가져오기 시작
	getSessionData();





</script>
</head>
<%@ include file="menu.jsp" %>

<nav>
 <c:choose>
			<c:when test="${sessionScope.mname eq null }">
				<li class="log1" onclick="location.href='./login;">Login</li>
			</c:when>
			<c:otherwise>
				<li class="log2"  onclick="location.href='./myInfo'">${sessionScope.mname }님 반갑습니다.</li>
				<li class="log1" type="button" onclick="location.href='./logout'">로그아웃</li>
			</c:otherwise>
		</c:choose>
		</nav>
<body>


	<p style="text-align: center; border: medium;">
	<h1>e농협회원 님은 일부 조회 서비스 이용이 가능합니다.</h1> </p>
	
	
	<form name="loginForm" action="./login" method="post">
	
    <input type="text" minlength="4" maxlength="20" placeholder="아이디"  
    required="required" name="id" class="loginID" id="id" onchange="" />
    
    <input type="password" name="pw" id="pw" class="loginPW" minlength="5" maxlength="12" 
    required="required" placeholder="********" />

    	<span>
		<button class="login" type="submit" onclick="/" onchange="check()">로그인</button>
	</span>
</form>

	<div>
	<a class="join" href="회원가입주소">e농협 회원가입</a>
	<a class="serchID" href="ID찾기주소">ID찾기</a>
	<a class="resetPW" href="비밀번호찾기주소">비밀번호초기화(재설정)</a>
</div>

<button type="button" onclick="location.href='./'"> 홈으로 </button>

</body>
</html>
