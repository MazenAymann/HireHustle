package com.example.hirehustle.users.Responses.JobPosts;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Map;

@Data
@AllArgsConstructor
public abstract class JobPostAdditionResponse {

    private String status;

    public abstract Map<String, Object> mapToArrangeGson();
}
