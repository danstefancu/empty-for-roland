<?php

class VehicleBase
{
    public $color;
    public $type;
    public $operator;

    /**
     * @param mixed $operator
     */
    public function setOperator($operator)
    {
        $this->operator = $operator;
    }

    /**
     * @return mixed
     */
    public function getOperator()
    {
        return $this->operator;
    }

    /**
     * @return mixed
     */
    public function getColor()
    {
        return $this->color;
    }

    /**
     * @param $color
     * @return $this
     */
    public function setColor($color)
    {
        $this->color = $color;
        return $this;
    }

    protected $colorNumber;

    /**
     * This method sets the value of the
     * property which is given
     *
     * @param $name
     * @param $value
     */
    public function __set($name, $value)
    {
        $this->$name=$value;
    }

    /**
     * This method extracts the value of the
     * property sent
     *
     * @param $value
     * @return mixed
     */
    public function __get($value){
        return $this->value;
    }

    /**
     * @param $type
     * @return $this
     */
    public function setType($type){
        $this->type = $type;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getType()
    {
        return $this->type;
    }

    /**
     * @param $colorNumber
     */
    public function setColorNumber($colorNumber){
        $this->colorNumber = $colorNumber;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getColorNumber(){
        return $this->colorNumber;
    }

    public function __isset($name)
    {
        if($this->$name) return true;
    }

    public function __clone(){
        $this->setType('SUV');
    }

    public function __invoke()
    {
        return get_class_methods(get_class($this));
    }

    public function __unset($name)
    {
        unset($this->$name);
    }

    public function __wakeup()
    {
        return true;
    }

    public function __sleep()
    {
        return array('color','type','colorNumber','colorHex');
    }

    /**
     * @return bool|string
     */
    public function getColorInfo(){
        if ($this->colorNumber && $this->color){
            return $this->color . ": " . $this->colorNumber;
        }
        return false;
    }
    
    public function __call($name, $arguments)
    {
        switch (true){
            case ($this instanceof Car):
                require 'Diagnostic/CarDiagnostic.php';
                $diagnostic = new CarDiagnostic($name, $arguments);
                return $diagnostic->runDiagnostic();
            case ($this instanceof Train):
                require 'Diagnostic/TrainDiagnostic.php';
                $diagnostic = new TrainDiagnostic($name,$arguments);
                return $diagnostic->runDiagnostic();
        }
        return false;
    }
}