<?php
session_start();
header("Content-Type:application/json");
require_once("../init.php");
@$uid=$_SESSION["uid"];
//1:判断上传文件内容是否为空
$rs=empty($_FILES);
//var_dump($rs);bool(true)
if($rs==true){
	die('{"code":-1."msg":"没有上传文件请检查"}');
}
//2:获取上传文件名  mypic 上传文件参数名称
//3:获取上传文件大小
$picname=$_FILES["mypic"]["name"];
$picsize=$_FILES["mypic"]["size"];
//4:判断文件超过512KB禁止上传
if($picsize>512*1024){
	die('{"code":-2."msg":"上传文件过大,超过512K"}');
}
//5:获取上传文件后缀
//6:判断格式
//7:不是图片格式禁止上传
$type=strstr($picname,".");
if($type!=".jpg" && $type!=".png" && $type!=".gif"){
	die('{"code":-3."msg":"上传文件格式不正确"}');
}
//8:创建新文件名
$fileName=time().rand(1,9999).$type;
//9:上传
$src =  $_FILES["mypic"]["tmp_name"];//原路径
$des =  "../../img/avatar/".$fileName;//现在路经
move_uploaded_file($src,$des);

$position="img/avatar/".$fileName;

//$sql = "UPDATE sc_user SET avatar='tttt' WHERE uid=$uid";
$sql =  " UPDATE sc_user SET  avatar='$position' WHERE uid=$uid";
$result = mysqli_query($conn,$sql);
$rowsCount = mysqli_affected_rows($conn);
//判断结果并且输出 json
if($result && $rowsCount>0){
   echo '{"code":1,"msg":"上传成功"}';
 }else{
   echo '{"code":-1,"msg":"上传失败"}';
 }