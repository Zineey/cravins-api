<?php
class General{
    protected $gm, $auth, $pdo;

    public function __construct(\PDO $pdo, $gm, $auth)
    {
        $this->pdo = $pdo;
        $this->gm = $gm;
        $this->auth = $auth;
    }
}
?>