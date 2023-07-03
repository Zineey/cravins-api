<?php

define("SERVER", "localhost");
define("DBASE", "cravins");
define("USER", "202011014");
define("PWORD", "ramosGC2021");

class Connection{
    protected $con_string = "mysql:host=".SERVER.";dbname=".DBASE."; charset=utf8mb4";
    protected $options = [
        \PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION,  
        \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC,
        \PDO::ATTR_EMULATE_PREPARES => false,
    ];

    public function connect(){
        return new \PDO($this->con_string, USER, PWORD, $this->options);
    }
}
?>