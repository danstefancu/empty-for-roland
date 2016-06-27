<?php


class ObjectFactoryService
{
    public static function getConfig(){
        return require_once '../config/configDatabase.php';
    }
}