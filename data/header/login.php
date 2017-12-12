<?php
session_start();
header("Content-Type:application/json;charset=utf-8");
require("../init.php");
@$uname=$_REQUEST["uname"];
@$upwd=$_REQUEST["upwd"];
$uPattern = '/^[A-Za-z0-9]{3,16}$/';
$pPattern = '/^[A-Za-z0-9]{6,18}$/';
if(!preg_match($uPattern,$uname)){
 echo '{"code":-2,"msg":"用户名格式不正确"}';
 exit;//停止php运行
}

if(!preg_match($pPattern,$upwd)){
 echo '{"code":-3,"msg":"密码格式不正确"}';
 exit;//停止php运行
}


$sql="select uid from sc_user where uname='$uname'  and upwd='$upwd' ";
$result=sql_execute($sql);
if(count($result)){
  $_SESSION["uid"]=$result[0]["uid"];
  //echo $result[0]["uid"];
  echo '{"code":1,"msg":"登录成功"}';
}else{
   echo '{"code":-1,"msg":"用户名或密码有误"}';
}
?>