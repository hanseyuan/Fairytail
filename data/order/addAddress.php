<?php
session_start();
header("Content-Type:application/json");
require_once("../init.php");
@$uid=$_SESSION["uid"];
//$uid=2;
@$province=$_REQUEST["province"];
@$city=$_REQUEST["city"];
@$county=$_REQUEST["county"];
@$address=$_REQUEST["address"];
@$cellphone=$_REQUEST["cellphone"];
@$receiver=$_REQUEST["receiver"];
@$is_default=$_REQUEST["is_default"];
@$postcode=$_REQUEST["postcode"];

if($address==""||$cellphone==""||$receiver==""||$postcode==""){
	echo '{"code":-2,"msg":"请完整您的信息"}';
	exit;//停止php运行
}

$sql="INSERT INTO sc_receiver_address VALUES(NULL,$uid,'$receiver','$province','$city','$county','$address','$cellphone','$postcode',$is_default)";
$sql_update="update sc_receiver_address set is_default='false' where  user_id=$uid";
if($is_default){
	sql_execute($sql_update);
};
sql_execute($sql);
$rowsCount = mysqli_affected_rows($conn);
//判断结果并且输出 json
if($rowsCount>0){
   echo '{"code":1,"msg":"添加成功！"}';
 }else{
   echo '{"code":-1,"msg":"添加失败！"}';
 }
