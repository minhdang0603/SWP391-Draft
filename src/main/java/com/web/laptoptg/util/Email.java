package com.web.laptoptg.util;

import com.web.laptoptg.dto.UserDTO;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeUtility;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

public class Email {
    final String FROM_EMAIL = "laptoptg2024@gmail.com";
    final String PASSWORD = "vtbl xtlc shkw ksxf";

    // send otp code
    public boolean sendEmail(UserDTO user, String title, String content){
        boolean test = false;

        String toEmail = user.getEmail();


        try {
            Properties props = configEmail(new Properties());
            // get sesssion to authenticate the host email address and password
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
                }
            });

            // set email message details
            Message message = new MimeMessage(session);

            message.setHeader("Content-Type", "text/html; charset=UTF-8");

            // set from email address
            message.setFrom(new InternetAddress(FROM_EMAIL));

            // set to email address or destination email address
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));

            // set email subject
            message.setSubject(MimeUtility.encodeText(title, "UTF-8", "B"));

            // set message text
            message.setContent(content, "text/html; charset=UTF-8");

            // send the message
            Transport.send(message);
            test = true;
        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
        return test;
    }

    // your host email smtp server details
    private Properties configEmail(Properties properties){
        properties.setProperty("mail.smtp.host", "smtp.gmail.com");
        properties.setProperty("mail.smtp.port", "587");
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.socketFactory.port", "587");
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        return properties;
    }
}
