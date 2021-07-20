<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="divInsert">	
		<div><h2>주문목록</h2></div>		
</div>
<div id="divCondition">
	<div id="divCondition1">	
		<select id="key">
			<option value="order_id">구매코드</option>
			<option value="name">구매자이름</option>
			<option value="address">주소</option>
		</select>		
		<input type="text" placeholder="검색어" id="word"/>	
		<select id="perpage">
			<option value="3">3개씩 보기</option>
			<option value="6"selected>6개씩 보기</option>
			<option value="9">9개씩 보기</option>
		</select>
		<span id="count"></span>
	</div>
	<div id="divCondition2">	
		<select id="order">
			<option value="order_id">최신순</option>
			<option value="name">이름순</option>
		</select>		
		<select id="desc">
			<option value="desc">내림차순</option>
			<option value="">오름차순</option>
		</select>
	</div>
</div>
<br/>
<table id="otbl"></table>	
<script id="otemp" type="text/x-handlebars-template">
	<tr class="title">
		<td width=80>주문번호</td>
		<td width=200>주문자이름</td>
		<td width=250>주소</td>
		<td width=150>전화번호</td>
		<td width=150>상세정보</td>
	</tr>
	{{#each purchaseList}}
	<tr class="row" pdate="{{pdate}}" paytype="{{paytype}}" email="{{email}}" status="{{status}}">
		<td class="order_id">{{order_id}}</td>
		<td class="name">{{name}}</td>
		<td class="address">{{address}}</td>
		<td class="tel">{{tel}}</td>
		<td><button class="btnStyle2">자세히보기</button></td>
	</tr>
	{{/each}}
</script>

<div id="btnCondition">
	<button id="btnPre" class="btnStyle1">이전</button>
	<span id="pageInfo"></span>
	<button id="btnNext" class="btnStyle1">다음</button>
</div>
<table id="orderInfo">
	<tr>
		<td class="title1" width=50>이름</td>
		<td class="name" width=100></td>
		<td class="title1"  width=50>전화번호</td>
		<td class="tel" width=100></td>
		<td class="title1"  width=50>이메일</td>
		<td class="email" width=100></td>
		<td class="title1"  width=50>구매일자</td>
		<td class="pdate" width=100></td>
	</tr>
	<tr>
		<td class="title1" width=50>주소</td>
		<td class="address"  colspan="3"></td>
		<td class="title1"  width=50>결제수단</td>
		<td class="paytype" width=100></td>
		<td class="title1"  width=50>상태</td>
		<td class="status" width=100></td>
	</tr>
</table>
<table id="productList"></table>
<script id="protemp" type="text/x-handlebars-template">
	<tr class="title">
		<td width=80>상품코드</td>
		<td width=200>상품이름</td>
		<td width=100>상품단가</td>
		<td width=100>상품수량</td>
		<td width=150>상품금액</td>
	</tr>
	{{#each .}}
	<tr class="row">
		<td>{{prod_id}}</td>
		<td>{{prod_name}}</td>
		<td>{{nf price}}원</td>
		<td>{{quantity}}개</td>
		<td>{{nf sum}}원</td>
	</tr>
	{{/each}}
</script>
<script>
Handlebars.registerHelper("nf", function(price){
    var regexp = /\B(?=(\d{3})+(?!\d))/g; 
    return price.toString().replace(regexp, ",");
});
</script>
<script>
	var page=1;
	getList();
	$("#orderInfo").hide();
	//주문자 정보 자세히보기
	$("#otbl").on("click",".row button",function(){		
		$("#orderInfo").show();
		var row = $(this).parent().parent();
		$("#orderInfo .name").html(row.find(".name").html());		
		$("#orderInfo .tel").html(row.find(".tel").html());
		$("#orderInfo .email").html(row.attr("email"));
		$("#orderInfo .pdate").html(row.attr("pdate"));
		$("#orderInfo .address").html(row.find(".address").html());
		var paytype=row.attr("paytype")=="0"?"무통장입금":"카드";
		$("#orderInfo .paytype").html(paytype);
		var status=row.attr("status")=="0"?"처리중":"처리완료";
		$("#orderInfo .status").html(status);
		var order_id=row.find(".order_id").html();	
		$.ajax({			
			type:"get",
			url:"/purchase/productList.json",
			dataType:"json",
			data:{"order_id":order_id},
			success:function(result){	
				var temp = Handlebars.compile($("#protemp").html());
				$("#productList").html(temp(result));
			}
		});
	});
	//주문상품출력	
	$("#word").on("keydown",function(e){
		if(e.keyCode=13){
			page=1;
			getList();
		}
	});
	$("#perpage").on("change",function(){
		page=1;
		getList();
	});
	$("#btnPre").on("click",function(){
		page--;
		getList();
	});
	$("#btnNext").on("click",function(){
		page++;
		getList();
	});
	function getList(){
		var key=$("#key").val();
		var word=$("#word").val();
		var perpage=$("#perpage").val();
		var order=$("#order").val();
		var desc=$("#desc").val();
		$.ajax({
			type:"get",
			url:"/purchase/list.json",
			dataType:"json",
			data:{"key":key,"word":word,"page":page,"perpage":perpage,"order":order,"desc":desc},
			success:function(result){	
				var temp = Handlebars.compile($("#otemp").html());
				$("#otbl").html(temp(result));
				$("#count").html("업체수 :" + result.count + "개");
				var lastPage= Math.ceil(result.count/perpage);
				$("#pageInfo").html(page+"/"+lastPage);
				if(page==1){
					$("#btnPre").attr("disabled",true);
				}else{
					$("#btnPre").attr("disabled",false);
				}
				if(page==lastPage){
					$("#btnNext").attr("disabled",true);
				}else{
					$("#btnNext").attr("disabled",false);
				}			
			}
		});
	}
</script>


