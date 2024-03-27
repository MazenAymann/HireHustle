package com.example.hirehustle.jobPosts;

import com.example.hirehustle.users.Applicant.Applicant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface JobPostRepository extends JpaRepository<JobPost, Long> {

//    @Query("SELECT jp FROM JobPost jp WHERE jp.jobPostState = :state")
//    List<JobPost> findByState(@Param("state") JobPostStates state);

    @Query("SELECT jp.id, jp.jobCategory, jp.jobTitle, jp.jobLocation, jp.jobDescription, jp.expirationPeriod, jp.workingHours, jp.jobRequirements, jp.salary, jp.overtime, jp.benefits, jp.additionalRequirements, jp.appliedNumber, jp.creationTime, jp.jobPostState FROM JobPost jp WHERE jp.jobPostState = :state")
    List<Object[]> findByState(@Param("state") JobPostStates state);

    @Query("SELECT j.applicants FROM JobPost j WHERE j.id = :jobPostId")
    Set<Applicant> findApplicantsByJobPostId(Long jobPostId);
}
