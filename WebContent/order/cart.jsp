<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>	
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div><h2>장바구니</h2></div>	
<c:if test="${cartList.size()==0||cartList==null}">
	<table>
		<tr class="title">
			<td width=800>장바구니가 비어있습니다</td>
		</tr>
	</table>
</c:if>
<c:if test="${cartList.size()>0}">
	<table id="tbl">
		<tr class="title">
			<td><input type="checkbox" id="chkAll"></td>
			<td>CODE</td>
			<td>NAME</td>
			<td>PRICE</td>
			<td>QUANTITY</td>
			<td>TOTAL</td>
			<td>DEL</td>
		</tr>		
		<c:forEach items="${cartList}" var="vo">
			<tr class="row">		
				<td><input type="checkbox" class="chk"></td>
				<td class="prod_id">${vo.prod_id}</td>
				<td class="prod_name">${vo.prod_name}</td>
				<td class="price">${vo.price}</td>
				<td>
					<input type="text" value="${vo.quantity}" class="quantity" id="quantity" size=3>
					<button id="btnUpdate" class="btnStyle3">수정</button>
				</td>
				<td class="sum"><fmt:formatNumber value="${vo.price*vo.quantity}" pattern="#,###원"></fmt:formatNumber></td>
				<td><button id="btnDelete" class="btnStyle3">삭제</button></td>
			</tr>
		</c:forEach>	
	</table>
	<div class="divButton">
		<button id="orderAll" class="btnStyle2">전체상품주문</button>
		<button id="orderSel" class="btnStyle2">선택상품주문</button>
	</div>
</c:if>
<div id="divOrder">
<h2>주문하기</h2>
<table id="tblOrder"></table>
	<script id="tempOrder" type="text/x-handlebars-template">
		<tr class="title">
			<td>CODE</td>
			<td>NAME</td>
			<td>PRICE</td>
			<td>QUANTITY</td>
			<td>TOTAL</td>				
		</tr>
		{{#each .}}
		<tr class="row">
			<td class="prod_id">{{id}}</td>
			<td>{{name}}</td>
			<td class="price">{{price}}</td>
			<td class="quantity">{{quantity}}</td>
			<td>{{sum}}</td>
		</tr>		
		{{/each}}
		<tr>
			<td colspan="4" style="text-align:center">총 결제금액</td>		
			<td></td>			
		</tr>
	</script>
	<form name="frm">
		<table id="order_idInfo">
			<tr>
				<td width=200 class="title1">주문자 성명</td>
				<td class="row1"><input type="text" name="name" value="김수지"/></td>
			</tr>
			<tr>
				<td width=200 class="title1">배송지 주소</td>
				<td class="row1"><input type="text" name="address" value="인천 남동구 구월동 " size=50/></td>
			</tr>
			<tr>
				<td width=200 class="title1">이메일 주소</td>
				<td class="row1"><input type="text" name="email" value="sssssuzy@naver.com" size=50/></td>
			</tr>
			<tr>
				<td width=200 class="title1">전화번호</td>
				<td class="row1"><input type="text" name="tel" value="010-0001-8282"/></td>
			</tr>
			<tr>
				<td width=200 class="title1">결제방법</td>
				<td class="row1">
					<input type="radio" name="paytype" value="0" checked/>무통장입금
					<input type="radio" name="paytype" value="1"/>신용카드
				</td>
			</tr>
		</table>
		<div class="divButton">
		<input type="submit" class="btnStyle2" value="주문하기"/>
		<input type="reset" class="btnStyle2" value="취소"/>
		</div>
	</form>
</div> 
<script>
	$("#divOrder").hide();
	$(frm).on("submit",function(e){
		e.preventDefault();
		if(!confirm("상품을 주문하시겠습니까?")) return;
		var name=$(frm.name).val();
		var address=$(frm.address).val();
		var tel=$(frm.tel).val();
		var email=$(frm.email).val();
		var paytype=$("input[name='paytype']:checked").val();
		//alert(name+"\n"+address+"\n"+tel+"\n"+email+"\n"+paytype);
		$.ajax({
			type:"post",
			url:"/purchase/insert",
			data:{"name":name,"address":address,"tel":tel,"email":email,"paytype":paytype},
			success:function(order_id){
				$("#tblOrder .row").each(function(){
					var prod_id=$(this).find(".prod_id").html();
					var price=$(this).find(".price").html();
					var quantity=$(this).find(".quantity").html();
					//alert(prod_id+"\n"+price+"\n"+quantity);
					$.ajax({
						type:"post",
						url:"/purchase/insert_product",
						data:{"order_id":order_id,"prod_id":prod_id,"price":price,"quantity":quantity},
						success:function(){}
					});
				});				
			}
		});
		alert("주문완료!");
		frm.action="/purchase/list";
		frm.method="get";
		frm.submit();
	});
	//전체상품주문 클릭시
	$("#orderAll").on("click",function(){
		$("#divOrder").show();
		var array=[];
		$("#tbl .row .chk").each(function(){
			var row = $(this).parent().parent();
			var prod_id = row.find(".prod_id").html();
			var prod_name = row.find(".prod_name").html();
			var price = row.find(".price").html();
			var quantity = row.find(".quantity").val();
			var sum = row.find(".sum").html();
			var data={"id":prod_id,"name":prod_name,"price":price,"quantity":quantity,"sum":sum};
			array.push(data);
		});
		var temp = Handlebars.compile($("#tempOrder").html());
		$("#tblOrder").html(temp(array));
	});
	//선택상품주문 클릭시
	$("#orderSel").on("click",function(){
		if($("#tbl .row .chk:checked").length==0){
			alert("주문할 상품을 선택하세요!");
			return;
		}
		var array=[];
		$("#tbl .row .chk:checked").each(function(){
			$("#divOrder").show();
			var row = $(this).parent().parent();
			var prod_id = row.find(".prod_id").html();
			var prod_name = row.find(".prod_name").html();
			var price = row.find(".price").html();
			var quantity = row.find(".quantity").val();
			var sum = row.find(".sum").html();
			var data={"id":prod_id,"name":prod_name,"price":price,"quantity":quantity,"sum":sum};
			array.push(data);
		});
		//console.log(array);
		var temp = Handlebars.compile($("#tempOrder").html());
		$("#tblOrder").html(temp(array));			
		});		
	
	//선택 체크박스 클릭
	$("#tbl .row .chk").on("click",function(){
		var num1=$("#tbl .row .chk").length;
		var num2=$("#tbl .row .chk:checked").length;
		if(num1==num2){
			$("#chkAll").prop("checked",true);
		}else{
			$("#chkAll").prop("checked",false);
		}
	});
	//전체 체크박스 클릭
	$("#chkAll").on("click",function(){
		if($(this).is(":checked")){
			$("#tbl .row .chk").each(function(){
				$(this).prop("checked",true);
			});
		}else{
			$("#tbl .row .chk").each(function(){
				$(this).prop("checked",false);
			});					
		}
	});
	//장바구니 수량 수정하기
	$("#tbl").on("click",".row #btnUpdate",function(){
		var row=$(this).parent().parent();
		var prod_id = row.find(".prod_id").html();
		var quantity = row.find(".quantity").val();		
		if(!confirm(prod_id+"의 수량을 "+quantity+"개로 수정하시겠습니까?")) return;
		$.ajax({
			type:"get",
			url:"/order/update",
			data:{"prod_id":prod_id,"quantity":quantity},
			success:function(){
				alert("수정완료!");
				location.href="/order/cart";
			}
		});
	});
	
	//장바구니 삭제하기
	$("#tbl").on("click",".row #btnDelete",function(){
		var prod_id = $(this).parent().parent().find(".prod_id").html();
		if(!confirm(prod_id+("을(를) 장바구니에서 삭제하실래요?"))) return;
		$.ajax({
			type:"get",
			url:"/order/delete",
			data:{"prod_id":prod_id},
			success:function(){
				alert("삭제완료!");
				location.href="/order/cart";
			}			
		});
	});
</script>