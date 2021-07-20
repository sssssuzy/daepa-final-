<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet"  href="/css/style.css"/>
<div class="divInsert">	
		<div><h2>업체목록</h2></div>
		<div><span class="insert"><button id="btnClose" class="btnStyle2" >닫기</button></span></div>
	</div>
<div id="divCondition" >
	<div id="divCondition1">	
		<select id="key">
			<option value="mall_name">업체이름</option>
			<option value="mall_id">업체코드</option>
			<option value="address">주소</option>
		</select>		
		<input type="text" placeholder="검색어" id="word"/>	
		<select id="perpage" style="display:none;">
			<option value="3" >3개씩 보기</option>
			<option value="6" >6개씩 보기</option>
			<option value="10" selected>9개씩 보기</option>
		</select>
		<span id="count"></span>
	</div>
	<div id="divCondition2" style="display:none;">	
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
	</tr>
	{{#each mallList}}
	<tr class="row">
		<td class="mall_id">{{mall_id}}</td>
		<td class="mall_name">{{mall_name}}</td>
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
	
	$("#btnClose").on("click",function(){
		window.close();
	});
	$("#mtbl").on("click",".row",function(){
		var mall_id=$(this).find(".mall_id").html();
		var mall_name=$(this).find(".mall_name").html();
		$(opener.frm.mall_id).val(mall_id);
		$(opener.frm.mall_name).val(mall_name);
		window.close();
	});	
	
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
