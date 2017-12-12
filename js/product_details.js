(()=>{ 

var lid=location.search.split("=")[1];
if(lid!==undefined)
ajax(
  "get",
  "data/product-details/details.php?lid="+lid,
  ""
).then(data=>{
  var phone=data.phone,
      family=data.family;
  /*加载详情下面部分*/
  /*右侧*/
  var details="";
  details=`
		<li>
			<a href="#">商品名称：<span>${phone.name}</span></a>
		</li>
		<li>
			<a href="#">品牌：<span>${phone.productor}</span></a>
		</li>
		<li>
			<a href="#">网络：<span>全网通4G</span></a>
		</li>
		<li>
			<a href="#">屏幕尺寸：<span>${phone.size}</span></a>
		</li>
		<li>
			<a href="#">颜色： <span>${phone.color}</span></a>
		</li>
		<li>
			<a href="#">商品产地：<span>中国大陆</span></a>
		</li>
		<li>
			<a href="#">系统：<span>${phone.system}</span></a>
		</li>
		<li>
			<a href="#">前置摄像头像素：<span>800万-1599万</span></a>
		</li>
		<li>
			<a href="#">热点：<span>骁龙芯片，双卡双待</span></a>
		</li>
		<li>
			<a href="#">后置摄像头像素：<span>1200万-1999万</span></a>
		</li>
		<li>
			<a href="#">电池容量：<span>3000mAh-3999mAh</span></a>
		</li>
		<li>
			<a href="#">机身内存：<span>${phone.ROM}</span></a>
		</li>
  `;
  $("#param>ul").html(details);
  var a=`${phone.details[0].phonePic}`;
  //console.log(a);
  $("#introduce>div").html(a);
  //左侧
  //console.log($("#sellmsg>.store>a>span"));
  $("#sellmsg>.store>a>span").html(`${phone.productor}`);
  $("#sellmsg>.store_pic").html(`${phone.details[0].brandPic}`);


 /*加载面包屑*/
 $("#bread-crumb>li:nth-child(3)>a").html(`${phone.productor}`);
 $("#bread-crumb>li:nth-child(4)>a").html(`${phone.name}`);
 /*加载左上角图片:*/
 var mImg=document.getElementById("mImg"),
      largeDiv=document.getElementById("largeDiv"),
      icon_list=document.getElementById("icon_list");
 //设置mImg的src为当前商品的第一张图片的中图片
 mImg.src=phone.pics[0].md;
 //设置largeDiv的backgroundImage为url(第一张图片的大图片)
 largeDiv.style.backgroundImage=`url("${phone.pics[0].lg}")`;
 var html="";//定义空字符串html
 //遍历当前商品的每张图片
  for(var pic of phone.pics){
    //向html中拼接
    html+=`<li class="i1"><img src="${pic.sm}" data-md="${pic.md}" data-lg="${pic.lg}"></li>`;
  }//(遍历结束)
  //设置icon_list的内容为html
  icon_list.innerHTML=html;



 /*加载右上角商品基本信息*/
 var $title=$("#show-details>div.title>h1"),
    $subtitle=$("#show-details>div.title>h3"),
    $price=$("#show-details>div.price>div.now-price>span"),
    $promotion=$("#show-details>div.price>div.promotion>span.coupon");
    $RAM=$("#show-details>div.RAM>div"),
    $ROM=$("#show-details>div.ROM>div"),
    $color=$("#show-details>div.color>div");
 //加载信息
	$title.html(phone.title);
    $subtitle.html(phone.subtitle);
	$price.html("¥"+phone.price);
	$promotion.html(phone.promotion);
//给购物车/立即购买添加lid的属性
	var $buy=$(".shops>.buy");
	var $cart=$(".shops>.cart");
	//console.log($buy);
	$buy.attr("data-lid",`${phone.lid}`);
	$cart.attr("data-lid",`${phone.lid}`);




	//延保服务
	var $as=$("#show-details>div.protection>a");
	//console.log($as);
	$as.click(e=>{
		 var $tar=$(e.target);
		 if($tar.hasClass("select")){
			 $tar.removeClass("select");
		 }else{
			 $tar.addClass("select");
		 }
	});
	//数量
	var $account=$(".account");
	var $reduce=$(".number-reduce");
	var $add=$(".number-add");
	var $input=$(".account>input");
	var a=parseInt($input.val());
	$add.click(function(){
		a= a + 1;
		$input.val(a);
	});
	$reduce.click(function(){
		if(a>0){
			a=a-1;
			$input.val(a);
		};
	});
//添加RAM
var html="";
 //遍历当前系列下的商品列表
 for(var l of family.RAM){
     if(l.RAM!=phone.RAM){
      html+=`<a>${l.RAM}</a>`;
    }else
      html+=`<a class="select">${l.RAM}</a>`
	RAM.innerHTML=html;
  }
 $RAM.html(html);
 //$RAM.children().first().addClass("select");

//添加ROM
var html="";
 //遍历当前系列下的商品列表
 for(var l of family.ROM){
     if(l.ROM!=phone.ROM){
      html+=`<a>${l.ROM}</a>`;
    }else
      html+=`<a class="select">${l.ROM}</a>`
  }
 $ROM.html(html);
 //$ROM.children().first().addClass("select");


//添加颜色及其图片
var html="";
 //遍历当前系列下的商品列表
 for(var l of family.color){
     if(l.color!=phone.color){
      html+=`<a>${l.color}</a>`;
    }else
      html+=`<a class="select">${l.color}</a>`
  }
  $color.html(html);
  //$color.children().first().addClass("select");



$btn=$("#color>a,#RAM>a,#ROM>a");
$btn.on("click",function(e){
	//if($btn.find(".select") ){
		 //$btn.first().addClass("select");
	//}
	var $tar=$(this);
	if(!$tar.is(".select")){
		$tar.addClass("select").siblings().removeClass("select");
	}
	var titlevalue=$title.html().substr(0,5);
	console.log(titlevalue);

	var RAMvalue=$RAM.find(".select").html();
	var ROMvalue=$ROM.find(".select").html();
	var colorvalue=$color.find(".select").html();
	console.log(RAMvalue,ROMvalue,colorvalue);
	$.post(
		"data/product-details/find.php",
		{
			title:titlevalue,
			RAM:RAMvalue,
			ROM:ROMvalue,
			color:colorvalue
		}).then(data=>{
		  //console.log(data);
	    	location.href=`product-details.html?lib=${data.lid}`;

		})
})



/***********放大镜********************************************************/
//查找id为smallDiv下的class为forward的a保存到aForward
  var aForward=document.querySelector("#smallDiv>.forward");
  //查找id为smallDiv下的class为backward的a保存到aBackward
  var aBackward=document.querySelector("#smallDiv>.backward");


  var moved=0,LIWIDTH=85;//定义变量
    //为aForward绑定单击事件
  aForward.onclick=function(){
    if(this.className.indexOf("disabled")==-1){
      moved++; move();
    }
  };
  aBackward.onclick=function(){
    if(this.className.indexOf("disabled")==-1){
      moved--; move();
    }
  };
  function move(){
    //修改icon_list的left为-moved*LIWIDTH+25
    icon_list.style.left=-moved*LIWIDTH+25+"px";
    checkA();
  }
  function checkA(){//根据moved，控制a的启用禁用
    //如果当前商品的图片列表的图片张数-moved==5
    if(phone.pics.length-moved==5){
      //设置aForward的class为forward和disabled
      aForward.className="forward disabled";
	  aBackward.className="backward";
    }else if(moved==0){//否则 如果moved==0
      //设置aBackward的class为backward和disabled
      aBackward.className="backward disabled";
	  aForward.className="forward";
    }
  }
  //如果当前商品的图片张数<=5
  if(phone.pics.length<=5)
    //设置aForward的class为"forward disabled"
    aForward.className="forward disabled";
 
 /*****鼠标进入小图片切换中图片和大图片*****/
 //为父元素icon_list绑定鼠标进入事件
  icon_list.onmouseover=function(e){
    var tar=e.target;//获得目标元素tar
    //如果目标元素是img时
    if(tar.nodeName=="IMG"){
      //设置mImg的src为tar的dataset中的md属性
      mImg.src=tar.dataset.md;
      //设置largeDiv的backgroundImage为url(tar的dataset中的lg)
      largeDiv.style.backgroundImage=`url("${tar.dataset.lg}")`;
	  largeDiv.style.backgroundImage
    }
  }
  /*****鼠标进入中图片启动放大镜*****/
  //查找id为superMask的div保存在superMask
  var superMask=
    document.getElementById("superMask");
  //查找id为mask的div保存在mask
  var mask=document.getElementById("mask");
  //为superMask绑定鼠标进入事件
  superMask.onmouseover=function(){
    mask.style.display="block";//让mask显示
    largeDiv.style.display="block"//让largeDiv显示
  }
  //为superMask绑定鼠标移出事件
  superMask.onmouseout=function(){
    mask.style.display="none";//让mask隐藏
    //让largeDiv隐藏
    largeDiv.style.display="none";
  }

 //放大镜效果
  //定义变量MSIZE=225保存mask的宽高
  var MSIZE=225;
  var SMSIZE=450;//保存superMask的大小
  //为superMask绑定鼠标移动事件
  superMask.onmousemove=function(e){
    //获得相对于当前元素的x,y
    var x=e.offsetX,y=e.offsetY;
    //计算top和left
    var top=y-MSIZE/2;
    var left=x-MSIZE/2;

    //如果top<0 就改回0
    if(top<0) top=0;
    //否则如果top>SMSIZE-MSIZE 就改回SMSIZE-MSIZE
    else if(top>SMSIZE-MSIZE)
      top=SMSIZE-MSIZE;

    //如果left<0 就改回0
    if(left<0) left=0;
    //否则如果left>SMSIZE-MSIZE 就改回SMSIZE-MSIZE
    else if(left>SMSIZE-MSIZE)
      left=SMSIZE-MSIZE;
    //设置mask的top为top,left为left
    mask.style.top=top+"px";
    mask.style.left=left+"px";
    largeDiv.style.backgroundPosition=-left*3/2+"px "+-top*3/2+"px";
  }
  });


//为你推荐
  var recommend_product=document.getElementById("recommend_product")
  ajax("get","data/product-details/recommend.php","")
	    .then(output=>{
		 //根据规定的模板,动态生成秒杀商品的HTML代码片段
		var html="";
		for(var i=0;i<output.length;i++){
			var p=output[i];
			 html+=`
				<li>
					<a href="${p.href}">
						<img src="${p.pic}">
						<p>${p.title}</p>
					</a>
                 </li>
			 `;
			recommend_product.innerHTML=html;
		}
		//给ul复制所有li一份
	    html=recommend_product.innerHTML=html;
		html+= html;
		recommend_product.innerHTML=html;
	});
	
	window.onload = function () {
		var scroll = document.getElementById("scroll");
		//获得ul
        var ul=scroll.getElementsByTagName("ul")[0];
		//获得所有li
		var lis=ul.getElementsByTagName("li");
		//给ul复制所有li一份

		//ul的宽度=第一个li的宽度*li的个数
		ul.style.width=lis[0].offsetWidth*14+"px";
		//console.log(ul.style.width);
		//ul的定位  ul/2等于一份宽度即最初的宽度
		ul.style.left=-ul.offsetWidth/2;
		//前进为-1  后退为1
		var speed=-1;
		//控制滚动
		function move(){
			//判断 如果ul的左侧宽度小于等于左移宽度
			if(ul.offsetLeft<=-ul.offsetWidth/2){
				ul.style.left = "0";
			}
			//如果ul的左侧宽度大于0
			if(ul.offsetLeft>0){
				ul.style.left = -ul.offsetWidth/2;
			}
			ul.style.left = ul.offsetLeft + speed +"px";
		}
		//设置定时器
		var timer = setInterval(move,30);
		//鼠标操作 暂停/滚动
		ul.onmouseover = function(){
			clearInterval(timer);
		}
		ul.onmouseout = function(){
			timer = setInterval(move,30);
		}
	}
	/**************************************************/
	/*****弹框********/
	function jumpMsg(msg,code){
		var code=parseInt(code);
		$("#jumpbox").css("display","block");
		$("#msg").html(msg);
		$("#yes").click(function(){
			$(this).parent().parent().css("display","none");
			if($(this).parent().parent().css("display")=="none"&& code==1){
				location.href = "cart.html";
			}
		});
		$("#no").click(function(){
			$(this).parent().parent().css("display","none");
		});
	
	};
	/*********立即购买************/
	var $buy=$(".shops>.buy");
	$buy.click(function(e){
		e.preventDefault();
		 if($("#listLogin").is(":visible")){
			alert("请先登录!");
		  }else{
			var lid=$(this).data("lid");
			console.log(lid);
			var count=$(".account>input").val();
			$.post(
				"data/product-details/gobuy.php",
				{lid,count}
			).then(
				//loadCart
				function(data){
					if(data.code>0){
						location.href = "order.html";
					}else{
						alert("网络出错");
					}

				}
			)
		  }
	})

	/*****加入购物车**************/
	var $cart=$(".shops>.cart");
	$cart.click(function(e){
		e.preventDefault();
		 if($("#listLogin").is(":visible")){
			alert("请先登录!");
		  }else{
			var lid=$(this).data("lid");
			console.log(lid);
			var count=$(".account>input").val();
			$.post(
				"data/cart/add.php",
				{lid,count}
			).then(
				//loadCart
				function(data){
					//alert(data.msg);
				jumpMsg(data.msg,data.code);
					
				//location.href = "cart.html";
				}
			)
		  }
	})
	//下边的购物车
	$("#nextAddCart").click(function(e){
		e.preventDefault();
		if($("#listLogin").is(":visible")){
			alert("请先登录!");
		  }else{
			var lid=$(".shops>.cart").data("lid");
			var count=$(".account>input").val();
			$.post(
				"data/cart/add.php",
				{lid,count}
			).then(
				function(data){
				jumpMsg(data.msg,data.code);
				}
			)
		  }

	})
	console.log($("#details>div.tab"));
	//距离顶部高度
	var Hight=$("#details>div.tab").offset().top;
	//console.log(Hight);
	var Width=$("#details>div.tab").offset().left;
	 //为当前窗口添加滚动事件监听
	//console.log($(document).scrollTop()); //滚动条高度
   $(window).scroll(function(){
		var $box=$("#details>div.tab");
		var scrollTop=$(document).scrollTop();
		//当滚动高度为720时
		 if(scrollTop>=1165){
        //设置class为main和fixed_nav
		 $box.addClass("clear fixed_nav");
		 $box.offset({left:Width});
		 } else//否则fixed_nav
        //设置class为
		 $box.removeClass("fixed_nav");
	});


	/**********************/
    /*返回顶部*********/
	//判断是否显示
	$(window).on("scroll",function(){
		//var top=$("#goTop").offset().top;
		//滚动条
		var TOP=1500;
		var scrollTop=$(document).scrollTop();
		if( scrollTop>=TOP){
	        //显示
			$("#goTop").css({"display":"block"});
		}else{
			//隐藏
			$("#goTop").css({"display": "none"});
		}
	
	})

	$("#goTop").on("click",function(){
		//alert(55555);
		var totalTop=0;
		$("html,body").stop(true).animate({
		  scrollTop:totalTop
		},1500);
	})

	
	/******************/

	/*****详情下面的显示*********/
	$("#d1").on("click",function(){
		$(this).addClass("active").siblings().removeClass("active");;
		$(this).children().addClass("active1").parent().children().removeClass("active1");
		$("#param").css("display","block");
		$("#introduce").css("display","block");
		$("#package").css("display","none");
		$("#protect").css("display","block");
		$(document).scrollTop(1150);
	});
	$("#d2").on("click",function(){
		$(this).addClass("active").siblings().removeClass("active");;
		$(this).children().addClass("active1").parent().children().removeClass("active1");
		$("#param").css("display","none");
		$("#introduce").css("display","none");
		$("#package").css("display","block");
		$("#protect").css("display","block");
		$(document).scrollTop(1150);
	})
	$("#d3").on("click",function(){
		$(this).addClass("active").siblings().removeClass("active");;
		$(this).children().addClass("active1").parent().children().removeClass("active1");
		$("#param").css("display","none");
		$("#introduce").css("display","none");
		$("#package").css("display","none");
		$("#protect").css("display","block");
		$(document).scrollTop(1150);
	})
		$("#d4").on("click",function(){
		$(this).addClass("active").siblings().removeClass("active");;
		$(this).children().addClass("active1").parent().children().removeClass("active1");
		$("#param").css("display","none");
		$("#introduce").css("display","none");
		$("#package").css("display","none");
		$("#protect").css("display","none");
		$(document).scrollTop(1150);
	})
	/***************************/

})()/*自调*/
