<?php

/**
 * Class ExampleSuperClass
 */
class ExampleSuperClass
{
    public $something;

    /**
     * @param $something
     */
    public function setSomething($something)
    {
        $this->something = $something;
    }

    /**
     * @return mixed
     */
    final public function getSomething()
    {
        return $this->something;
    }
}

class ExampleSubclass extends ExampleSuperClass{
    public function setSomething($something)
    {
      return $this->something;
    }
}