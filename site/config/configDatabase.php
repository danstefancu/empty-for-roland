<?php

return array(
    'dsn' => 'mysql:host=localhost;dbname=oop',
    'user' => 'root',
    'pass' => 'Kasamargit22',
    'autoloaderpaths' => array(
        'Classes',
        'Model'
    ),
    'Car' => array(
        'table_name' => 'Car',
        'id' => 'id INT(6) PRIMARY KEY AUTO_INCREMENT NOT NULL',
        'type' => ' name VARCHAR(50) UNIQUE NOT NULL',
        'model' => ' model Varchar(50) UNIQUE NOT NULL',
        'seat_capacity' => ' seat_capacity Varchar(50)',
        'engine_count' => ' engine_count VARCHAR(50)',
        'extras' => ' extras MEDIUMTEXT'
    )
);