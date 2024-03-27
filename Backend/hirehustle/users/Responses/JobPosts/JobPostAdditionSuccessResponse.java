package com.example.hirehustle.users.Responses.JobPosts;

import com.example.hirehustle.jobPosts.JobPost;
import lombok.AllArgsConstructor;

import java.util.LinkedHashMap;
import java.util.Map;


public class JobPostAdditionSuccessResponse extends JobPostAdditionResponse {

    private final Object data;
//    private final JobPost jobPost;

    public JobPostAdditionSuccessResponse(String status, Object data) {
        super(status);
        this.data = data;
        System.out.println(data);
//        this.jobPost = jobPost;
    }

    @Override
    public Map<String, Object> mapToArrangeGson(){
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("status", super.getStatus());
        map.put("data", data);
        return map;
    }

    public Object getData() {
        return data;
    }
}
