package com.example.hirehustle.users.Applicant;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ApplicantRepository extends JpaRepository<Applicant, Long> {

    @Query("SELECT applicant FROM Applicant applicant WHERE applicant.email=?1")
    Optional<Applicant> findByEmail(String email);

    @Query("SELECT applicant FROM Applicant applicant WHERE applicant.username=?1")
    Optional<Applicant> findByUsername(String username);

    @Query("SELECT applicant FROM Applicant applicant WHERE applicant.email=?1")
    Applicant getByEmail(String email);

    @Query("SELECT applicant FROM Applicant applicant WHERE applicant.id=?1")
    Applicant getApplicantById(Long id);

    @Query("SELECT a FROM Applicant a WHERE a.username=?1 AND a.password=?2")
    Optional<Applicant> dataIsValid(String username, String password);

    @Query("SELECT applicant FROM Applicant applicant WHERE applicant.username=?1")
    Applicant getByUsername(String username);

}
