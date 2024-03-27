package com.example.hirehustle.users.admin;

import com.example.hirehustle.jobPosts.JobPost;
import com.example.hirehustle.jobPosts.JobPostService;
import com.example.hirehustle.users.Applicant.Applicant;
import com.example.hirehustle.users.Applicant.ApplicantRepository;
import com.example.hirehustle.users.Applicant.ApplicantService;
import com.example.hirehustle.users.Responses.JobPosts.JobPostAdditionResponse;
import com.example.hirehustle.users.hr.HR;
import com.example.hirehustle.users.hr.HRService;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/admin")
@RequiredArgsConstructor
@CrossOrigin("*")
public class AdminController {

    private final ApplicantService applicantService;
    private final HRService hrService;
    private final AdminService adminService;
    private final JobPostService jobPostService;
    private final Gson gson = new Gson();

    @PostMapping("/addAdmin")
    public String addAdmin(@RequestBody Admin admin){
        return adminService.addAdmin(admin);
    }

    @PostMapping("/adminLogin")
    public String adminLogin(@RequestBody Admin admin){
        return adminService.adminLogin(admin);
    }

    @GetMapping("/allValidJobPosts")
    public Map<String, Object> getAllValidJobPosts(){
        JobPostAdditionResponse response = jobPostService.fetchAllValidJobPosts();
        return response.mapToArrangeGson();
    }

    @PostMapping("/disableApplicant/{applicantId}")
    public void disableApplicant(@PathVariable Long applicantId){
        applicantService.disableApplicant(applicantId);
    }

    @PostMapping("/enableApplicant/{applicantId}")
    public void enableApplicant(@PathVariable Long applicantId){
        applicantService.enableApplicant(applicantId);
    }

    @PostMapping("/disableHr/{hrId}")
    public void disableHr(@PathVariable Long hrId){
        hrService.disableHr(hrId);
    }

    @PostMapping("/enableHr/{hrId}")
    public void enableHr(@PathVariable Long hrId){
        hrService.enableHr(hrId);
    }

    @GetMapping("/getAllApplicants")
    public List<Applicant> getAllApplicants(){
        return applicantService.getAllApplicants();
    }

    @GetMapping("/getAllHrs")
    public List<HR> getAllHrs(){
        return hrService.getAllHRs();
    }

    @GetMapping("/getAllJobPosts")
    public List<JobPost> getAllJobPosts(){
        return jobPostService.getAllJobPosts();
    }

    @PostMapping("/inActiveHr/{hrId}")
    public void inActiveHr(@PathVariable Long hrId){
        hrService.inActiveHr(hrId);
    }

    @PostMapping("/activeHr/{hrId}")
    public void activeHr(@PathVariable Long hrId){
        hrService.activeHr(hrId);
    }

    @PostMapping("/inActiveApplicant/{applicantId}")
    public void inActiveApplicant(@PathVariable Long applicantId){
        applicantService.inActiveApplicant(applicantId);
    }

    @PostMapping("/activeApplicant/{applicantId}")
    public void activeApplicant(@PathVariable Long applicantId){
        applicantService.activeApplicant(applicantId);
    }

}
