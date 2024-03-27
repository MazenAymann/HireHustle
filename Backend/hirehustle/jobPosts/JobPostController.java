package com.example.hirehustle.jobPosts;

import com.example.hirehustle.users.Responses.JobPosts.JobPostAdditionResponse;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@RequestMapping("/api/v1/jobPosts")
@Controller
@CrossOrigin("*")
public class JobPostController {

    private final JobPostService jobPostService;


//    @GetMapping("/allValidJobPosts")
//    public Map<String, Object> getAllValidJobPosts(){
//        JobPostAdditionResponse response = jobPostService.fetchAllValidJobPosts();
//        return response.mapToArrangeGson();
//    }





}
