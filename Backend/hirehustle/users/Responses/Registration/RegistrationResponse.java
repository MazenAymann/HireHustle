package com.example.hirehustle.users.Responses.Registration;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Map;

@Data
@AllArgsConstructor
public abstract class RegistrationResponse {

    private String status;

    public abstract Map<String, Object> mapToArrangeGson();
}
