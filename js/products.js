 $("#select").load("sliding(1).html");

function pageLoad(pno=1){
	//读取url中的关键词?kw=xxxxxxxx
	var kw=location.search.split("=")[1]||"";
	$.ajax({
		type:"GET",
		url:"data/products/products.php?kw="+kw+"&pno="+pno,
		success:function(pager){
			var data=pager.data;
			//console.log(data);
			var $product=$("#product");
			var html="";
			if(data.length>0){
				for(var p of data){
					html+=`
						<li>
							<a href="product-details.html?lid=${p.lid}" class="pic">
								<img src="${p.md}"/>
								<p  id="similar">
									<span>找相似</span><span>找同款</span>
								</p>
							</a>
							<P class="price">¥${p.price}</P>
							<a href="product-details.html?lid=${p.lid}" class="title">${p.title}</a>
							<div class="assess"><img src="img/product/message.png" />已有<span>17761</span>人评价</div>
							<div class="self"">
								<img src="img/product/self.png"/>
								<img src="img/product/hot.png"/>
							</div>
						</li>
					`;
				};
			}else{
				html=`
					<div class="nosearch">
						<img src="img/product/nosearch.png" >
						<h1>商品未上架！</h1>
					</div>
				`;
			}
			$product.html(html);
			
			/**加载page**/
			var pageCount=parseInt(pager.pageCount);/*总页数*/
			var pageNo=parseInt(pager.pageNo);
			var $page=$("#page");
			//加载页面
			var html="";
			
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
					pageLoad(nowpage);
				}
			})
			//上一页 下一页
			$("#page a:first").on("click",function(e){
				e.preventDefault();
				if(!$(this).hasClass("disabled")){
					var aselect=$page.children(".selected");
					var nowpage=aselect.text();
					pageLoad(parseInt(nowpage)-1);
				}
			
			})
			//下一页
			$("#page a:last").on("click",function(e){
				e.preventDefault();
				if(!$(this).hasClass("disabled")){
					var aselect=$page.children(".selected");
					var nowpage=aselect.text();
					nowpage=parseInt(nowpage)+1;
					pageLoad(nowpage);
				}
			
			})
			/***/
		},
		error:function(){
			alert("网络错误,请检查");
		}
	
	})

	/**/
}
pageLoad();




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

})



//3box顶 左 点击变换颜色
var $ul=$("div.filter-top>ul.filter-left");
//console.log($ul.children("li"));
$ul.children("li").on("click",function(e){
	 e.preventDefault();
	  $(this).addClass("on").siblings().removeClass("on");
	  $(this).children("a").addClass("on");
	  $(this).siblings().children("a").removeClass("on");
})


//3.1box 搜索
var $gt_ul=$("div.filter-top>ul.filter-right");
var $gt_search=$gt_ul.children().last().children();
var $gt_input=$gt_ul.children().first().children();;
//console.log($gt_search);
$gt_search.on("click",function(e){
	 e.preventDefault();
	 var skw=$gt_input.val();
	 //console.log(skw);
	 var href="products.html?kw="+skw;
	 //console.log(href);
	 //$gt_search.attr("href","href");
	 location.href=href;

})


    //为当前窗口添加滚动事件监听
	console.log($(document).scrollTop()); //滚动条高度
	//距离顶部高度
	var Hight=$("#filter-box").offset().top;
	console.log(Hight);
	var Width=$("#filter-box").offset().left;
	console.log(Width);
	$(window).scroll(function(){
		var $box=$("#filter-box");
		var scrollTop=$(document).scrollTop();
		console.log($(document).scrollTop());
		//当滚动高度为720时
		 if(scrollTop>=550){
        //设置class为main和fixed_nav
		  $box.addClass("clear fixed_nav");
		  $("#filter-box").offset({left:232+162});
		 } else//否则fixed_nav
        //设置class为
		 $box.removeClass("fixed_nav");
	});


