package com.web.laptoptg.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAConfig {

    public static EntityManagerFactory emf;
    public static EntityManager em;

    public static EntityManager getEntityManager() {
        emf = Persistence.createEntityManagerFactory("jdbc");
        em = emf.createEntityManager();
        return em;
    }

    public static void shutdown(){
        if (em != null){
            em.close();
            emf.close();
        }
    }
}
