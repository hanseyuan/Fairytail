<?php
session_start();
header("Content-Type:application/json");
require_once("../init.php");
@$uid=$_SESSION["uid"];
@$gender=$_REQUEST["gender"];
@$phone=$_REQUEST["phone"];
@$email=$_REQUEST["email"];
$Pattern = '/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/';
$hPattern='/^((\+86|0086)\s+)?1[34578]\d{9}$/';

if(!preg_match($Pattern,$email)){
 echo '{"code":-2,"msg":"邮箱格式不正确"}';
 exit;//停止php运行
}
if(!preg_match($hPattern,$phone)){
 echo '{"code":-3,"msg":"手机格式不正确"}';
 exit;//停止php运行
}

//$gender=0;
//$email="snnsss@qq.com";
$sql =  " UPDATE sc_user SET  phone=$phone,gender='$gender',email='$email' WHERE uid=$uid";
$result = mysqli_query($conn,$sql);
//获取更新影响行数
$rowsCount = mysqli_affected_rows($conn);
//判断结果并且输出 json
if($result && $rowsCount>0){
   echo '{"code":1,"msg":"修改成功！"}';
 }else{
   echo '{"code":-1,"msg":"您未做任何修改！"}';
 }