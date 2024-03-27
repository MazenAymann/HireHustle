package com.example.hirehustle.users.hr;

import com.example.hirehustle.jobPosts.JobPost;
import com.example.hirehustle.token.Token;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.*;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class HR {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String profileImage;
    private String firstName;
    private String lastName;
    private String mobileNumber;
    private String nationalId;
    private String addressLine;
    private String username;
    private String password;
    private String email;
    private boolean isActivated = false;
    private boolean isEnabled = true;
    private int age;

    @JsonIgnoreProperties("hr")
    @OneToMany(mappedBy = "hr", cascade = CascadeType.ALL)
    List<Token> tokens = new ArrayList<>();

    @JsonIgnoreProperties("hr")
    @OneToMany(mappedBy = "hr", cascade = CascadeType.ALL)
    List<JobPost> jobPosts;

    public HR(
            String firstName,
            String lastName,
            String mobileNumber,
            String nationalId,
            String addressLine,
            String username,
            String password,
            String email,
            int age) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.mobileNumber = mobileNumber;
        this.nationalId = nationalId;
        this.addressLine = addressLine;
        this.age = age;
        this.email = email;
        this.username = username;
        this.password = password;
    }

    public void setTokens(Token token) {
        tokens.add(token);
    }

    public Map<String, Object> toMap(){
        Map<String, Object> hrMap = new HashMap<>();
        hrMap.put("id", getId());
        hrMap.put("profileImage", getProfileImage());
        hrMap.put("firstName", getFirstName());
        hrMap.put("lastName", getLastName());
        hrMap.put("mobileNumber", getMobileNumber());
        hrMap.put("nationalId", getNationalId());
        hrMap.put("addressLine", getAddressLine());
        hrMap.put("age", getAge());
        hrMap.put("email", getEmail());
        hrMap.put("username", getUsername());
        hrMap.put("password", getPassword());

        return hrMap;
    }

    public void setJobPosts(JobPost jobPost) {
        this.jobPosts.add(jobPost);
    }
}
