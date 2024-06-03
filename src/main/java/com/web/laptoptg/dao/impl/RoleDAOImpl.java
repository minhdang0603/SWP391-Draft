package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.RoleDAO;
import com.web.laptoptg.model.Role;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class RoleDAOImpl implements RoleDAO {

    @Override
    public List<Role> getAllRoles() {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            TypedQuery<Role> query = entityManager.createQuery("FROM Role", Role.class);
            return query.getResultList();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public Role getRoleByRoleName(String roleName) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            TypedQuery<Role> query = entityManager.createQuery("FROM Role WHERE roleName = :roleName", Role.class);
            query.setParameter("roleName", roleName);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }
}
