package com.example.hirehustle.users.Responses;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.HashMap;
import java.util.Map;


public class ResponseSuccess extends Response{

    private Object data;

    public ResponseSuccess(Object data) {
        this.data = data;
    }

    @Override
    public Map<String, Object> jsonData() {
        Map<String, Object> json = new HashMap<>();
        json.put("status", "success");
        json.put("data", data);
        return json;
    }

    public Object getData() {
        return data;
    }
}
