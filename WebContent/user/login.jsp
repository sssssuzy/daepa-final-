<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form name="frmLogin" method="post" action="login">
	<div id="divLogin">
	<table id="tblLogin">
		<tr>
		<td><input type="text" name="userid" placeholder="ID"/></td>
		</tr>
		<tr>
		<td><input type="password" name="userpass" placeholder="Password"/></td>
		</tr>
	</table>	
		<input type="submit" class="btnStyle4" value="LOGIN"/>
		<br>
		<button class="btnStyle5">MEMBER JOIN</button>
	</div>
</form>
<script>
	$(frmLogin).on("submit",function(e){
		e.preventDefault();
		var userid=$(frmLogin.userid).val();
		var userpass=$(frmLogin.userpass).val();		
		$.ajax({
			type:"post",
			url:"/user/login",
			data:{"userid":userid,"userpass":userpass},
			success:function(result){
				if(result==0){
					alert("아이디를 다시 입력하세요");
					$(frmLogin.userid).focus();
				}else if(result==2){
					alert("비밀번호를 다시 입력하세요");
					$(frmLogin.userpass).focus();						
				}else{
					alert("로그인 성공");
					location.href="/product/best";
				}	
			}
		});
	});

</script>