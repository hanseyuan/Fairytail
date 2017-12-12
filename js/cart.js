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

	
	/*加载列表*/	
	$.ajax({
		type:"GET",
		url:"data/cart/list.php",
		success:function(data){
			//console.log(data);
			var html="";
			for(var p of data){
				var sum=(p.price*p.count).toFixed(2);
				html+=`
					<tr>
					<td class="checkbox"><input class="check-one check" type="checkbox" data-iid="${p.iid}"/></td>
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
						<span class="reduce">-</span>
						<input type="text" value="${p.count}"/>
						<span class="add">+</span>
					</td>
					<td class="subtotal">${sum}</td>
					<td class="operation">
						<span class="delete" data-iid="${p.iid}">删除</span>
					</td>
				</tr>
				`;
			}
			$("#tbody").html(html);/***/




    var table = document.getElementById('cartTable'); // 购物车表格
    var selectInputs = document.getElementsByClassName('check'); // 所有勾选框
    var checkAllInputs = document.getElementsByClassName('check-all') // 全选框
    var tr = table.children[1].rows;    //行
    var selectedTotal = document.getElementById('selectedTotal'); //已选商品数目容器
    var priceTotal = document.getElementById('priceTotal'); //总计
    var deleteAll = document.getElementById('deleteAll'); // 删除全部按钮
    var selectedViewList = document.getElementById('selectedViewList'); //浮层已选商品列表容器
    var selected = document.getElementById('selected'); //已选商品
    var tfoot = document.getElementById('tfoot');

    //计算
   function getTotal(){
        var selected=0;
        var price=0;
        var html="";
        //循环表格,被选中,数量 和  小计 累加
        for(var i= 0;i<tr.length;i++){
          if(tr[i].getElementsByTagName("input")[0].checked){
              tr[i].className="on";
              selected += parseInt(tr[i].getElementsByTagName('input')[1].value);
              price += parseFloat(tr[i].getElementsByTagName('td')[4].innerHTML)
              // 添加图片到弹出层已选商品列表容器
              html += '<div><img src="'+tr[i].getElementsByTagName('img')[0].src+'"><span  class="del" index="'+i+'">取消选择</span></div>';
          }else{
              tr[i].className="";
          }
        }
        selectedTotal.innerHTML=selected; // 已选数目
        priceTotal.innerHTML=price.toFixed(2); // 总价
        selectedViewList.innerHTML=html;
        if(selected==0){
            tfoot.className="tfoot";
        }
    }
    //计算单行价格
    function getSubtotal(tr){
        var cells=tr.cells;
        var price=cells[2];  //单价
        var subtotal=cells[4];  //小计
        var countInput=tr.getElementsByTagName("input")[1];  //数目input
        subtotal.innerHTML=(parseInt(countInput.value)*parseFloat(price.innerHTML)).toFixed(2);
    }


    //点击选择框
    for(var i= 0 ;i < selectInputs.length;i++){
        selectInputs[i].onclick=function(){
            //如果全选
            if(this.className.indexOf("check-all") >= 0){ //如果是全选，则吧所有的选择框选中
                for(var j=0;j<selectInputs.length;j++){
                    selectInputs[j].checked = this.checked;
                }
            }
            //未选的的就取消 全选
            if(!this.checked){
                for(var k=0; k < checkAllInputs.length; k++) {
                    checkAllInputs[k].checked = false;
                }
            }
            getTotal();//选完更新总计
        }
    }

    //显示已选商品弹层
    selected.onclick=function(){
        if(selectedTotal.innerHTML!=0){
            tfoot.className=(tfoot.className=="tfoot"?"tfoot show":"tfoot");
        }
    }
    //已选商品弹层中的取消选择按钮
    selectedViewList.onclick=function(e){
        var e = e || window.event;
        var el = e.srcElement;
        if(el.className=="del"){
            var input=tr[el.getAttribute("index")].getElementsByTagName("input")[0];
            input.checked=false;
            input.onclick();
        }
    }


    //为每行元素添加事件
    for(var i=0;i<tr.length;i++){
        //将点击事件绑定到tr元素
        tr[i].onclick=function(e){
            var e=e||window.event;
            var el= e.target|| e.srcElement;//通过事件对象的target属性获取触发元素
            var cls=el.className;  //触发元素怒的class
            var countInout=this.getElementsByTagName('input')[1]; // 数目input
			//console.log(countInout);
            var value = parseInt(countInout.value); //数目
			var deletespan=this.getElementsByTagName('span')[5];
			var iid=deletespan.getAttribute("data-iid")
			//console.log(iid);
            //通过判断触发元素的class确定用户点击了哪个元素
            switch (cls) {
                case "add": //点击了加号
				var a= value + 1;
                countInout.value = a;
                getSubtotal(this);
				$.ajax({
						type:"post",
						url:"data/cart/update.php",
						data:{iid:iid,count:a},
				})

                break;
                case "reduce": //点击了减号
                if (value > 1) {
					var b= value - 1;
                    countInout.value =b;
                    getSubtotal(this);
                }
				$.ajax({
						type:"post",
						url:"data/cart/update.php",
						data:{iid:iid,count:b},
				})
                break;
                case "delete": //点击了删除
				$("#jumpbox").css("display","block");
				$("#msg").html('确定删除此商品吗？');
				$("#yes").click(function(){
					$(this).parent().parent().css("display","none");
					$.ajax({
						type:"post",
						url:"data/cart/delete.php",
						data:{iid:iid},
						success:function(data){
							if(data.code>0){
								//alert(data.msg);
								jumpMsg(data.msg,data.code);
							}else{
								//alert(data.msg);
								jumpMsg(data.msg,data.code);
							}
						},
						error:function(){alert("网络错误");}
						
					})

				})/*click*/
				$("#no").click(function(){
					$(this).parent().parent().css("display","none");
				});
                break;
            }
            getTotal();
        }

        // 给数目输入框绑定keyup事件
        tr[i].getElementsByTagName('input')[1].onkeyup = function () {
            var val = parseInt(this.value);
            if (isNaN(val) || val <= 0) {
                val = 1;
            }
            if (this.value != val) {
                this.value = val;
            }
            getSubtotal(this.parentNode.parentNode); //更新小计
            getTotal(); //更新总数
        }
    }
    //点击全部删除
    deleteAll.onclick=function(){
		function deleteAll(){
			$("#tbody>tr").each(function(){
			if($(this).is('.on')){
				//console.log($(this));
				var i=$(this).children().first().children().first().data("iid");
				//console.log($(this).children().first().children().first().data("iid"));
				console.log("iid为"+i);
				$.ajax({
						type:"post",
						url:"data/cart/delete.php",
						data:{iid:i}
						/*success:function(data){
							alert(data.msg);
						},
						error:function(){alert("网络错误");}*/
				});

			}
			});
		};
        if(selectedTotal.innerHTML!=0){
				$("#jumpbox").css("display","block");
				$("#msg").html('确认删除所选商品吗？');
				$("#yes").click(function(){
					deleteAll();
					$(this).parent().parent().css("display","none");
					if($(this).parent().parent().css("display")=="none"){
						location.href = "cart.html";
					};

				});
				$("#no").click(function(){
					$(this).parent().parent().css("display","none");
				});
         }else{
             //alert("请选择商品");
			 jumpMsg("请选择商品",0);
          }
         getTotal();//更新总数
    }

    //默认全选
    //checkAllInputs[0].checked = true;
    checkAllInputs[0].onclick();





	},/*success*/
	error:function(){
		//alert("您未登录");
		jumpMsg("您未登录",1);
		}
	})




	//立即购买
	$("#buy").click(function(){
		if(selectedTotal.innerHTML!=0){
			$("#tbody>tr").each(function(){
				if($(this).is('.on')){
					var i=$(this).children().first().children().first().data("iid");
					console.log("iid为"+i);
					$.ajax({
							type:"post",
							url:"data/order/updatelist.php",
							data:{iid:i},
					});
				}
			});
			$(this).attr("href","order.html");
		}else{
			jumpMsg("请选择商品",0);
        };
	});


	//2加载推荐
	$.ajax({
		type:"GET",
		url:"data/products/recommend.php",
		success:function(data){
			var $rp=$("#recommend-products");
			var html="";
			for( var p of data){
				html+=`
					<li>
						<a href="${p.href}">
							<img src="img/product/tuijian.png" alt="">
							<img src="${p.pic}" alt="">
						</a>
						<a href="${p.href}">
							${p.title}
						</a>
					</li>
				`;
			}
			$rp.html(html);
		},
		error:function(){
			alert("网络错误,请检查");
		}

	})/**/
	
}