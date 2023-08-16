
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/login.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>


<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<% 
String strReferer = request.getHeader("referer"); //이전 URL 가져오기  //# url 직접입력 막기#
if(strReferer == null){ 
%> 


<script language="javascript">
alert("URL을 직접 입력해서 접근하셨습니다.\n정상적인 경로를 통해 다시 접근해 주세요.");
document.location.href="warning"; </script> 
<% 
return; 
} 
%>


<html>
<head>
<title>로그인</title>


<script type="text/javascript">
//int count =Integer.parseInt(String.valueOf(result.get("count")));
	//모달사용하기위한링크 <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	//모달사용하기위한스크립 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js">

	//Jquery 
	
  	//## 페이지 새로고침 이벤트가 발생할 때 실행할 코드


		document.addEventListener('DOMContentLoaded', function () {
			//세션에 저장된 count를 storage에 저장
			sessionStorage.setItem("reloadData", <%=session.getAttribute("count")%> );
			sessionStorage.setItem("reloadID",  "<%=session.getAttribute("id")%>" );
			
			
			const id = sessionStorage.getItem("reloadID"); 
			//storage에 저장된 숫자를 countStorage 저장
			const countStorage = sessionStorage.getItem("reloadData");  // 
			
		console.log(id);
		 console.log(countStorage);
			
		 if (countStorage != null && id != null ) {
			 
			 $(".loginForm").hide(); 
			    reload(id); // #6. 로그인후 페이지 새로 고치면 로그인화면 그대로 보여주기 
				   //accountInfo(id);   // 계좌 정보 함수 호출
				   //extendSession(); // 세션 연장 함수 호출
			 
		 }
		   });
		

	

	//#1.아이디 비밀번호 확인후 로그인창 숨기기 
	function checkID(id, pw) {

		$.ajax({

			url : "./checkID",
			type : "post",
			dataType : "json",
			async : false,
			data : {
				"id" : id,
				"pw" : pw
			},

			success : function(data) {

				if (data.result === 1) {
					$(".loginForm").hide();
					nameAlert();   // #2.  로그인성공시 이름알림
					accountInfo(id);  //#3. 로그인성공시 계좌 및 잔액 보여주기 
					extendSession();   //#4. 세션 종료전 팝업 및 남은시간 보여주고,로그인 연장 버튼
					
				
					

				} else {
					alert("아이디와 비밀번호가 틀렸습니다.");
					location.href = "./login";
				}
			},
			error : function(request, status, error) {
				alert("서버 오류가 발생했습니다." + error);
			}
		});
	}

	// #2. 로그인성공후 alert에 name값 올려주기
	function nameAlert() {

		$.ajax({

			url : "./name",
			type : "post",
			dataType : "json",
			async : false,

			success : function(data) {
				const name = data.mname;

				alert(name + "님 어서오세요.");

			},
			error : function(request, status, error) {
				alert("서버 오류가 발생했습니다." + error);
			}
		});
	}

	//#3.로그인후 계좌정보표시
	function accountInfo(id) {
		
				$.ajax({ //로그인시 아이디가 보유중인 계좌 및 잔액 표시

					url : "./accountInfo",
					type : "post",
					dataType : "json",
					async : false,
					data : {
						"id" : id
					},

					success : function(data) {
						const account = data.account;
						const balance = data.balance;
						//alert("계좌는"+account +"잔액은"+balance)
						

						var accountHtml =

						'<form class="accountInfo" action="./login" method="post">'
								+ '<div class="accountInfo">'
								+ '계좌번호: '
								+ account
								+ '잔액: '
								+ balance
								+ '</div>'
								+ '<span>'
								+ '<button class="serch" type="submit" onclick=""/>조회</button>'
								+ '<button class="trans" type="submit" onclick=""/>이체</button>'
								+ '</span>' + '</form>';
						$("body").append(accountHtml); // 계좌 정보 추가

					},
					error : function() {
						console.log("세션 연장 실패");
					}
				});
	}

	// #4.세션 팝업 및 남은시간 및 로그인연장버튼
	function extendSession() {
		$.ajax({
			url : "./extendSession",
			type : "post",
			dataType : "json",
			async : false,

			success : function(response) {

				var remainTime = response.remainingTime;

				$("#remainingTime").text(remainTime); // 모달이랑남은시간이랑 간극으로 0초가 표시되고 남은시간이 표시되는거 잡는용

				var interval = setInterval(function() { // 모달에 남은시간 표시할때 줄여나가는 기능
					remainTime--;

					if (remainTime >= 0) {
						$("#remainingTime").text(remainTime);

						if (remainTime === 30) {

							$("#popupContent").dialog({
								modal : true, // 모달 창으로 설정
								width : 400,

								buttons : {

									"로그인 연장" : function() {
										seesionExtend(); //#5. 연장버튼 누를시 세셔초기시간부여 

										$(this).dialog("close");
									},

									"닫기" : function() {
										$(this).dialog("close");
									}
								}
							});
						}
					} else {

						clearInterval(interval); // 남은 시간이 마이너스면 카운트다운 중지
						$("#popupContent").dialog("close"); //끌때는 상위 창을 꺼야됨. 시간만끄면안됨
						$("#exitTime").text(0);

						$("#exitContent").dialog({

							modal : true, // 모달 창으로 설정
							width : 400,
							buttons : {
								"닫기" : function() {
									$(this).dialog("close");
								}
							}
						});
						location.reload();
					}
				}, 1000); //1초마다반복  setInterval(function) 지정한 시간마다 반복하는 기능
			},

			error : function() {
				console.log("세션 연장 실패");
			}
		}); // 팝업 ajax 끝단
	} // function 끝

	// #.5 로그인연장버튼 클릭시 초기세션시간 부여     
	function seesionExtend() {
		$.ajax({
			url : "./sessionextend", // 기존사용했던 ajax 재사용시 오류발생  새로운 인터벌 부여 주소사용
			type : "post",
			dataType : "json",
			async : false,

			success : function(response) {
				var extendedTime = response.interval; // 서버에서 넘겨준 세션 초기부여시간

				remainTime = extendedTime; // 기존 남은시간을 세션 초기부여시간으로 교체
			},

			error : function(request, status, error) {
				alert("서버 오류가 발생했습니다." + error);

			}

		});
	}

	
		 //#6.페이지 새로고침시 로그인상태 화면 유지용
	function reload (id) { 
		$(document).ready(function() {
			event.preventDefault(); // 기본 동작을 막음. 폼 action 기능 새로고침을 막아준다.*중요*
			
	$.ajax({
	    url: "./checkLoginStatus", // 서버에서 로그인 상태 확인하는 URL로 변경
	    type: "post",
	    dataType: "json",
	    success: function(response) {
	    	
	        if (response.session != null ) {
	            // 로그인 중일때 
	          $(".loginForm").hide(); 
	        	 accountInfo(id);  //#3. 로그인성공시 계좌 및 잔액 보여주기 
				extendSession();  //#4. 세션 종료전 팝업 및 남은시간 보여주고,로그인 연장 버튼
	          } else {
	        	  
	        	  alert("세션없데");
	          }
	         },
	         error : function(request, status, error) {
					alert("서버 오류가 발생했습니다." + error);

				}
	         
	        });
	    });
		}
	
	
	 
	 
	//##여기가 main 시작##
	$(function() {
		$(".login").click(function() {
			event.preventDefault(); // 기본 동작을 막음. 폼 action 기능 새로고침을 막아준다.*중요*
			let id = $("#id").val();
			let pw = $("#pw").val();
			
			//#0. 로그인 length검사 함수 
				if (id.length < 5) {
					//alert(id.length);
					alert("아이디가 잘못 입력되었습니다.");
					$("#id").focus();
				} else if (pw.length < 5) {
					//alert(pw.length);
					alert("아이디와 비밀번호를 잘못 입력되었습니다.");
					$("#pw").focus();

				} else {
					checkID(id, pw);   // #1. 아이디 비밀번호 확인후 로그인창 숨기기 
					  // 페이지 새로고침시 기존화면부여
				}
			});
	});
			
			
			
		 

	/*
	 // *함수없이 사용한거 삭제안되!!!*
	 $(function() {
	 $(".login").click(function() {
	 event.preventDefault(); // 기본 동작을 막음. 폼 action 기능 새로고침을 막아준다.*중요*
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
	
	 $.ajax({   // 1번 ajax 아이디 비밀번호 확인후 로그인창 숨기기 
	
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
	
	
	
	 $.ajax({    //2번쨰 ajax 로그인시 name값  alert에 기재
	
	 url : "./name", 
	 type : "post",
	 dataType:"json",
	 async : false,

	
	 success: function(data) {
	 const name = data.mname;

	 alert(name+"님 어서오세요.");
	
	 $.ajax({     //3번쨰 ajax 로그인시  로그인창 숨긴곳에 로그인 아이디가 보유중인 계좌 및 잔액 표시
	
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
	
	
	 // 세션 남은시간 모달을 띄우기 전에 남은 시간을 가져오는 Ajax 요청 보내기
	 $.ajax({
	 url: "./extendSession", 
	 type: "post",
	 dataType: "json",
	 async : false,
	
	 success: function(response) {
	
	 var remainTime = response.remainingTime;
	
	 $("#remainingTime").text(remainTime);  // 모달이랑남은시간이랑 간극으로 0초가 표시되고 남은시간이 표시되는거 잡는용
	
	 var interval = setInterval(function() {  // 모달에 남은시간 표시할때 줄여나가는 기능
	 remainTime--;
	
	 if (remainTime >= 0) {
	 $("#remainingTime").text(remainTime);
	
	 if (remainTime === 30) {
	
	 $("#popupContent").dialog({
	 modal: true, // 모달 창으로 설정
	 width: 400,
	
	 buttons: {
	 "로그인 연장": function() {
	 // 여기에 로그인 연장을 위한 Ajax 요청 처리 코드 추가
	 $.ajax({
	 url: "./sessionextend", // 기존사용했던 ajax 재사용시 오류발생  새로운 인터벌 부여 주소사용
	 type: "post",
	 dataType: "json",
	 async : false,
	
	 success: function(response) {
	 var extendedTime = response.interval; // 서버에서 넘겨준 세션 초기부여시간
	
	 remainTime = extendedTime; // 기존 남은시간을 세션 초기부여시간으로 교체
	
	
	
	
	 },
	 error: function() {
	 console.log("세션 연장 실패");
	 }
	 });
	 $(this).dialog("close");    
	 },
	 "닫기": function() {
	 $(this).dialog("close");
	 }
	 }
	 });
	 }
	 } else {
	
	 clearInterval(interval); // 남은 시간이 마이너스면 카운트다운 중지
	 $("#popupContent").dialog("close");  //끌때는 상위 창을 꺼야됨. 시간만끄면안됨
	 $("#exitTime").text(0);
	
	 $("#exitContent").dialog({
	
	 modal: true, // 모달 창으로 설정
	 width: 400,
	 buttons: { 
	 "닫기": function() {
	 $(this).dialog("close");
	 } 
	 }
	 });
	 location.reload(); 
	 }  
	 }, 1000); //1초마다반복  setInterval(function) 지정한 시간마다 반복하는 기능
	 },
	 error: function() {
	 console.log("세션 연장 실패");
	 }
	 }); // 팝업 ajax 끝단
	
	 },// accountinfo 성공 ajax 끝

	
	 error: function(request,status,error) {
	 alert("서버 오류가 발생했습니다."+error);
	
	 }
	
	 }); //accountinfo  여기서 끝
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

	 */
	/*	타이머 모달

	 $(document).ready(function() {
	 // 일정 시간이 경과하면 팝업을 띄움
	 setTimeout(function() {
	 // 세션 남은시간 모달을 띄우기 전에 남은 시간을 가져오는 Ajax 요청 보내기
	 $.ajax({
	 url: "./extendSession", 
	 type: "post",
	 dataType: "json",
	
	 success: function(response) {
	
	 var remainTime = response.remainingTime;
	
	 $("#remainingTime").text(remainTime);  // 모달이랑남은시간이랑 간극으로 0초가 표시되고 남은시간이 표시되는거 잡는용
	
	 var interval = setInterval(function() {  // 모달에 남은시간 표시할때 줄여나가는 기능
	 remainTime--;
	
	 if (remainTime >= 0) {
	 $("#remainingTime").text(remainTime);
	
	 } else {
	
	 clearInterval(interval); // 남은 시간이 마이너스면 카운트다운 중지
	 $("#popupContent").dialog("close");  //끌때는 상위 창을 꺼야됨. 시간만끄면안됨
	 $("#exitTime").text(0);
	 $("#exitContent").dialog({
	
	 modal: true, // 모달 창으로 설정
	 width: 400,
	 buttons: { 
	 "닫기": function() {
	 $(this).dialog("close");
	 } 
	 }
	 });
	 }  
	 }, 1000); //1초마다반복  setInterval(function) 지정한 시간마다 반복하는 기능
	
	
	
	 $("#popupContent").dialog({
	 modal: true, // 모달 창으로 설정
	 width: 400,
	
	 buttons: {
	 "로그인 연장": function() {
	 // 여기에 로그인 연장을 위한 Ajax 요청 처리 코드 추가
	 $(this).dialog("close");
	 },
	 "닫기": function() {
	 $(this).dialog("close");
	 }
	 }
	 });
	 },
	 error: function() {
	 console.log("세션 연장 실패");
	 }
	 });
	
	 }, 10000); // 10초 후에 팝업 띄움
	
	 });

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
		
		
	 *//*	
		
			
		
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
</script>
</head>

<div id="popupContent" style="display: none;">
	<p>로그인을 지속하실려면 연장버튼을 클릭해주세요.</p>
	<p>
		남은 시간: <span id="remainingTime">0</span>초
	</p>

</div>


<div id="exitContent" style="display: none;">
	<p>안내</p>
	<p>장시간 이용하시지 않아 안전한 금융거래보호를 위해 로그아웃 되었습니다.</p>
	<p>
		남은 시간: <span id="exitTime">0</span>초
	</p>

</div>









<nav>
	<c:choose>
		<c:when test="${sessionScope.mname eq null }">
			<li class="log1" onclick="location.href='./login'"></li>

		</c:when>
		<c:otherwise>
			<li class="log2" onclick="location.href='./myInfo'">${sessionScope.mname }님
				반갑습니다.</li>
			<li class="log1" type="button" onclick="location.href='./logout'"
				style="background-color: black; color: white;">로그아웃</li>
		</c:otherwise>
	</c:choose>
</nav>
<body>


	<p style="text-align: center; border: medium;">
	<h1>e농협회원 님은 일부 조회 서비스 이용이 가능합니다.</h1>
	</p>



	<form name="loginForm" class="loginForm" action="./login" method="post">

		<input type="text" minlength="4" maxlength="20" placeholder="아이디"
			required="required" name="id" class="loginID" id="id"
			oninput="validateInput(this)" /> <input type="password" name="pw"
			id="pw" class="loginPW" minlength="5" maxlength="12"
			required="required" placeholder="********"
			oninput="validateInput(this)" /> <span>
			<button class="login" type="submit" onclick="" />로그인
			</button>
		</span>
		<div class=loginOption>
			<a class="join" href="회원가입주소">e농협 회원가입</a> <a class="serchID"
				href="ID찾기주소">ID찾기</a> <a class="resetPW" href="비밀번호찾기주소">비밀번호초기화(재설정)</a>
		</div>

	</form>



	<button type="button" onclick="location.href='./'">홈으로</button>

</body>
</html>
