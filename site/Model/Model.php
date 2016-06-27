<?php

class Model
{
    public static $pdo;

    public static function connection($config){
        try {
            $pdo = new PDO($config['dsn'], $config['user'], $config['pass']);
        }catch (PDOException $e){
            echo "Fatal error connecting: " . $e->getMessage();
        }
        return $pdo;
    }

    public static function createTable($config){
        try{
            $sql = 'CREATE TABLE IF NOT EXISTS ' . $config['Car']['table_name'] .' (';
            foreach($config['Car'] as $value){
                $sql .= $value . " , ";
              }
            $sql .= ")";
            self::$pdo->prepare($sql)->execute();
        }catch (PDOException $e){
            echo "Fatal error: " . $e->getMessage();
        }
    }

}