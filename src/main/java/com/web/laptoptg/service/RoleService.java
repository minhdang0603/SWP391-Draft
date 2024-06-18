package com.web.laptoptg.service;

import com.web.laptoptg.model.Role;

import java.util.List;

public interface RoleService {
    List<Role> getAllRoles();
    Role getRoleByRoleName(String roleName);
    Role getRoleByRoleId(int roleId);
}
