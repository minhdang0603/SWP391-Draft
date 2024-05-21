package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.RoleDAO;
import com.web.laptoptg.model.Role;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class RoleDAOImpl implements RoleDAO {

    @Override
    public List<Role> getAllRoles() {
        EntityManager entityManager = JPAConfig.getEntityManager();
        TypedQuery<Role> query = entityManager.createQuery("from Role", Role.class);
        return query.getResultList();
    }

    @Override
    public Role getRoleByRoleName(String roleName) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        Role role = entityManager.find(Role.class, roleName);
        return role;
    }
}
