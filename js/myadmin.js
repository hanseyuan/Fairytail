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
	/*****************/
	/*********drapdown********************/
	$(".dropdown").on("mouseover",function(){
        $(this).children().last().addClass("in");
    });
	$(".dropdown").on("mouseout",function(){
        $(this).children().last().removeClass("in");
    });

	/*****弹框********/
	function jumpMsg(msg,code){
		var code=parseInt(code);
		$("#jumpbox").css("display","block");
		$("#msg").html(msg);
		$("#yes").click(function(){
			//console.log($(this).parent().parent());
			$(this).parent().parent().css("display","none");
			//console.log($(this).parent().parent().css("display"));
			if($(this).parent().parent().css("display")=="none"&& code>0){
				window.location.reload();
			}
		});
	
	};



    /*左加载右*/
    $(".affix>ul").on("click","[data-toggle=item]",function(e){
        e.preventDefault();
        var $tar=$(this);
        var $ul=$tar.parent().parent();
        if(!$ul.is(".active")){
            //$ul.addClass("active")
            //    .siblings().removeClass("active");
            var id=$tar.attr("href");
            $(id).addClass("active")
                .siblings().removeClass("active");
        }
    })

    /*手风琴*/
    $("[data-trigger=accordion]").on("click",".title", function (e) {
        var h=$(e.target).parent().next().children().height();
        $(e.target).parent().next().addClass("in").parent().siblings().children(".fade").removeClass("in");
        if( $(e.target).parent().next().hasClass("in")){
            $(e.target).parent().next().css("min-height",h)
                .parent().siblings().children(".fade").css("min-height",0);
        }
    })

    /*主体部分*/
    $(".tabs").on("click","[data-toggle=tab]",function(e){
        e.preventDefault();
        var $tar=$(e.target);
        //console.log($tar);
        if(!$tar.parent().is(".active")){
            $tar.parent().addClass("active")
                .siblings().removeClass("active");
            var id=$tar.attr("href");
            $(id).addClass("active")
                .siblings().removeClass("active");
        }
    })

  /*加载个人中心*********************************************************/
	$.ajax({
			type:"get",
			url:"data/myadmin/myself.php",
            success:function(data){
				var data=data;
				var html="";
				html=`
					<div>
						<label for="avatar">用户头像:</label>
						<img id="avatar" src="${data.avatar}" alt=""/>
					</div>
					<div>
						<label for="txtName">用户名:</label>
						<span id="txtName">${data.uname}</span>
						<!--<input type="text" name="uname" id="txtName">-->
						<span id="msgName"></span>
					</div>
					<div id="gender">
						<label >性别:</label>
						<input class="man" type="radio" name="gender"  value="0"><b>男</b>
						<input class="woman" type="radio" name="gender" value="1"><b>女</b>
						<span id="msgGander"></span>
					</div>
					<div>
						<label for="phone">手机号码:</label>
						<!--<span id="phone">${data.phone}</span>-->
						<input type="text" name="phone" id="phone" value="${data.phone}">
						<span id="msgPhone"></span>
					</div>
					<div>
						<label for="email">邮箱:</label>
						<span></span>
						<input type="text" name="email" id="email" value="${data.email}">
						<span id="msgEmail"></span>
					</div>
					<div>
						<button id="btn-update" data-uid="${data.uid}">保存修改</button>
					</div>
				
				`;
				$("#form1").html(html);
				//console.log(data.gender);
				if(data.gender==($("#gender>:radio").eq(1).val())){
					$("#gender>input.woman").attr("checked",true);
				}else{
					$("#gender>input.man").attr("checked",true);
				};


				/*更新用户信息*/
				//邮箱正则
				var ereg= /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/i;

				/*js验证*/
				function getUpwdFocus(){
					var p= $("[name='email']").val();
					console.log(p);
					var m=$("#msgEmail");
					console.log(m);
					if(p==""){
						m.html("邮箱不能为空");
						m.css({"color":"red"});
					}else if(!ereg.test(p)){
						m.html("格式不正确");
						m.css({"color":"red"});
					}else{
						m.html("ok");
						m.css({"color":"green"});
					}
				}
				$("[name='email']").focusout (
					getUpwdFocus
				);
				
				/*电话号码*/
				var phonereg=/^((\+86|0086)\s+)?1[34578]\d{9}$/i;
				$("[name='phone']").focusout(
					function(){
						var value= $(this).val();
						var span=$("#msgPhone");
						getFocus(value,phonereg,span,"手机号码不能为空","手机号码格式错误");
					}
				);


				//提交修改
				$("#btn-update").click(function(e){
					e.preventDefault();
					//alert(11111);
					var gender=$("input[type='radio']:checked").val();
					var phone=$("[name='phone']").val();
					var email=$("[name='email']").val();
					var msgEmail=$("#msgEmail");
					var msgPhone=$("#msgPhone");
					$.ajax({
						type:"post",
						url:"data/myadmin/update-myself.php",
						data:{gender:gender,phone:phone,email:email},
						success:function(data){
						    if(data.code==-3){
								msgPhone.html(data.msg);
								msgPhone.css({"color":"red"});
						    }else if(data.code==-2){
								msgEmail.html(data.msg);
								msgEmail.css({"color":"red"});
						    }else if(data.code==-1){
								jumpMsg(data.msg,data.code);
						    }else if(data.code==1){
								jumpMsg(data.msg,data.code);
							}
						},
						error:function(){
							jumpMsg("网络错误",1);
						}

					});

			  })/********************用户信息*/


               
            },
			error:function(){
				alert("网络错误");
			}

        });
 /**********************************************************/

/******	密码管理*****************************************/

    /**
     * 格式验证
     * @param value  输入值
     * @param reg  正则表达式
     * @param m    错误提示span
     * @param msg1 错误信息1
     * @param msg2 错误信息2
     */
    function getFocus(value,reg,m,msg1,msg2){
        if(value==""){
            m.html(msg1);
            m.css({"color":"red"});
        }else if(!reg.test(value)){
            m.html(msg2);
            m.css({"color":"red"});
        }else{
            m.html("ok!");
            m.css({"color":"green"});
        }
    }
	

    /*旧密码**/
    /*密码正则*/
    var preg = /^[A-Za-z0-9_-]{6,18}$/i;

    $("[name='upwd']").focusout(
        function(){
            var value= $(this).val();
            var span=$("#msgUpwd");
            getFocus(value,preg,span,"密码不能为空","密码格式错误");
        }

    );
    //新密码
    $("[name='nupwd']").focusout(
        function(){
            var value= $(this).val();
            var span=$("#msgNupwd");
            getFocus(value,preg,span,"密码不能为空","新密码格式错误");
        }

    );
    //确认密码
    $("[name='tupwd']").focusout(
        function(){
            var value= $(this).val();
            var span=$("#msgTupwd");
            var a= $("[name='nupwd']").val();
			console.log(value);
			console.log(a);
			console.log(value==a);
            if(value==""){
                span.html("确认密码不能为空");
                span.css({"color":"red"});
            //}else if(!value==a){
                //span.html("两次密码不一致");
                //span.css({"color":"red"});
            }else if(value==a){
                span.html("ok!");
                span.css({"color":"green"});
            }else{
                span.html("两次密码不一致");
                span.css({"color":"red"});
			}
        }
    );


    /*修改密码*/
	//console.log($("#update-upwd"));    
    $("#update-upwd").click(function(e){
        e.preventDefault();
        var upwd=$("[name='upwd']").val();
        var nupwd=$("[name='nupwd']").val();
        var tupwd=$("[name='tupwd']").val();
		var msgUpwd=$("#msgUpwd");
		var msgNupwd=$("#msgNupwd");
		var msgTupwd=$("#msgTupwd");
        $.ajax({
			type:"post",
			url:"data/myadmin/update-upwd.php",
            data:{upwd:upwd,nupwd:nupwd,tupwd:tupwd},
            success:function(data){
               if(data.code==-2){
					msgUpwd.html(data.msg);
					msgUpwd.css({"color":"red"});
				}else if(data.code==-3){
					msgNupwd.html(data.msg);
					msgNupwd.css({"color":"red"});	
				}else if(data.code==-4){
					msgTupwd.html(data.msg);
					msgTupwd.css({"color":"red"});
				}else if(data.code==-1){
					jumpMsg(data.msg,data.code);
				}else if(data.code==1){
					jumpMsg(data.msg,data.code);
				}
            },
			error:function(){
				alert("网络错误2");
			}

        });


    })
/**********************************************/
/**头像上传*****************/

/*预览*/
	 $("#file").change(function(){
        var objUrl = getObjectURL(this.files[0]) ;
        console.log("objUrl = "+objUrl) ;
        if (objUrl){
            $("#img0").attr("src", objUrl);
            $("#img0").removeClass("hide");
        }
    }) ;
    //建立一個可存取到該file的url
    function getObjectURL(file) {
        var url = null ;
        if (window.createObjectURL!=undefined){ // basic
            url = window.createObjectURL(file) ;
        }else if (window.URL!=undefined){
            // mozilla(firefox)
            url = window.URL.createObjectURL(file) ;
        }else if (window.webkitURL!=undefined) {
            // webkit or chrome
            url = window.webkitURL.createObjectURL(file) ;
        }
        return url ;
    }
/*上传*/
$("#uploads").click(function(e){
	  e.preventDefault();
	  $.ajax({
			type:"post",
			url:"data/myadmin/upload_avatar.php",
			data:new FormData($("#form3")[0]),  //从jquery对象取出dom元素
			contentType:false,                  //禁止类型转换
			processData:false,					//不允许ajax进行任何修改
			success:function(data){
				 if(data.code==-1){
					jumpMsg(data.msg,data.code);
				}else if(data.code==1){
					jumpMsg(data.msg,data.code);
				}
			},
			error:function(){
				alert("网络错误1");
			}
	  });
})



/*****************************/
/**地址管理*/
$.ajax({
		type:"get",
		url:"data/order/address.php",
		success:function(data){
			//console.log(data);
			var html="";
			var i=1;
			for(var p of data){
				html+=`
					<tr>
						<td>${i}</td>
						<td>${p.receiver}</td>
						<td>${p.province}</td>
						<td>${p.city}</td>
						<td>${p.county}</td>
						<td><span>${p.address}</span></td>
						<td>${p.postcode}</td>
						<td>${p.cellphone}</td>
						<td data-check='${p.is_default}'>是</td>
						<td>
							<a href="#" id="updateAddress" data-aid=${p.aid}>更新</a>
							<a href="#" id="deleteAddress"  data-aid=${p.aid}>删除</a>
						</td>
					</tr>
					
				`;
				i++;
			}
			$("#tbody1").html(html);
			$('[data-check=1]').html("是");
			$('[data-check=0]').html("否");
			
			/**删除地址*/
			$("#tbody1").on("click","#deleteAddress",function(e){
				e.preventDefault(); 
				var aid=$(this).data().aid;
				console.log(aid);
				$.post("data/myadmin/deleteAddress.php", 
						{ aid: aid } 
				).then(data=>{
					jumpMsg(data.msg,data.code);
				})

			});
			/*修改地址*/
			$("#tbody1").on("click","#updateAddress",function(e){
				e.preventDefault(); 
				$("#jumpbox1").css("display","block");
				$.cxSelect.defaults.url = 'js/cityData.min.json';
				$('#china1').cxSelect({
						selects: ['province', 'city', 'area'],
						nodata: 'none'
				});
				var aid=$(this).data().aid;
				//console.log(aid);
				$.get("data/myadmin/findAddress.php", 
						{ aid: aid } 
				).then(data=>{
				    var p=data[0];
					$("#china1 select.province.cxselect").find(":selected").text(p.province);
					$("#china1 select.city.cxselect").find(":selected").text(p.city);
					$("#china1 select.area.cxselect").find(":selected").text(p.county);
					$("#jump1>ul>li>textarea").val(p.address);
					$("#postcode1").val(p.postcode);
					$("#cellphone1").val(p.cellphone);
					$("#receiver1").val(p.receiver);
					if(p.is_default){
						$("#jump1>ul>li.default>label>input").prop("checked",true);
					}
					/*更新地址*/
					$("#yes1").click(function(){
						var province=$("#china1 select.province.cxselect").find(":selected").text();
						var city=$("#china1 select.city.cxselect").find(":selected").text();
						var county=$("#china1 select.area.cxselect").find(":selected").text();
						var address=$("#jump1>ul>li>textarea").val();
						var postcode=$("#postcode1").val();
						var cellphone=$("#cellphone1").val();
						var receiver=$("#receiver1").val();
						var is_default=$("#jump1>ul>li.default>label>input").prop("checked");
						console.log(province, city);
						$.ajax({
							type:"post",
							url:"data/myadmin/updateAddress.php",
							data:{
								province:province,
								city:city,
								county:county,
								address:address,
								postcode:postcode,
								cellphone:cellphone,
								receiver:receiver,
								is_default,is_default,
								aid:aid
							},
							success:function(data){
								//console.log(data.msg);
								jumpMsg(data.msg,data.code);
							},
							error:function(){
								alert("网络错误");
							}
						})
						$(this).parent().parent().parent().css("display","none");
						
					})/*更新*/
					$("#no1").click(function(){
						$(this).parent().parent().parent().css("display","none");
					});
					
				})/*获得*/

			});
		},
		error:function(){
			alert("错了,哥们");
		}
})
/***新增地址**/
	//修改地址
				$.cxSelect.defaults.url = 'js/cityData.min.json';
				$('#china').cxSelect({
						selects: ['province', 'city', 'area'],
						nodata: 'none'
				});
				
				$("#sureinput").click(function(){
					var province=$("#china select.province.cxselect").find(":selected").text();
					console.log(province);
					var city=$("#china select.city.cxselect").find(":selected").text();
					console.log(city);
					var county=$("#china select.area.cxselect").find(":selected").text();
					console.log(county);
					var address=$("#content32>div>ul>li>textarea").val();
					console.log(address);
					var postcode=$("#postcode").val();
					console.log(postcode);
					var cellphone=$("#cellphone").val();
					console.log(cellphone);
					var receiver=$("#receiver").val();
					console.log(receiver);
					var is_default=$("#content32>div>ul>li.default>label>input").prop("checked");
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
							jumpMsg(data.msg,data.code);
						},
						error:function(){
							alert("网络错误");
						}
					})
					
				});

/*************/
/******订单列表***********/

//全部订单
$("#myOrderList").on("click",function(){
	pageLoad(1,$("#tbody21"),0);
})

//未付款
$("#my-order>ul.tabs").on("click","li",function(){
     //console.log('index'+ $(this).index() );
	 var $tar=$(this).children();
	  var id=$tar.attr("href");
	 // console.log( 'id为'+id );
     var tbody= $(id).find("tbody");
     // console.log( $(id).find("tbody") );         
	var index=$(this).index() ;
	pageLoad(1,tbody,index);
})





function pageLoad(pno,element,con){
		if(con==0){
			con="";
		}
		console.log("状态",con);
		$.ajax({
			type:"get",
			url:"data/myadmin/orderList.php",
			data:{
					pno:pno,
					status:con
				},
			success:function(data){
				var output=data;
				console.log(output);
				var dataList=output.data;
				var html="";
				if(dataList.length>0){
				
						for(var p of dataList){
							html+=`
								 <tr>
									<td>
										<p>${p.order_id}</p>
										<a id="delList" data-aid="${p.aid}"><img src="img/myadmin/del.png" alt="删除订单" ></a>
									</td>
									<td class="good">
										<img src="${p.md}"/>
										<ul>
											 <li>
												<p>${p.title}</p>
											 </li>
											 <li>版本: <span>${p.RAM}</span></li>
											 <li>机身内存: <span>${p.ROM}</span></li>
											 <li>颜色: <span>${p.color}</span></li>	
										</ul>
									</td>
									<td>¥${p.price}</td>
									<td>${p.count}</td>
									<td>
										<a href="#">退货</a>	
									</td>
									<td class="totalPrice">${p.payPrice}</td>
									<td class="status" data-status="${p.status}"> </td>
									<td>
										<a href="#" data-aid="${p.aid}">确认收货</a>
									</td>
								</tr>

							
							`;
							
						}
						/*html+=`
							<tr>     
								<td colspan="8">
									<div id="page">
											446464654
									</div>		
								</td>  
							</tr>  
						`;*/
						 
     
					/************/
					element.html(html);
				
						/**********/
						//$("#tbody2").html(html);
						var status=$(".status");
						$.each(status,function(i,ele){
							var i=$(this).data("status");
							if(i==1){
								$(this).html("等待付款");
							}else if(i==2){
								$(this).html("等待发货");
							}else if(i==3){
								$(this).html("运输中");
							}else if(i==4){
								$(this).html("已签收");
							}else if(i==5){
								$(this).html("已取消");
							}
						});
						$.each($(".totalPrice"),function(i,ele){
							var j=$(this).html();
							if(j=="null"){
								$(this).html("未付款");
							}
						
						})
						
						/**加载page**/
						var pageCount=parseInt(output.pageCount);/*总页数*/
						var pageNo=parseInt(output.pageNo);
						var $page=$("#page");
						//加载页面
						var html="";
						if(pageCount>0){
							
							//[上一页]
							html+=`<a href="${pageNo>1?pageNo-1:'#'}" class="${pageNo<=1?'disabled':''}">上一页</a>`;
							//前两页
							if(pageNo-2>0)
								html+=`<a href="pageNo-2">${pageNo-2}`;
							//前一页
							if(pageNo-1>0)
								html+=`<a href="pageNo-1">${pageNo-1}`;
							//当前页
							html+=`<a href="pageNo" class="selected">${pageNo}`;
							//后一页
							if(pageNo+1<=pageCount)
								html+=`<a href="pageNo+1">${pageNo+1}`;
							//后两页
							if(pageNo+2<=pageCount)
								html+=`<a href="pageNo+2">${pageNo+2}`;
							//[下一页]
							html+=`<a href="${pageNo<pageCount?pageNo+1:'#'}" class="${pageNo>=pageCount?'disabled':''}">下一页</a>`;
							//共页数
							html+=`共有${pageCount}页`;
							$page.html(html);
							//给页码绑定事件
							$page.children().on("click",function(e){
								e.preventDefault();
								var nowpage=$(this).text();
								//console.log(nowpage);
								//筛选目标元素: 内容为数字
								if(!isNaN(nowpage)){
									pageLoad(nowpage,element,con);
								}
							})
							//上一页 下一页
							$("#page a:first").on("click",function(e){
								e.preventDefault();
								if(!$(this).hasClass("disabled")){
									var aselect=$page.children(".selected");
									var nowpage=aselect.text();
									pageLoad(parseInt(nowpage)-1,element,con);
								}
							
							})
							//下一页
							$("#page a:last").on("click",function(e){
								e.preventDefault();
								if(!$(this).hasClass("disabled")){
									var aselect=$page.children(".selected");
									var nowpage=aselect.text();
									nowpage=parseInt(nowpage)+1;
									pageLoad(nowpage,element,con);
								}
							
							})
						}else{
							$page.html(html);
						}
						/***/

						//删除订单
						element.on("click",'#delList',function(e){
							e.preventDefault;
							var aid=$(this).data("aid");
							console.log(aid);
							$.ajax({
								type:"post",
								url:"data/myadmin/delOrderList.php",
								data:{aid:aid},
								success:function(data){
									console.log(data);
									jumpMsg(data.msg,data.code);
								}
							
							})

							
						})
							
					/*************/
					}else{
					html=`
						<div class="noSearch" style="margin-top:100px;">
								<img src="img/myadmin/search.png">
								<span>未找到符合条件订单</span>
							</div>
					`;
					var nosearch=element.parent();
					//console.log(nosearch);
					nosearch.html(html);
					$("#page").html("");
				}

			},
			error:function(){
				alert("网络错误");
			}
		
		})


}





	/***************************/

}/***/