package com.web.laptoptg.dao;

import com.web.laptoptg.model.Role;

import java.util.List;

public interface RoleDAO {
    List<Role> getAllRoles();
    Role getRoleByRoleName(String roleName);
    Role getRoleById(int roleId);
}
