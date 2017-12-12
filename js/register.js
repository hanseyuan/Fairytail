    /*****弹框********/
	function jumpMsg(msg,code){
		var code=parseInt(code);
		$("#jumpbox").css("display","block");
		$("#msg").html(msg);
		$("#yes").click(function(){
			$(this).parent().parent().css("display","none");
			if($(this).parent().parent().css("display")=="none"&& code>0){
				location.href = "login.html";
			}
		});
	
	};
  
  
  
  
  
  //正则
  var ureg = /^[A-Za-z0-9_-]{3,16}$/i;
  var preg = /^[A-Za-z0-9_-]{6,18}$/i;
  var phonereg=/^((\+86|0086)\s+)?1[34578]\d{9}$/i;

  //用户注册
	 //console.log($("[name='uname']"));
   //1用户名验证
    function getUnameFocus(){
		var  u=$(this).val();
		var  u=$("[name='uname']").val();
		var msgName=$("#msgName");
		if(u==""){
			msgName.html("用户名不能为空");
			msgName.css({"color":"red"});
			
		}else if(!ureg.test(u)){
			msgName.html("格式不正确:只能是3~16位字母数字");
			msgName.css({"color":"red"});
		}else{
			$.ajax({
				type:"GET",
				url:"data/register/valiName.php",
				data:{uname:u},
				success:function(data){
					if(data=="true"){
					  msgName.html("用户名可用");
					  msgName.css({"color":"green"});
					}else{
					    msgName.html("用户名已占用");
						msgName.css({"color":"red"});
					}
				},
				error:function(){
					alert("网络错误,请检查");
				}
			})
		
		}
	}
	$("[name='uname']").focusout(getUnameFocus);
	//1用户名验证
	/*$("[name='uname']").focusout(function(){
		var  u=$(this).val();
		var msgName=$("#msgName");
		if(u==""){
			msgName.html("用户名不能为空");
			msgName.css({"color":"red"});
			
		}else if(!ureg.test(u)){
			msgName.html("格式不正确:只能是3~16位字母数字");
			msgName.css({"color":"red"});
		}else{
			$.ajax({
				type:"GET",
				url:"data/register/valiName.php?uname="+u,
				success:function(data){
					if(data=="true"){
					  msgName.html("用户名可用");
					  msgName.css({"color":"green"});
					}else{
					    msgName.html("用户名已占用");
						msgName.css({"color":"red"});
					}
				},
				error:function(){
					alert("网络错误,请检查");
				}
			})
		
		}

	})*/
 //密码
	 function getUpwdFocus(){
			//var p = $(this).val();
			var p= $("[name='upwd']").val();
			var msgUpwd=$("#msgUpwd");
			if(p==""){
				msgUpwd.html("密码不能为空");
				msgUpwd.css({"color":"red"});
			}else if(!preg.test(p)){
				msgUpwd.html("格式不正确:只能是6~18位字母数字");
				msgUpwd.css({"color":"red"});
			}else{
				msgUpwd.html("√");
				msgUpwd.css({"color":"green"});
			}
	 }
	 $("[name='upwd']").focusout(getUpwdFocus);

	/*$("[name='upwd']").focusout(function(){
	 	var p = $(this).val();
		var msgUpwd=$("#msgUpwd");
		if(!preg.test(p)){
			msgUpwd.html("格式不正确:只能是6~18位字母数字");
			msgUpwd.css({"color":"red"});
		}else{
			msgUpwd.html("√");
			msgUpwd.css({"color":"green"});
		}

	})*/

///核对密码




 $("[name='tupwd']").focusout(function(){
	var t= $("[name='tupwd']").val();
	var p = $("[name='upwd']").val();
	var msgTupwd=$("#msgTupwd");
	if(t==""){
		msgTupwd.html("请再次输入密码");
		msgTupwd.css({"color":"red"});
	}else if(t!=p){
		msgTupwd.html("两次密码不一致");
		msgTupwd.css({"color":"red"});
	}else{
		msgTupwd.html("√");
		msgTupwd.css({"color":"green"});
	}

 })
//核对手机号
 function getPhoneFocus(){
		var  phone =$("[name='phone']").val();
		//var  phone =$(this).val();
		var msgPhone=$("#msgPhone");
			//alert(msgPhone);
		if(phone==""){
			msgPhone.html("手机号不能为空");
			msgPhone.css({"color":"red"});
			
		}else if(!phonereg.test(phone)){
			msgPhone.html("格式不正确");
			msgPhone.css({"color":"red"});
		}else{
			$.ajax({
				type:"GET",
				url:"data/register/valiPhone.php",
				data:{phone:phone},
				success:function(data){

					if(data=="true"){
					  msgPhone.html("手机号可用");
					  msgPhone.css({"color":"green"});
					}else{
					   msgPhone.html("手机号已占用");
					msgPhone.css({"color":"red"});
					}
				},
				error:function(){
					alert("网络错误,请检查");
				}
			})
		
		}
	
	}
	$("[name='phone']").focusout(getPhoneFocus);

	/*$("[name='phone']").focusout(function(){
		var  phone =$("[name='phone']").val();
		//var  phone =$(this).val();
		var msgPhone=$("#msgPhone");
			//alert(msgPhone);
		if(phone==""){
			msgPhone.html("手机号不能为空");
			msgPhone.css({"color":"red"});
			
		}else if(!phonereg.test(phone)){
			msgPhone.html("格式不正确");
			msgPhone.css({"color":"red"});
		}else{
			$.ajax({
				type:"GET",
				url:"data/register/valiPhone.php?phone="+phone,
				success:function(data){
					if(data=="true"){
					  msgPhone.html("手机号可用");
					  msgPhone.css({"color":"green"});
					}else{
					   msgPhone.html("手机号已占用");
					msgPhone.css({"color":"red"});
					}
				},
				error:function(){
					alert("网络错误,请检查");
				}
			})
		
		}

	})*/



	//提交
	$("#submit").click(function(){
	
		var  uname=$("[name='uname']").val();
		var upwd= $("[name='upwd']").val();
		var  phone =$("[name='phone']").val();
		 getUnameFocus; getUpwdFocus; getPhoneFocus;
		/*getUnameFocus;
		getUpwdFocus;
		getPhoneFocus;*/
	   $.ajax({
			type:"post",
			url:"data/register/register.php",
			data:{
				 uname:uname,
				 upwd:upwd,
				 phone:phone
			},
			success:function(data){
					 	//console.log(typeof data);
				if(data.code>0){
					//alert(data.msg);
					jumpMsg(data.msg,data.code);
				}else{
					//alert(data.msg);
					jumpMsg(data.msg,data.code);
				}	
			},
			error:function(){
					alert("网络错误,请检查");
			}
		
		})

	})

	