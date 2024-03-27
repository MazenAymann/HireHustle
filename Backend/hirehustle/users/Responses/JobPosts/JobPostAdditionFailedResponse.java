package com.example.hirehustle.users.Responses.JobPosts;

import java.util.LinkedHashMap;
import java.util.Map;


public class JobPostAdditionFailedResponse extends JobPostAdditionResponse {

    private final String message;

    public JobPostAdditionFailedResponse(String status, String message) {
        super(status);
        this.message = message;
    }

    @Override
    public Map<String, Object> mapToArrangeGson(){
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("status", super.getStatus());
        map.put("message", message);
        return map;
    }

    public String getMessage() {
        return message;
    }
}
