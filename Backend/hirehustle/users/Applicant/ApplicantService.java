package com.example.hirehustle.users.Applicant;

import com.example.hirehustle.email.EmailService;
import com.example.hirehustle.token.Token;
import com.example.hirehustle.token.TokenService;
import com.example.hirehustle.token.TokenType;
import com.example.hirehustle.users.Person.Person;
import com.example.hirehustle.users.Person.UserService;
import com.example.hirehustle.users.Responses.Login.LoginFailedResponse;
import com.example.hirehustle.users.Responses.Login.LoginResponse;
import com.example.hirehustle.users.Responses.Login.LoginSuccessResponse;
import com.example.hirehustle.users.Responses.Registration.RegistrationFailedResponse;
import com.example.hirehustle.users.Responses.Registration.RegistrationResponse;
import com.example.hirehustle.users.Responses.Registration.RegistrationSuccessResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ApplicantService {

    private final UserService userService;
    private final TokenService tokenService;
    private final ApplicantRepository applicantRepository;
    private final EmailService emailService;

    public List<Applicant> getAllApplicants() {
        return applicantRepository.findAll();
    }

    @Transactional
    public RegistrationResponse register(Applicant applicant) {

        RegistrationResponse registrationResponse;

        // If applicant is stored and activated.
        if (isExist(applicant.getUsername(), applicant.getEmail())) {
            Applicant applicantData = applicantRepository.getByUsername(applicant.getUsername());
            if (applicantData.isActivated()) {
                String message = "Email or Username is already taken.";
                registrationResponse = new RegistrationFailedResponse("failed", message);
                return registrationResponse;
            }
        }
        // If applicant is not exist at all.
        else if (! isExist(applicant.getUsername(), applicant.getEmail())) {
            userService.saveUser(new Person(applicant.getUsername(), applicant.getEmail()));
            Token token = tokenService.generateAuthorizationToken(applicant, null);
            String activationLink = "http://localhost:8080/api/v1/applicant/confirmToken?token=" + token.getToken();
//            while (true) {
//                try {
//                    emailService.sendEmail(applicant.getUsername(), applicant.getEmail(), activationLink);
//                    break;
//                }catch (Exception e){
//                    System.out.println(e.getMessage());
//                }
//            }
            applicant.setTokens(token);
            tokenService.saveToken(token);
            applicantRepository.save(applicant);
            String data = "Registration success, please check your mail.";
            registrationResponse = new RegistrationSuccessResponse("success", data);
            return registrationResponse;
        }
        // If applicant is stored but not activated.
        Applicant savedApplicant = applicantRepository.getByUsername(applicant.getUsername());
        Token token = tokenService.getToken(getAuthorizationToken(savedApplicant));
        String activationLink = "http://localhost:8080/api/v1/applicant/confirmToken?token=" + token.getToken();
//        while (true) {
//            try {
//                emailService.sendEmail(applicant.getUsername(), applicant.getEmail(), activationLink);
//                break;
//            }catch (Exception e){
//                System.out.println(e.getMessage());
//            }
//        }
        String data = "Please check your mail to activate your account.";
        registrationResponse = new RegistrationSuccessResponse("success", data);
        return registrationResponse;
    }

    public boolean isExist(String username, String email) {
        return userService.isExist(username, email);
    }

    public void enableApplicant(String email) {
        Applicant applicant = applicantRepository.getByEmail(email);
        applicant.setEnabled(true);
        applicantRepository.save(applicant);
    }

    public void disableApplicant(String email) {
        Applicant applicant = applicantRepository.getByEmail(email);
        applicant.setEnabled(false);
        applicantRepository.save(applicant);
    }

    public String getAuthorizationToken(Applicant applicant) {
        List<Token> tokens = applicant.getTokens();
        for (Token token : tokens) {
            if (token.getTokenType() == TokenType.Authorization) {
                return token.getToken();
            }
        }
        return null;
    }

    @Transactional
    public String confirmToken(String token) {
        String result = tokenService.confirmToken(token);
        if (result.equals("confirmed")) {
            Token confirmationToken = tokenService.getToken(token);
            activateApplicant(confirmationToken.getApplicant().getEmail());
        }
        return result;
    }

    public void activateApplicant(String email) {
        Applicant applicant = applicantRepository.getByEmail(email);
        applicant.setActivated(true);
        applicantRepository.save(applicant);
    }

    @Transactional
    public LoginResponse login(Applicant applicant) {
        LoginResponse response;
        if (! dataIsValid(applicant.getUsername(), applicant.getPassword())) {
            String message = "The password or username that you have entered is incorrect.";
            response = new LoginFailedResponse("failed", message);
            return response;
        }
        Applicant applicant1 = applicantRepository.getByUsername(applicant.getUsername());
        if (applicant1.isActivated()) {
            Token token = tokenService.generateAccessToken(applicant1, null);
            tokenService.saveToken(token);
            Map<String, Object> data = new HashMap<>();
            data.put("token", token.getToken());
            response = new LoginSuccessResponse("success", data,null, applicant1);
            return response;
        }
        if (!applicant1.isEnabled()){
            return new LoginFailedResponse("failed", "Sorry, Your account is disabled by admin.");
        }
        return new LoginFailedResponse("failed", "Sorry, Account is not activated.");
    }

    @Transactional
    public boolean dataIsValid(String username, String password) {
        return applicantRepository.dataIsValid(username, password).isPresent();
    }

    @Transactional
    public void editApplicantInfo( Applicant applicant) {
        applicant.setActivated(true);
        applicantRepository.save(applicant);
    }

    @Transactional
    public void changeApplicantPassword(Long applicantId, String newPassword) {
        Applicant applicant = applicantRepository.getApplicantById(applicantId);
        applicant.setPassword(newPassword);
        applicantRepository.save(applicant);
    }

    @Transactional
    public void disableApplicant(Long applicantId) {
        Applicant applicant = applicantRepository.getApplicantById(applicantId);
        applicant.setEnabled(false);
        applicantRepository.save(applicant);
    }

    @Transactional
    public void enableApplicant(Long applicantId) {
        Applicant applicant = applicantRepository.getApplicantById(applicantId);
        applicant.setEnabled(true);
        applicantRepository.save(applicant);
    }

    public void inActiveApplicant(Long applicantId) {
        Applicant applicant = applicantRepository.getApplicantById(applicantId);
        applicant.setActivated(true);
        applicantRepository.save(applicant);
    }

    public void activeApplicant(Long applicantId) {
        Applicant applicant = applicantRepository.getApplicantById(applicantId);
        applicant.setActivated(false);
        applicantRepository.save(applicant);
    }
}
