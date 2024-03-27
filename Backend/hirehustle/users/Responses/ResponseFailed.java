package com.example.hirehustle.users.Responses;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.HashMap;
import java.util.Map;


public class ResponseFailed extends Response{

    private final String message;

    public ResponseFailed(String message) {
        this.message = message;
    }

    @Override
    public Map<String, Object> jsonData() {
        Map<String, Object> json = new HashMap<>();
        json.put("status", "failed");
        json.put("message", message);
        return json;
    }

    public String getMessage() {
        return message;
    }

}
