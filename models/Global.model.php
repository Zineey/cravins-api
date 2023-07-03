<?php
Class GlobalMethods{
    protected $pdo;

    public function __construct(\PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function callRoutine($proc, $dt = null){
        $params = null;
        $data = null;
        $msg = "Unable to process Data";
        $remarks = "Failed";
        $values = array();
        $sql = '';

        if ($dt != null){
            $params = is_object($dt) ? $dt->payload : null;
            if (!empty($params)) {
                foreach ($params as $key => $value) {
                    array_push($values, $value);
                }
                $placeholder = implode(',', array_fill(0, count($values), '?'));
                $sql = "CALL $proc($placeholder);";
            }
        } else{
            $sql = "CALL $proc()";
        }
        $stmt = $this->pdo->prepare($sql);

        try {
            if (count($values) > 0) {
                $stmt->execute($values);
                if ($stmt->rowCount() > 0){
                    if ($res = $stmt->fetchAll()): $data = $res; 
                    endif;
                    $stmt->closeCursor();
                    $remarks = "Success";
                    $msg = "Successfully Performed the request operation";
                    $code = 200;
                    return $this->response_payload($data, $remarks, $msg, $code);
                }
            } else{
                $data = array();
                if ($result = $this->pdo->query($sql)->fetchAll()){
                    foreach($result as $record){
                        array_push($data, $record);
                    }
                    $stmt->closeCursor();
                    $remarks = "Success";
                    $msg = "Successfully Performed the request operation";
                    $code = 200;
                    return $this->response_payload($data, $remarks, $msg, $code);
                } else{
                    $msg ="No Data Found";
                    $code = 404;
                }
            }
        } catch(\PDOException $e){
            $msg = $e->getMessage();
            $code = 403;
            echo $e->getMessage();
            return $this->response_payload(null, $remarks, $msg, $code);
        }
    }

    public function response_payload($payload, $remarks, $message, $code){
        $status = array("remarks"=>$remarks, "message"=> $message);
        http_response_code($code);
        return array(
            "status"=>$status,
            "payload"=>$payload,
            "timestamp" => date_create(),
            "prepared_by" => "John Carlo D. Ramos"
        );
    }
}

?>