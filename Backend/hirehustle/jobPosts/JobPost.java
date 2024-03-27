package com.example.hirehustle.jobPosts;

import com.example.hirehustle.users.Applicant.Applicant;
import com.example.hirehustle.users.hr.HR;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
import java.util.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "job_posts")
public class JobPost {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private String jobCategory;
    @Column(nullable = false)
    private String jobTitle;
    @Column(nullable = false)
    private String jobLocation;
    @Column(
            nullable = false,
            length = 5000 // Maximum length of 5000 characters.
    )
    private String jobDescription;
    @Column(nullable = false)
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    private LocalDateTime expirationPeriod;
    @Column(nullable = false)
    private String workingHours;
    @Column(
            nullable = false,
            length = 5000
    )
    private String jobRequirements;
    private String salary;
    private String overtime;
    private String benefits;
    @Column(
            length = 2000
    )
    private String additionalRequirements;

    private int appliedNumber = 0;
    @Column(nullable = false)
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    private LocalDateTime creationTime;
    @Enumerated(EnumType.STRING)
    private JobPostStates jobPostState = JobPostStates.VALID;

    @ManyToMany
    @JoinTable(
            name = "apply",
            joinColumns = @JoinColumn(name = "job_post_id"),
            inverseJoinColumns = @JoinColumn(name = "applicant_id")
    )
    @JsonIgnoreProperties("jobPosts")
    private Set<Applicant> applicants = new HashSet<>();

    //many jobPost to one hr

    @ManyToOne
    @JoinColumn(
            name = "HrId"
    )
    private HR hr;

    public JobPost(Long id,
                   String jobCategory,
                   String jobTitle,
                   String jobLocation,
                   String jobDescription,
                   LocalDateTime expirationPeriod,
                   String workingHours,
                   String jobRequirements,
                   String salary,
                   String overtime,
                   String benefits,
                   String additionalRequirements,
                   int appliedNumber,
                   LocalDateTime creationTime,
                   JobPostStates jobPostState) {
        this.id = id;
        this.jobCategory = jobCategory;
        this.jobTitle = jobTitle;
        this.jobLocation = jobLocation;
        this.jobDescription = jobDescription;
        this.expirationPeriod = expirationPeriod;
        this.workingHours = workingHours;
        this.jobRequirements = jobRequirements;
        this.salary = salary;
        this.overtime = overtime;
        this.benefits = benefits;
        this.additionalRequirements = additionalRequirements;
        this.appliedNumber = appliedNumber;
        this.creationTime = creationTime;
        this.jobPostState = jobPostState;
    }

    public Map<String, Object> toMap(){
        Map<String, Object> jobPostMap = new HashMap<>();
        jobPostMap.put("id", getId());
        jobPostMap.put("jobCategory", getJobCategory());
        jobPostMap.put("jobTitle", getJobTitle());
        jobPostMap.put("jobLocation", getJobLocation());
        jobPostMap.put("jobDescription", getJobDescription());
        jobPostMap.put("expirationPeriod", getExpirationPeriod());
        jobPostMap.put("workingHours", getWorkingHours());
        jobPostMap.put("jobRequirements", getJobRequirements());
        jobPostMap.put("salary", getSalary());
        jobPostMap.put("overtime", getOvertime());
        jobPostMap.put("benefits", getBenefits());
        jobPostMap.put("additionalRequirements", getAdditionalRequirements());
        jobPostMap.put("appliedNumber", getAppliedNumber());
        jobPostMap.put("creationTime", getCreationTime());
        jobPostMap.put("hr", getHr());

        return jobPostMap;
    }



}
