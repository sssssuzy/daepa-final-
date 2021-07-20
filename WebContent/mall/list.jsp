<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="divInsert">	
		<div><h2>업체목록</h2></div>
		<div><span class="insert"><button class="btnStyle2"  onClick="location.href='/mall/insert'">업체등록</button></span></div>
</div>
<div id="divCondition">
	<div id="divCondition1">	
		<select id="key">
			<option value="mall_name">업체이름</option>
			<option value="mall_id">업체코드</option>
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
			<option value="mall_id">최신순</option>
			<option value="mall_name">이름순</option>
		</select>		
		<select id="desc">
			<option value="desc">내림차순</option>
			<option value="">오름차순</option>
		</select>
	</div>
</div>
<br/>
<br/>
<table id="mtbl"></table>	
<script id="mtemp" type="text/x-handlebars-template">
	<tr class="title">
		<td width=80>업체코드</td>
		<td width=200>업체명</td>
		<td width=250>주소</td>
		<td width=150>전화번호</td>
		<td width=150>메일주소</td>
		<td width=150>상세정보</td>
	</tr>
	{{#each mallList}}
	<tr class="row">
		<td>{{mall_id}}</td>
		<td>{{mall_name}}</td>
		<td>{{address}}</td>
		<td>{{tel}}</td>
		<td>{{email}}</td>
		<td><button class="btnStyle2" onClick="location.href='/mall/read?mall_id={{mall_id}}'">업체정보</button></td>
	</tr>
	{{/each}}
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
			url:"/mall/list.json",
			dataType:"json",
			data:{"key":key,"word":word,"page":page,"perpage":perpage,"order":order,"desc":desc},
			success:function(result){	
				var temp = Handlebars.compile($("#mtemp").html());
				$("#mtbl").html(temp(result));
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
