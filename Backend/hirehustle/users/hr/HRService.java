package com.example.hirehustle.users.hr;

import com.example.hirehustle.email.EmailService;
import com.example.hirehustle.jobPosts.JobPost;
import com.example.hirehustle.jobPosts.JobPostService;
import com.example.hirehustle.token.Token;
import com.example.hirehustle.token.TokenService;
import com.example.hirehustle.token.TokenType;
import com.example.hirehustle.users.Applicant.Applicant;
import com.example.hirehustle.users.Applicant.ApplicantService;
import com.example.hirehustle.users.Person.Person;
import com.example.hirehustle.users.Person.UserService;
import com.example.hirehustle.users.Responses.Login.LoginFailedResponse;
import com.example.hirehustle.users.Responses.Login.LoginResponse;
import com.example.hirehustle.users.Responses.Login.LoginSuccessResponse;
import com.example.hirehustle.users.Responses.Registration.RegistrationFailedResponse;
import com.example.hirehustle.users.Responses.Registration.RegistrationResponse;
import com.example.hirehustle.users.Responses.Registration.RegistrationSuccessResponse;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpHeaders;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class HRService {

    private final UserService userService;
    private final TokenService tokenService;
    private final HRRepository hrRepository;
    private final EmailService emailService;
    private final JobPostService jobPostService;
    private final ApplicantService applicantService;

    public List<HR> getAllHRs() {
        return hrRepository.findAll();
    }

    @Transactional
    public RegistrationResponse register(HR hr) {

        RegistrationResponse registrationResponse;

        // If hr is stored and activated.
        if (isExist(hr.getUsername(), hr.getEmail())) {
            HR hrData = hrRepository.getByUsername(hr.getUsername());
            if (hrData.isActivated()) {
                String message = "Email or Username is already taken.";
                registrationResponse = new RegistrationFailedResponse("failed", message);
                return registrationResponse;
            }
        }
        // If hr is not exist at all.
        else if (! isExist(hr.getUsername(), hr.getEmail())) {
            userService.saveUser(new Person(hr.getUsername(), hr.getEmail()));
            Token token = tokenService.generateAuthorizationToken(null, hr);
            String activationLink = "http://localhost/api/v1/hr/confirmToken?token=" + token.getToken();
//            while (true) {
//                try {
//                    emailService.sendEmail(hr.getUsername(), hr.getEmail(), activationLink);
//                    break;
//                }catch (Exception e){
//                    System.out.println(e.getMessage());
//                }
//            }
            hr.setTokens(token);
            tokenService.saveToken(token);
            hrRepository.save(hr);
            String data = "Registration success, please check your mail.";
            registrationResponse = new RegistrationSuccessResponse("success", data);
            return registrationResponse;
        }
        // If hr is stored but not activated.
        HR savedHr = hrRepository.getByUsername(hr.getUsername());
        Token token = tokenService.getToken(getAuthorizationToken(savedHr));
        String activationLink = "http://localhost/api/v1/hr/confirmToken?token=" + token.getToken();
//            while (true) {
//                try {
//                    emailService.sendEmail(hr.getUsername(), hr.getEmail(), activationLink);
//                    break;
//                }catch (Exception e){
//                    System.out.println(e.getMessage());
//                }
//            }
        String data = "Please check your mail to activate your account.";
        registrationResponse = new RegistrationSuccessResponse("success", data);
        return registrationResponse;
    }

    public boolean isExist(String username, String email) {
        return userService.isExist(username, email);
    }

    public String getAuthorizationToken(HR hr) {
        List<Token> tokens = hr.getTokens();
        for (Token token : tokens) {
            if (token.getTokenType() == TokenType.Authorization) {
                return token.getToken();
            }
        }
        return null;
    }

    public void enableHR(String email) {
        HR hr = hrRepository.getByEmail(email);
        hr.setEnabled(true);
        hrRepository.save(hr);
    }

    public void disableHR(String email) {
        HR hr = hrRepository.getByEmail(email);
        hr.setEnabled(false);
        hrRepository.save(hr);
    }

    @Transactional
    public String confirmToken(String token) {
        String result = tokenService.confirmToken(token);
        if (result.equals("confirmed")) {
            Token confirmationToken = tokenService.getToken(token);
            activateHR(confirmationToken.getHr().getEmail());
        }
        return result;
    }

    public void activateHR(String email) {
        HR hr = hrRepository.getByEmail(email);
        hr.setActivated(true);
        hrRepository.save(hr);
    }

    @Transactional
    public LoginResponse hrLogin(HR hr) {
        LoginResponse response;
        if (! dataIsValid(hr.getUsername(), hr.getPassword())) {
            String message = "The password or username that you have entered is incorrect.";
            response = new LoginFailedResponse("failed", message);
            return response;
        }
        HR hr1 = hrRepository.getByUsername(hr.getUsername());
        if (hr1.isActivated()) {
            Token token = tokenService.generateAccessToken(null, hr1);
            tokenService.saveToken(token);
            Map<String, Object> data = new HashMap<>();
            data.put("token", token.getToken());
            response = new LoginSuccessResponse("success", data, hr1, null);
            return response;
        }
        if (! hr1.isEnabled()) {
            return new LoginFailedResponse("failed", "Sorry, Your account is disabled by admin.");
        }
        return new LoginFailedResponse("failed", "Sorry, Account is not activated.");
    }

    @Transactional
    public boolean dataIsValid(String username, String password) {
        return hrRepository.dataIsValid(username, password).isPresent();
    }

    public void makeRecommendations(Long jobPostId) throws Exception {
     //   List<Applicant> applicants = applyService.getApplicantsForJob(jobPostId).jsonData()["data"];
//        Set<Applicant> applicants = jobPostService.getApplicantsForJob(jobPostId);
        JobPost jobPost = jobPostService.getJobPost(jobPostId);
//        List<byte[]> cvs = applicants.stream().map(Applicant::getCv).toList();

        Map<String, Object> json = new HashMap<>();
        Map<String, Object> jobPostJson = new HashMap<>();
        jobPostJson.put("jobDescription", jobPost.getJobDescription());
        jobPostJson.put("jobRequirements", jobPost.getJobRequirements());

        json.put("jobPost", jobPostJson);
//        json.put("cvs", cvs);

        callTheMachineLearningModel(json);
    }

    public void callTheMachineLearningModel(Map<String, Object> json) throws IOException, InterruptedException {
        // Convert the JSON payload to a string
        ObjectMapper objectMapper = new ObjectMapper();
        String requestBody = objectMapper.writeValueAsString(json);

        // Set up the HTTP client
        HttpClient httpClient = HttpClient.newHttpClient();

        // Set up the HTTP request
        HttpRequest httpRequest = HttpRequest.newBuilder()
                .uri(URI.create("https://example.com/api/recommendations")) // Replace with your actual API endpoint
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                .build();

        // Send the HTTP request and receive the response
        HttpResponse<String> httpResponse = httpClient.send(httpRequest, HttpResponse.BodyHandlers.ofString());
        int statusCode = httpResponse.statusCode();
        HttpHeaders headers = httpResponse.headers();
        String responseBody = httpResponse.body();
    }

    @Transactional
    public void editApplicantInfo(HR hr) {
        hr.setActivated(true);
        hrRepository.save(hr);
    }

    @Transactional
    public void changeHrPassword(Long hrId, String newPassword) throws Exception {
        HR hr = hrRepository.findById(hrId)
                .orElseThrow(() -> new Exception("There is no hr by this id."));
        hr.setPassword(newPassword);
        hrRepository.save(hr);
    }

    @Transactional
    public void disableHr(Long hrId) {
        HR hr = hrRepository.getHrById(hrId);
        hr.setEnabled(false);
        hrRepository.save(hr);
    }

    public void enableHr(Long hrId) {
        HR hr = hrRepository.getHrById(hrId);
        hr.setEnabled(true);
        hrRepository.save(hr);
    }

    public void inActiveHr(Long hrId) {
        HR hr = hrRepository.getHrById(hrId);
        hr.setActivated(false);
        hrRepository.save(hr);
    }

    public void activeHr(Long hrId) {
        HR hr = hrRepository.getHrById(hrId);
        hr.setActivated(true);
        hrRepository.save(hr);
    }
}
