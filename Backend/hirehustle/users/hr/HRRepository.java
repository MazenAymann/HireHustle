package com.example.hirehustle.users.hr;

import com.example.hirehustle.users.Applicant.Applicant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface HRRepository extends JpaRepository<HR, Long> {
    @Query("SELECT hr FROM HR hr WHERE hr.email=?1")
    Optional<HR> findByEmail(String email);

    @Query("SELECT hr FROM HR hr WHERE hr.username=?1")
    Optional<HR> findByUsername(String username);

    @Query("SELECT hr FROM HR hr WHERE hr.email=?1")
    HR getByEmail(String email);

    @Query("SELECT hr FROM HR hr WHERE hr.id=?1")
    HR getHrById(Long id);

    @Query("SELECT hr FROM HR hr WHERE hr.username=?1 AND hr.password=?2")
    Optional<Object> dataIsValid(String username, String password);

    @Query("SELECT hr FROM HR hr WHERE hr.username=?1")
    HR getByUsername(String username);
}
