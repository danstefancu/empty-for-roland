<?php

require_once 'VehicleBase.php';
require_once '../Traits/airliner.php';

class Train extends VehicleBase
{
    use Airliner;
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