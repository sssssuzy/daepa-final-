<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>업체정보</h2>
<form name="frm">
	<table>
		<tr>
			<td class="title1" width=150>업체코드</td>
			<td><input type="text" name="mall_id" value="${vo.mall_id}" readonly></td>
			<td class="title1" width=150>업체이름</td>
			<td><input type="text"  name="mall_name" value="${vo.mall_name}"></td>
			<td class="title1" width=150>관리자</td>
			<td><input type="text"name="manager" value="${vo.manager}"></td>
		</tr>
		<tr>
			<td class="title1">주소</td>
			<td><input type="text"  name="address" value="${vo.address}"></td>
			<td class="title1">이메일</td>
			<td><input type="text"  name="email" value="${vo.email}"></td>
			<td class="title1">전화번호</td>
			<td colspan="3"><input type="text" name="tel" value="${vo.tel}" ></td>
		</tr>		
		<tr>		
			<td class="title1">상세정보</td>
			<td colspan="5">
				<textarea rows="10" cols="120" name="detail" >${vo.detail}</textarea>
			</td>
		</tr>
	</table>
	<div class="divButton">
		<input type="submit" class="btnStyle2" value="수정"/>	
		<input type="button" id="btnDel" class="btnStyle2" value="삭제"/>	
		<input type="reset" class="btnStyle2" value="취소"/>	
	</div>
</form>
<script>

//상품삭제하기
$("#btnDel").on("click",function(){
	var mall_id="${vo.mall_id}";
	var mall_name="${vo.mall_name}";
	if(!confirm(mall_name+"의 업체정보를 삭제하시겠습니까?")) return;
	frm.action="/mall/delete",
	frm.method="get",
	frm.submit();
	alert("삭제완료!");
	location.href="/mall/delete?mall_id="+mall_id;
});
//상품수정하기
$(frm).on("submit",function(e){
	e.preventDefault();
	if(!confirm("업체정보를 수정하시겠습니까?")) return;
	frm.action="/mall/update",
	frm.method="post",
	frm.submit();
});
</script>