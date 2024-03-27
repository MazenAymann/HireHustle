package com.example.hirehustle.users.Responses;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

import java.util.Map;

@Data
@AllArgsConstructor
public abstract class Response {
    public abstract Map<String, Object> jsonData();
}
