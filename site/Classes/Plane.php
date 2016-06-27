<?php

require_once 'Car.php';
require_once './Traits/airliner.php';
require_once './Traits/BusinessJet.php';

class Plane extends Car
{

    use Airliner,BusinessJet{
     BusinessJet::setOperator insteadof Airliner;
        Airliner::setOperator as setOP;
    }
    public $capacity;

    /**
     * @param $capacity
     * @return $this
     */
    public function setCapacity($capacity)
    {
        $this->capacity = $capacity;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getCapacity()
    {
        return $this->capacity;
    }

}