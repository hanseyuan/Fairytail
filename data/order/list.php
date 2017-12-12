<?php
session_start();
header("Content-Type:application/json");
require_once("../init.php");
@$uid=$_SESSION["uid"];
if($uid){
$sql="SELECT iid,lid,title,price,count,RAM,ROM,color,
	(SELECT md FROM `sc_phone_pic` WHERE color_id=color_num limit 1)  as md
	FROM sc_shoppingcart_item inner 
	JOIN sc_phone ON lid=product_id 
	WHERE user_id=$uid and `is_checked` = '1' ORDER  BY iid DESC
	";
echo json_encode(sql_execute($sql));
}