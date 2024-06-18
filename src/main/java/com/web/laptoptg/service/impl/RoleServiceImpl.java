package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.RoleDAO;
import com.web.laptoptg.dao.impl.RoleDAOImpl;
import com.web.laptoptg.model.Role;
import com.web.laptoptg.service.RoleService;

import java.util.List;

public class RoleServiceImpl implements RoleService {

    private RoleDAO roleDAO = new RoleDAOImpl();

    public RoleServiceImpl() {
        roleDAO = new RoleDAOImpl();
    }

    @Override
    public List<Role> getAllRoles() {
        return roleDAO.getAllRoles();
    }

    @Override
    public Role getRoleByRoleName(String roleName) {
        return roleDAO.getRoleByRoleName(roleName);
    }

    @Override
    public Role getRoleByRoleId(int roleId) {
        return roleDAO.getRoleById(roleId);
    }
}
