<?php
header("Content-Type:application/json");
require_once("../init.php");
$output=[];
$sql="SELECT * FROM sc_recommend_product  limit 4";
$output=sql_execute($sql);

echo json_encode($output);