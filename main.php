<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json: charset=utf8");
header("Access-Control-Allow-Methods: GET, POST, PATCH");
header("Access-Control-Max-Age: 86400");
ini_set('display_errors', 0);

date_default_timezone_set("Asia/Manila");
set_time_limit(1000);

$rootPath = $_SERVER['DOCUMENT_ROOT'];
$apiPath = $_SERVER['DOCUMENT_ROOT']."/cravins-api";
require_once($apiPath."/config/Connection.php");
require_once($apiPath."/controllers/Path.php");


$db = new Connection();
$pdo = $db->connect();
$gm = new GlobalMethods($pdo);
$auth = new Auth($pdo,$gm);


$req = [];
if(isset($_REQUEST['request'])){
    $req = explode('/', rtrim($_REQUEST['request'], '/') );
 }
 else{
     http_response_code(404);
 }

switch($_SERVER['REQUEST_METHOD']) {
    case 'GET': 
        print_r("Error");
        http_response_code(403);
    break;

    case 'POST':
        require_once($apiPath."/routes/Cravins.routes.php");
    break;

    default:
        print_r("Forbidden Access");
        http_response_code(403);
    break;
}

?>