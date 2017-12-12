<?php
header("Content-Type:text/plain");
require_once("../init.php");
@$iid=$_REQUEST["iid"];
$sql="update sc_shoppingcart_item set is_checked=true where iid=$iid";
echo json_encode(sql_execute($sql));