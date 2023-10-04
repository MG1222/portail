<?php

namespace App\Model;

use Library\Core\AbstractModel;

class AdminModel extends AbstractModel
{


    /**
     *Method for verifies if role main_admin exist
     * @return bool
     */
    public function mainAdminRoleExists(): bool {
        $roleAdmin = $this->db->getResults('SELECT * FROM `roles` WHERE `name` = "main_admin";');
        return !empty($roleAdmin);
    }

    /**
     * Methode for create role main_admin
     * @return ?int
     */
    public function createRolesMainAdminUser(): void {
        if (!$this->mainRoleExists()) {
            $this->db->execute('INSERT IGNORE INTO `roles` (id, name, type_project) VALUES (1 ,"main_admin", "ALL");');
        }
        if (!$this->userRoleExists()) {
            $this->db->execute('INSERT IGNORE INTO `roles` (id, name, type_project) VALUES (2, "user", "Utilisateur");');
        }
    }
    public function mainRoleExists(): bool {
        $result = $this->db->getResults('SELECT 1 FROM `roles` WHERE `name` = "main_admin" LIMIT 1;');
        return !empty($result);
    }

    public function userRoleExists(): bool {
        $result = $this->db->getResults('SELECT 1 FROM `roles` WHERE `name` = "Utilisateur" LIMIT 1;');
        return !empty($result);
    }



    /**
     * Methode for verifies if main admin exits
     * @return bool
     */
    public function mainAdminExists(): bool {
        $admin = $this->db->getResults('SELECT * FROM `admin` WHERE `role_id` = 1;');
        return !empty($admin);
    }

    /**
     *Methode for the creat main admin
     * @return ?int
     */
    public function createMainAdmin(): ?int {
        if (!$this->mainAdminRoleExists()) {
            $this->createRolesMainAdminUser();
        }

        if (!$this->mainAdminExists()) {
            $hashedPassword = password_hash('admin', PASSWORD_DEFAULT);
            $roleRows = $this->db->getResults('SELECT id FROM `roles` WHERE `name` = "main_admin"');

            // vérifiez si $roleRows est non vide et est un tableau
            if (!empty($roleRows) && is_array($roleRows)) {
                $roleId = $roleRows[0]['id'];  // Accédez à la première ligne, puis à la colonne 'id'

                // maintenant $roleId devrait être un entier, pas un tableau
                $adminId =  $this->db->execute('INSERT IGNORE INTO  `admin` (email, password, firstName, lastName, role_id) VALUES ("mainAdmin@email.com", :password, "Main", "Admin", :role_id);', [
                    'password' => $hashedPassword,
                    'role_id' => $roleId
                ]);
            } else {
                // Gérer l'erreur si $roleRows est vide ou n'est pas un tableau
                error_log('Erreur : Aucun rôle trouvé ou format de réponse inattendu de getResults.');
                return null;
            }
        }
        // Vérifiez si le record admin a été inséré avec succès
        if (empty($adminId)) {
            return null;
        }
        return $adminId;
    }








    public function createAdmin (array $data, int $role_id): ?int
    {

        // Insert the new admin record
        $adminId = $this->db->execute('INSERT IGNORE INTO  `admin` (email, password, firstName, lastName, role_id) VALUES (:email, :password, :firstName, :lastName, :role_id);', [
            'email' => $data['email'],
            'password' => $data['password'],
            'firstName' => $data['firstName'],
            'lastName' => $data['lastName'],
            'role_id' => $role_id
        ]);

        // Check if the admin record was inserted successfully
        if (empty($adminId)) {
            return null;
        }

        return $adminId;
    }


    public function findAdminById (int $id): ?array
    {
        $user = $this->db->getResults('SELECT * FROM `admin` WHERE `id` = :id;', [
            'id' => $id
        ]);
        if (!$user) {
            return null;
        }
        return $user[0];
    }

    public function findAdminByEmail (string $email): ?array
        {
            $user = $this->db->getResults('SELECT * FROM `admin` WHERE `email` = :email;', [
                'email' => $email
            ]);
            if (!$user) {
                return null;
            }
            return $user[0];
        }


    public function getRoles (): array
    {
        return $this->db->getResults('SELECT * FROM `roles` ORDER BY `name` ASC;');
    }
    /**
     * Get all users
     * @return array
     */

    public function getAllUsers(): array
    {
        $users = $this->db->getResults('SELECT id, email, firstName, lastName, role_id FROM users ORDER BY id DESC;');
        if (!$users) {
            return [];
        }
        return $users;
    }


    public function createRole(array $data): ?int
    {
        $role_id = $this->db->execute('INSERT INTO `roles` (name, type_project) VALUES (:name, :type_project);', [
            'name' => $data['name'],
            'type_project' => $data['type_project']
        ]);
        if (!$role_id) {
            return null;
        }
        return $role_id;
    }

    public function updateResetTokenAdmin(mixed $id, string|null $token, string|null $date): void
    {
        $this->db->execute('UPDATE admin SET reset_token = :token, reset_token_expiry = :date WHERE id = :id', [
            'token' => $token,
            'date' => $date,
            'id' => $id
        ]);
    }


    public function updatePasswordAdmin(mixed $id, string $password_hash): void
    {
        $this->db->execute('UPDATE admin SET password = :password WHERE id = :id', [
            'password' => $password_hash,
            'id' => $id
        ]);
    }




    public function findAdminByResetToken(mixed $token)
    {
        $admin = $this->db->getResults(
            sql: 'SELECT * FROM admin WHERE reset_token = :token AND reset_token_expiry >= NOW()',
            parameters: ['token' => $token]
        );
        if (empty($admin)) {
            return null;
        }
        return $admin[0];
    }

    public function getAllAdmins(): array
    {
        $admins = $this->db->getResults('SELECT id, email, firstName, lastName, role_id  FROM `admin` ORDER BY `id` DESC;');
        if (!$admins) {
            return [];
        }
        return $admins;
    }

    public function getRoleById(mixed $role_id)
    {
        $role = $this->db->getResults('SELECT * FROM `roles` WHERE `id` = :id;', [
            'id' => $role_id
        ]);
        if (!$role) {
            return null;
        }
        return $role[0];
    }

    public function getAdminById(mixed $admin_id)
    {
        $admin = $this->db->getResults('SELECT * FROM `admin` WHERE `id` = :id;', [
            'id' => $admin_id
        ]);
        if (!$admin) {
            return null;
        }
        return $admin[0];
    }

    public function getUserById(int $id): ?array
    {
        $user = $this->db->getResults('SELECT * FROM `users` WHERE `id` = :id;', [
            'id' => $id
        ]);
        if (!$user) {
            return null;
        }
        return $user[0];
    }




    public function updateAdmin(mixed $id, array $array): void
    {
       $this->db->execute('UPDATE admin SET email = :email, firstName = :firstName, lastName = :lastName, role_id = :role_id WHERE id = :id', [
            'email' => $array['email'],
            'firstName' => $array['firstName'],
            'lastName' => $array['lastName'],
            'role_id' => $array['role_id'],
            'id' => $id
        ]);


    }

    public function getAllRoles(): array
    {
        $roles = $this->db->getResults('SELECT * FROM `roles` ORDER BY `id` DESC;');
        if (!$roles) {
            return [];
        }
        return $roles;
    }

    public function getAllRolesName(): array
    {
        $roles = $this->db->getResults('SELECT id, type_project FROM roles WHERE type_project NOT IN ("name", "user", "ALL")');

        // Convert the array to an associative array with id as keys and type_project as values
        $rolesName = array_combine(array_column($roles, 'id'), array_column($roles, 'type_project'));

        return $rolesName;
    }

    public function deleteUser(mixed $user_id): void
    {
        $this->db->execute('DELETE FROM `users` WHERE `id` = :id;', [
            'id' => $user_id
        ]);
    }

    public function deleteAdmin(mixed $admin_id): void
    {
        $this->db->execute('DELETE FROM `admin` WHERE `id` = :id;', [
            'id' => $admin_id
        ]);
    }




}
