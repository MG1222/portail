<?php

namespace Config;

use Exception;
use App\Model\AdminModel;

class DatabaseSetup {

    private \PDO $pdo;


    /**
         * Methode for connection
         */

        public function __construct() {

            $config = require_once "database.php";
            $this->pdo = new \PDO(
                "mysql:host={$config['host']};dbname={$config['dbname']};charset=utf8",
                $config['user'],
                $config['password']
            );


        }

    /**
     * Methode for verification if table role and admin exist
     * @return bool
     * @throws Exception
     */
    public function verifyDatabaseSetup(): bool
    {
        // step 1 = check if table admin and roles are created
        $requiredTables = ['admin', 'roles'];
        foreach ($requiredTables as $table) {
            $stmt = $this->pdo->query("SHOW TABLES LIKE '$table'");
            $result = $stmt->fetch();
            if (!$result) {
                throw new Exception("La table '$table' n'existe pas.");
            }
        }

        // step 2 = check if tables have data
        $stmt = $this->pdo->query("SELECT COUNT(*) as count FROM admin");
        $adminCount = $stmt->fetch()['count'];

        $stmt = $this->pdo->query("SELECT COUNT(*) as count FROM roles");
        $rolesCount = $stmt->fetch()['count'];
        if ($rolesCount == 0) {
            $model = new AdminModel;
            $mainAdmin = $model->createRolesMainAdminUser();
            throw new Exception("La table 'roles' est vide.");

        }
        if ($adminCount == 0) {
            $model = new AdminModel;
            $mainAdmin = $model->createMainAdmin();
            throw new Exception("La table 'admin' est vide.");

        }



        return true;
    }



    }
