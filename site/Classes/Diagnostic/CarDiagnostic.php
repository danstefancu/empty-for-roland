<?php

/**
 * Class CarDiagnostic
 */
class CarDiagnostic
{
    public function __construct($arg,$args)
    {
        $this->$arg = $arg;
        foreach($args as $key => $value){
            $this->$args[$key] = $value;
        }
    }
    
    public function runDiagnostic(){
        return true;
    }
}