package com.example.hirehustle.jobPosts;

import com.example.hirehustle.users.Applicant.Applicant;
import com.example.hirehustle.users.Applicant.ApplicantRepository;
import com.example.hirehustle.users.Responses.JobPosts.JobPostAdditionFailedResponse;
import com.example.hirehustle.users.Responses.JobPosts.JobPostAdditionResponse;
import com.example.hirehustle.users.Responses.JobPosts.JobPostAdditionSuccessResponse;
import com.example.hirehustle.users.Responses.Response;
import com.example.hirehustle.users.Responses.ResponseSuccess;
import com.example.hirehustle.users.hr.HR;
import com.example.hirehustle.users.hr.HRRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@RequiredArgsConstructor
@Service
public class JobPostService {

    private final JobPostRepository jobPostRepository;
    private final ApplicantRepository applicantRepository;
    private final HRRepository hrRepository;

    public JobPostAdditionResponse createJobPost(JobPost jobPost, Long hrId) {
        JobPostAdditionResponse response;
        try {
            HR hr = hrRepository.getHrById(hrId);
            System.out.println(hr.getEmail());
            jobPost.setCreationTime(LocalDateTime.now());
            hr.setJobPosts(jobPost);
            jobPost.setHr(hr);
            jobPostRepository.save(jobPost);
            response = new JobPostAdditionSuccessResponse(
                    "success",
                    "Job Post Created Successfully."
            );
            return response;
        } catch (Exception e) {
            response = new JobPostAdditionFailedResponse(
                    "failed",
                    "Sorry, Error occurred in storing the job post."
            );
            System.out.println(e.getMessage());
            return response;
        }
    }

    @Transactional
    public JobPostAdditionResponse fetchAllValidJobPosts() {
        JobPostAdditionResponse response;
        try {
            List<Object[]> jobPosts = jobPostRepository.findByState(JobPostStates.VALID);
            response = new JobPostAdditionSuccessResponse(
                    "success",
                    jsonJobPosts(jobPosts)
            );
            return response;
        }catch (Exception e){
            response = new JobPostAdditionFailedResponse(
                    "failed",
                    "Sorry, Error occurred fetching job posts."
            );
            System.out.println(e.getMessage());
            return response;
        }
    }

    public JobPost getJobPost(Long jobPostId){
        if (jobPostRepository.findById(jobPostId).isPresent())
            return jobPostRepository.findById(jobPostId).get();
        return null;
    }

    public void applyForJob(Long jobPostId, Long applicantId) throws Exception {
        JobPost jobPost = jobPostRepository.findById(jobPostId)
                .orElseThrow(() -> new Exception("Job post not found"));
        Applicant applicant = applicantRepository.findById(applicantId)
                .orElseThrow(() -> new Exception("Applicant not found"));

        jobPost.getApplicants().add(applicant);
        jobPostRepository.save(jobPost);
    }
    @Transactional
    public Response getApplicantsForJob(Long jobPostId) throws Exception {
        Set<Applicant> applicants = jobPostRepository.findApplicantsByJobPostId(jobPostId);
        return new ResponseSuccess(applicants);
    }

    public void editJobPost(JobPost jobPost,Long hrId) {
        HR hr = hrRepository.getHrById(hrId);
        jobPost.setHr(hr);
        if (jobPost.getBenefits() == null)
            jobPost.setBenefits("");
        if (jobPost.getSalary() == null)
            jobPost.setSalary("");
        if (jobPost.getAdditionalRequirements() == null)
            jobPost.setAdditionalRequirements("");
        if (jobPost.getOvertime() == null)
            jobPost.setAdditionalRequirements("");
        jobPostRepository.save(jobPost);
    }

    @Transactional
    public void deleteJobPost(Long jobPostId) throws Exception {
        JobPost jobPost = jobPostRepository.findById(jobPostId)
                .orElseThrow(() -> new Exception("There is no job post by this id."));
        deleteJobPostApplicants(jobPost);
        jobPostRepository.delete(jobPost);
    }

    @Transactional
    public void deleteJobPostApplicants(JobPost jobPost) {
        jobPost.setApplicants(null);
        jobPostRepository.save(jobPost);
    }

    List<Map<String, Object>> jsonJobPosts(List<Object[]> jobPosts){
        List<Map<String, Object>> jobPostList = new ArrayList<>();
        for (Object[] obj :
                jobPosts) {
            JobPost jobPost = new JobPost(
                    (Long) obj[0],
                    (String) obj[1],
                    (String) obj[2],
                    (String) obj[3],
                    (String) obj[4],
                    (LocalDateTime) obj[5],
                    (String) obj[6],
                    (String) obj[7],
                    (String) obj[8],
                    (String) obj[9],
                    (String) obj[10],
                    (String) obj[11],
                    (int) obj[12],
                    (LocalDateTime) obj[13],
                    (JobPostStates) obj[14]);
            jobPostList.add(jobPost.toMap());
        }
        return jobPostList;
    }

    public Response getJobPostById(Long jobPostId) throws Exception {
        JobPost jobPost = jobPostRepository.findById(jobPostId)
                .orElseThrow(() -> new Exception("There is no job post by this id."));
        return new ResponseSuccess(jobPost);
    }

    public List<JobPost> getAllJobPosts() {
        return jobPostRepository.findAll();
    }

    public List<JobPost> getHrJobPosts(Long hrId) {
        HR hr = hrRepository.getHrById(hrId);
        return hr.getJobPosts();
    }
}
