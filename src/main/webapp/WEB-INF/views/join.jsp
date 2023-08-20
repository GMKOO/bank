<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 화면</title>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">



//제출시 완성된한글 인지 아닌지 검사 
function validateKoreanck(inputValue,elementID) {  //재사용하기위해서 내용,입력아이디 지정
	

		  
		
		        if (/^[가-힣a-zA-Z0-9]*$/.test(inputValue)) {  //한글 영어 대소문자 숫자허용 
		            // 입력된 문자열이 완성된 한글 또는 영어인 경우
		            alert("제대로입력한듯")
		            
		        	  return true;
		          
		        } else {
		            // 다른 문자가 입력된 경우
		            alert("이름과 주소는 올바른 한글만 입력할수 있습니다.");
		            $("#"+elementID).focus();
		        
		           return false;
		        }
		        
		     
		        }

//이름 제출시 완성된 한글 인지검사
function validateAndSubmit() {
    var input = document.getElementById("koreanInput");
    var value = input.value;

    // 정규식으로 완성된 한글만 허용
    var regex = /^[가-힣]*$/;

    if (!regex.test(value)) {
        alert("잘못된 이름입니다. 완성된 한글만 입력하세요.");
        return false; // 폼 제출 방지
    }

   
    return true; // 폼 제출
}



//공백 입력방지

function preventWhitespace(input) {
    var value = input.value;
    if (/\s/.test(value)) {
        input.value = value.replace(/\s/g, "");
        alert("중간에 공백을 포함할 수 없습니다.");
    }
}


//특수문자 공백 입력방지 아이디생성용
function validateInput(input) {
	var value = input.value;
	if (/[^\w\d]/.test(value) || /\s/.test(value)) {
		var newValue = value.replace(/[^\w\d]/g, "").replace(/\s/g, "");
		 input.value = newValue; // 입력값을 다시 원래상태로 되돌리기 
		alert("특수문자와 공백은 입력할 수 없습니다.");
	}
}
	
	//한글허용 된 입력방지
	function validateInput1(input) {
	    var value = input.value;
	    if (/[^a-zA-Z0-9ㄱ-힣]/.test(value) || /\s/.test(value)) {
	        input.value = value.replace(/[^a-zA-Z0-9ㄱ-힣]/g, "").replace(/\s/g, "");
	        alert("특수문자와 공백은 입력할 수 없습니다.");
	    }
	}
	
	//숫자만허용됨
	function validateNumbers2(input) {
	    var value = input.value;
	    if (!/^\d+$/.test(value)) {
	        input.value = value.replace(/[^\d]/g, "");
	        alert("숫자만 입력할 수 있습니다.");
	    }
	}
	
	//
	function validateKoreanEnglish1(input) {
	 var value = input.value;
    if (/[^a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ]/.test(value)) {
        // 한글과 영어, 한글 자소가 아닌 문자가 입력되었을 때
        var newValue = value.replace(/[^a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ]/g, "");
        input.value = newValue; // 입력 요소의 값을 변경
        alert("한글과 영어만 입력할 수 있습니다.");
   
    }

	}
	
	//한글과 영어만 허용 
	function validateKoreanEnglish(input) {
		var value = input.value;
	    if (/[^a-zA-Z가-힣]/.test(value)) {
	        // 한글과 영어가 아닌 문자가 입력되었을 때
	        var newValue = value.replace(/[^a-zA-Z가-힣]/g, "");
	        input.value = newValue; // 입력 요소의 값을 변경
	        alert("한글과 영어만 입력할 수 있습니다.");
	    }
	 
	}
// 숫자랑 아이디만 허용 
	function validateAlphanumeric(input) {
	    var value = input.value;
	    if (/[^a-zA-Z0-9]/.test(value)) {
	        input.value = value.replace(/[^a-zA-Z0-9]/g, "");
	        alert("숫자와 영어만 입력할 수 있습니다.");
	    }
	}
	
	
	

	
	
	// 아이디 중복검사사용
	 $(function(){
		 $("#idCheck").click(function(){
			let id = $("#id").val();
			
			if(id == ""|| id.length <2) {
				
				$("#id").focus();
				$("#resultMSG").text("아이디는 2글자 이상이어야 합니다.");
				$("#resultMSG").css("color","red").css("font-weight","bold").css("font-size","15pt");
				
			} else { 
				$.ajax({
					
					url : "./joincheckid", //
					type : "post",
					data : {"id" : id},
				
					dataType : "json", // {result : 0}
					success : function(data) {
					
					
						
					if(data.result==1) { 
						$("#resultMSG").text("이미 등록된 아이디 입니다.");
						$("#resultMSG").css("color","red");
						
						$("#id").focus();
					} else {
						$("#resultMSG").css("color","green");
						$("#resultMSG").text("가입할 수 있습니다.");
			
						}
					
					},
					
					error: function(request,status,error){
						$("#resultMSG").text("오류가 발생 했습니다. 가입할 수 없습니다.");
					}
					
					
			
				}); //  ajax 시작 선언
			
			}
			return false; //  멈추기 
		 
		 });
	 });

	// 비밀번호 일치함수
	function joinpwck() {
		let pw = $(".joinPw").val();
		let id = $("#id").val();
		let pwck = $(".joinPwck").val();
		let name = $("#koreanInput").val();
		let addr = $("#addr").val();
		let birth = $("#birth").val();
		let birth2 = $("#birth2").val();
		let phonenum = $("#phonenum").val();
		
		var formData = $("#joinform").serialize(); // 폼 데이터를 직렬화 키,값으로 보낸다

		
		//주소는 나중에 그 선택하는거 사용하도록 업그레이드하자
		
		if(pw !== pwck) {
			
			$(".joinPwck").focus();
			$(".joinckMSG").text("비밀번호가 일치하지 않습니다.");
			alert("비밀번호가 일치 하지 않습니다.");
			$(".joinckMSG").css("color","red").css("font-weight","bold").css("font-size","15pt");
			return false;
		}else if(pw == pwck) {
			$(".joinckMSG").text("비밀번호가 일치 합니다.");
	
		$(".joinckMSG").css("color","green").css("font-weight","bold").css("font-size","15pt");
			
		}
		
		
		if(pw.length < 5) {
			
		
			$(".joinPwck").focus();
			$(".joinckMSG").text("비밀번호 길이를 확인해주세요.");
			alert("비밀번호 길이를 확인해주세요.");
			$(".joinckMSG").css("color","red").css("font-weight","bold").css("font-size","15pt");
			return false;
			
		
		}
		
		
		if(addr.length < 6 ) {
			
			$("#addr").focus();
			
			
			alert("주소를 정확히 입력해주세요");
			
			return false;
		}
		
		if(name.length < 2 ) {
			
			$("#name").focus();
			
			
			alert("이름을 정확히 입력해주세요");
			
			return false;
		}
		
		
		
		
		if( birth.length <6 ) {
			$("#birth").focus();
			alert("주민등록번호 앞자리를 정확하게 입력해주세요");
			return false;
		}
		if(birth2.length <7 ) {   //주민번호도 있으면 가입불가로해야되
			$("#birth2").focus();
			alert("주민등록번호 뒷자리를 정확하게 입력해주세요");
			return false;
		}
		
		if( phonenum.length < 9) {
			$("#phonenum").focus();
			alert("전화번호를 정확하게 입력해주세요");
			return false;
		}
		
		if( id.length < 2 ) {  //db에서아이디 같은지 다시확인?
			$("#id").focus();
			alert("id를 정확하게 입력해주세요.");
			return false;
		}
		
		//var formElement = document.getElementById("joinform");
		//var formData = new FormData(formElement);
	
		 
		
				
		if(validateKoreanck(addr,"addr") && validateKoreanck(name,"koreanInput")) {
			joincreateid (formData); ////db에 신규회원 insert문
			alert("회원가입성공");
			return true;
			
		}else {
			alert("회원가입 다시 진행해주세요");
			return false;
			
		}
	
		
		

	

	}
	
	//db에 신규회원 insert문
	function joincreateid (formData) {
			

			//db에 신규회원 insert문
			$.ajax({
				
				url : "./joincreateid", //
				type : "post",
				dataType : "json", // {result : 0}
				data : formData,
			
				success : function(data) {   
					location.href = "./login";
					console.log("result"+data.result);
				
				//if(data.result==1) {
					//alert("data.result"+data.result);
			
				
				
				},
				
				error: function(request,status,error){
					$("#resultMSG").text("오류가 발생 했습니다. 가입할 수 없습니다.");
					
					return false;
				}
				
				
		
			}); //  ajax 끝
			
		}
		
		/*	
		let pw = $(".joinPw").val();
		let id = $("#id").val();
		let pwck = $(".joinPwck").val();
		let name = $("#koreanInput").val();
		let addr = $("#addr").val();
		let birth = $("#birth").val();
		let birth2 = $("#birth2").val();
		let phonenum 
			
			function serchid() {
			
			
			$.ajax({
				
				url : "./serchid", //
				type : "post",
				dataType : "json", // {result : 0}
			
				success : function(data) {   
					 $(".loginForm").hide(); 
					 
					 var serchid = 
					 '<form class="serchid" action="./login" method="post">'
						+ '<div class="serchid">'
						+ '이름: '
						+ '<div><input id="koreanInput" name="name" type="text"'
						+'placeholder="이름" required="required" maxlength="20"'
						+'oninput="validateKoreanEnglish1(this)"/></div>'
						+ '주민등록번호: '
						+ '<div><input name="birth" id="birth" required="required"' 
						+'class="joinNum" type="text" oninput="validateNumbers2(this)"' 
						+'placeholder="주민등록번호 앞자리" maxlength="6" minlength="6"/>'
						+'<input name="birth2" id="birth2" required="required" class="joinNum"'
						+'type="password" oninput="validateNumbers2(this)" placeholder="주민등록번호 뒷자리"'
						+'maxlength="7" minlength="7"/></div>'
						+ '</div>'
						+ '<span>'
						+ '<button class="serch" type="submit" onclick=""/>조회</button>'
						+ '<button class="reset" type="reset" onclick=""/>닫기</button>'
						+ '</span>' + '</form>';
				$("body").append(serchid); // 조회창 구현 
				serchck();
				
				},
				
				error: function(request,status,error){
					$("#resultMSG").text("오류가 발생 했습니다. 가입할 수 없습니다.");
					
					return false;
				}
		
			
		});
		}
				
		function serchck() { 
			
			 var name = $("#koreanInput").val();
			    var birth = $("#birth").val();
			    var birth2 = $("#birth2").val();

			
		
		
				$.ajax({
					
					url : "./serchck", //
					type : "post",
					dataType : "json", // {result : 0}
					data : {"name": name, 
							"birth":birth,
							"birth2":birth2,
							
					},
				
					success : function(data) {   
						 $(".loginForm").hide(); 
					
						 alert("아이디는");
					//if(data.result==1) {
						//alert("data.result"+data.result);
				
					
					
					},
					
					error: function(request,status,error){
						$("#resultMSG").text("오류가 발생 했습니다. 가입할 수 없습니다.");
						
						return false;
					}
			
				
			});
				}

*/
</script>

</head>

<body>


	<div class="container">
		<form action="./join" method="post" name="joinform" id="joinform">
		<h1>회원가입</h1>
		<div>
			<input class="joinId" id="id" name="id" type="text" placeholder="아이디"
				required="required" maxlength="20" oninput="validateAlphanumeric(this)"/>
			
				<button id="idCheck"> 중복검사 </button>
				<P><span id="resultMSG"></span></p>
				
		</div>
		<div>
			<input class="joinPw"  required="required" name="pw1" type="password" placeholder="비밀번호"
				required="required" maxlength="20" oninput="preventWhitespace(this)"/>
		</div>
		<div>
			<input class="joinPwck"  required="required" name="pw2" type="password" placeholder="비밀번호확인"
				required="required" maxlength="20" oninput="preventWhitespace(this)"/>
				
				<P><span class="joinckMSG" id="joinckMSG"></span></p>
		</div>
		<div>
			<input class="joinName" id="koreanInput" required="required" name="name" type="text" placeholder="이름"
				required="required" maxlength="20" oninput="validateKoreanEnglish1(this)"/>
		</div>
		<div>
			<input class="joinAddress" required="required" id="addr" name="addr" type="text" placeholder="주소"
				required="required" maxlength="20" oninput="validateKoreanEnglish1(this)"/>
		</div>
		<div>
			<input class="joinphonenum" required="required" name="phonenum" id="phonenum" type="text" placeholder="전화번호 -입력하지마세요"
				required="required" maxlength="14" oninput="validateNumbers2(this)"/>
		</div>


		<div>
			<input name="birth" id="birth" required="required" class="joinNum" type="text"  oninput="validateNumbers2(this)" placeholder="주민등록번호 앞자리" maxlength="6" minlength="6"/>
			<input name="birth2" id="birth2" required="required" class="joinNum" type="password"  oninput="validateNumbers2(this)" placeholder="주민등록번호 뒷자리" maxlength="7" minlength="7"/>
		</div>

		<div class="button1">
			<button type="button" class="login" onclick="joinpwck()">가입하기</button>
			<button type="reset" class="login" >취소</button>
		</div>
		</div>
	 </form>
	


</body>
</html>