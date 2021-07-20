<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div><img src="/css/2.png"></div>
<div id="divCondition">
	<div id="divCondition1">	
		<select id="key">
			<option value="prod_item" seleted>상품분류</option>
			<option value="prod_name">상품이름</option>
			<option value="prod_id">상품코드</option>			
			<option value="detail">내용</option>
		</select>		
		<input type="text" placeholder="검색어" id="word" value="outer" />	
		<select id="perpage">
			<option value="3">3개씩 보기</option>
			<option value="6" selected>6개씩 보기</option>
			<option value="9">9개씩 보기</option>
		</select>
		<span id="count"></span>
	</div>
	<div id="divCondition2">	
		<select id="order">
			<option value="prod_id">신상순</option>
			<option value="price1">가격순</option>
			<option value="prod_name">이름</option>
		</select>		
		<select id="desc">
			<option value="desc">내림차순</option>
			<option value="">오름차순</option>
		</select>
	</div>
</div>
<br/>
<div id="tbl"></div>
<script id="temp" type="text/x-handlebars-template">
	{{#each productList}}
	<div class="productBox" productId="{{prod_id}}" productName="{{prod_name}}" price="{{price1}}">
		<img src="{{pntImage image}}" id="productImg" />
		<div>{{prod_id}}/{{prod_name}}</div>
		<div> ￦ {{nf price1}}</div>
		<div class="detail">{{detail}}</div>
		<div class="del{{prod_del}}">{{status prod_del}}</div>
	</div>
	{{/each}}
</script>
<script>
Handlebars.registerHelper("nf", function(price1){
    var regexp = /\B(?=(\d{3})+(?!\d))/g; 
    return price1.toString().replace(regexp, ",");
});
Handlebars.registerHelper("status", function(prod_del){
    if(prod_del==0){
  	  return "장바구니 담기";
    }else{
  	  return "품절";
    }
});
Handlebars.registerHelper("pntImage", function(image){
	if(!image){
		return "http://placehold.it/300x400";
	}else{
		return "/product/image/"+image;
	}
});
</script>
<div><img id="blank" src="/css/white.png"></div>
<div id="btnCondition">
	<button id="btnPre" class="btnStyle1">이전</button>
	<span id="pageInfo"></span>
	<button id="btnNext" class="btnStyle1">다음</button>
</div>

<script>
	var page=1;
	getList();
	//장바구니담기 눌렀을때
	$("#tbl").on("click",".productBox .del0",function(){		
		var box=$(this).parent();
		var prod_id=box.attr("productId");
		var prod_name=box.attr("productName");
		var price=box.attr("price");
		if(!confirm(prod_name+"을(를) 장바구니에 넣으시겠습니까?")) return;
		$.ajax({
			type:"get",
			url:"/order/insert",
			data:{"prod_id":prod_id,"prod_name":prod_name,"price":price},
			success:function(){
				if(!confirm("장바구니로 이동하실래요?")) return;
				location.href="/order/cart";
			}
		});
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
			url:"/product/list.json",
			dataType:"json",
			data:{"key":key,"word":word,"page":page,"perpage":perpage,"order":order,"desc":desc},
			success:function(result){					
				var temp = Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(result));
				$("#count").html("상품수 :" + result.count + "개");
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
