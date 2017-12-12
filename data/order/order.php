<?php
session_start();
header("Content-Type:application/json");
require_once("../init.php");
@$uid=$_SESSION["uid"];
@$address_id=$_REQUEST["address_id"];
@$post=$_REQUEST["post"];
@$discount=$_REQUEST["discount"];


if($uid){
$sql="SELECT iid,lid,title,price,count,RAM,ROM,color,
	(SELECT md FROM `sc_phone_pic` WHERE color_id=color_num limit 1)  as md
	FROM sc_shoppingcart_item inner 
	JOIN sc_phone ON lid=product_id 
	WHERE user_id=$uid and `is_checked` = '1' ORDER  BY iid DESC
	";



$result=sql_execute($sql);
$showtime= time();
$order_id=time()."65656".$uid;
//echo($showtime);
//echo($order_id);
$sql_add="";
$price=0;
$totalPrice=0;
for($i=0;$i<count($result);$i++){
	$data=$result[$i];
	//echo  json_encode($data);
	
	$status=1;  //订单状态
	$iid=$data['iid'];
	$order_time=$showtime;  //下单时间   
	$product_id=$data['lid'];		   //产品编号
	$count=$data['count'];		   //购买数量
	$price=$data['price'];
	$totalPrice+=$price*$count;
	$sql_add.="insert into  sc_order (user_id,order_id,product_id,count,address_id,status,order_time) values ($uid,'$order_id',$product_id,$count,$address_id,$status,$order_time);";

	
}
$totalPrice=$totalPrice+$post-$discount;	
	//$sql_update="update sc_order set payPrice=$payPrice where order_id=$order_id";
	//$result2=mysqli_query($conn,$sql_update);



	$sql_del="DELETE FROM sc_shoppingcart_item WHERE  is_checked=1 and user_id=$uid";
	$result1=mysqli_query($conn,$sql_del);
	

	$result =mysqli_multi_query($conn,$sql_add);
	$rowsCount = mysqli_affected_rows($conn);
	
	$output=array();
	$output["order_id"]=$order_id;
	$output['price']=$price;
	$output['discount']=$discount;
	$output['post']=$post;
	$output['totalPrice']=$totalPrice;
	$output["code"]="1";
	$output["msg"]="成功";
	if($rowsCount>0){
		echo  json_encode($output) ;
	}else{
	   echo '{"code":-1,"msg":"失败！"}';
	}

}




