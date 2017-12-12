<?php
header("Content-Type:application/json");
require_once("../init.php");
$output=[];
@$title=$_REQUEST["title"];
@$RAM=$_REQUEST["RAM"];
@$ROM=$_REQUEST["ROM"];
@$color=$_REQUEST["color"];



 $sql="SELECT lid from sc_phone where title LIKE '%$title%' AND RAM='$RAM'  AND ROM='$ROM'  AND color='$color'";
 //$output["id"]=sql_execute($sql)[0];
 //$color_id=$output["id"]["color_id"];
 //echo $color_id;
 ///*查询图片*/
 //$sql="SELECT * FROM sc_phone_pic where color_id='$color_id' ";
 //$output["phone"]["pics"]=sql_execute($sql);
$output=sql_execute($sql)[0];
 echo json_encode($output);