<?php
//<link rel="stylesheet" type="text/css" href="/home/c9432556/public_html/sinceretechnology.com.au/table.css"> 
function dir_size($dir)
{
  $handle = opendir($dir);
  while ($file = readdir($handle)) {
    if ($file != '..' && $file != '.' && !is_dir($dir.'/'.$file)) {
      $mas += filesize($dir.'/'.$file);
    } else if (is_dir($dir.'/'.$file) && $file != '..' && $file != '.') {
      $mas += dir_size($dir.'/'.$file);
    }
  }
  return $mas;
}
//$B?tCM$NC10L$rJQ99(B
function used_bytes($dir){
  $si_prefix = array('B', 'KB', 'MB', 'GB', 'TB', 'EB', 'ZB', 'YB');
  $base = 1024;
  $dir_size = dir_size($dir);
  $class = min((int)log($dir_size, $base), count($si_prefix) - 1);
  if(pow($base,$class) == 0){
    $used_bytes = "--";
  }else {
    $used_bytes = sprintf('%1.2f', $dir_size / pow($base, $class)) . $si_prefix[$class];
  }
  return $used_bytes;
}

//対象フォルダはカレントディレクトリ（WP-CONTENT）のひとつ上の階層に決め打ち
//第一引数の容量確認ターゲットディレクトリを取得する
if(!empty($_SERVER["argv"]) && count($_SERVER["argv"]) >= 2) {
  $dir = $_SERVER["argv"][1];
}else{
  $dir = "..";
}
//第二引数のURLを取得する（WPのサーバーURLをメールに表示するため）
if(!empty($_SERVER["argv"]) && count($_SERVER["argv"]) >= 3) {
  $targeturl = $_SERVER["argv"][2];
}else{
  $targeturl = "";
}
//第三引数の管理者用メールアドレスを取得する
if(!empty($_SERVER["argv"]) && count($_SERVER["argv"]) >= 4) {
  $admin_email = $_SERVER["argv"][3];
}else{
  $admin_email = "matsubara.h@gmail.com,matsubara.h@sinceretechnology.com.au";
}

$cdir = scandir($dir);

$content = "";
$content .= "<html>"; 
$content .=   "<body>"; 

  $content .= "backup has been completed successfully.";
  $content .= "<p>Total used space is ";
  $content .= used_bytes($dir);
  $content .= "</p>";

$content .=   "<table>"; 
$content .=   "<tr>"; 
$content .=   "<th style='background-color: #f34955;'>"; 
$content .=   "Folder name"; 
$content .=   "</th>"; 
$content .=   "<th style='background-color: #f34955;'>"; 
$content .=   "size"; 
$content .=   "</th>"; 
$content .=   "<th>"; 
$content .=   "</th>"; 
$content .=   "</tr>"; 
foreach ($cdir as $key => $value)
{
  if (is_dir($dir.'/'.$value) && !in_array($value,array(".","..")))
  {
  $content .= "<tr>"; 
  $content .= "<td>"; 
	$content .=($value);
  $content .= "</td>"; 
  $content .= "<td>"; 
	$size = used_bytes($dir.'/'.$value);
	$content .=($size);
  $content .= "</td>"; 
  $content .= "<td>";
  $mx=intval(dir_size($dir.'/'.$value)/1000000000); 
  for($i=0; $i<$mx;$i++){
    $content .= "*";
  } 
  $content .= "</td>"; 
  $content .= "</tr>"; 
  }
} 
  $content .= "<tr>"; 
  $content .= "<td style='font-weight: bold;'>"; 
  $content .= "Total";
  $content .= "</td>"; 
  $content .= "<td style='font-weight: bold;'>"; 
  $content .= used_bytes($dir);
  $content .= "</td>"; 
  $content .= "</tr>"; 
  $content .= "<tr>"; 
  $content .= "<td style='font-weight: bold;'>"; 
  $content .= "</td>"; 
  if(dir_size($dir)/200000000000>0.7){
    $col="red";
  }else{
    $col="black";
  }
  $content .= "<td style='font-weight: bold;color:".$col."'>"; 
  $content .= sprintf("%d",dir_size($dir)/200000000000*100)."%";
  $content .= "</td>"; 
  $content .= "<td>"; 
  $content .= "</td>"; 
  $content .= "</tr>"; 
  $content .= "</table>"; 

  //第一引数のURL（WPのサーバーURLをメールに表示するため）
  $content .= "<p>Target url: ".$targeturl."</p>";
  //第二引数の管理者用メールアドレス
  $content .= "<p>Mail to ".$admin_email."</p>";

  $content .= "<p>***** Please notify the sender immediately if you are not the intended recipient. *****</p>";

  $content .= "</body>"; 
  $content .= "</html>"; 

//echo $content;
$sysdate = date("Y/m/d H:i:s");

//第二引数の管理者用メールアドレス
$to = $admin_email;
$subject = "[$targeturl]Backup has been completed on $sysdate";
$message = $content;
$headers = "From: $admin_email";
$headers .= "\r\n";
$headers .= "Content-type: text/html; charset=UTF-8";
 
mail($to, $subject, $message, $headers);

