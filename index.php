<?php

use Library\Http\NotFoundException;
use Config\DatabaseSetup;
use App\Model\AdminModel;

try {

    ini_set('display_errors', 1);
    session_start();
    require 'helpers.php';

    // Autoloader
    spl_autoload_register(function ($className) {
        if (in_array($className, ['PDO'])) {
            return;
        }
        $fileName = str_replace('\\', '/', $className);
        if (strpos($className, 'Config\\') === 0) {
            require "config/" . substr($fileName, strpos($fileName, '/') + 1) . ".php";
        } else {
            require "src/$fileName.php";
        }
    });

    $adminModel = new AdminModel();
    if (!$adminModel->mainAdminRoleExists()) {
        $adminModel->createRolesMainAdminUser();
        if (!$adminModel->mainAdminExists()) {
            var_dump('hello');
            $adminModel->createMainAdmin();
        }
    }
    
    //  if user try to access a page not authorized, he is redirected to the home page
    $route = $_SERVER['PATH_INFO'] ?? '/';

    $routes = require 'config/routes.php';

    // if route exists
    if (isset($routes[$route])) {
        // if route is a class
        list($controllerName, $method) = $routes[$route];
        $controller = new $controllerName();
        $controller->$method();
    } else {
        // if route is not a class
        throw new NotFoundException("");
    }

    // if route doesn't exist
} catch (NotFoundException $e) {
    header("HTTP/1.1 404 Not Found");
    require 'src/App/View/404.phtml';
    error_log(date('d/m/Y H:i:s')." : ".$e->getMessage());
    exit();
} catch (Error $e) {
    header("HTTP/1.1 500 Internal Server Error");
    require 'src/App/View/500.phtml';
    error_log(date('d/m/Y H:i:s')." : ".$e->getMessage());
    exit();
} catch (Exception $e) {
    header("HTTP/1.1 500 Internal Server Error");
    require 'src/App/View/500.phtml';
    error_log(date('d/m/Y H:i:s')." : ".$e->getMessage());
    exit();
}
