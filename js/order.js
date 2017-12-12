window.onload= function () {
	/*登录功能***********************/
	 var $login=$("#listLogin");
	 var $welcome=$("#listWelcome");
	 /*判断是否登录  uid的存在*/
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
	/*********drapdown********************/
	$(".dropdown").on("mouseover",function(){
        $(this).children().last().addClass("in");
    });
	$(".dropdown").on("mouseout",function(){
        $(this).children().last().removeClass("in");
    });
		

	/*****************/
	/*****弹框********/
	function jumpMsg(msg,code){
		var code=parseInt(code);
		$("#jumpbox").css("display","block");
		$("#msg").html(msg);
		$("#yes").click(function(){
			$(this).parent().parent().css("display","none");
			if($(this).parent().parent().css("display")=="none"&& code>0){
				location.href = "cart.html";
			}
		});
		$("#no").click(function(){
			$(this).parent().parent().css("display","none");
		});
	
	};

	/*********************/
	

	
	//添加地址
	$.ajax({
		type:"get",
		url:"data/order/address.php",
		success:function(data){
			var html="";
			for(var p of data){
				html+=`<li>
					<input type="radio" value="1" name="address" data-check='${p.is_default}' data-address_id='${p.aid}'><span>${p.province} ${p.city} ${p.county} ${p.address} </span> <span>   ${p.receiver}</span> (收)  <span id="telephone"> ${p.cellphone}</span>
					</li>
				`;
			}
			html+=`
				<li>
					<button id="add_address"><img src="img/list/add.png"/>添加新地址</button>
				</li>
			`;
			$("#address>ul").html(html);
			$('[data-check=1]').attr("checked",true);
			/*订单地址变化*/
			function  updateAddress(){
				var address=$("#address>ul").find("input[type='radio']:checked").next().html();
				$("#sure>li>span.postaddress").html(address);
				var user=$("#address>ul").find("input[type='radio']:checked").next().next().html();
				$("#sure>li>span.user").html(user);
				var phone=$("#address>ul").find("input[type='radio']:checked").next().next().next().html();
				$("#sure>li>span.phone").html(phone);
			
			}
			/****/
			updateAddress();
			$("input[type='radio']").change(function(){
				updateAddress();
			})
			
			//修改地址
			$.cxSelect.defaults.url = 'js/cityData.min.json';
			$('#china').cxSelect({
					selects: ['province', 'city', 'area'],
					nodata: 'none'
			});
			$("#add_address").click(function(){
				$("#jumpbox").css("display","block");
				
				$("#yes").click(function(){
					var province=$("#china select.province.cxselect").find(":selected").text();
					console.log(province);
					var city=$("#china select.city.cxselect").find(":selected").text();
					console.log(city);
					var county=$("#china select.area.cxselect").find(":selected").text();
					console.log(county);
					var address=$("#jump>ul>li>textarea").val();
					console.log(address);
					var postcode=$("#postcode").val();
					console.log(postcode);
					var cellphone=$("#cellphone").val();
					console.log(cellphone);
					var receiver=$("#receiver").val();
					console.log(receiver);
					var is_default=$("#jump>ul>li.default>label>input").prop("checked");
					console.log(is_default);
					$.ajax({
						type:"post",
						url:"data/order/addAddress.php",
						data:{
							province:province,
							city:city,
							county:county,
							address:address,
							postcode:postcode,
							cellphone:cellphone,
							receiver:receiver,
							is_default,is_default
						},
						success:function(data){
							console.log(data);
							$(this).parent().parent().parent().css("display","none");
							window.location.reload();
						},
						error:function(){
							alert("网络错误");
						}
					})
					
				});
				$("#no").click(function(){
					$(this).parent().parent().parent().css("display","none");
				});
			
			})

		



		},
		error:function(){
			alert("网路错误");	
		}
	})



	/*加载商品**/
	$.ajax({
		type:"get",
		url:"data/order/list.php",
		success:function(data){
			//console.log(data);
			var html="";
			var i=1;
			for(var p of data){
				var sum=(p.price*p.count).toFixed(2);	
				html+=`
					<tr>
						<td>${i}</td>
						<td class="goods">
						<img src="${p.md}"/>
						<a href="#">${p.title}</a>
						<ul>
							<li>版本: <span>${p.RAM}</span></li>
							<li>内存: <span>${p.ROM}</span></li>
							<li>颜色: <span>${p.color}</span></li>
						</ul>
						</td>
						<td  class="price">${p.price}</td>
						<td class="count">
							${p.count}
						</td>
						<td class="discount">
							<span>无优惠</span>
						</td>
						<td class="subtotal">${sum}</td>
					</tr>
				`;
				i++;
			}
			$("#tbody").html(html);
			//总价格
			//console.log($("#tbody>tr"));
			var sumprice=0;
			$("#tbody>tr").each(function(){
					var a=$(this).children(".subtotal").html();
					sumprice+=parseInt(a);
			});
			//优惠
			sumprice-=parseInt($("#you").html());
			//邮费
			/*加载价格*/
			function changePrice(){
				var $option=$("#poster").find("option:selected").text();
				var subpost=$option.split(":")[1];
				var postprice=parseInt(subpost);
				$("#postprice").html(postprice.toFixed(2));
				psumprice=(parseInt(sumprice)+parseInt(subpost)).toFixed(2);
				$("#allprice").html(psumprice);
				/*生成订单**/
				$("#sure>li:first>span.sure_price").html($("#allprice").html());
			}
			changePrice();//加载价格
			//change事件
			$("#poster").change(function(){
				changePrice();
			});

			

			
		/************************************/
			//去支付
		$("#sum-bottom>button").click(function(){
			var address_id=$("#address>ul").find("input[type='radio']:checked").attr("data-address_id");
			console.log('地址'+address_id);
			var post=parseInt($("#postprice").html());
			console.log("邮费"+post);
			var discount=parseInt($("#you").html());
			console.log("优惠"+discount);
			$.ajax({
					type:"post",
					url:"data/order/order.php",
					data:{post:post,
						  discount:discount,
						  address_id:address_id	},
					success:function(data){
						console.log(data);
						var order_id=data.order_id;
						var payPrice=data.totalPrice;
						$("#pay").css("display","block");
						$("#all").css("display","none");
						$("#order_id").html(order_id);
						$("#payPrice").html(payPrice);

						/*付款*/
						$("#pay-bottom>a").click(function(){

							var wd=$("#payWd").val();
							if(wd==""){
								$("#nowd").html("请输入支付密码");
								$("#nowd").css("color","red");
							}else{
								$.ajax({
									type:"post",
									url:"data/order/pay.php",
									data:{  order_id:order_id,
											payPrice:payPrice
										},
									success:function(data){
										console.log(data);
									}
								
								});
								$("#success").css("display","block");
								$("#all").css("display","none");
								$("#pay").css("display","none");
								backIndex();
							}
						});
						
					}
			});
			
		});



		/**************************************/

		},
		error:function(){
			alert("网路错误");	
		}
	})

	
	

						
	




	/*返回购物车修改购买set is_checked=false*/
	$("#sum-bottom>a").click(function(){
		$.ajax({
				type:"post",
				url:"data/order/clear.php"
		});
	});


	$("#pay-bottom>a").click(function(){
		var wd=$("#payWd").val();
		if(wd==""){
			$("#nowd").html("请输入支付密码");
			$("#nowd").css("color","red");
		}else{
			$("#success").css("display","block");
			$("#all").css("display","none");
			$("#pay").css("display","none");
			backIndex();
		}
	});
	
	/*5秒后返回首页*/
	function backIndex(){
		var number=5;
		var timer=setInterval(function(){
				number--;
				$("#second").html(number);
				if(number == 0){
					//结束定时器
					clearInterval(timer);
					timer = null;
					//跳转到首页 Router
				   location.href = "index.html";
				}
		 },1000);
		  
	 }




}