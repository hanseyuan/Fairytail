<?php
session_start();
header("Content-Type:application/json");
require_once("../init.php");
@$uid=$_SESSION["uid"];

@$province=$_REQUEST["province"];
@$city=$_REQUEST["city"];
@$county=$_REQUEST["county"];
@$address=$_REQUEST["address"];
@$cellphone=$_REQUEST["cellphone"];
@$receiver=$_REQUEST["receiver"];
@$is_default=$_REQUEST["is_default"];
@$postcode=$_REQUEST["postcode"];
@$aid=$_REQUEST["aid"];
 
if($address==""||$cellphone==""||$receiver==""||$postcode==""){
	echo '{"code":-2,"msg":"请完整您的信息"}';
	exit;//停止php运行
}


$sql = " UPDATE sc_receiver_address SET  receiver='$receiver',province='$province',city='$city',county='$county',address='$address',cellphone='$cellphone',postcode='$postcode',is_default=$is_default WHERE aid=$aid ";
$result = mysqli_query($conn,$sql);
//获取更新影响行数
$rowsCount = mysqli_affected_rows($conn);
//判断结果并且输出 json
if($result && $rowsCount>0){
   echo '{"code":1,"msg":"修改成功！"}';
 }else{
   echo '{"code":-1,"msg":"您做任何修改！"}';
 }