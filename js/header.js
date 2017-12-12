(()=>{

 //加载header 
 $("#header").load("header.html",()=>{
	 /*登录功能***********************/
	 var $login=$("#listLogin");
	 var $welcome=$("#listWelcome");
	 /*判断是否登录  uid的存在*/
	/*$.ajax({
		type:"get",
		url:"data/header/isLogin.php",
		success:function(data){ 
			console.log(data);
			if(data.code==1){
				$("#uname").text(data.uname);
				$welcome.show();
				$login.hide();
			}else{
				$welcome.hide();
				$login.show();
			}
		}
	})*/
	$.get("data/header/isLogin.php")
		.then(data=>{
		 //console.log(data);
			if(data.code==1){
				$("#uname").text(data.uname);
				$welcome.show();
				$login.hide();
			}else{
				$welcome.hide();
				$login.show();
			}
		})
	 /*注销按钮*/
	 $("#btnLogout").click(()=>{
		$.get("data/header/logout.php")
		 .then(()=>location.reload());
	 })
		
	
	/*更换头像*/
	$.ajax({
			type:"get",
			url:"data/myadmin/myself.php",
            success:function(data){
				$("#avatar").attr("src",`${data.avatar}`);
			},
			error:function(){
				alert("网络错误");
			}

        });


 
	 /*为查询按钮绑定单击事件跳转********/

	 var $search=$("#search");
	  //console.log($search);
	 function find(){
        var $input=$("#txtSearch");
		   var kw=$input.val();
		if(kw.trim().length!=0){
			var url="products.html?kw="+kw;
		    location=url;
		}
    };
     
	 $search.click(function(e){
			find();
	    }
	 );
	



	/*********drapdown********************/
	$(".dropdown").on("mouseover",function(){
        $(this).children().last().addClass("in");
    });
	$(".dropdown").on("mouseout",function(){
        $(this).children().last().removeClass("in");
    });
	
	
	/**搜素框**/
	//输入框失去焦点,清空录得内容
	var clear=function(){
		$("#top-input>ul.autocomplete").html("");
	};
	$("#txtSearch").blur(function(){
		setTimeout(clear,500);
	});
	var key=0;
	
	$("#txtSearch").keyup(function(e){
		var term=$(this).val();
		//console.log(term);

		/*字母数字键盘指定 加载数据*/
		if(e.keyCode > 40 || e.keyCode == 8 || e.keyCode ==32){
			$.ajax({
				type:"get",
				url:"data/header/expand.php",
				data:{term:term},
				success:function(data){
					//console.log(data);
					var html="";
					//for(var p of data){
						//html+=`<li>${p.title}</li>`;
					//};
					$.each(data, function(index,term) {
						//console.log(index);
						//console.log(term);
						html+=`<li data-id="${index}">${term.title}</li>`
					})
					$("#top-input>ul.expand").html(html);

					// 鼠标移入li变高亮
					$("#top-input>ul>li").hover(
						//添加高亮消除其他高亮
						(e)=>{
							 //console.log( $(e.target));
							 $(e.target).addClass("highlight").siblings().removeClass("highlight");
							 key=$(e.target).index();//获取当前li的位置
							 //console.log(key);
						},
						
						(e)=>{
							//离开后消除其高亮,设置key为-1
							$(e.target).removeClass('highlight');
							key = -1;
							//console.log(key);
						}
						//点击后赋值
					).click(function(e){
						var kw=$(e.target).text();
						 //console.log(kw);
						 $("#txtSearch").val(kw);
						 setTimeout(find(),100);
					});
					 //console.log(key);

				},
				error:function(){
					alert("网络错误");
				}
			})//*ajax*//
		}/*字母数字键盘指定*/
		/*其余按键*/
		/*下键*/
		//下拉列表li个数
		var lis=$("#top-input>ul>li").length;
		
		///key:上键和下键的范围,以及高亮
		var setKey=function(item){
			key=item;
			if(key<0) key=lis-1;
			if(key>lis-1) key=0;
			$("#top-input>ul>li").removeClass('highlight').eq(key).addClass('highlight');
		 };

		//console.log(lis);
		// 下键绑定40
		  if(e.keyCode == 40){
			if(key==-1){
			  setKey(0);
			}else{
			  setKey(key+1);
			}
		  };
		//上键绑定函数38
		if(e.keyCode == 38){
			if(key==-1){
			  setKey(0);
			}else{
			  setKey(key-1);
			}
		  };
		// esc键
		if(e.keyCode == 27){
			
			setTimeout(clear,200);
        };

		// 回车键13
		if(e.keyCode == 13 ){
			console.log(lis);
			console.log(key);
			//find();
			//setTimeout(find(),1000);
			if(lis!=0 && key>0){
				var kw=$("#top-input>ul>li").eq(key).text();
				$("#txtSearch").val(kw);
				setTimeout(find(),100);
			};
			if(lis==0 || key==0 ||key==-1){
				setTimeout(find(),1000);
			};
		}
	})

/***/
	/*下拉导航**/
	$("#loadingSearch").on("click","a",function(e){
			e.preventDefault;
			//console.log($(this));
			var keys=$(this).html();
			var url="products.html?kw="+keys;
			$(this).attr("href",url);
	})

/***/
})



/***********************/
})();
