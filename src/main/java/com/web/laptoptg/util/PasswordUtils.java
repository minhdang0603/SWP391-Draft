package com.web.laptoptg.util;

import org.mindrot.jbcrypt.BCrypt;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PasswordUtils {

    // use for auto generate password
    private static final String UPPERCASE_LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String LOWERCASE_LETTERS = "abcdefghijklmnopqrstuvwxyz";
    private static final String DIGITS = "0123456789";
    private static final int PASSWORD_LENGTH = 8;

    // Hash password to using bcrypt format with the salt
    public static String hash(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(10));
    }

    // verify hashing value
    public static boolean verify(String checkedPassword, String hashedPassword) {
        return BCrypt.checkpw(checkedPassword, hashedPassword);
    }

    public static String generatePassword() {
        SecureRandom random = new SecureRandom();

        // Ensure the password contains at least one uppercase letter and one special character
        StringBuilder password = new StringBuilder();
        password.append(UPPERCASE_LETTERS.charAt(random.nextInt(UPPERCASE_LETTERS.length())));
        password.append(DIGITS.charAt(random.nextInt(DIGITS.length())));

        // Fill the rest of the password with random characters from all categories
        String allCharacters = UPPERCASE_LETTERS + LOWERCASE_LETTERS + DIGITS;
        for (int i = 2; i < PASSWORD_LENGTH; i++) {
            password.append(allCharacters.charAt(random.nextInt(allCharacters.length())));
        }

        // Shuffle the characters to avoid predictable patterns
        return shuffleString(password.toString(), random);
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
