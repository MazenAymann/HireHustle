package com.example.hirehustle.users.Applicant;

import com.example.hirehustle.jobPosts.JobPostService;
import com.example.hirehustle.users.Responses.Login.LoginResponse;
import com.example.hirehustle.users.Responses.Registration.RegistrationResponse;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/applicant")
@RequiredArgsConstructor
@CrossOrigin("*")
public class ApplicantController {

    private final ApplicantService applicantService;
    private final JobPostService jobPostService;
    private final Gson gson = new Gson();

    @PostMapping("/register")
    public String applicantRegister(@RequestBody Applicant applicant) {
        RegistrationResponse registrationResponse = applicantService.register(applicant);
        return gson.toJson(registrationResponse.mapToArrangeGson());
    }

    @PostMapping("/login")
    public String applicantLogin(@RequestBody Applicant applicant) {
        LoginResponse loginResponse = applicantService.login(applicant);
        return gson.toJson(loginResponse.mapToArrangeGson());
    }

    @GetMapping("/confirmToken")
    public String confirmToken(@RequestParam("token") String token) {
        return applicantService.confirmToken(token);
    }

    @PostMapping("/apply/{jobPostId}")
    public void applyForJob(@PathVariable Long jobPostId, @RequestBody Applicant applicant) throws Exception {
        jobPostService.applyForJob(jobPostId, applicant.getId());
    }

    @PostMapping("/editApplicantInfo")
    public void editApplicantInfo(@RequestBody Applicant applicant) throws Exception {
        applicantService.editApplicantInfo(applicant);
    }

    @PostMapping("/changeApplicantPassword/{ApplicantId}")
    public void changeApplicantPassword(@PathVariable Long ApplicantId,
                                        @RequestBody Applicant applicant){
        applicantService.changeApplicantPassword(ApplicantId,applicant.getPassword());
    }
}
