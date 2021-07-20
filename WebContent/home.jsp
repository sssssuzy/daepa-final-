<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"  href="/css/style.css"/>
<title>수지-SSSSUZZY</title>
</head>
<body>
<div id="divpage">
	<div id="divHeader">
		<h1 onclick="location.href='/product/best'">SSSSUZZY</h1>
		<div id="login">
		<c:if test="${user.userid==null}">
			<button class="btnStyle2" onClick="location.href='/user/login'">LOGIN</button>
		</c:if>
		<c:if test="${user.userid!=null}">			
			 ${user.username}님			
			<button class="btnStyle2" onClick="location.href='/user/logout'">LOGOUT</button>
		</c:if>
		</div>
	</div>
	<br/>
	<div id="divCenter">
		<div id="divMenu">
			<jsp:include page="/menu.jsp"></jsp:include>
		</div>
		<div id="divContent">
			<jsp:include page="${pageName}"></jsp:include>
		</div>		
	</div>
	<div id="divBottom">		
		<h3>Copyright (c) HYOLIC , All right reserved</h3>
	</div>
</div>
</body>
</html>