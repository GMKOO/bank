<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 화면</title>
<link rel="stylesheet" href="./css/join.css?version=0.4">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">

//완성된 한글 입력되게
function validateKorean(input) {
    var value = input.value;

    // 정규식으로 완성된 한글만 허용
    var regex = /^[가-힣]*$/;

    if (!regex.test(value)) {
        // 완성된 한글이 아닌 경우 입력값에서 제거
        input.value = value.replace(/[ㄱ-ㅎㅏ-ㅣ]/g, "");
        alert("완성된 한글만 입력할 수 있습니다.");
    }
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
	
/* $(function(){
/* 	$("#idCheck").click(function(){
		let id = $("#id").val();
		if(id == "" || id.length <2) {
			
			//alert("아이디는 5글자 이상이어야 합니다.");
			$("#resultMSG").text("아디는 5글자 이상이어야 합니다.");
			$("#resultMSG").css("color","red");
			$("#id").focus();
			
		} else {
			let result = ""; // 결과값 찍기 
			$.ajax({
				url:"./checkID",
				type: "post",
				data: {"id":id},  //checkID?id=pseidon
				dataType: "html",		
						
				success:function(data){
					
					$("#resultMSG").text("data : " + data);
				},
				error:function(request,status,error){
					
					$("#resultMSG").text("error : " + error);
					console.log(error);
				}
				
				
			});
			
			$("#resultMSG").text("아디는 5글자 이상이어야 합니다.");
			$("#resultMSG").css("color","green");
			
		}
		
		
		return false;

		
	});
	
	 */
	/* 
	 $(function(){
		 $("#idCheck").click(function(){
			let id = $("#id").val();
			//console.log(id);
			//console.log(id.length);
			if(id == ""|| id.length <2) {
				
				$("#id").focus();
				$("#resultMSG").text("아이디는 2글자 이상이어야 합니다.");
				$("#resultMSG").css("color","red").css("font-weight","bold").css("font-size","15pt");
				
			} else { 
				$.ajax({
					
					url : "./checkID", //
					type : "post",
					data : {"id" : id},
				//	dataType : "html", html 타입 다음 json타입으로 진행
					dataType : "json", // {result : 0}
					success : function(data) {
						//alert(data.result);
					
						//$("#resultMSG").text("성공시 결과값 : " + data);
					if(data.result==1) { 
						$("#resultMSG").text("이미 등록된 아이디 입니다.");
						$("#resultMSG").css("color","red");
						$("#id").css("background-color","red");
						$("#id").css("color","white");
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

*/
</script>

</head>

<body>


	<div class="container">
		<form action="./join" method="post">
		<h1>회원가입</h1>
		<div>
			<input class="joinId" id="id" name="id" type="text" placeholder="아이디"
				required="required" maxlength="20" onchange="checkID()" oninput="validateAlphanumeric(this)"/>
			
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
		</div>
		<div>
			<input class="joinName" required="required" name="name" type="text" placeholder="이름"
				required="required" maxlength="20" oninput="validateKorean(this)"/>
		</div>
		<div>
			<input class="joinAddress" required="required" name="addr" type="text" placeholder="주소"
				required="required" maxlength="20" oninput="validateKoreanEnglish(input)"/>
		</div>

		<div>
			<input name="birth" required="required" class="joinNum" type="text"  oninput="validateNumbers2(this)" placeholder="주민등록번호 앞자리" maxlength="6" minlength="6"/>
			<input name="birth2" required="required" class="joinNum" type="password"  oninput="validateNumbers2(this)" placeholder="주민등록번호 뒷자리" maxlength="7" minlength="7"/>
		</div>

		<div class="button1">
			<button type="submit" class="login" onclick="">가입하기</button>
			<button type="reset" class="login" onclick="">취소</button>
		</div>
		</div>
	 </form>
	


</body>
</html>