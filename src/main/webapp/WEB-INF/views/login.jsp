
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
function checkID() {

	//alert("!");

	let msg = document.getElementById("msg");
	//msg.innerHTML = "<p>" + document.getElementById("id").value + " 아이디를 변경했습니다. </p>"
}

function check() {
	//alert("!");
	let id = document.getElementById("id");

	let msg = document.getElementById("msg");

	if (id.value.length < 1) {

		alert("아이디는 2글자 이상이어야 합니다");
		msg.innerHTML = text;
		id.focus();
		return false; // 
	}

	if (pw.value.length < 8) {

		alert("비밀번호는는 8글자 이상이어야 합니다");
		pw.focus();
		return false;
	}
	document.fm.submit();
	/* alert(id.value);//1234  */
	/* alert(id.value.length); // 4 */

}

//Jquery
$(function() {
	$(".login").click(function() {
		let id = $("#id").val();
		let pw = $("#pw").val();
		if (id.length < 2) {
			alert("아이디에 길이가 짧습니다.");
			$("#id").focus();
		} else {
			if (pw.length < 5) {
				alert("패스워드 길이가 짧습니다.");
				$("#pw").focus();
			} else {
				//아이디하고 암호하고 정확하게 입력되었습니다.
				let form = $("<form></form>");
				form.attr("method", "post");
				form.attr("action", "./home");
				form.append($("<input/>", {
					type : "hidden",
					name : "id",
					value : id
				}));
				form.append($("<input/>", {
					type : "hidden",
					name : "pw",
					value : pw
				}));
				form.appendTo("body");
				form.submit();

			}
		}
	});
});







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
	
	
	<form name="fm" action="./login" method="post">
    <input type="text" minlength="2" maxlength="20" placeholder="아이디"  required="required" name="id" 
    class="loginID" id="id" />
    <input type="password" name="pw" id="pw" class="loginPW" minlength="4" maxlength="12" 
    required="required" placeholder="********" />

    	<span>
		<button class="login" type="submit" onclick="/">로그인</button>
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
