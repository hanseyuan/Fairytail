<?php
header("Content-Type:application/json;charset=utf-8");
require_once("../init.php");
@$uname=$_REQUEST["uname"];
@$upwd=$_REQUEST["upwd"];
@$phone=$_REQUEST["phone"];
//.1通过正则表达式在PHP对用户参数再验证
$uPattern = '/^[A-Za-z0-9]{3,16}$/';
$pPattern = '/^[A-Za-z0-9]{6,18}$/';
$hPattern='/^((\+86|0086)\s+)?1[34578]\d{9}$/';


if(!preg_match($uPattern,$uname)){
 echo '{"code":-3,"msg":"用户名格式不正确"}';
 exit;//停止php运行
}
$sql="SELECT * FROM sc_user where uname='".strtolower($uname)."'";
$result = mysqli_query($conn,$sql);
$rowCount=mysqli_affected_rows($conn);
if($result && $rowCount>0){
	echo '{"code":-4,"msg":"该用户名已被占用"}';
	exit;
}



if(!preg_match($pPattern,$upwd)){
 echo '{"code":-3,"msg":"密码格式不正确"}';
 exit;//停止php运行
}



if(!preg_match($hPattern,$phone)){
 echo '{"code":-3,"msg":"手机格式不正确"}';
 exit;//停止php运行
}
$sql="SELECT * FROM sc_user where phone='".strtolower($phone)."'";
$result2 = mysqli_query($conn,$sql);
$rowCount2=mysqli_affected_rows($conn);
if($result2 && $rowCount2>0){
	echo '{"code":-4,"msg":"该手机号码已被占用"}';
	exit;
}



$sql="INSERT INTO sc_user (uname, upwd, phone) VALUES ('$uname','$upwd','$phone')";
$result = mysqli_query($conn,$sql);
$rowCount=mysqli_affected_rows($conn);
if($result && $rowCount>0){
	echo '{"code":1,"msg":"注册成功,去登录"}';
}else{
	echo '{"code":-1,"msg":"注册失败:信息填写有误"}';
}