<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once 'Classes/Car.php';
require_once 'Classes/Train.php';
require_once 'Classes/Plane.php';
require_once 'Classes/VehicleBase.php';
require_once 'Model/Model.php';
require_once 'Classes/OrderedList.php';

$car = new Car();

$car->setColor("Green")->setType("Sedan")->setColorNumber(14)->setColorHex("#FFFFF");

echo "My car is a " .  implode(" ",$car->getColorInfo()) . PHP_EOL . $car->getType() . "<br />";

$train = new Train();

$train->setColor("Red")->setType("Sw-42")->setSize("Absolutely Huge")->setColorNumber(22);

echo "But my train is " . $train->getColorInfo() . PHP_EOL .$train->getType() . " and it's size is " . $train->getSize() . "<br />";

$plane = new Plane();

$plane->setColor("White")->setType('Boeing 747')->setCapacity(650)->setColorNumber(24)->setHasFirstClass(true)->setHasBusinessClass(true)->setOperator("yes");

$echo = "Last but not least, my airplane is " . $plane->getColorInfo() . PHP_EOL . $plane->getType() . " and it's capacity is " . $plane->getCapacity();
if ($plane->hasFirstClass){
    $echo .= " and has a first class";
    }else null;
if($plane->hasBusinessClass){
    $echo .= " but also has a business class";
}else null;

echo $echo;

$car->hasSeatBelt = "no";
echo "<br /> Seat belt on: " . $car->hasSeatBelt . "<br /><br />";

$car->model = "Alfa";

if (isset($car->model)){
    echo "Model: " . $car->model . "<br />";
    unset($car->model);
}

$serializedObj = serialize($car);

echo $serializedObj;

$restoredCar = unserialize($serializedObj);

echo "Type is:" . $restoredCar->getType();

$orderedList = new OrderedList();

echo $orderedList($car());

$suv = clone $car;
echo "<br />" . $suv->getType() . "<br />";


$airliner = new Plane();
$airliner->setColor("Red")->setType('Canada Airliner')->setCapacity(250)->setColorNumber(21)->setHasFirstClass(false)->setHasBusinessClass(true)->setOperator("yes");

$echo = "My second airplane is: " . $airliner->getColorInfo() . PHP_EOL . $airliner->getType() . " and it's capacity is " . $airliner->getCapacity();
if ($airliner->hasFirstClass){
    $echo .= " and has a first class";
}else null;
if($airliner->hasBusinessClass){
    $echo .= " but also has a business class";
}else null;

echo $echo;