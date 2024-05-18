package com.web.laptoptg.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class PasswordEncrypt {

    public static final String SALT = "4UGYpILSejCHw52lbkSGWg==";

    // Hash password to SHA-256 format with the salt
    public static String encryptPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(Base64.getDecoder().decode(SALT)); // Decode the salt from Base64 to bytes
        byte[] hash = md.digest(password.getBytes());
        return Base64.getEncoder().encodeToString(hash); // Encode the hash to Base64
    }
}
