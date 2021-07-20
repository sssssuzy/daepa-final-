<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="divInsert">	
		<div><h2>상품목록</h2></div>
		<div><span class="insert"><button class="btnStyle2" onClick="location.href='/product/insert'">상품등록</button></span></div>
</div>

<div id="divCondition">
	<div id="divCondition1">	
		<select id="key">
			<option value="prod_name"> 상품이름</option>
			<option value="prod_id">상품코드</option>
			<option value="prod_item">상품별</option>
			<option value="company">업체명</option>
		</select>		
		<input type="text" placeholder="검색어" id="word"/>	
		<select id="perpage">
			<option value="3" >3개씩 보기</option>
			<option value="6" selected>6개씩 보기</option>
			<option value="9">9개씩 보기</option>
		</select>
		<span id="count"></span>
	</div>
	<div id="divCondition2">	
		<select id="order">
			<option value="prod_id">최신순</option>
			<option value="prod_name">이름순</option>
		</select>		
		<select id="desc">
			<option value="desc">내림차순</option>
			<option value="">오름차순</option>
		</select>
	</div>
</div>
<br/>
<table id="ptbl"></table>	
<script id="ptemp" type="text/x-handlebars-template">
	<tr class="title">
		<td width=80>상품코드</td>
		<td width=200>상품명</td>
		<td width=100>상품분류</td>
		<td width=100>업체명</td>
		<td width=100>제조사</td>
		<td width=80>판매가</td>
		<td width=80>일반가</td>
		<td width=80>상세정보</td>
	</tr>
	{{#each productList}}
	<tr class="row">
		<td>{{prod_id}}</td>
		<td>{{prod_name}}</td>
		<td>{{prod_item}}</td>
		<td>{{mall_id}}</td>
		<td>{{company}}</td>
		<td>{{nf price1}}원</td>
		<td>{{nf price2}}원</td>
		<td><button class="btnStyle2" onClick="location.href='/product/read?prod_id={{prod_id}}'">상품정보</button></td>
	</tr>
	{{/each}}
</script>
<script>
Handlebars.registerHelper("nf", function(price1){
    var regexp = /\B(?=(\d{3})+(?!\d))/g; 
    return price1.toString().replace(regexp, ",");
});
</script>
<div id="btnCondition">
	<button id="btnPre" class="btnStyle1">이전</button>
	<span id="pageInfo"></span>
	<button id="btnNext" class="btnStyle1">다음</button>
</div>

<script>
	var page=1;
	getList();
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
			url:"/product/list.json",
			dataType:"json",
			data:{"key":key,"word":word,"page":page,"perpage":perpage,"order":order,"desc":desc},
			success:function(result){	
				var temp = Handlebars.compile($("#ptemp").html());
				$("#ptbl").html(temp(result));
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
