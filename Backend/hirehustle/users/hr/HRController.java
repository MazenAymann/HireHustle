package com.example.hirehustle.users.hr;

import com.example.hirehustle.jobPosts.JobPost;
import com.example.hirehustle.jobPosts.JobPostService;
import com.example.hirehustle.users.Applicant.Applicant;
import com.example.hirehustle.users.Responses.JobPosts.JobPostAdditionResponse;
import com.example.hirehustle.users.Responses.Login.LoginResponse;
import com.example.hirehustle.users.Responses.Registration.RegistrationResponse;
import com.example.hirehustle.users.Responses.Response;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Set;

@RestController
@RequestMapping("/api/v1/hr")
@RequiredArgsConstructor
@CrossOrigin("*")
public class HRController {

    private final HRService hrService;
    private final JobPostService jobPostService;

    private final Gson gson = new Gson();

    @PostMapping("/register")
    public String HrRegister(@RequestBody HR hr){
        RegistrationResponse registrationResponse = hrService.register(hr);
        return gson.toJson(registrationResponse.mapToArrangeGson());
    }

    @PostMapping("/login")
    public String HrLogin(@RequestBody HR hr){
        LoginResponse loginResponse = hrService.hrLogin(hr);
        return gson.toJson(loginResponse.mapToArrangeGson());
    }

    @GetMapping("/confirmToken")
    public String confirmToken(@RequestParam("token") String token){
        return hrService.confirmToken(token);
    }

    @PostMapping("/createJobPost/{hrId}")
    public Map<String, Object> createJobPost(@PathVariable Long hrId ,@RequestBody JobPost jobPost){
        JobPostAdditionResponse response = jobPostService.createJobPost(jobPost,hrId);
        return response.mapToArrangeGson();
    }

    @PostMapping("/makeRecommendations/{jobPostId}")
    public void makeRecommendations(@PathVariable Long jobPostId) throws Exception {
        hrService.makeRecommendations(jobPostId);
    }

    @PostMapping("/editHrInfo")
    public void editHrInfo(@RequestBody HR hr) throws Exception {
        hrService.editApplicantInfo(hr);
    }

    @PostMapping("/changeHrPassword/{hrId}")
    public void changeHrPassword(@PathVariable Long hrId,
                                 @RequestBody HR hr) throws Exception {
        hrService.changeHrPassword(hrId, hr.getPassword());
    }

    @PostMapping("/editJobPost/{hrId}")
    public void editJobPost(@PathVariable Long hrId,@RequestBody JobPost jobPost){
        jobPostService.editJobPost(jobPost,hrId);
    }

    @DeleteMapping("/deleteJobPost/{jobPostId}")
    public void deleteJobPost(@PathVariable Long jobPostId) throws Exception {
        jobPostService.deleteJobPost(jobPostId);
    }

    @GetMapping("/getAllApplicants/{jobPostId}")
    public Map<String, Object> getAllApplicants(@PathVariable Long jobPostId) throws Exception {
        Response response = jobPostService.getApplicantsForJob(jobPostId);
        return response.jsonData();

    }

    @GetMapping("/getJobPostById/{jobPostId}")
    public Map<String, Object> getJobPostById(@PathVariable Long jobPostId) throws Exception {
        Response response = jobPostService.getJobPostById(jobPostId);
        return response.jsonData();

    }


    @GetMapping("/getHrJobPosts/{hrId}")
    public List<JobPost> getHrJobPosts(@PathVariable Long hrId) {
        return jobPostService.getHrJobPosts(hrId);
    }
}
