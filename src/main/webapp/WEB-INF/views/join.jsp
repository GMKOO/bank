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
	
    if (/\s/.test(value)) {
        input.value = value.replace(/\s/g, "");
        alert("중간에 공백을 포함할 수 없습니다.");
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
		input.value = value.replace(/[^\w\d]/g, "").replace(/\s/g, "");
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
	
	//한글과 영어만 허용 
	function validateKoreanEnglish(input) {
	    var value = input.value;
	    if (!/^[a-zA-Zㄱ-힣]+$/.test(value)) {
	        input.value = value.replace(/[^\sa-zA-Zㄱ-힣]/g, "");
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
		let pwck = $(".joinPwck").val();
		let name = $("#name").val();
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
		}
		if(addr ==null || addr == "") {
			
			$("#addr").focus();
			
			alert("주소를 정확히 입력해주세요");
			
			return false;
		}
		if(birth ==null || birth.length <6) {
			$("#birth").focus();
			alert("주민등록번호 앞자리를 정확하게 입력해주세요");
			return false;
		}
		if(birth2 ==null || birth2.length <7) {   //주민번호도 있으면 가입불가로해야되
			$("#birth2").focus();
			alert("주민등록번호 뒷자리를 정확하게 입력해주세요");
			return false;
		}
		if(phonenum ==null || phonenum.length <9) {
			$("#phonenum").focus();
			alert("전화번호를 정확하게 입력해주세요");
			return false;
		}
		if(id ==null ) {  //db에서아이디 같은지 다시확인?
			$("#id").focus();
			alert("id 중복된 가입입니다");
			return false;
		}
		
		
		
		$.ajax({
			
			url : "./joincreateid", //
			type : "post",
			dataType : "json", // {result : 0}
			data : formData,
			success : function(data) {
			
			
			if(data.result==1) {
				
				console("성공적");
			}
			
			},
			
			error: function(request,status,error){
				$("#resultMSG").text("오류가 발생 했습니다. 가입할 수 없습니다.");
			}
			
			
	
		}); //  ajax 시작 선언
		
		
		alert("회원가입성공");
		return true;
		
	}


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
				<P><span id="joinckMSG"></span></p>
		</div>
		<div>
			<input class="joinName" id="koreanInput" required="required" name="name" type="text" placeholder="이름"
				required="required" maxlength="20" oninput="validateKoreanEnglish(this)"/>
		</div>
		<div>
			<input class="joinAddress" required="required" name="addr" type="text" placeholder="주소"
				required="required" maxlength="20" oninput="validateKoreanEnglish(this)"/>
		</div>
		<div>
			<input class="joinphonenum" required="required" name="phonenum" type="text" placeholder="전화번호 -입력하지마세요"
				required="required" maxlength="14" oninput="validateNumbers2(this)"/>
		</div>


		<div>
			<input name="birth" required="required" class="joinNum" type="text"  oninput="validateNumbers2(this)" placeholder="주민등록번호 앞자리" maxlength="6" minlength="6"/>
			<input name="birth2" required="required" class="joinNum" type="password"  oninput="validateNumbers2(this)" placeholder="주민등록번호 뒷자리" maxlength="7" minlength="7"/>
		</div>

		<div class="button1">
			<button type="submit" class="login" onclick="joinpwck()">가입하기</button>
			<button type="reset" class="login" onclick="">취소</button>
		</div>
		</div>
	 </form>
	


</body>
</html>