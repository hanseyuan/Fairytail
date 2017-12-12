<?php
session_start();
header("Content-Type:application/json");
require_once("../init.php");
@$uid=$_SESSION["uid"];
@$order_id=$_REQUEST["order_id"];
@$payPrice=$_REQUEST["payPrice"];

//$order_id='1511946782656562';
//$payPrice='888886';

if($uid){

$pay_time=time();  //支付时间 
$sql_update="update sc_order set payPrice=$payPrice,pay_time=$pay_time,status=2 where order_id=$order_id";

$result = mysqli_query($conn,$sql_update);
//获取更新影响行数
$rowsCount = mysqli_affected_rows($conn);
//判断结果并且输出 json
if($result && $rowsCount>0){
   echo '{"code":1,"msg":"付款成功！"}';
 }else{
   echo '{"code":-1,"msg":"付款失败！"}';
 }
	
}