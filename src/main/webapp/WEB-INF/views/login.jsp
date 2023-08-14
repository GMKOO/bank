
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/login.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js" 
integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
crossorigin="anonymous"></script>	



<html>
<head>
<title>로그인</title>

<script type="text/javascript">

// 세션 연장 팝업 타이머 
$(document).ready(function() {
    // 시간이 경과한 후 팝업 띄우기
    setTimeout(function() {
        if (/* 조건이 달성되었을 경우 */) {
            showPopup();
        }
    }, 5000); // 5000ms (5초) 경과 후 팝업 띄우기
});





 // 리다이렉트를 처음에는 허용
// var loginResult = 

// timeout controller에서 인터벌타임을 세션에 담아서jsp로보내고 jsp에서 선언후 스크립트에서 사용 .
//Jquery 

 // 스크립트 변수에 loginCount 값을 할당
 
 		
		//contentType : "application/json",
		
$(function() {
	$(".login").click(function() {
		event.preventDefault(); // 기본 동작을 막음 폼 action 기능 새로고침을 막아준다.
		let id = $("#id").val();
		let pw = $("#pw").val();

		if( id.length < 5 ) { 	
			//alert(id.length);
			alert("아이디가 잘못 입력되었습니다.");
			$("#id").focus();
		}else if(pw.length < 5 ) {
			//alert(pw.length);
				alert("아이디와 비밀번호를 잘못 입력되었습니다.");	
				$("#pw").focus();
		
		}else{
		
		$.ajax({
			
			url : "./checkID", 
			type : "post",
			dataType:"json", 
			async : false,
			data : { "id" : id,
				     "pw" : pw },
		
		
			success: function(data) {
				
				if(data.result === 1) { 
					
					$(function() {
				      $(".loginForm").hide(); 
					});
			
				
			
				$.ajax({
					
					url : "./name", 
					type : "post",
					dataType:"json",
					async : false,

								
				success: function(data) {
				const name = data.mname;

				alert(name+"님 어서오세요.");
				
				$.ajax({
					
					url : "./accountInfo", 
					type : "post",
					dataType:"json",
					async : false,
					data : {"id" : id },

								
				success: function(data) {
					const account = data.account;
					const balance = data.balance;
					//alert("계좌는"+account +"잔액은"+balance)
					
					var accountHtml = 
						
						
			 '<form class="accountInfo" action="./login" method="post">'+
			 '<div class="accountInfo">' +
             '계좌번호: ' + account +
             '잔액: ' + balance +
             '</div>'+
			 '<span>'+
			 '<button class="serch" type="submit" onclick=""/>조회</button>'+
			 '<button class="trans" type="submit" onclick=""/>이체</button>'+
			 '</span>' +
			 '</form>';
                            $("body").append(accountHtml); // 계좌 정보 추가
				

				},
				
				error: function(request,status,error) {
					alert("서버 오류가 발생했습니다."+error);
					
				}
				
				});
			},
				error: function(request,status,error) {
					alert("서버 오류가 발생했습니다."+error);
					
				}
				
				});
				} else { alert("아이디와 비밀번호가 틀렸습니다.");
				  location.href = "./login";
				}
					
				
					
					
				},
				error: function(request,status,error) {
					alert("서버 오류가 발생했습니다."+error);
				}
			});
		}

		
				}); 
		
		});


/*	

*/   
		

/*
 * 
 
	

		 fetch('./name')  // 요청할 엔드포인트 URL을 지정
		  .then(response => {
		      return response.json()  // JSON 형식의 응답을 파싱
		  		})
		  .then(data => {
		    // JSON 응답에서 데이터 추출 ("("+ rp +")");
		    const mname = ""+data.mname+"";

		    // 추출한 데이터 사용
		    console.log("Received mname:", mname);
		    console.log("data:", data);
		    console.log("data.mname:", data.mname);
		  })
		  
		  .catch(error => {
		    console.error("Error fetching data:", error);
		  });
 */ 
 /*
		
			
			
		}
	});
});
		
		
	*/ /*	
		
			
		
		      if (sessionTimeout == 10) {
		      	    // 팝업 창을 띄웁니다.
		      	    alert("로그인 시간이 10초 남았습니다.");
		      	}

		      	if (sessionTimeout == 0) {
		      	    // 세션 초기화 시키고 로그인 만료 창을 띄웁니다.
		      	    alert("사용자 로그인 시간이 만료되었습니다.");
		      	    location.href = "./login"; // 로그인 페이지로 리다이렉트
			}
		      	if (sessionTimeout == 0) {
	      	    // 세션 초기화 시키고 로그인 만료 창을 띄웁니다.
	      	    alert("사용자 로그인 시간이 만료되었습니다.");
	      	    location.href = "./login"; // 로그인 페이지로 리다이렉트
			}

				}

*/
	//문자열 비교이니 "" 이거 까먹지마!!!
			
	
	
	//if( id.length < 5  ) { 		
		
		//alert("${id}");
		//alert(pw;)
		
	

	

    // 세션 만료 시간이 지나면 로그인 페이지로 리다이렉트

/*
setTimeout(function() {
	
	alert("진짜열림?");
	
}, timeout);

*/

/*
$(function() {
	$(".login").click(function() {
		
		
		
	});
});


*/

		
		
	

		

		/*	
		if("${mid}" == id && "${mpw}"== pw) {
			// 
	$("#loginForm").hide();
			alert("id"+id);
			alert("pw1"+pw +mpw +${mpw}+"${mpw}");
			
			alert("로그인에 성공하셨습니다");
		} else(id.length < 5 && pw.length <5 ) {

			
			alert("pw1"+pw +mpw +${mpw}+"${mpw}");
			
			alert("아이디와 비밀번호를 잘못 입력하셨습니다.");
		}
	});
});
				*/	
			 				
				//아이디하고 암호하고 정확하게 입력되었습니다.
			




// 세션 만료 알림 표시 함수

/*-
function showSessionExpirationAlert() {
	

	
	if(sessionExpirationTime <=10)  {
		const confirmed = confirm("세션이 만료되었습니다. 다시 로그인하시겠습니까?");
		
		if(confirmed) {
			
			
		}
		
	} 
		
	
	
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
/*

 
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

	${sessionScope.mname}
	${mname}
	${timeout}
	${sessionScope.loginResult}
	
	${mpw}
	${mid }
	${sessionScope.mid}
	${result}


	*/
	//특수문자 공백 입력방지  스크립트  + oninput사용
	function validateInput(input) {
	    var value = input.value;
	    if (/[^\w\d]/.test(value) || /\s/.test(value)) {
	        input.value = value.replace(/[^\w\d]/g, "").replace(/\s/g, "");
	        alert("특수문자와 공백은 입력할 수 없습니다.");
	    }
	}
	/*    
	  //세션시간 시분초로 정리  
	    function calculateAndFormatDuration(startTimestamp, endTimestamp) {
	        const durationInMillis = endTimestamp - startTimestamp;

	        // 밀리초를 초로 변환
	        const durationInSeconds = Math.floor(durationInMillis / 1000);

	        // 초를 분으로 변환
	        const durationInMinutes = Math.floor(durationInSeconds / 60);

	        // 분을 시간으로 변환
	        const durationInHours = Math.floor(durationInMinutes / 60);

	        // 시, 분, 초를 계산
	        const hours = durationInHours;
	        const minutes = durationInMinutes % 60;
	        const seconds = durationInSeconds % 60;

	        // 시분초 형식으로 포맷팅하여 반환
	        return `${hours}시간 ${minutes}분 ${seconds}초`;
	    }

	    const sessionStartTimestamp = 1691905003918;
	    const sessionEndTimestamp = 1691905015095;

	    const formattedDuration = calculateAndFormatDuration(sessionStartTimestamp, sessionEndTimestamp);
	    console.log(formattedDuration);	 
	 */   
	    
	

</script>
</head>

		
	

		
		<div id="autoLogoutPopup" style="display: none;">
    <!-- 팝업 내용 -->
    <p>팝업창</p>
</div>

<nav>
 <c:choose>
			<c:when test="${sessionScope.mname eq null }">
				<li class="log1" onclick="location.href='./login'" >
				
				
				</li>
				  
			</c:when>
			<c:otherwise>
				<li class="log2"  onclick="location.href='./myInfo'">${sessionScope.mname }님 반갑습니다.</li>
				<li class="log1" type="button" onclick="location.href='./logout'" style="background-color: black ; color: white;" >로그아웃</li>
			</c:otherwise>
		</c:choose>
		</nav>
<body>


	<p style="text-align: center; border: medium;"><h1>e농협회원 님은 일부 조회 서비스 이용이 가능합니다.</h1></p>

	
	
	<form name="loginForm" class="loginForm" action="./login" method="post">
	
    <input type="text" minlength="4" maxlength="20" placeholder="아이디"  
    required="required" name="id" class="loginID" id="id" oninput="validateInput(this)" />
     
    <input type="password" name="pw" id="pw" class="loginPW" minlength="5" maxlength="12" 
    required="required" placeholder="********" oninput="validateInput(this)" />

    	<span>
		<button class="login" type="submit" onclick=""/>로그인</button>
	</span>
	<div class=loginOption>
	<a class="join" href="회원가입주소">e농협 회원가입</a>
	<a class="serchID" href="ID찾기주소">ID찾기</a>
	<a class="resetPW" href="비밀번호찾기주소">비밀번호초기화(재설정)</a>
</div>
	
</form>



<button type="button" onclick="location.href='./'"> 홈으로 </button>

</body>
</html>
