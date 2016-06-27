<?php

trait BusinessJet{
    public $seatCapacity;
    public $range;


    /**
     * @param $operator
     * @return $this
     */
    public function setOperator($operator){
        $this->operator = $operator;
        return $this;
    }


}