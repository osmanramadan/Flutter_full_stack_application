<?php
function filterrequest($req)
{
  return htmlspecialchars(strip_tags($_POST[$req]));
}

function upload_file($filerequest)
{
  // define("mb", 1048576);
  global $errors;
  //$filerequest is path of image or file
  
  $randomnum=rand(0,10000);

  $filename = "image".$randomnum.$_FILES[$filerequest]['name'];
  $tmpplace_name = $_FILES[$filerequest]['tmp_name'];
  $size = $_FILES[$filerequest]['size'];
  $allowedext = array("jpg", "png", "gif", "mp3", "pdf");

  $strtoarrary = explode(".", $filename);
  $findextention = end($strtoarrary);


  if (!empty($filerequester) && !in_array($findextention, $allowedext)) {
    $errors[] = "ext";
  }
  if ($size > 2 * 1048576) {
    $errors[] = "size";
  }
  if (empty($errors)) {
    move_uploaded_file($tmpplace_name, "../auth/upload/" . $filename);
    return $filename;
  } else {
    echo json_encode(array("status" => "fail"));
  }
}

function deletefile($dir, $imagename)
{
  if (file_exists($dir . "/" . $imagename)) {
    $f=unlink($dir . "/" . $imagename);
    return $f;
  }
}



function checkAuthenticate()
{
    if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {
        if ($_SERVER['PHP_AUTH_USER'] != "osman" ||  $_SERVER['PHP_AUTH_PW'] != "kjhuy7t7tt6r6r6r6r5rtee4e"){
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;

        }
    } else {
        exit;
    }}
?>
