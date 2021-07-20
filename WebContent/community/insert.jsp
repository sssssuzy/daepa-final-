<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>Q/A</h2>
<form name="frm">
	<table>
		<tr>
			<td class="title1" width=150>글번호</td>
			<td><input type="text" name="noid" value="${noid}"></td>
			<td class="title1" width=150>글종류</td>
			<td>
				<select id="category" class="category" name="category">
					<option value="배송문의" >배송문의</option>
					<option value="교환문의" >교환문의</option>
					<option value="환불문의" >환불문의</option>
					<option value="상품문의" >상품문의</option>
				</select>
			</td>
			<td class="title1" width=150>아이디</td>
			<td><input type="text" name="userid" value="${vo.userid}"></td>
		</tr>
		<tr>			
			<td class="title1">제목</td>
			<td colspan="5"><input type="text"  name="subtitle" size=50></td>
		</tr>		
		<tr>		
			<td class="title1">내용</td>
			<td colspan="5">
				<textarea rows="10" cols="120" name="content"></textarea>
			</td>
		</tr>
	</table>
	<div class="divButton">
		<input type="submit" class="btnStyle2" value="등록"/>	
		<input type="reset" class="btnStyle2" value="취소"/>	
	</div>
</form>
<script>
//글등록하기
$(frm).on("submit",function(e){
	e.preventDefault();
	if(!confirm("글을 등록하시겠습니까?")) return;
	frm.action="/community/insert",
	frm.method="post",
	frm.submit();
});
</script>