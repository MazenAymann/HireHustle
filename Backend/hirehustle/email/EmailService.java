package com.example.hirehustle.email;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import org.springframework.stereotype.Service;

import java.util.Properties;

@Service
public class EmailService {

    public void sendEmail(String name, String email, String activationLink) {
        try {
            String subject = "Account Confirmation";
            String buttonStyles = "display: inline-block; background-color: black; color: #ffffff; text-decoration: none; font-weight: bold; padding: 10px 20px; border-radius: 5px; transition: background-color 0.3s;";
            String buttonHtml = "<a href=\"" + activationLink + "\" style=\"" + buttonStyles + "\">Activate Account</a>";
            String emailBodyStyles = "font-family: Arial, sans-serif; font-size: 14px; line-height: 1.5;";
            String body = "<div style=\"" + emailBodyStyles + "\">" +
                    "<p>Dear " + name + ",</p>" +
                    "<p>To activate your account, please click on the following button:</p>" +
                    "<p style=\"text-align: center;\">" + buttonHtml + "</p>" +
                    "</div>";
            String from = "hire.hustle1@gmail.com";
            String password = "ipozfcndqykqpslz";
            String host = "smtp.gmail.com";
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", "587");
            Session session = Session.getInstance(props,
                    new Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(from, password);
                        }
                    });
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from, false));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            msg.setSubject(subject);
            msg.setContent(body, "text/html; charset=utf-8");
            Transport.send(msg);

        } catch (MessagingException ex) {
            throw new RuntimeException(ex);
        }
    }

}
