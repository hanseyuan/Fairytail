<?php
session_start();
header("Content-Type:application/json");
require_once("../init.php");
$uid=$_SESSION["uid"];
@$lid=$_REQUEST["lid"];
@$count=$_REQUEST["count"];
$sql_has="select * from sc_shoppingcart_item where product_id=$lid and user_id=$uid";
//添加
$sql_insert="insert into sc_shoppingcart_item(iid,user_id,product_id,count) values(null,$uid,$lid,$count)";
//更新
$sql_update="update sc_shoppingcart_item set count=count+$count where product_id=$lid and user_id=$uid";
//如果购物车中没有，就insert
//否则 就update
if(count(sql_execute($sql_has)))
  sql_execute($sql_update);
else
  sql_execute($sql_insert);
$rowsCount = mysqli_affected_rows($conn);
//判断结果并且输出 json
if($rowsCount>0){
   echo '{"code":1,"msg":"添加成功,前往购物车！"}';
 }else{
   echo '{"code":-1,"msg":"添加失败！"}';
 }