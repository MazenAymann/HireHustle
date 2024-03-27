package com.example.hirehustle.users.admin;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AdminRepository extends JpaRepository<Admin, Long> {

    @Query("SELECT admin FROM Admin admin WHERE admin.username=?1 AND admin.password=?2")
    Optional<Admin> dataIsValid(String username, String password);

    @Query("SELECT admin FROM Admin admin WHERE admin.username=?1")
    Optional<Object> adminIsExist(String username);
}
