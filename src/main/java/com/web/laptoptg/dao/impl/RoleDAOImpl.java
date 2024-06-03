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

    private EntityManager entityManager;
    private EntityTransaction transaction;

    public RoleDAOImpl(){
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
    }

    @Override
    public List<Role> getAllRoles() {
        TypedQuery<Role> query = entityManager.createQuery("from Role", Role.class);
        return query.getResultList();
    }

    @Override
    public Role getRoleByRoleName(String roleName) {
        TypedQuery<Role> query = entityManager.createQuery("from Role where roleName = :roleName", Role.class);
        query.setParameter("roleName", roleName);
        Role role = null;
        try {
            role = query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
        return role;
    }
}
