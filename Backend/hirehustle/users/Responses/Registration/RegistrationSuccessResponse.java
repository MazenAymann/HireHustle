package com.example.hirehustle.users.Responses.Registration;

import java.util.LinkedHashMap;
import java.util.Map;

public class RegistrationSuccessResponse extends RegistrationResponse {

    private final String data;

    public RegistrationSuccessResponse(String status, String data) {
        super(status);
        this.data = data;
    }

    @Override
    public Map<String, Object> mapToArrangeGson(){
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("status", super.getStatus());
        map.put("data", data);
        return map;
    }

    public String getData() {
        return data;
    }
}
