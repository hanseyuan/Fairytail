<?php
session_start();
header("Content-Type:application/json");
require_once("../init.php");
@$uid=$_SESSION["uid"];
@$upwd=$_REQUEST["upwd"];
@$nupwd=$_REQUEST["nupwd"];
@$tupwd=$_REQUEST["tupwd"];
//$uid=2;
//$upwd="1234567";
//$nupwd="123456";
//$tupwd="135456";
$sql_select=" SELECT * FROM sc_user  WHERE uid=$uid AND upwd='$upwd'";
$result = mysqli_query($conn,$sql_select);
$row = mysqli_fetch_assoc($result);

if($row==null){
  echo '{"code":-2,"msg":"旧密有误"}';
  exit;
 }


$Pattern = '/^[A-Za-z0-9]{6,18}$/';
if(!preg_match($Pattern,$nupwd)){
 echo '{"code":-3,"msg":"新密码格式不正确"}';
 exit;//停止php运行
}

//echo $nupwd;
//echo $tupwd;
//echo $nupwd==$tupwd;
if(!$nupwd==$tupwd){
 echo '{"code":-4,"msg":"两次输入不一致"}';
 exit;//停止php运行
}



$sql_update=" UPDATE sc_user SET upwd='$nupwd' WHERE uid=$uid";
$result = mysqli_query($conn,$sql_update);
$rowCount = mysqli_affected_rows($conn);
if($result&&$rowCount>0){
  echo ('{"code":1,"msg":"密码修改成功"}');
}else{
  echo ('{"code":-1,"msg":"修改失败,新旧密码不能一致"}');
}