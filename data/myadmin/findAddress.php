<?php
session_start();
header("Content-Type:application/json");
require_once("../init.php");
@$uid=$_SESSION["uid"];
@$aid=$_REQUEST["aid"];
if($uid){
	$sql=" SELECT * FROM sc_receiver_address  WHERE user_id=$uid and aid=$aid";
	@$result = mysqli_query($conn,$sql);
	@$rows = mysqli_fetch_all($result,MYSQLI_ASSOC);	
	echo json_encode($rows);
}