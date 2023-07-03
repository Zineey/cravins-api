<?php
$dt = json_decode(file_get_contents("php://input"));
if($req[0] == 'getusers'){ echo json_encode($gm->callRoutine("getUsers")); return;}
if($req[0] == 'getuser'){ echo json_encode($gm->callRoutine("getUser", $dt)); return;}
if($req[0] == 'changepass'){ echo json_encode($gm->callRoutine("changePass", $dt)); return;}
if($req[0] == 'login'){ echo json_encode($gm->callRoutine("authLogin", $dt)); return;}
if($req[0] == 'register'){ echo json_encode($gm->callRoutine("createAccount", $dt)); return;}
if($req[0] == 'createdish'){ echo json_encode($gm->callRoutine("createDish", $dt)); return;}
if($req[0] == 'deleteuserdata'){ echo json_encode($gm->callRoutine("deleteUserData", $dt)); return;}
if($req[0] == 'deletedish'){ echo json_encode($gm->callRoutine("deleteDish", $dt)); return;}
if($req[0] == 'updatedish'){ echo json_encode($gm->callRoutine("updateDish", $dt)); return;}
if($req[0] == 'updateuser'){ echo json_encode($gm->callRoutine("updateUser", $dt)); return;}
if($req[0] == 'getdishes'){ echo json_encode($gm->callRoutine("getDishes")); return;}
if($req[0] == 'getdishbyname'){ echo json_encode($gm->callRoutine("getDishByName", $dt)); return;}
if($req[0] == 'getdishbyrecipe'){ echo json_encode($gm->callRoutine("getDishByRecipe", $dt)); return;}
if($req[0] == 'randomdish'){ echo json_encode($gm->callRoutine("getRandomDish")); return;}

?>