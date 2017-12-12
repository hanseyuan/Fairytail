<?php
session_start();
header("Content-Type:application/json");
require_once("../init.php");
@$uid=$_SESSION["uid"];
$sql=" SELECT * FROM sc_user  WHERE uid=$uid";

@$result = mysqli_query($conn,$sql);
@$row = mysqli_fetch_assoc($result);
if(!$row){
  //echo mysqli_error($conn);//显示详细错误信息
  die('{"code":-1,"msg":"'.mysqli_error($conn).'"}');
  //停止php运行,并且输出字符串
}
echo json_encode($row);