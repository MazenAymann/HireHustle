package com.example.hirehustle.users.Responses.Login;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Map;

@Data
@AllArgsConstructor
public abstract class LoginResponse {

    private String status;

    public abstract Map<String, Object> mapToArrangeGson();
}
