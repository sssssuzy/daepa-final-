<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="divInsert">	
		<div><h2>Q/A</h2></div>
		<div><span class="insert"><button class="btnStyle2" onClick="location.href='/community/insert'">글쓰기</button></span></div>
</div>
<div id="divCondition">
	<div id="divCondition1">	
		<select id="key">
			<option value="userid">작성자</option>
			<option value="noid">문의번호</option>
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
			<option value="noid">최신순</option>
			<option value="name">이름순</option>
		</select>		
		<select id="desc">
			<option value="desc">내림차순</option>
			<option value="">오름차순</option>
		</select>
	</div>
</div>
<br/>
<table id="qnatbl"></table>	
<script id="qnatemp" type="text/x-handlebars-template">
	<tr class="title">
		<td width=80>NO</td>
		<td width=200>CATEGORY</td>
		<td width=250>TITLE</td>
		<td width=150>DATE</td>
		<td width=150>ID</td>
	</tr>
	{{#each qnaList}}
	<tr class="row" >
		<td class="noid">{{noid}}</td>
		<td class="category">{{category}}</td>
		<td class="subtitle">{{subtitle}}</td>
		<td class="qnadate">{{qnadate}}</td>
		<td class="userid">{{userid}}</td>
	</tr>
	{{/each}}
</script>

<div id="btnCondition">
	<button id="btnPre" class="btnStyle1">이전</button>
	<span id="pageInfo"></span>
	<button id="btnNext" class="btnStyle1">다음</button>
</div>
<script>
Handlebars.registerHelper("nf", function(price){
    var regexp = /\B(?=(\d{3})+(?!\d))/g; 
    return price.toString().replace(regexp, ",");
});
</script>
<script>
	var page=1;
	getList();
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
			url:"/community/list.json",
			dataType:"json",
			data:{"key":key,"word":word,"page":page,"perpage":perpage,"order":order,"desc":desc},
			success:function(result){	
				var temp = Handlebars.compile($("#qnatemp").html());
				$("#qnatbl").html(temp(result));
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


