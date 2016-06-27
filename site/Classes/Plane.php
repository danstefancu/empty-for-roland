<?php

require_once 'Car.php';
require_once './Traits/Jet.php';

class Plane extends Car
{
    use Jet;
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