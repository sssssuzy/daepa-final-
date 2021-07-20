<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>상품등록</h2>
<form name="frm" enctype="multipart/form-data">
	<table>
		<tr>
			<td class="title1" width=150>상품코드</td>
			<td><input type="text" name="prod_id" value="${prod_id}"></td>
			<td class="title1" width=150>제조원/수입원</td>
			<td><input type="text"  name="company"></td>
			<td class="title1" width=150>상품분류</td>
			<td>
				<select id="prod_item" class="prod_item" name="prod_item">
					<option value="outer" >OUTER</option>
					<option value="top" >TOP</option>
					<option value="bottom" >BOTTOM</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="title1">업체코드</td>
			<td colspan="3">
				<input type="text"  name="mall_id" size=5 >&nbsp;
				<input type="text" name="mall_name" size=60>
			</td>
			<td class="title1">판매가격</td>
			<td colspan="3"><input type="text"  name="price1" value="0"/></td>
		</tr>
		<tr>
			<td class="title1">상품이름</td>
			<td colspan="3"><input type="text"  name="prod_name"  size=72></td>
			<td class="title1">일반가격</td>
			<td colspan="3"><input type="text"  name="price2"  value="0" /></td>
		</tr>
		<tr>
			<td class="title1">상품설명</td>
			<td colspan="3"><textarea rows="10" cols="74" name="detail"></textarea></td>
			<td class="title1">상품이미지</td>
			<td>
				<input type="file" name="image" size=100 style="display:none;" accept="image/*"/>
				<img src="http://placehold.it/150x200" id="image" width=150/>
			</td>
		</tr>
	</table>
	<div class="divButton">
		<input type="submit" class="btnStyle2" value="등록"/>	
		<input type="reset" class="btnStyle2" value="취소"/>	
	</div>
</form>
<script>
	//업체정보 리스트 띄우기
	$(frm.mall_id).on("click",function(){
		window.open("/mall/mallList.jsp","mall","width=400,height=500,top=200,left=900")
	});	
	//상품등록하기
	$(frm).on("submit",function(e){
		e.preventDefault();
		if(!confirm("상품을 등록하시겠습니까?")) return;
		frm.action="/product/insert",
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