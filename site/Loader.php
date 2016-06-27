<?php

class Loader
{
  public static function init(){
      spl_autoload_extensions('.php');
      foreach(ObjectFatoryService::getConfig()['autoloaderpaths'] as $path){
          set_include_path(get_include_path() . PATH_SEPARATOR . __DIR__ . DIRECTORY_SEPARATOR . $path .DIRECTORY_SEPARATOR);
      }

      spl_autoload_register();
  }
}