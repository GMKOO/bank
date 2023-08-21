<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<script type="text/javascript">



	</script>
	
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<nav> <c:choose>
			<c:when test="${sessionScope.mname eq null }">
				<li class="log1" onclick="location.href='/login'">Login</li>
			</c:when>
			<c:otherwise>
				<li class="log2"  onclick="link('myInfo')">${sessionScope.mname }님 반갑습니다.</li>
				<li class="log1"  onclick="link('logout')">로그아웃</li>
			</c:otherwise>
		</c:choose>
		</nav>
<body>
 <h1> 홈화면</h1>
 <button onclick="location.href='./login'" type="button">로그인이동</button>
</body>
</html>