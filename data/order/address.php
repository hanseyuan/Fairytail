<?php
session_start();
header("Content-Type:application/json");
require_once("../init.php");
@$uid=$_SESSION["uid"];
if($uid){
	$sql=" SELECT * FROM sc_receiver_address  WHERE user_id=$uid ORDER  BY is_default DESC";
	@$result = mysqli_query($conn,$sql);
	@$rows = mysqli_fetch_all($result,MYSQLI_ASSOC);	
	echo json_encode($rows);
}