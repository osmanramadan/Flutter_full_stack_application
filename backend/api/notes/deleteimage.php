<?php
include "../auth/functions.php";

$dir=$_POST["dir"];
$name=$_POST["name"];

$k=deletefile($dir,$name);
if($k==1){
    echo json_encode(array("status"=>"done"));
}else{
    echo json_encode(array("status"=>"fail"));
}
?>