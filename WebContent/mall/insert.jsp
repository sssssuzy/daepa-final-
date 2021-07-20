<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>업체등록</h2>
<form name="frm">
	<table>
		<tr>
			<td class="title1" width=150>업체코드</td>
			<td><input type="text" name="mall_id" value="${mall_id}"></td>
			<td class="title1" width=150>업체이름</td>
			<td><input type="text"  name="mall_name"></td>
			<td class="title1" width=150>관리자</td>
			<td><input type="text"name="manager"></td>
		</tr>
		<tr>
			<td class="title1">주소</td>
			<td><input type="text"  name="address"></td>
			<td class="title1">이메일</td>
			<td><input type="text"  name="email" ></td>
			<td class="title1">전화번호</td>
			<td colspan="3"><input type="text"  name="tel"  ></td>
		</tr>		
		<tr>		
			<td class="title1">상세정보</td>
			<td colspan="5">
				<textarea rows="10" cols="120" name="detail"></textarea>
			</td>
		</tr>
	</table>
	<div class="divButton">
		<input type="submit" class="btnStyle2" value="등록"/>	
		<input type="reset" class="btnStyle2" value="취소"/>	
	</div>
</form>
<script>
//상품등록하기
$(frm).on("submit",function(e){
	e.preventDefault();
	if(!confirm("업체를 등록하시겠습니까?")) return;
	frm.action="/mall/insert",
	frm.method="post",
	frm.submit();
});
</script>