<?php

trait Airliner{
    public $hasFirstClass = false;
    public $hasBusinessClass = false;
    public $operator;

    /**
     * @param $hasFirstClass
     * @return $this
     */
    public function setHasFirstClass($hasFirstClass)
    {
        $this->hasFirstClass = $hasFirstClass;
        return $this;
    }

    /**
     * @param $hasBusinessClass
     * @return $this
     */
    public function setHasBusinessClass($hasBusinessClass)
    {
        $this->hasBusinessClass = $hasBusinessClass;
        return  $this;
    }

    /**
     * @param $operator
     * @return $this
     */
    public function setOperator($operator)
    {
        $this->operator = $operator;
        return $this;
    }
}