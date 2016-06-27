<?php

require_once 'VehicleBase.php';

class Train extends VehicleBase
{
    public $size;

    /**
     * @param $size
     * @return $this
     */
    public function setSize($size)
    {
        $this->size = $size;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getSize()
    {
        return $this->size;
    }
}