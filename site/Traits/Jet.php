<?php

require_once 'airliner.php';
require_once 'BusinessJet.php';

trait Jet{
    use Airliner,BusinessJet{
        BusinessJet::setOperator insteadof Airliner;
        Airliner::setOperator as setOp;
    }

    public static $oPStatus = "In service";
    public $operationBase;

    /**
     * @param string $oPStatus
     */
    public static function setOPStatus($oPStatus)
    {
        self::$oPStatus = $oPStatus;
    }

    /**
     * @return string
     */
    public static function getOPStatus()
    {
        return self::$oPStatus;
    }

    /**
     * @param mixed $operationBase
     */
    public function setOperationBase($operationBase)
    {
        $this->operationBase = $operationBase;
    }

    /**
     * @return mixed
     */
    public function getOperationBase()
    {
        return $this->operationBase;
    }
}