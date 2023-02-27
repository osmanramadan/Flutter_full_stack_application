
<?php
include "../auth/connect.php";




$title       = filterrequest("title");
$content     = filterrequest("content");
$userid      = filterrequest("id");
$imagename   = upload_file("file");

    
    
    $stmt = $con->prepare("INSERT INTO `notes`(`notes_title`,`notes_content`,`notes_image`,`notes_users`) VALUES (?  , ?, ? , ?) ");
    $stmt->execute(array($title, $content,$imagename, $userid));
    $count = $stmt->rowCount();
    
    if ($count > 0) {

    echo json_encode(array("status" => "success"));
    }
    else
    {
    echo json_encode(array("status" => "fail"));
    }
?>
