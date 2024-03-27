package com.example.hirehustle.users.Responses.Login;

import com.example.hirehustle.users.Applicant.Applicant;
import com.example.hirehustle.users.hr.HR;

import java.util.LinkedHashMap;
import java.util.Map;

public class LoginSuccessResponse extends LoginResponse{

    private final Map<String, Object> data;
    private final HR hr;
    private final Applicant applicant;

    public LoginSuccessResponse(String status, Map<String, Object> data, HR hr, Applicant applicant) {
        super(status);
        this.data = data;
        this.hr = hr;
        this.applicant = applicant;
    }

    @Override
    public Map<String, Object> mapToArrangeGson(){
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("status", super.getStatus());
        if (this.applicant == null)
            this.data.put("hr", this.hr.toMap());
        else
            this.data.put("applicant", this.applicant.toMap());
        map.put("data", data);
        return map;
    }

}
