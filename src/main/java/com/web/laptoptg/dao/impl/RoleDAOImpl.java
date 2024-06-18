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

    EntityManager entityManager;
    EntityTransaction transaction;

    public RoleDAOImpl() {
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
    }

    @Override
    public List<Role> getAllRoles() {
        entityManager.clear();
        TypedQuery<Role> query = entityManager.createQuery("FROM Role", Role.class);
        return query.getResultList();
    }

    @Override
    public Role getRoleByRoleName(String roleName) {
        try {
            TypedQuery<Role> query = entityManager.createQuery("FROM Role WHERE roleName = :roleName", Role.class);
            query.setParameter("roleName", roleName);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public Role getRoleById(int roleId) {
        return entityManager.find(Role.class, roleId);
    }
}
