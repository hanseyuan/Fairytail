function getTotalTop(elem){
  var sum=0;
  do{
    sum+=elem.offsetTop;
    elem=elem.offsetParent;
  }while(elem);
  return sum;
}


//header浮动
 //为当前窗口添加滚动事件监听
	//console.log($(document).scrollTop()); //滚动条高度
	$(window).scroll(function(){
		var $box=$("#header-top");
		var scrollTop=$(document).scrollTop();
		//当滚动高度为720时
		 if(scrollTop>=620)
        //设置class为main和fixed_nav
		 $box.addClass("clear fixed_nav");
      else//否则fixed_nav
        //设置class为
		 $box.removeClass("fixed_nav");
	});




//加载广告轮播
(()=>{
  ajax("get","data/index/banners.php","")
    .then(data=>{
    const LIWIDTH=1200;
    var htmlImgs="";//保存图片li的HTML片段
    //for(var i=0;i<data.length;i++){
      //var p=data[i];
    data.push(data[0]);
    for(var p of data){
      htmlImgs+=`<li>
              <a href="${p.href}" title="${p.title}">
                <img src="${p.img}">
              </a>
            </li> `;
    }
    var bannerImg=
      document.getElementById("banner-img");
    bannerImg.style.width=
      LIWIDTH*data.length+"px";
    bannerImg.innerHTML=htmlImgs;
    document.getElementById("indicators")
            .innerHTML=
              "<li></li>".repeat(data.length-1);///repeat()重复代码nci
    $("#indicators>li:first").addClass("hover");

    var i=0,wait=3000,timer=null;
        $banner=$(bannerImg);
    function move(){
      timer=setTimeout(()=>{
        if(i<data.length-1){
          i++;
          $banner.css("left",-LIWIDTH*i);
          if(i<data.length-1)
            $("#indicators>li:eq("+i+")")
              .addClass("hover")
              .siblings().removeClass("hover");
          else
            $("#indicators>li:eq("+0+")")
            .addClass("hover")
            .siblings().removeClass("hover");
          move();
        }else{
          $(bannerImg).css("transition","")
          $banner.css("left",0);
          setTimeout(()=>{
            $(bannerImg)
              .css(
              "transition","all .3s linear");
            i=1;
            $banner.css("left",-LIWIDTH*i);
			//小圆点
            $("#indicators>li:eq("+i+")")
            .addClass("hover")
            .siblings().removeClass("hover");
          },50);
          $("#indicators>li:eq("+i+")")
            .addClass("hover")
            .siblings().removeClass("hover");
          move();
        }
        
      },3000);
    }
    move();
	//鼠标进入轮播停止
    $("#banner").hover(
      ()=>clearTimeout(timer),
      ()=>move()
    );
	//鼠标在圆点上直达轮播
    $("#indicators")
      .on("mouseover","li",function(){
      var $this=$(this);
      if(!$this.hasClass("hover")){
        i=$this.index();
        $banner.css("left",-LIWIDTH*i);
        $("#indicators>li:eq("+i+")")
              .addClass("hover")
              .siblings().removeClass("hover");
      }
    })
	//轮播左右按键
	//左
	$("#ck-left").on("click",function(){
      $(bannerImg).css("transition","all .3s linear");
		if(i<data.length-1&&i>0){
			  i--;
			  $banner.css("left",-LIWIDTH*i);
		 }else {
			  i=3;
			  $(bannerImg).css("transition","")
              $banner.css("left",-LIWIDTH*i);
		 }
			//圆点变化
			  $("#indicators>li:eq("+i+")")
              .addClass("hover")
              .siblings().removeClass("hover");
	})
	//右
	$("#ck-right").on("click",function(){
      $(bannerImg).css("transition","all .3s linear");
      if(i<data.length-2){
              i++;
			  $banner.css("left",-LIWIDTH*i);
        }else{
          i=0;
          $(bannerImg).css("transition","")
          $banner.css("left",0);
        }
      //圆点变化
		$("#indicators>li:eq("+i+")").addClass("hover").siblings().removeClass("hover");
	})

 })


//秒杀专区
	///秒杀计时
	function task(){
		var end=new Date("2017/10/30 17:00:00");
		var now=new Date();
		var hour=document.getElementById("hour");
		var minutes=document.getElementById("minutes");
		var second=document.getElementById("second");
		var s=parseInt((end-now)/1000);
		if(s>0){
			var d=parseInt(s/3600/24);
			if(d<10) d="0"+d;
			//s/3600/24,再下取整
			var h=parseInt(s%(3600*24)/3600);
			if(h<10) h="0"+h;
			//s/(3600*24)的余数,再/3600,再下去整
			var m=parseInt(s%3600/60);
			if(m<10) m="0"+m;
			//s/3600的余数,再/60，再下取整
			s%=60;//s/60的余数
			if(s<10) s="0"+s;
			hour.innerHTML=h;
			minutes.innerHTML=m;
			second.innerHTML=s;
		  }else{
			clearInterval(timer);
		  }
	}
	task();
	var timer=setInterval(task,1000);
	//加载秒杀商品
	ajax("get","data/index/seckill_product.php","")
	    .then(output=>{
		 //根据规定的模板,动态生成秒杀商品的HTML代码片段
		var html="";
		for(var i=0;i<output.length;i++){
			var p=output[i];
			 html+=`
				<li>
                   <a href="${p.href}">
                       <img src="${p.pic}" alt=""/>
                       <p>${p.title}</p>
                       <p>¥${p.price} <span>¥${p.old_price}</span></p>
                   </a> 
               </li> 
			 `;
			  document.getElementById("seckill_product")
            .innerHTML=html;
		}
	})



//加载楼层
	ajax("get","data/index/floors.php","")
    .then(output=>{
		//根据规定的模板,动态生成f1的HTML代码片段
		var html="";
		var f1=output.f1;
		for(var i=0;i<f1.length;i++){
			var p=f1[i];
			html+=i<1?`
				<div class="content_top">
                    <a>
                        <img src="${p.pic}" alt=""/>
					</a>
					<div  class="attention">
							<p>${p.title}</p>
							<a href="#"><span>❤ </span>关注</a>
					</div>
                </div>`:i==1?`
				<div class="content_top">
					  <a href="${p.href}">
							<img src="${p.pic}" alt=""/>
					  </a>
				</div>`:`
				<div class="content_bottom">
                        <a href="${p.href}">
                            <img src="${p.pic}" alt=""/>
                            <p>${p.title}</p>
                            <p>${p.details}</p>
                        </a>
                        <div>
                            <span>¥${p.price}</span>
                            <span>已售: <span>${p.number_sold}</span>台</span>
                        </div>
				</div>
			
			`
		 }
		 $("#f1-content").html(html);


    //楼层2
		var html="";
		var f2=output.f2;
		for(var i=0;i<f2.length;i++){
			var p=f2[i];
			html+=i<1?`
				<div class="content_top">
                    <a>
                        <img src="${p.pic}" alt=""/>
                    </a>
					<div  class="attention">
							<p>${p.title}</p>
							<a href="#"><span>❤ </span>关注</a>
					</div>
                </div>`:i==1?`
				<div class="content_top">
					  <a href="${p.href}">
							<img src="${p.pic}" alt=""/>
					  </a>
				</div>`:`
				<div class="content_bottom">
                        <a href="${p.href}">
                            <img src="${p.pic}" alt=""/>
                            <p>${p.title}</p>
                            <p>${p.details}</p>
                        </a>
                        <div>
                            <span>¥${p.price}</span>
                            <span>已售: <span>${p.number_sold}</span>台</span>
                        </div>
				</div>
			
			`
		 }
		  $("#f2-content").html(html);

    //楼层3
		var html="";
		var f3=output.f3;
		for(var i=0;i<f3.length;i++){
			var p=f3[i];
			html+=i<1?`
				<div class="content_top">
                    <a>
                        <img src="${p.pic}" alt=""/>
                    </a>
					<div  class="attention">
							<p>${p.title}</p>
							<a href="#"><span>❤ </span>关注</a>
					</div>
                </div>`:i==1?`
				<div class="content_top">
					  <a href="${p.href}">
							<img src="${p.pic}" alt=""/>
					  </a>
				</div>`:`
				<div class="content_bottom">
                        <a href="${p.href}">
                            <img src="${p.pic}" alt=""/>
                            <p>${p.title}</p>
                            <p>${p.details}</p>
                        </a>
                        <div>
                            <span>¥${p.price}</span>
                            <span>已售: <span>${p.number_sold}</span>台</span>
                        </div>
				</div>
			
			`
		 }
		  $("#f3-content").html(html);
			
	//楼层加载******************************************//
	//获得id为f1的元素距页面顶部的总距离totalTop
	var f1TotalTop=$("#f1").offset().top;
	//console.log(f1TotalTop);
	//查找id为lift的div保存在变量lift中
	var lift=$("#lift");
	//为window添加滚动事件监听
	$(window).on("scroll",function(){
		//获得页面滚动的高度scrollTop
		var scrollTop=$(document).scrollTop();
		//如果totalTop<=scrollTop+innerHeight/2
		var top=scrollTop+$(window).height()/2;
		//console.log(top);
		if(top>=f1TotalTop){
	        //让lift显示
			lift.css({"display":"block"});
		}else{
			//否则,让lift隐藏
			lift.css({"display": "none"});
		}
		  /***********/
		 //只有电梯按钮显示时，才用判断按钮的亮灭
		if(lift.css("display")=="block"){
			//console.log("NB");
			//console.log($("#f1").height());//710+30
			//定义楼层高度变量FHEIGHT=740
			var FHEIGHT=740;
			var fs=$(".floor");
			 //遍历fs中每个楼层
			for(var i=0;i<fs.length;i++){
				//获得当前楼层距body顶部的总距离totalTop
				 var totalTop=getTotalTop(fs[i]);
				 //console.log(totalTop);
				  //计算楼层亮灯区域的开始位置
				  var start=totalTop-innerHeight/2;
				  //计算结束位置end为start+FHEIGHT
				  var end=start+FHEIGHT;
				  //如果scrollTop>=start且scrollTop<end
				  if(scrollTop>=start&&scrollTop<end)
				  break;//就退出循环
			}
			//在lift下找到class为lift_item_on的li，将其class恢复为lift_item
			var currLi=$(".lift_item_on1");
			if(currLi){
				currLi.removeClass("lift_item_on1");
				//设置lift下第i个li的class为lift_item_on
				$(`.lift_list li:nth-child(${i+1})`).addClass("lift_item_on1")
					.siblings().removeClass("lift_item_on1");
			}
		}/*亮灯*/
	});
	//在lift下找class为lift_list下的class为lift_item的所有a保存在as中
	var as=$("#lift  .lift_list .lift_item1");
	//console.log(as);
	var floors=$(".floor");
	//console.log(floors);
	as.on("click",function(){
		var i=$(this).index();
		//console.log(i);
		var totalTop=getTotalTop(floors[i]);
		//console.log(totalTop);
		//让window滚动到totalTop
		$("html,body").stop(true).animate({
          scrollTop:totalTop
        },500);
	})/*时间绑定*/
	//返回顶部
	var up=$(".gotop");
	up.on("click",function(){
		var totalTop=0;
		$("html,body").stop(true).animate({
          scrollTop:totalTop
        },1000);
	})
 })/*ajax*/


	
})();/*自调*/





