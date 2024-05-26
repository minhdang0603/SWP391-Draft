package com.web.laptoptg.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PasswordUtil {

    // use for encode password
    private static final String SALT = "4UGYpILSejCHw52lbkSGWg==";

    // use for auto generate password
    private static final String UPPERCASE_LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String LOWERCASE_LETTERS = "abcdefghijklmnopqrstuvwxyz";
    private static final String DIGITS = "0123456789";
    private static final String SPECIAL_CHARACTERS = "!@#$%^&*()-_=+<>?";
    private static final int PASSWORD_LENGTH = 8;

    // Hash password to SHA-256 format with the salt
    public static String encryptToSHA256(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(Base64.getDecoder().decode(SALT)); // Decode the salt from Base64 to bytes
        byte[] hash = md.digest(password.getBytes());
        return Base64.getEncoder().encodeToString(hash); // Encode the hash to Base64
    }

    // validate password match the pattern
    public static boolean passwordValidate(String password) {
        // regex for password
        // length at least 8 character
        // contain at least 1 uppercase
        // contain at least 1 specail character
        String regexPattern = "^(?=.*[A-Z])(?=.*\\d)(?=.*[\\W_]).{8,}$";

        // compile regex pattern
        Pattern pattern = Pattern.compile(regexPattern);

        // create matcher object
        Matcher matcher = pattern.matcher(password);

        return matcher.matches();
    }

    public static String generatePassword(int length) {
        SecureRandom random = new SecureRandom();

        // Ensure the password contains at least one uppercase letter and one special character
        StringBuilder password = new StringBuilder();
        password.append(UPPERCASE_LETTERS.charAt(random.nextInt(UPPERCASE_LETTERS.length())));
        password.append(DIGITS.charAt(random.nextInt(DIGITS.length())));
        password.append(SPECIAL_CHARACTERS.charAt(random.nextInt(SPECIAL_CHARACTERS.length())));

        // Fill the rest of the password with random characters from all categories
        String allCharacters = UPPERCASE_LETTERS + LOWERCASE_LETTERS + DIGITS;
        for (int i = 2; i < length; i++) {
            password.append(allCharacters.charAt(random.nextInt(allCharacters.length())));
        }

        // Shuffle the characters to avoid predictable patterns
        return shuffleString(password.toString(), random);
    }

    // verify hashing value
    public static boolean verify(String password, String hashedPassword) throws NoSuchAlgorithmException {
        return encryptToSHA256(password).equals(hashedPassword);
    }

    // shuffle the character
    private static String shuffleString(String input, SecureRandom random) {
        char[] characters = input.toCharArray();
        for (int i = characters.length - 1; i > 0; i--) {
            int index = random.nextInt(i + 1);
            // Simple swap
            char temp = characters[index];
            characters[index] = characters[i];
            characters[i] = temp;
        }
        return new String(characters);
    }
}
