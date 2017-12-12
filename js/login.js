  /*****弹框********/
	function jumpMsg(msg,code){
		var code=parseInt(code);
		$("#jumpbox").css("display","block");
		$("#msg").html(msg);
		$("#yes").click(function(){
			$(this).parent().parent().css("display","none");
			if($(this).parent().parent().css("display")=="none"&& code>0){
				window.location.reload();
			}
		});
	
	};
  
   $(".tabs:has([data-toggle=tab])").on("click","[data-toggle=tab]",e=>{
	   e.preventDefault();
      var $tar=$(e.target);
      if(!$tar.parent().is(".active")){
        $tar.parent().addClass("active")
          .siblings().removeClass("active");
        var id=$tar.attr("href");
        $(id).addClass("active")
          .siblings().removeClass("active");
      }
    })
  
  
  //正则
  var ureg = /^[A-Za-z0-9_-]{3,16}$/i;
  var preg = /^[A-Za-z0-9_-]{6,18}$/i;
  var phonereg=/^((\+86|0086)\s+)?1[34578]\d{9}$/i;

  //用户登录
	 //console.log($("[name='uname']"));
   //1用户名验证
    function getUnameFocus(){
		var u=$(this).val();
		var msgName=$(".msgName");
		var  u=$("[name='uname']").val();
		if(u==""){
			msgName.html("用户名不能为空");
			msgName.css({"color":"red"});
		}else if(!ureg.test(u)){
			msgName.html("格式不正确:只能是3~16位字母数字");
			msgName.css({"color":"red"});
		}else{
			msgName.html(" ");
			msgName.css({"color":"red"});
		}
	}
	$("[name='uname']").focusout(getUnameFocus);
	
 //密码
			var msgUpwd=$(".msgUpwd");
	 function getUpwdFocus(){
			//var p = $(this).val();
			var p= $("[name='upwd']").val();
			if(p==""){
				msgUpwd.html("密码不能为空");
				msgUpwd.css({"color":"red"});
			}else if(!preg.test(p)){
				msgUpwd.html("格式不正确:只能是6~18位字母数字");
				msgUpwd.css({"color":"red"});
			}else{
				msgUpwd.html(" ");
				msgUpwd.css({"color":"red"});
			}
	 }
	 $("[name='upwd']").keyup(getUpwdFocus);


	//提交
	$("#submit").click(function(){
		var  uname=$("[name='uname']").val();
		var upwd= $("[name='upwd']").val();
	    $.ajax({
			type:"post",
			url:"data/login/login.php",
			data:{
				 uname:uname,
				 upwd:upwd
			},
			success:function(data){
				if(data.code==-2){
					msgName.html(data.msg);
					msgName.css({"color":"red"});
				}else if(data.code==-3){
					msgUpwd.html(data.msg);
					msgUpwd.css({"color":"red"});	
				}else if(data.code==-1){
					//msgUpwd.html(data.msg);
					//msgUpwd.css({"color":"red"});
					jumpMsg(data.msg,data.code);
				}else if(data.code>0){
					location.href = "index.html";
				};
			},
			error:function(){
					alert("网络错误,请检查");
			}
		})

	})

	