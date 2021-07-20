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
			url:url,
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