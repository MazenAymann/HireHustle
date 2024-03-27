package com.example.hirehustle.users.Applicant;

import com.example.hirehustle.jobPosts.JobPost;
import com.example.hirehustle.token.Token;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.*;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Table(name = "applicants")
public class Applicant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String profileImage;
    private String cvPlaceholder;
    private String firstName;
    private String lastName;
    private String mobileNumber;
    private String email;
    private String nationalId;
    private String addressLine;
    private String username;
    private String password;
    private String residencePlace;
    private boolean isActivated = false;
    private boolean isEnabled = true;
    private int age;


    @ManyToMany(mappedBy = "applicants", cascade = CascadeType.ALL)
    private Set<JobPost> jobPosts = new HashSet<>();

    @OneToMany(mappedBy = "applicant", cascade = CascadeType.ALL)
    List<Token> tokens = new ArrayList<>();

    public Applicant(String firstName,
                     String lastName,
                     String mobileNumber,
                     String nationalId,
                     String addressLine,
                     String username,
                     String password,
                     String residencePlace,
                     String email,
                     int age) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.mobileNumber = mobileNumber;
        this.nationalId = nationalId;
        this.addressLine = addressLine;
        this.username = username;
        this.password = password;
        this.residencePlace = residencePlace;
        this.email = email;
        this.age = age;
    }

    public void setTokens(Token token) {
        tokens.add(token);
    }

    public Map<String, Object> toMap(){
        Map<String, Object> applicantMap = new HashMap<>();
        applicantMap.put("profileImage", getProfileImage());
        applicantMap.put("cvPlaceholder", getCvPlaceholder());
        applicantMap.put("id", getId());
        applicantMap.put("firstName", getFirstName());
        applicantMap.put("lastName", getLastName());
        applicantMap.put("mobileNumber", getMobileNumber());
        applicantMap.put("email", getEmail());
        applicantMap.put("nationalId", getNationalId());
        applicantMap.put("addressLine", getAddressLine());
        applicantMap.put("username", getUsername());
        applicantMap.put("password", getPassword());
        applicantMap.put("residencePlace", getResidencePlace());
        applicantMap.put("age", getAge());

        return applicantMap;
    }

}
