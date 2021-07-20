<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h2>상품정보</h2>
<form name="frm" enctype="multipart/form-data">
	<table>
		<tr>
			<td class="title1" width=150>상품코드</td>
			<td><input type="text" name="prod_id" value="${vo.prod_id}" readonly></td>
			<td class="title1" width=150>제조원/수입원</td>
			<td><input type="text"  name="company" value="${vo.company}"></td>
			<td class="title1" width=150>상품분류</td>
			<td>
				<select id="prod_item" class="prod_item" name="prod_item" value="${vo.prod_item}">
					<option value="outer">OUTER</option>
					<option value="top" >TOP</option>
					<option value="bottom" >BOTTOM</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="title1">업체코드</td>
			<td>
				<input type="text"  name="mall_id"  size=2 value="${vo.mall_id}">&nbsp;
				<input type="text" name="mall_name"  size=15  value="${vo.mall_name}">
			</td>
			<td class="title1">판매가격</td>
			<td><input type="text"  name="price1"value="${vo.price1}"/></td>
			<td class="title1">일반가격</td>
			<td><input type="text"  name="price2"  value="${vo.price2}" /></td>
		</tr>
		<tr>
			<td class="title1">상품이름</td>
			<td colspan="3"><input type="text"  name="prod_name" value="${vo.prod_name}" size=72></td>
			<td class="title1">판매상태</td>
			<td><input type="checkbox"  name="prod_del" value="${vo.prod_del}" <c:out value="${vo.prod_del=='1'?'checked':''}"/>>판매중지</td>
		</tr>
		<tr>
			<td class="title1">상품설명</td>
			<td colspan="3"><textarea rows="10" cols="74"  name="detail">${vo.detail}</textarea></td>
			<td class="title1">상품이미지</td>
			<td>
				<input type="file" name="image" size=100 style="display:none;" accept="image/*"/>
				<c:if test="${vo.image==null}">
					<img src="http://placehold.it/150x200" id="image"/>
				</c:if>
				<c:if test="${vo.image!=null}">
				<img src="/product/image/${vo.image}" id="image" width=150/>
				</c:if>
			</td>
		</tr>
	</table>
	<div class="divButton">
		<input type="submit" class="btnStyle2" value="수정"/>			
		<input type="button" class="btnStyle2" value="삭제" id="btnDel" />	
		<input type="reset" class="btnStyle2" value="취소"/>	
	</div>
</form>
<script>
	//상품삭제하기
	$("#btnDel").on("click",function(){
		var prod_id="${vo.prod_id}";
		var prod_name="${vo.prod_name}";
		if(!confirm(prod_name+"을(를) 삭제하시겠습니까?")) return;
		location.href="/product/delete?prod_id="+prod_id;
		alert("삭제완료!");
	});
	//판매중지하기
	$(frm.prod_del).on("click",function(){
		if($(frm.prod_del).is(":checked")){
			$(frm.prod_del).val(1);
			alert("상품 판매를 중지합니다.");
		}else{
			$(frm.prod_del).val(0);
			alert("상품을 판매중으로 전환합니다.");
		}
	});
	//업체정보 리스트 띄우기
	$(frm.mall_id).on("click",function(){
		window.open("/mall/mallList.jsp","mall","width=400,height=500,top=200,left=900")
	});
	//상품수정하기
	$(frm).on("submit",function(e){
		e.preventDefault();
		if(!confirm("상품을 수정하시겠습니까?")) return;		
		frm.action="/product/update",
		frm.method="post",
		frm.submit();
	});
	//이미지 src 클릭시 파일상자 열기
	$("#image").on("click",function(){
		$(frm.image).click();
	});
	//이미지 미리보기
	$(frm.image).on("change",function(){
		var reader=new FileReader();
		reader.onload=function(e){
			$("#image").attr("src",e.target.result);
		}
		reader.readAsDataURL(this.files[0]);
	});
</script>